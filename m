Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA6764CDF8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbiLNQ1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbiLNQ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:27:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32195F98;
        Wed, 14 Dec 2022 08:27:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B57661B45;
        Wed, 14 Dec 2022 16:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA2EC433D2;
        Wed, 14 Dec 2022 16:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671035261;
        bh=sJ2dZlXlxbHZMLCuBdc37LA6k6jU4IYfv3YtQbdOTxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ocgdoyR03oml0AaBujgZuxX24w3KfCJBJBtRhcGRkOM71IEswAY7PsZUiZ5hGTI7X
         AxPuWvAwN8nOAJzT9VxaMMtNIwLXR3qMsfJerjzkMM7g3dxg4QG7vS7kSfzVrDXAep
         yh2ZpQdpghtbnmE8IDFPMV9AdM016IP0jLocXdmdBejeFpebKythqNPw06OfsaQTVH
         TDtM45gPZWpXPrkHuF1QEtxcl8rwmP0jrGPBWp6ptWTLiaE1mnw6P/pO2P/D77UPOS
         D3djAjY4oMrIZ8P3R+YegTOR4+8ETiOV0ox8aqnJMs/DqW9Wu1AF0ASjyssNKBnyHD
         Qq9qhL+G5yO/A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A591A40367; Wed, 14 Dec 2022 13:27:38 -0300 (-03)
Date:   Wed, 14 Dec 2022 13:27:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] tools: perf: Use "grep -E" instead of "egrep"
Message-ID: <Y5n5esPQ0QkBpgda@kernel.org>
References: <1668762999-9297-1-git-send-email-yangtiezhu@loongson.cn>
 <CAP-5=fXR58DQFkUW81KUs_f9cLTX=L28H1hkxXVzX3dUdRLBjw@mail.gmail.com>
 <ab41b1fe-4a59-2a6b-ee9f-785c98c48df5@loongson.cn>
 <CAP-5=fWtFktYKch+4Sv4zSHoW8SO96yEsyQgDKApyR20UjXhSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWtFktYKch+4Sv4zSHoW8SO96yEsyQgDKApyR20UjXhSA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 21, 2022 at 08:52:47AM -0800, Ian Rogers escreveu:
> On Sun, Nov 20, 2022 at 6:59 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> >
> >
> > On 11/20/2022 02:17 AM, Ian Rogers wrote:
> > > On Fri, Nov 18, 2022 at 1:17 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> > >>
> > >> The latest version of grep claims the egrep is now obsolete so the build
> > >> now contains warnings that look like:
> > >>         egrep: warning: egrep is obsolescent; using grep -E
> > >> fix this up by moving the related file to use "grep -E" instead.
> > >>
> > >>   sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/perf`
> > >>
> > >> Here are the steps to install the latest grep:
> > >>
> > >>   wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
> > >>   tar xf grep-3.8.tar.gz
> > >>   cd grep-3.8 && ./configure && make
> > >>   sudo make install
> > >>   export PATH=/usr/local/bin:$PATH
> > >>
> > >> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > >
> > > Hi Tiezhu,
> > >
> > > installing a newer grep tool in order to build/test perf is somewhat
> > > burdensome, as such I don't think we should merge this change. Looking
> > > at my Debian derived distro. I have grep 3.7, so I'd need to do this.
> > > I imagine the majority of people are using a grep earlier than 3.8. I
> > > agree there is a problem perhaps we can:
> > >  - rewrite to just need grep and not egrep;
> > >  - rewrite in a stable language with regex support, perhaps python;
> > >  - have a grep/egrep wrapper that selects based on version number.
> > >
> >
> > Hi Ian,
> >
> > I found this issue on Linux From Scratch system which uses grep 3.8 [0],
> > we can see the following NEWS in grep-3.8 release announcement [1]:
> >
> > "The egrep and fgrep commands, which have been deprecated since
> >   release 2.5.3 (2007), now warn that they are obsolescent and should
> >   be replaced by grep -E and grep -F."
> >
> > Additionally, the next grep rpm/deb version is 3.8 on Fedora [2]
> > and Debian [3], so use "grep -E" instead of "egrep" so we won't see
> > the warning for various versions of grep.
> >
> > [0] https://linuxfromscratch.org/~thomas/multilib/chapter06/grep.html
> > [1] https://savannah.gnu.org/forum/forum.php?forum_id=10227
> > [2] https://packages.fedoraproject.org/pkgs/grep/grep/fedora-rawhide.html
> > [3] https://packages.debian.org/sid/grep
> >
> > Thanks,
> > Tiezhu
> 
> Thanks Tiezhu,
> 
> My grep is 3.7 and has -E support. In the changelog I see:
> 
> ```
> 2021-08-14  Jim Meyering  <meyering@fb.com>
> 
>        version 3.7
>        * NEWS: Record release date.
> ```
> 
> So I'm guessing 3.8 is newer than is necessary for this change, but
> demonstrates the warning issue your change addresses. Arnaldo's build
> compatibility scripts should be able to spot further issues.
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

