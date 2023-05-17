Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28EF706D50
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjEQPv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjEQPvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:51:03 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F147F93FD;
        Wed, 17 May 2023 08:50:45 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6ad13a1fbceso759522a34.2;
        Wed, 17 May 2023 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684338645; x=1686930645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9HhW1QPOz6WTxYOa6mD6gfn6R8qH8lALXUH8QmZoMg=;
        b=n5c9Ir11FEGWxrX9Spg8H5xlBdTR09lOx01uqFjr427nt0oZnDUEL72ungDwhT+sTW
         SAeOoO7gi9FAINmMrZAJJiAG21VuFDqiEzg3SV2phgBINF1OtRtqtiowvBzwj3F3APyU
         sSGI1EQDw9f3nyoIKmQoXWneqYDSzVwKOfame82qRWg1jpMP3X1UeOSoSDXnKoV30Ez/
         jU1D1alXVJqVGZJNw2AYrUn9uIHHNYHwUY+efpgwvNbl6hKq7JqLliDbo13rPgF89MUY
         w4w4V86JY4+7zedgqkGLUCJfQmGNdXhbitb5Jvmcb2xw6v471HuJQ8UTu7AN/BtTnBkH
         jmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684338645; x=1686930645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9HhW1QPOz6WTxYOa6mD6gfn6R8qH8lALXUH8QmZoMg=;
        b=N/RxhYa687t8nxrqirSzjZHv6hZ7j/VVaQiI/1huwR1BhO54b7OW2hZhEoJcRg/MtJ
         h1aQt2IjNhYFvV7CzhTqiZiyp/oB8O8VQ5L+VbqfdNnFzYCpXGX2shjjUq9+6uJgI4jt
         Tr2MCgeZtV/14iHsSWbK/y0jaBUDCKfjBi1/KRu7fqKK/HVPEL14zg2aMajToljhlYuz
         S/p7bnjOmKWUR/q20OKfs4pxy2FSp55FJbEhGPZ7rJEO6U/X4ob2/aazhDIz3+u4XDb1
         Wc3dGUyBLyA3k0xSS8Ix0Bw6l81E7m8rYaFI4eXdrRnefVIdxhSJY4lfZiV+RJPtQvQg
         f/5w==
X-Gm-Message-State: AC+VfDw9und7b0hB8j3J8Y/Fa953Kw1jjqB8Tw+Il2Jw2+BpvmnOZA+e
        pjuVcSriZLXd5qo6GwgtFQCEgr6zego=
X-Google-Smtp-Source: ACHHUZ5Fm2Y5z75+SEObXY7Sc7LD7OB9PYFbUesVRcZlRwLZYgJ6Zdz4et4d2phgT0D3+TXe9nknLg==
X-Received: by 2002:a05:6870:c382:b0:192:736c:ae28 with SMTP id g2-20020a056870c38200b00192736cae28mr20196567oao.58.1684338644942;
        Wed, 17 May 2023 08:50:44 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:3754:4771:3b5:e909])
        by smtp.gmail.com with ESMTPSA id j5-20020a056870a48500b0018b12e3a392sm14214468oal.42.2023.05.17.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:50:44 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v14 13/13] hp-bioscfg: MAINTAINERS
Date:   Wed, 17 May 2023 10:50:26 -0500
Message-Id: <20230517155026.28535-14-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517155026.28535-1-jorge.lopez2@hp.com>
References: <20230517155026.28535-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP BIOS Configuration driver purpose is to provide a driver supporting
the latest sysfs class firmware attributes framework allowing the user
to change BIOS settings and security solutions on HP Inc.’s commercial
notebooks.

Many features of HP Commercial notebooks can be managed using Windows
Management Instrumentation (WMI). WMI is an implementation of Web-Based
Enterprise Management (WBEM) that provides a standards-based interface
for changing and monitoring system settings. HP BIOSCFG driver provides
a native Linux solution and the exposed features facilitates the
migration to Linux environments.

The Linux security features to be provided in hp-bioscfg driver enables
managing the BIOS settings and security solutions via sysfs, a virtual
filesystem that can be used by user-mode applications. The new
documentation cover HP-specific firmware sysfs attributes such Secure
Platform Management and Sure Start. Each section provides security
feature description and identifies sysfs directories and files exposed
by the driver.

Many HP Commercial notebooks include a feature called Secure Platform
Management (SPM), which replaces older password-based BIOS settings
management with public key cryptography. PC secure product management
begins when a target system is provisioned with cryptographic keys
that are used to ensure the integrity of communications between system
management utilities and the BIOS.

HP Commercial notebooks have several BIOS settings that control its
behaviour and capabilities, many of which are related to security.
To prevent unauthorized changes to these settings, the system can
be configured to use a cryptographic signature-based authorization
string that the BIOS will use to verify authorization to modify the
setting.

Linux Security components are under development and not published yet.
The only linux component is the driver (hp bioscfg) at this time.
Other published security components are under Windows.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9af9ace0e348..648c986f5867 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9436,6 +9436,12 @@ S:	Obsolete
 W:	http://w1.fi/hostap-driver.html
 F:	drivers/net/wireless/intersil/hostap/
 
+HP BIOSCFG DRIVER
+M:	Jorge Lopez <jorge.lopez2@hp.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/hp/hp-bioscfg/
+
 HP COMPAQ TC1100 TABLET WMI EXTRAS DRIVER
 L:	platform-driver-x86@vger.kernel.org
 S:	Orphan
-- 
2.34.1

