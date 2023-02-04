Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD568AB9E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 18:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjBDRWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 12:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBDRWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 12:22:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88732DE7D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 09:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8OAKmxWIEzbaWOmDMgmo8UdlEP+FyQwFTksNrLzmP30=; b=d2l1OHMR3M4pCRMdi/vvI2Gstn
        yjCGH+H5nrhmlUMM5c2mw5g1pk+vhIhM8GXEIQ+A6BTwWjmHMCqeUYii87rnz7KKPTkT1DUiVBzBE
        bn46r8bmml+5bgK865xdihdfEaDElGiANbAam2VC76DXSbIfv1+ZpIFac6bsnDRUrDB6QZMXbok1F
        rdZaM1yRMGz7/Ehc4MPsuOZOOE+MGk0EI8YP5GYNYKUbE8FoWjlm/t+2pem1Rkw6/EwfeGPnSPiMw
        zmoPwW5KYw8EP8ysLNdWDAmfIFsfPl+7TRv5MBp9bwXqIowTnBiejB4G+EkMCGzOHMIJutAdyci1K
        kPxQHKyw==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOMEp-005RDq-OO; Sat, 04 Feb 2023 17:22:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kexec_file: fix implicit decl error
Date:   Sat,  4 Feb 2023 09:22:06 -0800
Message-Id: <20230204172206.7662-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kexec (PPC64) code calls memory_hotplug_max(). Add the header declaration
for it from <asm/mmzone.h>. Using <linux/mmzone.h> does not work since
the #include for <asm/mmzone.h> depends on CONFIG_NUMA=y, which is not
set in this kernel config file.

Fixes this build error/warning:

../arch/powerpc/kexec/file_load_64.c: In function 'kexec_extra_fdt_size_ppc64':
../arch/powerpc/kexec/file_load_64.c:993:33: error: implicit declaration of function 'memory_hotplug_max' [-Werror=implicit-function-declaration]
  993 |                 usm_entries = ((memory_hotplug_max() / drmem_lmb_size()) +
      |                                 ^~~~~~~~~~~~~~~~~~

Fixes: fc546faa5595 ("powerpc/kexec_file: Count hot-pluggable memory in FDT estimate")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kexec/file_load_64.c |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -26,6 +26,7 @@
 #include <asm/firmware.h>
 #include <asm/kexec_ranges.h>
 #include <asm/crashdump-ppc64.h>
+#include <asm/mmzone.h>
 #include <asm/prom.h>
 
 struct umem_info {
