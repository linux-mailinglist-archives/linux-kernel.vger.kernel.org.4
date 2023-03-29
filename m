Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC3B6CD853
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjC2LTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjC2LTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:19:36 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7263AB8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=ileIkfmdnMy/56ic43iEWAbjiYmiGoaU3VQE/Y3cqAg=; b=gr9/E8pZqbhqiYDFGxPWEfMFpX
        Jnq15hdxqRt+/AVKdTaX0L/C2YNzfxaYQZjaGd9OZrIFvir20ydz3/kVcUtFXE/CGFArtBvD/VA/r
        V8V/2MWFgAEC3dJrxUddNXBoSKxGRXBv8uIk8YWdsNAF/z4EEcI9tfbtxbnGcm4FD8IKrEAzrMBnf
        4TBsJbhAERlu2yw0tYI9koz/bZ9HAWSZVqy12DfIvcUN9Sqq3lh8A1Lv/qU94wOgmL0P9oeqMad49
        706a+dbkxfDuSnzUosevxH8twwrwXTh0W22Wn4mmPfysXa075e+dCyS9JF7/wYh/zK8MxkEDnSlup
        xsLqmM+s4+1dAQ23PcCZwMrx+TkhTvKEERu6au2PMRgpTHNhVJOAYiLFsx8QIHi+Djp4u0pG6jbjU
        uH+E4jTU9dSlfSS++Gep+1pjNwkCVJlL46Gx/T1J0nAOok9GF5bPWoW6LQh0Qn21UQHYFy6X+1JZ3
        aRcCmxjtJ88ApqewZeex1MWe8Ebd3qVtwE9YDMASV/0lmTZ6yZ55ByVTzSR2p7TRmHFMetm9RWDb7
        PAV3TohNZrGSmIa0vSy96qss3ENioYATrpMRTUv4SvmRQQDQvTPyrsr1Jfm8RvqhbyyY90Bf478b6
        8FOkbqikwL49KjWu6RCjiH8dByNLlJAcGuKmctKyQ=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jeff Layton <jlayton@kernel.org>, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: 9p caching with cache=loose and cache=fscache
Date:   Wed, 29 Mar 2023 13:19:08 +0200
Message-ID: <2322056.HEUtEhvpMu@silver>
In-Reply-To: <ZCNlWnQTbWoBBPd2@codewreck.org>
References: <ZA0FEyOtRBvpIXbi@bombadil.infradead.org>
 <ZCMmrnmZFcH65Orp@bombadil.infradead.org> <ZCNlWnQTbWoBBPd2@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 29, 2023 12:08:26 AM CEST Dominique Martinet wrote:
> Luis Chamberlain wrote on Tue, Mar 28, 2023 at 10:41:02AM -0700:
> > >   "To speedup things you can also consider to use e.g. cache=loose instead.
> > 
> > My experience is that cache=loose is totally useless.
> 
> If the fs you mount isn't accessed by the host while the VM is up, and
> isn't shared with another guest (e.g. "exclusive share"), you'll get
> what you expect.
> 
> I have no idea what people use qemu's virtfs for but this is apparently
> common enough that it was recommended before without anyone complaining
> since that started being recommended in 2011[1] until now?
> 
> [1] https://wiki.qemu.org/index.php?title=Documentation/9psetup&diff=2178&oldid=2177
> 
> (now I'm not arguing it should be recommended, my stance as a 9p
> maintainer is that the default should be used unless you know what
> you're doing, so the new code should just remove the 'cache=none'
> altogether as that's the default.
> With the new cache models Eric is preparing comes, we'll get a new safe
> default that will likely be better than cache=none, there is no reason
> to explicitly recommend the historic safe model as the default has
> always been on the safe side and we have no plan of changing that.)

It's not that I receive a lot of feedback for what people use 9p for, nor am I
QEMU's 9p maintainer for a long time, but so far contributors cared more about
performance and other issues than propagating changes host -> guest without
reboot/remount/drop_caches. At least they did not care enough to work on
patches.

Personally I also use cache=loose and only need to push changes host->guest
once in a while.

> > >    That will deploy a filesystem cache on guest side and reduces the amount of
> > >    9p requests to hosts. As a consequence however guest might not see file
> > >    changes performed on host side *at* *all*
> > 
> > I think that makes it pretty useless, aren't most setups on the guest read-only?
> > 
> > It is not about "may not see", just won't. For example I modified the
> > Makefile and compiled a full kernel and even with those series of
> > changes, the guest *minutes later* never saw any updates.
> 
> read-only on the guest has nothing to do with it, nor has time.
> 
> If the directory is never accessed on the guest before the kernel has
> been built, you'll be able to make install on the guest -- once, even if
> the build was done after the VM booted and fs mounted.
> 
> After it's been read once, it'll stay in cache until memory pressure (or
> an admin action like umount/mount or sysctl vm.drop_caches=3) clears it.
> 
> I believe that's why it appeared to work until you noticed the issue and
> had to change the mount option -- I'd expect in most case you'll run
> make install once and reboot/kexec into the new kernel.
> 
> It's not safe for your usecase and cache=none definitely sounds better
> to me, but people should use defaults make their own informed decision.

It appears to me that read-only seems not to be the average use case for 9p,
at least from the command lines I received. It is often used in combination
with overlayfs though.

I (think) the reason why cache=loose was recommended as default option on the
QEMU wiki page ages ago, was because of its really poor performance at that
point. I would personally not go that far and discourage people from using
cache=loose in general, as long as they get informed about the consequences.
You still get a great deal of performance boost, the rest is for each
individual to decide.

Considering that Eric already has patches for revalidating the cache in the
works, I think the changes I made on the other QEMU wiki page are appropriate,
including the word "might" as it's soon only a matter of kernel version.

> >>   In the above example the folder /home/guest/9p_setup/ shared of the
> >>   host is shared with the folder /tmp/shared on the guest. We use no
> >>   cache because current caching mechanisms need more work and the
> >>   results are not what you would expect."
> >
> > I got a wiki account now and I was the one who had clarified this.
> 
> Thanks for helping making this clearer.

Yep, and thanks for making a wiki account and improving the content there
directly. Always appreciated!



