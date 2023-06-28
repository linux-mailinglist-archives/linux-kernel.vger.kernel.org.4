Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7D2740EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjF1K3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjF1K0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:26:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350B630C7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 03:26:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-311099fac92so6973248f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 03:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687948000; x=1690540000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srR4qXI4SOaRzuTnNjTHD1luV6fZZPzoY3QYdalo8qI=;
        b=Y6Q+PawFy+kJaRdCZCPHXwMw9ZqLRbomAw6YgjOi9KVEfS/4P/HbDrP9ZhJRU6ywOe
         iPv0i8olWL0oVFvuiIRH981wrhd+0pzPMqEy0D0ZgBge/cjyeDZ73H6a0WW82n704GUS
         4Y+Wk0SCIcMFW7ghIYsQg9J15d+lSu6A4sqaWr3IocqBnd+WBewi6ZB7hEw7JCckIql5
         FB4i5VDkAG78WKb1JBJChHG/5jncfE8sX84cDYXoNG4syCvR7JTv6mmK4Japm2OWV8Qy
         wiiX9wGTj6mkM9Z74fzUTnghT2FI9trCV2M1LmWw3YvtarKYty56k+D3F+H0+NoLgpO5
         yY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687948000; x=1690540000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srR4qXI4SOaRzuTnNjTHD1luV6fZZPzoY3QYdalo8qI=;
        b=KcWfUB8C/WzX404S/KR14WYZjC3I4YSBumpRG5vApfChZPj7inz+BaB6aszHHujL7A
         K38Vh1TcddvKJ+zfB0EpUYfwdRHiX1GD8JB4rms26Kndq1u8EQTb67rTJpiNUfBRUgas
         DAK0CWd4fSa+298zD6pynP1gz4MnfB2pY6bAPfq200ZW6vo0Om2wSCMBSnp1hByyB7hq
         kpQ2s5WERhlK3CA7rAXZoNlaKc1TWczkn08+HexWor+55ZuxA/QFyLZVg7kSlGzfWUs7
         MSmYnrE/0mQHil4+qRiKWijGWPQWAdKFU3FfbqXewvpfdVt3oQJA1TaJgb8NTe9Pkjvu
         aXWQ==
X-Gm-Message-State: AC+VfDyG1yPFTl+SHuGX64f7ocpKrYC0QDnZ+OVSmRy2OgDzgJOz9ycr
        PqYVhtpD5t4BWistt2PT/1vDTg==
X-Google-Smtp-Source: ACHHUZ5S4H9zXhddpOXM9tKWiI2dGOx62qaeBcYbU97WH85fLsREvkzVPMEm3gY/9OG0jwyaeyA//w==
X-Received: by 2002:a5d:5307:0:b0:313:f60d:4958 with SMTP id e7-20020a5d5307000000b00313f60d4958mr5463674wrv.53.1687948000700;
        Wed, 28 Jun 2023 03:26:40 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d53ca000000b003140555c0ddsm2467780wrw.56.2023.06.28.03.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 03:26:40 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        broonie@kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sc8280xp-x13s: Add audio topology firmware path
Date:   Wed, 28 Jun 2023 11:26:21 +0100
Message-Id: <20230628102621.15016-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230628102621.15016-1-srinivas.kandagatla@linaro.org>
References: <20230628102621.15016-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio topology firmware name and path in dt so that we can
specify full path for it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 7cc3028440b6..0160b8e7d64f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -924,6 +924,11 @@
 	};
 };
 
+
+&q6apm {
+	firmware-name = "qcom/sc8280xp/LENOVO/21BX/audioreach-tplg.bin";
+};
+
 &qup0 {
 	status = "okay";
 };
-- 
2.21.0

