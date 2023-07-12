Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01105750A74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjGLOJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjGLOJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:09:12 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABE3CE;
        Wed, 12 Jul 2023 07:09:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C1781BF208;
        Wed, 12 Jul 2023 14:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689170949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CbH1sJuZS/Xc5s2+qd80MXtWIjOqIm/V2jGSfoumZkw=;
        b=fcmgIrDuRZOw3vQEbHsrPT0Ya1VKzHREHrZfWbB56FDykrhoZKwPfE+I7c3jBqv4UDDIQw
        TQrLqEeIOml+Cfr/hKL4/WfObvvUI5F6g5+H9L3muLRY57dsDMLNg80Lex+1fNXCk8pg19
        bHO+VbJn4Nv/MgKwrb6qv/5N8KoZcbfTJOz07qz20QI4hC2NNMxhmEJ2gUzoHHiyTi+Kao
        LtHLQ7B/ofNdpReJoX67vU87KbP3gW/kqVvA8JEv7mzmHYZxuxXMCX/+e3AfXkIDcBMGT5
        lWPXrrRb1crMg6BhSnKUXTIJszz7M9E1+JseXZjcXD8DBR9QYSzIlY1GR+fSXg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru, Stable@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mtd: rawnand: meson: fix OOB available bytes for ECC
Date:   Wed, 12 Jul 2023 16:08:53 +0200
Message-Id: <20230712140854.284151-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705065211.293500-1-AVKrasnov@sberdevices.ru>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'7e6b04f9238eab0f684fafd158c1f32ea65b9eaa'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-05 at 06:52:10 UTC, Arseniy Krasnov wrote:
> It is incorrect to calculate number of OOB bytes for ECC engine using
> some "already known" ECC step size (1024 bytes here). Number of such
> bytes for ECC engine must be whole OOB except 2 bytes for bad block
> marker, while proper ECC step size and strength will be selected by
> ECC logic.
> 
> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
