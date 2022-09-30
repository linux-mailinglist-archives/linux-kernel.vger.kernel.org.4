Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B0F5F1031
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiI3Qnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiI3Qnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CCC197F0C;
        Fri, 30 Sep 2022 09:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A530C623D4;
        Fri, 30 Sep 2022 16:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60E5C433D6;
        Fri, 30 Sep 2022 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664556224;
        bh=SWtS+7E5mlewLIB2MxlC+wWCohwQYFyWnTQenJeGod0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7CI4KjNPEMk1U3lVKktJM1X0JJvE5XgFbHTG9w1gUOiQUiN+1IDCXcefKVxCE25J
         0Ltg5fe6i/jl3imt7Uf4FNOhmvwO1TmnHlNEJ1zUL4lGP6JJ0m6QTT0Jjg9Rp2yWee
         fxrmyR7an4ZqxVZPAd6BrKC2/6/nd+C+CoOdtpZGzqNOMbqwoW9zsYSj7N7tIQSLJx
         961YyQH69OB2/ubDF+8eZ5I0ewoT8U2gzjzw+MahmAaHqHz4UuFczZy9v+h8Das7uN
         CpI7EVNbhHHhgPfwxao9TZ5o2ynA8tdnESe9UCMPglLQ5clEoO1J4cpa4KQodQTOQT
         nITMqEbRikMcQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 772084062C; Fri, 30 Sep 2022 13:43:41 -0300 (-03)
Date:   Fri, 30 Sep 2022 13:43:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Will Chandler <wfc@wfchandler.org>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf tools: Fix empty version number when building
 outside of a git repo
Message-ID: <Yzccvf367WOK44U6@kernel.org>
References: <20220927195228.47304-1-wfc@wfchandler.org>
 <20220930151157.529674-1-wfc@wfchandler.org>
 <30a2631b-341c-8c41-52dd-becb40bfc4be@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a2631b-341c-8c41-52dd-becb40bfc4be@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 30, 2022 at 05:14:43PM +0100, John Garry escreveu:
> On 30/09/2022 16:11, Will Chandler wrote:
> > When perf is built in a full source tree that is not a git repository,
> > e.g. from a kernel source tarball, `perf version` will print empty tag
> > and commit strings:
> > 
> >    $ perf version
> >    perf version
> > 
> > Currently the tag version is only generated from the root Makefile when
> > building in a git repository. If PERF-VERSION-FILE has not been
> > generated and the source tree is not in a git repository, then
> > PERF-VERSION-GEN will return an empty version.
> > 
> > The problem can be reproduced with the following steps:
> > 
> >    $ wget https://git.kernel.org/torvalds/t/linux-6.0-rc7.tar.gz
> >    $ tar -xf linux-6.0-rc7.tar.gz && cd linux-6.0-rc7
> >    $ make -C tools/perf
> >    $ tools/perf/perf -v
> >    perf version
> > 
> > Builds from tarballs generated with `make perf-tar-src-pkg` are not
> > impacted by this issue as PERF-VERSION-FILE is included in the archive.
> > 
> > The perf RPM provided by Fedora for 5.18+ is experiencing this problem.
> > Package build logs[0] show that the build is attempting to fall back on
> > PERF-VERSION-FILE, but it is not present.
> > 
> > To resolve this, revert back to the previous logic of using the kernel
> > Makefile version if not in a git repository and PERF-VERSION-FILE does
> > not exist.
> > 
> > [0] https://kojipkgs.fedoraproject.org/packages/kernel-tools/5.19.4/200.fc36/data/logs/x86_64/build.log
> > 
> > Fixes: 7572733b8499 ("perf tools: Fix version kernel tag, 2022-02-21")
> > Signed-off-by: Will Chandler <wfc@wfchandler.org>
> 
> This looks fine, thanks.
> 
> Reviewed-by: John Garry <john.garry@huawei.com>

Tested, fixed the problem, applied.

- Arnaldo
 
> > ---
> > Range-diff against v1:
> > 1:  8195a5ccd82d < -:  ------------ perf tools: Fix empty version number when building outside of a git repo
> > -:  ------------ > 1:  a3beccdab700 perf tools: Fix empty version number when building outside of a git repo
> > 
> >   tools/perf/util/PERF-VERSION-GEN | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/PERF-VERSION-GEN b/tools/perf/util/PERF-VERSION-GEN
> > index 0ee5af529238..3cc42821d9b3 100755
> > --- a/tools/perf/util/PERF-VERSION-GEN
> > +++ b/tools/perf/util/PERF-VERSION-GEN
> > @@ -11,7 +11,8 @@ LF='
> >   '
> >   #
> > -# Always try first to get the version from the kernel Makefile
> > +# Use version from kernel Makefile unless not in a git repository and
> > +# PERF-VERSION-FILE exists
> >   #
> >   CID=
> >   TAG=
> > @@ -19,9 +20,14 @@ if test -d ../../.git -o -f ../../.git
> >   then
> >   	TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
> >   	CID=$(git log -1 --abbrev=12 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
> > -else
> > +elif test -f ../../PERF-VERSION-FILE
> > +then
> >   	TAG=$(cut -d' ' -f3 ../../PERF-VERSION-FILE | sed -e 's/\"//g')
> >   fi
> > +if test -z "$TAG"
> > +then
> > +	TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
> > +fi
> >   VN="$TAG$CID"
> >   if test -n "$CID"

-- 

- Arnaldo
