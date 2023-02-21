Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1EE69E780
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjBUScc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBUSc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:32:28 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902D32F7A3;
        Tue, 21 Feb 2023 10:32:25 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cq23so20729285edb.1;
        Tue, 21 Feb 2023 10:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVgROdQULqVTm5cZsK90w6/mn8hCbHN5YbVIzDSMgeI=;
        b=XthLSfsJ3sDWeedA3vMFgH+nYyTWffN3ykvdKMIgZCII5Lp0jEbv1STD7zYnHiAXsu
         HbvRZ0JONBH3SVuVB+D0CU+OjLkg8WrvZOXAe8YXc7Xs3p4civ1HOb80g6Tv3mnRfP95
         9sDvNh3FXGQz+/yu7FB5/GsOZLhL+JO0XCqNK3uF8VLDnB+TJ8TX/6mn2YAqLu0HIxIX
         vr7d7tzQV75/NlCycYQmnXfYXZPj+dE/8KeQcg69mWpegtRdxTHv4Pr/act1AhAqOqY7
         cgGIryvz4WE5E7Q5hzUSNbz7aYTdhQBOuwDn4qbY+NnweeqjJBM0oFLTCbhT/5SFR52S
         VNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVgROdQULqVTm5cZsK90w6/mn8hCbHN5YbVIzDSMgeI=;
        b=8JxMBFfRsLKZ3IhFyDWYQ7u0Hg10P7KJvUAXQddzBxYwWRVkXCMSpED3Vpg2hpvbGF
         oB7OJOQdySaRtXl3VDtgLbD6tOMKzCkfIbffdle3Xfoq26Q6ulegSPXmQayihHQQuqTd
         Nky5bfUJbIBJovA+X5sDxQUmZp4ZTkq0rmA2u63rsUQh2XqM4hJpC5uY/6/1x4l40NJx
         WFIY3JHEFs1SbsKcT/w5dMW8yQQ1Mg/G78COGKzZN4+wNSXr2MemhKCq0ZLv/A4Hnj7W
         d8SZsHAP9INfG7HqDB2crCKs0i9VQ2wtAjPidwD3MHspc1cqsHu08Xk0eC/GkkSekyV+
         rLDA==
X-Gm-Message-State: AO0yUKUrgop5uOjVZNJkXv5xZv9G+sZnYbA7uFtJdWPabrSdxrIDNjUP
        PqXZ2CK73VZepmS+xUZIVnM=
X-Google-Smtp-Source: AK7set+jQ+9BvsQ5gp+9b4ZiiTcgH/+mt6qbyEDN5u7cOiJ5nhFbV8IA7F8K4+TrBiJSTmaG8DqX7Q==
X-Received: by 2002:a05:6402:406:b0:4ac:b8eb:e398 with SMTP id q6-20020a056402040600b004acb8ebe398mr4582455edv.6.1677004343982;
        Tue, 21 Feb 2023 10:32:23 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id i3-20020a50c3c3000000b004af5aa16fcasm169102edf.66.2023.02.21.10.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:32:23 -0800 (PST)
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
Subject: [PATCH v1 01/10] dt-bindings: sound: nvidia,tegra-audio-common: add new property
Date:   Tue, 21 Feb 2023 20:32:02 +0200
Message-Id: <20230221183211.21964-2-clamor95@gmail.com>
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

Add nvidia,coupled-mic-hp-det property to use Mic detect GPIO only
if HP GPIO is in active state.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/sound/nvidia,tegra-audio-common.yaml  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml
index 82801b4f46dd..7c1e9895ce85 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml
@@ -80,4 +80,8 @@ properties:
     type: boolean
     description: The Mic Jack represents state of the headset microphone pin
 
+  nvidia,coupled-mic-hp-det:
+    type: boolean
+    description: The Mic detect GPIO is viable only if HP detect GPIO is active
+
 additionalProperties: true
-- 
2.37.2

