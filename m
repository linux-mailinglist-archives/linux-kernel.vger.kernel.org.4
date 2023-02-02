Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E308C68735F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 03:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjBBCiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 21:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBBCiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 21:38:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C235313D7D;
        Wed,  1 Feb 2023 18:38:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75736B8239B;
        Thu,  2 Feb 2023 02:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80ECC433EF;
        Thu,  2 Feb 2023 02:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675305480;
        bh=m0oALI10K5jRJIt1Mci3LOCOhnyCnOFYCba3RlhkNM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFXGYyFk6+CDFHI++Y7r2Y0UBThKzmZNCdYCETNP5ES/I0YeifUCsd9HkPz44MoN1
         wecPr+Vg2aI2Oewahmtv6BClqrNcZYpwtvzBwAk90dxVYlOV/gfDbvUVXVMARm3rSa
         3xviyK/Qucb2ncZ7Txuetk3FbqCvYdnbDXiCAk0qo8+vF7Qkoxr7q1Ge8y0C7WgPZ6
         CBn2PRfYuWU6d5LjLk5iN1l/ZvhZey788zyzW/RV5EMRVovtN3Gr5m+CX7bh82ZMQx
         zmXAoxnCkr3jMdO0rQh2Zr1HaiLhZHpt80OM9R5gz5GSZwQFQltRyiiSXgKGm0VOt5
         qXxbc/CRSIbvw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CA09B405BE; Wed,  1 Feb 2023 23:37:56 -0300 (-03)
Date:   Wed, 1 Feb 2023 23:37:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, bp@alien8.de,
        namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, dave.hansen@linux.intel.com,
        james.clark@arm.com, irogers@google.com, eranian@google.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v3 1/2] perf script: Show branch speculation info
Message-ID: <Y9siBA2xfhFeWJku@kernel.org>
References: <cover.1675057032.git.sandipan.das@amd.com>
 <87c48949f5a442dda6d4dc75d4a4303973eb04b2.1675057032.git.sandipan.das@amd.com>
 <08385b8c-0fae-3249-3dfb-5a7800928213@amd.com>
 <Y9gj5spCa8JcTY/X@kernel.org>
 <Y9sOH5p6ffMi91wd@kernel.org>
 <Y9shRsZuhGgpNi25@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9shRsZuhGgpNi25@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 01, 2023 at 11:34:46PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Feb 01, 2023 at 10:13:03PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Jan 30, 2023 at 05:09:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Mon, Jan 30, 2023 at 04:04:58PM +0530, Sandipan Das escreveu:
> > > > Sorry but I realized later that this change breaks the builtin branch test.
> > > > The additional change below fixes that.
> > > 
> > > Please wait a bit for people to be able to review the other patches and
> > > then submit a v2 series.
> > 
> > So I applied it manually, no need to send v2.
> 
> Please send v2 after figuring out why 'perf test "Sample parsing"'
> fails,
> 
> I removed both patches for now.

Triple checking:

[acme@quaco perf]$ git log --oneline -1
24a617c84f0da540 (HEAD -> perf/core) perf session: Show branch speculation info in raw dump
[acme@quaco perf]$ perf -v
perf version 6.2.rc5.g24a617c84f0d
[acme@quaco perf]$ perf test "Sample testing"
[acme@quaco perf]$ perf test "Sample parsing"
 27: Sample parsing                                                  : FAILED!
 80: x86 Sample parsing                                              : Ok
[acme@quaco perf]$ git reset --hard HEAD~
HEAD is now at 1fad7c0ae6516706 perf script: Show branch speculation info

[acme@quaco perf]$ git log --oneline -1
1fad7c0ae6516706 (HEAD -> perf/core) perf script: Show branch speculation info
[acme@quaco perf]$ perf -v
perf version 6.2.rc5.g1fad7c0ae651
[acme@quaco perf]$ perf test 27
 27: Sample parsing                                                  : FAILED!
[acme@quaco perf]$ git reset --hard HEAD~
HEAD is now at d4a6f399c89520ba perf bench syscall: Add execve syscall benchmark
[acme@quaco perf]$

[acme@quaco perf]$ git log --oneline -1
d4a6f399c89520ba (HEAD -> perf/core, five/perf/core) perf bench syscall: Add execve syscall benchmark
[acme@quaco perf]$ perf -v
perf version 6.2.rc5.gd4a6f399c895
[acme@quaco perf]$ perf test 27
 27: Sample parsing                                                  : Ok
[acme@quaco perf]$

- Arnaldo
