Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C765F6A0D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiJFOxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiJFOxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:53:31 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192733AE7F;
        Thu,  6 Oct 2022 07:53:31 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id q10so2293205oib.5;
        Thu, 06 Oct 2022 07:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bceuVvUJb3hxQm+ePCYNozIRIQ4HIe1CkvXUOasxSc0=;
        b=ajytUqcnVpUIiUJPqr1uzTxRaxwz5XNCnPPwoAaAnKc5WRxa0ddxKNLqEGX/xgqmxR
         CdtpHygUjmM3n+tI4HWfUMSy14R60990h3moPIHh16uI0GVMKIogpgbIwDmJpzhuQJfa
         oH+zMjwGk2q4yvBWg+Vw4xs2cNBjPULCgukKb4nUSgBGqQ3jnWvnH1pFTNQaCx43mxcd
         N2VIJbjoAqB7FGSVUkNv+qjRulpv3mcCl5xdHEfN2NMjd+TnpawsOrWEtlQjOlvQex81
         VukXbhmiFb7ZqJ7XpFzrT98lJ9xzYpURfynwvKnSD5K0i8GKae9Oubt0GDaxVy6nKjNP
         HlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bceuVvUJb3hxQm+ePCYNozIRIQ4HIe1CkvXUOasxSc0=;
        b=682bvo+ZFtBLdeO7bN9hRSiSrj+DffqC5Mg4eL+KCnx5u6Cgfvosb7lEpsrgcJp6t9
         Z97bRsFNByh+yrYUq50Oar5YzwDK2QszEzZYidYZzpEuKQiruKwRx+Kf6UwRopYwJuRx
         KfkGYQQB7/7VxmE9mmwC8mQ2j/JkxlnonVVWnP04WFdh9uqbY74Lm8P2IXPXraNsfL1N
         l3Ae7KkwV7rWL0d5ilkpYt8egY8XlCBGRqrsaAaw0tDcKZyjn+3GxbxiEjehORn15x0g
         djGC4yimThxTg6DNh8UM2zdfRYi1NHK7EA0Cfl/F3QK5wbJq4R0rsxGlU6IgzgOnmiH0
         6VcA==
X-Gm-Message-State: ACrzQf3EqSw2Quh/RSXn/Z1WQi4sVlkcbM/YjnK1Y/dhZl6b1IkoZHAn
        ucIal38HKC1VqblP0AWX73o=
X-Google-Smtp-Source: AMsMyM4FYx8zNYauOySDk4nZprtJkqeDzXfw2rrXyfqj+d3DfQl1T+jGjKriFSBGEN4lHVykPwKsFA==
X-Received: by 2002:a05:6808:2026:b0:34e:5c1c:77c5 with SMTP id q38-20020a056808202600b0034e5c1c77c5mr30175oiw.76.1665068010433;
        Thu, 06 Oct 2022 07:53:30 -0700 (PDT)
Received: from localhost.localdomain ([177.222.37.214])
        by smtp.googlemail.com with ESMTPSA id f18-20020a9d5f12000000b00659579f505fsm5618043oti.64.2022.10.06.07.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:53:30 -0700 (PDT)
From:   Henry Castro <hcvcastro@gmail.com>
To:     thunderbird2k@gmail.com
Cc:     Henry Castro <hcvcastro@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drivers: hid: warn feature report 0x81
Date:   Thu,  6 Oct 2022 10:53:08 -0400
Message-Id: <20221006145308.4393-1-hcvcastro@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAEc3jaCgEB5=3ATdaRXozMT3HrC1JeQVsY_HVF2VgY2oajzyow@mail.gmail.com>
References: <CAEc3jaCgEB5=3ATdaRXozMT3HrC1JeQVsY_HVF2VgY2oajzyow@mail.gmail.com>
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

> Just for reference if you want to try out if 0x12 works, you can try
> this code. This is from the new driver (ps_get_report is from
> hid-playstation, but you can just use one of the existing hid calls)
> if you wanted to try.

It works with my 2 DS4 =)


		if (sc->hdev->bus == BUS_USB) {
			buf = kzalloc(DS4_FEATURE_REPORT_PAIRING_INFO_SIZE, GFP_KERNEL);
			if (!buf)
				return -ENOMEM;

			ret = hid_hw_raw_request(sc->hdev, DS4_FEATURE_REPORT_PAIRING_INFO, buf,
						 DS4_FEATURE_REPORT_PAIRING_INFO_SIZE, HID_FEATURE_REPORT,
						 HID_REQ_GET_REPORT);
			if (ret != DS4_FEATURE_REPORT_PAIRING_INFO_SIZE) {
				hid_err(sc->hdev, "Failed to retrieve DualShock4 pairing info:%pe\n", ERR_PTR(ret));
				goto out_free;
			}

			memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));




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

