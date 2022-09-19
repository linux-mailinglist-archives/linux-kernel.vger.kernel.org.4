Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFE35BCA84
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiISLQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiISLQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE4EFD1C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663586211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+Bz0UOQAJOXRrtdCnmyKdFMTMhYr8+15WKdruE59Rlc=;
        b=L9YGiNDSPdrtnbHPEmwLi07HgdqrQ5+jJ6wsB/03HVjG12/VccOPy4ENm6+GpjZuntSjXc
        TeO/gejrrn1d8UKZ28fAQfCls2EpsJ7wXuzZKTBTu33Nfbky59unMgeiRr5+FUDjkZ3T5w
        2aZnIVTHhPEGcac61TTJSCNJ+5aYpcM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-675-L9QZF5VHOiCAZm77Fewz7w-1; Mon, 19 Sep 2022 07:16:50 -0400
X-MC-Unique: L9QZF5VHOiCAZm77Fewz7w-1
Received: by mail-wm1-f72.google.com with SMTP id k38-20020a05600c1ca600b003b49a809168so4513217wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+Bz0UOQAJOXRrtdCnmyKdFMTMhYr8+15WKdruE59Rlc=;
        b=RjpD/FRlkXGOu8tNWHTTJSyFRlND95NfblNJY3fK/1MW1EPbe6XGl4eoVPfisLDvlp
         XyxegVb/ctNYKRARAGGb29tS7Eao8oXCmdmLVzHbGk3MoGot2JOM+plTSWxC2YzqVCSc
         Ue2xIioOaB0JBjvmDUoMDGonUbN4COFgtZHUbouFaYZSgL4PlpjEA+gmpm6eng+nNVgD
         2nPozOarAhbEsVZpGpAya5OlMbEM6prHXqff7oXn8mndOPqtcCniYCWezbCPUT8YkqO/
         w/wvTAw9uLu+9qJnclw89NN6XxYTXCJWFf/w2qvF9u3nn3WGIvERBJFMgbEw+bo1TB2e
         wBbw==
X-Gm-Message-State: ACrzQf2FQ1pJE0D2hCYMw/3Rb9+buv81oOKE9cBych5rKRuoDTnxIBvb
        0+Bv6tN4jE61PsRBzIqXJxdptKmHYfdlI5C6YlAvwFVeVxTiCQdJHw3SN6RM11RCkEGC/jYhAun
        UNZMoft0d6Eg3yUC9B27DwGVb
X-Received: by 2002:a5d:58f8:0:b0:22a:f284:496e with SMTP id f24-20020a5d58f8000000b0022af284496emr5928694wrd.501.1663586208789;
        Mon, 19 Sep 2022 04:16:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4+YoLASGIvhgO3CYh57x41pdBvHMpazmIJpNV+9J15jjkYoSQD4i/JuZFbP+vWbBIeHI/u/g==
X-Received: by 2002:a5d:58f8:0:b0:22a:f284:496e with SMTP id f24-20020a5d58f8000000b0022af284496emr5928681wrd.501.1663586208587;
        Mon, 19 Sep 2022 04:16:48 -0700 (PDT)
Received: from p1.Home ([2001:8a0:6724:4500:dc68:d331:1862:9fcb])
        by smtp.gmail.com with ESMTPSA id k21-20020adfb355000000b0022584c82c80sm13424911wrd.19.2022.09.19.04.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 04:16:47 -0700 (PDT)
From:   Eric Curtin <ecurtin@redhat.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Cc:     Eric Curtin <ecurtin@redhat.com>, linux-kernel@vger.kernel.org,
        Brian Masney <bmasney@redhat.com>, Al Stone <ahs3@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Joe Konno <joe.konno@intel.com>
Subject: [PATCH] ata: ahci: Enable/Disable ATA Staggered Spin-up by default
Date:   Mon, 19 Sep 2022 10:46:39 +0100
Message-Id: <20220919094635.184804-1-ecurtin@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some kernels tuned for performance, you want to always favour
spin-up time versus power draw. This adds the ability to always favour
spin-up time by default (disabling Staggered Spin-up favours
performance, rather than power draw).

Regardless of whether this is enabled or disabled the
libahci.ignore_sss option will override any kernel config.

Signed-off-by: Eric Curtin <ecurtin@redhat.com>
---
 drivers/ata/Kconfig   | 15 +++++++++++++++
 drivers/ata/libahci.c |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 1c9f4fb2595d..36b11fbcf644 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -67,6 +67,21 @@ config ATA_FORCE
 
 	  If unsure, say Y.
 
+config ATA_SSS
+        bool "Enable ATA Staggered Spin-up by default"
+        default y
+        help
+          This option denotes whether Staggered Spin-up capability on
+          storage controllers is used. Staggered Spin-up reduces
+          peak power draw, but decreases performance. If this config is
+          set to N, Staggered Spin-up capability will be ignored by
+          default.
+
+          This can be overridden by using the kernel argument
+          libahci.ignore_sss.
+
+          If unsure, say Y.
+
 config ATA_ACPI
 	bool "ATA ACPI Support"
 	depends on ACPI
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index cf8c7fd59ada..b7b573d47fda 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -33,7 +33,7 @@
 #include "libata.h"
 
 static int ahci_skip_host_reset;
-int ahci_ignore_sss;
+int ahci_ignore_sss = !IS_ENABLED(CONFIG_ATA_SSS);
 EXPORT_SYMBOL_GPL(ahci_ignore_sss);
 
 module_param_named(skip_host_reset, ahci_skip_host_reset, int, 0444);
-- 
2.37.3

