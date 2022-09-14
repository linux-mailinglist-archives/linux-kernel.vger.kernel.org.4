Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D285B8EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 20:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiINSPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 14:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiINSPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:15:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21B01573F;
        Wed, 14 Sep 2022 11:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79E7961E8E;
        Wed, 14 Sep 2022 18:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FCCC433C1;
        Wed, 14 Sep 2022 18:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663179298;
        bh=YSZCfCgBas7sM38vNqjuLIpxrhdHOeh3iNoKuSZSNgQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=urqn2kULlBPEfMnbgZ253cO6nn/5Qh9LuC6Lcr4XqSnVkxp5LlrLMjWdMBtzclWE2
         lVxyH9SClgzxpd73uTmD1BDxZVd9Yx8bgP6wNuKevZMEabNN/6hTl9/a+ffQoaysbg
         wLX/uJDhnoCu/XniMB0advt5wYr3AAFxWz6f6G/6tQ6/NzUmepf2ComI5equDKSwy+
         qPescjzuN3MXPeivEFaHZopIhwR4++Tvs5xSwTcYAumlj+xH10EhT/DSwFCdHOUAS5
         rXRxSTm5FE9nW1AYg3qtKJ2nqxtQCm26QlzSTraQt6QaXAjBct3ZXTzi1nP9ZWRYF3
         kadx1bR66QF3Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c221873f-f230-0cce-e120-7e3cc732cf00@i2se.com>
References: <20220815-rpi-fix-4k-60-v1-0-c52bd642f7c6@cerno.tech> <20220815-rpi-fix-4k-60-v1-2-c52bd642f7c6@cerno.tech> <20220914155035.88E45C433C1@smtp.kernel.org> <50e8f1e8-806a-3599-7cbe-0c7d4bec1c51@i2se.com> <20220914180508.0EDD9C433D6@smtp.kernel.org> <c221873f-f230-0cce-e120-7e3cc732cf00@i2se.com>
Subject: Re: [PATCH v1 2/7] clk: bcm: rpi: Add a function to retrieve the maximum
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Dom Cobley <popcornmix@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Emma Anholt <emma@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Date:   Wed, 14 Sep 2022 11:14:56 -0700
User-Agent: alot/0.10
Message-Id: <20220914181458.C6FCCC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stefan Wahren (2022-09-14 11:09:04)
> Am 14.09.22 um 20:05 schrieb Stephen Boyd:
> > Quoting Stefan Wahren (2022-09-14 10:45:48)
> >> Am 14.09.22 um 17:50 schrieb Stephen Boyd:
> >>> Furthermore, I wonder if even that part needs to be implemented.  Why
> >>> not make a direct call to rpi_firmware_property() and get the max rat=
e?
> >>> All of that can live in the drm driver. Making it a generic API that
> >>> takes a 'struct clk' means that it looks like any clk can be passed,
> >>> when that isn't true. It would be better to restrict it to the one use
> >>> case so that the scope of the problem doesn't grow. I understand that=
 it
> >>> duplicates a few lines of code, but that looks like a fair tradeoff v=
s.
> >>> exposing an API that can be used for other clks in the future.
> >> it would be nice to keep all the Rpi specific stuff out of the DRM
> >> driver, since there more users of it.
> > Instead of 'all' did you mean 'any'?
> yes

Why?
