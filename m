Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AC36717DF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjARJes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjARJZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:25:15 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1404FCF4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:50:36 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so888596wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKaTYBIcLeZ/0BySV/Ka7DaUt4SzdRu7Puu1gbLBN94=;
        b=lJVELh243+4LJskeUT2v48cfFzmLSZvOyuzmnR8tSrxvJ+m06Wr8+4vGoyf5ITF1A9
         lkNUM7Y06bp1HKT6ytBvVjqzsN2kP7cA6FIajCeBs/bQdGlI3gJdQn4HODnezSjxTm8F
         mF5FtyxOI4CWPMZXyns/zIT94nTYzMRwdACtr1p09nfUFyd+eO69lLIydoQZF2NQDkFm
         g4cNpf+qAbA/x9iFsLzc0XLIVTXeIJj1DlRyivboFb5p+Qe4XCOsoF7CDk+NqLhGJZt3
         WAqPpLdjkzcZAYXyW31dc8Q51cko/PTqMDuXojrLpenDq+dT5nAtmmTnCTTjajXQyfgR
         q7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKaTYBIcLeZ/0BySV/Ka7DaUt4SzdRu7Puu1gbLBN94=;
        b=nvUptNXwgkWL3iS42XCjNKUeSsBpNSQED4UQpwuzlMqnJUC4glraQHWFwApQ3UMXII
         PBAPkTugqM0uUSlMbYCa9WQDli9zP38o6bvbg3UJik62rivVc57xln17PQojR9tA7y9a
         q/X8fSAccubrL1LfTztHKuqjC3aWo+SoA2B2fBfkT5CxqOTmSJUq75mGM9TYNg21R+uE
         ZLWvFHmUe/j4IksYqh6JD9KJHTX1LxXjytxnMs0WO/bKYZqZOzKBOYBziX5PZwdEgcBi
         0vnl0W5Wvu2aX4B7h4zGm19Q8UhjLL12+1xASJQdTqlehRXfAIgnxoMn4bz+Gow4DpXG
         YFpg==
X-Gm-Message-State: AFqh2kpKBsakH+dY9HLj10OtNeIa8G3rckX+ow/42mBuRRjfHK2Tikbv
        F96AlbWQRx5edJY0V8M0TyjfhZVfFDVPqeUg
X-Google-Smtp-Source: AMrXdXuHHDK8oPbdhIuFO8i692RnT8txkS4Q2tWXqLNpsFmoRi/+flP1MT5csYq4wsvng0n3jt30xw==
X-Received: by 2002:a1c:f617:0:b0:3d2:191d:2420 with SMTP id w23-20020a1cf617000000b003d2191d2420mr5744758wmc.7.1674031835442;
        Wed, 18 Jan 2023 00:50:35 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ay22-20020a05600c1e1600b003dafbd859a6sm1272231wmb.43.2023.01.18.00.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:50:35 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 18 Jan 2023 09:50:31 +0100
Subject: [PATCH v3 2/2] arm64: defconfig: enable Visionox VTDR6130 DSI Panel driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-topic-sm8550-disp-defconfig-v3-2-11b558f7ff5d@linaro.org>
References: <20230110-topic-sm8550-disp-defconfig-v3-0-11b558f7ff5d@linaro.org>
In-Reply-To: <20230110-topic-sm8550-disp-defconfig-v3-0-11b558f7ff5d@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build the Visionox VTDR6130 DSI Panel driver as module

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9011e1438c0..7bbf628ab80c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -765,6 +765,7 @@ CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
+CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
 CONFIG_DRM_LONTIUM_LT8912B=m
 CONFIG_DRM_LONTIUM_LT9611=m
 CONFIG_DRM_LONTIUM_LT9611UXC=m

-- 
2.34.1
