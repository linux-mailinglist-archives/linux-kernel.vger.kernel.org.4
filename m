Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9869D6AF5C3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjCGTfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjCGTek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:34:40 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88309D008B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 11:21:37 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AF33EE0002;
        Tue,  7 Mar 2023 19:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678216896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jiRALHWp1e55wkcvOyL9CF4DO76BHMp1mu0i9xqSDT8=;
        b=LUwmOwDODq5cIiSeh8c/7f3GcXpTtevBpMqwe5mR0kWLi15eHV4KanB+gV5vxGXrAMxxFd
        ximCxN7g1beDKseM5NdjfeTCvWiJhNp5j1fjjBXnaCXAVXXgt/KFjjKL8fOn0tnb8KO/Qs
        Iw3omJ8VBkP33XZ25TFrlAEll7JOMqCMOFLwsUhbt0I6fVmHegVc7oTmDy/XaEeumSI0aA
        mgVffttYfwEKkC2frA/GRLYNSgRlNsuKYEkxHEIOTdi5JhEd7oYrRnVJu7mGUsu5dOmBsw
        V4CEbvTdQkl3LqKcNBhdLOHHPX6zROxL3GffnpLLJvwYfHPWjDHDaZmlPcGA2g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH v4] mtd: rawnand: meson: initialize struct with zeroes
Date:   Tue,  7 Mar 2023 20:21:33 +0100
Message-Id: <20230307192133.274898-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230227102425.793841-1-AVKrasnov@sberdevices.ru>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'4ce341de6c02d02aba7c78a6447ccfcaa9eeb328'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-02-27 at 10:24:25 UTC, Arseniy Krasnov wrote:
> This structure must be zeroed, because it's field 'hw->core' is used as
> 'parent' in 'clk_core_fill_parent_index()', but it will be uninitialized.
> This happens, because when this struct is not zeroed, pointer 'hw' is
> "initialized" by garbage, which is valid pointer, but points to some
> garbage. So 'hw' will be dereferenced, but 'core' contains some random
> data which will be interpreted as a pointer. The following backtrace is
> result of dereference of such pointer:
> 
> [    1.081319]  __clk_register+0x414/0x820
> [    1.085113]  devm_clk_register+0x64/0xd0
> [    1.088995]  meson_nfc_probe+0x258/0x6ec
> [    1.092875]  platform_probe+0x70/0xf0
> [    1.096498]  really_probe+0xc8/0x3e0
> [    1.100034]  __driver_probe_device+0x84/0x190
> [    1.104346]  driver_probe_device+0x44/0x120
> [    1.108487]  __driver_attach+0xb4/0x220
> [    1.112282]  bus_for_each_dev+0x78/0xd0
> [    1.116077]  driver_attach+0x2c/0x40
> [    1.119613]  bus_add_driver+0x184/0x240
> [    1.123408]  driver_register+0x80/0x140
> [    1.127203]  __platform_driver_register+0x30/0x40
> [    1.131860]  meson_nfc_driver_init+0x24/0x30
> 
> Changelog:
> v1 -> v2:
>  * More details in the commit message.
> v2 -> v3:
>  * Add 'a' article to "interpreted as a pointer".
> v3 -> v4:
>  * Add changelog.
> 
> Fixes: 1e4d3ba66888 ("mtd: rawnand: meson: fix the clock")
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
