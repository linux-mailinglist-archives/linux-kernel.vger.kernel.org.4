Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F95472422A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbjFFMbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbjFFMbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:31:34 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B1210C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:31:33 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fdae76f3aso5514511a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686054693; x=1688646693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiKvZSsDZj7fd26SGwfQBoXfS34tAdkyr70ERjpK1aY=;
        b=vCh2+X1hf0TIIqnpm/AYIkJaz2jT0HvZyY8bUB2wjkMlUlr67HtNsjAYxwsEYkOZyF
         XIKe8KpscCayq2BtwbDRSUyFEdCS9VpWkl9TFax2IjiA4Xos7Ta5bpj8bLVjYyY2adrI
         mcH0oCzttY2usSGHLG/a/QaOhO/+h+tXZW2fD167DVcqAKd6UORhX9O7p6MpHSQc316i
         zn/pzSjzsM1FQImlU4vIWgknepTFraqPz6u0xlEFtz4kpWzLgEYsvrtaHRKtxlDKyW0Z
         Kp0ZZVzkQtHUOSU2ztASWNFj+BM2oEa5ZaZpH2s3vesViYmVVSqovyPLxgkLfZQbDhTj
         Bmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686054693; x=1688646693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiKvZSsDZj7fd26SGwfQBoXfS34tAdkyr70ERjpK1aY=;
        b=KDsRME9dvj3e2WdYIFyGF4MHUYIcdyQjCJzki4bD+uveYORlNqhUg5Wc28b/2y7+nH
         ldwtWgj/Iu1swm5Pdfuj+cT2g8IoaXUj70gUnJxA5iL1sKKW5DEv2CP776yGxepfWcWC
         azZkogyjFw7jqCNfsCeeiiejqe3055zzMqUJ9f7FejnvS6kEogESBWAucHdhw2Fmf+lt
         vTfpJe/z3rBeQI40EEuRb8wBSZLCOGivIFlE2CP8T0gEa4ISRD2jMYAdnJ5KLGIP5MTM
         RkumuCJS/xGz0d79tW3/BP6IVwntoYjzNa1xZdiLDUh+Wze/G286LTwsGapiGorOuefl
         V4BA==
X-Gm-Message-State: AC+VfDwnH+s4s/w1XHrd0/d+GyP+/j67cVQJR70/qG9b6EUwVLwP4SVn
        BMmCBEs7999Gnqz5WAhD5O9/U5bPc8R93ra8Zg==
X-Google-Smtp-Source: ACHHUZ6q7kMWkvKwEjp12H3nPIO/0rtM06chnPUoE9/svFCtghq4ilDRKHYlyeO3lDycmF/ZYtA12w==
X-Received: by 2002:a17:902:d48f:b0:1ae:8892:7d27 with SMTP id c15-20020a170902d48f00b001ae88927d27mr2399759plg.42.1686054693195;
        Tue, 06 Jun 2023 05:31:33 -0700 (PDT)
Received: from localhost.localdomain ([117.202.186.178])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902c74500b001ae59169f05sm8446431plq.182.2023.06.06.05.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:31:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] MAINTAINERS: Add entry for MHI networking drivers under MHI bus
Date:   Tue,  6 Jun 2023 18:01:18 +0530
Message-Id: <20230606123119.57499-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606123119.57499-1-manivannan.sadhasivam@linaro.org>
References: <20230606123119.57499-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host MHI net driver was not listed earlier. So let's add both host and
endpoint MHI net drivers under MHI bus.

Cc: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 081eb65ef865..14d9e15ae360 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13632,6 +13632,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
 F:	Documentation/ABI/stable/sysfs-bus-mhi
 F:	Documentation/mhi/
 F:	drivers/bus/mhi/
+F:	drivers/net/mhi_*
 F:	include/linux/mhi.h
 
 MICROBLAZE ARCHITECTURE
-- 
2.25.1

