Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A696F8A3E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjEEUe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjEEUep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:34:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB6D4C12;
        Fri,  5 May 2023 13:34:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD65A62FB4;
        Fri,  5 May 2023 20:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0106CC433D2;
        Fri,  5 May 2023 20:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683318867;
        bh=AFT7knrEPhLEA6RJfSbjIHYPUd6cKJPFX4vMnUj8HPQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m8xSlKCb794at+pDA2CJBWf1z89M4bzl/yxif1iN1rRFavvCkd6CIBqS4Wfs3CHVb
         ckNOj9uS/IU0bXbDQcGVI6Jvd7Rs8eVaITk8flI7trvTNMMSCWFTfmIl4/QmQkKdp6
         ON1+OmL2ISBXHNuSKDUwopFfdyHqMO72iG7BniTo=
Date:   Fri, 5 May 2023 13:34:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, hannes@cmpxchg.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bfoster@redhat.com, willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v13 2/3] cachestat: implement cachestat syscall
Message-Id: <20230505133426.d70a6599d9a729496b68a70c@linux-foundation.org>
In-Reply-To: <CAMuHMdWUtb_A-uhXrBg6kC9L2zbC_q3m8oCZoq80ZSJvk6mUAA@mail.gmail.com>
References: <20230503013608.2431726-1-nphamcs@gmail.com>
        <20230503013608.2431726-3-nphamcs@gmail.com>
        <CAMuHMdWUtb_A-uhXrBg6kC9L2zbC_q3m8oCZoq80ZSJvk6mUAA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2023 19:26:11 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> >  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
> >  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
> 
> This should be wired up on each and every architecture.
> Currently we're getting
> 
>     <stdin>:1567:2: warning: #warning syscall cachestat not implemented [-Wcpp]
> 
> in linux-next for all the missing architectures.

Is that wise?  We risk adding a syscall to an architecture without the
arch maintainers and testers even knowing about it.

The compile-time nag is there to inform the arch maintainers that a new
syscall is available and that they should wire it up, run the selftest
and then ship the code if they're happy with the result.
