Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B58B6A19FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBXKUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjBXKUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:20:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F8018B2E;
        Fri, 24 Feb 2023 02:20:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3969AB81C15;
        Fri, 24 Feb 2023 10:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1E67C433EF;
        Fri, 24 Feb 2023 10:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677234012;
        bh=iO9PN0y1qjt6XxSGQL41NucjZnvl8Vrb0aCV9l4Baxw=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=OixR4bYwEQE7++QzTrIaH6fU7sSNYsijDXBgaK8GT2QmRNLs9gnHS31+DW6CLiQRt
         /jkVCvqf0/y7QqLQUj0NeCesSHQMGu12DYOQ36eOsqU4X8qCPlL/yAn95+nHI0n6Vj
         JpjvM7bWSDNBu85pKTSJud4RMYc9lcZPBzgqsLPCaHt7v7sbDCn827eDtcMeeiphE3
         K52/peY3d7XWQWw17kuvZVNWy3zTrjJf5uGF8d6qA4+gpDaUXf6swfMPiAOzt8bVvp
         nLf7zNQcUBfR6fZZ9gNbQBaP9JfczmTHWEBzlekweU2ny/1Q5CSwMNzTncp2X98QiU
         ERO5kI/B1RKXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id C45FAC61DA3;
        Fri, 24 Feb 2023 10:20:11 +0000 (UTC)
From:   Sasha Finkelstein via B4 Relay 
        <devnull+fnkl.kernel.gmail.com@kernel.org>
Subject: [PATCH RFC 0/4] Driver for Apple Z2 touchscreens.
Date:   Fri, 24 Feb 2023 11:20:05 +0100
Message-Id: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFWP+GMC/x2NQQqDQAxFryJZN6DRFum20AO4LS5mbKYG6iiJF
 FG8u2OXj/8+bwNjFTa4Zxso/8RkjAmKSwZd7+KHUd6JgXIqc6ISV8IwKg5fLOrgr1TdQuVrSL5
 3xujVxa4/H4OzmfUcJuUgyz/ygub5gHbfD/nmbFF5AAAA
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>, Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677234010; l=1467;
 i=fnkl.kernel@gmail.com; s=20230213; h=from:subject:message-id;
 bh=iO9PN0y1qjt6XxSGQL41NucjZnvl8Vrb0aCV9l4Baxw=;
 b=dImDJPnm2PjAzixKlaYbuO+xXG0Y6YZ4B4bWEsmaK9XI/9tzCa8+2bLT0yto9OtWiqh83pRqY
 qM6HrTIDAOcArxJFYMyemiDG6YVmwXVJgxx8kVAqt5UfoTFGbwNqHHn
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=7LFSAJtxIWAs9LzCIyX0sSvCZy2wQTyEIu1zch6o804=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20230213 with auth_id=28
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: <fnkl.kernel@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This series adds support for Apple touchscreens using the Z2 protocol.
Those are used as the primary touchscreen on mobile Apple devices, and for the
touchbar on laptops using the M-series chips. (T1/T2 laptops have a coprocessor
in charge of speaking Z2 to the touchbar).

Sending this as a RFC for now, since this series requires the SPI controller
support which is not upstream yet:
https://lore.kernel.org/all/20211212034726.26306-1-marcan@marcan.st/

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
Sasha Finkelstein (4):
      dt-bindings: input: touchscreen: Add Z2 controller bindings.
      input: apple_z2: Add a driver for Apple Z2 touchscreens
      arm64: dts: apple: t8103: Add touchbar bindings
      MAINTAINERS: Add entries for Apple Z2 touchscreen driver

 .../input/touchscreen/apple,z2-touchscreen.yaml    |  81 ++++
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/apple/t8103-j293.dts           |  20 +
 arch/arm64/boot/dts/apple/t8103.dtsi               |  12 +
 drivers/input/touchscreen/Kconfig                  |  13 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/apple_z2.c               | 465 +++++++++++++++++++++
 7 files changed, 594 insertions(+)
---
base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
change-id: 20230223-z2-for-ml-18fb5246f4b8

Best regards,
-- 
Sasha Finkelstein <fnkl.kernel@gmail.com>

