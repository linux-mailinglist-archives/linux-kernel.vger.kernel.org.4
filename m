Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13AB5B376A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiIIMRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiIIMQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:16:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742F51451DC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:14:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d2so2437109wrn.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=kU3PArCQqxQipCIfucwesyNxkP/aJS3R0eM5cUNlEUA=;
        b=Ui/OmfngH60cOIrYZk95zbIeb/2CDhLAf86C5SETenp39ghQqRZG8qx+UR3Hc6R+nU
         WbPoYPqBmWyiCQA6peYymCZUDHoZZ9M0aQRX2rbmhWaCLgXrJJzi10EyhOHAfIKTC5oa
         B7yq4PgzU1xJ46WWob3oyz3oMsAhKT6ebysK7pl7dlHAQNK0/8zGIZ3TiU29Tu8Jaj/W
         VCOB236sZkEshou5uSxp5rhr/EOoBZTeF0L5eyDHKCzgDuzcu7+0LbVNHWuxqcjeJrJ+
         ShicXWNe/sBC1TVAKcJCXZaeXLpCTNrwMqsZnPbtG/A0wu+jrLhgGVUkk1CBmiJP+7dC
         ONVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kU3PArCQqxQipCIfucwesyNxkP/aJS3R0eM5cUNlEUA=;
        b=LmsDg1xtWbkAWDqbbQXsRvwlihkinN6+TYQCW6s9EJNk0sVRu0NqMPwtJkF3aJ8LDW
         MUzP41UlwRXb3mgAUULFTxGFcaOKzKnG6ha/H1OC0oa+uF2AfxSjtIisgQvYjVfJ/v+N
         Mcrhx4dKqPy8bJrVXZPzsNf9kzJ9bIAgEfhKkO7qcdcRooTMOf6kty8yFPsWfculGY7R
         6I3Be+mnsYhHCSlAPDtoF/bzoCLJKaBWie6BvDM967BQEA8/drPf47jwE/UznLPJ2euk
         n9QizTKPiSC5AEKsTda3vImWzVqwHIk9aOWxXZp5K4rg6oJjob+HUtjpPr7NBjRrOUUj
         vT1Q==
X-Gm-Message-State: ACgBeo2D7HWJ/m+KohlUEsI3d0QqrawRJ+9nTKgwXOSGTW8uWke9ImXL
        en2AbSbiz8r+nOkLGjKoS6Cj8Q==
X-Google-Smtp-Source: AA6agR7opbqPg1bHkUfjnVa9VnfIISVE6LHws7dw0+EJuCOY33VPET8FWL9UrGbpIzMCSAu0cP0ZYw==
X-Received: by 2002:adf:d1ef:0:b0:228:a9ee:8f13 with SMTP id g15-20020adfd1ef000000b00228a9ee8f13mr7523722wrd.686.1662725614654;
        Fri, 09 Sep 2022 05:13:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a421:c10c:c626:3f52])
        by smtp.gmail.com with ESMTPSA id l10-20020adfe58a000000b0022863395912sm379005wrm.53.2022.09.09.05.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:13:34 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/2] gpiolib: export the consumer's PID to user-space
Date:   Fri,  9 Sep 2022 14:13:27 +0200
Message-Id: <20220909121329.42004-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been asked several times independently over the course of last months
for a way to figure out the PID of the user-space process that's holding
a specific GPIO line. This does sound like a valid use-case as the user may
create a background process that requests some lines and then want to kill
it to release those lines.

These patches propose to extend the gpio_v2_line_info struct with the
consumer's PID which is set to the process ID for user-space consumers and
0 for kernel-space ones.

Bartosz Golaszewski (2):
  gpiolib: un-inline gpiod_request_user()
  gpiolib: cdev: export the consumer's PID

 drivers/gpio/gpiolib-cdev.c |  2 ++
 drivers/gpio/gpiolib.c      | 33 +++++++++++++++++++++++++++++----
 drivers/gpio/gpiolib.h      | 14 +++-----------
 include/uapi/linux/gpio.h   |  5 ++++-
 4 files changed, 38 insertions(+), 16 deletions(-)

-- 
2.34.1

