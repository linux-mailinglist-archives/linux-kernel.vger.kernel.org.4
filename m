Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE13628B58
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbiKNV2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbiKNV2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:28:13 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C00B62D8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:28:11 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4C4F23C111D;
        Mon, 14 Nov 2022 21:28:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a275.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 37B343C1211;
        Mon, 14 Nov 2022 21:28:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668461290; a=rsa-sha256;
        cv=none;
        b=W5ROWTsMZrHOHnhlDC/c6QB+czt5XPTkoV5zDfGDPt/FHWv1UilUde+1hJ47wGnptQ0Wqo
        SNJZUt2J5Cn3xdD5vKwLFMfnfq5ShL+bUgaAnJZHr4k/ooiVpT3vWpwPGs8PzP1MsLNhg3
        0zYkSKJaQSqH1vW0y16GqvBeuAOCwopusarCnAM/JrhGrYcEhVBtKYJYbXjjSv/GUWGVDX
        2tnDzQ/Lf/7Ts0XFgFDmHLflJN6CcyAgxAouewjf35KDEsyV08QjoxT/VkfPf4Lg6x9b+Z
        78n8yJ6ZMEDh4B3n67V9RoGWDhqUw3BXwQwKGFTHWfkBdM0N1P+ou+DPB60KkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668461290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=dhghcBTxDDlVUI0nQwj3B1Orugxyqsm8zkmydYGlNeg=;
        b=H6u+23w3RXz/Zo3AdwtkpT5IMv4Gpi3AlEBbu0g4A5RixMKO+Zte12nButeG8yjftzpYyL
        RlbARv+wR+tov8WkvJH/MI9vROUQoTv7xOPo5OK7IxhAjHqc9Mnud7lsQzA98ZKEYF7plb
        JpGrapa01Cjf5PsFhGMh4Cr5gAZ+/GhZaVy97RsE5AjkSL4X56OqE1emXZnkFxpBKwVs4s
        NwlFmKY/CrXpINtGDjwJuf81t1Gs/XEw7zL0zF2SnyBKWix68KTS9tiEHKNU06wydt99EX
        F6k1BAPi5XBUW7m7xOP2SOxkAcyJWu6116xhYtIFIcpiRbM1TY61mu1KgRa3Lw==
ARC-Authentication-Results: i=1;
        rspamd-7f9bbcf788-gzxf5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Absorbed-Industry: 6e3b9a3016e26135_1668461290545_1507680007
X-MC-Loop-Signature: 1668461290545:2518700890
X-MC-Ingress-Time: 1668461290545
Received: from pdx1-sub0-mail-a275.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.200.111 (trex/6.7.1);
        Mon, 14 Nov 2022 21:28:10 +0000
