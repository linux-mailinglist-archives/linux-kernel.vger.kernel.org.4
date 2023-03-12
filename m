Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32E66B6B60
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjCLUnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjCLUnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:43:19 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD68F3C784;
        Sun, 12 Mar 2023 13:42:48 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id p6so5843620pga.0;
        Sun, 12 Mar 2023 13:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678653768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfAHpBWoMxTHMa2AnmzhjkXruv6iv5Hi+uoFH6JuoB0=;
        b=SZk/mFJjL17EA59SAV1C7+KSi58oOlhcu2GkvfGdTdiqqIb3DBq/AztD3dErzqUrJf
         y8d5XUrwYtXXLBhhwAThzI8X+md14LexxS/wg0rAxp1YVX6f4H4A6xcLXAzo8yJEJv1w
         SWrtoyJwmxyYzsTv7stlyGlv8wZMVsxDWB1ESp1kFS8zDH7uFgAKJcdhbWgMMjEmOz8l
         5rcq6gS+xXIc72rvhVp1rwPKRttpyk9HnA9IcqxhOdTl9nwDK2FQJYjIaaAEKAVw2wC3
         /lIdVUWm6bwSmzWWp1WOwYRO7Xg2XZY4myIPs9bZ4ImHXhnePtBo9bNezGlhXN2vbCmf
         95MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678653768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfAHpBWoMxTHMa2AnmzhjkXruv6iv5Hi+uoFH6JuoB0=;
        b=dRnKlR4yALuPSgvt+9O+9eK5bIPFdH/mwR9rnde7RUn5wZk2HyOWATO7XIH2rMRWJK
         j2cNp6h3YvR0R55p5WzYKiiTbt4wg0EP3XPSHh5VG6+hmoezZUfnDTw0waq5NwkOGka0
         iElJ3rD/J5qg9RgpaowUo5+sQOF3An2o1+U1W3kyFvOIjG00xT64g/hQU+0e1Qf1RuAo
         SgUy60oOEMFczLbjZyovoeWZGXl7ZFofJCSqKR9wSYMhxNrh36e84yKnw8H/ddXvmfbU
         XBP9Hy7sltqvRqIq77uz/V9HjhlYgNdFFUo/IPOmFb0NwbC1HW4ZAtASKFBsSLsn3frb
         0/Tg==
X-Gm-Message-State: AO0yUKVA43oeQMyjChjThT+/+KJXr+/Py6K4WJi8nKFQQZW998Jq9KIC
        cpshneOrKYy0RkcHTD6rmJc=
X-Google-Smtp-Source: AK7set87ZVy65GE33Rw0XBiekKUgpOWPLY80uMY4DBKjyUe+sE5mUPtEy8WWl6cR7PYtGzTVSMaVJQ==
X-Received: by 2002:a62:1a17:0:b0:5d6:4847:1bd4 with SMTP id a23-20020a621a17000000b005d648471bd4mr26595681pfa.20.1678653768116;
        Sun, 12 Mar 2023 13:42:48 -0700 (PDT)
Received: from localhost ([2601:1c0:5080:d9fa:9b45:95de:f47d:f85e])
        by smtp.gmail.com with ESMTPSA id l1-20020a62be01000000b0058d8f23af26sm3048790pff.157.2023.03.12.13.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:42:47 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 11/13] soc: qcom: smd-rpm: Use GFP_ATOMIC in write path
Date:   Sun, 12 Mar 2023 13:41:39 -0700
Message-Id: <20230312204150.1353517-12-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312204150.1353517-1-robdclark@gmail.com>
References: <20230312204150.1353517-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Preparing for better lockdep annotations for things that happen in runpm
suspend/resume path vs shrinker/reclaim in the following patches, we
need to avoid allocations that can trigger reclaim in the icc_set_bw()
path.  In the RPMh case, rpmh_write_batch() already uses GFP_ATOMIC, so
it should be reasonable to use in the smd-rpm case as well.

Alternatively, 256bytes is small enough for a function that isn't called
recursively to allocate on-stack.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/soc/qcom/smd-rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index 7e3b6a7ea34c..478da981d9fb 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -113,7 +113,7 @@ int qcom_rpm_smd_write(struct qcom_smd_rpm *rpm,
 	if (WARN_ON(size >= 256))
 		return -EINVAL;
 
-	pkt = kmalloc(size, GFP_KERNEL);
+	pkt = kmalloc(size, GFP_ATOMIC);
 	if (!pkt)
 		return -ENOMEM;
 
-- 
2.39.2

