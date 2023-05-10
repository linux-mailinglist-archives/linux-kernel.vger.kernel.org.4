Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3567E6FD797
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjEJG5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbjEJG5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:57:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E64EE0;
        Tue,  9 May 2023 23:57:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9659c5b14d8so1111797166b.3;
        Tue, 09 May 2023 23:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683701844; x=1686293844;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jib9CThn5oOIqaAcJUx1/VImgFdNgy0gBYxsFcrmZXs=;
        b=bg59xE8+0swNMVYMIiW0DA/awHofnNcumX43q3rNAScQxlCiA/VICFfIDjmZeMx8GA
         MWknhv7jQdtAGAMN81a9pJMa7/4wwth1v0KNwvIkX630ZqvZWWNhreAG9k1swvOjg4To
         dIHTU+pXib2bE9vTY+yH85PgB1JwBERjON1i1Al+/c4Tl1lg/LdkjUZGd46ZR5or0upv
         4+kYePP8oksf1Iz3m/GU/5AFRqQmQJVqi3iYD6QV84loTxZ86zPQl7hamSFJLZgFv/nI
         gmMTH/x0G1UVwgu55CUm0LF1yMqteAYe5J/3tla1qBdeancAjMJrvrqv2hEumC8W7IWR
         pJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683701844; x=1686293844;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jib9CThn5oOIqaAcJUx1/VImgFdNgy0gBYxsFcrmZXs=;
        b=PhdTuPoRSAZ374nzVH7qBY7/O6AaRG5GC9wPB2MA9jG0gXaSOnXBxpejm/6RdHj4hr
         QAqskorW2YrgJ93mrZx4lPKlF5gmLiVajiYY+NoCXoCN1COYK/1fYEAw30gbTJ64Zl29
         frw3/1go6junCcjQYW7CeCnFsTMA4geEZMC9a7XlPcH5AsB5RPrmktgZ9rWqpCDG9Fhk
         KbwQ/TDLGMuyYN36JgtVwfZ+5eKrrFZgZ3mQcTdPQCC023OSdVAKfEcilByWkZUiJaMv
         OtjP9FCfngZsMkQ1aoan2b/Z2S98DF43rxaixiHTUyJTB0bDH+zqWIAbhR9Nt9zGxuES
         QvCw==
X-Gm-Message-State: AC+VfDzlEdd8FdyatLBBES+80pY/A4vXP8igWiilIlnRniU9ugL+ZeAB
        PbNwt+6iYV5ZQeiOtAVeBdU=
X-Google-Smtp-Source: ACHHUZ6wJvH+M4Bo8bYTR+f6gf1sM7dLAdQefToVzoX3ed2I0Omxh5lat9h3tvPr1TVeQbN6cbJ3PA==
X-Received: by 2002:a17:906:fe09:b0:94f:61f5:9ef7 with SMTP id wy9-20020a170906fe0900b0094f61f59ef7mr14827353ejb.44.1683701843850;
        Tue, 09 May 2023 23:57:23 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:81b:847c:e4fd:f042])
        by smtp.gmail.com with ESMTPSA id ka11-20020a170907990b00b0096602a5ab25sm2274018ejc.92.2023.05.09.23.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 23:57:23 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/2] x86: make X86_FEATURE_NAMES non-configurable in prompt
Date:   Wed, 10 May 2023 08:57:12 +0200
Message-Id: <20230510065713.10996-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230510065713.10996-1-lukas.bulwahn@gmail.com>
References: <20230510065713.10996-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While discussing to change the visibility of X86_FEATURE_NAMES (see Link)
in order to remove CONFIG_EMBEDDED, Boris suggested to simply make the
X86_FEATURE_NAMES functionality unconditional.

As a first step, make X86_FEATURE_NAMES disappear in the config prompt. So,
as X86_FEATURE_NAMES defaults to yes, to disable it, one now needs to
modify the .config file before compiling the kernel.

If there are no complaints on this config after a grace period, we can then
further remove the config entirely.

Link: https://lore.kernel.org/all/20230509084007.24373-1-lukas.bulwahn@gmail.com/

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab123a8ee..a7db116e429a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -442,7 +442,7 @@ config SMP
 	  If you don't know what to do here, say N.
 
 config X86_FEATURE_NAMES
-	bool "Processor feature human-readable names" if EMBEDDED
+	bool
 	default y
 	help
 	  This option compiles in a table of x86 feature bits and corresponding
-- 
2.17.1

