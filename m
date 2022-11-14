Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF1D627677
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbiKNHhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbiKNHhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:37:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8A4A45F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:37:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v1so16470851wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+v1xeFroLEZ2pPLWd3Trc4JUUcj9sZhHuuFgi+e21Mw=;
        b=QCYJSmxG90jy4NieQkayH0lG0lScaEdWQyhiRCp8N7qfAMSGsgfQ8iBhqOZ6SBmNfi
         JU78vKU+n8si93XORHoJlj+IyS35XgorRvB9drP9/ljOAHVajtonHoOx46PTsdMWWw33
         u2UKx60i/0aIxiFFMhJvNmoVlCYYXZsYuM9f6gda6+ciPJt+HYMz3ugKdoAimwOAU4wZ
         elYJNaqU0EPk/jIb4FxDRNX/MiO7SzynHuwuKawRWmHxjUJMfc1GtH2YkATz0O0EzaP6
         RDZl0oTFY3l/VEsL07ZaQ4Ugwqh6d48eFkJmTHCh0OoIxpwwUnUJHvusF1I7zlY/cEo6
         Qc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+v1xeFroLEZ2pPLWd3Trc4JUUcj9sZhHuuFgi+e21Mw=;
        b=nqg5hBfNEVg2HYDf/JJ2yMVPpaPI4sfzamAeyu9nQ7UDb6QvCvsuBr3OBoHsx83mrI
         9XWKEWiLc9ChjU2X/Zv9B0t2CS4I+nXDJ2JkCUo/xKTYsT90n9iJc3uE77wNCl2KnggD
         qFR4oraml7lF7j02Sin3euNWlXFhTjhl+Pc+BjJAsUxRZC944HuHa3VL51oYK6GqyyA3
         rUSp0xl8XZ38WJ2UT6kuS4xl2Rl+ZnuciZk3ZWgoFHNeJe2epgwBCLh13gefUzpqirf9
         5qT1j1FnLk93dMm2Ch9v3lgT1HXYxQjtJwrlqSvDYubjzT6A817oX+7VDflJ46feQJtP
         y8eQ==
X-Gm-Message-State: ANoB5pkYaKF1r/V7qAq1/uLFvepp2CeJFszFlo/YmprDCjJsram9t8nQ
        NstpZT8+O6mviEpC5D56lQ8z/A==
X-Google-Smtp-Source: AA0mqf5NqsKh/vcuUJFt2MRTYucERtlYxCAdolorEZtoSJ0reSjA8C0sNOAzq3eciyj5DEt5Kug7eg==
X-Received: by 2002:adf:9bcf:0:b0:22e:5d66:dc5d with SMTP id e15-20020adf9bcf000000b0022e5d66dc5dmr6633491wrc.175.1668411468143;
        Sun, 13 Nov 2022 23:37:48 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h11-20020a05600c314b00b003b4fe03c881sm18467775wmo.48.2022.11.13.23.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 23:37:47 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 0/2] usb: serial: add support for CH348
Date:   Mon, 14 Nov 2022 07:37:34 +0000
Message-Id: <20221114073736.672194-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Corentin Labbe (2):
  usb: serial: add support for CH348
  usb: serial: add myself as maintainer of CH348

 MAINTAINERS                 |   5 +
 drivers/usb/serial/Kconfig  |   9 +
 drivers/usb/serial/Makefile |   1 +
 drivers/usb/serial/ch348.c  | 739 ++++++++++++++++++++++++++++++++++++
 4 files changed, 754 insertions(+)
 create mode 100644 drivers/usb/serial/ch348.c

-- 
2.37.4

