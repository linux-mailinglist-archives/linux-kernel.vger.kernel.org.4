Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B12614E94
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiKAPq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiKAPq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:46:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3092EF5BA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667317615; x=1698853615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JH/9IndlqC0kFmEQVXJIchi6cPTgR0x9pFcVbHHM06c=;
  b=kguMFbUftObj+bj2iyGztHbaY441sqvSAY0dfdqYwYGZTROcdSp3tyFT
   CNU9SwlbrnZB3oPMcS/fGlGIp0OtZc67KaSmsb8YhDdbxjJW6OgPLqVgN
   5C3km9+bRFh8l6YZON0dJJ6rkgjCMq9Yr4TV7TEF4iNSUr/ErosdebFg7
   9eZuY3O7cVrQbizgFSXmYseM5G8uH8H0w0VNHBDwRlBQvmxROCZTjB3hK
   tOmwuAX68pi5CO1NNP/h9BGxI0sVHsAodPp657GRKlh4qck4wUOIT7etI
   2DTmFFKiqHghwjOGSMyYZslyDuaToJvju4X8hrt5sQakJrDicM/r7RLy/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="373382637"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="373382637"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:46:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="636438929"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="636438929"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga007.fm.intel.com with ESMTP; 01 Nov 2022 08:46:51 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2A1FknW4015165;
        Tue, 1 Nov 2022 15:46:50 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/boot: robustify calling startup_{32,64}() from the decompressor code
Date:   Tue,  1 Nov 2022 16:44:41 +0100
Message-Id: <20221101154441.976294-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <454A126A-1E27-4A5C-9073-4E72D3D23B5A@zytor.com>
References: <20221031151047.167288-1-alexandr.lobakin@intel.com> <20221031151047.167288-2-alexandr.lobakin@intel.com> <454A126A-1E27-4A5C-9073-4E72D3D23B5A@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 31 Oct 2022 13:31:05 -0700

> On October 31, 2022 8:10:46 AM PDT, Alexander Lobakin <alexandr.lobakin@intel.com> wrote:
> >After commit ce697ccee1a8 ("kbuild: remove head-y syntax"), I
> >started digging whether x86 is ready from removing this old cruft.
> >Removing its objects from the list makes the kernel unbootable.
> >This applies only to bzImage, vmlinux still works correctly.
> >The reason is that with no strict object order determined by the
> >linker arguments, not the linker script, startup_64 can be placed
> >not right at the beginning of the kernel.
> >Here's vmlinux.map's beginning before removing:

[...]

> >-	return output;
> >+	return output + off;
> > }
> > 
> > void fortify_panic(const char *name)
> 
> Put the entry points in dedicated sections and declare them explicitly in the linker script (the standard name for this section would be .init, but we presumably want .init.32 and .init.64 to keep 32- and 64-bit code in separate sections.)

Uhm, I'm not sure I follow. We're trying to eliminate as much
hardcode as possible, and now you propose to introduce new :P
Some architectures don't have a separate .head.text at all: startup
functions are placed in .init.text, preboot code finds the entry
point and it just works. It's not possible currently on x86_64, but
we'll be there one day.

Thanks,
Olek
