Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0A2687077
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 22:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjBAVYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 16:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBAVYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 16:24:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5415CFDD;
        Wed,  1 Feb 2023 13:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9JTW+I5Cj/1Ke1PLMLNBpaeoMxVBLFYDYxoJ/Y2+CmQ=; b=dOEfqGu3h1VLJ/KmymIUX7u2QG
        eApSHHQqQa3jpmuc/yx7tlBLBnNqtNybmfy6b1saQgAP9fc7uWkpwX+D+Sm8rhlpzPkf1hf6fkfOt
        uMFA0Qb5SmLZPWwJYvXpGi3HGKSIpGk8inA6Y3l6qa5HdoemuessSAXak+Rvfbz8Fc4ZiajHaiVKy
        q94XFRpjsDxxN6zBeayGTfhFacijzWB9+cQRWvtU+j/GCFVqhkBxduJTMzzgR5dBEMdZR2IPYia8u
        zlZw9RaaOiQp3VjVkS2w8PpJbBQ+mJo4HEzSGgz4IkQP1C12vmIGzxFb7nHBoyzLl/afDItogs7EW
        4PkAlBbg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNKaK-00CnV1-5o; Wed, 01 Feb 2023 21:24:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A135C300446;
        Wed,  1 Feb 2023 22:24:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B197200DCC72; Wed,  1 Feb 2023 22:24:02 +0100 (CET)
Date:   Wed, 1 Feb 2023 22:24:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, kernel-team@meta.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v7] module: replace module_layout with module_memory
Message-ID: <Y9rYcvPx4MhA+c+u@hirez.programming.kicks-ass.net>
References: <20230201184422.2932156-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201184422.2932156-1-song@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 10:44:22AM -0800, Song Liu wrote:

>  static ssize_t show_datasize(struct module_attribute *mattr,
>  			     struct module_kobject *mk, char *buffer)
>  {
> -	return sprintf(buffer, "%u\n", mk->mod->data_layout.size);
> +	unsigned int size = 0;
> +
> +	for_class_mod_mem_type(type, core) {
> +		if (type == MOD_TEXT)
> +			continue;

isn't this the same as:

	for_class_mod_mem_type(type, core_data)

?

> +		size += mk->mod->mem[type].size;
> +	}
> +	return sprintf(buffer, "%u\n", size);
>  }


> -	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
> +	for_class_mod_mem_type(type, core) {
> +		lockdep_free_key_range(mod->mem[type].base,
> +				       mod->mem[type].size);
> +	}

Why the core_data to core change? Specifically the difference seems to
be you now include text. Now, we shouldn't be having lockdep keys in
text, so it's harmless, still a bit weird.


Anyway, looks real good to me otherwise. Thanks!
