Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D45E69E788
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjBUScf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBUSc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:32:29 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B12301B7;
        Tue, 21 Feb 2023 10:32:26 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id ee7so5924244edb.2;
        Tue, 21 Feb 2023 10:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAXecBgeRkHu8ZmrGSEh+xC8pZ8csJk/gLQuqMv+ZEI=;
        b=n5P5sUEHLppfy1KRySapcmLr3VmalIXip2527iBV1pCY+xwS8ywbsnb6vBwPteurfH
         Ou9heSahzhfGJVOnzPjla6C+JQo2VGd0yOCOpw4k/pjtCPDEpRrjpZLdpNF66Pi1DKH9
         WLP3xJQVbHYcEVJ7Wy9+73EuPBfWRbCokMg00ejhFAjQXjTyfePQrZKDmFkJzrRKuLnx
         e3M1VTGBwW93NFqHDNrX3XzJJqgBFJMitGzKukSDLzjuw8aKsmEHHiVsL6l5ARdcTx7Z
         NB5lKQ8K6GmD8sZRwzyMJ4RNTwnljCCDwYAzGsGxScbfzvJvZWnorpAYlZQpX1l6rhMw
         Ad/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAXecBgeRkHu8ZmrGSEh+xC8pZ8csJk/gLQuqMv+ZEI=;
        b=eEMkHVnlP+9/FwLPwFDhGRd+8cARCgDM/uj+nvUEO1gBsjYg4J2ArRluwsBwWT+tGC
         9M9QxZDrOXbkJ7vPytF1jx1nZIWkQ66J+spAyCW/SkvRFpKtMQU+xNksOexZvh7naf+I
         voF2GL14rDxoNUwKZl9hG53kavJWXlDJPmgKIiAKX2uOoAlvAoN6BPMY7KCoDi1CWFpv
         0YJXkSh3dJMQmU8rsYMwlf8oPBAAOPRT4hh1ETU7uoIue4fAWFZ2o104bJdew1wcEhb5
         2vqRw/uctoMe8PIScF91Duvfayow2dPbqv3VRxMkRbfvFRbtUE+kTVtmXMk9mhv0tuyh
         sV6g==
X-Gm-Message-State: AO0yUKVDV/km3+m3obeKLZnuszjmbeZDaeFcWSeZ8soyN0E2DPUA5EGs
        tOAwLbpjftDZV1nFV2LdUZQ=
X-Google-Smtp-Source: AK7set9zWlurnl/3CRZ7DTez58dz2jKnck1MAztIosG4p1jWNb1dZJz3bfbLFRpOyeGB3qiJQ4VlZQ==
X-Received: by 2002:aa7:ca56:0:b0:4ae:e5ab:46d7 with SMTP id j22-20020aa7ca56000000b004aee5ab46d7mr3752692edt.8.1677004345190;
        Tue, 21 Feb 2023 10:32:25 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id i3-20020a50c3c3000000b004af5aa16fcasm169102edf.66.2023.02.21.10.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:32:24 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v1 02/10] sound: soc: jack: allow multiple interrupt per gpio
Date:   Tue, 21 Feb 2023 20:32:03 +0200
Message-Id: <20230221183211.21964-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230221183211.21964-1-clamor95@gmail.com>
References: <20230221183211.21964-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This feature is required for coupled hp-mic quirk used
by some Nvidia Tegra 3 based devices work properly.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 sound/soc/soc-jack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index fcece5ca38c6..f951acb2ce36 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -367,6 +367,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 
 		ret = request_any_context_irq(gpiod_to_irq(gpios[i].desc),
 					      gpio_handler,
+					      IRQF_SHARED |
 					      IRQF_TRIGGER_RISING |
 					      IRQF_TRIGGER_FALLING,
 					      gpios[i].name,
-- 
2.37.2

