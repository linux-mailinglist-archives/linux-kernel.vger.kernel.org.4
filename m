Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC890681C45
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjA3VFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjA3VFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:05:03 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA734485BE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:04:37 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id o1so1171854ioo.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjEtYXJDp6iclp+CacIWVQrUALk4651QlhNhwW9psWc=;
        b=Y07MbFOYxOnlk9zeG1BJM4rCp26i7iCbS7OBlWQEB59AaW7LlF9gqKWobXisdIL/MV
         2z0Q5JOa6hTyJg+QkolsD0W55C9JqLU9nWv+2fEKslgqMOXfmvtgVA+kXUN+GhGG2nYS
         MUamAqiBDqbcmxTtAdjraAICTaftm2lJuYL/lhyfeWlQuNb80ePuX+amS6b/iF/S+Ofq
         KH6MJoZV+8GcO6Xu1GEGa/vYvJ0qxLzmSutUdk7ln/OWKQJ01H82hw89WHDN6ikQyIMl
         ofmaCQVYWXFqs0hqbwK7Qs2x7kB//XUlDIdzwVNwaQE79nAZQHRk9nJbNRM2lACSGu1S
         zOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjEtYXJDp6iclp+CacIWVQrUALk4651QlhNhwW9psWc=;
        b=w0lNhvX6tliH1yFZvPu8nlKjZfKknx6JX2ZIxWlZ3Ykj0bArnwUcKuM9Kk3qjI9scD
         1qk8+tGAE/aZIa/xHtvVXdl9eF3STp5c/u3o+LMbEpiY6f084IY5ZUlcwm6HS/fSC/2H
         9b3UcI3EazyQV98IMx2azKFwfNQMuM6vYugCGIYM9KsJJfktb1j/ylu9ni/Uq93brYnQ
         3YU6Wm4SvEkl2dnuWYKufpXoW2491wVMo3rLdB4JpUrRyanF4/Ft/Dx9MmevaM30PnUb
         SUdAbgZawA3+H2sVxW0TVI1r0jenhVRI6U2/pFvEAy0fsaoXWWoCPsMJFJLHT701H8uL
         BJ6w==
X-Gm-Message-State: AO0yUKWp/fiuq9SN0Oy5nt0Nqg4qrBjTvw0ANu94tIm39IdPTfZTb+QD
        Gx/+PDNjA7TWaR0pE6wvka8F3g==
X-Google-Smtp-Source: AK7set/4Zx2FyQuLsaWj/dxoL1fKfr2CII0LxRm/eqsY5DJPZKWVfrnBRrPd9S+HvrF30wvxH2DPXw==
X-Received: by 2002:a6b:fb16:0:b0:71a:1b72:5afc with SMTP id h22-20020a6bfb16000000b0071a1b725afcmr4556466iog.19.1675112673912;
        Mon, 30 Jan 2023 13:04:33 -0800 (PST)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id a30-20020a02735e000000b003aef8fded9asm1992046jae.127.2023.01.30.13.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:04:07 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 8/8] net: ipa: define two new memory regions
Date:   Mon, 30 Jan 2023 15:01:58 -0600
Message-Id: <20230130210158.4126129-9-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130210158.4126129-1-elder@linaro.org>
References: <20230130210158.4126129-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPA v5.0 uses two memory regions not previously used.  Define them
and treat them as valid only for IPA v5.0.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_mem.c | 8 +++++++-
 drivers/net/ipa/ipa_mem.h | 8 +++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_mem.c b/drivers/net/ipa/ipa_mem.c
index 9ec5af323f731..a07776e20cb0d 100644
--- a/drivers/net/ipa/ipa_mem.c
+++ b/drivers/net/ipa/ipa_mem.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2022 Linaro Ltd.
+ * Copyright (C) 2019-2023 Linaro Ltd.
  */
 
 #include <linux/types.h>
@@ -163,6 +163,12 @@ static bool ipa_mem_id_valid(struct ipa *ipa, enum ipa_mem_id mem_id)
 			return false;
 		break;
 
+	case IPA_MEM_AP_V4_FILTER:
+	case IPA_MEM_AP_V6_FILTER:
+		if (version != IPA_VERSION_5_0)
+			return false;
+		break;
+
 	case IPA_MEM_NAT_TABLE:
 	case IPA_MEM_STATS_FILTER_ROUTE:
 		if (version < IPA_VERSION_4_5)
diff --git a/drivers/net/ipa/ipa_mem.h b/drivers/net/ipa/ipa_mem.h
index 570bfdd99bffb..868e9c20e8c41 100644
--- a/drivers/net/ipa/ipa_mem.h
+++ b/drivers/net/ipa/ipa_mem.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2021 Linaro Ltd.
+ * Copyright (C) 2019-2023 Linaro Ltd.
  */
 #ifndef _IPA_MEM_H_
 #define _IPA_MEM_H_
@@ -62,13 +62,15 @@ enum ipa_mem_id {
 	IPA_MEM_PDN_CONFIG,		/* 0/2 canaries (IPA v4.0+) */
 	IPA_MEM_STATS_QUOTA_MODEM,	/* 2/4 canaries (IPA v4.0+) */
 	IPA_MEM_STATS_QUOTA_AP,		/* 0 canaries, optional (IPA v4.0+) */
-	IPA_MEM_STATS_TETHERING,	/* 0 canaries (IPA v4.0+) */
+	IPA_MEM_STATS_TETHERING,	/* 0 canaries, optional (IPA v4.0+) */
 	IPA_MEM_STATS_DROP,		/* 0 canaries, optional (IPA v4.0+) */
-	/* The next 5 filter and route statistics regions are optional */
+	/* The next 7 filter and route statistics regions are optional */
 	IPA_MEM_STATS_V4_FILTER,	/* 0 canaries (IPA v4.0-v4.2) */
 	IPA_MEM_STATS_V6_FILTER,	/* 0 canaries (IPA v4.0-v4.2) */
 	IPA_MEM_STATS_V4_ROUTE,		/* 0 canaries (IPA v4.0-v4.2) */
 	IPA_MEM_STATS_V6_ROUTE,		/* 0 canaries (IPA v4.0-v4.2) */
+	IPA_MEM_AP_V4_FILTER,		/* 2 canaries (IPA v5.0) */
+	IPA_MEM_AP_V6_FILTER,		/* 0 canaries (IPA v5.0) */
 	IPA_MEM_STATS_FILTER_ROUTE,	/* 0 canaries (IPA v4.5+) */
 	IPA_MEM_NAT_TABLE,		/* 4 canaries, optional (IPA v4.5+) */
 	IPA_MEM_END_MARKER,		/* 1 canary (not a real region) */
-- 
2.34.1

