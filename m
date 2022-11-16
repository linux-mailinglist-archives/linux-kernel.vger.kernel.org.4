Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B23962BBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiKPLbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbiKPLar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:30:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8D31033;
        Wed, 16 Nov 2022 03:19:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7EF161CCB;
        Wed, 16 Nov 2022 11:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1722C433D6;
        Wed, 16 Nov 2022 11:19:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RYhLS4HY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668597580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6aTacRSOW2cWRX+axKPWZgBes5QK7CSYjTPlhqVOCO8=;
        b=RYhLS4HYaHxihQYVM1R+CzqlOPL90sTaI7vmGV3QtXlWibp1bi8awrU+FuAA2eQdgS6KFl
        XZ9rv7hWQ63Z3YQqQyY944TJgpvfbO6hddteDl+zJt34IPDprA4zN0NcVZ2ANML7h5MBRK
        l9HZAKt7noEUSk0XtSj1eGNRy1C4/Gs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 412042da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Nov 2022 11:19:40 +0000 (UTC)
Date:   Wed, 16 Nov 2022 12:19:38 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/24] crypto: x86/poly - load based on CPU features
Message-ID: <Y3THSmvuZlq2+hky@zx2c4.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
 <20221116041342.3841-18-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221116041342.3841-18-elliott@hpe.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:13:35PM -0600, Robert Elliott wrote:
> +static const struct x86_cpu_id module_cpu_ids[] = {
> +	X86_MATCH_FEATURE(X86_FEATURE_ANY, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
> +
>  static int __init poly1305_simd_mod_init(void)
>  {
> +	if (!x86_match_cpu(module_cpu_ids))
> +		return -ENODEV;

What exactly does this accomplish? Isn't this just a no-op?

Jason
