Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83126B50F4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCJTaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjCJTaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:30:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E949FE51
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678476567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y8l/CWBJuX1y5EPl4GX+elbQQ57+iHsuSsPv5DqoqZk=;
        b=e8wg4ByM4FkzFqFgeYQcOgQa7P8EmoCyaPvw+V3j3rJOBUnrjVgphDmB8zrw+sA6IyB4Md
        hnLrMmeq7N5ThJcuX2ZuSvMcKiSdyWWgqyDMUtTfb6ydyuKzCGveKr7oaT+X8rplOk8Lsc
        sFjiQUJUw+05r4h/GPtQsezoAQn+bns=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-LBimcXonOJuk-NO3r1vMLg-1; Fri, 10 Mar 2023 14:29:24 -0500
X-MC-Unique: LBimcXonOJuk-NO3r1vMLg-1
Received: by mail-qk1-f200.google.com with SMTP id s21-20020a05620a0bd500b0074234f33f24so3654728qki.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678476563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8l/CWBJuX1y5EPl4GX+elbQQ57+iHsuSsPv5DqoqZk=;
        b=LQpmx3PcUrDg074gFKWVIxjAvs+eV+AVfOAO6ySfjwPPAV4Pt4kpE+Sih7PqlwfTw8
         KL3bt4mhzQX58fViHfNNm4JZfhFFhP9o8nqMgu7pracBzXTM7HxQsotvcJVP0kt/PiEI
         4FfuOKUVUaq6NtmyvxCKCi/rzAfXPAwGthfou/avQMDv5x1mjWfltuB1GSasQu0+sZYV
         LTMgff4xcaMH62wf31VWkCaDerQwS5tqPK7xuJtGyOzV2GzpOXXUmYRCA0aiseWnNWNV
         nHSAcxz9ZVoux+SFP3YiYYHF0RJcqIeQf5Aav8jFSf4icLaLdcYQPhlWEVZdvr3JsWue
         2xOw==
X-Gm-Message-State: AO0yUKUKj6sVh3jvy89fdlj8EelGdafUkUqUtW6QRe3QApi4aAF1cQlz
        XPN6UD5VQPqmbkekn+fWE9RuYFss1N8gstINpjDSbEtHs0aP/apDR7xQXItZPscKvcUiTNsw37W
        9M+nGFnDDjOOthRHka6g6VvU6
X-Received: by 2002:a05:622a:1a86:b0:3bf:c355:9ad4 with SMTP id s6-20020a05622a1a8600b003bfc3559ad4mr45221384qtc.34.1678476563409;
        Fri, 10 Mar 2023 11:29:23 -0800 (PST)
X-Google-Smtp-Source: AK7set9p6QTglxUhaENPHKfFZq9rVgTHs0Xubm/clFXEHX2vfoItSR5lGlHnUyw4Q1N4ymCoUNJc7A==
X-Received: by 2002:a05:622a:1a86:b0:3bf:c355:9ad4 with SMTP id s6-20020a05622a1a8600b003bfc3559ad4mr45221362qtc.34.1678476563185;
        Fri, 10 Mar 2023 11:29:23 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w25-20020a05620a129900b0073b8512d2dbsm340236qki.72.2023.03.10.11.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 11:29:22 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] platform/x86: x86-android-tablets: select PMIC_OPREGION to resolve a link error of intel_soc_pmic_exec_mipi_pmic_seq_element
Date:   Fri, 10 Mar 2023 14:29:15 -0500
Message-Id: <20230310192915.2700069-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A rand config causes this link error
drivers/platform/x86/x86-android-tablets/lenovo.o: In function `lenovo_yt3_init':
lenovo.c:(.init.text+0x6c): undefined reference to `intel_soc_pmic_exec_mipi_pmic_seq_element'

The rand config has
CONFIG_X86_ANDROID_TABLETS=y
CONFIG_PMIC_OPREGION=n

PMIC_OPREGION should be selected to build the
intel_soc_pmic_exec_mipi_pmic_seq_element symbol.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/platform/x86/x86-android-tablets/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/x86-android-tablets/Kconfig b/drivers/platform/x86/x86-android-tablets/Kconfig
index 2b3daca5380b..65980229d783 100644
--- a/drivers/platform/x86/x86-android-tablets/Kconfig
+++ b/drivers/platform/x86/x86-android-tablets/Kconfig
@@ -6,6 +6,7 @@
 config X86_ANDROID_TABLETS
 	tristate "X86 Android tablet support"
 	depends on I2C && SPI && SERIAL_DEV_BUS && ACPI && EFI && GPIOLIB
+	select PMIC_OPREGION
 	help
 	  X86 tablets which ship with Android as (part of) the factory image
 	  typically have various problems with their DSDTs. The factory kernels
-- 
2.27.0

