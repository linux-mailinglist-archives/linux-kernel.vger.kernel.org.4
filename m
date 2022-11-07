Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BC061F98F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiKGQ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiKGQZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:25:47 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF3727B01;
        Mon,  7 Nov 2022 08:22:17 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DCD9FE000D;
        Mon,  7 Nov 2022 16:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667838134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rjjELctFESp7irdpKdkiJYoito1nOsPFkddC5B+aubE=;
        b=SdmdWDUYP4zm9smi9oF7/3BdmRNEEvLW9N713dXxVP4YZWbf7RhTSBGbP7dhmuZ+7DC/Ho
        kmEOEnVaP+CYusyinFsU8fVSzKNAjTlGSdtcSo/RiPaAlfWfZ8lczxeGvnCOtE30P4d9tO
        U1XMw+v4lY+wqNdjX/sMsT4V3KDG9vp1MGbZd/5AZ1tyTXsGMGj1Q/yK10qtFZcOlWfTgL
        msj3oFIQC58YunfQmoOW26ReKIS+LPgJIsE/UZIBz0EB1cJ113z4CzSgm/zIrD2jtc4Z0Z
        k5zFrdypQz65YRyV3YVDG21eq8G1rCbApzVqQGBqNhf7dh7wmt05GA+ErP1Ogg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3 1/2] dt-bindings: mtd: partitions: support marking rootfs partition
Date:   Mon,  7 Nov 2022 17:22:12 +0100
Message-Id: <20221107162212.49114-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221022211318.32009-1-zajec5@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2b9a31d762f0441ab87cb76524c005adf54d6719'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-10-22 at 21:13:17 UTC, =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Linux needs to know what to use as root device. On embedded devices with
> flash the only common way to specify that is cmdline & root= parameter.
> 
> That solution works with U-Boot which is Linux & cmdline aware but isn't
> available with all market bootloaders. Also that method is fragile:
> 1. Requires specific probing order on multi-flash devices
> 2. Uses hardcoded partitions indexes
> 
> A lot of devices use different partitioning methods. It may be
> "fixed-partitions" or some dynamic partitioning (e.g. based on parts
> table). For such cases allow "linux,rootfs" property to mark correct
> flash partition.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
