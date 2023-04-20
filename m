Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE4F6E8FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbjDTKSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjDTKRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:17:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EEE559D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:16:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5055141a8fdso669724a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681985789; x=1684577789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeY19byibaKQU5SmsEhk5n4vvprUavR/0B7l0HzeYIU=;
        b=PtBULmQbRQK20LScpRHebHKUZ901DjN1+0eDl2Of/GBmLfksDulveUnoVXib8qy+uD
         QUe+Yb8aMFMzNSO1V+nHCMwhblZ/UApGmT/xVxec0sSS8yLQ3228EM2ky/wV2O6QTinR
         TbER1FHIeDgGvgB9Dpr62VcWaWGuk53+yeNTODNT1OH4iyNVPz6lswqcRoup8QuiJ7h9
         G+ydlD2RLMmNwpNDrzo7jy5U95KruGjzYVechUf+52Nypvhhag90S5KPva7I+4yr5maE
         zHmELbVNzxsf2OI5Q0g2dnKxKMG6T2PDh7Oz/jga08dkZdQFGAPqpSKSwKTmCzYf9sUv
         9KAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985789; x=1684577789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeY19byibaKQU5SmsEhk5n4vvprUavR/0B7l0HzeYIU=;
        b=jNmsySA1RQGl0liUJksPSNbrDFVRRtdmQwDY9Ql6re0aJrfkHhuTyI8Iqje2yB2d0h
         SCTA/SA6d7UFf8ZzJzB5n6h6vu9qhb8KNUe+DmoQLAdpMvQwJRiSVVRjdgVMOtXUnVqi
         eDWRbnXLKwlnUojjrIJH6bePhGGygc0n07TAvn0qC8b/o8yY8vw/q1LKxp7MXjZCoIha
         rQW31qKT78KRJUBTKN5oM6wFh3ngvp2DtfyrjqDbNlqV47M1PmOfWiYF2bRyGhgLEzb8
         7vEZoVywdE3xmWFKjDZHvDqBw1A2jXGqki0Lw9FpY8u6i2wgQJrfBQ6rfLtAi/n1eqae
         SwcQ==
X-Gm-Message-State: AAQBX9e17TMPE/No1Kk2PA2y3lnGgszfqzyDGoey9843kBqOrAiNMY+g
        5HjN3VuchOkVdXFwKw959Rs8zg==
X-Google-Smtp-Source: AKy350ab0FABnbmrq7aa1gl1X9x4VEUtxamldKuTt6enWYqiZCxTZKEHSXUbjkdPzuX8LK1YY94UYQ==
X-Received: by 2002:aa7:d5c1:0:b0:506:8470:c323 with SMTP id d1-20020aa7d5c1000000b005068470c323mr1381184eds.24.1681985789356;
        Thu, 20 Apr 2023 03:16:29 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id l22-20020aa7c3d6000000b00506be898998sm588954edr.29.2023.04.20.03.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:16:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Patrick Lai <quic_plai@quicinc.com>
Subject: [PATCH 5/6] soudnwire: master: protect concurrecnt check for bus->md
Date:   Thu, 20 Apr 2023 12:16:16 +0200
Message-Id: <20230420101617.142225-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
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

The Soundwire master controllers might want to check for bus->md
initialization to avoid race between early interrupt and finish of
sdw_bus_master_add()/sdw_master_device_add().  Such early interrupt can
happen if Soundwire devices are not powered off during their probe.

Add a store release barrier, so the Soundwire controllers can safely
check it in concurrent (e.g. in interrupt) way.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Patrick Lai <quic_plai@quicinc.com>
---
 drivers/soundwire/master.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
index 9b05c9e25ebe..d5bf13e7e602 100644
--- a/drivers/soundwire/master.c
+++ b/drivers/soundwire/master.c
@@ -161,7 +161,12 @@ int sdw_master_device_add(struct sdw_bus *bus, struct device *parent,
 	/* add shortcuts to improve code readability/compactness */
 	md->bus = bus;
 	bus->dev = &md->dev;
-	bus->md = md;
+	/*
+	 * Make sure the contents of md is stored before storing bus->md.
+	 * Paired with new slave attached and slave status interrupts
+	 * on the Soundwire master side.
+	 */
+	smp_store_release(&bus->md, md);
 
 	pm_runtime_set_autosuspend_delay(&bus->md->dev, SDW_MASTER_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&bus->md->dev);
-- 
2.34.1

