Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F361608169
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJUWTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJUWS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:18:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0922ABA86
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666390718; x=1697926718;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ULBpQ5EN8N1NKghx8R1WO/yzugle/nugMiYF22untdc=;
  b=WCX1u7qZ/OGjZ+XpJuIX7K+teHhZufJJQFPqojgxq/R+9ymMLpXNeQ3P
   MqehnkjYRTsfqZBzxYHTD5Xl00+7C3fBYyk6kzG01gVPER56M8NpBhH7x
   tK2wqEMuRO1S5f5tttzafadJ8wM6mQlOd2yEsmTBTFveETS3OYYDVbkGF
   S91sIuQM223Vct3B9Snxx0qKDQbWqfcVBf9x1rX63cTiCjP9pAa+KxIXE
   RaLKE59JPJrCq18cWeRw9ytghm7+pDMypM6SBXdBAxl7PzRUP5ybn7sDt
   p2wsWexRVDKkEWd+9q8WL14PsktZz/QUHj3v190/qWVEiXb2eMgdUW53Y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369181092"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="369181092"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:18:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="959808500"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="959808500"
Received: from sanekar-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.5.12])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:18:36 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com,
        keescook@chromium.org, ebiederm@xmission.com
Subject: [PATCH 0/2] Regset cleanups
Date:   Fri, 21 Oct 2022 15:18:01 -0700
Message-Id: <20221021221803.10910-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two cleanups came out of the shadow stack series[0]. Resending them
separately for earlier consideration. They were also posted as separate
cleanups once before[1]. Note, Eric Biederman had suggested to change the
pre-existing format of REGSET_FOO32 to REGSET32_FOO. This was missed in an
earlier revision, and the changes are now added in this version.

There should be no functional change. To verify this, testing included checking
for binary differences in ptrace.o by:
 1. Have the config be a 64 bit kernel with CONFIG_IA32_EMULATION=y
 2. Adjust stock v6.1-rc1 and these changes to have the same line numbers for
    the bulk of the code in ptrace.c by adding blank lines.
 3. Remove BUILD_BUG_ONs() from new changes.
 4. strip and objdump both versions.
 5. Compare and find disassembly was identical.

[0] https://lore.kernel.org/lkml/20220929222936.14584-1-rick.p.edgecombe@intel.com/
[1] https://lore.kernel.org/lkml/20220315201706.7576-1-rick.p.edgecombe@intel.com/


Rick Edgecombe (2):
  x86: Separate out x86_regset for 32 and 64 bit
  x86: Improve formatting of user_regset arrays

 arch/x86/kernel/ptrace.c | 174 ++++++++++++++++++++++++---------------
 1 file changed, 108 insertions(+), 66 deletions(-)


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.17.1

