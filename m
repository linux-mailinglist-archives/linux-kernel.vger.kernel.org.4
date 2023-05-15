Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33007040AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbjEOWED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245738AbjEOWCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:02:48 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66941D84F;
        Mon, 15 May 2023 15:01:41 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-19638b3a304so5683392fac.1;
        Mon, 15 May 2023 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684188078; x=1686780078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpWRid5cmCr0SjsRhGTnuvLDk1kP0ktA07Mc2yuVwzg=;
        b=KX5Wwk39dk7wZPDt2tcIDMX9zGKkXhLZ1Coy+KoC9E5bKt616rANczIRC3fSnAPPWw
         7oiJT+k9dXyXUj9HwcfLL8fhYt1j9HE6AtMzvgLWQ7qJ9btwqnDtpKZsL1bgJa3s9EQ7
         F+XYtXq1kgSBzGFq+LryNe0eoLY/Jghyy6svaPQXICkZ5F1iM0Vr2mqdq7BBvRWwsFjR
         hwcYCzPDz5TosHeaFlO8m/DEGsYWYgJql6ua0rtf+DVQ/Z471fc1mPys0ufBla6WM6o4
         5F7JS8JNIMsbd3lF+JG6INiBxoq3hGQ9jvvt3EmMd4vaBR7qpW1L/aS8DbJdSTAl0KEd
         w4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684188078; x=1686780078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpWRid5cmCr0SjsRhGTnuvLDk1kP0ktA07Mc2yuVwzg=;
        b=FOYenMReICu7W+8vf7gP1mo7WZwKDpI1P5Jl++PmqYYP+hOmD/pCIS8HLQ45QBdGrc
         rMjCR7uNR494K6DJTI3cbjBObB1b+EHkyz5qTlPa+OmEGzmLz2X+c5dRvwsUUEYsvqnS
         lzF2TWYBjiaX8dW3HuITQ+LQ0ZIzD0a4tMjFSClu1U9v2xMxdYkVVe7jBvhXsq8l48cc
         RBQ25odvaOyE8jDT5t+7Wr+5nLFBP8+3/EOse4bOwo+2sUF3LfVfnIn/QSuWMo6Tt9d0
         L9kK3tO30hVxwGalD1YepokgDMtmNTNXLIcXdm4vkL45V4prV8f0WWZxdlEF+W1D8XJ1
         Cc5g==
X-Gm-Message-State: AC+VfDyYv5XL5DCJo4+5vXkrc1hRFcKzv+ymEGpJ9HG1c5o7R/qREFfm
        rQMp3gAg4pQY2qi7BQLTUUc=
X-Google-Smtp-Source: ACHHUZ6dCtHHc/Tyis21EWcZyXyQoCgu522rbYdCPnOWa9D1Ua681uS0z4kwAWMg6r9qmvXywp2OpQ==
X-Received: by 2002:aca:1e12:0:b0:38b:c4c3:b3ec with SMTP id m18-20020aca1e12000000b0038bc4c3b3ecmr9652841oic.3.1684188077836;
        Mon, 15 May 2023 15:01:17 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:5391:4539:59c2:4092])
        by smtp.gmail.com with ESMTPSA id i1-20020aca0c41000000b0038e07fe2c97sm5265148oiy.42.2023.05.15.15.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 15:01:17 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v13 13/13] hp-bioscfg: MAINTAINERS
Date:   Mon, 15 May 2023 17:01:01 -0500
Message-Id: <20230515220101.39794-14-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515220101.39794-1-jorge.lopez2@hp.com>
References: <20230515220101.39794-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 0c9011f5fc17..7d1f261af539 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9367,6 +9367,12 @@ S:	Obsolete
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

