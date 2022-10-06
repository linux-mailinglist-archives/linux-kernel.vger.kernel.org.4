Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AA85F6D88
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 20:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiJFSbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 14:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiJFSbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 14:31:33 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72396AA34D;
        Thu,  6 Oct 2022 11:31:32 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id m81so3008838oia.1;
        Thu, 06 Oct 2022 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLSUG+i+YfUxCARVJTD1GslXbH0UKN+cZHn6UsaYzBg=;
        b=fZg6klCgbal5S5LyLap7E1l92Ytg2/ipGvE3NNsX+Yydh61Jga0Ys2YMOo05+LwPAf
         8w24PXt5DIXI2SBkAa0tbMa82JRu3QhTrf/rECh2PP+q94awywDtvL1eUCfbHAQLM5cZ
         fnODJfbNZN+avjTlgrJhAhdbz2kLM/lPkA5gpZfHi1+uih0awjf+TDmeE9R4bTgnpgyv
         az5yKz/wp6qUVQq6CHa/dB6OsCbSvTz+wa0yfN31Teo/dt4SrTnZ0R2LtsaHJ1v1G3Fq
         x1z611IkW4QsoEg9uVd9B2nnR0YQ436LVBRgd558w9yeiYmNaqDeMuHQBm7/m5xPMuyv
         jMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLSUG+i+YfUxCARVJTD1GslXbH0UKN+cZHn6UsaYzBg=;
        b=NFNgg36lKUofLWVAOJrgOt0VY+a17kVfXo1OfHVG+5X5rhwC8mSiRUlt5kCzKRPk9b
         KEm3fXsh8ya88x6BeM5hNMxat5okYyIuVTSLO06ZzUwWHsM+D3rnUYKqJng5y/Tx1O/A
         TxxvVEtf5/17g2WDzOOg9iSGl2+u5rNANTh7qHFU+Jym4+VhjUSElyHie7ylIhLLKXum
         wY6JLBYUHOuSgd9hmkX95g8t4GB6oNkF9TIruh90n9tk/xS1ctG+0wHeipbhj94Snxc6
         fJPcuPk/9M1ytRASakvy4OgFPk74N8dFb/pIW4HxoSiYmfPgBLd6/mzHt0HavVc1JWoo
         l4ag==
X-Gm-Message-State: ACrzQf1D6xTUNwFl0qBFZpohdoeuX+zHnpAmANb7YB27ZpFGuAd4Y94Y
        J2nGQMxfLNUd8btXMR+aRLY=
X-Google-Smtp-Source: AMsMyM6/NVTZ+0fokMyhiCeou3tD8LlJk1ayumLAvEacbx/3wUtCkDP4gg2L2F03C7hL2qv7tdh3jg==
X-Received: by 2002:a05:6808:1448:b0:350:c8a5:3e7e with SMTP id x8-20020a056808144800b00350c8a53e7emr5767070oiv.234.1665081091752;
        Thu, 06 Oct 2022 11:31:31 -0700 (PDT)
Received: from localhost.localdomain ([177.222.37.214])
        by smtp.googlemail.com with ESMTPSA id 6-20020aca0506000000b003509cc4ad4esm6110429oif.39.2022.10.06.11.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 11:31:31 -0700 (PDT)
From:   Henry Castro <hcvcastro@gmail.com>
To:     thunderbird2k@gmail.com
Cc:     Henry Castro <hcvcastro@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drivers: hid: adjust gyro calibration data
Date:   Thu,  6 Oct 2022 14:31:05 -0400
Message-Id: <20221006183105.5416-1-hcvcastro@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAEc3jaALWiuHTxNz21k3d7f0BMYxCdK0qWmng=tu6w-prej7Jw@mail.gmail.com>
References: <CAEc3jaALWiuHTxNz21k3d7f0BMYxCdK0qWmng=tu6w-prej7Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason my DualShock 4 get the calibration
data values equal:

	gyro_pitch_plus == gyro_pitch_minus

Probably due to some defect in the DS4 hardware, and cause
a CPU division exception to crash the linux kernel.

At least with the patch, I can continue play Retroarch
without using the Gyroscope :)

Signed-off-by: Henry Castro <hcvcastro@gmail.com>
---

> Are it only these which are equal or are there are other funky ones?
> Are all constants in general the same? I'm just trying to figure out
> if some of this device would even need calibration.

More data logs:

gyro_pitch_plus=8704 giro_pitch_minus=8704
gyro_yaw_plus=8704 giro_yaw_minus=-8704
gyro_roll_plus=-8704 giro_roll_minus=-8704

Yes, They are constants values :( I


 drivers/hid/hid-sony.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 87b538656f64..656caa07b25f 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1823,6 +1823,15 @@ static int dualshock4_get_calibration_data(struct sony_sc *sc)
 	acc_z_plus       = get_unaligned_le16(&buf[31]);
 	acc_z_minus      = get_unaligned_le16(&buf[33]);

+	if (gyro_pitch_plus == gyro_pitch_minus)
+		gyro_pitch_minus *= -1;
+
+	if (gyro_yaw_plus == gyro_yaw_minus)
+		gyro_yaw_minus *= -1;
+
+	if (gyro_roll_plus == gyro_roll_minus)
+		gyro_roll_minus *= -1;
+
 	/* Set gyroscope calibration and normalization parameters.
 	 * Data values will be normalized to 1/DS4_GYRO_RES_PER_DEG_S degree/s.
 	 */
--
2.20.1

