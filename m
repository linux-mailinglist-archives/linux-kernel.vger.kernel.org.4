Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCA66E7DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjDSPPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbjDSPN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:13:57 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C864EF4;
        Wed, 19 Apr 2023 08:13:42 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6a604259983so1112427a34.2;
        Wed, 19 Apr 2023 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681917221; x=1684509221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpWRid5cmCr0SjsRhGTnuvLDk1kP0ktA07Mc2yuVwzg=;
        b=V86dkUvgWhX/26GSEm3W6Q69f84iJEr6xben0GsCF2jLttscYfOOJ8SZKCr2CUqzIK
         srUSHJfQjr8A/TzJQAXTr5+vPyeppevLJt8j+i5Nj+UuPljiIUy7DUIKlYGvEVx3hUw/
         dseCd+z0+u8+mAv91khPx28ZDQbedDgVMG29k3uLaSz5hXSbCmCuTg/pdLwzHS+5z9U1
         dZxlT3UZAs0JM++HWe1cGQbZmVE4bPdrR9+E/0aaZQvAfqUrb1F5lEXAcRB0C11183Aa
         aTLZdM7j8Zv2x9PU7Evy8Q/Io60Ytm5o4PM/8t5Ud/Qume673R9KcvalIerwE1hmCFiD
         fS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681917221; x=1684509221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpWRid5cmCr0SjsRhGTnuvLDk1kP0ktA07Mc2yuVwzg=;
        b=DoxKBjVGE3LQFKEnO0j0WsKpl4fBEgncpAWfeaHL/sjQrR2jDHXOR45KXpeS3PI8UW
         3tRM0gb4/lPcm6FFFe+ft0JDtFpXlglR+1eVOY2iPqE8GbwI9kvgmBSPi+W6J1QfRrVe
         5E58cHf/TrYjZ36n5asmy9xacHkqLTBU+HdWhSmbYPZp7tE7jO5TkR5dUHMNY8QG/UCP
         N2EZw4cgAqncFvINuNwa53jxluCu1su3Yo3aKlfJUoTzg486VrITQi6XLn3TOY0birwl
         /2JLfuRDZTCBDzjBkt0127qFQQnBLEipX93igQxZ4ywJXUjXrI1PUC4ZEqs1WaHi3Ujt
         xEIQ==
X-Gm-Message-State: AAQBX9etkXfWOJ0Xal3VKdTYUHt9S53w/5YtMx4Z1LsTceHH7RDOr87L
        mnRjfUnxXUt2E3ruA9ez6PJL3ncCicU=
X-Google-Smtp-Source: AKy350b9QfL1DX+xVWkMvqe8Fmj+a3fi04MNuF6DLZL9UDj72jhArZDxmUJniZam/Nq9LZpmJjtVow==
X-Received: by 2002:a9d:7d8a:0:b0:6a5:cf2a:8b10 with SMTP id j10-20020a9d7d8a000000b006a5cf2a8b10mr3266339otn.32.1681917221681;
        Wed, 19 Apr 2023 08:13:41 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e175:6963:338:7453])
        by smtp.gmail.com with ESMTPSA id f17-20020a056830205100b00690e990e61asm4308842otp.14.2023.04.19.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:13:41 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v10 14/14] HP BIOSCFG driver  - MAINTAINERS
Date:   Wed, 19 Apr 2023 10:13:21 -0500
Message-Id: <20230419151321.6167-15-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419151321.6167-1-jorge.lopez2@hp.com>
References: <20230419151321.6167-1-jorge.lopez2@hp.com>
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

