Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D5A5BFD41
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiIULrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiIULrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:47:00 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2CC90C5F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 04:46:41 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id p5so6609599ljc.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=m9+Zmy++ta7sMSatXKhKoM2rtE1PAA0b2u/bqTy/9Yo=;
        b=hY7GTvbSgNOU09X0DCba8ho6mZShPG9k3hNdmr2t1K3aOuagsPyICR6YM/Guhur5Zi
         Hxxspf+em6oL8GsG0v8hQh0lLBfv0/45h5GwU6B/38kmuhk0d4c7k0noV/IiWRI+vlBK
         1tVcjPW7Y1k575XuJStd/o/SranxSgOj3LT10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=m9+Zmy++ta7sMSatXKhKoM2rtE1PAA0b2u/bqTy/9Yo=;
        b=z6ogDYOssOeRjdfsitUDDiwZFXpY+NFDKrUjSaCMHnkMH9uB1dy4YxcGhTJ4WyyDnv
         PKa2qaG95QDpeLkBc02KaQ5VnUZGuzGrxr85pJzy7VbIFgBOWsJfosJUPn+EpEYEKOqc
         bFf4Ze66t7Xb+A88OkhG+e04axdjLxQ4S9HX6ynmxugprbpqDiVKjAWfKmetrRjGuH4G
         FLCVWMn+FIiijLIlqMoip9qu6kDwcA7avQpgPyPbyHKE1B+Dg6PVyE8P5d8X9fCXy+Xu
         w0jHlOkkMtT45o/RuylrSp2XTCLmuAPXgakiunn0E9qAzFOavcmXibMmoSrxl0BepxpJ
         mn6A==
X-Gm-Message-State: ACrzQf1a5kKcJPoaN3k1Ce4DM7wf0yb+nf0pHz2L1ulYv0xJLkzHrgd8
        XXZJTtBBsr5TU5459lPYkXA0bw==
X-Google-Smtp-Source: AMsMyM7qN5dEJxOUF9bSZZtyudDeKm4BTi/9npAp2ELjfLp7ivsmOvQQT71JKcXCUwyUhWVDNnU81A==
X-Received: by 2002:a2e:90da:0:b0:26c:8dc:3c52 with SMTP id o26-20020a2e90da000000b0026c08dc3c52mr8886029ljg.474.1663760799695;
        Wed, 21 Sep 2022 04:46:39 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b00494618889c0sm405713lfr.42.2022.09.21.04.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:46:39 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] rtc: isl12022: drop redundant write to HR register
Date:   Wed, 21 Sep 2022 13:46:22 +0200
Message-Id: <20220921114624.3250848-8-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's nothing in the data sheet that says writing to one of the time
keeping registers is necessary to start the RTC. It does so at the
stop condition of the i2c transfer setting the WRTC bit:

  Upon initialization or power-up, the WRTC must be set to "1" to
  enable the RTC. Upon the completion of a valid write (STOP), the RTC
  starts counting.

Moreover, even if such a write to one of the timekeeping registers was
necessary, that's exactly what we do anyway just below when we
actually write the given struct rtc_time to the device.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index df6d91f4e8f3..6fb13a5d17f1 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -171,20 +171,6 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 						 buf[0] | ISL12022_INT_WRTC);
 			if (ret)
 				return ret;
-
-			/* Write to any RTC register to start RTC, we use the
-			 * HR register, setting the MIL bit to use the 24 hour
-			 * format. */
-			ret = isl12022_read_regs(client, ISL12022_REG_HR,
-						 buf, 1);
-			if (ret)
-				return ret;
-
-			ret = isl12022_write_reg(client,
-						 ISL12022_REG_HR,
-						 buf[0] | ISL12022_HR_MIL);
-			if (ret)
-				return ret;
 		}
 
 		isl12022->write_enabled = true;
-- 
2.37.2

