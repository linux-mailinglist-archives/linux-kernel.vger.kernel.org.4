Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FB3677F91
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjAWPY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjAWPYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:24:12 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3CE110439;
        Mon, 23 Jan 2023 07:23:40 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0D16B20E2D02;
        Mon, 23 Jan 2023 07:23:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D16B20E2D02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1674487385;
        bh=7TNJ2WIfSIYuwj2O7qe++FA04VZR5MAYU2yAGmNDdFA=;
        h=From:To:Cc:Subject:Date:From;
        b=Wj+eKekO/LSI+nhLw7leLdjlsN8jdoRSQw+pP90GAr0gW5aWiGqydq+tnXYvIQMBF
         cXu+DGC8Pwlo8YXL9Ubh31tTkXueZYA6nUlxxNSdo11dg5F0956AJXbS3nHofvXzO+
         vjEfEBB7gPaewIQLfLxzRd9XXQMG+/8LFq7RimDI=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: [PATCH v1 0/8] Support ACPI PSP on Hyper-V
Date:   Mon, 23 Jan 2023 15:22:42 +0000
Message-Id: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces support for discovering AMD's PSP from an ACPI
table and extends the CCP driver to allow binding to that device on x86. This
method of PSP discovery is used on Hyper-V when SNP isolation support is
exposed to the guest. There is no ACPI node associated with this PSP, so after
parsing the ASPT it is registered with the system as a platform_device.

I was not quite sure about where to place some of this code but opted for
placing the ASPT parsing code in drivers/acpi/ and the platform device creation
in arch/x86/ because configuring the irq for the PSP through the ACPI interface
requires poking at bits from the architectural vector domain. This was also
inspired by the sev-guest device.

This series is a prerequisite for nested SNP-host support on Hyper-V but is
independent of the SNP-host support patch set. Hyper-V only supports nested
SEV-SNP (not SEV or SEV-ES) so the PSP only supports a subset of the full PSP
command set. Without SNP-host support (which is not upstream yet), the only
PSP command that will succeed is SEV_PLATFORM_STATUS.

Jeremi Piotrowski (8):
  include/acpi: add definition of ASPT table
  ACPI: ASPT: Add helper to parse table
  x86/psp: Register PSP platform device when ASP table is present
  x86/psp: Add IRQ support
  crypto: cpp - Bind to psp platform device on x86
  crypto: ccp - Add vdata for platform device
  crypto: ccp - Skip DMA coherency check for platform psp
  crypto: ccp - Allow platform device to be psp master device

 arch/x86/kernel/Makefile          |   2 +-
 arch/x86/kernel/psp.c             | 213 ++++++++++++++++++++++++++++++
 drivers/acpi/Makefile             |   1 +
 drivers/acpi/aspt.c               | 104 +++++++++++++++
 drivers/crypto/ccp/sp-dev.c       |  67 +++++++++-
 drivers/crypto/ccp/sp-dev.h       |  16 ++-
 drivers/crypto/ccp/sp-pci.c       |  48 -------
 drivers/crypto/ccp/sp-platform.c  |  73 +++++++++-
 include/acpi/actbl1.h             |  46 +++++++
 include/linux/platform_data/psp.h |  32 +++++
 10 files changed, 544 insertions(+), 58 deletions(-)
 create mode 100644 arch/x86/kernel/psp.c
 create mode 100644 drivers/acpi/aspt.c
 create mode 100644 include/linux/platform_data/psp.h

-- 
2.25.1

