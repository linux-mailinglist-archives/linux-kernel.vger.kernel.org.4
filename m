Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943A17202AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbjFBNKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjFBNKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:10:48 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81EA1B3;
        Fri,  2 Jun 2023 06:10:46 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-39831cb47c6so893871b6e.2;
        Fri, 02 Jun 2023 06:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685711446; x=1688303446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AtMTYFs/pjr42l2m77xDerUdsJMk0X2kmgEfABxAPxs=;
        b=nb/oTOBQrp/6oUTY7aaFgzmss2n6BpZsX80yV+4E2xBv4E1xF51bPnDxt72oZxw+9q
         e6OeEhewyuW3feHSI8P1vMNu3y6KRr7yla5z+XvNdKzWrBhhixtx50wFUgH28LmFM2kB
         JgKa31U8/4YoXLRNm6s+kPKBy7TqwKio5CfCbB7rRMs3KzetPhljSroXZm5yyavnGbgN
         4qLlhCUe8hbPn2ZbN7qXTH16nT/fi+mB0ZbKcc0NYemLld+jgWG9drqDP6ljF1gZe8kw
         okNGCS0walCrwRApS5a7k9JG28qpD1jh31uFy4Xwn2mvRvo6InRxTeI/R9cAL/vBxOzR
         K3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711446; x=1688303446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtMTYFs/pjr42l2m77xDerUdsJMk0X2kmgEfABxAPxs=;
        b=UEbBLEhat3WnkNxa/7vTVusg2RoRZ3C5V1e7eYlFmNsbrqENN+tXD3WDUo2oVsVuqB
         xENB0VYgD/E84qGYJgvo/X7JhTZMmFA6u3JNcJH1JVHgSp/kCDwezCzkQ3RUxyVhEy7Y
         iuQ9jcobkNWC/DG1nEdtaMfvZ+rvWnDIjeiJ8YDQzYZTozNzmRWil2B6v7Waskw3EXly
         Nz347np4qAkhmenmkwMTjIsXk4TGTJPC5D+EHUbG8/ivWnJWIQRnpSM8QaEYUBfrEuCr
         7UOo5GkYV10h9erM7KzPIs9LHX+O9rWAOFUjLOenSR2cBbk25UmYdHJQkfF+noGajhCj
         NLtA==
X-Gm-Message-State: AC+VfDznsd3eUnKVNz+zZYamvjo04arI0Fz0uyrzy7SZgv9k8q36U2/4
        3dA+5bm5w0BNihCrWlLimnsQapaV3T8=
X-Google-Smtp-Source: ACHHUZ48ztlu3zYuPxfjBBRkU9c7yvFj67VsteM3M8HwGJOb52evsbAdpaK98dOqLcNPP+l1sw/PZg==
X-Received: by 2002:a05:6808:274e:b0:398:10b2:d2b1 with SMTP id eh14-20020a056808274e00b0039810b2d2b1mr1143844oib.44.1685711445952;
        Fri, 02 Jun 2023 06:10:45 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:125c:6b6d:18e9:9361])
        by smtp.gmail.com with ESMTPSA id k17-20020a544691000000b0039a531d9b92sm483762oic.56.2023.06.02.06.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:10:45 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v16 00/13] hp-bioscfg driver 
Date:   Fri,  2 Jun 2023 08:10:31 -0500
Message-Id: <20230602131044.3297-1-jorge.lopez2@hp.com>
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

Version 16
	Only patches marked [update] changed between version 16 and 15

	Patches
	 Documentation
	 biosattr-interface
	 bioscfg 			[update]
	 bioscfg-h 			[update]
	 enum-attributes 		[update]
	 int-attributes 		[update]
	 order-list-attributes 		[update]
	 passwdattr-interface
	 spmobj-attributes
	 string-attributes 		[update]
	 surestart-attributes
	 Makefile ../hp/Makefile ../hp/Kconfig 
	 MAINTAINERS


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

Version 6
	Breaks down the changes into 4 patches
	SureAdmin-attributes was removed


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
 .../x86/hp/hp-bioscfg/biosattr-interface.c    | 312 ++++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 986 ++++++++++++++++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h  | 486 +++++++++
 .../x86/hp/hp-bioscfg/enum-attributes.c       | 462 ++++++++
 .../x86/hp/hp-bioscfg/int-attributes.c        | 437 ++++++++
 .../x86/hp/hp-bioscfg/order-list-attributes.c | 451 ++++++++
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 540 ++++++++++
 .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 386 +++++++
 .../x86/hp/hp-bioscfg/string-attributes.c     | 401 +++++++
 .../x86/hp/hp-bioscfg/surestart-attributes.c  | 132 +++
 15 files changed, 4726 insertions(+), 2 deletions(-)
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

