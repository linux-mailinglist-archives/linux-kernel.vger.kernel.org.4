Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98C06EBB87
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 23:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjDVVbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 17:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDVVbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 17:31:00 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DABC0198B;
        Sat, 22 Apr 2023 14:30:59 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pqKoq-0004RI-00; Sat, 22 Apr 2023 23:30:56 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 03F14C0135; Sat, 22 Apr 2023 23:30:42 +0200 (CEST)
Date:   Sat, 22 Apr 2023 23:30:42 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     ndesaulniers@google.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v2 0/2] MIPS: Fix check_bugs() modpost warning
Message-ID: <20230422213042.GA7318@alpha.franken.de>
References: <20230419-mips-check_bugs-init-attribute-v2-0-60a7ee65d4bf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419-mips-check_bugs-init-attribute-v2-0-60a7ee65d4bf@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 09:11:25AM -0700, Nathan Chancellor wrote:
> Hi all,
> 
> This series fixes a modpost warning visible in -next from check_bugs()
> and helps avoid a potential, albeit unlikely, warning from
> check_bugs_early().
> 
> ---
> Changes in v2:
> - Now two separate patches: one to avoid current check_bugs() warning
>   and one to avoid potential check_bugs_early() warning.
> - Sink body of check_bugs_early() into setup_arch() directly, rather
>   than marking it as __init (Nick).
> - Add Naresh's reported-by to patch 1, which came after v1 was sent.
> - Reword commit messages to note that there is not a problem at run time
>   because check_bugs() and check_bugs_early(), while not marked __init,
>   are only called from __init functions; modpost does not know this
>   though, hence the warning.
> - Link to v1: https://lore.kernel.org/r/20230419-mips-check_bugs-init-attribute-v1-1-91e6eed55b89@kernel.org
> 
> ---
> Nathan Chancellor (2):
>       MIPS: Mark check_bugs() as __init
>       MIPS: Sink body of check_bugs_early() into its only call site
> 
>  arch/mips/include/asm/bugs.h | 8 +-------
>  arch/mips/kernel/setup.c     | 3 ++-
>  2 files changed, 3 insertions(+), 8 deletions(-)
> ---
> base-commit: 6a8f57ae2eb07ab39a6f0ccad60c760743051026
> change-id: 20230419-mips-check_bugs-init-attribute-026103bdb255
> 
> Best regards,
> -- 
> Nathan Chancellor <nathan@kernel.org>

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
