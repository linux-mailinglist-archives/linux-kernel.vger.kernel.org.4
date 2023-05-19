Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0C770A052
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjESUNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjESUNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:13:05 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F272A102;
        Fri, 19 May 2023 13:13:03 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1962e7284baso2736161fac.3;
        Fri, 19 May 2023 13:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684527183; x=1687119183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7Y0i4GvrbFVwsVHtX/Gx93Fyr8XKJyIAD1SuH1o0io=;
        b=RFzAB1eRTjvoWl50jOGZxctGk5w1uYwxM8KbDbUMqncFAlcUxgon1mxcyQn8lhqxkZ
         cz+/a5GJZY1DX94a9Jdv6d3JYEG4h/qmaLjGfOG0rgCkmYULXBD31AAKfwoqjqYNXtS+
         R7Vvc1UB2CtQXbqSbIegMJuz0QqLSaigKIGa6vDtI+xAtreMJfc8bPL72EMaDgzFiuAH
         D4Ynn4zd83Qo5tDgEZJjyNgomAYPlp0rtBqTAJkKRyFCWjpkTiw5GOO2jl/lZYeX1eXp
         BifykfCRT+855WHPpNW8bLhyxTIHempQc4H+HEpxu0OQba88GO96OMC+PT3tXhisUpkx
         3/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684527183; x=1687119183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7Y0i4GvrbFVwsVHtX/Gx93Fyr8XKJyIAD1SuH1o0io=;
        b=POVv6BQ1hb0iBbh/uNORUviketgxXn6XJysGjPugHR7/nY+YWHgOrFpK4p51ffX2R9
         xAkFFcsgzhMwri3F7vPww68mYCvpon7KYU42WgUalzJOXnrg+meoV5cKUC0OViV0PutM
         kKYy9a+sASNJ/Kf6ECbPi4ew96riaaa9TZ4LGuwi1EK80clctri91CyaFUUuz+iNgo9U
         PBKRsTEymcP0zSLGqc7BTBJ2PLHM/O8/jzTpd+Rw59RCGeNEsgLyeKHwpNCq3LBYgv/T
         vZ8obQUHS/1CRn1A8iVXC4VAhWBd2M58t1Jtqv7Bi/5F4Fg3zUdMdUGx1vJfj+CTZcMW
         C40g==
X-Gm-Message-State: AC+VfDwmkAUEgM0UN8uSvQrANg3OQJeXcJMl19Wkritx6wxz2al7/KnN
        HF9YT5K+emoqkEjhdJ6m1A0=
X-Google-Smtp-Source: ACHHUZ4PT+QWwJF6haYhD3T3ZLhUUfBnkX67QJxpyxOVQiSEy3Phjydm6Xt0sQHS/ugzAGC9KbEMmw==
X-Received: by 2002:a05:6870:3884:b0:188:1195:5ec5 with SMTP id y4-20020a056870388400b0018811955ec5mr1641846oan.39.1684527183238;
        Fri, 19 May 2023 13:13:03 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e6dc:4936:31b7:d3d0])
        by smtp.gmail.com with ESMTPSA id g4-20020a056870d20400b001964dc3dadesm2325239oac.45.2023.05.19.13.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:13:02 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v15 01/13] hp-bioscfg: Documentation
Date:   Fri, 19 May 2023 15:12:48 -0500
Message-Id: <20230519201300.12964-2-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519201300.12964-1-jorge.lopez2@hp.com>
References: <20230519201300.12964-1-jorge.lopez2@hp.com>
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
 .../testing/sysfs-class-firmware-attributes   | 101 +++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
index 4cdba3477176..df9904b9f39c 100644
--- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
+++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
@@ -22,6 +22,11 @@ Description:
 			- integer: a range of numerical values
 			- string
 
+		HP specific types
+		-----------------
+			- ordered-list - a set of ordered list valid values
+
+
 		All attribute types support the following values:
 
 		current_value:
@@ -126,6 +131,21 @@ Description:
 					value will not be effective through sysfs until this rule is
 					met.
 
