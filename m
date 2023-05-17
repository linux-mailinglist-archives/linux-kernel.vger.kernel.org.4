Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B35706BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjEQO6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjEQO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:58:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A63618682
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:58:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B29E2F4;
        Wed, 17 May 2023 07:58:54 -0700 (PDT)
Received: from [10.57.58.217] (unknown [10.57.58.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FEA93F73F;
        Wed, 17 May 2023 07:58:06 -0700 (PDT)
Message-ID: <59cb3075-3747-7478-58e2-534b00b5daec@arm.com>
Date:   Wed, 17 May 2023 15:58:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/3] mm: Call arch_swap_restore() from unuse_pte()
Content-Language: en-GB
To:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        "david@redhat.com" <david@redhat.com>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com
References: <20230517022115.3033604-1-pcc@google.com>
 <20230517022115.3033604-3-pcc@google.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20230517022115.3033604-3-pcc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 03:21, Peter Collingbourne wrote:
> We would like to move away from requiring architectures to restore
> metadata from swap in the set_pte_at() implementation, as this is not only
> error-prone but adds complexity to the arch-specific code. This requires
> us to call arch_swap_restore() before calling swap_free() whenever pages
> are restored from swap. We are currently doing so everywhere except in
> unuse_pte(); do so there as well.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/I68276653e612d64cde271ce1b5a99ae05d6bbc4f

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  mm/swapfile.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 274bbf797480..e9843fadecd6 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1794,6 +1794,13 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  		goto setpte;
>  	}
>  
> +	/*
> +	 * Some architectures may have to restore extra metadata to the page
> +	 * when reading from swap. This metadata may be indexed by swap entry
> +	 * so this must be called before swap_free().
> +	 */
> +	arch_swap_restore(entry, page_folio(page));
> +
>  	/* See do_swap_page() */
>  	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
>  	BUG_ON(PageAnon(page) && PageAnonExclusive(page));

