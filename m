Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4882687E4E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjBBNKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjBBNKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:10:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534A38C1C3;
        Thu,  2 Feb 2023 05:10:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D586761A0F;
        Thu,  2 Feb 2023 13:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080DCC433EF;
        Thu,  2 Feb 2023 13:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675343435;
        bh=ouXElO1fFiss/pPy50hwCqRHtegyzt/i3epdgeUAFI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FnXPGfg9kPjfplMHFVWxym0YoCT3EEzPAzMPxZUlORDNJYoyjKN6ugQRLDwzpHmKK
         jN34UTZxx1tA9FBN3jdPRJfyR6ErxTNlO/A6oJtZjBv4Zp3lXg+7aNnknBJIvV2HfG
         gKFdPoiERYZiNYmsvL+NF+XmedC7QYTiBdpd0woD74lUjtYVL5/EFyECtha+7yaUDx
         drOgOjuSaSvpMLMdZv6eplmj5ucGdky8NV0o3uMtniZvsV/smS6z4KWa2emOZo1zUX
         xGG9QZh3HTdsLwaQi4ZsQXeJc3k63Bnl2865+186RoACbj3cvkG/WfeSZ7VmIN6vVs
         se8tDSYRdLCwg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8358B405BE; Thu,  2 Feb 2023 10:10:32 -0300 (-03)
Date:   Thu, 2 Feb 2023 10:10:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, bp@alien8.de,
        namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, dave.hansen@linux.intel.com,
        james.clark@arm.com, irogers@google.com, eranian@google.com,
        maddy@linux.ibm.com, kjain@linux.ibm.com, tmricht@linux.ibm.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v4 0/4] tools perf: Add branch speculation info
Message-ID: <Y9u2SKUYL5RgC0Cb@kernel.org>
References: <cover.1675333809.git.sandipan.das@amd.com>
 <Y9u0zJA05JNHpB+i@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9u0zJA05JNHpB+i@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 02, 2023 at 10:04:12AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Feb 02, 2023 at 05:56:13PM +0530, Sandipan Das escreveu:
> > AMD Last Branch Record Extension Version 2 (LbrExtV2) provides branch
> > speculation information and the perf UAPI is extended to provide this in
> > a generic way. Make perf tool show this additional information.
> > 
> > The UAPI changes can be found in commit 93315e46b000 ("perf/core: Add
> > speculation info to branch entries").
> > 
> > Requesting help from folks having access to big-endian systems to test
> > changes in the sample parsing test as I was only able to test these in
> > a ppc64 simulator.
> 
> I'll try folding some of these patches as 'perf test' must pass after
> each of them, so that we keep the codebase bisectable.
> 
> Right now, after appling the first patch on this v4 series:
> 
> ⬢[acme@toolbox perf]$ perf test 27
>  27: Sample parsing                                                  : FAILED!
> ⬢[acme@toolbox perf]$

So this is what I did:

$ git rebase -i HEAD~4
pick 266d6702711d299c perf script: Show branch speculation info
squash d2fa279aba8d2863 perf test sample-parsing: Update expected branch flags
pick b335ad966cadcbfa perf session: Show branch speculation info in raw dump
squash 272ce62f64e60fc7 perf test brstack: Update regex to include spec field

And then combined the commit messages. Please have bisectability in
mind, running 'perf test', and if it fails, add the fix to to 'perf
test' on the patch that introduced the problem.

Thanks,

- Arnaldo
