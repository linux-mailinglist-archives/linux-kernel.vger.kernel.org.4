Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA2562369E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 23:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiKIWdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 17:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiKIWd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 17:33:29 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2442FCF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 14:33:27 -0800 (PST)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9LiejI008946;
        Wed, 9 Nov 2022 22:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=JxKPgmzVSEbxlvigJPVo7CanmHSm07zzY5OI2+Z6bRM=;
 b=CFC++j5ePpBmiU+D4gEbLPBM9uy0UAN6qDRx5No2Z/yomjA38gm0TujUdnNfmTk+8Hby
 +vsLG0esZqZuIW239d/kv4zofZqloo/eN4W61dDxkLiSh6yrYllNAL4fLmZJUmle9p2X
 p6kk46NcOLJFeRYwhsDd5HY2JnhZZiWt2IiyO20p7oGlAwR1ivTxafsOnuCNHVU9K3Wt
 3BRFkoDx/H7KHuQlMA6LxUXxA+bE8zlOfaXPv7FHWyXUjaBpA5Shhy1+mKx13I2e1p9i
 aJU7/ERFKW/zWFuMOdekJ4mkeDWSxBphhG7+kHYaeY980ePq+COqPY0/E9/Vy4of6iaB WA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3krmcxre80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 22:33:02 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 807E6806B6A;
        Wed,  9 Nov 2022 22:33:01 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 683F1805ADA;
        Wed,  9 Nov 2022 22:32:59 +0000 (UTC)
Date:   Wed, 9 Nov 2022 16:32:57 -0600
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     gregkh@linuxfoundation.org, zhengyejian1@huawei.com,
        dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        alex000young@gmail.com, security@kernel.org, lkp@intel.com
Subject: Re: [PATCH v9] misc: sgi-gru: fix use-after-free error in
  gru_set_context_option, gru_fault and gru_handle_user_call_os
Message-ID: <20221109223257.GB34247@hpe.com>
References: <20221109141701.237407-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109141701.237407-1-zyytlz.wz@163.com>
X-Proofpoint-GUID: vxClIitucthVN34Yc-PR6wcWnF3VZ0K5
X-Proofpoint-ORIG-GUID: vxClIitucthVN34Yc-PR6wcWnF3VZ0K5
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090169
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 10:17:01PM +0800, Zheng Wang wrote:
> In some bad situation, the gts may be freed gru_check_chiplet_assignment.
> The call chain can be gru_unload_context->gru_free_gru_context->gts_drop
> and kfree finally. However, the caller didn't know if the gts is freed
> or not and use it afterwards. This will trigger a Use after Free bug.
> 
> Fix it by introducing a return value to see if it's in error path or not.
> Free the gts in caller if gru_check_chiplet_assignment check failed.
> 
> Fixes: 55484c45dbec ("gru: allow users to specify gru chiplet 2")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Acked-by: Dimitri Sivanich <sivanich@hpe.com>
> ---
> v9:
> - rewrite changelog and add comment in the code to make it more clear
> 
> v8:
> - remove tested-by tag suggested by Greg
> 
> v7:
> - fix some spelling problems suggested by Greg, change kernel test robot from reported-by tag to tested-by tag
> 
> v6:
> - remove unused var checked by kernel test robot
> 
> v5:
> - fix logical issue and remove unnecessary variable suggested by Dimitri Sivanich
> 
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
>  drivers/misc/sgi-gru/grumain.c   | 22 ++++++++++++++++++----
>  drivers/misc/sgi-gru/grutables.h |  2 +-
>  3 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
> index d7ef61e602ed..bdd515d33225 100644
> --- a/drivers/misc/sgi-gru/grufault.c
> +++ b/drivers/misc/sgi-gru/grufault.c
> @@ -656,7 +656,9 @@ int gru_handle_user_call_os(unsigned long cb)
>  	if (ucbnum >= gts->ts_cbr_au_count * GRU_CBR_AU_SIZE)
>  		goto exit;
>  
> -	gru_check_context_placement(gts);
> +	ret = gru_check_context_placement(gts);

Below we do not want to skip over the rest of the logic in either return case.
You will have to do the gru_find_lock_gts again after unloading the gru context,
then check the gts value, then return EINVAL if not set (same as earlier in the
function).

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
> @@ -874,7 +880,11 @@ int gru_set_context_option(unsigned long arg)
>  		} else {
>  			gts->ts_user_blade_id = req.val1;
>  			gts->ts_user_chiplet_id = req.val0;
> -			gru_check_context_placement(gts);
> +			if (gru_check_context_placement(gts)) {
> +				gru_unlock_gts(gts);
> +				gru_unload_context(gts, 1);

Looking at this again, I think we should return 0, as we originally would 
have done in this case anyway.

> +				return -EINVAL;
> +			}
>  		}
>  		break;
>  	case sco_gseg_owner:
> diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
> index 6706ef3c5977..816def778078 100644
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
> @@ -726,15 +727,23 @@ void gru_check_context_placement(struct gru_thread_state *gts)
>  	 * references. Pthread apps use non-owner references to the CBRs.
>  	 */
>  	gru = gts->ts_gru;
> +	/*
> +	 * If gru or gts->ts_tgid_owner isn't initialized properly, return
> +	 * success is fine, for it's not a deadly error. The related variable
> +	 * can be reconfigure in other function.The caller is responsible
> +	 * for their inspection, and reinitialization if needed.
> +	 */

How about this instead?
  "If gru or gts->ts_tgid_owner isn't initialized properly, return
   success to indicate that the caller does not need to unload the gru
   context.  The caller is responsible for their inspection and
   reinitialization if needed."

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
> @@ -934,7 +943,12 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
>  	mutex_lock(&gts->ts_ctxlock);
>  	preempt_disable();
>  
> -	gru_check_context_placement(gts);
> +	if (gru_check_context_placement(gts)) {
> +		preempt_enable();
> +		mutex_unlock(&gts->ts_ctxlock);
> +		gru_unload_context(gts, 1);
> +		return VM_FAULT_NOPAGE;
> +	}
>  
>  	if (!gts->ts_gru) {
>  		STAT(load_user_context);
> diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
> index 8c52776db234..640daf1994df 100644
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
