Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ACC5F67C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiJFNXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiJFNW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:22:59 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C97A9277;
        Thu,  6 Oct 2022 06:22:58 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id m81so2013488oia.1;
        Thu, 06 Oct 2022 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dmvq8KIE/zpZSMh2g+NahhwyurlwxFIfoRR8ad0sVPs=;
        b=JJ+nNeKI0ZOFxYlUfd3f0Mxr0tfGkUB582syHapBEi6yb/d2om7T8rrGb7GFlyVS1w
         lImJdHdZulBPaX3JabDIRn1vLEp/0Dx9FzFc9TmyVI1wgCJDdUngqeHTHhkkenMgJaDQ
         I297SjxoJ3iOeR9QrTA4Ij7FgjzUhRYMhS/yYRePoFvJZ6vfqmqgJ83o9rcECwnl10J6
         EqVczBqdIqsrIu2piwpaGw2Df6GXygwAFFghBP2dIUzsEJ4YhlEFBceReg2+atw52a+q
         RLFPuVBfFB0x5kDBk8oQIcfQTals/oJl0OiUVIMYx2h/vlhwRd+klQV4uXSHH7zXTPiB
         9Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dmvq8KIE/zpZSMh2g+NahhwyurlwxFIfoRR8ad0sVPs=;
        b=TbeAiOi9PWALSz1LIRkvXJdPsMveHi532ez7bbm/8o7zryhS0XelLGd5xosRkkVTbM
         xoUs7YLNAxsWon3jEzNIhhzpaegnRfWG6r8/ox86wJ7ZEp0avupx63fuqqDMgQnw5Use
         radWtB8cnlvbi917q21ySOz7c6A+FLw2gPsoFOPnHuBlBkm+IeZprDnTZM8CRaPMtvvX
         KXq5fv2rE8Itz0FwWbr4az2TldGVDRfD7HaM7aP8o2p45s99asbNxo+TnOIOduSSAIci
         YPY25YsFIIYqJZyHzr+2QL4X/xybWhwVNUMrgfhddavU2GeaKBvDY68hLMBKnBjiY06N
         kE9A==
X-Gm-Message-State: ACrzQf1Uwp9gYs1axPhPXBhN0dS/QYcUt9fqvpe84n24CTyVY0WW1H47
        0czFH+mXqkpcu16VumhnsA8=
X-Google-Smtp-Source: AMsMyM64hY326AropxKvRAnkG37ZybxlGxZIuOJcyXrML4zdtT9KoK6ui8ZdXSpfr4i4d2gNr6H/rw==
X-Received: by 2002:a05:6808:2001:b0:353:ee38:4641 with SMTP id q1-20020a056808200100b00353ee384641mr4936114oiw.156.1665062578103;
        Thu, 06 Oct 2022 06:22:58 -0700 (PDT)
Received: from localhost.localdomain ([177.222.37.214])
        by smtp.googlemail.com with ESMTPSA id p13-20020a0568708a0d00b001326b043f37sm4741322oaq.36.2022.10.06.06.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:22:57 -0700 (PDT)
From:   Henry Castro <hcvcastro@gmail.com>
To:     thunderbird2k@gmail.com
Cc:     Henry Castro <hcvcastro@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drivers: hid: warn feature report 0x81
Date:   Thu,  6 Oct 2022 09:22:40 -0400
Message-Id: <20221006132240.3706-1-hcvcastro@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAEc3jaBiN_b_AJGugkYSwxF-ZWHzD6ib4r99tm9Z4RwN2=bgzw@mail.gmail.com>
References: <CAEc3jaBiN_b_AJGugkYSwxF-ZWHzD6ib4r99tm9Z4RwN2=bgzw@mail.gmail.com>
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

Unfortunately, my PS DualShock 4, does not support
the feature 0x81 to get the MAC address. Instead,
use a unique hash to fake a MAC address, so I can
use DS4 to play Retroarch :)

Signed-off-by: Henry Castro <hcvcastro@gmail.com>
---

>> I see in the other email. If it doesn't support this request, it is
>> likely a clone device. We are about to submit a brand new DS4 driver
>> (for hid-playstation). It will use a different report (0x12) if I
>> recall which does the same thing. That's the more mainstream one we
>> use.

I have 2 DualShock 4, I did not notice but I have one DS4 compatible
(clone, I guess).

The DS4 Sony -> returns -ETIMEDOUT
The DS4 clone -> returns -EPIPE

Look great the new DS4 driver :)



 drivers/hid/hid-sony.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 656caa07b25f..e3e9c58887cf 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2641,13 +2641,14 @@ static int sony_check_add(struct sony_sc *sc)
 				HID_REQ_GET_REPORT);

 		if (ret != DS4_FEATURE_REPORT_0x81_SIZE) {
-			hid_err(sc->hdev, "failed to retrieve feature report 0x81 with the DualShock 4 MAC address\n");
-			ret = ret < 0 ? ret : -EINVAL;
-			goto out_free;
+			uint32_t hash = full_name_hash(NULL, dev_name(&sc->hdev->dev),
+						       strlen(dev_name(&sc->hdev->dev)));
+			hid_warn(sc->hdev, "failed to retrieve feature report 0x81 with the DualShock 4 MAC address\n");
+			memcpy(sc->mac_address, &hash, sizeof(hash));
+		} else {
+			memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
 		}

-		memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
-
 		snprintf(sc->hdev->uniq, sizeof(sc->hdev->uniq),
 			 "%pMR", sc->mac_address);
 	} else if ((sc->quirks & SIXAXIS_CONTROLLER_USB) ||
--
2.20.1

