Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5F65B61A1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 21:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiILT0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 15:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiILT0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:26:06 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2051512608;
        Mon, 12 Sep 2022 12:26:06 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-11e9a7135easo26083075fac.6;
        Mon, 12 Sep 2022 12:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=OwBDVbFQEw2EAV+CoYDVuZdyw9Sp+7B2pZqgX6wtMO8=;
        b=VoJ5UatIZjLOTKrOnCmk/Zs7UgHFZN1Z5iu17az8YvLSGUNJ5r0hATbF37tZf0OjHH
         5ZKToyVbZpsue0tm3aNPKtlC7U7ivv/8D94Lrtz0vCC/12ZlBjVdkrY+5Ybm/dH3VWmZ
         b2CNKTlvhrDtgVkP9oYfHMAIToEliZTHYbWq6w15tvcY5yM55L8gNOa63KY0UKyCZnFm
         InPZPsyFDTyxSMaCyaFhpxGhC+lWecgJJcL6nj5nCozXulS9vJZXFIMA26gGu2fR8jC2
         wFOuvzdwFq0/Cc6Hf2uI9mBJ2Gkyx0SXzniLjUc2llJMa+w6An0EUC+PxKXztfSTUPnq
         UECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=OwBDVbFQEw2EAV+CoYDVuZdyw9Sp+7B2pZqgX6wtMO8=;
        b=3lZQzbNTkA+/fRkTdoX7xBUxf7kyPAmJXeiXcv6nEZKfuIKSZgCpb8CRLUgmDwmTaP
         hZi1X303NxKDEVBiA+inKNkjKZk3h3lo6iBEBciQw44sF5ZhjNmBPFOaKaa/vmMda48o
         dQaqLfoiXQ3WCI7hm8yiCzfDMNElJKUWJjK+O8jgL6r6bmjdZIJElVnH5beLGF8GjF0p
         E8TJRzsrCE/aVb9sOpCX9K3MhqxDavtcHrQkfsBu3fASV50WDYCwxKy1J5K9Kx2kLUDo
         AdkrQrAF/Q9FMtOv1QdaLt+HhTI5eX0kZSYwpUaBeuQb+3K+yQTvVluQmbtr0aOaz5ET
         xCdw==
X-Gm-Message-State: ACgBeo0NM5J9y1Uv+iXmP4VNZGh7fKgUBvO5E28SCC1xJQFrGF4JsXGO
        awqNWsbqSQ+eaVURItvQLn0=
X-Google-Smtp-Source: AA6agR5hLdk4wV80PywGLbBBBLUDe6WFVwWLD7ei7ufpEjqgMbvwq6LB/oZJvWToQ283HEK1RjQQPw==
X-Received: by 2002:a05:6808:23cc:b0:34b:73b1:19e8 with SMTP id bq12-20020a05680823cc00b0034b73b119e8mr10207917oib.105.1663010765430;
        Mon, 12 Sep 2022 12:26:05 -0700 (PDT)
Received: from grumpy-vm.hsd1.tx.comcast.net ([2601:2c3:480:7390::465])
        by smtp.gmail.com with ESMTPSA id 5-20020a9d0d85000000b0063975d170a8sm5018208ots.7.2022.09.12.12.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 12:26:04 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, balalic.enver@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     markgross@kernel.org
Subject: [PATCH v2 1/1] hp-wmi: Setting thermal profile fails with 0x06
Date:   Mon, 12 Sep 2022 14:26:03 -0500
Message-Id: <20220912192603.4001-1-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error 0x06 (invalid command parameter) is reported by hp-wmi module
when reading the current thermal profile and then proceed to set it
back. The failing condition occurs in Linux NixOS after user
configures the thermal profile to ‘quiet mode’ in Windows.  Quiet Fan
Mode is supported in Windows but was not supported in hp-wmi module.

This fix adds support for PLATFORM_PROFILE_QUIET in hp-wmi module for
HP notebooks other than HP Omen series.  Quiet thermal profile is not
supported in HP Omen series notebooks.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next

Version 2 - Set bit (PROFILE_QUIET) only for non HP Omen Notebooks
Version 1 - Original patch
---
 drivers/platform/x86/hp-wmi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index bc7020e9df9e..9a64601e217f 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -177,7 +177,8 @@ enum hp_thermal_profile_omen_v1 {
 enum hp_thermal_profile {
 	HP_THERMAL_PROFILE_PERFORMANCE	= 0x00,
 	HP_THERMAL_PROFILE_DEFAULT		= 0x01,
-	HP_THERMAL_PROFILE_COOL			= 0x02
+	HP_THERMAL_PROFILE_COOL			= 0x02,
+	HP_THERMAL_PROFILE_QUIET		= 0x03,
 };
 
 #define IS_HWBLOCKED(x) ((x & HPWMI_POWER_FW_OR_HW) != HPWMI_POWER_FW_OR_HW)
@@ -1194,6 +1195,9 @@ static int hp_wmi_platform_profile_get(struct platform_profile_handler *pprof,
 	case HP_THERMAL_PROFILE_COOL:
 		*profile =  PLATFORM_PROFILE_COOL;
 		break;
+	case HP_THERMAL_PROFILE_QUIET:
+		*profile = PLATFORM_PROFILE_QUIET;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1216,6 +1220,10 @@ static int hp_wmi_platform_profile_set(struct platform_profile_handler *pprof,
 	case PLATFORM_PROFILE_COOL:
 		tp =  HP_THERMAL_PROFILE_COOL;
 		break;
+	case PLATFORM_PROFILE_QUIET:
+		tp = HP_THERMAL_PROFILE_QUIET;
+		break;
+
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1263,6 +1271,8 @@ static int thermal_profile_setup(void)
 
 		platform_profile_handler.profile_get = hp_wmi_platform_profile_get;
 		platform_profile_handler.profile_set = hp_wmi_platform_profile_set;
+
+		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
 	}
 
 	set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
-- 
2.34.1

