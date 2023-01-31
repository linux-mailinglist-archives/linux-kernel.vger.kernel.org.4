Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E88682B65
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjAaL0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjAaL0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:26:32 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBBA49552;
        Tue, 31 Jan 2023 03:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fni5RrTCyCs+Sh4H/vFsbV5abfu+10gEt7V5kFFlcfc=; b=d+8c6GdMDVVoOZSK+xAHo+Kx2e
        a0B1GBSEJWO/YTO1nGRFLpGwwDHYDa7RcPnY5o10axj1Ax2xBxIjqLe5UkA3HOruALm3VMvW2dBfa
        BtJxkF8daeyrzmJSfOWuKOIpKO9p4/E5aHtARePtm+AEZwR8ofMR5BJ1r/ATiT/dzsjOVo/v4wM3Z
        p/JncbnQReCIr90eNvIeVTwAjCzlFS7yNAAuxIb52NaMD/uBGVSb24QOFuy2o4MCBogSvi2FAoo6F
        A0L29P5lI2ZMlM5ZzgXUtLXt5yLXUBxQ2ZUHYr4A5T3qc3VrPd2+racWUWYa2830IaNp4XJAUuW+q
        0o9UGUSg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pMolq-004Klj-0v;
        Tue, 31 Jan 2023 11:25:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA02F300673;
        Tue, 31 Jan 2023 12:26:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AFBCE20B506EC; Tue, 31 Jan 2023 12:26:23 +0100 (CET)
Date:   Tue, 31 Jan 2023 12:26:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, kernel-team@meta.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v4] module: replace module_layout with module_memory
Message-ID: <Y9j63zD4P2LtIbyE@hirez.programming.kicks-ass.net>
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
> +	if (type == MOD_DATA || type == MOD_RODATA ||
> +	    type == MOD_RO_AFTER_INIT) {

> +static bool mod_mem_use_vmalloc(enum mod_mem_type type)
> +{
> +	return type == MOD_DATA || type == MOD_RODATA || type == MOD_RO_AFTER_INIT;
> +}

perhaps a mod_mem_type_is_data() helper?
