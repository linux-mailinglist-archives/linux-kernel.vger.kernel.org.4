Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373C168636D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjBAKIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjBAKIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:08:02 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4165DC39;
        Wed,  1 Feb 2023 02:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g+3Kn0G4m+PlpkGb8DecHsMvWoNFYkOTR3sD11gMtlE=; b=bl7PyQga9sZkESdiKhqmk7ZoT3
        9daFCbP2lTujVbKRcXeogZoeKXWceOXK4w5L5XjP/1hSybxRCS+sV01rUM1s/yEBrG2wNc7B2bIbZ
        ONfSWIVTHSU7mL3wMNghdxIAxCLCuh2ELVkMIhJEJel/MMeayrLgVuHlO4BcsECAjv4yIZY5Md0nc
        g2MdN1oVvg8lSPHTIwwvnTM9HL8ykPDThCxpauh2aeSH8HV1bo5RnDT/JsNlpwnl4COaB2L17ug32
        CDvGrgXwwPV7Xr4szxAV+aJ4SbKClR4btgl7mYp/6oRKLLmft+udxMriTHJLJiXyxh7noXTsxIw3O
        ZTdeD9zg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pNA0u-004iqu-2i;
        Wed, 01 Feb 2023 10:06:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69D63300129;
        Wed,  1 Feb 2023 11:07:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 38E56206F4AB2; Wed,  1 Feb 2023 11:07:21 +0100 (CET)
Date:   Wed, 1 Feb 2023 11:07:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, kernel-team@meta.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v5] module: replace module_layout with module_memory
Message-ID: <Y9o52aAC33YlRueI@hirez.programming.kicks-ass.net>
References: <20230201064720.1949224-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201064720.1949224-1-song@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 10:47:20PM -0800, Song Liu wrote:
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 8c5909c0076c..3429d354fec0 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -320,17 +320,50 @@ struct mod_tree_node {
>  	struct latch_tree_node node;
>  };
>  
> +enum mod_mem_type {
	MOD_TEXT = 0,

(just paranoia, and you explicitly rely on that below)

> +	MOD_DATA,
> +	MOD_RODATA,
> +	MOD_RO_AFTER_INIT,
> +	MOD_INIT_TEXT,
> +	MOD_INIT_DATA,
> +	MOD_INIT_RODATA,
> +
> +	MOD_MEM_NUM_TYPES,
> +	MOD_INVALID = -1,
> +};
> +
> +#define mod_mem_type_is_core_data(type)	\
> +	((type) == MOD_DATA ||		\
> +	 (type) == MOD_RODATA ||	\
> +	 (type) == MOD_RO_AFTER_INIT)
> +
> +#define mod_mem_type_is_core(type)	\
> +	((type) == MOD_TEXT ||		\
> +	 mod_mem_type_is_core_data(type))
> +
> +#define mod_mem_type_is_init(type)	\
> +	((type) == MOD_INIT_TEXT ||	\
> +	 (type) == MOD_INIT_DATA ||	\
> +	 (type) == MOD_INIT_RODATA)

Note that, per definition:

  core := !init
  data := !text

(and vice-versa ofcourse, so pick the smallest set) also ISTR you
explicitly needing is_text somewhere.... ah yes, module_enable_nx().

That is; I'd write something like:

#define mod_mem_type_is_core(type) !mod_mem_type_is_init(type)

#define mod_mem_type_is_text(type)	\
	((type) == MOD_TEXT ||		\
	 (type) == MOD_INIT_TEXT)

#define mod_mem_type_is_data(type) !mod_mem_type_is_text(type)

and then possibly additional helpers like is_core_data etc.. where
needed.

#define mod_mem_type_is_core_data(type)	\
	(mod_mem_type_is_core(type) &&	\
	 mod_mem_type_is_data(type))

> +#define for_each_mod_mem_type(type)		\
> +	for (enum mod_mem_type (type) = 0;	\
> +	     (type) < MOD_MEM_NUM_TYPES; (type)++)

So how about instead of this ...

> +#define for_core_mod_mem_type(type)			\
> +	for (enum mod_mem_type (type) = 0;		\
> +	     (type) < MOD_MEM_NUM_TYPES; (type)++)	\
> +		if (mod_mem_type_is_core(type))
> +
> +#define for_init_mod_mem_type(type)			\
> +	for (enum mod_mem_type (type) = 0;		\
> +	     (type) < MOD_MEM_NUM_TYPES; (type)++)	\
> +		if (mod_mem_type_is_init(type))

... you write something like:

#define for_class_mod_mem_type(type, class)		\
	for_each_mod_mem_type(type)			\
		if (mod_mem_type_is_##class(type))

Then we can write things like:

	for_class_mod_mem_type(type, init)
	for_class_mod_mem_type(type, data)

and

	for_class_mod_mem_type(type, core_data)

(this last could be used in show_datasize() for example).

Does that make sense?
