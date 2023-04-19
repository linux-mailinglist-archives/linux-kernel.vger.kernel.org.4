Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BDF6E7DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjDSPM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDSPM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:12:56 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE59FFA;
        Wed, 19 Apr 2023 08:12:54 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-18777914805so10206473fac.1;
        Wed, 19 Apr 2023 08:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681917174; x=1684509174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LgyelK5AQ23WEMgFpi3kd5xccNHQg9qlLU9me3qruqc=;
        b=Wa/x4Cz0szJ1tY6/qeKeAy2D1zJuOW7o0YVnH7hAbsO1pqJRVfSd0t2KBdNI8SREf1
         nA0k1hFNfkgQ7yLpog72b22FLNG/ZtkO50KA47rFPi9xtird2jR1CK0fFLVPbO6IsiyT
         +SqG+6Od0+SbMGN81eC/7Xq8lQRTIO6y5sSuLPPKKmWGHmXSOpragQoqXuJJ0F4Pg8Qy
         Wy4avHy1KHMwgoF1xTyDUDwsjRrFrJylA5RhIGOXAcMGSA2odNbh80oN5t7wSRt7EP5+
         um/Hr5IFTN1H7GPZLGsbEj9E3jY8nZcqZd1lMVMxHOJSdCMAcKw+0NNFjwKkRq2o8/OU
         z+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681917174; x=1684509174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgyelK5AQ23WEMgFpi3kd5xccNHQg9qlLU9me3qruqc=;
        b=GTQhztCuWTqhDFcyi25lhhUCe2AMwD1srg/tSi5qdZe+RwzFrY+45/nRmjoJE2RoH0
         t8dAyzSyZLwfTJ+r3ewXD+3V/6TM9SPsMav6VNFVG3eA8/ynNG3Qvn/SclG6Wo79rOnI
         0Q0nqQk/hsJdx4AmryZf7Z15xaRyH4D8x5zGZ+7S9E+1l+kXvtQLqsGZHt8w6F8NfUyi
         IikQwFGo0epF3snKA1tHMC4FfEuneqNlqHD1/AwVLC6x1KMMR12pucW6P4S2jlZxqa5R
         Llp7Qo2ifcpYQY7h3dmgVEuE8nIdJbieyOn05txqzhVO/iADpwjn73eiySHrReqh60dZ
         lRMQ==
X-Gm-Message-State: AAQBX9eJqxYzq2puJMEMhsPx/HWMLhnraO8hUSCIyZib4htrYOf4lq42
        7peYp5Ln8OF7BDcMknOCSc6LmTSQuhM=
X-Google-Smtp-Source: AKy350awz6n7FOg5Rw2v9NM8srBe9A3NuVktARJJazMCjt4MxwWpj3dQqc0VVBPRBC4xY6DXAyWnTQ==
X-Received: by 2002:aca:db56:0:b0:38e:4e96:1292 with SMTP id s83-20020acadb56000000b0038e4e961292mr1367292oig.3.1681917174004;
        Wed, 19 Apr 2023 08:12:54 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e175:6963:338:7453])
        by smtp.gmail.com with ESMTPSA id o10-20020acad70a000000b0038bae910f7bsm5766847oig.1.2023.04.19.08.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:12:53 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v10 00/14] HP BIOSCFG driver
Date:   Wed, 19 Apr 2023 10:12:40 -0500
Message-Id: <20230419151249.6126-1-jorge.lopez2@hp.com>
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

