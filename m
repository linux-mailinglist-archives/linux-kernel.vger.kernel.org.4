Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E193460C5DE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJYHxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiJYHx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:53:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A02167266;
        Tue, 25 Oct 2022 00:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666684408; x=1698220408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r7S3mOEcqGZPkBpgreetd4wIQYH9cpt8uSJwUzBHaYc=;
  b=WiYGutWddc+7b7g3V7NUmJ6o7l1mwJXiugLfiosb9NvlEug1vL/CPws/
   n0aXLJqGpE6d7GkpIwBlYjaFsaTDFe3bMTnw0qwEDI0+w8poD2nocbtcG
   uECPucdOD0i0tdvDCPwOEgF1+U/R2CCHVb4tBDnz5To9a5NKMzfKyXkoC
   yDGR9LIX+GHHtHkvEGoM09sR8C38jrpKv48+keHvTTRV7tlK9KgsyqlQu
   qcrIl9jjM44a4jUof3gZdPig61ysoTXadniHKb55iwoGQ4ZVoMBhq0hzn
   jlU5nGOv/U0h1HFYXgEzkuPxIJaf3OItihlGdchvSF/47bpJilK+KMb9Y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="290916769"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="290916769"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 00:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="736725627"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="736725627"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga002.fm.intel.com with ESMTP; 25 Oct 2022 00:53:26 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, x86@kernel.org
Cc:     nathan@kernel.org, keescook@chromium.org,
        andrew.cooper3@citrix.com, hpa@zytor.com, peterz@infradead.org
Subject: [PATCH v2 0/1] kbuild: upgrade the orphan section warning to an error if CONFIG_WERROR is set
Date:   Tue, 25 Oct 2022 00:30:22 -0700
Message-Id: <20221025073023.16137-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Cooper suggested upgrading the orphan section warning to a hard link
error. However Nathan Chancellor said outright turning the warning into an
error with no escape hatch might be too aggressive, as we have had these
warnings triggered by new compiler generated sections, and suggested turning
orphan sections into an error only if CONFIG_WERROR is set. Kees Cook echoed
and emphasized that the mandate from Linus is that we should avoid breaking
builds. It wrecks bisection, it causes problems across compiler versions, etc.

Change since v1:
* Introduce a new Kconfig item CONFIG_LD_ORPHAN_WARN_LEVEL to replace
  (if $(CONFIG_WERROR),error,warn) (Nathan Chancellor).

Xin Li (1):
  kbuild: upgrade the orphan section warning to an error if
    CONFIG_WERROR is set

 Makefile                          |  2 +-
 arch/arm/boot/compressed/Makefile |  2 +-
 arch/arm64/kernel/vdso/Makefile   |  2 +-
 arch/arm64/kernel/vdso32/Makefile |  2 +-
 arch/x86/boot/compressed/Makefile |  2 +-
 init/Kconfig                      | 15 ++++++++++++---
 6 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.34.1

