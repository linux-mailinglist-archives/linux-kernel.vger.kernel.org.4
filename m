Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F696037B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 03:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJSB4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 21:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJSB4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 21:56:34 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1FBA3443
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 18:56:32 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MsYg35f1DzJn3t;
        Wed, 19 Oct 2022 09:53:51 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 09:56:30 +0800
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 09:56:30 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <zyytlz.wz@163.com>
CC:     <alex000young@gmail.com>, <arnd@arndb.de>,
        <dimitri.sivanich@hpe.com>, <gregkh@linuxfoundation.org>,
        <hackerzheng666@gmail.com>, <linux-kernel@vger.kernel.org>,
        <security@kernel.org>
Subject: Re: [PATCH v3] misc: sgi-gru: fix use-after-free error in  gru_set_context_option, gru_fault and gru_handle_user_call_os
Date:   Wed, 19 Oct 2022 09:55:56 +0000
Message-ID: <20221019095556.3465031-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221018165259.693958-1-zyytlz.wz@163.com>
References: <20221018165259.693958-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022 00:52:59 +0800, Zheng Wang <zyytlz.wz@163.com> wrote:
> Gts may be freed in gru_check_chiplet_assignment.
> The caller still use it after that, UAF happens.
>
> Fix it by introducing a return value to see if it's in error path or not.
> Free the gts in caller if gru_check_chiplet_assignment check failed.
>
> Fixes: 55484c45dbec ("gru: allow users to specify gru chiplet 2")
> Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
> v3:
> - add preempt_enable and use VM_FAULT_NOPAGE as failure code by Yejian

Sorry, maybe I didn't make it clearly enough in
https://lore.kernel.org/lkml/20221009201418.509417-1-zhengyejian1@huawei.com/

What I suggested was that return value of gru_fault() should be some VM_FAULT_XXX,
because this return value would be specially handled in pagefault flow like:
    __do_fault() {
        ......
        ret = vma->vm_ops->fault(vmf);
        ......
    }

But in other functions that are not in pagefault flow, common error code
like -EINVAL is ok. Meanings of every error code can be found in:
https://man7.org/linux/man-pages/man3/errno.3.html

By the way, these are all personal suggestions. You need Reviewed-by Maintainer :)

-- Zheng Yejian

>
> v2:
> - commit message changes suggested by Greg
>
> v1: https://lore.kernel.org/lkml/CAJedcCzY72jqgF-pCPtx66vXXwdPn-KMagZnqrxcpWw1NxTLaA@mail.gmail.com/
> ---
>  drivers/misc/sgi-gru/grufault.c  | 14 ++++++++++++--
>  drivers/misc/sgi-gru/grumain.c   | 18 ++++++++++++++----
>  drivers/misc/sgi-gru/grutables.h |  2 +-
>  3 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> index d7ef61e602ed..864be8a2cb61 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -656,7 +656,9 @@ int gru_handle_user_call_os(unsigned long cb)
> 	if (ucbnum >= gts->ts_cbr_au_count * GRU_CBR_AU_SIZE)
> 		goto exit;
>
> -	gru_check_context_placement(gts);
> +	ret = gru_check_context_placement(gts);
> +	if (ret)
> +		goto err;
>
> 	/*
> 	 * CCH may contain stale data if ts_force_cch_reload is set.
> @@ -677,6 +679,10 @@ int gru_handle_user_call_os(unsigned long cb)
>  exit:
> 	gru_unlock_gts(gts);
> 	return ret;
> +err:
> +	gru_unlock_gts(gts);
> +	gru_unload_context(gts, 1);
> +	return VM_FAULT_NOPAGE;
>  }
>
>  /*
> @@ -874,7 +880,7 @@ int gru_set_context_option(unsigned long arg)
> 		} else {
> 			gts->ts_user_blade_id = req.val1;
> 			gts->ts_user_chiplet_id = req.val0;
> -			gru_check_context_placement(gts);
> +			ret = gru_check_context_placement(gts);
> 		}
> 		break;
> 	case sco_gseg_owner:
> @@ -889,6 +895,10 @@ int gru_set_context_option(unsigned long arg)
> 		ret = -EINVAL;
> 	}
> 	gru_unlock_gts(gts);
> +	if (ret) {
> +		gru_unload_context(gts, 1);
> +		ret = VM_FAULT_NOPAGE;
> +	}
>
> 	return ret;
>  }
> diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
> index 9afda47efbf2..952803790818 100644
> --- a/drivers/misc/sgi-gru/grumain.c
> +++ b/drivers/misc/sgi-gru/grumain.c
> @@ -716,9 +716,10 @@ static int gru_check_chiplet_assignment(struct gru_state *gru,
>   * chiplet. Misassignment can occur if the process migrates to a different
>   * blade or if the user changes the selected blade/chiplet.
>   */
> -void gru_check_context_placement(struct gru_thread_state *gts)
> +int gru_check_context_placement(struct gru_thread_state *gts)
>  {
> 	struct gru_state *gru;
> +	int ret = 0;
>
> 	/*
> 	 * If the current task is the context owner, verify that the
> @@ -727,14 +728,16 @@ void gru_check_context_placement(struct gru_thread_state *gts)
> 	 */
> 	gru = gts->ts_gru;
> 	if (!gru || gts->ts_tgid_owner != current->tgid)
> -		return;
> +		return ret;
>
> 	if (!gru_check_chiplet_assignment(gru, gts)) {
> 		STAT(check_context_unload);
> -		gru_unload_context(gts, 1);
> +		ret = VM_FAULT_NOPAGE;
> 	} else if (gru_retarget_intr(gts)) {
> 		STAT(check_context_retarget_intr);
> 	}
> +
> +	return ret;
>  }
>
>
> @@ -919,6 +922,7 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
> 	struct gru_thread_state *gts;
> 	unsigned long paddr, vaddr;
> 	unsigned long expires;
> +	int ret;
>
> 	vaddr = vmf->address;
> 	gru_dbg(grudev, "vma %p, vaddr 0x%lx (0x%lx)\n",
> @@ -934,7 +938,13 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
> 	mutex_lock(&gts->ts_ctxlock);
> 	preempt_disable();
>
> -	gru_check_context_placement(gts);
> +	ret = gru_check_context_placement(gts);
> +	if (ret) {
> +		preempt_enable();
> +		mutex_unlock(&gts->ts_ctxlock);
> +		gru_unload_context(gts, 1);
> +		return ret;
> +	}
>
> 	if (!gts->ts_gru) {
> 		STAT(load_user_context);
> diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
> index 5efc869fe59a..f4a5a787685f 100644
> --- a/drivers/misc/sgi-gru/grutables.h
> +++ b/drivers/misc/sgi-gru/grutables.h
> @@ -632,7 +632,7 @@ extern int gru_user_flush_tlb(unsigned long arg);
>  extern int gru_user_unload_context(unsigned long arg);
>  extern int gru_get_exception_detail(unsigned long arg);
>  extern int gru_set_context_option(unsigned long address);
> -extern void gru_check_context_placement(struct gru_thread_state *gts);
> +extern int gru_check_context_placement(struct gru_thread_state *gts);
>  extern int gru_cpu_fault_map_id(void);
>  extern struct vm_area_struct *gru_find_vma(unsigned long vaddr);
>  extern void gru_flush_all_tlb(struct gru_state *gru);
> --
> 2.25.1
