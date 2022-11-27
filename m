Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A283B639E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 00:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiK0X4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 18:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK0X4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 18:56:07 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E701BC93;
        Sun, 27 Nov 2022 15:56:06 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7E8DF40006;
        Sun, 27 Nov 2022 23:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669593365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2cLQyRvTObsQSLR0d1Gq8L390yP6Zpvaz75Y8uF4u+U=;
        b=DdrpY7xoS3ciCKeMPN4cBm0Cz5UUQmtRY+1gdK9iJ8QL8a3UJbD8Pq3JGDUbbCFAHZSQJb
        k3hnhlhCYZtUOn2YlixtLUs0v8cW0YLWXcGNgCee3CImITPWwNeUlZBQKFzJWg6ils46C+
        RvnOEvhZNQnEaGDGbm2z82Lw2MxBlC9Nekm1kokqdIZfIZddiaderKcWID1ez1ja3bKVSm
        nTuf/turaFPxCP/hVq1O7FOrW09zU87Qsgg7muy1q2yFd9/z71cXzraw+xECV6SbB0NPkR
        Ukuuh/DslHXEHHnG3C20PuNfWq2dCKYRRH16XFEhQaXKi/AsGp1OjDvROBIfbw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Subject: Re: [PATCH 0/6] ARM: dts: pci-mvebu: Fix assigned-addresses for
 every PCIe Root Port
In-Reply-To: <20220817223053.31141-1-pali@kernel.org>
References: <20220817223053.31141-1-pali@kernel.org>
Date:   Mon, 28 Nov 2022 00:56:03 +0100
Message-ID: <878rjw9cks.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> Per IEEE Std 1275-1994 bindings documentation (to which kernel DT
> bindings refers), DT property assigned-addresses contains BDF address
> of resource. Currently more PCIe Root Port nodes have BDF address in
> assigned-addresses which points to different PCIe Root Port nodes. This
> obviously does not make sense as the address resource specified in
> assigned-addresses of every PCIe Root Port describes address range of
> internal registers which are specific for corresponding Marvell PCIe
> Root Port. Fix this issue and align all BDF addresses in
> assigned-addresses DT property to specify correct BDF address of the
> current PCIe Root Port.
>
> Note that current version of pci-mvebu.c controller driver, which
> registers Marvell PCIe Root Ports, ignores BDF value in DT property
> assigned-addresses. It expects that Root Port's assigned-addresses
> contains address range of that root port. That is why driver currently
> works without any issue and nobody spotted it. But if driver or
> something else would do device tree validation then this issue should be
> spotted and throws error. Also device tree files may be used by other
> projects where drivers may require correct values.
>
> This patch series aligns BDF address of every Marvell PCIe Root Port in
> node name, config space in reg property and mem in assigned-address
> property of internal registers resource.
>
> Pali Roh=C3=A1r (6):
>   ARM: dts: dove: Fix assigned-addresses for every PCIe Root Port
>   ARM: dts: armada-370: Fix assigned-addresses for every PCIe Root Port
>   ARM: dts: armada-xp: Fix assigned-addresses for every PCIe Root Port
>   ARM: dts: armada-375: Fix assigned-addresses for every PCIe Root Port
>   ARM: dts: armada-38x: Fix assigned-addresses for every PCIe Root Port
>   ARM: dts: armada-39x: Fix assigned-addresses for every PCIe Root Port

Series applied on mvebu/dt

Thanks,

Gregory
>
>  arch/arm/boot/dts/armada-370.dtsi        |  2 +-
>  arch/arm/boot/dts/armada-375.dtsi        |  2 +-
>  arch/arm/boot/dts/armada-380.dtsi        |  4 ++--
>  arch/arm/boot/dts/armada-385.dtsi        |  6 +++---
>  arch/arm/boot/dts/armada-39x.dtsi        |  6 +++---
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi |  8 ++++----
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi | 16 ++++++++--------
>  arch/arm/boot/dts/dove.dtsi              |  2 +-
>  8 files changed, 23 insertions(+), 23 deletions(-)
>
> --=20
> 2.20.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
