Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C352748FAD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGEV1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGEV1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:27:03 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F401980;
        Wed,  5 Jul 2023 14:27:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31441dfbf97so2343463f8f.1;
        Wed, 05 Jul 2023 14:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688592420; x=1691184420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=olSkp5XULjlmnBa7SpZh0QplgA0djzdnRtnuuGpp6wA=;
        b=NLuSX2FTIADLN7+dkb8Vwwe818Bz20GOXnq59XetMyVZXyKUQ1919z6O9OljWS9vdG
         Yt7B5XZm6omB3smJfUsVWU0V8ijmH4Lx8aRPG4XOZqsoYeQK5mhHsQr2iSAcD6uQRtHD
         VjuNnwMqJdr4sLoiA2pJqbVfgIuAUZ6zTcbffJUKEdiJQwt8iCfowCDasxzjsX1gDykI
         bAt/PovcxTrvz+DeDRTOeAu3CLaI0P6JjDcJ8JP+z0DsdjrqLQluAKh5dpL4ijFuy1F+
         4buCXBQfV9RLI1tFuLSbgkh5HLw2OhBcHo2TySaaC9S9129O6tCIfFnbFoIZFwgMIK5q
         G55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688592420; x=1691184420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olSkp5XULjlmnBa7SpZh0QplgA0djzdnRtnuuGpp6wA=;
        b=k/28I+sgrq2/asB8kdibxtrMZ4zMH/wamcHDt2r2aK8Ffs+68o8c75706igWtRVfd2
         7JGxX3XNRTP1WxkIdpbl2I+TUkE5+VpjhzU0jjSPPGA+80159pxO7Diega0q1bDBNjlj
         ILUpLEUj8+8xSfVg+fFBSUz4d0eDaIrv4DLzdJ3Doe7QUv0sdOxrwXD0mHunMoDQZoZ7
         EpefxQYWLYaSJIwjlasKLy8ey/2z2x1nGTmPbtPy4e3qd+evrqpwi/sNVfbcHIZac0GJ
         qbl1YMJizPfKZN2k9F7ZHQjPud7jLFbUnd+KZ7ScdobVdZ5Tj6FxVmI/xtdvTY0X/YNk
         8iOQ==
X-Gm-Message-State: ABy/qLYNK2r4eEWP9O4zkUcbf4zOzFkTYxleNKKvqYpogAlqCiG731+y
        P32cB4V1rYjA3KeomZ6G9yowAlztOR/HIw==
X-Google-Smtp-Source: APBJJlEwLu2fe4dShbzcVXct7CtYsMSsas/ZNPT/Iwdpv9DftIxt5uJNXnPq0hL//0ugTHy+7B5J2Q==
X-Received: by 2002:a5d:6190:0:b0:314:c2a:31c5 with SMTP id j16-20020a5d6190000000b003140c2a31c5mr15708678wru.19.1688592419760;
        Wed, 05 Jul 2023 14:26:59 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d6190000000b003143867d2ebsm30325wru.63.2023.07.05.14.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 14:26:59 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rich Felker <dalias@libc.org>, Stafford Horne <shorne@gmail.com>,
        Szabolcs Nagy <nsz@port70.net>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-openrisc@vger.kernel.org
Subject: [RFC PATCH v2] openrisc: Union fpcsr and oldmask in sigcontext to unbreak userspace ABI
Date:   Wed,  5 Jul 2023 22:26:45 +0100
Message-Id: <20230705212646.3618706-1-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 27267655c531 ("openrisc: Support floating point user api") I
inproperly added an entry to the struct sigcontext which caused an
unwanted to chagne to the userspace ABI.

Since oldmask was never used in OpenRISC we now use it's space for the
floating point fpcsr state.  We do this with a union to restore the ABI
back to the pre kernel v6.4 ABI and keep API compatibility.

This does mean if there is some code somewhere that is setting oldmask
in a userspace sighandler it would end up setting the floating point
register status, but I think it's unlikely as oldmask was never used
before.

Fixes: 27267655c531 ("openrisc: Support floating point user api")
Reported-by: Szabolcs Nagy <nsz@port70.net>
Closes: https://lore.kernel.org/openrisc/20230626213840.GA1236108@port70.net/
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Changes since v1:
 - Rather than revert the change, just use the oldmask slot for fpu state.

 arch/openrisc/include/uapi/asm/sigcontext.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/uapi/asm/sigcontext.h b/arch/openrisc/include/uapi/asm/sigcontext.h
index ca585e4af6b8..93817d7051aa 100644
--- a/arch/openrisc/include/uapi/asm/sigcontext.h
+++ b/arch/openrisc/include/uapi/asm/sigcontext.h
@@ -28,8 +28,10 @@
 
 struct sigcontext {
 	struct user_regs_struct regs;  /* needs to be first */
-	struct __or1k_fpu_state fpu;
-	unsigned long oldmask;
+	union {
+		struct __or1k_fpu_state fpu;
+		unsigned long oldmask;	/* unused */
+	};
 };
 
 #endif /* __ASM_OPENRISC_SIGCONTEXT_H */
-- 
2.39.1

