Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33B060490B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiJSOT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiJSOTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:19:23 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5452011702A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:02:48 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JDWDC9021218;
        Wed, 19 Oct 2022 14:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=IoPDvBRIJspiL5VXnRfID6LEYNIpLUXxfJ62lVwmdL8=;
 b=Aa3KlIgEBybBYPpWSaw/9KTZOLlDEMMKY5TTCyVSMfL8WvyHp/RI1ILK9UtMjJ0KDTIe
 3/9cJs3aCWYJPZI2E20B8dY+XRgaDl01Tp+Bt+ZkxsI9ts8woYUUPEepeQJF6HOVMMwY
 /phouhVJtvoAt0Fh3Mg0EPa+pjxA3l1n8xazAyh1k/7im/H4H4cgEIugST7VHMRKiVpV
 9G1dDU0QDC7XeuScVQfz8agRU+z+vyjwQ28dMRgPMEsrsMGR0bNewRPCvnuSL4x1TtHr
 2cHWH8VdDILsxCVsrAMMfWhQzpcSW3+8Cvz0QpulnDAbN85VDw02Y5PG/sqz/aeMM4Qx dA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kah2sruhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 14:00:49 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id B0F5680471E;
        Wed, 19 Oct 2022 14:00:48 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 228F3802BA4;
        Wed, 19 Oct 2022 14:00:45 +0000 (UTC)
Date:   Wed, 19 Oct 2022 09:00:43 -0500
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     gregkh@linuxfoundation.org, zhengyejian1@huawei.com,
        dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        alex000young@gmail.com, security@kernel.org
Subject: Re: [PATCH v4] misc: sgi-gru: fix use-after-free error in
  gru_set_context_option, gru_fault and gru_handle_user_call_os
Message-ID: <20221019140043.GD18792@hpe.com>
References: <20221019031445.901570-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019031445.901570-1-zyytlz.wz@163.com>
X-Proofpoint-GUID: rXkQs5R-GlMN_SV7xQZNuuq2LnEmJygG
X-Proofpoint-ORIG-GUID: rXkQs5R-GlMN_SV7xQZNuuq2LnEmJygG
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_08,2022-10-19_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190078
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 11:14:45AM +0800, Zheng Wang wrote:
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
> v4:
> - use VM_FAULT_NOPAGE as failure code in gru_fault and -EINVAL in other functions suggested by Yejian
> 
> v3:
> - add preempt_enable and use VM_FAULT_NOPAGE as failure code suggested by Yejian
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
> index d7ef61e602ed..2b5b049fbd38 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -656,7 +656,9 @@ int gru_handle_user_call_os(unsigned long cb)
>  	if (ucbnum >= gts->ts_cbr_au_count * GRU_CBR_AU_SIZE)
>  		goto exit;
>  
> -	gru_check_context_placement(gts);
> +	ret = gru_check_context_placement(gts);
> +	if (ret)
> +		goto err;
>  
>  	/*
>  	 * CCH may contain stale data if ts_force_cch_reload is set.
> @@ -677,6 +679,10 @@ int gru_handle_user_call_os(unsigned long cb)
>  exit:
>  	gru_unlock_gts(gts);
>  	return ret;
> +err:
> +	gru_unlock_gts(gts);
> +	gru_unload_context(gts, 1);
> +	return -EINVAL;
>  }
>  
>  /*
> @@ -874,7 +880,7 @@ int gru_set_context_option(unsigned long arg)
>  		} else {
>  			gts->ts_user_blade_id = req.val1;
>  			gts->ts_user_chiplet_id = req.val0;
> -			gru_check_context_placement(gts);
> +			ret = gru_check_context_placement(gts);

In gru_set_context_option(), you are calling gru_unload_context() for all
non-zero 'ret' values, but there are other instances where non-zero 'ret'
values are being set that should not call gru_unload_context().  Maybe do
this instead:
			if (gru_check_context_placement(gts)) {
				gru_unlock_gts(gts);
				gru_unload_context(gts, 1);
				return -EINVAL;
			}

>  		}
>  		break;
>  	case sco_gseg_owner:
> @@ -889,6 +895,10 @@ int gru_set_context_option(unsigned long arg)
>  		ret = -EINVAL;
>  	}
>  	gru_unlock_gts(gts);
> +	if (ret) {
> +		gru_unload_context(gts, 1);
> +		ret = -EINVAL;
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
> index 9afda47efbf2..77becb52f550 100644
> --- a/drivers/misc/sgi-gru/grumain.c
> +++ b/drivers/misc/sgi-gru/grumain.c
> @@ -716,9 +716,10 @@ static int gru_check_chiplet_assignment(struct gru_state *gru,
>   * chiplet. Misassignment can occur if the process migrates to a different
>   * blade or if the user changes the selected blade/chiplet.
>   */
> -void gru_check_context_placement(struct gru_thread_state *gts)
> +int gru_check_context_placement(struct gru_thread_state *gts)
>  {
>  	struct gru_state *gru;
> +	int ret = 0;
>  
>  	/*
>  	 * If the current task is the context owner, verify that the
> @@ -727,14 +728,16 @@ void gru_check_context_placement(struct gru_thread_state *gts)
>  	 */
>  	gru = gts->ts_gru;
>  	if (!gru || gts->ts_tgid_owner != current->tgid)
> -		return;
> +		return ret;
>  
>  	if (!gru_check_chiplet_assignment(gru, gts)) {
>  		STAT(check_context_unload);
> -		gru_unload_context(gts, 1);
> +		ret = -EINVAL;
>  	} else if (gru_retarget_intr(gts)) {
>  		STAT(check_context_retarget_intr);
>  	}
> +
> +	return ret;
>  }
>  
>  
> @@ -919,6 +922,7 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
>  	struct gru_thread_state *gts;
>  	unsigned long paddr, vaddr;
>  	unsigned long expires;
> +	int ret;
>  
>  	vaddr = vmf->address;
>  	gru_dbg(grudev, "vma %p, vaddr 0x%lx (0x%lx)\n",
> @@ -934,7 +938,13 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
>  	mutex_lock(&gts->ts_ctxlock);
>  	preempt_disable();
>  
> -	gru_check_context_placement(gts);
> +	ret = gru_check_context_placement(gts);
> +	if (ret) {

One suggestion, there is now no need to declare 'ret'.  Do this instead:
        if (gru_check_context_placement(gts)) {

> +		preempt_enable();
> +		mutex_unlock(&gts->ts_ctxlock);
> +		gru_unload_context(gts, 1);
> +		return VM_FAULT_NOPAGE;
> +	}
>  
>  	if (!gts->ts_gru) {
>  		STAT(load_user_context);
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
