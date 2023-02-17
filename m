Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3112369AD48
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBQOD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBQODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:03:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186DE656B2;
        Fri, 17 Feb 2023 06:03:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7F1061BA0;
        Fri, 17 Feb 2023 14:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EF0C433EF;
        Fri, 17 Feb 2023 14:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676642632;
        bh=uohuAHrUCjnqA7irnaiWAtD+EmHIGiwseVTupadX5zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3x8ARgnp/EUpbuufgbLFiKFaCTeO5ylHTOPnWaNNXvVEQydhvaPGeKMZ7EnuUgEc
         pfM6+P8rROn+rVQi5HSc3fWZUT3iL6K38EFRg1pkOurXm7Kn7doFpDxnmeNMnJ3Xxu
         s09dUZyBU5up84KCnkvZcaZIEZtEFUHZEJJ2VMhhhuOeCYBDc4uBdqVSJzsn1EbuE0
         HSv3AI+F7snKnu7ZGPrg8Q02tuZbcy5qScWnNlHTds8iP9GA2Y81DoIvV/c00daYju
         woUxAPP5QXJojPmNvkxByqqcM+Ocq6h+UQ1Lkd+IqgFTziNQL28Bq6WXtSEmUaWzfs
         MhFB+oltjckWg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4B76140025; Fri, 17 Feb 2023 11:03:49 -0300 (-03)
Date:   Fri, 17 Feb 2023 11:03:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Steinar H. Gunderson" <sesse@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf intel-pt: Synthesize cycle events
Message-ID: <Y++JRY4ExBkxeejU@kernel.org>
References: <20220322082452.1429091-1-sesse@google.com>
 <YjpAYjdgHWwkid5N@kernel.org>
 <YjpFcLiCTjHZWzzA@google.com>
 <52d31321-66e1-f189-2ffc-7c93239eea74@intel.com>
 <Yj49LDY3S/ANeN0V@kernel.org>
 <Y+9evQVBRLrCLQKf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+9evQVBRLrCLQKf@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 17, 2023 at 12:02:21PM +0100, Steinar H. Gunderson escreveu:
> On Fri, Mar 25, 2022 at 07:07:40PM -0300, Arnaldo Carvalho de Melo wrote:
> >>> 
> >>> There are two issues in play:
> >>> 
> >>>  1. PT event synth doesn't support reading inline information from DWARF
> >>>     yet, and my patch to add it runs into some problems. This is not
> >>>     relevant for this patch at all.
> >>>  2. The results from v3 don't quite match the ones from v1, and neither
> >>>     of us are entirely sure why. My personal feeling is that the one
> >>>     from v1 are the wrong ones, but it's up to Adrian to say whether we
> >>>     want to try to investigate deeply here.
> >> V3 is good.  Please take that.
> > Thanks, applied.
> 
> Hi,
> 
> I downloaded linux-6.1.12 now and built perf from that, and this patch
> isn't included. Did it get somehow lost along the way?

I must have committed some mistake when doing rebases, I'm sorry.

I applied it now and will push it later today, after the usual set of
tests with it and other patches I apply today.

- Arnaldo
