Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B490D6EFDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240014AbjDZWzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjDZWzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:55:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED731FCA;
        Wed, 26 Apr 2023 15:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C60A462D4A;
        Wed, 26 Apr 2023 22:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64D3C433EF;
        Wed, 26 Apr 2023 22:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682549752;
        bh=mO31oiCqVL+zzEwTGzeQsA/0T08Xnt0P1wKcAF+Logc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UTx9xBDo4rTTgBZ6kYLPc/H0W27KPvUPha+gU/V9BiMCyIZMS+/C71u1MU1H9O89M
         hLq1rTVA1fZYw63ZnNMOadUH/admvQdzc5vtd5JhEQXShF9hJVi+Xkr7a8BJfBbtQW
         8BOScQvTLSkdz7gXDSB2y+vOryBE9JYykmj1jMxZHSrvZtADBwNyjcy84g1hjvWvD3
         ps3r7IBomKD1ud3/vIa8ZeSD0Iqb+J8Je7kLq7irahYybUmi/nw5HZ2ZcK3gdrdB1Q
         TvihtT9/JJC7KHpaPHamSYp8sGNmfSdMYWjX3DD2OR/cdldWF98lcB4xFo/x+aqKrW
         jdODNyng+Mgvw==
Date:   Wed, 26 Apr 2023 15:55:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4 0/4] Implement GCM ghash using Zbc and Zbkb extensions
Message-ID: <20230426225550.GA65659@sol.localdomain>
References: <20230329140642.2186644-1-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329140642.2186644-1-heiko.stuebner@vrull.eu>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Wed, Mar 29, 2023 at 04:06:38PM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> This was originally part of my vector crypto series, but was part
> of a separate openssl merge request implementing GCM ghash as using
> non-vector extensions.
> 
> As that pull-request
>     https://github.com/openssl/openssl/pull/20078
> got merged recently into openssl, we could also check if this could
> go into the kernel as well and provide a base for further accelerated
> cryptographic support.

One more question.  It seems that this patchset uses the RISC-V scalar crypto
extensions.  I've been hearing rumors that the RISC-V scalar crypto extensions
have been superseded by the vector crypto extensions.  Is that accurate?  I
wonder if it's worth putting effort into implementations that use the scalar
crypto extensions when they might already be obsolete.

- Eric
