Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408726139D3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiJaPQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJaPQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:16:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9991114D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667229399; x=1698765399;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4++IyYJ8OpehOQHF4kDtDXvNgj+srzG4CNF9T4lsNHk=;
  b=j8Y+tcmD1ZiMsaPnc6UqI1Je2kJPkIdSMJEurQft6Fve6Glmf3F+EF68
   zfGffo0IzJs1DO2GOCyHH5jED1UZiiA1AdOmZY/4Yu0OB04eeek0y84zO
   t4nsjDoDJzamiWcD2+TF1sSb/pf74utEd7TQwhx4sAc31GSC9p1TIzDz2
   V/ZnjTSjnFj5eCONbUXnOQDYkw/7kvIE0z+7t+O/6gMQJtH8SPgxbEs1u
   iphyK/BOBME4kSFcg3+6F29T31sZSqHc7bFUXZz7HvJry64OOBkwEGHbK
   ZxMZM8dhL82LdofPAbJPVTz//wTsGqPcyCYFWWkuTzwRJ5HwIqG5rKI7D
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="373134128"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="373134128"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 08:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="697045596"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="697045596"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga008.fm.intel.com with ESMTP; 31 Oct 2022 08:16:35 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 29VFGXGD008839;
        Mon, 31 Oct 2022 15:16:33 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2]  x86/boot: fix relying on link order
Date:   Mon, 31 Oct 2022 16:10:45 +0100
Message-Id: <20221031151047.167288-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series contains stuff I caught last week while working on some
x86 code. It can be considered a material for fixes or for next,
I'm okay with either, although leaning more towards fixes :P

Notes on patches:
* 0001: I didn't put any "Fixes:" tag since it's not linear. The
        lines changed with this patch came from the initial x86
        KASLR series, but that unconditional jump to the kernel
        beginning already was there. It goes at least from the set
        that brought relocatable kernel support to x86, but this
        is quite prehistoric already and might not look really
        relatable. So up to you whether it needs any.
* 0002: doesn't fix anything, except that having any files listed
        in that whitelist already is an architecture bug :D And
        it wouldn't be convenient to decouple it from #0001, but
        up to you as well.

Alexander Lobakin (2):
  x86/boot: robustify calling startup_{32,64}() from the decompressor
    code
  scripts/head-object-list: remove x86 from the list

 arch/x86/boot/compressed/head_32.S |  2 +-
 arch/x86/boot/compressed/head_64.S |  2 +-
 arch/x86/boot/compressed/misc.c    | 16 +++++++++++-----
 scripts/head-object-list.txt       |  6 ------
 4 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.38.1

