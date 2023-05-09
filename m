Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F576FD2CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjEIWuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEIWuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:50:09 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADA259E7
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:50:08 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-96622bca286so764806366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 15:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683672606; x=1686264606;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n+llcoQhZ1+xDIZc/YuxS/XX/JJ3BpLDZegnXpVRHmY=;
        b=bbnO2dbi7/8IFVyjRd+mQhfos5G1eY2qrDnpbIY3s5BSj1apkc6GYFQ7uECOGGjraM
         LeVOxg7YMUAsCMDHF2OI6W+JiDA1P1/5nh4Q0QGmK07KnFqNjG9HdzJygd8sEHdjqggZ
         zj9C2FT9KAy9jtDITUfFu0Ij8n2Nvp2ruOYfOwMcyl0rHkEG1sb/OdXhoJ5PBNClaVMD
         fDU38sRP0J7TcEcYnSfKG9ly+H8m2qy0KDmxCfKflzm67vFbcm99YJUrAHo5RtQj9HcB
         w/gEMAqxq8kfj7B8b1KHBkz3q2ym7TDlj38kavsBe5f4ekYFvmcsjNjYWDl/Yx4FQBG/
         lFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683672606; x=1686264606;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+llcoQhZ1+xDIZc/YuxS/XX/JJ3BpLDZegnXpVRHmY=;
        b=XxXrtuCIXeoOy07pgCl2HfiLIT/bII2oeebhyWotFHMXgpXXwVZcMhA/X81rVXSTzA
         n1wFVWBdFbyU2mXi/xs/ZR9GkPCO4dGGMMSfS7J6gHP3OFv/c8EbjtLj1E9Kz38LZN8g
         XZcPYIzh1JUXyDMBBhZzBFaP6N787WecLuX8qvCWQpNJwbB7F2BxHUaSSQPCItMAxfok
         hAkG4ZcXrcWxY2BHsg5lO1sxwGMQY0lLPgyxXyWaJa8CnuiUP2omOoT5mMI8yfi6wuEp
         eU0NYgzth/jCNiIkxmKMrdDemK1iD4XKuLgn1fh+Pdsz+yPwqqs1hrW2Rs+icI+WZPEA
         fISQ==
X-Gm-Message-State: AC+VfDxXe+RWY6Xvv3jintFMz3IaU49lwuPazVy8P2OMTlk+lcQOKsxl
        ixGGuEsXD3BXtb4EkrE5xJjts4A/OpTyig==
X-Google-Smtp-Source: ACHHUZ6++mkktW+wEOxVivZcjikll8FysQj2zK6AIDtG3LeOSIHijfQn5iSe/WLb9rWHrwnWYYkRSQ==
X-Received: by 2002:a17:907:5c5:b0:965:9edf:f0d0 with SMTP id wg5-20020a17090705c500b009659edff0d0mr12859533ejb.13.1683672606363;
        Tue, 09 May 2023 15:50:06 -0700 (PDT)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id p24-20020a1709065dd800b0094e93ec20adsm1875316ejv.106.2023.05.09.15.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 15:50:05 -0700 (PDT)
From:   Jakob Koschel <jkl820.git@gmail.com>
Date:   Wed, 10 May 2023 00:49:53 +0200
Subject: [PATCH v2] w1: Replace usage of found with dedicated list iterator
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v2-1-259bf1ba44ed@gmail.com>
X-B4-Tracking: v=1; b=H4sIABDOWmQC/x2OTQqDMBBGryJZdyA1WLBXKV1M4qQOaCIzUQvi3
 Ru7fDy+n8MoCZOaZ3MYoY2Vc6rQ3hoTRkwfAh4qm9a2zna2h/0OQsuEgWBVrD5HiHlNA+xcRij
 zAhNrAS4kWLLAhsLoJ4LQPVzvYrTO9ab2e1QCL5jCeC3MqDVyiUUo8vd/6vU+zx+gpqgrpAAAA
 A==
To:     Evgeniy Polyakov <zbr@ioremap.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jakob Koschel <jkl820.git@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683672605; l=2926;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=ArsdWSzl//HHaek54+hIwOznbov1JSj2WiaKVNSOxSQ=;
 b=JFegx2U1WFfpmiz6SsV55wQMbiLEfVPzJmvO3+PeLMBFBVCeGC2JymSZTHVQ2FjqemympYLAbsfE
 cGOeTyPcA1GhoTyff/GtPQ2k1YovsW+jSgm6jfBMnMpTMeGxJTtl
X-Developer-Key: i=jkl820.git@gmail.com; a=ed25519;
 pk=rcRpP90oZXet9udPj+2yOibfz31aYv8tpf0+ZYOQhyA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
Changes in v2:
  - fix checkpatch intentation issues

Note: I've changed my email address to contributions to
jkl820.git@gmail.com, I hope that's not an issue since the v1 was still
on my old email.
---
 drivers/w1/w1.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 9d199fed9628..c453160684e1 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -830,49 +830,47 @@ int w1_slave_detach(struct w1_slave *sl)
 
 struct w1_master *w1_search_master_id(u32 id)
 {
-	struct w1_master *dev;
-	int found = 0;
+	struct w1_master *dev = NULL, *iter;
 
 	mutex_lock(&w1_mlock);
-	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
-		if (dev->id == id) {
-			found = 1;
-			atomic_inc(&dev->refcnt);
+	list_for_each_entry(iter, &w1_masters, w1_master_entry) {
+		if (iter->id == id) {
+			dev = iter;
+			atomic_inc(&iter->refcnt);
 			break;
 		}
 	}
 	mutex_unlock(&w1_mlock);
 
-	return (found)?dev:NULL;
+	return dev;
 }
 
 struct w1_slave *w1_search_slave(struct w1_reg_num *id)
 {
 	struct w1_master *dev;
-	struct w1_slave *sl = NULL;
-	int found = 0;
+	struct w1_slave *sl = NULL, *iter;
 
 	mutex_lock(&w1_mlock);
 	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
 		mutex_lock(&dev->list_mutex);
-		list_for_each_entry(sl, &dev->slist, w1_slave_entry) {
-			if (sl->reg_num.family == id->family &&
-					sl->reg_num.id == id->id &&
-					sl->reg_num.crc == id->crc) {
-				found = 1;
+		list_for_each_entry(iter, &dev->slist, w1_slave_entry) {
+			if (iter->reg_num.family == id->family &&
+					iter->reg_num.id == id->id &&
+					iter->reg_num.crc == id->crc) {
+				sl = iter;
 				atomic_inc(&dev->refcnt);
-				atomic_inc(&sl->refcnt);
+				atomic_inc(&iter->refcnt);
 				break;
 			}
 		}
 		mutex_unlock(&dev->list_mutex);
 
-		if (found)
+		if (sl)
 			break;
 	}
 	mutex_unlock(&w1_mlock);
 
-	return (found)?sl:NULL;
+	return sl;
 }
 
 void w1_reconnect_slaves(struct w1_family *f, int attach)

---
base-commit: eeac8ede17557680855031c6f305ece2378af326
change-id: 20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-c56393ff0339

Best regards,
-- 
Jakob Koschel <jkl820.git@gmail.com>

