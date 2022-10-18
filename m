Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797C06023DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJRFlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJRFlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:41:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993449E2DF;
        Mon, 17 Oct 2022 22:41:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h2so5469980plb.2;
        Mon, 17 Oct 2022 22:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9NG3CBgcMhiqdPdVXVfFN0tafSKygxdY4MZpqU8ulL8=;
        b=QLcHi1gUfZaa/q2+yUxqZL2jA8pWuPlvSDT+67V72EZmsg5g8+XkKWJ1c7xsUNwz5y
         gXtwcdEmwzHxyrMUnsfe8X1LgcGDXVsDr88y+aVVhsro9/NAtasgg2If4YYEu9Q1XTlP
         FXytHzi3CwMIXxNDEs/c15cmSgNOnS9KnPjg+jSuJsgESciv3tfgBdM10fRfoRmNehRu
         /PaYZ7u9fO6P/7iaA5MLy4xlPl8SsK9pNRiZTt8EnK8PFTdsIBLPEgYcRZvqbj1/ei9t
         CF9U8mM0F+Pz0g+0bBwcRg6XYe8ZsXv3sw2+8z3gpl6BSZant2UqtrYEB+rUD2ex71zM
         CjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NG3CBgcMhiqdPdVXVfFN0tafSKygxdY4MZpqU8ulL8=;
        b=3hMymn0h+9q1GzYubpytCTSSKS7GIIIF9IHe7ru2yL/y1G4+PIRKRZzg/noU9I56Rv
         sM8ooP1ls1sVVzFcqk8UasUwa30ZiEsIkQnRfquRsN5hE12Yk89XaB6qGq6aUftdKB3d
         7mX3B5P+7LL5fp3iSZqsfVXQOnk/ZmzwYZQRaWZM1pOosmmmia1wo544dzjqTxAIZAoW
         kT0nde418C2i32uUNU0+wZB6je2HpxXKfmcuCnwwhAXJUM6nsqeGNqA9bMQary0bhlWx
         RRuF0l4dfv/oOLkNTNI2OKAFCYqRdc/wXt/KD3x8BJcqE8M8sVLrWg9QswiJc0b8ZYG3
         h8sw==
X-Gm-Message-State: ACrzQf00Zv7XD9AHpgblDHRNHMFl/DVkEOLTBnSJvvptB9VYozEGK+9+
        lpShljnxFvL8JGufz4CAwG4=
X-Google-Smtp-Source: AMsMyM7XHHf5Pyx6Gn8sMGSJArjz3NQyswzyQYRRuRVgwIvwKGu90zGY7HBHYd5RIvSrj/j6sjma1Q==
X-Received: by 2002:a17:90b:4ac5:b0:20a:de32:366b with SMTP id mh5-20020a17090b4ac500b0020ade32366bmr1625503pjb.197.1666071675818;
        Mon, 17 Oct 2022 22:41:15 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:f7bc:1bb5:e0b1:92cb])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709027e8700b00172f4835f53sm7597435pla.192.2022.10.17.22.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 22:41:14 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 00/10] gpiolib: more quirks to handle legacy names
Date:   Mon, 17 Oct 2022 22:41:01 -0700
Message-Id: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-5166b
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to converting several drivers to gpiod API, and to keep=0D
existing DTS working, this series adds additional quirks to locate=0D
gpio lines with legacy names.=0D
=0D
Additionally the quirk handling has been reworked (once again) to pull=0D
all simple renames (ones that do not involve change of indices or other=0D
complex manipulations) into a single quirk with a table containing=0D
transformations. This should make adding new quirks easier.=0D
When using legacy names gpiolib will emit a message to nudge users to=0D
update DTSes (when possible).=0D
=0D
Note that the last patch requires the following change from the OF tree:=0D
=0D
        88269151be67 ("of: base: make of_device_compatible_match() accept c=
onst device node")=0D
=0D
The change is also available in mainline - it has been merged in 6.1=0D
merge window.=0D
=0D
Thanks.=0D
=0D
To: Linus Walleij <linus.walleij@linaro.org>=0D
To: Bartosz Golaszewski <brgl@bgdev.pl>=0D
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=0D
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>=0D
Cc: Daniel Thompson <daniel.thompson@linaro.org>=0D
Cc: linux-gpio@vger.kernel.org=0D
Cc: linux-kernel@vger.kernel.org=0D
Cc: linux-arm-kernel@lists.infradead.org=0D
Cc: linux-mediatek@lists.infradead.org=0D
=0D
---=0D
Changes in v3:=0D
- added missed legacy compatible for UART variant of Marvell NFC controller=
=0D
- added naming quirk for MOXA ART RTC=0D
- Link to v2: https://lore.kernel.org/r/20221011-gpiolib-quirks-v2-0-73cb71=
76fd94@gmail.com=0D
=0D
Changes in v2:=0D
- fixed 'fsl,imx8mq-fec' & 'fsl,imx8qm-fec' compatibles issue noticed=0D
  by Alexander Stein=0D
- implemented Daniel Thompson's suggestion on tightening configs=0D
  selecting renaming quirks and added a comment to discourage adding=0D
  rename quirks without checks for specific compatible(s) =0D
- added a polarity quirk for Himax LCDs=0D
- collected reviewed-by tags=0D
- Link to v1: https://lore.kernel.org/r/20221011-gpiolib-quirks-v1-0-e01d9d=
3e7b29@gmail.com=0D
=0D
---=0D
Dmitry Torokhov (10):=0D
      gpiolib: of: add a quirk for legacy names in Mediatek mt2701-cs42448=
=0D
      gpiolib: of: consolidate simple renames into a single quirk=0D
      gpiolib: of: tighten selection of gpio renaming quirks=0D
      gpiolib: of: add quirk for locating reset lines with legacy bindings=
=0D
      gpiolib: of: add a quirk for reset line for Marvell NFC controller=0D
      gpiolib: of: add a quirk for reset line for Cirrus CS42L56 codec=0D
      gpiolib: of: add a quirk for legacy names in MOXA ART RTC=0D
      gpiolib: of: factor out code overriding gpio line polarity=0D
      gpiolib: of: add quirk for phy reset polarity for Freescale Ethernet=
=0D
      gpiolib: of: add a quirk for reset line polarity for Himax LCDs=0D
=0D
 drivers/gpio/gpiolib-of.c | 349 ++++++++++++++++++++++++++++++------------=
----=0D
 1 file changed, 227 insertions(+), 122 deletions(-)=0D
---=0D
base-commit: dca0a0385a4963145593ba417e1417af88a7c18d=0D
change-id: 20221011-gpiolib-quirks-d452ed31d24e=0D
=0D
-- =0D
Dmitry=0D
=0D
