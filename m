Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E416FF8F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbjEKRzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239020AbjEKRza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:55:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FD28687
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:54:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so1473859866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683827693; x=1686419693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWUkM7YNIz/qne/58Y7txSqq5Dsegg65dFtn1/ZBov0=;
        b=NnQxm3VUs5u45jP+g9SmyDYRELyxfT87OPA2PzDmnu8TidwO21XH2U805f1ygs1p2H
         RKFtNsKPzDZQCEpTU7NZM2VRK87OPOpcehrjU0Fn/+mcxsaFejQoQJzJO7uP4F9gUTR5
         3D/r1a8rDo4rvjtEIJ8M1a7bxNDGi2ZFEiq7tpvmKr+BgGX6IiyxfehvfVbiwrzkCVru
         86fsw4NoiluECssqJVajADt01aY2sy0uZjpBho6onFfyqBARxqPBSKTZc8zhmfKoS1ZW
         LuWvaJpLPKLk+P9zOyoq9LX16U9jo5qJaE5mhRhPmOtePVBN7Ob+FwASLFsz4F0Ons2r
         A5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683827693; x=1686419693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWUkM7YNIz/qne/58Y7txSqq5Dsegg65dFtn1/ZBov0=;
        b=HA1LLkUn1Ptnj1NCxTDixZKgzYwmMxJ5StQqs2FBK6KzI2fQxrDJU6VPB9h99GrWD9
         NqnYT0B1nGceoViLVEKLaKRvvnj4xw1rjcMk7DC+Em7WGyr/2p6h6T/N7GuQcFDm+E0Y
         M3GRme5oEs3JO8MObSAYQefHpwDVMIw0sxHEV8nPPQ+IdC9N5oRoHnm/f17J1YxxeUeS
         lmmE6njLPMctctKC71sNPDszgtBiqOt2iIxoSAFUG2Dcghjmc0A0KwkpY9EKGL+/UsV5
         l75zGuPEN8tuHM+t4z7Dg+AQBBG5f5Ok4fOG6WHAuIVa+7CeDNtyaMYIe5nnuOrQoOBb
         T8Ig==
X-Gm-Message-State: AC+VfDwZPzgrRL+pAic9bDkhybX/dcU/4qirdAoqmiT1mmno1ckE8MAW
        R+hu0hT4DGf96GUfbbNTcHqw9w==
X-Google-Smtp-Source: ACHHUZ531l/ZVfumbcnlWUdlQgEjKWChdfdtwVK9p3i8Ia+VznRyJkXQKBzxfKCpAXhA+OtXNM8FHQ==
X-Received: by 2002:a17:907:5c5:b0:95f:56e8:1c3c with SMTP id wg5-20020a17090705c500b0095f56e81c3cmr20269767ejb.17.1683827692748;
        Thu, 11 May 2023 10:54:52 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d7cd:1be6:f89d:7218])
        by smtp.gmail.com with ESMTPSA id j2-20020a170906410200b00965c076133esm4354527ejk.176.2023.05.11.10.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:54:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
Date:   Thu, 11 May 2023 19:54:51 +0200
Message-Id: <20230511175451.282096-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Statically allocated array of pointers to hwmon_channel_info can be made
const for safety.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/vdpa/solidrun/snet_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/solidrun/snet_hwmon.c b/drivers/vdpa/solidrun/snet_hwmon.c
index 42c87387a0f1..af531a339082 100644
--- a/drivers/vdpa/solidrun/snet_hwmon.c
+++ b/drivers/vdpa/solidrun/snet_hwmon.c
@@ -159,7 +159,7 @@ static const struct hwmon_ops snet_hwmon_ops = {
 	.read_string = snet_hwmon_read_string
 };
 
-static const struct hwmon_channel_info *snet_hwmon_info[] = {
+static const struct hwmon_channel_info * const snet_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL),
 	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL),
-- 
2.34.1

