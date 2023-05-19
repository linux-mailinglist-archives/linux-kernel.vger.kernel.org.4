Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0C370A050
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjESUNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESUNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:13:04 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E33E101;
        Fri, 19 May 2023 13:13:03 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-19a27f1cd6dso864897fac.0;
        Fri, 19 May 2023 13:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684527182; x=1687119182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jbeNZrThB0gFfoABsAjMFBkDt0uJSP14r2owHswDMco=;
        b=JggotjsBZGKshR+jusA+ffJ3KYj+Uw2GU2bjeue9f6GOHhQs6ahG+HhNbsvwlx7vMI
         F+K50OpYSaOvLEk2u/VFII6+SdLrQbZbmpSXYNV84FDquDd67wm0wdzCv15ZY8ZEFyZa
         8t8zaN/VmXxWgwAytu4DdDiAsB2+tbo1WfxRNZm1LX+Mvyf9/L8mmcf/ktioIFRWQUQ5
         BIajlrmym0SGAUJ2+DhPuvKJoFFZvDX08YmB3gn0jBz6pVrQzEcbSJ9NU9HqzIIJp1BE
         HEIhi83IKhipTrXp/LcoX24FsHSpfb5a3MBCMDWkNs7EEJBoneAmmRcvlOBGaXT3z6Wh
         0kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684527182; x=1687119182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbeNZrThB0gFfoABsAjMFBkDt0uJSP14r2owHswDMco=;
        b=GxY6vYEOxiT0Q1swl5l79xpnlTAyu/lqIdHUs/1I/IuoT4+oOOTRX/OitiWVWmvNlQ
         ZZ9Yg+fE4ZaUZbqM36YCm6VlvEiXHJ0wzG1zW+6zElKF4BZWdOWm8oBSTs9XGS8P5qeg
         s7Tk8pzad7UNTGiSHt6FaG6+FBdJca+AZ1sFfo4vBFfpScc9wF12kjGLSRpW37UijuRF
         9k6/IZn9O5PosPDHzHK7U32pSfuXWSWl92AAJZgpwHlTbkSoD5dlo9nYdm1pG8V0RTTK
         aw80dpiRcJl/KUZm9i9KK/aBm6kM+VJrzSHrmOQiRc1rpX+PRumR2E1+S1yVRbuGY/M9
         ctyw==
X-Gm-Message-State: AC+VfDxHDeAlX+I1p3iQgL5KtvSR+Fstcheo/A2d9zgc3/PJT2cQUvXt
        7SBPQxHdIlQ9nfZKK/sJicAY3PHZJxs=
X-Google-Smtp-Source: ACHHUZ45D/jNYBg4STIAybjVmiClNzrhcUMeYE4w63Ho1BuePmetsiVTTb83k7nPcY78LlJ3aaLcPA==
X-Received: by 2002:a05:6870:3881:b0:192:b406:c590 with SMTP id y1-20020a056870388100b00192b406c590mr2192728oan.23.1684527182400;
        Fri, 19 May 2023 13:13:02 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e6dc:4936:31b7:d3d0])
        by smtp.gmail.com with ESMTPSA id g4-20020a056870d20400b001964dc3dadesm2325239oac.45.2023.05.19.13.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:13:01 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v15 00/13] hp-bioscfg driver
Date:   Fri, 19 May 2023 15:12:47 -0500
Message-Id: <20230519201300.12964-1-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
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

History

Version 15
	Only patches marked [update] changed between version 15 and 14

	Patches
	 Documentation			[update]
	 biosattr-interface
	 bioscfg
	 bioscfg-h
	 enum-attributes
	 int-attributes
	 order-list-attributes
	 passwdattr-interface
	 spmobj-attributes		[update]
	 string-attributes
	 surestart-attributes 
	 Makefile ../hp/Makefile ../hp/Kconfig 
	 MAINTAINERS

Version 14
	Only patches marked [update] changed between version 14 and 13
	Sorted commit patches alphabetically
	Rename ordered-attributes to order-list-attributes

	Patches
	 Documentation
	 biosattr-interface 		[update]
	 bioscfg
	 bioscfg-h
	 enum-attributes 		[update]
	 int-attributes
	 order-list-attributes
	 passwdattr-interface
	 spmobj-attributes
	 string-attributes
	 surestart-attributes 
	 Makefile ../hp/Makefile ../hp/Kconfig 
	 MAINTAINERS


