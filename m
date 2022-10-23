Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11D36095FF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 22:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiJWUIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 16:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiJWUHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 16:07:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4025F105;
        Sun, 23 Oct 2022 13:07:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5FA67CE0F52;
        Sun, 23 Oct 2022 20:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F4AC433D6;
        Sun, 23 Oct 2022 20:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666555670;
        bh=Ag/xg2HQiuQje4wmXFAhGvzAEVCH/1G7yr5qMDmyc4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c63qn7Vui6sNhirZB/Gy8jQQWSTBX6RlPENYbdmf2euXuPTcRwNhSYO/4GuC9R230
         DYAEiWjMh6h3KRvLgVBt6+9ddkvTjzfgmsIOhtBL2d8JP2c/AhDIYwLUet8xR2PZbB
         j0BamdIOibCtH89FdHO9Xp2r2k9u4pmx7fv+eEBSbDGDa6iyDCy6hFl5wtluF0faiA
         Ymcfo81tjwPf230EWg+JYwdVePTXAI44+YWQp52bB968AbzQ9NhW3lKj5+mXZyombc
         cTVXEhcS3MLeIP4VXX9V3NPxKSlwdnD2+86NRTWV/5eyFdSaKY0UCqSUOIF9+oQgpA
         DL3XZLmCsZY7Q==
Date:   Sun, 23 Oct 2022 23:07:43 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-sgx@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/5] x86/sgx: use VM_ACCESS_FLAGS
Message-ID: <Y1WfD1x+XDi3xvpL@kernel.org>
References: <20221019034945.93081-1-wangkefeng.wang@huawei.com>
 <20221019034945.93081-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019034945.93081-3-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 11:49:42AM +0800, Kefeng Wang wrote:
> Simplify VM_READ|VM_WRITE|VM_EXEC with VM_ACCESS_FLAGS.
> 
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/x86/kernel/cpu/sgx/encl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 1ec20807de1e..6225c525372d 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -268,7 +268,7 @@ static struct sgx_encl_page *sgx_encl_load_page_in_vma(struct sgx_encl *encl,
>  						       unsigned long addr,
>  						       unsigned long vm_flags)
>  {
> -	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
> +	unsigned long vm_prot_bits = vm_flags & VM_ACCESS_FLAGS;
>  	struct sgx_encl_page *entry;
>  
>  	entry = xa_load(&encl->page_array, PFN_DOWN(addr));
> @@ -502,7 +502,7 @@ static void sgx_vma_open(struct vm_area_struct *vma)
>  int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
>  		     unsigned long end, unsigned long vm_flags)
>  {
> -	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
> +	unsigned long vm_prot_bits = vm_flags & VM_ACCESS_FLAGS;
>  	struct sgx_encl_page *page;
>  	unsigned long count = 0;
>  	int ret = 0;
> -- 
> 2.35.3
> 

Why?

BR, Jarkko
