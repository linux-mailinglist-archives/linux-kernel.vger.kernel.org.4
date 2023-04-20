Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE73D6E9C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjDTTWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjDTTWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:22:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E907C2717
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:22:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9640E1FD8C;
        Thu, 20 Apr 2023 19:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682018526;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uXvwYIgNLC4kcwKmk7HnoSn3oEer+G5mDmxEmWneBn8=;
        b=NofC3OAKDsapbnWFT97w6GFfNFBBogeivP4UrZDNo+ASjTZh3P5dZ5BO2M7CYO87dQiEtJ
        4ywulR9IOgro+SjulychlFc2rjOqe7eJ6jrQd4oK9EoWWS+kQLJzV2+af6wieocxgXgIHh
        Gp6AwSxP/tFuZwn6g77UiJnu42Vksk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682018526;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uXvwYIgNLC4kcwKmk7HnoSn3oEer+G5mDmxEmWneBn8=;
        b=7DBBR4Gyj3MSmXT9HgUEqgBINI8PRilBS2GN4wJCQJIiZlSzw9iHvG/KpFAdr3FNq8FJ4c
        LYnJKAQfsJZbS2CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 637641333C;
        Thu, 20 Apr 2023 19:22:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7oyIF96QQWRySwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 20 Apr 2023 19:22:06 +0000
Date:   Thu, 20 Apr 2023 21:21:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Neal Gompa <neal@gompa.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        Rafael Wysocki <rafael@kernel.org>, Chris Mason <clm@meta.com>,
        Boris Burkov <boris@bur.io>
Subject: Re: Linux regressions report for mainline [2023-04-16]
Message-ID: <20230420192156.GY19619@suse.cz>
Reply-To: dsterba@suse.cz
References: <CAHk-=wjL7GG9s9Y2+u2725M+Ru=bUXnzOnXRwoSktY0fVdhhzw@mail.gmail.com>
 <20230418213228.1273218-1-neal@gompa.dev>
 <d1b7b62d-bec8-e290-d12c-0b641ab382dd@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1b7b62d-bec8-e290-d12c-0b641ab382dd@leemhuis.info>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 07:03:31AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 18.04.23 23:32, Neal Gompa wrote:
> > 
> > I'm the guy that sort of kickstarted this whole thing a year ago.
> >>From my perspective in Fedora-land, we've been running automatic
> > weekly fstrim on every Fedora system for three years now[1] and
> > have not received any complaints about SSDs pushing daises from
> > that.
> > 
> > When we started discussing btrfs discard=async within Fedora
> > two years ago[2], I started soliciting feedback and information
> > from the Btrfs developers I was regularly working with at the time.
> > 
> > Last year, I had a face-to-face with Chris Mason and we discussed
> > the idea in depth and decided to go for this, based on both Fedora's
> > data with consumer disks and Facebook's data with their datacenters.
> > 
> > The only real surprise we had was the so-called "discard storm",
> > which Boris Burkov made adjustments to resolve a couple weeks ago[3].
> > [...]
> > [3]: https://lore.kernel.org/linux-btrfs/cover.1680723651.git.boris@bur.io/T/#t
> 
> Wait, what? Argh. Sorry, if I had seen that patch, I wouldn't have
> brought this up in my report at all. I missed it, as I wasn't CCed; and
> regzbot missed it, because the patch uses a odd format for the lore link
> (but not totally uncommon, will change regzbot to ensure that doesn't
> happen again).

I'd need pay more attention when the regression tracking process is
involved in case there are more patch versions floating around. People
usually don't "CC enough" so that you have the regzbot in place helps
to track the state.

> Ciao, Thorsten
> 
> P.S.: /me meanwhile yet again wonders if we should tell people to add a
> "CC: <regressions@lists.linux.dev>" on patches fixing regressions. Then
> in this case I would have become aware of the patch. And it makes it
> obvious for anybody handling patches that the patch is fixing a
> regression. But whatever, might not be worth it.

I'm not sure if it would fit how regzbot workflow works, but syzbot
provides links with the reports and then changes the state when the
patch is committed containing the links. I don't see anything similar in
the process/handling-regression document. If the "Link: <report>" is
sufficient then it should work already but there's no guarantee that the
submitted patches would contain that. I add links to the committed
versions but then you'd need to scan at least linux-next. In any case
with the regzbot it's fixable.
