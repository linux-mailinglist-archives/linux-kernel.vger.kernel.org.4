Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67536C7645
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCXDeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCXDeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:34:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBD612D;
        Thu, 23 Mar 2023 20:33:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c18so685765ple.11;
        Thu, 23 Mar 2023 20:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679628836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuNyNXqOE8MJi82Ss2jr4+2w7Bbh8bl4PPMM+ipEJZg=;
        b=QwKiPoPY2sBwX1qMThbCtcIkli32kb6pTnveqLIR6/FUR0CnPvXMpm6UQcwe8zw1iO
         tnNYj38tfYqF2OiaVC+QiDTBesRwi98uV3TOpG97R9vbUvGQ3XA9dxnSuWiyeNoHLDJV
         sSZ1ROXCtKhrzQvdQgjYOPmg8bLYwN8lPQPdXdVXubE1UO49L/uhwfp+YInwbJ2ta4Mv
         fCG+4HJt79P1HIo5PUqOBBUs/VHhzPwXO4lZlo1i6yfvh+YEGftqNROdR2RFy7l3S8qs
         ex+z565PIKVV/ObuQXItC/D5mAiO9JBuJK3nsQDDi7zpNcJI7vaRV4uNy4lrG3t04Qm9
         ErEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679628836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuNyNXqOE8MJi82Ss2jr4+2w7Bbh8bl4PPMM+ipEJZg=;
        b=dPZS7/uDOmmsPfTvC7nq5Uh6IBoEsSEUXSWMA5J2JEQYgs2WNyVEFvFeZuI72NG/Tk
         OPqYjoFZma9wPSh7xwvFpRwIRsEDW3rNUqkFMSXeJ3sryapKuD0dcA9pNRuv/e2shGKm
         +XRocuOHOiefDoMZeKocyu4XflmsNDlGx/8VVH4/RRoncyOqGjQy6qnjiI4rgZqX8kdR
         XZRyY8OhSgYq0p+uyyfM53PIt8EkXj4mN+IUVED6yuDYkaf5MOeRwIdrUgjyFYik6ElS
         l9EAHSFXQADkrLgQXkhqie8ZilnUSrQNQmTUEiIN8yGXBuyu3NC0p6AFJ78AdkBBzS/Y
         vUMA==
X-Gm-Message-State: AAQBX9dJvcU0RLcuxl90bp4xVZheG23twB2bFaCrY4TVaFqL1j+aRWsw
        Ut+EQACRwZrlYpCWAfxl1NQ=
X-Google-Smtp-Source: AKy350ZTjVR39b2Jkhn03bjHsLNpTlLtmn8tFDvpX8T0uDzXVOdf1btaAfwE3KcJr+IRUCEUIuI9Sg==
X-Received: by 2002:a17:902:e3cb:b0:19c:a866:6a76 with SMTP id r11-20020a170902e3cb00b0019ca8666a76mr908258ple.42.1679628836270;
        Thu, 23 Mar 2023 20:33:56 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f7cd00b0019d1f42b00csm13014101plw.17.2023.03.23.20.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 20:33:55 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, guoren@kernel.org, e.shatokhin@yadro.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH V8 1/4] riscv: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Date:   Fri, 24 Mar 2023 11:33:39 +0800
Message-Id: <20230324033342.3177979-2-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230324033342.3177979-1-suagrfillet@gmail.com>
References: <20230324033342.3177979-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RISC-V, -fpatchable-function-entry option is used to support
dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
don't have to be called to create the __mcount_loc section before
the vmlinux linking.

Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
Makefile not to run recordmcount.

Link: https://lore.kernel.org/linux-riscv/CAAYs2=j3Eak9vU6xbAw0zPuoh00rh8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
Link: https://lore.kernel.org/linux-riscv/Y4jtfrJt+%2FQ5nMOz@spud/
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c5e42cc37604..93d4817c9d73 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -56,6 +56,7 @@ config RISCV
 	select COMMON_CLK
 	select CPU_PM if CPU_IDLE
 	select EDAC_SUPPORT
+	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
-- 
2.20.1

