Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A445704095
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245755AbjEOWC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245717AbjEOWCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:02:34 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FD711B73;
        Mon, 15 May 2023 15:01:14 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5527167350bso1451447eaf.3;
        Mon, 15 May 2023 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684188063; x=1686780063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RNocRGH7KyBL79y9bxMlfFDjdi7MvVlxTfLw5Q7Lhis=;
        b=ZchuJoa5tXLNgjcL+mq2WFqz3zKm5JHmm0jmuXGWA1NX+Dv0DG3vT4esC7u55YnSdt
         O3uE5cBEVvVZV1yzbYq4WE5wBfBsfP3I4PgGyCcryn2LuQsVxNcg3CcrAXCtHYPRj1lA
         dc41sIGk7gRfBqbycsQ2qQOgpeuX23+km2OWRMFL0gis6Q4OVASNlTvkLIBgJomV7vo4
         dZAfvMfNX4o1if0YrolLIQ24Ku9mCJNGu3NEBcu5YhIeoRNfIvlgV/hhuWm7J0JTGJqs
         d0WxbU8RAuRl5y8Q5fg4YrPZ6U+IrNVG71w9RSFwi409UDuEavhg/pC0u+xg6MKnxomt
         D2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684188063; x=1686780063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNocRGH7KyBL79y9bxMlfFDjdi7MvVlxTfLw5Q7Lhis=;
        b=N5caANpRcoX9Hninj95EQz1+8TtYEFt0EcRT25L+JpypwzcMCIr/0Bqgg2GorsaYmR
         +BEIEXuTVkfLapCho/H3kv7hg71LEQyYl75h+eA/BxHEkm6THiGmEv+JdWncPgRvVbIk
         MwuTtdkNnku+wbiJ24cixqxWekWuXj2ZGk6VGhFKWA9Hw0aIAluzCXm0SSxAaEA1vdiA
         BgxMMPeDaYV8wZX0XKz1arY7PNZQrs8GOOHocnt8w2ZPg0t2xEeiP1Fb1WWyGcuR82Un
         HNTCMwY7mvwiZSWI8Hd0YdDbfYE2MXun7MSn0ZXwEqve0gsZTUwnXG0IXJKHms+FyPsi
         /VUQ==
X-Gm-Message-State: AC+VfDy/vh90PQPoNwLZXjYF9ZKDZh0oT2yrIpco5nJbEdIPvD0pyf5+
        DzRpGKw1f2fex9JuW+6DuG230LShJfw=
X-Google-Smtp-Source: ACHHUZ7a+9PbLeurLyepHoYdXaQQHUdFISBWhqlSvybr38hvoO3xGDsIbXt5fedVPAzxfsOIRUIKgg==
X-Received: by 2002:a4a:7606:0:b0:542:5d35:12a0 with SMTP id t6-20020a4a7606000000b005425d3512a0mr10958402ooc.3.1684188063069;
        Mon, 15 May 2023 15:01:03 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:5391:4539:59c2:4092])
        by smtp.gmail.com with ESMTPSA id i1-20020aca0c41000000b0038e07fe2c97sm5265148oiy.42.2023.05.15.15.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 15:01:02 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v13 00/13] hp-bioscfg driver
Date:   Mon, 15 May 2023 17:00:48 -0500
Message-Id: <20230515220101.39794-1-jorge.lopez2@hp.com>
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

Version 13
	Only patches marked [update] changed between version 12 and 13
	Sorted commit patches alphabetically
	Rename ordered-attributes to order-list-attributes

	Patches
	 Documentation 			[update]
	 biosattr-interface 		[update]
	 bioscfg 			[update]
	 bioscfg-h			[update]
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

Version 5
	Remove version 4 patch 1
	Address review changes proposed in Version 4
	Reorganize all patches number and file order




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

 .../testing/sysfs-class-firmware-attributes   | 102 +-
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
 .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 389 +++++++
 .../x86/hp/hp-bioscfg/string-attributes.c     | 404 +++++++
 .../x86/hp/hp-bioscfg/surestart-attributes.c  | 132 +++
 15 files changed, 4750 insertions(+), 2 deletions(-)
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

