Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BCE74881D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjGEPeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjGEPe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:34:29 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24237171C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:34:28 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-5.bstnma.fios.verizon.net [173.48.102.5])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 365FY5s4025721
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jul 2023 11:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688571251; bh=PxGfltF6c2E6Vt1/VG/UEQXjz/2rYU3qwRGE/kZ15tA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=R7BeBsCH1h0L32dAtFswGvJD4QioXcZgo9EBmkJn6JkhNgjmsuLJb71GkLoRwFfHI
         2tm0WOuxakbWjCsSYmWkcNGJ9UZPmndS6lUaCS2FbEnWImLxIxBXOpPtpjCt7APfO0
         8J8LevpZDepGqdOBp1Ox5sZzjk1nHAVOrHuHcdYssRFnz/2LTCuLXb22mEJh50xHbU
         4nmggvdsORDckBL6wmhHLlOD6pCMpGP0BEYWN4L7SXLxiO+Zia1biDi9VqVQUycJ7o
         dIHAYV6CS6bYvRycSDOf4K3YqGJv7fRuM/PmEQ3na5V2KccNshnLHh6CI0B3rF451l
         7QQwYqRHpyz9w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6979C15C0294; Wed,  5 Jul 2023 11:34:05 -0400 (EDT)
Date:   Wed, 5 Jul 2023 11:34:05 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Overly aggressive .gitignore file?
Message-ID: <20230705153405.GA1382903@mit.edu>
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
 <CAK7LNAQas0cK7pgi72tYC3yU=ZkQxnr41YYW1mXd-sWiHtG+UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQas0cK7pgi72tYC3yU=ZkQxnr41YYW1mXd-sWiHtG+UA@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:59:28AM +0900, Masahiro Yamada wrote:
> Perhaps, a slightly similar case is *.patch.
> (We do ignore *.patch)
> 
> People quite often run 'git format-patch'.
> And, the generated patches have similar prefixes.
> (0001-, 0002-, 0003-, ..., for good reasons)
> 
> The autocomplete does not work if 000* files
> exist from the previous time I ran 'git format-patch'.
> I repeatedly run 'rm -f 00*' even if 'git status' does not show them.

Autocomplete "works", in so far that if you type 0<TAB>, it will
autocomplete up to 000 and then ring the terminal bell, at which point
I'll type say, 1<TAB>, and then if there are previous *.patch files,
it will ring the terminal bell again, and then if you type <TAB> a
second time, it will list the possible autocompletes.

I will also say that since of "rm -f <pattern includes a '*'>" is too
easy to accidentally screwup and delete something I would care about,
my solution is "git format-patch -o /tmp/p ...", since then I can
clear out the files by typing "rm -r /tmp/p".

Cheers,

					- Ted

P.S.  Also note that "git format-patch" will automatically create
/tmp/p if it doesn't exist, unlike how b4 works with the -o option.
