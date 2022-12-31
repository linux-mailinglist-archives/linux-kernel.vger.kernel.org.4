Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF4865A81F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiLaXRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbiLaXQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:16:15 -0500
X-Greylist: delayed 369 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 31 Dec 2022 15:15:47 PST
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FDED9E
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 15:15:45 -0800 (PST)
Received: from [192.168.100.223] (cust-41-49-110-94.dyn.as47377.net [94.110.49.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 0D2D1363A7A;
        Sun,  1 Jan 2023 00:09:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1672528173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6NFJgwtjfD4IL2exCtJYBQu1vWuIyPrWetXe26gp8Xo=;
        b=ZDURpk5WElkz1pl0t4hnQc50t213FELs1yg+W4gdoeX/3Qc66fgES/jkQmHdsa9gtgyich
        RizyRMMfiyEPmdFHtkmbHprUtjXuN2LJ7oR2M64LCeABSx4DGuFCg4xdVknawH2UchjSX2
        oU9GSq/bQdgCx1h4g7cHJicwoyEck1bx2ncLl0iV2DDRR7mEbfGe7rUv/n+JWiPo0EWRFk
        g9SBIfN4cWJTEyX9+9ofp2GMxahaSHifQA8qoLdLipdDgki1TV93nPPHQETNgUznYRwjoR
        UxMKXf3j//L+WQx2f65PPOFs1tEyTWAH+VRm+cKL0L41xrlX+moj+NfWXgLrIw==
Message-ID: <b5a0c3cb115e3408094c434e486f009aef7a9585.camel@svanheule.net>
Subject: Re: [PATCH] watchdog: realtek_otto: Use devm_clk_get_enabled()
 helper
From:   Sander Vanheule <sander@svanheule.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Date:   Sun, 01 Jan 2023 00:09:31 +0100
In-Reply-To: <5e4255782fbb43d1b4b5cd03bd12d7a184497134.1672498920.git.christophe.jaillet@wanadoo.fr>
References: <5e4255782fbb43d1b4b5cd03bd12d7a184497134.1672498920.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Sat, 2022-12-31 at 16:02 +0100, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
> =C2=A0=C2=A0 - calls devm_clk_get()
> =C2=A0=C2=A0 - calls clk_prepare_enable() and registers what is needed in=
 order to
> =C2=A0=C2=A0=C2=A0=C2=A0 call clk_disable_unprepare() when needed, as a m=
anaged resource.
>=20
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> =C2=A0drivers/watchdog/realtek_otto_wdt.c | 17 ++---------------
> =C2=A01 file changed, 2 insertions(+), 15 deletions(-)

Good to see more concise code here. Thanks!

FWIW

Acked-by: Sander Vanheule <sander@svanheule.net>

Best,
Sander

