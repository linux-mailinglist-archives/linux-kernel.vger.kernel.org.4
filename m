Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836DE6E7DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjDSPOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjDSPNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:13:45 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A98C6A76;
        Wed, 19 Apr 2023 08:13:26 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6a5f21a0604so1478111a34.2;
        Wed, 19 Apr 2023 08:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681917205; x=1684509205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LgyelK5AQ23WEMgFpi3kd5xccNHQg9qlLU9me3qruqc=;
        b=bc2fv55EDQj93fliAAZqIxT7rQ8icWliqDo8R8snKM0FchlmRfy95/dsaW7BBx2YQc
         kDIJ4HUH6L4msmAMCyIV62qsXdZxxDAg7bdU10hSNKyIZO66guY9PCCOFxSit7VDZvZz
         rI86KvGbV49aTGTrbM4lWhkvD8oXTUI4DnM2ipipXZFRfk1DtHCRT25z26jE/tyhTxDe
         wHW/Ih2oo9DVUt/6mzzPh8qvdAXdtRwYTP22b62vpKMQSlTLUP7H1H6UzqgBZ4twV5FD
         7Wyr0CHYRmgXrfpCuwmdzgfFJH4FWQiCDLbEtL2TJ9v7oIPX7LOQDvXAieFHcVgN1jBc
         UhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681917205; x=1684509205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgyelK5AQ23WEMgFpi3kd5xccNHQg9qlLU9me3qruqc=;
        b=CqeaPUm76Vdil29+NntCAkKTHmjVJBMs7tg81RuO6poeC6ArFy0n/7asL1jYmXK4fv
         06Pi7bpMn00IbPRFkBEjTAd1uMdDyOTqdUt3e8drkf9FSXe8Rlm33y3DJp4tX08Wy66y
         Wa/nVThe318WdvwnykZ8gARR7rCfFONpAXGGwc4lOGUtdMW58JmHBvIy4QKWQQ4UPT/8
         aHe39LWnHjehBNIZA4r6pPsvBBymUaBc8LFBaIdm+pUvd7IMYAF50lsIWmGdB0bSIOIa
         VbiSt2I+D20YkWi+v6ceKkZpd1otY/TM2DAP/R6NBvuyhRn1/14kox5clL0lov7/AQjL
         mhAQ==
X-Gm-Message-State: AAQBX9dFfOtt1p+rz9pkGZtuaXXSuYoTmkhLt8IL3GjGRtgp6pawvqEK
        QVL9cHVQwjSwTLvJCuoUSj4=
X-Google-Smtp-Source: AKy350aiOBIB3FQ9ZBslFns9wFRnTTjnEIGYz8pqmJMIvAQ6CsqUl4DQA7TjTSz4Vp6uFbQiSPoyQA==
X-Received: by 2002:a9d:65c7:0:b0:6a4:402c:50bf with SMTP id z7-20020a9d65c7000000b006a4402c50bfmr3086109oth.37.1681917205376;
        Wed, 19 Apr 2023 08:13:25 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e175:6963:338:7453])
        by smtp.gmail.com with ESMTPSA id f17-20020a056830205100b00690e990e61asm4308842otp.14.2023.04.19.08.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:13:25 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v10 00/14] HP BIOSCFG driver
Date:   Wed, 19 Apr 2023 10:13:07 -0500
Message-Id: <20230419151321.6167-1-jorge.lopez2@hp.com>
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


Jorge Lopez (14):
  HP BIOSCFG driver - Documentation
  HP BIOSCFG driver  - biosattr-interface
  HP BIOSCFG driver  - bioscfg
  HP BIOSCFG driver  - int-attributes
  HP BIOSCFG driver  - ordered-attributes
  HP BIOSCFG driver  - passwdobj-attributes
  HP BIOSCFG driver  - string-attributes
  HP BIOSCFG driver  - bioscfg-h
  HP BIOSCFG driver  - enum-attributes
  HP BIOSCFG driver  - passwdattr-interface
  HP BIOSCFG driver  - spmobj-attributes
  HP BIOSCFG driver  - surestart-attributes
  HP BIOSCFG driver  - Makefile
  HP BIOSCFG driver  - MAINTAINERS

 .../testing/sysfs-class-firmware-attributes   |  98 +-
 MAINTAINERS                                   |   6 +
 drivers/platform/x86/hp/Kconfig               |  16 +
 drivers/platform/x86/hp/Makefile              |   1 +
 drivers/platform/x86/hp/hp-bioscfg/Makefile   |  13 +
 .../x86/hp/hp-bioscfg/biosattr-interface.c    | 305 ++++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 961 ++++++++++++++++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h  | 613 +++++++++++
 .../x86/hp/hp-bioscfg/enum-attributes.c       | 543 ++++++++++
 .../x86/hp/hp-bioscfg/int-attributes.c        | 474 +++++++++
 .../x86/hp/hp-bioscfg/ordered-attributes.c    | 563 ++++++++++
 .../x86/hp/hp-bioscfg/passwdattr-interface.c  |  51 +
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 668 ++++++++++++
 .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 405 ++++++++
 .../x86/hp/hp-bioscfg/string-attributes.c     | 451 ++++++++
 .../x86/hp/hp-bioscfg/surestart-attributes.c  | 130 +++
 16 files changed, 5296 insertions(+), 2 deletions(-)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/Makefile
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/ordered-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c

-- 
2.34.1

