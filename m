Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE0609127
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 06:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJWEah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 00:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJWEae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 00:30:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5339B56001
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 21:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A68360B7C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 04:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88220C433D6;
        Sun, 23 Oct 2022 04:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666499428;
        bh=uPMCGsaL3pal+Bgihru3JqaP1UoQzo4SMlHGUQrGKlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=amtUSmCzayHOwb6jzx1Ib0/FiWdaZ+MYyFRYfT8yH0KMxY48pvCLCM3WdWj5gglWi
         OLFZVsyYea17nTsGv7/3cSfrkqfrqr1hjbrUB0Ry6oLmXsfwEjZK67EyiHNmFuaOXC
         gVF6fC1GNfmzYppRMmPfCXSVpV+2A6mKXsVkvWC3P1BJxJ5LawngHyAQfRu8QdK3zZ
         VrcElQ5tXEX3XXvVvtBXZYH7xLMpKf89lVe1tU2uy5to7Uajpyp0x6dTqdHMBl69dX
         8wPmMNtV7anwxGivsMRoRuhjN9Kcv28E8ocwZ/ESIn2v6az+PqkqZlFShENmB9fhPu
         hdL9cSz6ObmFg==
Date:   Sun, 23 Oct 2022 07:30:21 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Thomas Tai <thomas.tai@oracle.com>
Cc:     tony.luck@intel.com, dave.hansen@linux.intel.com,
        reinette.chatre@intel.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com
Subject: Re: [PATCH V3 1/1] x86/sgx: Add code to inject hwpoison into SGX
 memory
Message-ID: <Y1TDXd/l9OA53XVs@kernel.org>
References: <20221017223305.578073-1-thomas.tai@oracle.com>
 <20221017223305.578073-2-thomas.tai@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017223305.578073-2-thomas.tai@oracle.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 06:33:05PM -0400, Thomas Tai wrote:
> Inspired by commit c6acb1e7bf46 ("x86/sgx: Add hook to error injection
> address validation"), add a similar code in hwpoison_inject function to
> check if the address is located in SGX Memory. The error will then be
> handled by the arch_memory_failure function in the SGX driver. After
> injection, the action_result() will print out the page type and the
> action taken.
> 
> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> ---
>  Documentation/mm/hwpoison.rst | 24 ++++++++++++++++++++++++
>  include/linux/mm.h            |  1 +
>  include/ras/ras_event.h       |  1 +
>  mm/hwpoison-inject.c          |  4 ++++
>  mm/memory-failure.c           |  5 ++++-
>  5 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/mm/hwpoison.rst b/Documentation/mm/hwpoison.rst
> index b9d5253c1305..100894bb020c 100644
> --- a/Documentation/mm/hwpoison.rst
> +++ b/Documentation/mm/hwpoison.rst
> @@ -162,6 +162,30 @@ Testing
>  
>    Some portable hwpoison test programs in mce-test, see below.
>  
> +* Special notes for injection into SGX enclaves
> +
> +  1) Determine physical address of enclave page
> +
> +	dmesg | grep "sgx: EPC"
> +
> +	sgx: EPC section 0x8000c00000-0x807f7fffff
> +	sgx: EPC section 0x10000c00000-0x1007fffffff
> +
> +  2) Convert the EPC address to page frame number.
> +
> +	For 4K page size, the page frame number for 0x8000c00000 is
> +	0x8000c00000 / 0x1000 = 0x8000c00.
> +
> +  3) Inject a memory error
> +
> +	modprobe hwpoison-inject
> +	echo "0x8000c00" > /sys/kernel/debug/hwpoison/corrupt-pfn
> +
> +  4) Check dmesg output
> +
> +        dmesg | grep "Memory failure"
> +        Memory failure: 0x8000c00: recovery action for sgx page: Recovered
> +
>  References
>  ==========
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 21f8b27bd9fd..cdca3ff1418c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3248,6 +3248,7 @@ enum mf_action_page_type {
>  	MF_MSG_BUDDY,
>  	MF_MSG_DAX,
>  	MF_MSG_UNSPLIT_THP,
> +	MF_MSG_SGX,
>  	MF_MSG_UNKNOWN,
>  };
>  
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index cbd3ddd7c33d..ee3a925c1e9d 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -373,6 +373,7 @@ TRACE_EVENT(aer_event,
>  	EM ( MF_MSG_BUDDY, "free buddy page" )				\
>  	EM ( MF_MSG_DAX, "dax page" )					\
>  	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
> +	EM ( MF_MSG_SGX, "sgx page" )					\
>  	EMe ( MF_MSG_UNKNOWN, "unknown page" )
>  
>  /*
> diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
> index 65e242b5a432..141eeeb793b1 100644
> --- a/mm/hwpoison-inject.c
> +++ b/mm/hwpoison-inject.c
> @@ -21,6 +21,10 @@ static int hwpoison_inject(void *data, u64 val)
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	/* Inject the error if the page is part of the processor reserved memory */
> +	if (arch_is_platform_page(pfn << PAGE_SHIFT))
> +		goto inject;
> +
>  	if (!pfn_valid(pfn))
>  		return -ENXIO;
>  
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 14439806b5ef..40a22b23b50a 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -781,6 +781,7 @@ static const char * const action_page_types[] = {
>  	[MF_MSG_BUDDY]			= "free buddy page",
>  	[MF_MSG_DAX]			= "dax page",
>  	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
> +	[MF_MSG_SGX]			= "sgx page",
>  	[MF_MSG_UNKNOWN]		= "unknown page",
>  };
>  
> @@ -1990,8 +1991,10 @@ int memory_failure(unsigned long pfn, int flags)
>  	p = pfn_to_online_page(pfn);
>  	if (!p) {
>  		res = arch_memory_failure(pfn, flags);
> -		if (res == 0)
> +		if (res == 0) {
> +			action_result(pfn, MF_MSG_SGX, MF_RECOVERED);
>  			goto unlock_mutex;
> +		}
>  
>  		if (pfn_valid(pfn)) {
>  			pgmap = get_dev_pagemap(pfn, NULL);
> -- 
> 2.31.1
> 

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>

BR, Jarkko
