Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A5D72C6C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjFLOAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbjFLN7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:59:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABE25198E;
        Mon, 12 Jun 2023 06:59:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA4FB1FB;
        Mon, 12 Jun 2023 07:00:10 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.27.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB8E63F71E;
        Mon, 12 Jun 2023 06:59:20 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:59:13 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 15/18] watchdog/perf: Add a weak function for an arch
 to detect if perf can use NMIs
Message-ID: <ZIckscgmirrgxZ75@FVFF77S0Q05N>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.15.Ic55cb6f90ef5967d8aaa2b503a4e67c753f64d3a@changeid>
 <ZIb0hd8djM+jJviF@FVFF77S0Q05N>
 <CAD=FV=WyLKygSsArCaSzid47Rz5=ozR6Yh9L6Q3JStpzF9Tn9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WyLKygSsArCaSzid47Rz5=ozR6Yh9L6Q3JStpzF9Tn9w@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 06:55:37AM -0700, Doug Anderson wrote:
> Mark,
> 
> On Mon, Jun 12, 2023 at 3:33 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Fri, May 19, 2023 at 10:18:39AM -0700, Douglas Anderson wrote:
> > > On arm64, NMI support needs to be detected at runtime. Add a weak
> > > function to the perf hardlockup detector so that an architecture can
> > > implement it to detect whether NMIs are available.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > While I won't object to this patch landing, I consider it part of the
> > > arm64 perf hardlockup effort. I would be OK with the earlier patches
> > > in the series landing and then not landing ${SUBJECT} patch nor
> > > anything else later.
> >
> > FWIW, everything prior to this looks fine to me, so I reckon it'd be worth
> > splitting the series here and getting the buddy lockup detector in first, to
> > avoid a log-jam on all the subsequent NMI bits.
> 
> I think the whole series has already landed in Andrew's tree,
> including the arm64 "perf" lockup detector bits. I saw all the
> notifications from Andrew go through over the weekend that they were
> moved from an "unstable" branch to a "stable" one and I see them at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-nonmm-stable
> 
> When I first saw Anderw land the arm64 perf lockup detector bits in
> his unstable branch several weeks ago, I sent a private message to the
> arm64 maintainers (yourself included) to make sure you were aware of
> it and that it hadn't been caught in mail filters. I got the
> impression that everything was OK. Is that not the case?

Sorry; I'm slowly catching up with a backlog of email, and I'm just behind.

Feel free to ignore this; sorry for the noise!

If we spot anything going wrong in testing we can look at fixing those up.

Thanks,
Mark.
