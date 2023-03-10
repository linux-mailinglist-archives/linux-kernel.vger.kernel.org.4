Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3D96B49B7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjCJPPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjCJPOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:14:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7BECEF8B;
        Fri, 10 Mar 2023 07:05:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6711EB822DE;
        Fri, 10 Mar 2023 15:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09315C433A4;
        Fri, 10 Mar 2023 15:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678460741;
        bh=a3EVePx4MR1kBaDwbruPRZltn9GARuNR/ULdgsWNyaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IC6ems9fQjxrT8ZJvfO75+WYGfTK1sth7WtrAxzkW/aVo5Rd9njC+nwx4vZoPAkwv
         +ISw1DM2ycExNM6zFU/uBiMfNgOQjw0IGNEPSUthoSK1vX+cDu3QZGY6UyMZ/SdOb0
         uB4Xy83k5PW5MMDYolsHGFFXkYlnup7Bg7dEynDIAPx3ZTZNMUR/KDwAob3IDj6fWM
         MGV8QkXBjJRuA6+7oG34BVGu5DCtCgAko5ZXaWU07ILqxEZOQ2UOIuVi7xD2Y2bw+e
         878VZK+RJ1Gl/lwf0H79iY21M+HOi1o9qIUfraVDQi7x8JDKlcXAecxyUJQk4AYupL
         4fi6wGufJ25yQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AA6A94049F; Fri, 10 Mar 2023 12:05:38 -0300 (-03)
Date:   Fri, 10 Mar 2023 12:05:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@huawei.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hui Wang <hw.huiwang@huawei.com>
Subject: Re: [PATCH v2 0/3] perf : fix counting when initial delay configured
Message-ID: <ZAtHQuhWz+q//pE2@kernel.org>
References: <20230302031146.2801588-1-changbin.du@huawei.com>
 <CAM9d7cigZ=TRoH8-MNbovUETzsjf+OuX7ykXA9rSyhsOY48dRg@mail.gmail.com>
 <ZAEJsMYGo1HC5CRk@kernel.org>
 <20230310023714.gqmenjlunlcm3bju@M910t>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310023714.gqmenjlunlcm3bju@M910t>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 10, 2023 at 10:37:14AM +0800, Changbin Du escreveu:
> On Thu, Mar 02, 2023 at 05:40:16PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Mar 02, 2023 at 11:22:37AM -0800, Namhyung Kim escreveu:
> > > Hello,
> > > 
> > > On Wed, Mar 1, 2023 at 7:12 PM Changbin Du <changbin.du@huawei.com> wrote:
> > > >
> > > > The first one fixes the problem that counters are never enabled  when initial
> > > > delay configured.
> > > > The remaining two reuse the common field target::initial_delay for
> > > > record/ftrace/trace subcommands.
> > > >
> > > > v2:
> > > >  - introduce common filed target::initial_delay
> > > >
> > > > Changbin Du (3):
> > > >   perf stat: fix counting when initial delay configured
> > > >   perf record: reuse target::initial_delay
> > > >   perf: ftrace: reuse target::initial_delay
> > > 
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Thanks, applying the first to perf-tools (old perf/urgent) and the rest
> > to perf-tools-next (old perf/core).
> > 
> > - Arnaldo
> > 
> Hi Arnaldo, it seems only the first one is applied. The remaining two patches
> are missed in your tree.
>  - perf record: reuse target::initial_delay
>  - perf: ftrace: reuse target::initial_delay

Those are not fixes, right? I mentioned that I would apply it after the
first is merged.

- Arnaldo
