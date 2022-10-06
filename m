Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3465F6848
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiJFNge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiJFNga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:36:30 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B216AA3DC;
        Thu,  6 Oct 2022 06:36:29 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id g130so1995703oia.13;
        Thu, 06 Oct 2022 06:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLXPxZYLJ33P9YRMaUqNWZNwY4Oz87dKOXcoOCv55Dg=;
        b=G6T5Ttl7ZNwdME1gCPM3OZFNsthHEgOaB8eD2GTkklD6FlejW3OrrxlKV03ChVvYhL
         Z4gBrDiQgKlEBToHoruFEgVEekBmlWPKMK7qlVZUkT/WiJTS/yzPzbGOlfb7yQCp7IAg
         igEs37GHNFfjHUTE+x1+y63HhmSapFeiDt52jef8CPPz6E3ymYY/8LJ00K74+0hgw5Vr
         2gDXQ9DcPKyTSTsuqzg0KqQm5qkWyaRaoYI7/65QKjtsH+KDZU+1ML9dgqK8D8xLBS4B
         s9EIz84/KJVn4RqfaX6LE2TftEWWmkWwehTqNZknVoRE3KMnuI9zMrCqGbI5Q68VoLoB
         jjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLXPxZYLJ33P9YRMaUqNWZNwY4Oz87dKOXcoOCv55Dg=;
        b=uS8XDrxeRwBLl4KwCA577TKFbGCtE/LLtniGUwTiP7xx59ih89qBR+h9tuor/EoFkc
         WjsV0X8LRIufxF0GH3O3SF1qV5j7GEtbCn2S6OHOLoSjtb8gNFNmAYnvMGv53ifCUEqY
         5q1mwBT+KFWeBkaCET9qvcFMwwI4oVGI87JH4/VSyvvglhP7v1pE+VQkTddqH+6DUmxx
         iGDz7RCht/RQV1gQbFy71BPipzrRgIXhFbFYPHeHF0J2XJscBoVYFArSeuWh8HAAgy5A
         FLmGokATCDZYt2aRRegh2UkdaF/TYXGBeumsrAP1fZZ2nprQ0FG7qM2ILvcQFhATXJ+3
         1Oyg==
X-Gm-Message-State: ACrzQf1bJnCLrBhizgfWtUOONvbUBsXlCSqKCKV1sfIO02Y0yb+VZ1sB
        xs4VpvZsvr0N/mIMxIC0RwI=
X-Google-Smtp-Source: AMsMyM6EcixukxWzrQaXpJrqPqXt8odO87pvfGMhLYfHTuTZf/jO9L9z8/0mEIJS621E1vrjhwkKnA==
X-Received: by 2002:a05:6808:3010:b0:351:4ed2:cb27 with SMTP id ay16-20020a056808301000b003514ed2cb27mr5007872oib.109.1665063388339;
        Thu, 06 Oct 2022 06:36:28 -0700 (PDT)
Received: from localhost.localdomain ([177.222.37.214])
        by smtp.googlemail.com with ESMTPSA id l6-20020a056871068600b0011e37fb5493sm7051167oao.30.2022.10.06.06.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:36:27 -0700 (PDT)
From:   Henry Castro <hcvcastro@gmail.com>
To:     thunderbird2k@gmail.com
Cc:     Henry Castro <hcvcastro@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drivers: hid: adjust gyro calibration data
Date:   Thu,  6 Oct 2022 09:36:08 -0400
Message-Id: <20221006133609.3839-1-hcvcastro@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAEc3jaDLE1_+cCdL0nwUq-TPzBhoPmukGs527TokNN=iwqO5Hw@mail.gmail.com>
References: <CAEc3jaDLE1_+cCdL0nwUq-TPzBhoPmukGs527TokNN=iwqO5Hw@mail.gmail.com>
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

>> Hm, I'm not the biggest fan. Is this an official DS4 or a clone
>> device? It sounds like it is some type of clone (some look real).

Sorry it happens in my DS4 clone:

I have the log values:

gyro_pitch_plus = 8704
giro_pitch_minus = 8704

Then the division exception:

mult_frac(x, y, 0)



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

