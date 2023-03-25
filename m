Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197336C8CB4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjCYIhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjCYIhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:37:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF29018B3D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:36:56 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d17so3860341wrb.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jq9FEnTj7FoMjw/gmnidJvZt7UB0t16wRzVKOg51PoU=;
        b=C63Ln4cbdBEFNaAtwZnNcK3wxmaH9YcpZlBQhu9BFowDQX4wPmVFaTXFVbDWSC95GS
         B+xgj6im0tCPY2KPNId1xDxggGn8KDT6NuW7HrNnovnoiAwFi13zV2zcr54g4Hidc6+e
         Y+v7NcW6ZxKGYT3cgSTWUF9eUO7MVrZlld0da4SGiCzJQ3HbKdBRtGvsLyafy+DstAfA
         fukfS99IOoZvf252KgsqjRKxARdBskv5Ql5UKUvFhgSn5u7M/a+zx/r41OTxOIrjZZE0
         /9AcQu1SUCnNij8FHBDeYQ+iTc1c3CoKb3g23/e4QXcHO6Vhm0nlJdTBWCQ5OFi/A5dU
         ixUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jq9FEnTj7FoMjw/gmnidJvZt7UB0t16wRzVKOg51PoU=;
        b=CnOEFzEpFdiy/PTEdwL+ydzHlQ5Kd/XWz1eRoH/WaxE8hBApJaQIXotur9d6uncpPD
         GZAnFOzrpr7zxdlVb7VF8fmUs3zlKAc46cdLXAnFZYpb0D3AZsoGAjIhnfEN8oIhqeSp
         z5UlO7hC6mWVzS1NfGOTkX248cKL4Q4YcUjZLIO3WMVnQJBo1fRFaX8mI1E5BYJhS54f
         lC6VPvOPporgWmQyGTn0ciGD8jsZMJzYDQ7b8zuKf0EOyK9C5gJZ9j/m6yDYokLYE8+O
         Oz8l4fWcoUHHNBdEebcKffhAq48sxTDDhMRKyqmoaT4rPJEE5QHjJRB2/q8Gz8qnIOPv
         Ts2w==
X-Gm-Message-State: AAQBX9e0q7/Rai2SvwiIZfXb3J4tLv6mlsOp6Nrx6fvCvw/2itDGAhHm
        eSoQOGE6/sJpuMkdMxM9LVs=
X-Google-Smtp-Source: AKy350YcjB+FqjbJ1ISjNYEgRniwUWZU5VaL6gKZI1bJIVjHEv5O1AEiuA8r8boXGibMdT9c6rNpFg==
X-Received: by 2002:a5d:6b8b:0:b0:2ce:ad08:ca4 with SMTP id n11-20020a5d6b8b000000b002cead080ca4mr4027591wrx.35.1679733415092;
        Sat, 25 Mar 2023 01:36:55 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d4d52000000b002d1e49cff35sm20108204wru.40.2023.03.25.01.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:36:54 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] ASoC: wm8903: implement DMIC support
Date:   Sat, 25 Mar 2023 10:36:43 +0200
Message-Id: <20230325083643.7575-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230325083643.7575-1-clamor95@gmail.com>
References: <20230325083643.7575-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DMIC input and routing.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF300T
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 sound/soc/codecs/wm8903.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 41346e5ec5ad..9c2f0aadcff3 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -9,7 +9,6 @@
  *
  * TODO:
  *  - TDM mode configuration.
- *  - Digital microphone support.
  */
 
 #include <linux/module.h>
@@ -816,6 +815,7 @@ SND_SOC_DAPM_INPUT("IN2L"),
 SND_SOC_DAPM_INPUT("IN2R"),
 SND_SOC_DAPM_INPUT("IN3L"),
 SND_SOC_DAPM_INPUT("IN3R"),
+SND_SOC_DAPM_INPUT("DMIC"),
 SND_SOC_DAPM_INPUT("DMICDAT"),
 
 SND_SOC_DAPM_OUTPUT("HPOUTL"),
@@ -996,6 +996,9 @@ static const struct snd_soc_dapm_route wm8903_intercon[] = {
 	{ "AIFTXL", NULL, "Left Capture Mux" },
 	{ "AIFTXR", NULL, "Right Capture Mux" },
 
+	{ "ADCL", NULL, "DMIC" },
+	{ "ADCR", NULL, "DMIC" },
+
 	{ "ADCL", NULL, "Left ADC Input" },
 	{ "ADCL", NULL, "CLK_DSP" },
 	{ "ADCR", NULL, "Right ADC Input" },
-- 
2.37.2

