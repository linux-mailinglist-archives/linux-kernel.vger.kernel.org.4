Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FB863EDD6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiLAKbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiLAKbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:31:11 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048949FA98
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:31:05 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id b2so3108623eja.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 02:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbApf1anPXhkyL1eMhU3x4CauZkX++vBii8PykYLja0=;
        b=a5RWL8PSQEK0iO8D8xGt8NT2AQ4OV/qzxmaspNDbxZCSpoxCIuJ8vexkpLEXothzvJ
         nA46USR5g+fZ8RmhwNme1mUk4fTwlPRvZ2Vr7Fo0BIC8HQU3oBI/FlZ0rNvwDOQCd7Zg
         ILeFDzoCJG6yn45os/rNOFjn5OgcOcNC5aX3frAWSqtE5f9UDhvVajhtcQx3dm4I0x1l
         zUMnMfHWHhYshJ2WSdzjW031qTsDlclT4TP7Ujld7X1y9znWkqpND/WFjphv37tki6qf
         npw9YXacBh/EakMCf80tDIHdhe2tBdzdrvOBJjQN4RC7Tp9EH3iYeRyN/NbDlPEsq8Yh
         eG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NbApf1anPXhkyL1eMhU3x4CauZkX++vBii8PykYLja0=;
        b=CXjKDtTCTtPgafYniftbgLcpEcDbQDTf5cA8pQfqZmY3YXHgkbhCtE9l+sfPMMtwQl
         ToVMnVr/txKFG2AWUmsyIDkJgMaNiJUwddwCfzH+OOfdwYsCnph2uVbPnzxKbvhJxmnd
         Ejj/OcbWTYg5SC13f167avzIFDftcmAIq3eZLdjpQ6dm6NMNuPzruc1fhsptK5cPX4IG
         IezbbGZy6cFFXmc2T8li7i4wcdllsd8oOTqby/fvQ7p3x86HFfrw/zzO1GzkzCDW5meo
         83P4mgpQAQ0iJOmx63fB98QtxMAb3KQcj4XLvs6/Ukb1E3jFyUird0/xNEhehb+d4UAk
         /64g==
X-Gm-Message-State: ANoB5plgOaUTQlrAcuTQeTinhWVmnsHdCnE978ur9vhBwH5TfxeUQIKx
        UTui0I+QOqEHro50bVQAOd0=
X-Google-Smtp-Source: AA0mqf792BH1dkxj+elKYFKEKcD4i+q0VwaieVCNwc2KlVuSsd9a8B002/dcWUBiKX1TDLbx9Qr5UA==
X-Received: by 2002:a17:906:c18c:b0:7b2:8a6e:c569 with SMTP id g12-20020a170906c18c00b007b28a6ec569mr56271431ejz.582.1669890662588;
        Thu, 01 Dec 2022 02:31:02 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b007c07b23a79bsm1592400eja.213.2022.12.01.02.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:31:02 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE
        GPU IP),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU
        IP), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 6/7] drm/etnaviv: Warn when probing on NPUs
Date:   Thu,  1 Dec 2022 11:30:22 +0100
Message-Id: <20221201103026.53234-7-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201103026.53234-1-tomeu.vizoso@collabora.com>
References: <20221201103026.53234-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace is still not making full use of the hardware, so we don't know
yet if changes to the UAPI won't be needed. Warn about it.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 37018bc55810..3cbc82bbf8d4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -765,6 +765,10 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 		goto fail;
 	}
 
+	if (gpu->identity.nn_core_count > 0)
+		dev_warn(gpu->dev, "etnaviv has been instantiated on a NPU, "
+                                   "for which the UAPI is still experimental\n");
+
 	/* Exclude VG cores with FE2.0 */
 	if (gpu->identity.features & chipFeatures_PIPE_VG &&
 	    gpu->identity.features & chipFeatures_FE20) {
-- 
2.38.1

