Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8D974F88A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 21:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjGKTuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 15:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGKTuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BB619B;
        Tue, 11 Jul 2023 12:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6384A615D4;
        Tue, 11 Jul 2023 19:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C8EC433C7;
        Tue, 11 Jul 2023 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689105016;
        bh=GJ2IGsxnD02URnsLt1TvbqxKOkCuebJia7feM719N4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fMKOQFzuut/D9ubxM3KOsZFPHEseHkuGvxGjPPeSi3+qAnDqN58I5pHr7giY5odwn
         jR+6s7Ekt69CBC5haeuQKqwHO68ZDmFpzcz1i8SYYJEva0Hlzrt0JbcUJacFZtoKEE
         xPTxwJRCP/Ibemx9yanDlE3M26etSkLcIE+1INt1/1aTyAXJxMACR4VMgTtPaDqJNx
         FUX2mJz0g+GNFpZLX5UbPdyKCeS01nyuvzvgkN0kEf2X/Oj9d7NLbrb2moePgrHgbj
         H5Xzl85ceyKKhmz7Gwmb9c7UcHOQmVitcGXAKIUAJsI2V5Ve59HFPMZTl8/piPPmfG
         aQbMXiNXKfksQ==
Date:   Tue, 11 Jul 2023 20:50:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Saravana Kannan <saravanak@google.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <jstultz@google.com>, stable@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] regmap-irq: Fix out-of-bounds access when allocating
 config buffers
Message-ID: <8e5fba54-9ec7-45a7-8dd6-6ea63d853907@sirena.org.uk>
References: <20230711193059.2480971-1-isaacmanjarres@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L8CpatHGZQaIU02J"
Content-Disposition: inline
In-Reply-To: <20230711193059.2480971-1-isaacmanjarres@google.com>
X-Cookie: marriage, n.:
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L8CpatHGZQaIU02J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 11, 2023 at 12:30:58PM -0700, Isaac J. Manjarres wrote:

> [   14.033877][    T1] ==================================================================
> [   14.042507][    T1] BUG: KASAN: invalid-access in regmap_add_irq_chip_fwnode+0x594/0x1364
> [   14.050796][    T1] Write of size 8 at addr 06ffff8081021850 by task init/1
> [   14.057841][    T1] Pointer tag: [06], memory tag: [fe]
> [   14.063124][    T1]
> [   14.065349][    T1] CPU: 2 PID: 1 Comm: init Tainted: G        W   E      6.4.0-mainline-g6a4b67fef3e2 #1
> [   14.075014][    T1] Hardware name: Thundercomm Dragonboard 845c (DT)
> [   14.081432][    T1] Call trace:

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--L8CpatHGZQaIU02J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmStsm8ACgkQJNaLcl1U
h9AUcAf9G68AiXv6aJE9KUy58k3z0XT6+0DHhNxDhCNIuQjRhtZvwtLBaIN3gVwD
mfjARc11IuPFmjfAiY9oWJfMwQvWjnVmo6Rr+WY+gm+bwGqnxUmFb54e2yvSciWi
KTf6bHmi29Qo11mMoE80kySFYG+r0qmGX0tu/f49WCH/zpR4u1UMkOUh6/+4GJZW
8jmp7ovdzda2S48NKcb3W5naN4M0xOvUc5eyh+JWiGNeZl655ozbZYkKCw0y8BIH
A/u6j6I5kqErD1LchXNo1zB+7Gt8LD0rOWXAU2ep7UoM5ZE03PAcQ1aDfMNlFuux
y/3UwbOEhXpFtidtJtgXptuRq/OhIg==
=ZyB8
-----END PGP SIGNATURE-----

--L8CpatHGZQaIU02J--