Version 13
	Only patches marked [update] changed between version 12 and 13
	Sorted commit patches alphabetically
	Rename ordered-attributes to order-list-attributes

	Patches
	 Documentation 			[update]
	 biosattr-interface 		[update]
	 bioscfg 			[update]
	 bioscfg-h 			[update]
	 enum-attributes 		[update]
	 int-attributes 		[update]
	 order-list-attributes 		[update]
	 passwdattr-interface 		[update]
	 spmobj-attributes 		[update]
	 string-attributes 		[update]
	 surestart-attributes 		[update] 
	 Makefile ../hp/Makefile ../hp/Kconfig 
	 MAINTAINERS

Version 12
	Only patches marked [update] changed between version 11 and 12

	Patches
	 Documentation 			[update]
	 biosattr-interface 		[update]
	 bioscfg 			[update]
	 int-attributes 		[update]
	 ordered-attributes 		[update]
	 passwdobj-attributes 	[deleted]
	 string-attributes 		[update]
	 bioscfg-h 			[update]
	 enum-attributes 		[update]
	 passwdattr-interface 		[update]
	 spmobj-attributes 		[update]
	 surestart-attributes 		[update] 
	 Makefile ../hp/Makefile ../hp/Kconfig [update]
	 MAINTAINERS


Version 11
	Only patches marked [update] changed between version 10 and 11

	Patches
	 Documentation
	 biosattr-interface 		[update]
	 bioscfg
	 int-attributes
	 ordered-attributes
	 passwdobj-attributes 		[update]
	 string-attributes
	 bioscfg-h
	 enum-attributes
	 passwdattr-interface
	 spmobj-attributes 		[update]
	 surestart-attributes 		[update]
	 Makefile ../hp/Makefile ../hp/Kconfig
	 MAINTAINERS

Version 10
	Break down changes to single files per patch
	Removed SPM/statusbin support
	Patches
	 Documentation
	 biosattr-interface
	 bioscfg
	 int-attributes
	 ordered-attributes
	 passwdobj-attributes
	 string-attributes
	 bioscfg-h
	 enum-attributes
	 passwdattr-interface
	 spmobj-attributes
	 surestart-attributes
	 Makefile ../hp/Makefile ../hp/Kconfig
	 MAINTAINERS

Version 9
	Includes only sysfs-class-firmware-attributes documentation

Version 8
	Includes only sysfs-class-firmware-attributes documentation

Version 7
	Includes only sysfs-class-firmware-attributes documentation



Jorge Lopez (13):
  hp-bioscfg: Documentation
  hp-bioscfg: bioscfg-h
  hp-bioscfg: bioscfg
  hp-bioscfg: biosattr-interface
  hp-bioscfg: enum-attributes
  hp-bioscfg: int-attributes
  hp-bioscfg: order-list-attributes
  hp-bioscfg: passwdobj-attributes
  hp-bioscfg: spmobj-attributes
  hp-bioscfg: string-attributes
  hp-bioscfg: surestart-attributes
  hp-bioscfg: Makefile
  hp-bioscfg: MAINTAINERS

 .../testing/sysfs-class-firmware-attributes   | 101 +-
 MAINTAINERS                                   |   6 +
 drivers/platform/x86/hp/Kconfig               |  16 +
 drivers/platform/x86/hp/Makefile              |   1 +
 drivers/platform/x86/hp/hp-bioscfg/Makefile   |  11 +
 .../x86/hp/hp-bioscfg/biosattr-interface.c    | 318 ++++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 988 ++++++++++++++++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h  | 486 +++++++++
 .../x86/hp/hp-bioscfg/enum-attributes.c       | 465 +++++++++
 .../x86/hp/hp-bioscfg/int-attributes.c        | 440 ++++++++
 .../x86/hp/hp-bioscfg/order-list-attributes.c | 454 ++++++++
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 540 ++++++++++
 .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 386 +++++++
 .../x86/hp/hp-bioscfg/string-attributes.c     | 404 +++++++
 .../x86/hp/hp-bioscfg/surestart-attributes.c  | 132 +++
 15 files changed, 4746 insertions(+), 2 deletions(-)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/Makefile
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c

-- 
2.34.1

