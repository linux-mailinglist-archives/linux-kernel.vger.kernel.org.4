Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1626955C9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBNBP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBNBP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:15:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CF01284B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 17:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676337311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C2q55MxPPzBSLVgcIgTObGkRfLMUQPDaZIBurW0k0ig=;
        b=fGuxr1PbI5Wa3IT/Ym1W9rv1isv1UTZEomYIYNWTM6LSMu6Ttn55xf6KfudWY+mWOSaRy6
        YOucw0rECcN2DxpTdSu9PXvaSucnBScLMwdgyFejay9F5fHqU6wqgNvlAlCxCRyzCyY+wd
        8LsC75fhhddUrlTg/8VaPl2Gt1TmZf8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-TyvtUno1NOCV1-UIY-ybDQ-1; Mon, 13 Feb 2023 20:15:06 -0500
X-MC-Unique: TyvtUno1NOCV1-UIY-ybDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1EB7811E6E;
        Tue, 14 Feb 2023 01:15:05 +0000 (UTC)
Received: from localhost (ovpn-12-99.pek2.redhat.com [10.72.12.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BA232166B26;
        Tue, 14 Feb 2023 01:15:03 +0000 (UTC)
Date:   Tue, 14 Feb 2023 09:15:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/kfence: fix page fault reporting
Message-ID: <Y+rglIOjA7kascpE@MiWiFi-R3L-srv>
References: <20230213183858.1473681-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213183858.1473681-1-hca@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/23 at 07:38pm, Heiko Carstens wrote:
> Baoquan He reported lots of KFENCE reports when /proc/kcore is read,
> e.g. with crash or even simpler with dd:
> 
>  BUG: KFENCE: invalid read in copy_from_kernel_nofault+0x5e/0x120
>  Invalid read at 0x00000000f4f5149f:
>   copy_from_kernel_nofault+0x5e/0x120
>   read_kcore+0x6b2/0x870
>   proc_reg_read+0x9a/0xf0
>   vfs_read+0x94/0x270
>   ksys_read+0x70/0x100
>   __do_syscall+0x1d0/0x200
>   system_call+0x82/0xb0
> 
> The reason for this is that read_kcore() simply reads memory that might
> have been unmapped by KFENCE with copy_from_kernel_nofault(). Any fault due
> to pages being unmapped by KFENCE would be handled gracefully by the fault
> handler (exception table fixup).
> 
> However the s390 fault handler first reports the fault, and only afterwards
> would perform the exception table fixup. Most architectures have this in
> reversed order, which also avoids the false positive KFENCE reports when an
> unmapped page is accessed.
> 
> Therefore change the s390 fault handler so it handles exception table
> fixups before KFENCE page faults are reported.
> 
> Reported-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Applied this patch on the latest kernel 6.2-rc8 and tested, it fixes the
problem perfectly. Thank a lot. Please feel free to add:

Tested-by: Baoquan He <bhe@redhat.com>

> ---
>  arch/s390/mm/fault.c | 49 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 9649d9382e0a..8e84ed2bb944 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -96,6 +96,20 @@ static enum fault_type get_fault_type(struct pt_regs *regs)
>  	return KERNEL_FAULT;
>  }
>  
> +static unsigned long get_fault_address(struct pt_regs *regs)
> +{
> +	unsigned long trans_exc_code = regs->int_parm_long;
> +
> +	return trans_exc_code & __FAIL_ADDR_MASK;
> +}
> +
> +static bool fault_is_write(struct pt_regs *regs)
> +{
> +	unsigned long trans_exc_code = regs->int_parm_long;
> +
> +	return (trans_exc_code & store_indication) == 0x400;
> +}
> +
>  static int bad_address(void *p)
>  {
>  	unsigned long dummy;
> @@ -228,15 +242,26 @@ static noinline void do_sigsegv(struct pt_regs *regs, int si_code)
>  			(void __user *)(regs->int_parm_long & __FAIL_ADDR_MASK));
>  }
>  
> -static noinline void do_no_context(struct pt_regs *regs)
> +static noinline void do_no_context(struct pt_regs *regs, vm_fault_t fault)
>  {
> +	enum fault_type fault_type;
> +	unsigned long address;
> +	bool is_write;
> +
>  	if (fixup_exception(regs))
>  		return;
> +	fault_type = get_fault_type(regs);
> +	if ((fault_type == KERNEL_FAULT) && (fault == VM_FAULT_BADCONTEXT)) {
> +		address = get_fault_address(regs);
> +		is_write = fault_is_write(regs);
> +		if (kfence_handle_page_fault(address, is_write, regs))
> +			return;
> +	}
>  	/*
>  	 * Oops. The kernel tried to access some bad page. We'll have to
>  	 * terminate things with extreme prejudice.
>  	 */
> -	if (get_fault_type(regs) == KERNEL_FAULT)
> +	if (fault_type == KERNEL_FAULT)
>  		printk(KERN_ALERT "Unable to handle kernel pointer dereference"
>  		       " in virtual kernel address space\n");
>  	else
> @@ -255,7 +280,7 @@ static noinline void do_low_address(struct pt_regs *regs)
>  		die (regs, "Low-address protection");
>  	}
>  
> -	do_no_context(regs);
> +	do_no_context(regs, VM_FAULT_BADACCESS);
>  }
>  
>  static noinline void do_sigbus(struct pt_regs *regs)
> @@ -286,28 +311,28 @@ static noinline void do_fault_error(struct pt_regs *regs, vm_fault_t fault)
>  		fallthrough;
>  	case VM_FAULT_BADCONTEXT:
>  	case VM_FAULT_PFAULT:
> -		do_no_context(regs);
> +		do_no_context(regs, fault);
>  		break;
>  	case VM_FAULT_SIGNAL:
>  		if (!user_mode(regs))
> -			do_no_context(regs);
> +			do_no_context(regs, fault);
>  		break;
>  	default: /* fault & VM_FAULT_ERROR */
>  		if (fault & VM_FAULT_OOM) {
>  			if (!user_mode(regs))
> -				do_no_context(regs);
> +				do_no_context(regs, fault);
>  			else
>  				pagefault_out_of_memory();
>  		} else if (fault & VM_FAULT_SIGSEGV) {
>  			/* Kernel mode? Handle exceptions or die */
>  			if (!user_mode(regs))
> -				do_no_context(regs);
> +				do_no_context(regs, fault);
>  			else
>  				do_sigsegv(regs, SEGV_MAPERR);
>  		} else if (fault & VM_FAULT_SIGBUS) {
>  			/* Kernel mode? Handle exceptions or die */
>  			if (!user_mode(regs))
> -				do_no_context(regs);
> +				do_no_context(regs, fault);
>  			else
>  				do_sigbus(regs);
>  		} else
> @@ -334,7 +359,6 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  	struct mm_struct *mm;
>  	struct vm_area_struct *vma;
>  	enum fault_type type;
> -	unsigned long trans_exc_code;
>  	unsigned long address;
>  	unsigned int flags;
>  	vm_fault_t fault;
> @@ -351,9 +375,8 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  		return 0;
>  
>  	mm = tsk->mm;
> -	trans_exc_code = regs->int_parm_long;
> -	address = trans_exc_code & __FAIL_ADDR_MASK;
> -	is_write = (trans_exc_code & store_indication) == 0x400;
> +	address = get_fault_address(regs);
> +	is_write = fault_is_write(regs);
>  
>  	/*
>  	 * Verify that the fault happened in user space, that
> @@ -364,8 +387,6 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  	type = get_fault_type(regs);
>  	switch (type) {
>  	case KERNEL_FAULT:
> -		if (kfence_handle_page_fault(address, is_write, regs))
> -			return 0;
>  		goto out;
>  	case USER_FAULT:
>  	case GMAP_FAULT:
> -- 
> 2.37.2
> 

