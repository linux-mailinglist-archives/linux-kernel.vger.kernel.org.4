Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F1E614E81
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiKAPku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiKAPks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:40:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD16BCB1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667317247; x=1698853247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PdiefJ/kTbBD/wXr6en4XMshbMyVBy16hir1aWLoRr8=;
  b=ZAryAoXwRSNYpFrzxGzzKe2MgdibXt2y23KHncxTghxKkEtaqIy+j88W
   KiG+g1WpFTzoBadO2NGUvq8t31z3JIw2iSQFoE1u9OQhrdLHyLL5lPzEb
   tS7K9HiE1xGCqCuU+0JeIH+kHiPINKAOQg1AgslqC4QUO4IpTHbOg+vBx
   USOJbcnich6/tW5HHSAtEEIZ9XDw74gNqnhjTi/PpRAn8MOdDDpMxY99j
   llXPpEOvE3al3E/TOpx7q+m4G0PU8QtaQcSlyDpjwLwqGKvLUiHqwIzHA
   arYlUc2zuLK26xcw3Ee3GeOyaiplMP1fh+eAJw7Pejt0mFkq+LYVqOAB7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="306782398"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="306782398"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:40:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="739372473"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="739372473"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga002.fm.intel.com with ESMTP; 01 Nov 2022 08:40:45 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 2A1FehK2014382;
        Tue, 1 Nov 2022 15:40:43 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/boot: robustify calling startup_{32,64}() from the decompressor code
Date:   Tue,  1 Nov 2022 16:38:34 +0100
Message-Id: <20221101153834.975871-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <39ac78ea-1ee5-8911-1208-c56e57df7338@kernel.org>
References: <20221031151047.167288-1-alexandr.lobakin@intel.com> <20221031151047.167288-2-alexandr.lobakin@intel.com> <0fcbedf6-3eb5-75cd-cdd9-24582f70cc64@kernel.org> <39ac78ea-1ee5-8911-1208-c56e57df7338@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jirislaby@kernel.org>
Date: Tue, 1 Nov 2022 07:50:04 +0100

> On 01. 11. 22, 7:47, Jiri Slaby wrote:
> > Tested-by: Jiri Slaby <jirislaby@kernel.org>
> 
> FWIW that means: tested with gcc-lto which deliberately stores 
> startup_64() randomly, not to the beginning of vmlinux.

Yeah, you never know. After rebasing on top of 6.1-rc1 my FG-KASLR
series stopped booting, I found out that the combo of that
head-object-list.txt + -ffunction-sections (but for Asm) also made
startup_64() appear in random parts of .head.text.

Re head removal -- that would be awesome, but currently from what
I've tried during the development, there's a lot of stuff to be
redone, the compressor code sometimes just doesn't want to work
if you play with .head.text too much. Will see.

> 
> -- 
> js
> suse labs

Thanks,
Olek
