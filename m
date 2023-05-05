Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E846F8C0F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjEEWAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjEEWAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:00:48 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA26A1FDA;
        Fri,  5 May 2023 15:00:45 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6a5f21a0604so1612190a34.2;
        Fri, 05 May 2023 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683324045; x=1685916045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=83tgoutch2QY+z6Wt3CVxP42znch7iYr3rA4A3IWrsI=;
        b=Nav1Bgw6N+l4tqR2sXCQWqsWYuTZjfvWm4aupCBsaov0XnBWCdt29Dv85LZu6JwyjN
         xmGlYkhFiDSvLVNsdkUBfF52TfYYuRHhz3PtQ6iiGY1aktdeRFsQmjKa7N29wwWFOH0a
         6dN5ZvAbEJKUqe7TkZaqbI01q+PVFRzNrcZNKxLZUbycHVR2ATcxrYDPT7zRZ52pjkZZ
         LrSPHxs9A8ijE3JeSUfPkcStoAje0aPga5IhHUTPXUaSgatHj9ZtMbh31Q2qhGDKORGG
         hwwQ4Lax2DFvMXNKiGUKkkpKsbqUEXbx1y3zWONTuku3lLroLyyPBGJ8lTmMz8Pt6WHz
         K8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683324045; x=1685916045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83tgoutch2QY+z6Wt3CVxP42znch7iYr3rA4A3IWrsI=;
        b=WiVuBK6x7gZNwJmnXAbw3OzEyd02sx6Cni3Bx5a9cysTUnEA9XkVdahj4+s/RnnvYC
         bUiUpy+pWG4JJodhTQgwf+ko+Cz7KYj9wwAC73UsuOejagPY/oKxc0svNjRXnFJIPiUP
         K81LOzlGCJURk2t4Dmfulo7wlZyUBOKNg7kMY+9KXY85piFp6f6eGeyBGWs8h/HocliN
         E9CtIE7rXuBtFytThZnw1qUiah0LYILaxTXrSkq/2HdrytHIVVC5SNicS8vUZ3nifcHr
         dDpiE6OnbpI+ac3/5FoIRBO2PN+yMEc4tGG6RFemqnNJybYvHvIigIPF5XA87GxO4Mmq
         faag==
X-Gm-Message-State: AC+VfDxz7VdYL86TArSPVjb50oKggfv0Wr7BrCe6A1ALjx3W8McZ9E1u
        bapADeyd/+32kSWYOMrVdnYya5r4tI4=
X-Google-Smtp-Source: ACHHUZ4WPAOUpAzvCawSMma23EccLX56k1BscYW0tuQZE59JdWsxHifLspMKKfcwu+Nn4XCg6BTSDA==
X-Received: by 2002:a9d:6acb:0:b0:6a5:f438:143c with SMTP id m11-20020a9d6acb000000b006a5f438143cmr1447347otq.34.1683324045144;
        Fri, 05 May 2023 15:00:45 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:90cc:2e0a:7522:8ecc])
        by smtp.gmail.com with ESMTPSA id w15-20020a056830060f00b006a61bef7968sm1359547oti.53.2023.05.05.15.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:00:44 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v12 00/13] HP BIOSCFG driver
Date:   Fri,  5 May 2023 17:00:30 -0500
Message-Id: <20230505220043.39036-1-jorge.lopez2@hp.com>
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

Version 5
	Remove version 4 patch 1
	Address review changes proposed in Version 4
	Reorganize all patches number and file order


Jorge Lopez (13):
  HP BIOSCFG driver - Documentation
  HP BIOSCFG driver  - biosattr-interface
  HP BIOSCFG driver  - bioscfg
  HP BIOSCFG driver  - int-attributes
  HP BIOSCFG driver  - ordered-attributes
  HP BIOSCFG driver  - passwdobj-attributes
  HP BIOSCFG driver  - string-attributes
  HP BIOSCFG driver  - bioscfg-h
  HP BIOSCFG driver  - enum-attributes
  HP BIOSCFG driver  - spmobj-attributes
  HP BIOSCFG driver  - surestart-attributes
  HP BIOSCFG driver  - Makefile
  HP BIOSCFG driver  - MAINTAINERS

 .../testing/sysfs-class-firmware-attributes   | 117 ++-
 MAINTAINERS                                   |   6 +
 drivers/platform/x86/hp/Kconfig               |  16 +
 drivers/platform/x86/hp/Makefile              |   1 +
 drivers/platform/x86/hp/hp-bioscfg/Makefile   |  12 +
 .../x86/hp/hp-bioscfg/biosattr-interface.c    | 319 ++++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 982 ++++++++++++++++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h  | 523 ++++++++++
 .../x86/hp/hp-bioscfg/enum-attributes.c       | 482 +++++++++
 .../x86/hp/hp-bioscfg/int-attributes.c        | 448 ++++++++
 .../x86/hp/hp-bioscfg/ordered-attributes.c    | 443 ++++++++
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 584 +++++++++++
 .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 381 +++++++
 .../x86/hp/hp-bioscfg/string-attributes.c     | 415 ++++++++
 .../x86/hp/hp-bioscfg/surestart-attributes.c  | 133 +++
 15 files changed, 4860 insertions(+), 2 deletions(-)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/Makefile
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c

--
2.34.1

