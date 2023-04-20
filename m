Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D8D6E99F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjDTQzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDTQy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:54:58 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F541FDA;
        Thu, 20 Apr 2023 09:54:57 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5427422a17eso570940eaf.3;
        Thu, 20 Apr 2023 09:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682009696; x=1684601696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1xiCdBRN3dkhS3z75tgs/uAmebSFn4Q10CTGq+DYf8=;
        b=sRjWqBs83UZWdFqal36ni+g160KKgLqCpgKpwUj9Thpi8XQ5O2+5UqfOqWkuukuXkz
         aT87Foksb3uH4/xUFe8YxdeL3X3HXL4DY66yDiOhQKHA8gkMFDDPWaMmeQBTW4To+Q4Y
         tSG6SoUYYp7x7sMIKg/XpbHZ7R6lWXgbimlHmAMUZ1SkXSMDhSVjkdzxhnTEhbAJvkZI
         Kfj52zIdTtLlzFckUqInFBPw36TfPydLrmxTUa7pouKVitK8Kue2ICaxFkNjiv2KH1Lb
         a5dJp+Lzrld++OXvFCcH7jSUpftqBMAjwTnvYV0LP45JhdcLHBO/qlfKsKpjoLzJWD12
         q6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682009696; x=1684601696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1xiCdBRN3dkhS3z75tgs/uAmebSFn4Q10CTGq+DYf8=;
        b=a/yaMG0LxQAhqIOkarUhNNHDpgmc5TvaYKL2+HAch3pED7nkMyx2D2nJ8MRRX6aUw2
         jm3kyFdsQreYhUIv2r+rx+WxLki4fO78A6m5R36x++lyqAuhuZHFFhYKLkRc76z/wHHD
         aNSKjj63U2GO/zzmbZqeik3JBeZ/E5qRUzfSQxZx6uo41gGIys2yjEinjLQg1kKWm3Ej
         TLBb2uG8QxxPfY8tZFvKtfv1Anh1KluXS9y2+L7858AQNi4B9DohonJCmQrkaVRTIJBO
         lqZB8rNo/TJXsB+1BYgPod5G6hCO51nKlfuSdIBJAp3PF2xu6Km2Xnv1jZVi0O18FQra
         XuQg==
X-Gm-Message-State: AAQBX9dsUgh0VkDzQjhrAEjeTw72sqsB50/XgiBA0+LvbymFgQwbdZ4i
        Zax9qfuZ57qHlPM1XK26kgrZXLLPAHA=
X-Google-Smtp-Source: AKy350aUfhxFP9p0HiI8OVyHXVFTAe4hcVJfnD/CgGaGdRl/x+0EAvjxHVwkLgm3WMoa+Cd7hGKJ4w==
X-Received: by 2002:a05:6808:655:b0:38e:19e6:6401 with SMTP id z21-20020a056808065500b0038e19e66401mr1160640oih.30.1682009696364;
        Thu, 20 Apr 2023 09:54:56 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:d090:9746:e449:eb46])
        by smtp.gmail.com with ESMTPSA id s129-20020a4a5187000000b005252e5b6604sm791913ooa.36.2023.04.20.09.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:54:55 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v11 00/14] HP BIOSCFG driver
Date:   Thu, 20 Apr 2023 11:54:40 -0500
Message-Id: <20230420165454.9517-1-jorge.lopez2@hp.com>
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

Version 11
	Only patches marked [update] changed between version 10 and 11

	Patches
	 Documentation
	 biosattr-interface [update]
	 bioscfg
	 int-attributes
	 ordered-attributes
	 passwdobj-attributes [update]
	 string-attributes
	 bioscfg-h
	 enum-attributes
	 passwdattr-interface
	 spmobj-attributes [update]
	 surestart-attributes [update]
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
 .../x86/hp/hp-bioscfg/biosattr-interface.c    | 307 ++++++++++++++++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 961 ++++++++++++++++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h  | 613 +++++++++++
 .../x86/hp/hp-bioscfg/enum-attributes.c       | 543 ++++++++++
 .../x86/hp/hp-bioscfg/int-attributes.c        | 474 +++++++++
 .../x86/hp/hp-bioscfg/ordered-attributes.c    | 563 ++++++++++
 .../x86/hp/hp-bioscfg/passwdattr-interface.c  |  51 +
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 669 ++++++++++++++++++
 .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 405 ++++++++
 .../x86/hp/hp-bioscfg/string-attributes.c     | 451 ++++++++
 .../x86/hp/hp-bioscfg/surestart-attributes.c  | 130 +++
 16 files changed, 5299 insertions(+), 2 deletions(-)
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