Received: from rhino (dsl-50-5-144-34.fuse.net [50.5.144.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a275.dreamhost.com (Postfix) with ESMTPSA id 4NB2V10bz7z2S;
        Mon, 14 Nov 2022 13:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1668461289;
        bh=dhghcBTxDDlVUI0nQwj3B1Orugxyqsm8zkmydYGlNeg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=mK4q9NkruEYIjXoq8Y/9TcThuEieVs86t3ohaDs90lUbXqGBtd8fm4Q8B9qe7JIEM
         PyIb6iZ+Do03zrAQpLtigLPppnkPDLhtbHCXpeGwqlDjUxXeU21ADsdg0A9xLLH9rr
         Z//uyOaZLaoiXZGV4WWDZeQI4BkAlQd1UI6fGLpjjeKCdAPq/o2v/NKdiAISphm9uz
         i2KmL3iJh//2duJ9Va0SajToLnoYX40X84Eyer8uCfxAOJ7ha9x4VVzMxw+px2G9YY
         DfzMi2A0vf2q6u0W8pDFMSGrXnEvJIqXdca99oY7+Ao23y99ThFrmf8fXovHsdiA80
         Xl6Kf1Q+s+jmA==
Date:   Mon, 14 Nov 2022 16:28:07 -0500
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: include: linux: slab: kmalloc_trace undefined when compiling
 drivers
Message-ID: <Y3Ky54xVZdY2IT9L@rhino>
References: <Y2/Luovqgz8O+Kqa@rhino>
 <f83aca33-3a5f-97ac-625e-aa7c72bf60ba@infradead.org>
 <Y3AXVRAoZA5YEho+@rhino>
 <1df133ef-d5e9-f323-7c67-fc9ffed04274@infradead.org>
 <Y3A9waTkehESUyn+@rhino>
 <abdb1b8d-859d-669b-6bbf-604febb643b2@infradead.org>
 <Y3BGimp2LmRqV9oy@rhino>
 <Y3IDWt9vINpCtXjP@hyeyoo>
 <Y3I3FnPfHObfdIUb@rhino>
 <5dc7529d-9edf-4ea7-35d3-a5f3dc55dd5c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc7529d-9edf-4ea7-35d3-a5f3dc55dd5c@suse.cz>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:56:25PM +0100, Vlastimil Babka wrote:
> On 11/14/22 13:39, Ian Cowan wrote:
> > On Mon, Nov 14, 2022 at 05:59:06PM +0900, Hyeonggon Yoo wrote:
> >> On Sat, Nov 12, 2022 at 08:21:14PM -0500, Ian Cowan wrote:
> >> > On Sat, Nov 12, 2022 at 05:11:27PM -0800, Randy Dunlap wrote:
> >> > > 
> >> > > 
> >> > > On 11/12/22 16:43, Ian Cowan wrote:
> >> > > > On Sat, Nov 12, 2022 at 04:34:18PM -0800, Randy Dunlap wrote:
> >> > > >>
> >> > > >>
> >> > > >> On 11/12/22 13:59, Ian Cowan wrote:
> >> > > >>> On Sat, Nov 12, 2022 at 09:21:34AM -0800, Randy Dunlap wrote:
> >> > > >>>> Hi--
> >> > > >>>>
> >> > > >>>> On 11/12/22 08:37, Ian Cowan wrote:
> >> > > >>>>> When compiling drivers (speficially drivers/pci/hotplug), I am receiving
> >> > > >>>>> the following modpost error for both `kmalloc_trace` and
> >> > > >>>>> `kmalloc_node_trace` on the staging/staging-next branch:
> >> > > >>>>>
> >> > > >>
> >> > > >> Ian, what do you mean by "on the staging/staging-next branch"?
> >> > > >>
> >> > > >> What kernel version are you trying to build?
> >> > > >>
> >> > > >> The .config that you sent is for v6.1.0-rc1.
> >> > > > 
> >> > > > I am building from the staging repository (gregkh/staging) and my
> >> > > > working branch when building is staging-next. So I am trying to build
> >> > > > from staging and not a particular version. I have also run `make modules_prepare`
> >> > > > and updated the .config per that script. However, when I do build
> >> > > > v6.1.0-rc1 from the main repository (torvalds/linux), I run into the same problem.
> >> > > 
> >> > > Have you built the entire kernel already and then you are trying to build
> >> > > only drivers/pci/hotplug?
> >> > Yes, I did build the entire kernel already and then I'm just trying to
> >> > rebuild that module.
> >> > 
> >> > In `include/linux/slab.h` if I remove the lines between `#ifdef
> >> > CONFIG_TRACING` and `#else` (lines 473-480) and then the corresponding
> >> > `#endif` and leave lines 481-499, I'm able to compile that module
> >> > without issue.
> >> 
> >> I don't get what the problem is.
> >> In case kmalloc[_node]_trace() is undefined, it's replaced with kmem_cache_alloc[_node]. 
> >> 
> >> Is the kernel built with same config on tree?
> > 
> > Yes, the same config on tree with no errors or warnings. I was able to
> > trace it back to this commit - building on the commit immediately prior
> > builds without error or warning. It looks like this commit does some
> > refactoring of the kmem_cache_alloc[_node] and kmalloc[_node]_trace.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-next&id=26a40990ba052
> 
> Wonder if you have a stale mm/slab_common.o because for some reason it's not
> being recompiled (a file timestamp in the future?)
> Can you rm it and rebuild? And maybe also mm/built-in.a
> Or maybe a full make clean and/or a fresh checkout.
> 

I pulled a fresh checkout and rebuilt everything and it was fixed after
that. Thanks for your help!
