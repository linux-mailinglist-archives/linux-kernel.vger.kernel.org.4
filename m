Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C29660195
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 14:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjAFNxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 08:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjAFNxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:53:50 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4C8777F3
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 05:53:48 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r2so1323207wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 05:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4WNMsx5q6cRvPII41LbEPP4xqVdTisRzp480tWzGjdk=;
        b=KHT5msff5tEKeojSXkM0K6w3V8PAPFm7IMYeBwR6ETayrfQO/2+r1O9h4w+/frXhcg
         c9GcVdMYS+LExqtN/j5+uhsi9IyuCbxjc4Nj+yWh/+GJl77TUFo4cNMvMMWVXaltEOzd
         3odiiRn4wuC+uv167YAEeE8oSKHEvJ3qy9+MUCYh4IE/1k4od4+qXd8X8+8K4rBh5UfL
         AgoNtZruktlnYza7yDxZeHZOzZ+Odd9ig57t1kljMdOtzTG0zkN3paj3koYv0wfbQeHP
         O/O+ltlc/pP3LGBg5nokQf+eHQszlJBycYlXpcStaus42QsPpkfcqcH1zgGKE+I9Y9fx
         Vz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WNMsx5q6cRvPII41LbEPP4xqVdTisRzp480tWzGjdk=;
        b=rhipT0pJjZdVM+zWIyRnQZGVyeIJoRd79kQ8W/vi3MVDFTDjiM4OAD/tx2YCht5yq3
         6ALui1QfGKdfmqQPZrPOchb60+zId0KVN4cnMd6o8ijYBFE9qgoP8a8HtIaToZshnfXS
         v+wdGhPIXH90PIlKYv3/JnwyY8l0J55TAwB/FGQFgmGuPaATUgsp1MKlCOOF80jiKXZL
         k41mmn1OZbtJPlMEoBVxkD8ypOJG7JmumKWecsMqGtoktnfO/X82KJCoGiMU3sf6ITQ3
         GNXwEfWLuPMKpH5IARpCKfAu3RFk7TSvghZJyW7UW7or9947A4aCWv2zi2gkWBcDwc+b
         cq8g==
X-Gm-Message-State: AFqh2kr0CxbX4uJk3O50BvQbmAtnZIi2MTt9+Ydvbmx0NPZRpp3BakNB
        utwfddfRZiQqfkNzbAiPOuRnMA==
X-Google-Smtp-Source: AMrXdXsyM+9RmdZJ7yzacmsIWdZyXH+McvFTvkZxqAv6vY+2rEeM0PeH7jx7DxXNcuDx8N2rFH9hVw==
X-Received: by 2002:adf:ec87:0:b0:297:1b3e:7087 with SMTP id z7-20020adfec87000000b002971b3e7087mr12017251wrn.37.1673013226873;
        Fri, 06 Jan 2023 05:53:46 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id m7-20020adffe47000000b002b880b6ef19sm1191623wrs.66.2023.01.06.05.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 05:53:46 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 0/2] usb: serial: add support for CH348
Date:   Fri,  6 Jan 2023 13:53:36 +0000
Message-Id: <20230106135338.643951-1-clabbe@baylibre.com>
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

Changes since v3
- Fixed all reported problem from https://lore.kernel.org/lkml/Y5NDwEakGJbmB6+b@Red/T/#mb6234d0427cfdabf412190565e215995a41482dd
  Mostly reworked the endpoint mux to be the same than mx_uport

Changes since v4:
- The V4 was sent against stable and next have ch348_set_termios ktermios
  parameter const that I forgot to change


Corentin Labbe (2):
  usb: serial: add support for CH348
  usb: serial: add myself as maintainer of CH348

 MAINTAINERS                 |   5 +
 drivers/usb/serial/Kconfig  |   9 +
 drivers/usb/serial/Makefile |   1 +
 drivers/usb/serial/ch348.c  | 660 ++++++++++++++++++++++++++++++++++++
 4 files changed, 675 insertions(+)
 create mode 100644 drivers/usb/serial/ch348.c

-- 
2.38.2

