Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFD65F71F1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiJFXih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiJFXie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:38:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35C4B7EC2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oOLFoz2ScuEP6dVb0gaYdy4OAdRu69MR7MjrV0Tmd4Y=; b=oDbgZqj70hQA5CMLaGbk548qz6
        Lpp9gS8LU047NO15e/mNQfZEIMy1gPyvc1TKC1N8J860IroU5rzMGmsvd/Hen+5OVIhkMaw/6mvnk
        xURfiqfg20izKMGjTJDUsDlsS6l/yEYZcePWUvZPphW4Dt41AohHMcfxo4qWklcSI+5kSMOcIZq7g
        7zh3Ru8BpzqQJM4oKoDm9xH/ZezZTntlQMzv7AVnlstyReuAIY2qZ9Ov2AdUwilNSO1/7sb8t7Mst
        7R9khJwzSovU+GtE8zAY6o1QWlc884YOODVfUYnhZVcTc6rV3/LRoHZo5vceMelLYCcHn85G+ZAar
        SzttgOAQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogaRg-005zxj-6r; Thu, 06 Oct 2022 23:38:28 +0000
Date:   Thu, 6 Oct 2022 16:38:28 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, x86@kernel.org, peterz@infradead.org,
        hch@lst.de, kernel-team@fb.com, rick.p.edgecombe@intel.com,
        dave.hansen@intel.com
Subject: Re: [RFC 3/5] modules, x86: use vmalloc_exec for module core
Message-ID: <Yz9m9N9qG2OOdyPy@bombadil.infradead.org>
References: <20220818224218.2399791-1-song@kernel.org>
 <20220818224218.2399791-4-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818224218.2399791-4-song@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 03:42:16PM -0700, Song Liu wrote:
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index 100446ffdc1d..570af623e28f 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -229,6 +229,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
>  	bool early = me->state == MODULE_STATE_UNFORMED;
>  	void *(*write)(void *, const void *, size_t) = memcpy;
>  
> +	early = false;
>  	if (!early) {
>  		write = text_poke;
>  		mutex_lock(&text_mutex);

As per 88fc078a7a8f6 ("x86/module: Use text_poke() for late
relocations") I'm curious why we have to take the live patching
path now all the time?

  Luis
