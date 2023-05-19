Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9788270A069
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjESUOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjESUNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:13:32 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89C91701;
        Fri, 19 May 2023 13:13:17 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-19a3a8784c3so865989fac.1;
        Fri, 19 May 2023 13:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684527197; x=1687119197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9HhW1QPOz6WTxYOa6mD6gfn6R8qH8lALXUH8QmZoMg=;
        b=iF6cd/SQqoESUciFgASUjAYi6K6UTP6gErDflZkogLAGLV9hAGkUUNKeLbj1VDslD/
         BecAWYf0OwoDrCy5fFlD9SOLkufxabJEazUvYpweOLLNmOfmCIaNRit0UHaOiwUnBqwE
         UuHJwRDl8Uk+j/vXN1Bl89ubXLAJbf/fj6JVij0kiBpXFw0IZRheJI4fGIwCwlrBBd39
         wf940SnHZwQbQtqThmP1yCOcYuz64avYpCwsBD4NDh6prZIohrB6V86BQNMq78Zf3z1X
         5ajDUNDOxu5s69ceFqhYoGMV5IAKs+raP6nAHQu9oTjy0/xscdz2t64KLCxET5WouP3t
         pynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684527197; x=1687119197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9HhW1QPOz6WTxYOa6mD6gfn6R8qH8lALXUH8QmZoMg=;
        b=c8/zQPwJKaYasdcavZTaWzC11/eip8CziO9WAcE8dlNrfV9mOUlQY0z1FFFhXOSwVH
         WQRK97lW2qoCkOdgAPO7nF6fRYFlp5hdgOquXxJzyW6RpLlL/r8LWQ3H5zNCPt1cCowY
         X7x1q/ZhYYMNnvthsUYBixq/dyhIeL7wUWKtuc/pClPPSHE3rG+hss4yn9zRTkSjdfij
         VkNdWybv7omek+MvLkApMMyo60zrXQ34KKXMdiQd0xKkjomuevxXdjMQXof4YNlQytoW
         SJcGpburwoARAGOZudSVQwMfTo7ZCqfbGkUEn2R7Hqwl/dTswl9aa0Ea7jC0TY+4keKV
         +Mlg==
X-Gm-Message-State: AC+VfDzEna73/NPDEcd70KqVDFL2gXVStJYFPtcXFEj/jwdPpsnhx2uR
        G+9MfJINHhmlbj0eHTg5N8M=
X-Google-Smtp-Source: ACHHUZ4nmmwJNBPbGSrTLRLF35B836lq36WzmYE7nDJ7QrTgSMrxg1B5571kp19/+VlZ+jATehurKQ==
X-Received: by 2002:a05:6870:c8a3:b0:196:4801:837c with SMTP id er35-20020a056870c8a300b001964801837cmr3132731oab.15.1684527196950;
        Fri, 19 May 2023 13:13:16 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e6dc:4936:31b7:d3d0])
        by smtp.gmail.com with ESMTPSA id g4-20020a056870d20400b001964dc3dadesm2325239oac.45.2023.05.19.13.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:13:16 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v15 13/13] hp-bioscfg: MAINTAINERS
Date:   Fri, 19 May 2023 15:13:00 -0500
Message-Id: <20230519201300.12964-14-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519201300.12964-1-jorge.lopez2@hp.com>
References: <20230519201300.12964-1-jorge.lopez2@hp.com>
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

