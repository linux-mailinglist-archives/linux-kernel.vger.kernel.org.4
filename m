Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BAF6D6A62
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbjDDRWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbjDDRWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:22:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F7E19F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so133631384edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO2ovPp2g8BY9KhfdMQrBMTwegDXLLj5jKc/ptyrY30=;
        b=tjhO1KpfHhc+1lR2iyt1Hk/rwcxama/wjJ7OZ99SJ9iE5PvvnClZooJL0nqUXPFW4w
         8PzRygBzo62hR6aADvLBLh5zaUc9K6iHxsjI8GhSstvvF0Lj0mjG16K1nLIAgvpe3lCO
         IfvpySSB2i8q6tkhKqZxiq+I1G7MxQ6gEgFpY8mVOIr605DfgxdCPoHlgKjdf+DkmH7q
         m79NFghwh84Eqf8YGE3vMjyxAXLo15cRhi2jqwO8XbxtMGQwFbaEvZyF60IAZAT2Uukn
         Xy3tyVnLskveOBXY8K6of7oF+MzTS1kEAy6H9E5JdXU9fI0rQ5mTzNQBPzovDarbqu1z
         whUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HO2ovPp2g8BY9KhfdMQrBMTwegDXLLj5jKc/ptyrY30=;
        b=USrEdnfVryCHpGvwB0vFkv0xIkREjgCFdXTM6uIgQJAXcNOs5mHZjFfu/NY+AoVTb3
         740u/x2ta0+zU9eI2HhVzO5R63d/9n5l2YRzbleEMoZKCOg9Y2n3Q5s4Fkg5IKGNmywV
         ny3tQRAyNL2WzLI9eO0CIj7bZNJY3FVa1M8PdFrl1K1duY0GMTtGRPVBcGke2FXiMY0p
         yiK9RqsK4UEFfWtjX804BY8WPP47jcSoMmB3BIvV1vHlJq2LmhhSPF7dxVsN5fCjuk7L
         rB0AGO6wkGGyvN4qvSsMTo8KizsQmODnHxcNQCRVAIAGvOVQIETrmEo6I+iFR6p70aB7
         Z/ig==
X-Gm-Message-State: AAQBX9f0scbODw8tJCcR0K4eVl2uW6U7LqeVomX37D85LyrXWNvwvkLV
        xYGR9EJSP3uSVNwfdtCWcDZ+OQ==
X-Google-Smtp-Source: AKy350Y26vq43+a2Aqrtc3D+K5XSDWstIaaK2jDuDL/irBvuLfTWCLG7XAeAr7fcVbJqkjEUOP1U2w==
X-Received: by 2002:a17:906:f1d5:b0:870:d9a:9ebb with SMTP id gx21-20020a170906f1d500b008700d9a9ebbmr302300ejb.38.1680628944564;
        Tue, 04 Apr 2023 10:22:24 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Nick Alcock <nick.alcock@oracle.com>,
        Michal Simek <michal.simek@amd.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/40] nvmem: xilinx: zynqmp: make modular
Date:   Tue,  4 Apr 2023 18:21:11 +0100
Message-Id: <20230404172148.82422-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Alcock <nick.alcock@oracle.com>

This driver has a MODULE_LICENSE but is not tristate so cannot be
built as a module, unlike all its peers: make it modular to match.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Michal Simek <michal.simek@amd.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 6dec38805041..3b3832f4dfad 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -368,7 +368,7 @@ config NVMEM_VF610_OCOTP
 	  be called nvmem-vf610-ocotp.
 
 config NVMEM_ZYNQMP
-	bool "Xilinx ZYNQMP SoC nvmem firmware support"
+	tristate "Xilinx ZYNQMP SoC nvmem firmware support"
 	depends on ARCH_ZYNQMP
 	help
 	  This is a driver to access hardware related data like
-- 
2.25.1

