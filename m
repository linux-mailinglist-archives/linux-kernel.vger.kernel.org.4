Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7EB64CC64
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiLNOfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbiLNOfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:35:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE56BF2;
        Wed, 14 Dec 2022 06:35:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4999061ACE;
        Wed, 14 Dec 2022 14:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F887C433EF;
        Wed, 14 Dec 2022 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671028501;
        bh=m98RlXJ/WE9s7A2/YHKpBSHyNKsZEnL4fFE9zIp3ocE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DDM5pcZ0jlu38c7MLCTaHrXajkeM7tOgeVuIkw0XTQvpfpl5DlhG5EvxTtf+TYmjt
         mrbTx5R6devy6Dax4iPppell2fc+Rj1nfJmcBGnQDfUuY5eO6hNHKtfCrbE0ED0REz
         JkbAuYp3h6YElz/KFQ3dXPofd4Y3MmqqZGQ04ROx47diVl54m8KNOpIQwzIqcN5gCz
         rW9x0O1hKzcg/VatoVfkINLqisaYjUrpNIcN9sqcfYpOUjmRguwT0AAi6V96+EEzNa
         gRkLLStL0AS0wT8tf73rvaXmpb1YLvdmN90Q2XUKaL61GlkpkvXm4PvyzbXLGV+bfk
         qnKMEj+pft67A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 84C0940367; Wed, 14 Dec 2022 11:34:58 -0300 (-03)
Date:   Wed, 14 Dec 2022 11:34:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        svens@linux.ibm.com
Subject: Re: [PATCH 2/2] perf/test: Fix perf test 89 on x86
Message-ID: <Y5nfEu+3sU/Hcoon@kernel.org>
References: <20221213105729.1447368-1-tmricht@linux.ibm.com>
 <20221213105729.1447368-2-tmricht@linux.ibm.com>
 <Y5iQXJaQOrhjLZQW@kernel.org>
 <f5e69102-ed17-1f2d-3a09-3c7968b611ff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5e69102-ed17-1f2d-3a09-3c7968b611ff@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 14, 2022 at 11:40:32AM +0100, Thomas Richter escreveu:
> On 12/13/22 15:46, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Dec 13, 2022 at 11:57:29AM +0100, Thomas Richter escreveu:
> >> perf test '89: probe libc's inet_pton & backtrace it with ping'
> >> fails on x86. Debugging revealed a changed stack trace for the
> >> ping command using probes:

> >> ping 35729 [002]  8006.365063: probe_libc:inet_pton: (3ff9603e7c0)
> >>                   12be50 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
> >>                   4fca main+0x139b (/usr/bin/ping)

> >> The line getaddrinfo.... in the call stack is gone.
> >> It was introduced with glibc version 2.36.8 released
> >> with Fedora 37.

> >> Output before on x86
> >>  # ./perf test 89
> >>  89: probe libc's inet_pton & backtrace it with ping   : FAILED!
> >>  #

> >> Output after on x86:
> >>  # ./perf test 89
> >>  89: probe libc's inet_pton & backtrace it with ping   : Ok
> >>  #

> > Not having at the current state of that script, that $expected may be a
> > subset of the actual backtrace, i.e. will this continue working with
> > the systems where that getaddrinfo line appear?
 
> No, that is not the case.
> Taking this into account requires a larger rework of the call stack
> checking. Not just simple line by line matching which is done now.
> It also raises the question of how far to go back
> in glibc history. Different versions of glibc have different call stacks.
 
> I will rethink this...

One possibility is to have the options on a temp file, the previous one,
then if it fails, remove the getaddrinfo line and try again, if it
works, its the new glibc, test result is Ok.

Add a commment stating that from circa glibc versiuon 2.36.8 the
getaddrinfo isn't there anymore.

- Arnaldo
