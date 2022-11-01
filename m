Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA366142C5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 02:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKAB1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 21:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKAB12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 21:27:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3709167DA;
        Mon, 31 Oct 2022 18:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3C775CE1919;
        Tue,  1 Nov 2022 01:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01FCC433B5;
        Tue,  1 Nov 2022 01:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667266044;
        bh=PS1as+ceSEXBGHbOqVQdndDC8+DR17xtfU44SRYRlFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hMGgzfYiCH502VeSJ9PCjWIO5p6Cw6JngKeVG3Tz3UPL+7UqG0NH9eAXfejv9bmpC
         pUwBTtlPnOL7IVQaqffg+ObRP+9x62BL2v7t80r2sgMltSFkvnx5VKNEDRvdQJj/Mb
         d3uVrK4eTThoCP8BnUlKMhupJtq/OqsaeOhuwulb7TGL7hBth2snqswwI9bD8OWN1a
         MVF7dGGTeCo+nHqO9TtLKVRuJCr7pz7CqQ4S/jEPdop6IPQyGdrSB8ZD5QeYRlUJJN
         SvEcBxGWIIAZP5EljDcjl+CYC1iyXtR6CGjxHAFIwjBF1vH4lbANibBDbldolh6b/M
         W4IfdOWvyJ9eg==
Date:   Tue, 1 Nov 2022 03:27:20 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, md.iqbal.hossain@intel.com,
        haitao.huang@intel.com, linux-sgx@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] x86/sgx: Reduce delay and interference of enclave
 release
Message-ID: <Y2B1+NM2ONHGPgwj@kernel.org>
References: <00efa80dd9e35dc85753e1c5edb0344ac07bb1f0.1667236485.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00efa80dd9e35dc85753e1c5edb0344ac07bb1f0.1667236485.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:29:58AM -0700, Reinette Chatre wrote:
> commit 8795359e35bc ("x86/sgx: Silence softlockup detection when
> releasing large enclaves") introduced a cond_resched() during enclave
> release where the EREMOVE instruction is applied to every 4k enclave
> page. Giving other tasks an opportunity to run while tearing down a
> large enclave placates the soft lockup detector but Iqbal found
> that the fix causes a 25% performance degradation of a workload
> run using Gramine.
> 
> Gramine maintains a 1:1 mapping between processes and SGX enclaves.
> That means if a workload in an enclave creates a subprocess then
> Gramine creates a duplicate enclave for that subprocess to run in.
> The consequence is that the release of the enclave used to run
> the subprocess can impact the performance of the workload that is
> run in the original enclave, especially in large enclaves when
> SGX2 is not in use.
> 
> The workload run by Iqbal behaves as follows:
> Create enclave (enclave "A")
> /* Initialize workload in enclave "A" */
> Create enclave (enclave "B")
> /* Run subprocess in enclave "B" and send result to enclave "A" */
> Release enclave (enclave "B")
> /* Run workload in enclave "A" */
> Release enclave (enclave "A")
> 
> The performance impact of releasing enclave "B" in the above scenario
> is amplified when there is a lot of SGX memory and the enclave size
> matches the SGX memory. When there is 128GB SGX memory and an enclave
> size of 128GB, from the time enclave "B" starts the 128GB SGX memory
> is oversubscribed with a combined demand for 256GB from the two
> enclaves.
> 
> Before commit 8795359e35bc ("x86/sgx: Silence softlockup detection when
> releasing large enclaves") enclave release was done in a tight loop
> without giving other tasks a chance to run. Even though the system
> experienced soft lockups the workload (run in enclave "A") obtained
> good performance numbers because when the workload started running
> there was no interference.
> 
> Commit 8795359e35bc ("x86/sgx: Silence softlockup detection when
> releasing large enclaves") gave other tasks opportunity to run while an
> enclave is released. The impact of this in this scenario is that while
> enclave "B" is released and needing to access each page that belongs
> to it in order to run the SGX EREMOVE instruction on it, enclave "A"
> is attempting to run the workload needing to access the enclave
> pages that belong to it. This causes a lot of swapping due to the
> demand for the oversubscribed SGX memory. Longer latencies are
> experienced by the workload in enclave "A" while enclave "B" is
> released.
> 
> Improve the performance of enclave release while still avoiding the
> soft lockup detector with two enhancements:
> - Only call cond_resched() after XA_CHECK_SCHED iterations.
> - Use the xarray advanced API to keep the xarray locked for
>   XA_CHECK_SCHED iterations instead of locking and unlocking
>   at every iteration.
> 
> This batching solution is copied from sgx_encl_may_map() that
> also iterates through all enclave pages using this technique.
> 
> With this enhancement the workload experiences a 5%
> performance degradation when compared to a kernel without
> commit 8795359e35bc ("x86/sgx: Silence softlockup detection when
> releasing large enclaves"), an improvement to the reported 25%
> degradation, while still placating the soft lockup detector.
> 
> Scenarios with poor performance are still possible even with these
> enhancements. For example, short workloads creating sub processes
> while running in large enclaves. Further performance improvements
> are pursued in user space through avoiding to create duplicate enclaves
> for certain sub processes, and using SGX2 that will do lazy allocation
> of pages as needed so enclaves created for sub processes start quickly
> and release quickly.
> 
> Fixes: 8795359e35bc ("x86/sgx: Silence softlockup detection when releasing large enclaves")
> Reported-by: Md Iqbal Hossain <md.iqbal.hossain@intel.com>
> Tested-by: Md Iqbal Hossain <md.iqbal.hossain@intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> I do not know if this qualifies as stable material.
> 
> Changes since V1:
> - V1: https://lore.kernel.org/lkml/06a5f478d3bfaa57954954c82dd5d4040450171d.1666130846.git.reinette.chatre@intel.com/
> - Use local variable for max index instead of open code in loop. (Jarkko)
> - Send to broader X86 audience.
> 
>  arch/x86/kernel/cpu/sgx/encl.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 1ec20807de1e..2c258255a629 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -680,11 +680,15 @@ const struct vm_operations_struct sgx_vm_ops = {
>  void sgx_encl_release(struct kref *ref)
>  {
>  	struct sgx_encl *encl = container_of(ref, struct sgx_encl, refcount);
> +	unsigned long max_page_index = PFN_DOWN(encl->base + encl->size - 1);
>  	struct sgx_va_page *va_page;
>  	struct sgx_encl_page *entry;
> -	unsigned long index;
> +	unsigned long count = 0;
> +
> +	XA_STATE(xas, &encl->page_array, PFN_DOWN(encl->base));
>  
> -	xa_for_each(&encl->page_array, index, entry) {
> +	xas_lock(&xas);
> +	xas_for_each(&xas, entry, max_page_index) {
>  		if (entry->epc_page) {
>  			/*
>  			 * The page and its radix tree entry cannot be freed
> @@ -699,9 +703,20 @@ void sgx_encl_release(struct kref *ref)
>  		}
>  
>  		kfree(entry);
> -		/* Invoke scheduler to prevent soft lockups. */
> -		cond_resched();
> +		/*
> +		 * Invoke scheduler on every XA_CHECK_SCHED iteration
> +		 * to prevent soft lockups.
> +		 */
> +		if (!(++count % XA_CHECK_SCHED)) {
> +			xas_pause(&xas);
> +			xas_unlock(&xas);
> +
> +			cond_resched();
> +
> +			xas_lock(&xas);
> +		}
>  	}
> +	xas_unlock(&xas);
>  
>  	xa_destroy(&encl->page_array);
>  
> -- 
> 2.34.1
> 

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
