Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2B6740D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjF1Jca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjF1J1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:27:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDC52947
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:26:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so6349743f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687944376; x=1690536376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qKK5utJ9WUOCHYsz3PoXdTZVo2YNgLhQoii2fNTDAo=;
        b=RCxuizjrqEplk6mORLmvlUHF4+4hHCL3E6cWQhBwxYCxsHEyTkxt04mYDp1cbrFxQI
         7A4AJrDbuGfSipMPXa91qOFk7iz4RJ8lWqhZvwg8fxZ54tvNpoJy24mfzD8s3DGu82E9
         0GT49xLXsE8ml8GfMdRIxYIwPZGZoOIGcqUMMiYW9GSNfzh1ijXEObap7krCL5xbSIyI
         fClOtL4dUlG411/oCPkgH86RMo94aGddLHn/wQk5unvzd3BXk04SOlSj2N+YYZvaI4hm
         4aSwMCRPY9dFwKvayjBdBRi2kj5VTIM+b1V17jKeTJ/ZSJnYDRMvwsKPnwpmBCIyROKG
         tsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687944376; x=1690536376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qKK5utJ9WUOCHYsz3PoXdTZVo2YNgLhQoii2fNTDAo=;
        b=BnyFPk6sr7ncb4bd9OfShGZnBPoAjGx+yQUZiU94Ab+0UDtsR4TnMPSO+OwuTrJtAw
         doKQdEDUgNEmsaF0X6uqntmfXW5XDJHByVM/ceQvQ0YH3or216u9Q83HODIKVdDVIo8v
         RfeI24BqucuIQ1V+lLnPe40jPGzVLXDepmhAMC6Jksk+tTNN1d6m6k45D7wy16VQf/Rc
         xvH3S7lIOn4bZ9zRDOV9gN9IzMfxr+l1BLg7Llv8xUhF+fSRWBssClscMw+FQ+ob4Ul7
         Xo7YMrNSfNFzq4d9MyI2nRcw2IAeCDn9KtdYWV85+8bkhi2s3/352dN/QBwQtjA/RCXu
         draw==
X-Gm-Message-State: AC+VfDx67ZxFmd/5JFxiVztxyupVEwhrbLvKfClTXg5rcDVuddumI4LT
        n3DLs4jKplpxlVrodidptdpkEVX3XRs=
X-Google-Smtp-Source: ACHHUZ4syAPqSUYjrywb4iMzOiDw/YZi2hjqp7H/voc1D+bTdLaLkgvkaDzuUQ7yJ8WazOMk2fYiCw==
X-Received: by 2002:a5d:58d8:0:b0:313:e2a2:fc80 with SMTP id o24-20020a5d58d8000000b00313e2a2fc80mr10134350wrf.33.1687944375548;
        Wed, 28 Jun 2023 02:26:15 -0700 (PDT)
Received: from gmail.com ([31.46.247.226])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d4c41000000b0030ae499da59sm12721365wrt.111.2023.06.28.02.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 02:26:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 28 Jun 2023 11:26:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] objtool: Remove btrfs_assertfail() from the noreturn
 exceptions list
Message-ID: <ZJv8s7RZvAtKpG8L@gmail.com>
References: <ZJrGGfFl4MHEeftI@gmail.com>
 <ZJrMJYz285GLB881@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJrMJYz285GLB881@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > Linus,
> > 
> > Please pull the latest objtool/core git tree from:
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2023-06-27
> > 
> >    # HEAD: 301cf77e21317b3465c5e2bb0188df24bbf1c2e2 x86/orc: Make the is_callthunk() definition depend on CONFIG_BPF_JIT=y
> 
> I forgot to mention that there's a new conflict when you merge this, in 
> tools/objtool/check.c, plus a semantic conflict in the new 
> tools/objtool/noreturns.h file - to remove the 'btrfs_assertfail' entry 
> from the new tools/objtool/noreturns.h file.
> 
> Our -tip CI conflict resolution can be double checked here:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/merge

I believe the (minor & silent) semantic conflict was overlooked in your 
upstream merge:

      6f612579be9d Merge tag 'objtool-core-2023-06-27' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

I've fixed it up with the attached patch.

[ There was no harm done to build correctness or functionality AFAICS, 
  because the extra leftover entry in upstream tools/objtool/noreturns.h is 
  now meaningless, as btrfs_assertfail() has become a macro that will not 
  show up as an ELF symbol. ]

Thanks,

	Ingo

======================>
From: Ingo Molnar <mingo@kernel.org>
Date: Wed, 28 Jun 2023 11:16:03 +0200
Subject: [PATCH] objtool: Remove btrfs_assertfail() from the noreturn
 exceptions list

Upstream merge commit:

  6f612579be9d Merge tag 'objtool-core-2023-06-27' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

... generated a (minor) semantic conflict that was not resolved: the btrfs_assertfail()
entry that was removed from the list in tools/objtool/check.c in:

  b831306b3b7d ("btrfs: print assertion failure report and stack trace from the same line")

... because btrfs_assertfail() was changed from a noreturn function into
a macro.

But the list was moved to a different file, in a different enumeration format:

  6245ce4ab670 ("objtool: Move noreturn function list to separate file")

And has to be removed from tools/objtool/noreturns.h post-merge as well.

Do it explicitly.

Cc: David Sterba <dsterba@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/noreturns.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index 1514e84d5cc4..e45c7cb1d5bc 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -14,7 +14,6 @@ NORETURN(__stack_chk_fail)
 NORETURN(__ubsan_handle_builtin_unreachable)
 NORETURN(arch_call_rest_init)
 NORETURN(arch_cpu_idle_dead)
-NORETURN(btrfs_assertfail)
 NORETURN(cpu_bringup_and_idle)
 NORETURN(cpu_startup_entry)
 NORETURN(do_exit)
