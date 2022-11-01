Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA2861555E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiKAW6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiKAW6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:58:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E727A1A20A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667343485; x=1698879485;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h3B1b8kOxLB+ep8phSxlZOYflbfFLBaAd9A06Q4+aAo=;
  b=XXxQCC2HV+HTZtN/ALRuXWyGt+yAa64B1fJXrK5bZTK2+lETINNl1JLM
   iGnmVu4Kt/JkCGRud8w52Zo9ucbAVJvu8zh3k1GTFcIWr3okVjfqYxCFE
   FAHS9RHtSBVAoLAbdxetglXVAYeuRswTLLqebU31mJtiBKchKx8bEgCfu
   D85AFYvogHAdmGlwAKTDzOdoDd/X7OsZOPioTlx7ZK0rkeadeKVxH3Jp+
   BxRAiQcEe3PlRS+14WrULbRfwBod8OzSeN0mFRNTE26G6uVxPCxwsGNA9
   J3lAIqXUw8rcBpkm0VXsVqziOsBJ6aF+yvEAuphiIPYq7C4mnX0bseNuF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="395572292"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="395572292"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 15:58:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="697575365"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="697575365"
Received: from leungcal-mobl.amr.corp.intel.com (HELO [10.212.136.36]) ([10.212.136.36])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 15:58:04 -0700
Message-ID: <74ab03dd-46c5-a79e-c256-e4e4ea0341e0@intel.com>
Date:   Tue, 1 Nov 2022 15:58:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RESEND PATCH v5] x86, mem: move memmove to out of line assembler
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, bp@alien8.de,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        dave.hansen@linux.intel.com, David.Laight@aculab.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, llvm@lists.linux.dev, luto@kernel.org,
        mingo@redhat.com, torvalds@linux-foundation.org, x86@kernel.org
References: <20221018172155.287409-1-ndesaulniers@google.com>
 <Y08NJohEeoYX2aIf@thelio-3990X> <202211011534.C31FC5ED6@keescook>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <202211011534.C31FC5ED6@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/22 15:36, Kees Cook wrote:
>> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Can an x86 maintainer please pick this up for -tip?

Queued it here:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/asm


