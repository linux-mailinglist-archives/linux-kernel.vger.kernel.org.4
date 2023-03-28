Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E86B6CBE29
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjC1LyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjC1LyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:54:03 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D9E6A7F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=BrwzSYm4qlu0nTuyTngTlfOl4RIB2UxL2RuI4CuMcZE=; b=kwH2NwmceG+zgIGou0R+M5KHeu
        KLYVZhG/+nbnPaOqSj3FDNNQchoJuthsHBPLQGJb/XHus3/KJXzhQQ9BFb8wGzwcg5UsxnfJfUMxD
        rfXVm//evWq2CC82XPADMyKtJ+pPpiufrUe9w6hBHdpULrxUhQqXEsGz9+fvg5M9tix6rr/9dzDuj
        NDY6rrBacOcmOSXYVskEbVcy3WmSr6FzF/bb7nyXFZgPnuAAJvE7SVzSVjxsWUsGEb4hIc/YiKSQx
        Y3bxlv+TJfK57oF4dMFQAgxdL+39SxXbsaxqX9FMpJjhqJlroQvB2dhEd4wf40XKwsbdlq6X+HseB
        gwj4RpG3K91d5Tf0Gxkegt/WT9s13hvp94n2p++1ZEllU9W5I8MYMyDWQQv2WhH/e4Hk3FXSidtVQ
        ktal5gQqYpOhgwcQov1dkheb+4avQFm3Ah25AXXduHDbnuxLbnJY31U8y8kERasuXU9SQepF/IJxi
        g4jYZ1T/tyBhM6fGIKgCIseJTdMKarTNUJqQfu8SEx90vGv7Ves32vRChg8PQOfNUu7iv7xMaaahb
        nUWC8pSNU3q0uvA/6OEuJkEUwmzO8dmCAOqq8Pf/4djs79jvej2ZszIM/s8xVyttI123sXEUr+hN5
        4nshqzOYk4mtZTEdh3bNHXWNXMZ585VfxWHxfh1vE=;
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
Date:   Tue, 28 Mar 2023 13:53:49 +0200
Message-ID: <2391219.DQnbcWml7j@silver>
In-Reply-To: <ZCJRlqc/epbRhm93@codewreck.org>
References: <ZA0FEyOtRBvpIXbi@bombadil.infradead.org>
 <ZCHU6k56nF5849xj@bombadil.infradead.org> <ZCJRlqc/epbRhm93@codewreck.org>
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

On Tuesday, March 28, 2023 4:31:50 AM CEST Dominique Martinet wrote:
> Luis Chamberlain wrote on Mon, Mar 27, 2023 at 10:39:54AM -0700:
> > > I have fixed what
> > > I hope to be my last bug with the new patch series so it should be
> > > going into linux-next today.
> > 
> > Nice, thanks, since kdevops relies on a host kernel though and we strive
> > to have stability for that, I personally like to recommend distro
> > kernels and so they're a few kernel releases out of date. So debian-testing
> > is on 6.1 as of today for example.
> > [...]
> > -    opts: "ro,trans=virtio,version=9p2000.L,posixacl,cache=loose"
> > +    opts: "ro,trans=virtio,version=9p2000.L,posixacl,cache=none"
> 
> Yes, if you want something mostly coherent with the host, cache=none (or
> cache=mmap if you need mmap, iirc linux build does for linking? if you
> want to do that on guest...) is what you'll want to use on current
> kernels.
> 
> > BTW the qemu wiki seems to suggest cache=loose and its why I used it on
> > kdevops as a default. What about the following so to avoid folks running
> > into similar issues? I can go and update the wiki too.
> 
> I've added Christian in Cc for this point, he's more active on the qemu
> side
> (thread started here:
> https://lkml.kernel.org/r/ZA0FEyOtRBvpIXbi@bombadil.infradead.org
> )
> 
> I have no opinion on the current wording, the default is there for a
> reason and it's a safe default (none), and cache=loose is clearly
> described with "no attempts are made at consistency, intended for
> exclusive, read-only mounts" which I think ought to be clear enough
> (exclusive means not shared with the host), but if you think it's not
> clear enough it probably isn't.
> 
> A word on the qemu wiki "if you want to share with host..." would
> probably be good though.

Hi Luis,

not sure which QEMU wiki page you are referring to. AFAIK we currently have 3
QEMU wiki pages concerning 9p:

1. 9p documentation for users:
https://wiki.qemu.org/Documentation/9psetup

2. 9p documentation for developers only:
https://wiki.qemu.org/Documentation/9p

3. How to setup an entire guest on top of a 9p root filesystem:
https://wiki.qemu.org/Documentation/9p_root_fs

Only the latter wiki page mentions cache=loose at all:

  "To speedup things you can also consider to use e.g. cache=loose instead. 
   That will deploy a filesystem cache on guest side and reduces the amount
   of 9p requests to hosts. As a consequence however guest might not 
   immediately see file changes performed on host side. So choose wisely upon
   intended use case scenario. You can change between cache=mmap or e.g.
   cache=loose at any time."

Which I now changed to:

  "To speedup things you can also consider to use e.g. cache=loose instead.
   That will deploy a filesystem cache on guest side and reduces the amount of
   9p requests to hosts. As a consequence however guest might not see file
   changes performed on host side *at* *all* (as Linux kernel's 9p client 
   currently does not revalidate for fs changes on host side at all, which is
   planned to be changed on Linux kernel side soon though). So choose wisely
   upon intended use case scenario. You can change between cache=mmap or e.g.
   cache=loose at any time."

On the user page it was already clearly mentioned though:

  "Mount the shared folder on guest using

      mount -t 9p -o trans=virtio test_mount /tmp/shared/ -oversion=9p2000.L,posixacl,msize=104857600,cache=none

  In the above example the folder /home/guest/9p_setup/ shared of the host
  is shared with the folder /tmp/shared on the guest. We use no cache because
  current caching mechanisms need more work and the results are not what you
  would expect."

Best regards,
Christian Schoenebeck


