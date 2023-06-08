Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56D1728503
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjFHQd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjFHQdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:33:25 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA0D19B;
        Thu,  8 Jun 2023 09:33:21 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-39a4eb67c5fso600355b6e.0;
        Thu, 08 Jun 2023 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686242000; x=1688834000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HwPNtm00qKPNpBKYYHXekOntgh6IVyiDOoXjUG3ztA=;
        b=nGXgsY/tusUMD3+0BJ/22HW3hVYDv+3fkD3DQV3t2m1MslmRhbV3yIwhQhre2rPuzZ
         WF8ROcKhGcpvYiZcl+4IdYSRl0rVubx/mL0UEpcI7sgP+QpQPv/G/k0yajesUkpEeLX1
         5YrpEue8SK9uX+J2+OMtDsBTzkvsiLyqEJM29nXUnTDCKfC92mDk6DijhVawxpNJnHne
         f+MtnJclbki2yBeIHDLP4mGPgs5Ts0oxqXuHf5lJdyyttY0d2mNHl4MSZUmX0wrl8ERU
         DUazzSxLMyVio1zg0I+rBAHSi2lqOnLDOfxjRhQuIae1X3/+emu4ozWNvy6OhDxB33zQ
         yh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242000; x=1688834000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HwPNtm00qKPNpBKYYHXekOntgh6IVyiDOoXjUG3ztA=;
        b=LAEmsttOgQ7avFKaZk1lhnrgWxv2zY86FiWmCoC4Egjn+bX0sQGqDik+tb3AfHkxZU
         +ZsC6J+tY+acvds7Y6awANZkMKsFqsD4Li0lpNdVUukeY3n3yX7+81MPaurSEDgPUT9G
         LpeGxxRlXO/uEcAtDQ+CMp14Kg+NMh/pFrWNN2bs6t10r9x604fGav/N/3yCHwWNxr2M
         KbJPiV8W/IbWib/LbNlW6biGUFV8rL0rOLGSEryV5Q0ulrtCOk7CFWdSH+503JNQefhh
         9Zl1aCJ/WGKxKS9eYv+4g7LRaQ7zufduTRYM/p8qF0CXxzdE6TFrvTAfsBVsLoSbx2tv
         RtQg==
X-Gm-Message-State: AC+VfDy6PRhlxDDofg6CB46wlzdiI8o4ea7Da2FHmXEmoBpSNVUkONrf
        0xSjFFzQT6Muuk+CKDze183cIv4RGBQ=
X-Google-Smtp-Source: ACHHUZ6ow4s8nTQ0O3ywHQep5OK7QlBBngBd1Fa0uJFZlxjuo8yuJNWsNV4ZyNrCVsedoFlhjyDt4A==
X-Received: by 2002:a05:6808:218:b0:398:e4c:d5c2 with SMTP id l24-20020a056808021800b003980e4cd5c2mr5873320oie.9.1686242000619;
        Thu, 08 Jun 2023 09:33:20 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:a60f:2d4d:e52b:2fca])
        by smtp.gmail.com with ESMTPSA id e10-20020acab50a000000b003942036439dsm577500oif.46.2023.06.08.09.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:33:20 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v17 00/13] hp-bioscfg driver
Date:   Thu,  8 Jun 2023 11:33:06 -0500
Message-Id: <20230608163319.18934-1-jorge.lopez2@hp.com>
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

Version 17
	Only patches marked [update] changed between version 17 and 16
	Added helper routine to handle all common data for all attributes.
	Corrected spaces found prior and after a '"'.
        Update commit message to reflect comments from reviewers
       

	Patches
	 Documentation                  [update]
	 biosattr-interface
	 bioscfg 			[update]
	 bioscfg-h 			[update]
	 enum-attributes 		[update]
	 int-attributes 		[update]
	 order-list-attributes 		[update]
	 passwdattr-interface           [update]
	 spmobj-attributes
	 string-attributes 		[update]
	 surestart-attributes
	 Makefile ../hp/Makefile ../hp/Kconfig 
	 MAINTAINERS

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

 .../testing/sysfs-class-firmware-attributes   |  101 +-
 MAINTAINERS                                   |    6 +
 drivers/platform/x86/hp/Kconfig               |   16 +
 drivers/platform/x86/hp/Makefile              |    1 +
 drivers/platform/x86/hp/hp-bioscfg/Makefile   |   11 +
 .../x86/hp/hp-bioscfg/biosattr-interface.c    |  312 +++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 1055 +++++++++++++++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h  |  487 ++++++++
 .../x86/hp/hp-bioscfg/enum-attributes.c       |  447 +++++++
 .../x86/hp/hp-bioscfg/int-attributes.c        |  409 +++++++
 .../x86/hp/hp-bioscfg/order-list-attributes.c |  436 +++++++
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c  |  543 +++++++++
 .../x86/hp/hp-bioscfg/spmobj-attributes.c     |  386 ++++++
 .../x86/hp/hp-bioscfg/string-attributes.c     |  390 ++++++
 .../x86/hp/hp-bioscfg/surestart-attributes.c  |  132 +++
 15 files changed, 4730 insertions(+), 2 deletions(-)
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

