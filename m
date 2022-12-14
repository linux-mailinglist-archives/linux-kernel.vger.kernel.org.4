Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A1064C38E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 06:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiLNFhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 00:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiLNFhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 00:37:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF681D647;
        Tue, 13 Dec 2022 21:37:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7547F617CB;
        Wed, 14 Dec 2022 05:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ACFC433D2;
        Wed, 14 Dec 2022 05:37:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QBIFZNVX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670996226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fZQGckN0/rFE/eVMKFJVfNbNA3hXDeqlh4GZMp2rfkg=;
        b=QBIFZNVXUbM1GfDAR28xwM1dC/tTM4U362ccc5zFI2LJ/2XxltK2LjNOxZM6OT6frK/7Kp
        6g05Ivbw0PQzBZHRWpuyobp10EELpmY9C2YBTRoeqVYNrwlTfoyy5vhF46K7Uw6n54T3EU
        ShTQGqV2EC+seC/vOUW7FBDRX458A0A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0e1ab403 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 14 Dec 2022 05:37:05 +0000 (UTC)
Date:   Tue, 13 Dec 2022 22:37:04 -0700
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the random tree
Message-ID: <Y5lhAK6oR/ovwSn5@zx2c4.com>
References: <20221214125359.147f33fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221214125359.147f33fa@canb.auug.org.au>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 12:53:59PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the random tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> arch/x86/mm/cpu_entry_area.c: In function 'init_cea_offsets':
> arch/x86/mm/cpu_entry_area.c:39:23: error: implicit declaration of function 'prandom_u32_max'; did you mean 'prandom_u32_state'? [-Werror=implicit-function-declaration]
>    39 |                 cea = prandom_u32_max(max_cea);
>       |                       ^~~~~~~~~~~~~~~
>       |                       prandom_u32_state
> net/ipv4/tcp_plb.c: In function 'tcp_plb_update_state_upon_rto':
> net/ipv4/tcp_plb.c:100:18: error: implicit declaration of function 'prandom_u32_max'; did you mean 'prandom_u32_state'? [-Werror=implicit-function-declaration]
>   100 |         pause += prandom_u32_max(pause);
>       |                  ^~~~~~~~~~~~~~~
>       |                  prandom_u32_state
> 
> Caused by commit
> 
>   1effd020f82d ("prandom: remove prandom_u32_max()")
> 
> interacting with some new usages.  Why not leave this removal until
> just after -rc1 has been released?
> 
> I have reverted this commit for today.

The plan was the last chance before rc1, yea. I'll remove it for now so
that it stops breaking -next.

Jason
