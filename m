Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1327863603F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbiKWNpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbiKWNpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:45:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED6DD5396;
        Wed, 23 Nov 2022 05:33:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A9EB61CC9;
        Wed, 23 Nov 2022 13:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB36C433D6;
        Wed, 23 Nov 2022 13:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669210409;
        bh=o5a/1D++1Mz35bMC46Wx3lUgNniBZ5e14zrk6/8nSLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LOl7Q4n4cEl48OuaUSA+Bgl0IZTxdonu6mUt/hJRzmYjzYC5vh9Aa2N3ZXMxrUR/6
         48m+AKkRf2fO3muoslzGBzQUQBe2NxHZTgy+eHvpR+Au3yxQ2og13EtKoKPsTf8Wyg
         nwUHbaUgC/sR+weWCCWEzz0ML39ZkwLmTORo98UEeKQs4s5cDDnvO08asxGGog6Ydz
         eBDgNoiqpV5wqgiRgNG0A/FUmd9zgySBEdzk5Ud2AYI+S2ARX0UaCBcxxK1s3revGZ
         GA8gUTbE00d7ixoql1pdSKm1bZNED2WAN8pFIiz5zQiXrapqcLWoVFoJCyl8cfqdRy
         8bN3OuFhi7ziQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E73C84034E; Wed, 23 Nov 2022 10:33:26 -0300 (-03)
Date:   Wed, 23 Nov 2022 10:33:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf test: Skip watchpoint tests if no watchpoints
 available
Message-ID: <Y34hJrqCzSE+W+X9@kernel.org>
References: <20221121102747.208289-1-naveen.n.rao@linux.vnet.ibm.com>
 <a9f0f8f1-96cd-f6a8-9dda-d4744b938f97@csgroup.eu>
 <CAP-5=fXJf+1V5RF-m3e+AhK0Qg-yaJ1_2HL0CTOvp1xkK-1fDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXJf+1V5RF-m3e+AhK0Qg-yaJ1_2HL0CTOvp1xkK-1fDg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 22, 2022 at 12:57:05PM -0800, Ian Rogers escreveu:
> On Tue, Nov 22, 2022 at 11:19 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> >
> >
> >
> > Le 21/11/2022 à 11:27, Naveen N. Rao a écrit :
> > > On IBM Power9, perf watchpoint tests fail since no hardware breakpoints
> > > are available. Detect this by checking the error returned by
> > > perf_event_open() and skip the tests in that case.
> > >
> > > Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
> > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > ---
> > >   tools/perf/tests/wp.c | 12 +++++++-----
> > >   1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
> > > index 56455da30341b4..cc8719609b19ea 100644
> > > --- a/tools/perf/tests/wp.c
> > > +++ b/tools/perf/tests/wp.c
> > > @@ -59,8 +59,10 @@ static int __event(int wp_type, void *wp_addr, unsigned long wp_len)
> > >       get__perf_event_attr(&attr, wp_type, wp_addr, wp_len);
> > >       fd = sys_perf_event_open(&attr, 0, -1, -1,
> > >                                perf_event_open_cloexec_flag());
> > > -     if (fd < 0)
> > > +     if (fd < 0) {
> > > +             fd = -errno;
> > >               pr_debug("failed opening event %x\n", attr.bp_type);
> > > +     }
> >
> > Do you really need that ?
> >
> > Can't you directly check errno in the caller ?
> 
> errno is very easily clobbered and not clearly set on success - ie,
> it'd be better not to do that.
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

