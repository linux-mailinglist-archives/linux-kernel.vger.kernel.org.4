Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117097412AE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjF1Nis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjF1Nil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:38:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B40A129
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:38:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fba64d9296so20826025e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687959518; x=1690551518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BD6UVrDj44rW0iJhXXnbinIwh1j5tk1DZT8e7Z3NaOY=;
        b=WWeVCCFbIZYErL2dpy976B3XVZvdzxcSOLDIklpFS4QKRgwH1WVfQ9hdJfQU2Oj8kt
         59hY7CvgZDiQ23mxOd4qQbzgRVCEMXayqCNT6lb14UlOh+86lDuEuW/zAfWMM7Hgqfig
         2zJ1A4rfpFzuqAed6ZUOl65Zf3gBcUAWSGgVpTaqq3LhZr4CBd2zu3uFu2gdjvHNS2x9
         auKS8QERrTRDWhPdE9u/Ex/qEGt2GqHNFFo6+me2Mvcbx+ZmJ+LsYv4wR8huegNmSF71
         dBz0l5eJ+Xfjo44TJXOiUZGY0XgcBgeOnJL3Hndpk5dgbD9tN0MyNaZwV4tUAs6K1LDr
         qU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959518; x=1690551518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BD6UVrDj44rW0iJhXXnbinIwh1j5tk1DZT8e7Z3NaOY=;
        b=AoP1Bz6ORPCjQerbKNKFRga7Z7NYfSOb+R324YPHvNk2X6xsWL+LtHxaBHEOCG3nk7
         nPxBnj1aOxQANExiIdDTI5KrzVKsFkLdCWkLz56MKpW5QoKPxAbJ4w395sBGqwDlJq1g
         VOOwOkqXbwi/QWx7LVruEqwbUsu0YrXJpgorcvgMvPaqAKNKgT6bTuhblSQlR2Fs86Mv
         77WxMqYSFd/92zvmYgyq3qfsHhMmphmi74puZ4gRsSFa2PAO2WQXZyEBZKDaZ+Ag/S5x
         Xp0H7OCFPkja3RtwgqwJuq+7WolP0bdyg2Ud6kAy9BK8xccbVpPdP4xtq9YHDAxj64V4
         6vBw==
X-Gm-Message-State: AC+VfDwSBomaWV9cDGWEibNEiAE5kwTWJQDbX+DLmqZf6z0rYvrF+mN0
        GyKhIrxOydyUKQ0Oa6kNdw/78w==
X-Google-Smtp-Source: ACHHUZ4smNZjAC+Ejv0ENEyNEdlvmH41eqPq/7xhCc98BSyBZS5jwVv/KMif0Uft9u5CQGBQuBe34A==
X-Received: by 2002:a1c:f603:0:b0:3f8:f80e:7b45 with SMTP id w3-20020a1cf603000000b003f8f80e7b45mr26822235wmc.7.1687959518616;
        Wed, 28 Jun 2023 06:38:38 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o23-20020a05600c379700b003fae92e7a8dsm7657539wmr.27.2023.06.28.06.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:38:37 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        david@ixit.cz, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 0/2] usb: serial: add support for CH348
Date:   Wed, 28 Jun 2023 13:38:32 +0000
Message-Id: <20230628133834.1527941-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The CH348 is an octo serial to USB adapter.
The following patch adds a driver for supporting it.
Since there is no public datasheet, unfortunatly it remains some magic values.

It was tested with a large range of baud from 1200 to 1500000 and used with
success in one of our kernel CI testlab.

Regards

Changes since v1:
- use a data structure for encoding/decoding messages.
- check if needed endpoints exists
- fix URB leak in ch348_allocate_status_read error case
- test for maximum baud rate as stated by datasheet

Changes since v2:
- specify ch348_rxbuf data length
- Use correct speed_t dwDTERate instead of __le32
- test for maximum baud rate supported according to datasheet
- Use a define for CH348_TX_HDRSIZE

Changes since v3
- Fixed all reported problem from https://lore.kernel.org/lkml/Y5NDwEakGJbmB6+b@Red/T/#mb6234d0427cfdabf412190565e215995a41482dd
  Mostly reworked the endpoint mux to be the same than mx_uport

Changes since v4:
- The V4 was sent against stable and next have ch348_set_termios ktermios
  parameter const that I forgot to change

Changes since v5:
- Fixed all reported problem from https://lore.kernel.org/lkml/20230106135338.643951-1-clabbe@baylibre.com/T/#m044aab24dfb652ea34aa06f8ef704da9d6a2e036
- Major change is dropping of all status handling which was unused.
  It will be probably necessary to bring it back when using GPIO.
  This will be done when I will finish my next devboard.

Corentin Labbe (2):
  usb: serial: add support for CH348
  usb: serial: add myself as maintainer of CH348

 MAINTAINERS                 |   5 +
 drivers/usb/serial/Kconfig  |   9 +
 drivers/usb/serial/Makefile |   1 +
 drivers/usb/serial/ch348.c  | 491 ++++++++++++++++++++++++++++++++++++
 4 files changed, 506 insertions(+)
 create mode 100644 drivers/usb/serial/ch348.c

-- 
2.39.3

