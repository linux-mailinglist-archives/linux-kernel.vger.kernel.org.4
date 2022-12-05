Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B952642F87
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiLER5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLER5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:57:53 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE71D12ABA;
        Mon,  5 Dec 2022 09:57:51 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id p18so5620633qkg.2;
        Mon, 05 Dec 2022 09:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7F0TLMUFiwR3iCnsvoeF7vGdv4a+JS2sxocOvhZdEjg=;
        b=Ni9TZbp61wZ/nJkqkWBATXcK110ZcuHrNa4AJ5A9L7yz/6gyxhIN500aDkuwRyRY9z
         Qz+UZguYSPmUxhqWHPG34lGIvHVN51Ss9wTTycAUVPUTEgTyF0lmjO2x+9JDHNriMKjp
         qgzOnylRG8MyJ2YyCKEujtHMu6LaEczexztyawRsl/nCMjmOnVS3+qWbNWLRoHbavZx/
         fsDpeRPW3bDhkfFDx2wwOcGKAYA7k2L8TJ1Qri37w31RlFmakw6BTPlYBpOMmgmlIJG8
         BtTNhDGTFDitf0277pxO8NwtHl8S3luOd5ry5w4RrfAuwB7+8K3QQtxMsDgpBPxc6gwB
         9hVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7F0TLMUFiwR3iCnsvoeF7vGdv4a+JS2sxocOvhZdEjg=;
        b=3E7hpaXjmhEhRtyTSOAjrJChYz6JJgADzvlqiZA3Zzw/y/HBM967ok2q4zbqS3V9an
         J5XpjKFumXkUJ4bDUJrVp8FjtcArUE5QkGMl5XOpUHHkgNGf0RjJOoOpY4EuJHsU8+AQ
         W0o0Gg0a+cnSoqCnC+62lM2ivkLpKZbrTRgs+RAKWefrpAqEMTDc6OE5JAgWanUmzQyv
         pG0IArMXmr8+Bw78xS1MXR4iNPiqriflJnwWd0WxS75ESW+brUgmYf/vfm/v2KJ65rDO
         XtH55Qslrvi2CwNS8OWSy0b4ESrf4Et8kNiBYcNkYiyXAPiABCdWM3z9kwR7zeEiW3DH
         zA8A==
X-Gm-Message-State: ANoB5pkLm5ekPmokRXz9qrXUsHbsO/lbKSKmbvUFrMDEekquAJQsVnPh
        2UEAxJv39xi8y9tCwtSEgABGHzvvmns=
X-Google-Smtp-Source: AA0mqf62l0FZyHcUjh2+T9ookFicFEYJCdwdxNB85dlw5UTB8EX82xmUZ2CKVcYajS5acJbRTE8Cyg==
X-Received: by 2002:a05:620a:13ab:b0:6fe:b81b:b34d with SMTP id m11-20020a05620a13ab00b006feb81bb34dmr5232347qki.670.1670263070796;
        Mon, 05 Dec 2022 09:57:50 -0800 (PST)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a430600b006fc5a1d9cd4sm12903721qko.34.2022.12.05.09.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:57:50 -0800 (PST)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kyle Meyer <kyle.meyer@hpe.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH] cpufreq: acpi: Only set boost MSRs on supported CPUs
Date:   Mon,  5 Dec 2022 11:57:44 -0600
Message-Id: <20221205175744.9746-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.31.1
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

Stop trying to set boost MSRs on CPUs that don't support boost.

This corrects a bug in the recent patch "Defer setting boost MSRs".

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index bb58175a8d40..a7c5e312340e 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -888,7 +888,8 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
 		pr_warn(FW_WARN "P-state 0 is not max freq\n");
 
-	set_boost(policy, acpi_cpufreq_driver.boost_enabled);
+	if (acpi_cpufreq_driver.set_boost)
+		set_boost(policy, acpi_cpufreq_driver.boost_enabled);
 
 	return result;
 
-- 
2.31.1

