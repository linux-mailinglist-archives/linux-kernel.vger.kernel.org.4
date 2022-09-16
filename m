Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0855BA6E2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiIPGeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiIPGeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:34:19 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54652A2846
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:34:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b23so20294330pfp.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=0iLMF7VaNW67qSSdRMptbhIUY1ZQGrGNpN6qf2oppFk=;
        b=kMrmvPIaz9BpfbOBvrRRIXcHSglFVkeFDDq55eAExZUcyFNP3+O7UvMsIQFvBYV987
         KCxkGsia00O03QVxD9JvlyQlxcAAfj7Kky7By0ZNNB9/wV3DvwBIqcoX0GC7ws5RJ3TX
         f3vw1Er3D3PjCE6HdM8aMv9j8N2uElQeGGukt6GhhXmA/xxdzYJNCy6ec9znUN57dIL4
         rakGf6Mydh3s6WFsWce96+iFtPBJqpLKSwwZzCwD/DTE/LkqEwbt349I6o9PpZryA76C
         Qf3eYpAwdr/OdL54jJ/bOaw3QJP2AXlSOwSkmsTUeeixVA93bjPkKz09H0G8L/M1+LqO
         Se7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=0iLMF7VaNW67qSSdRMptbhIUY1ZQGrGNpN6qf2oppFk=;
        b=yiiFrqGOwUh4sfEewJB0AQ6IM1JQ+dlyv4v0rjnpPd1Y8gG1KasbfauuQa4F6gVveA
         Mv9A1Ch0ZvoSeyr8STXVLoW25AA9cEJQ+PBdRPFiJtxebBigItJOB0yjX9sC7mQCpOag
         3eNFoC0EhJ/Wf/mnMn6ILyJc/PfdC96G0YPQxBxfcZK4JhlrkF9Ypgaag8DzRZUTKqkZ
         4RvTbClXtFP+iHnsCnz4z2yNceJltS7ivKeAMkJrnZm31lMPRSBYnUnihL90qJ9ol1tf
         M06VpH9AE7fKDr+5FNa7ycOgewPmg3kjq/I64mYh19gaf985p4z/7xD20ZPcezZ5g07N
         obJA==
X-Gm-Message-State: ACrzQf217uP+JmS0O8PdNGcYreqPNBhfaxxs2/ojIT40UsU0ppJVyMjG
        8nnqL3KFK5niUUjRpIxNS+6qEzBrRiw=
X-Google-Smtp-Source: AMsMyM7t8mC2Js8PSfe54xaQa64qaLgz+TutwcaOCDr1bhv3ajadxQMWVzLjTJzbm/o/Vjf2REJLrA==
X-Received: by 2002:a63:8043:0:b0:434:fe8f:6cd0 with SMTP id j64-20020a638043000000b00434fe8f6cd0mr3230211pgd.115.1663310058883;
        Thu, 15 Sep 2022 23:34:18 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d3-20020a170903230300b00174abcb02d6sm14005774plh.235.2022.09.15.23.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 23:34:18 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] x86/hpet: use strscpy() is more robust and safer
Date:   Fri, 16 Sep 2022 06:34:14 +0000
Message-Id: <20220916063414.155695-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 arch/x86/kernel/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 71f336425e58..47ef8aecdd37 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -421,7 +421,7 @@ static void __init hpet_legacy_clockevent_register(struct hpet_channel *hc)
 	 * the IO_APIC has been initialized.
 	 */
 	hc->cpu = boot_cpu_data.cpu_index;
-	strncpy(hc->name, "hpet", sizeof(hc->name));
+	strscpy(hc->name, "hpet", sizeof(hc->name));
 	hpet_init_clockevent(hc, 50);
 
 	hc->evt.tick_resume	= hpet_clkevt_legacy_resume;
-- 
2.25.1
