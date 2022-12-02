Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E798F640D9C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiLBSmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbiLBSle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:41:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB082F4EB0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:39:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07E7E623A9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 18:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB72C433C1;
        Fri,  2 Dec 2022 18:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670006389;
        bh=BleIvxODy6ciEnk+PuCyneMSnGiwb5+/ySNjeEHNJkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJUwhG4CRx8Ozeh7tSuc48PznuxPcM+We5TOZo/7oRcm/2mkD1+QBUDWQDCO9Ljk9
         Qq8O1oAa2r4z01tL12S4XiE8d+bKhkQF1POhEPbTudpw8sN/2SbKdhUnJQI4oEh7cD
         uLZigFpldlNU+3f0rR/22kr/AK2ZSbGLshxlUxmhT5bTAd8iyDPVEhqKZOicSB2HlV
         DcW6KfEaVAVcYYbhenC1fj5zop65p0oIiwAGNQy4ZmLp69KvxYFCxt76OXC790lxkN
         8HzTTArSJ5S+1+ARm9H/O5uW/J5lxO9VEOXH62Ama4ZB89hANTfwjEzyDHKXrgmphD
         MdwucQPzlQLbA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 03D564034E; Fri,  2 Dec 2022 15:39:46 -0300 (-03)
Date:   Fri, 2 Dec 2022 15:39:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Hans-Peter Nilsson <hp@axis.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH] perf arm64: Fix mksyscalltbl, don't lose syscalls due to
 sort -nu
Message-ID: <Y4pGchpqZCaWhPQg@kernel.org>
References: <20201228023941.E0DE2203B5@pchp3.se.axis.com>
 <20201229030933.GC28115@leoy-ThinkPad-X240s>
 <Y4Cspv98j8TqwCqZ@axis.com>
 <Y4C66dg+9wwiXdVs@leoy-yangtze.lan>
 <98978f82-eb78-4fa7-901e-76c3070362e3@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98978f82-eb78-4fa7-901e-76c3070362e3@app.fastmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 25, 2022 at 02:56:31PM +0100, Arnd Bergmann escreveu:
> On Fri, Nov 25, 2022, at 13:54, Leo Yan wrote:
> > On Fri, Nov 25, 2022 at 12:53:10PM +0100, Vincent Whitchurch wrote:
> 
> >> It looks like this patch was never applied?  AFAICS it is still needed
> >> on current HEAD and it still applies cleanly.
> >
> > Thanks a lot for bringing up this.
> >
> > Before there have a discussion [1] for refactoring Arm64 system call
> > table but it didn't really happen.
> 
> I actually worked on this last week and did a new series to convert
> the old asm-generic/unistd.h header into the syscall.tbl format,
> and change arm64 to use that.
> 
> You can find my work in the 'syscall-tbl' branch of my asm-generic
> tree [1]. This has only seen light build testing so far, and is
> probably still buggy, but most of the work is there. The missing
> bits are the Makefiles for the other seven architectures using
> asm-generic/unistd.h, and checking the output to ensure the
> contents are still the same.
> 
> > I think it's the right thing to merge
> > this patch, @Arnaldo, could you pick up this patch?
> 
> That sounds fine to me.

Sure, and adding an Acked-by: Arnd
 
>     Arnd
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/

-- 

- Arnaldo
