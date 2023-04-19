Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CD66E7D78
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjDSOvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjDSOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:51:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD9D1BF6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:51:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C372A1FD91;
        Wed, 19 Apr 2023 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681915908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aMdPcxnwSRjwkYQwhc08+JCB6JrLB3Opn8DwV5ja/b4=;
        b=aP19408rhvyzqbLhP51ve5CXnmb6FjpOny8h3MN5MO9aOK/1wtSTlDVfzltvFCTL4uNx74
        5O4kwxyZimTEbmST24PheU8q2W5NEu2i6Ds4Gq0MOyxGrXMZ8C3rGJqmevDtagvjvXH930
        YGeHQCM54GHghUQDVfazoi8d/+Bk0Ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681915908;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aMdPcxnwSRjwkYQwhc08+JCB6JrLB3Opn8DwV5ja/b4=;
        b=iFOnXmOIRK80/CezY3ZJMr5qTmDjOME8exBI+w5NlQVJZc9LnILk2SuGECu8h+5UclkJbc
        W2GAM3MOKaNV2+Cg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A1A302C141;
        Wed, 19 Apr 2023 14:51:48 +0000 (UTC)
Date:   Wed, 19 Apr 2023 16:51:48 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 0/8] objtool: warning improvements
In-Reply-To: <cover.1681853186.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2304191651340.14485@pobox.suse.cz>
References: <cover.1681853186.git.jpoimboe@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023, Josh Poimboeuf wrote:

> v3:
> - dropped merged patches and rebased on tip/objtool/core
> - moved list of noreturn functions to separate file
> - improved WARN_INSN() to do single evaluation of insn arg
> 
> Josh Poimboeuf (8):
>   objtool: Limit unreachable warnings to once per function
>   objtool: Add verbose option for disassembling affected functions
>   objtool: Include backtrace in verbose mode
>   objtool: Detect missing __noreturn annotations
>   objtool: Ignore exc_double_fault() __noreturn warnings
>   objtool: Remove superfluous global_noreturns entries
>   tools/lib/subcmd: Replace NORETURN usage with __noreturn
>   objtool: Move noreturn function list to separate file
> 
>  tools/lib/subcmd/parse-options.h        |   8 +-
>  tools/lib/subcmd/subcmd-util.h          |   5 +-
>  tools/objtool/Documentation/objtool.txt |  10 ++
>  tools/objtool/builtin-check.c           |   5 +
>  tools/objtool/check.c                   | 195 ++++++++++++++++--------
>  tools/objtool/include/objtool/builtin.h |   1 +
>  tools/objtool/include/objtool/elf.h     |   1 +
>  tools/objtool/include/objtool/warn.h    |  21 ++-
>  tools/objtool/noreturns.h               |  45 ++++++
>  9 files changed, 214 insertions(+), 77 deletions(-)
>  create mode 100644 tools/objtool/noreturns.h

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
