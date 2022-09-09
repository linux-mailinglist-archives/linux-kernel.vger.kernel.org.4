Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2E35B3938
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiIINkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiIINkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:40:36 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5389989820;
        Fri,  9 Sep 2022 06:40:28 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F1FF31C0007;
        Fri,  9 Sep 2022 13:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662730826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ymJxpyXPHP7SnAhvIF7gZ8BpVklD5DeS9VKlbiuGSqo=;
        b=aMUOBNCAEpF9nr+LoVLA74Tm2wRdWubL7OjHHSiyxjNF7A5DyJnc+Tw8Ry0qoodVDZTRGD
        Bn4rtApb/9sE30UV7S24NOsKqrDHZuLNvhqrNsbfIxeQt1y7REkrP02NNSADgM+DoGSYWu
        shA/LsPKsCqimA/DlAcdto195BwSyJB0Qb0e25G71nXurK+HWiCAiKeVNza3UX1HYxf93u
        PQ2wAu2+XsbTK2s361PNJ23W0dNbAknKuFwV7iY3a5I3jgLrmH7b9MOmBOj+2ejPM9aGJs
        L8C0UkQFZS5QPIHJrL4uPSQBNmtHWj/Nr0CgDq8vI/TuwaWPr/PKKECRYDynNw==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 0/4] media: sunxi: MIPI CSI-2 controllers link fixups
Date:   Fri,  9 Sep 2022 15:39:50 +0200
Message-Id: <20220909133954.97010-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the MIPI CSI-2 drivers to correctly check enabled links and to
register their subdev even without a sensor attached. This allows
their parent driver to register in that situation and makes it
possible to use a parallel sensor when both parallel and MIPI CSI-2
are fed to the same controller but no sensor is connected to the
MIPI CSI-2 bridge.

With this change, it becomes possible to always describe the links
between the CSI and MIPI CSI-2 blocks in device-tree.

This series is based atop Christophe JAILLET's fixes at:
https://patchwork.kernel.org/project/linux-media/list/?series=670059

Paul Kocialkowski (4):
  media: sun6i-mipi-csi2: Require both pads to be connected for
    streaming
  media: sun8i-a83t-mipi-csi2: Require both pads to be connected for
    streaming
  media: sun6i-mipi-csi2: Register async subdev with no sensor attached
  media: sun8i-a83t-mipi-csi2: Register async subdev with no sensor
    attached

 .../sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c   | 23 +++++++++++++------
 .../sun8i_a83t_mipi_csi2.c                    | 23 +++++++++++++------
 2 files changed, 32 insertions(+), 14 deletions(-)

-- 
2.37.3

