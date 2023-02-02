Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FAE688018
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjBBO1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBBO1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:27:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D330FBB9D;
        Thu,  2 Feb 2023 06:27:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 616DCB82670;
        Thu,  2 Feb 2023 14:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C809C433D2;
        Thu,  2 Feb 2023 14:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675348058;
        bh=qOwTu/BTR9R+73FMppDBlSi8/NkSXWZrGllJ1FIjvL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=adEKWk11wzuIUaKuNN7JMFb/VwO1GBm3YEduvlKAYdT3270fPE8FycqG1xl0aDPoS
         zjigbG9JvCbZ5UYg/4PEtPC3rgHpEHYyJ2u60nx//7JT/w7ph7/n6Z0UkpE0LuBkYj
         FX55b/7rUzkuVJKVjmP+gTU06BhW/QAKgTKnnlSw=
Date:   Thu, 2 Feb 2023 15:27:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1] docs: describe how to quickly build Linux
Message-ID: <Y9vIVtnyvJBMmahC@kroah.com>
References: <fabdb45fa44db2531f0dbe5e88545c49dfb87040.1675252073.git.linux@leemhuis.info>
 <1f217c94-b90f-359a-2142-0d3ae5d84fc6@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f217c94-b90f-359a-2142-0d3ae5d84fc6@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 12:15:36PM +0100, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
> [adding Konstantin and Greg to the list of recipients]
> 
> On 01.02.23 12:52, Thorsten Leemhuis wrote:
> > Add a text explaining how to quickly build a kernel, as that's something
> > users will often have to do when they want to report an issue or test
> > proposed fixes. This is a huge and frightening task for quite a few
> > users these days, as many rely on pre-compiled kernels and have never
> > built their own. They find help on quite a few websites explaining the
> > process in various ways, but those howtos often omit important details
> > or make things too hard for the 'quickly build just for testing' case
> > that 'localmodconfig' is really useful for. Hence give users something
> > at hand to guide them, as that makes it easier for them to help with
> > testing, debugging, and fixing the kernel.
> 
> Side note: after feedback on social media I'll likely switch to a title
> like "how to quickly configure & build a trimmed-down Linux kernel", as
> some people from the current title assumed this would be about things
> like ccache. I'll also likely will switch to using a localversion file
> in the buildroot instead of modifying the EXTRAVERSION in the top-level
> makefile (but I haven't actually tried it yet).
> 
> > [...]
> >
> > The text currently describes two approaches to retrieve Linux' sources
> > using git: the regular clone with linux-stable as a remote and a shallow
> > clone with just one branch from linux-stable. The shallow clone approach
> > is a little bit more tricky to describe and handle, but downloads way
> > less data – and thus is a lot quicker, unless you have a really really
> > quick link to the internet (which in some parts of the world is hard to
> > come by). That's why I wonder if the text should switch to making the
> > shallow clone with selected stable branches the default. What do you
> > think, dear reader?
> 
> So, I looked into what Greg suggested (e.g.
> https://kernel.org/best-way-to-do-linux-clones-for-your-ci.html and
> https://www.kernel.org/cloning-linux-from-a-bundle.html
> ). Assuming users have a up2date git (afaics 2.38+) I could use commands
> like this in my text:
> 
> curl -L
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/clone.bundle
> -o ~/linux/linux-stable.git.bundle
> git clone --bundle-uri=linux-stable.git.bundle
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> ~/linux/sources
> rm ~/linux/linix-stable.git.bundle
> 
> This took roundabout 16 minutes with my 100 Mbit cable internet
> connection (~9 min for the download, 7 for the clone [the machine used
> is somewhat old]) and downloads & stores ~4,5 GByte data (without checkout).
> 
> [side note: using
> "--bundle-uri=https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/clone.bundle"
> does not work (due to the redirect? whatever) -- but that might be
> unwise anyway in case the download is interrupted]
> 
> 
> Then I tried creating a shallow clone like this:
> 
> git clone
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> --depth 1 -b v6.1
> git remote set-branches --add origin master
> git fetch --all --shallow-exclude=v6.1
> git remote add -t linux-6.1.y linux-stable
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> git fetch --all --shallow-exclude=v6.1
> 
> This took only roundabout 2 minutes and downloads & stores ~512 MByte
> data (without checkout).
> 
> 
> Not totally sure, but the shallow clone somehow feels more appropriate
> for the use case (reminder, there is a "quickly" in the document title),
> even if such a clone is less flexible (e.g. users have to manually add
> stable branches they are interested it; and they need to be careful when
> using git fetch).
> 
> That's why I now strongly consider using the shallow clone method by
> default in v2 of this text. Or does that also create a lot of load on
> the servers? Or are there other strong reason why using a shallow clone
> might be a bad idea for this use case?

I think Konstantin answered your question already on a social network
based on the server load question.

For the "will this work for testing", sure, a shallow clone should work
just fine, if no one has to use 'git bisect' to go back further than the
version you originally clone.  Hopefully that's not a normal thing.

thanks,

greg k-h
