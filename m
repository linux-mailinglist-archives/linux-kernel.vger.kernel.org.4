Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD466614F13
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKAQU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKAQUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:20:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C821C900
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667319623; x=1698855623;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SNm6rjp1B+V9CVysuR7iPvu4UoSaKbxpji8M1GDsvx4=;
  b=Wt9U8k1YqUkX+jbwqOJVf4ItImZpySZDtlCc05TSH1HKvF1AMYcOHz+P
   F41Rt9S9wwpJo6H4i08RC2KYTtv208OXbdTVpQmJDNx/x4tI5GVeqTlZf
   smnF/eBGjdvKu2Ze9PFUKPeEuVuY4VcjC+av7xXtdjPfs5jBYOpgYwFUS
   6xIhi6mJrS/25NhUILetifzHK4N9pxB2ewBeXSUyFOUjzTJzBc2NNr8n9
   NcZGcph06UuZ19OXXnx1vpNK4reLmPld6YOlxVqGYuYnWVTkokeaXCvyr
   aBYRl43iSEKVycawfQHMqT1ZDKP4iGPIbN/UuWZub70lz/LPhcJlgtfaH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="309175942"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="309175942"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 09:19:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="628623926"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="628623926"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga007.jf.intel.com with ESMTP; 01 Nov 2022 09:19:37 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2A1GJa8A019884;
        Tue, 1 Nov 2022 16:19:36 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] x86/boot: fix relying on link order
Date:   Tue,  1 Nov 2022 17:15:27 +0100
Message-Id: <20221101161529.1634188-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

From v1[0]:
 * collect the Tested-by tags (Jiri);
 * don't add pathetic returns after noreturn error() (Jiri);
 * debug-print the entry point offset via debug_putaddr() before
   booting (Jiri);
 * always have an empty line before return statements (Jiri). 

[0] https://lore.kernel.org/all/20221031151047.167288-1-alexandr.lobakin@intel.com

Alexander Lobakin (2):
  x86/boot: robustify calling startup_{32,64}() from the decompressor
    code
  scripts/head-object-list: remove x86 from the list

 arch/x86/boot/compressed/head_32.S |  2 +-
 arch/x86/boot/compressed/head_64.S |  2 +-
 arch/x86/boot/compressed/misc.c    | 16 ++++++++++------
 scripts/head-object-list.txt       |  6 ------
 4 files changed, 12 insertions(+), 14 deletions(-)

-- 
2.38.1

