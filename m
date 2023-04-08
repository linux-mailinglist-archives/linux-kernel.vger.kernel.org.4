Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69116DB8F6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 06:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDHE40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 00:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjDHE4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 00:56:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FF2CA01
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 21:56:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 062AF61545
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 04:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA0FC433D2;
        Sat,  8 Apr 2023 04:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680929781;
        bh=3k2Pl+dZy+mhR1dngOYtBiIpmXB21t7Xe0d4P1VZSZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OaDlsaYo6V5yScNVYSS8oS1cCCu3r2wIFkNL9zFefiZoUxfAmVq6UEj1DFMOE/KBq
         kGzATEDpqvSW+Q6WFJeoA9Akle5BSS79hesoClIgcgBtRgskB1rGwFBHviEwFhuGkA
         LZ7ARRLiqkbY6kiiW7IZ8SYf/bMlt7ZtsqOKndSfSVAHEG6Ymywl+ywr4MVskKUMce
         z+qeBNzanU1zIBlQVbNeU1giAQnmk5yekNoi/a0d8dVBh0GLR/GHYX3v0yaIX/uF//
         0tjC5yDuvVj4M81QbdpmxbScC2tGyDOycPKnhsZl0WwygbMXqUy9FOW4JRiP9M3jR7
         DadDcIspuH82A==
Date:   Fri, 7 Apr 2023 21:56:19 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     peterz@infradead.org, keescook@chromium.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/2] x86: make profile_pc() use arch_stack_walk()
Message-ID: <20230408045619.m5zfbispodf4zjvz@treble>
References: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
 <20230330081552.54178-2-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230330081552.54178-2-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 04:15:51PM +0800, Qi Zheng wrote:
> The profile_pc() try to get pc by doing a trick to read
> the contents of the stack. This may cause false positives
> for KASAN, like the following:
> 
>  BUG: KASAN: stack-out-of-bounds in profile_pc+0x5b/0x90
>  Read of size 8 at addr ffff8881062a7a00 by task id/130040

I don't think this was actually a false positive.  The !FRAME_POINTER
code in profile_pc() has been badly broken for many years.

BTW, there was a similar patch here:

  https://lore.kernel.org/lkml/20230224021858.120078-1-chenzhongjin@huawei.com/

I thought CONFIG_PROFILING was obsolete but Andi said previously he
wants to keep it for at least boot-time profiling.

Andi did suggest removing the lock profiling hacks, which means all the
profile_pc() implementations can just be removed in favor of the generic
instruction_pointer().

-- 
Josh
