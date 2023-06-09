Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12DD729D14
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241344AbjFIOjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbjFIOjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:39:18 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686C5E43;
        Fri,  9 Jun 2023 07:39:16 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686321555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+5iuQIstEtDJEg7gekNXIRCPhM+FCXeq/OlIFGESoiE=;
        b=LavNs/BZU4t+UhNZnxd3ATjI29/dD7MdKyM+g5RbvWPYNmm2j95f8OxqUuNHnzOXq6RJbr
        nekM99xq2ecV7n5waBir65xEpQL5kqb6TkKl5WP23CsqKcrOGrOTKIejcwfXbprD2Mn6Jl
        ScWPQbcLb6ICiz1s1nfFl28G2UUGse1Sbn0Y3M58qosRBjHE4Oe7nst+mUiUK5li6Va3NG
        tcMFqZ930zb+5yp9f0VuQB/cq8KjRkDnV7H1spd1NtGk0hyZMrqudTxzYk7JJIzcXS4cmG
        hv1Kf5r/sAey/sYLAn7zWY6LmrhCnse0VusJmDhXM9d0m98Njes/+vGVPKjJZg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DE396000B;
        Fri,  9 Jun 2023 14:39:13 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/2] Expose reset reason through sysfs
Date:   Fri,  9 Jun 2023 16:39:10 +0200
Message-Id: <20230609143912.849995-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Back in 2019, my colleague Kamel did try to upstream a small change in the at91 reset driver, in order to expose the reset reason through sysfs instead of expecting userland to grep through dmesg to get it. There was basically no strong reason opposed to it, besides minor changes which needed fixing. 4 years ago I am seeing again the need for such exposure, so here is Kamel's patch with the minor comments addressed, as well as a small cleanup just before.

Link: https://lore.kernel.org/lkml/00f4e9a2-f6bd-9242-cafd-9c0c4f4dc619@microchip.com/T/

Cheers,
Miquèl

Changes in v2:
* Collected Nicolas' Acked-by
* Dropped the Xtal frequency information (as this may change between
  platforms of course).

Kamel Bouhara (1):
  power: reset: at91-reset: add sysfs interface to the power on reason

Miquel Raynal (1):
  power: reset: at91-reset: use driver structure as status parameter

 .../testing/sysfs-platform-power-on-reason    | 10 +++++
 drivers/power/reset/at91-reset.c              | 45 +++++++++++++------
 include/linux/power/power_on_reason.h         | 19 ++++++++
 3 files changed, 60 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-power-on-reason
 create mode 100644 include/linux/power/power_on_reason.h

-- 
2.34.1

