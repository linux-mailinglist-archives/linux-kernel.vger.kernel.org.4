Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97008627DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbiKNMkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbiKNMj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:39:59 -0500
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2508AD122
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:39:57 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A6D4A3C2015;
        Mon, 14 Nov 2022 12:39:53 +0000 (UTC)
Received: from pdx1-sub0-mail-a224.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 18D7A3C21A2;
        Mon, 14 Nov 2022 12:39:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668429593; a=rsa-sha256;
        cv=none;
        b=OQcP6hpN2JDTJRCf63lvjPFJ+KfciYfTRe7TMVSBz0iqXMcwwT0GUX48O6VrAXNSukzeYI
        7lTmC3FsFkKVO1WURNjE2wYfxbit/1qSzHgR1XrjB/Lc/+/8QeOo4MFQGuDyKcTdS3lmny
        S9Nft/strnv9kWLESlYG3Jw4D9bClklj5bWKYqRfISOhn5phawVN9qQjZl/jtP2P9t8TVx
        +PxYT37NPBgv7mRdwnd/FRh5jjLIPCWjDuJboaoX7Yus8SA6qfMnz+/w9Nf7+3lNctsemN
        9aWXKvAGaq/K/v0uhd/CdFe+P2I+gtcLxL6ZyakeZli4FKrHDaD36x+3aBo/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668429593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=V2ivCcpdDwhgU+m05c5VMXcyKM/5Jve0hQofmv5JAVY=;
        b=3xnCevwpfj6eIqO4t4pxfLmYohZAyilQE/2aWo9ICi31Y248Q1pYapeUSEFMxC34dWpDLz
        ae3RxNYn3dMhSZYCFWl0kjz0u7wkLjbV7VUamAU+/dVHAbOdqaC8iZF+NkP5B61aoORUhm
        xmIrPtIx0aV6rRzXHy5YfTdgdsuqx2emr74NCDPzMMHEcXNaP0q4HYC5Ts/ryaLMVSHO4D
        OYVN6fLDg2yZUgaK8ayQpFEUcXGcRW8U/QxlZ68JJNIdZZQM5DKcMN0PoVS1GvZ6vLJw1R
        iqoqrolegy1x3rLoBf84n8oZXJaUqJaL1WgqSwBV4KlRRcIJssl8cCvwUT60Og==
ARC-Authentication-Results: i=1;
        rspamd-7f9bbcf788-7kz28;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Versed-Society: 26234432670b8ce8_1668429593459_1843617815
X-MC-Loop-Signature: 1668429593459:849872635
X-MC-Ingress-Time: 1668429593459
Received: from pdx1-sub0-mail-a224.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.179.71 (trex/6.7.1);
        Mon, 14 Nov 2022 12:39:53 +0000
Received: from rhino (dsl-50-5-144-34.fuse.net [50.5.144.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a224.dreamhost.com (Postfix) with ESMTPSA id 4N9pmS0svGz74;
        Mon, 14 Nov 2022 04:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1668429592;
        bh=V2ivCcpdDwhgU+m05c5VMXcyKM/5Jve0hQofmv5JAVY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=aFc4+FMj0dABX2ArrTUonSPSsG93UEBBpZn5RE66neKhy5kNHrVwJJWvyrw1JTiKs
         7ImXFZTasv4srnNxaFEpvWu5hCOPaPtJ+p8vkmQoNRUAqAAGyrQjjxWVnkPA714P3i
         3nOATVlWSdI6mx7p7/FPjwhJT5N/JKjCFmIp0wmlUoWOYTnj3IP9V92Wei1gt7w2vk
         usMjL5JRKGlAeBDwiDRD6x0+TBHzyHRPSrkY5c108qDrObYuiONB3QBBLjWzPVzq73
         MW1KbOWZj3xYhH04zVRKj3FQE/BrpXcSRsj4tt8Np1qk+pLVGiWoFUX2UfO62CNKUj
         A7edm0Nbg1ulg==
Date:   Mon, 14 Nov 2022 07:39:50 -0500
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: include: linux: slab: kmalloc_trace undefined when compiling
 drivers
Message-ID: <Y3I3FnPfHObfdIUb@rhino>
References: <Y2/Luovqgz8O+Kqa@rhino>
 <f83aca33-3a5f-97ac-625e-aa7c72bf60ba@infradead.org>
 <Y3AXVRAoZA5YEho+@rhino>
 <1df133ef-d5e9-f323-7c67-fc9ffed04274@infradead.org>
 <Y3A9waTkehESUyn+@rhino>
 <abdb1b8d-859d-669b-6bbf-604febb643b2@infradead.org>
 <Y3BGimp2LmRqV9oy@rhino>
 <Y3IDWt9vINpCtXjP@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3IDWt9vINpCtXjP@hyeyoo>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:59:06PM +0900, Hyeonggon Yoo wrote:
> On Sat, Nov 12, 2022 at 08:21:14PM -0500, Ian Cowan wrote:
> > On Sat, Nov 12, 2022 at 05:11:27PM -0800, Randy Dunlap wrote:
> > > 
> > > 
> > > On 11/12/22 16:43, Ian Cowan wrote:
> > > > On Sat, Nov 12, 2022 at 04:34:18PM -0800, Randy Dunlap wrote:
> > > >>
> > > >>
> > > >> On 11/12/22 13:59, Ian Cowan wrote:
> > > >>> On Sat, Nov 12, 2022 at 09:21:34AM -0800, Randy Dunlap wrote:
> > > >>>> Hi--
> > > >>>>
> > > >>>> On 11/12/22 08:37, Ian Cowan wrote:
> > > >>>>> When compiling drivers (speficially drivers/pci/hotplug), I am receiving
> > > >>>>> the following modpost error for both `kmalloc_trace` and
> > > >>>>> `kmalloc_node_trace` on the staging/staging-next branch:
> > > >>>>>
> > > >>
> > > >> Ian, what do you mean by "on the staging/staging-next branch"?
> > > >>
> > > >> What kernel version are you trying to build?
> > > >>
> > > >> The .config that you sent is for v6.1.0-rc1.
> > > > 
> > > > I am building from the staging repository (gregkh/staging) and my
> > > > working branch when building is staging-next. So I am trying to build
> > > > from staging and not a particular version. I have also run `make modules_prepare`
> > > > and updated the .config per that script. However, when I do build
> > > > v6.1.0-rc1 from the main repository (torvalds/linux), I run into the same problem.
> > > 
> > > Have you built the entire kernel already and then you are trying to build
> > > only drivers/pci/hotplug?
> > Yes, I did build the entire kernel already and then I'm just trying to
> > rebuild that module.
> > 
> > In `include/linux/slab.h` if I remove the lines between `#ifdef
> > CONFIG_TRACING` and `#else` (lines 473-480) and then the corresponding
> > `#endif` and leave lines 481-499, I'm able to compile that module
> > without issue.
> 
> I don't get what the problem is.
> In case kmalloc[_node]_trace() is undefined, it's replaced with kmem_cache_alloc[_node]. 
> 
> Is the kernel built with same config on tree?

Yes, the same config on tree with no errors or warnings. I was able to
trace it back to this commit - building on the commit immediately prior
builds without error or warning. It looks like this commit does some
refactoring of the kmem_cache_alloc[_node] and kmalloc[_node]_trace.

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-next&id=26a40990ba052
