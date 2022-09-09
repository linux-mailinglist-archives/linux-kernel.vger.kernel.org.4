Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DC15B386B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiIINAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiIINAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:00:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B13D7F13A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:00:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l14so3787345eja.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=UibdPMF/OtInHGuz/UIlvSJ6nzqlq7xgDckEDL9fFwI=;
        b=U9d8OXPkAGSmrqn9TVzY3UpsVWxPOadGUPgoCDAzEkSfPzhi9dntYk9qCvR+xGTKPI
         WhcEQRjK4FwLGhmOpYT3gqgGWtB2m7rGT4MUZAgLbPS59EphdcHJekgLVCzi9TRXorrg
         pydeEiQGxH2IUJfoek/lMtASBT87/DR8Sf2HC5qfuahxnbFynZCV72dzg8d0uJWQuWHS
         WTDTRfCoeRMGERvMHm5FJm/SDYreRIhDnkxbGcBRTkcSCrPws8W2Ml/LSP97x67k/Lty
         5e8rpB1H7NLJnX8dBJ2zki+nKiTnQdxZY24j8mbYy33jimHfkQoQ0LjVcFuxQtm/yfqO
         gceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=UibdPMF/OtInHGuz/UIlvSJ6nzqlq7xgDckEDL9fFwI=;
        b=UGaXWgrKG9qFSQt5UmMuo9VXWZQNFy8RrbMVp2/cACvzAnGll7rvuRYgyyopuVQeSN
         6s6IJkuc75bjghwusY0UFBH+2XMmYZlMvKUM0zaUsMNKepuym7/C6L5p83UrcedkkSBV
         jwZUKOk5N1u2g+HGwGJ0nvlfaLsC00nfJBng98xpGGIkbKKlRdLOlYIZ0NWN3uWAwDkY
         T371uHQHdaecr4sZ6+v84zb8Yg0qVdPPr1qqc212Rn8dRNTWsKF+bXFD4pNR2VKNaiqm
         dzYEE2ClEyecci5y75vdKbtFfEnBAT7jSyYmRDQkwgoW3Zi4is0kOy36aMA0EnCwEGSa
         oAxg==
X-Gm-Message-State: ACgBeo12ZYQETAedN40c6SeYmqeOYyMl1Mxp0/lFBUwPeAuEYdVYdkyo
        TyakJo3kbOCL2s23U1ah63Mf+g==
X-Google-Smtp-Source: AA6agR6K70PkbbhwvQ4p3t1XAkp5aUuMV+Od8e3zHpyTXImV2+5GjOFqv/4MU6ikX+z/rqJnzumD4Q==
X-Received: by 2002:a17:907:9801:b0:742:1206:52b1 with SMTP id ji1-20020a170907980100b00742120652b1mr9989954ejc.61.1662728428935;
        Fri, 09 Sep 2022 06:00:28 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-088-153-019-247.um27.pools.vodafone-ip.de. [88.153.19.247])
        by smtp.gmail.com with ESMTPSA id kb8-20020a170907924800b00777d41ba812sm238636ejb.113.2022.09.09.06.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:00:28 -0700 (PDT)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: core: Prevent integer underflow
Date:   Fri,  9 Sep 2022 14:59:53 +0200
Message-Id: <20220909125954.577669-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using a ratio of delay to poll_enabled_time that is not integer
time_remaining underflows and does not exit the loop as expected.
As delay could be derived from DT and poll_enabled_time is defined
in the driver this can easily happen.

Use a signed iterator to make sure that the loop exits once
the remaining time is negative.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d3e8dc32832d..c3871565fd7d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2681,7 +2681,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 	 * return -ETIMEDOUT.
 	 */
 	if (rdev->desc->poll_enabled_time) {
-		unsigned int time_remaining = delay;
+		int time_remaining = delay;
 
 		while (time_remaining > 0) {
 			_regulator_delay_helper(rdev->desc->poll_enabled_time);
-- 
2.37.2

