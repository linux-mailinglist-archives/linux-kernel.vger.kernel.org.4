Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37F76083D9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 05:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJVD2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 23:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJVD2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 23:28:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9892906AA;
        Fri, 21 Oct 2022 20:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666409307; x=1697945307;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S5WdQ+X2Dl9VyjKh6IQ4k1l6UBlilbtoCi4Mqd21SG4=;
  b=n/CXCyWk3gaie2WMXbgnrBHTMplFRbHvCYQ1hDJnT6OFD1Oh7sT+joq0
   akKS9yb/5ANg09i2EoVPD9TuWM3FcBREE7wA1UV7nSeCg/AmtFOGXfKU7
   qQQ1cIlX3bquVq4xlL57LwE8xjfR1G3jclKLuFmED5QGEsuVdBxvpdfFO
   4JdW0VozJr7LEhrs5BOMNzJ1XRwj6TwzgYmWy43BS4TTfIKvWRYkTIut0
   /3S8CuOmdB8zZo8aTBY1Gmm66dxICViPimwslugg86OdsZ0292XGb7E/E
   fm612KrC6jZX12XbXpEBGKRWXfcgraYZ8tx6wIik43VIoznMvt8ZyUsj5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="286869120"
X-IronPort-AV: E=Sophos;i="5.95,204,1661842800"; 
   d="scan'208";a="286869120"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 20:28:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="693955256"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="693955256"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 21 Oct 2022 20:28:26 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, x86@kernel.org
Cc:     nathan@kernel.org, keescook@chromium.org,
        andrew.cooper3@citrix.com, hpa@zytor.com, peterz@infradead.org
Subject: [PATCH 0/1] kbuild: upgrade the orphan section warning to an error if CONFIG_WERROR is set
Date:   Fri, 21 Oct 2022 20:05:18 -0700
Message-Id: <20221022030519.9505-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Xin Li (1):
  kbuild: upgrade the orphan section warning to an error if
    CONFIG_WERROR is set

 Makefile                          | 2 +-
 arch/arm/boot/compressed/Makefile | 2 +-
 arch/arm64/kernel/vdso/Makefile   | 2 +-
 arch/arm64/kernel/vdso32/Makefile | 2 +-
 arch/x86/boot/compressed/Makefile | 2 +-
 init/Kconfig                      | 9 ++++++---
 6 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.34.1

