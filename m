Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24086693D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBMEyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBMEyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:05 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFC055BC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:04 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id i18so3869955pli.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDt2xtowm1vGovkYD2IOPyMg5XU+WITSemeLQt38+wk=;
        b=GCKt9FdzGzyUdkocjCliMYjgCOa0QLOjiBhttAdZOxargwxJw4vxLJDmHp57SYMfvU
         df4SL6t3EB6DwCr+yMREIqZPNA8lH1KY/NmjCtwPh7RiF2sS7CiZ+NVMmais/oNJuTRH
         oG9Xrug0dghHSuhHhbgxN9qJXDUVlSZvObtB30dIISrsnoeeYB0xZZ+8gPVYP3YKnZCO
         dt88KRAfl30IBpKYZCytTsdN/Ze3ePYzwWGTvqiW7lM1M2AfAWANpaxMxFedjYeFVoMB
         HvpyZQbKyRm57FGGHC2NuTZLmtqE8+b7eRudJLnJAgLJFszO3O7vTBEFeEwvQCyU/ukk
         guYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDt2xtowm1vGovkYD2IOPyMg5XU+WITSemeLQt38+wk=;
        b=csl00DskKcJwsXWIxB/+Xh+hgMSKC51CwlajrRn5zPGlWZIQt5yjWBZEnjLIC2K+4M
         EAmKTAbczKm7Sre2zX2Qy9/8VC7F/I2JASv7yNq0KBFUhmygiYZ9u+FVz3zBahxTgw38
         tmaMlUwcCFiPpWitYLKiI3K0RvBZlvLfTBKVUY2G0TlcTbplWTRIfV41hc/NlPmp3dtj
         c6Zat+xmQqsGwMYaICl+VXElkhL73p5yTMNsAqK2LIn6sJ8j3mFH5qI/dAkNo3NrIFeH
         gCNE5tsn16DtR0Dqe3iNwpQjfU++GNHUFXdZVPwf6OBAZVhdwd64zOEX2eFxdB4qAGmZ
         RUHw==
X-Gm-Message-State: AO0yUKWlS0Oq9bJkcPTIWLyaYr7zESMjSQ5q7oY77Xl5WQS/ZB7UyGMk
        q8/lGQAXI7kSvuom4h0ZPHrordl9hV9HAlaX
X-Google-Smtp-Source: AK7set9Y52bDpNDCM5e4MJvhFWuMbirMIwWV6jFT56ImTqva5KruRhYx1rh/voDp7RXfFbY6juKL1A==
X-Received: by 2002:a17:902:f809:b0:199:e58a:61c2 with SMTP id ix9-20020a170902f80900b00199e58a61c2mr13328153plb.29.1676264043302;
        Sun, 12 Feb 2023 20:54:03 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:02 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 01/20] sslp stubs: shadow stack and landing pad stubs
Date:   Sun, 12 Feb 2023 20:53:30 -0800
Message-Id: <20230213045351.3945824-2-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213045351.3945824-1-debug@rivosinc.com>
References: <20230213045351.3945824-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In absence of shadow stack config and landing pad instr config, stubs are
needed to indicate whether shadow stack & landing pad instr is supported.

In absence of config, these stubs return false (indicating no support)
In presence of config, an extern declaration is added and arch specific
implementation can choose to implement detection.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/processor.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/processor.h b/include/linux/processor.h
index dc78bdc7079a..228aa95a7cd7 100644
--- a/include/linux/processor.h
+++ b/include/linux/processor.h
@@ -59,4 +59,21 @@ do {								\
 
 #endif
 
+#ifndef CONFIG_USER_SHADOW_STACK
+static inline bool arch_supports_shadow_stack(void)
+{
+	return false;
+}
+#else
+extern bool arch_supports_shadow_stack(void);
+#endif
+
+#ifndef CONFIG_USER_INDIRECT_BR_LP
+static inline bool arch_supports_indirect_br_lp_instr(void)
+{
+	return false;
+}
+#else
+extern bool arch_supports_indirect_br_lp_instr(void);
+#endif
 #endif /* _LINUX_PROCESSOR_H */
-- 
2.25.1