+		HP specific class extensions
+		------------------------------
+
+		On HP systems the following additional attributes are available:
+
+		"ordered-list"-type specific properties:
+
+		elements:
+					A file that can be read to obtain the possible
+					list of values of the <attr>. Values are separated using
+					semi-colon (``;``) and listed according to their priority.
+					An element listed first has the highest priority. Writing
+					the list in a different order to current_value alters
+					the priority order for the particular attribute.
+
 What:		/sys/class/firmware-attributes/*/authentication/
 Date:		February 2021
 KernelVersion:	5.11
@@ -206,7 +226,7 @@ Description:
 		Drivers may emit a CHANGE uevent when a password is set or unset
 		userspace may check it again.
 
-		On Dell and Lenovo systems, if Admin password is set, then all BIOS attributes
+		On Dell, Lenovo and HP systems, if Admin password is set, then all BIOS attributes
 		require password validation.
 		On Lenovo systems if you change the Admin password the new password is not active until
 		the next boot.
@@ -296,6 +316,15 @@ Description:
 						echo "signature" > authentication/Admin/signature
 						echo "password" > authentication/Admin/certificate_to_password
 
+		HP specific class extensions
+		--------------------------------
+
+		On HP systems the following additional settings are available:
+
+		role: enhanced-bios-auth:
+					This role is specific to Secure Platform Management (SPM) attribute.
+					It requires configuring an endorsement (kek) and signing certificate (sk).
+
 
 What:		/sys/class/firmware-attributes/*/attributes/pending_reboot
 Date:		February 2021
@@ -311,7 +340,7 @@ Description:
 			==	=========================================
 			0	All BIOS attributes setting are current
 			1	A reboot is necessary to get pending BIOS
-			        attribute changes applied
+				attribute changes applied
 			==	=========================================
 
 		Note, userspace applications need to follow below steps for efficient
@@ -364,3 +393,71 @@ Description:
 		use it to enable extra debug attributes or BIOS features for testing purposes.
 
 		Note that any changes to this attribute requires a reboot for changes to take effect.
+
+
+		HP specific class extensions - Secure Platform Manager (SPM)
+		--------------------------------
+
+What:		/sys/class/firmware-attributes/*/authentication/SPM/kek
+Date:		March 2023
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:
+		'kek' Key-Encryption-Key is a write-only file that can be used to configure the
+		RSA public key that will be used by the BIOS to verify
+		signatures when setting the signing key.  When written,
+		the bytes should correspond to the KEK certificate
+		(x509 .DER format containing an OU).  The size of the
+		certificate must be less than or equal to 4095 bytes.
+
+What:		/sys/class/firmware-attributes/*/authentication/SPM/sk
+Date:		March 2023
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:
+		'sk' Signature Key is a write-only file that can be used to configure the RSA
+		public key that will be used by the BIOS to verify signatures
+		when configuring BIOS settings and security features.  When
+		written, the bytes should correspond to the modulus of the
+		public key.  The exponent is assumed to be 0x10001.
+
+What:		/sys/class/firmware-attributes/*/authentication/SPM/status
+Date:		March 2023
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:
+		'status' is a read-only file that returns ASCII text in JSON format reporting
+		the status information.
+
+		  "State": "not provisioned | provisioned | provisioning in progress ",
+		  "Version": " Major. Minor ",
+		  "Nonce": <16-bit unsigned number display in base 10>,
+		  "FeaturesInUse": <16-bit unsigned number display in base 10>,
+		  "EndorsementKeyMod": "<256 bytes in base64>",
+		  "SigningKeyMod": "<256 bytes in base64>"
+
+What:		/sys/class/firmware-attributes/*/attributes/Sure_Start/audit_log_entries
+Date:		March 2023
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:
+		'audit_log_entries' is a read-only file that returns the events in the log.
+
+			Audit log entry format
+
+			Byte 0-15:   Requested Audit Log entry  (Each Audit log is 16 bytes)
+			Byte 16-127: Unused
+
+What:		/sys/class/firmware-attributes/*/attributes/Sure_Start/audit_log_entry_count
+Date:		March 2023
+KernelVersion:	5.18
+Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
+Description:
+		'audit_log_entry_count' is a read-only file that returns the number of existing
+		audit log events available to be read. Values are separated using comma (``,``)
+
+			[No of entries],[log entry size],[Max number of entries supported]
+
+		log entry size identifies audit log size for the current BIOS version.
+		The current size is 16 bytes but it can be up to 128 bytes long in future BIOS
+		versions.
-- 
2.34.1

