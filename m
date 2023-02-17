Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5B569AB5F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjBQMX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjBQMXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:23:25 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC5F66046;
        Fri, 17 Feb 2023 04:23:24 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d24so1356873lfs.8;
        Fri, 17 Feb 2023 04:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IJSfyz5KF1Ot3VlsJvshITzQvDrfzFSnqAesUwer2gU=;
        b=ntJt6vrD4KEHrdCLW4oOXb0eakY24ItcDskG4ZtZzyd5BCycQK+MGGrqixWtZbHV5h
         o9zTLysYZuphihYmCrTSe7bNf6Bfl70IscBzCObyQ4mx4UpMzFcpZTexI4HK/mH8UYQv
         wAXRNc6aw88eHyltyDOkMAnwD1794lXkGHc+t6jatC1neW6pWAsEOsmwzPldHTnPDklG
         BM30m5KRzqfAVQ4drF8kq4UH6MLEKViGW+A4HAPdCtGVwEd2V19zWc+FSucc94e1ye/f
         48yiyFNlkj9gdK45jQV5S7fM9llp6oBS0SgIeVo8aws9dxDG+DQAgQ8aE3iX1GMSq3SP
         SU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJSfyz5KF1Ot3VlsJvshITzQvDrfzFSnqAesUwer2gU=;
        b=Mh/xd7WmvRCChOegYS90dNuw9m/Xq0xemjPy1HgkdZuRR5zcPVJc83Fj4b3T/2l1Ew
         5SCcwjpE8pJJZ9WUCjLXKxNS6GaT/92WVvuyBojXLgKMW1GjtmuyeerO5fLQ6uGzGHhw
         z7Dl1es8iTOBd1fx4pHcD+RJBLSygOKdHXnaP6gAvHB60pf8FfoChb1BWiw9rkE4/eTP
         ukuQt0p8cXuHqZIxJc4i/cMu5wclRaPKw0f8kqwSFSdTM51xApGJzKEc8e5TM6IQ5SfN
         izV3PWvnZODhsmzhrFneyOK3l3ljLQ7+dU/ec6jOgCDYkMfJwB+ldc5acN0scxLDySb7
         tJew==
X-Gm-Message-State: AO0yUKXiEC0camv6+ZXd/3/JY5qLPbm83kfiqXA4HaYT6BMEo7u4n0Fd
        YIYW4PqQYbePbz6w6U9I+8Q=
X-Google-Smtp-Source: AK7set9CtCkbseU52YhyOb5qjscNZTQpQvMNYeTZ/BD0GuBrtzVD/KUHNMgHdxXroGe+3H1J6GPmog==
X-Received: by 2002:ac2:41ca:0:b0:4ca:94cc:a288 with SMTP id d10-20020ac241ca000000b004ca94cca288mr2086867lfi.27.1676636602116;
        Fri, 17 Feb 2023 04:23:22 -0800 (PST)
Received: from alsp.securitycode.ru ([2a02:2168:8bff:fb00:c81a:1ac1:84a6:458f])
        by smtp.googlemail.com with ESMTPSA id c20-20020ac25314000000b004db3e445f1fsm666961lfh.97.2023.02.17.04.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 04:23:21 -0800 (PST)
From:   Alexander Sapozhnikov <alsp705@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Alexander Sapozhnikov <alsp705@gmail.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] arch/x86/kernel/acpi/boot: fix buffer overflow on negative index in mp_config_acpi_gsi()
Date:   Fri, 17 Feb 2023 15:23:12 +0300
Message-Id: <20230217122314.11689-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexander Sapozhnikov <alsp705@gmail.com>
---
 arch/x86/kernel/acpi/boot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 907cc98b1938..abb78822f164 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -463,8 +463,10 @@ static void mp_config_acpi_gsi(struct device *dev, u32 gsi, int trigger,
 	mp_irq.srcbus = number;
 	mp_irq.srcbusirq = (((devfn >> 3) & 0x1f) << 2) | ((pin - 1) & 3);
 	ioapic = mp_find_ioapic(gsi);
-	mp_irq.dstapic = mpc_ioapic_id(ioapic);
-	mp_irq.dstirq = mp_find_ioapic_pin(ioapic, gsi);
+	if (ioapic >= 0) {
+		mp_irq.dstapic = mpc_ioapic_id(ioapic);
+		mp_irq.dstirq = mp_find_ioapic_pin(ioapic, gsi);
+	}
 
 	mp_save_irq(&mp_irq);
 #endif
-- 
2.34.1

