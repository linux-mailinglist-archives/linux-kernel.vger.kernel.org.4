Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99419682B40
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjAaLPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjAaLPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:15:19 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4B14B4BD;
        Tue, 31 Jan 2023 03:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jMvM0+xbojoZ0shu619o2595UT1a9CRCkz5/Q2lhHqc=; b=rZNgBZ55MzJnwFqWAE2nUOxkhJ
        I5kLzEzM0diehKG2t8g9I/dVmq47TUpgbIsoydXQb0kWr8r8OOdHAtpBJfp2j53CSjW4zcC1MnmqY
        u7eDMTy85Wuhi4ML6GzvL8MXVS82vFmxswiHRdWP80MZ2ZJxNEIY2VZ5tWWsJv2Bpam9WA/OUpLxE
        ecPXcWS4xbNyf+LAtZQD48oRFTvwGYdUQO85qfzZdfch7J5ZTkyMTerqTvEoib5OR7eT7nt6JKTWJ
        EWjAJPSv6aFmRfXJcGQ7dNf4IQjKV7LZryhYJZ7tEcgRLP8PYTnpjEoulM3iWKSOsk6u5lVTY0tTz
        wtsNmF2w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pMoai-004KYN-1d;
        Tue, 31 Jan 2023 11:14:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 77F9B30012F;
        Tue, 31 Jan 2023 12:14:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5EE69240A5DF9; Tue, 31 Jan 2023 12:14:53 +0100 (CET)
Date:   Tue, 31 Jan 2023 12:14:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, kernel-team@meta.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v4] module: replace module_layout with module_memory
Message-ID: <Y9j4LYijtFZzkKHa@hirez.programming.kicks-ass.net>
References: <20230130182109.3571524-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130182109.3571524-1-song@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:21:09AM -0800, Song Liu wrote:
> +#define for_each_mod_mem_type(type)	\
> +	for ((type) = MOD_TEXT;	\
> +	     (type) < MOD_MEM_NUM_TYPES; (type)++)
>  
> +#define for_core_mod_mem_type(type)		\
> +	for ((type) = MOD_TEXT;		\
> +	     (type) < MOD_INIT_TEXT; (type)++)
> +
> +#define for_init_mod_mem_type(type)		\
> +	for ((type) = MOD_INIT_TEXT;		\
> +	     (type) < MOD_MEM_NUM_TYPES; (type)++)

#define __for_each_mod_mem_types(type, _from, _to)	\
	for (enum mod_mem_type type = _from; type <= _to; type++;)

also to be used in the previously suggested within_module_mem_types()
function.

also note the C99 variable in for-loop decl thing

#define for_code_mod_mem_type(type)			\
	__for_each_mod_mem_types(type, MOD_TEXT, MOD_RO_AFTER_INIT)

#define for_code_mod_mem_type(type)			\
	__for_each_mod_mem_types(type, MOD_INIT_TEXT, MOD_INIT_RODATA)



