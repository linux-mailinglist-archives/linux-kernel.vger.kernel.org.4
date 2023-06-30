Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6E1743568
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjF3G5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjF3G5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:57:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5211981
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:57:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5618857518dso13762807b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688108238; x=1690700238;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hZ3wBkz2pxdTUS9/OQCSJauqcYuxtthvA5zABIfqeJs=;
        b=IHjNBLE8spNRlxeSzalRRO2ui4YRHwmxXkc+ASamvdb9CHOxn8qwnSEiqN1+mF7C1I
         65kVXy93Ko1Y/lEMFdRR+ZIxNX1TFNkeG34Xnis5jg9d0hoEGdOt9w0AQpFne6mShjAt
         P9FoTr3D5bkGN6Uhsybdnl/wjbGlbKxkniTkommrQ3mcVrTVSFMiHagDwxm/jHimrFva
         ckJ8+CSVgcLaA4zwAlsciWEVoIriv+4cFbHcrbQq93D0DOSMm103Hzoifcvl27VqzRiD
         Be0R5gQEKHBb7geFzHl2ZWZAYHckPDF6oBtMfIumcSlc3pBItBFY2E7ChuQVw7A1CaTs
         Puqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688108238; x=1690700238;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hZ3wBkz2pxdTUS9/OQCSJauqcYuxtthvA5zABIfqeJs=;
        b=HtZWTzfexntmlE+LfIpq51hZtbMNaVQi9fEoXbDVBABM5gMuf/MoM99Izqz7ZVy508
         YU3MQB49aQRGlCzOqv3VxsnRwrORDbwYRV1utmP0qYKGQ09IzyNqPpWoyWDcduPwlDRE
         sCkWc0YuBlz8KNWaOLjFquCf6ngyPfJaKLwx0BrFB/mKfohqjNr4rVJHYx0VZX0kSay8
         B4OIfIzS7qHv8Mi+Avx4/NJ/t5QB40NMJyEk6e+sk83qBdwEbrktpehm1hvfQoeQW4VH
         ncDoL826EfXnXQKPNnTygar+VGzlmkoU7svFtIQELAqK078RJU+wLGWvZ5MeH0dsIGQd
         odiQ==
X-Gm-Message-State: ABy/qLZrjndUXvIlGuMiwxdsHRNGIUY/geba3Yl+hYIQzPzWzjOEAwA2
        r1FwH0w/MD9xlWH6JtTPAK09OTKdPms=
X-Google-Smtp-Source: APBJJlGQnXr8LdhGOtoxxO7nzmA+qzRWdfpj/MZ43yNUGq1KD/gmpUbEbaXsQjjANjBBl6atuvTUd8xkVKg=
X-Received: from hhhuuu.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:c80])
 (user=hhhuuu job=sendgmr) by 2002:a25:d158:0:b0:c42:6459:c45a with SMTP id
 i85-20020a25d158000000b00c426459c45amr2389ybg.12.1688108238655; Thu, 29 Jun
 2023 23:57:18 -0700 (PDT)
Date:   Fri, 30 Jun 2023 06:57:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630065711.801569-1-hhhuuu@google.com>
Subject: [PATCH] usb: typec: tcpm: Add IS_ERR_OR_NULL check for port->partner
From:   Jimmy Hu <hhhuuu@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     kyletso@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jimmy Hu <hhhuuu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

port->partner may be an error or NULL, so we must check it with
IS_ERR_OR_NULL() before dereferencing it.

Fixes: 5e1d4c49fbc8 ("usb: typec: tcpm: Determine common SVDM Version")
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 829d75ebab42..cd2590eead04 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1626,6 +1626,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 				break;
 
 			if (PD_VDO_SVDM_VER(p[0]) < svdm_version) {
+				if (IS_ERR_OR_NULL(port->partner))
+					break;
 				typec_partner_set_svdm_version(port->partner,
 							       PD_VDO_SVDM_VER(p[0]));
 				svdm_version = PD_VDO_SVDM_VER(p[0]);
-- 
2.41.0.255.g8b1d071c50-goog

