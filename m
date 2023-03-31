Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF5D6D263A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjCaQu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjCaQuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:50:00 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB82C23B75
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:47:24 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5445009c26bso425557937b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680281243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZS7d7+T0OxQvYK3IXahXhyZfGvpeL3UaMkf6s2Bw4Y=;
        b=NRAWWllwTLVGvMSvyrYM2t7yJQGQzEtzX1s2+wMIffidrBT850ocAuhwKJ8I9hVoGg
         yDfjxOpBet9evCqoOrFf3NZBsJGt4hXaaoxQ543woJGWS3FfaYED6NuJvWOgEvwQf0a3
         t5lCwIuEhmsNwsYmdxcdxBBVQ/Hi6leXSVYCTHy9Uqm3wPPvsvaLR7+IhkiFcX/IkmD+
         iWL04tMGSyGPGLK4XqeqmNEKkpd6ToKj3ulrm+2kwPaAmSm6uWOUg6TkooiFfyHTE8Nq
         HLyvOZxSSW2+PPGnHKllK98ass29UoTkbWUCm92/V8hS86BFcTOeCHoldlLJW7VkevTX
         lBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680281243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZS7d7+T0OxQvYK3IXahXhyZfGvpeL3UaMkf6s2Bw4Y=;
        b=g+5o3qA39OsMrm1t1GNL1W7MUlu/YBF2NQKP2nPPI9p2SsYL5NFUP2hC4GsDUKXsNM
         TSOFl1LArxhTOh6LjF73fm8qgepB/N5x0E4QIVAY46kJGayvR/FGtZllzJwwd1F7GaCc
         QsuFnBgPYw3qftCsuf5YVuSy8Fd8JIadZzpP3ap0h/YBs/Z1+ysVTaMPOsneR/Bi41ph
         fAdydIe+ho4N7Z0bHLYeeIe03/sP6CrZDM43fy/xZlr49OZl3g3pdW3aoXd2WmKBS9Zv
         pcz1m21ttoHEU8BolT0jq8xrcN+LoiNXL+QmNPbvI2eWDmoy9QKB1k3qJ3/rDG+ugQoQ
         774Q==
X-Gm-Message-State: AAQBX9d6BSUkgnylqxAbb/FY1LTFHS0Vg2Dg4N4iEY6sNVnssFht3Qsj
        pmqgqjGAttgoPpNQFr/BCbmAZj9swq/oqrN9ETw=
X-Google-Smtp-Source: AKy350Y7/xO/rQJYMGqdUAlYBMUfzqrigzlpMOS5N8Qw02cwN6O7P8VBYSLpWwCpGzVxUPz6viRUZkwqJzCzP1Od9uU=
X-Received: by 2002:a81:b50f:0:b0:544:b8d8:339e with SMTP id
 t15-20020a81b50f000000b00544b8d8339emr14051696ywh.5.1680281242941; Fri, 31
 Mar 2023 09:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <ZA0FEyOtRBvpIXbi@bombadil.infradead.org> <ZCMmrnmZFcH65Orp@bombadil.infradead.org>
 <ZCNlWnQTbWoBBPd2@codewreck.org> <2322056.HEUtEhvpMu@silver> <6f89f0ac34956e7f527c7efa3d162b4a1f5ea71a.camel@kernel.org>
In-Reply-To: <6f89f0ac34956e7f527c7efa3d162b4a1f5ea71a.camel@kernel.org>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Fri, 31 Mar 2023 11:47:12 -0500
Message-ID: <CAFkjPT=gJBELBg1gCjYFrZKVp5fy1vmidByOstB8tfqcuCUvLA@mail.gmail.com>
Subject: Re: 9p caching with cache=loose and cache=fscache
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Josef Bacik <josef@toxicpanda.com>, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I like the sliding window concept - I wasn't aware NFS was doing that,
I'll have a look as part of my rework.
The unmount/mount should indeed flush any cache (unless using
fscache), so that might be a good workaround if it can be automated in
the workflow.

          -eric

On Wed, Mar 29, 2023 at 6:32=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2023-03-29 at 13:19 +0200, Christian Schoenebeck wrote:
> > On Wednesday, March 29, 2023 12:08:26 AM CEST Dominique Martinet wrote:
> > > Luis Chamberlain wrote on Tue, Mar 28, 2023 at 10:41:02AM -0700:
> > > > >   "To speedup things you can also consider to use e.g. cache=3Dlo=
ose instead.
> > > >
> > > > My experience is that cache=3Dloose is totally useless.
> > >
> > > If the fs you mount isn't accessed by the host while the VM is up, an=
d
> > > isn't shared with another guest (e.g. "exclusive share"), you'll get
> > > what you expect.
> > >
> > > I have no idea what people use qemu's virtfs for but this is apparent=
ly
> > > common enough that it was recommended before without anyone complaini=
ng
> > > since that started being recommended in 2011[1] until now?
> > >
> > > [1] https://wiki.qemu.org/index.php?title=3DDocumentation/9psetup&dif=
f=3D2178&oldid=3D2177
> > >
> > > (now I'm not arguing it should be recommended, my stance as a 9p
> > > maintainer is that the default should be used unless you know what
> > > you're doing, so the new code should just remove the 'cache=3Dnone'
> > > altogether as that's the default.
> > > With the new cache models Eric is preparing comes, we'll get a new sa=
fe
> > > default that will likely be better than cache=3Dnone, there is no rea=
son
> > > to explicitly recommend the historic safe model as the default has
> > > always been on the safe side and we have no plan of changing that.)
> >
> > It's not that I receive a lot of feedback for what people use 9p for, n=
or am I
> > QEMU's 9p maintainer for a long time, but so far contributors cared mor=
e about
> > performance and other issues than propagating changes host -> guest wit=
hout
> > reboot/remount/drop_caches. At least they did not care enough to work o=
n
> > patches.
> >
> > Personally I also use cache=3Dloose and only need to push changes host-=
>guest
> > once in a while.
> >
> > > > >    That will deploy a filesystem cache on guest side and reduces =
the amount of
> > > > >    9p requests to hosts. As a consequence however guest might not=
 see file
> > > > >    changes performed on host side *at* *all*
> > > >
> > > > I think that makes it pretty useless, aren't most setups on the gue=
st read-only?
> > > >
> > > > It is not about "may not see", just won't. For example I modified t=
he
> > > > Makefile and compiled a full kernel and even with those series of
> > > > changes, the guest *minutes later* never saw any updates.
> > >
> > > read-only on the guest has nothing to do with it, nor has time.
> > >
> > > If the directory is never accessed on the guest before the kernel has
> > > been built, you'll be able to make install on the guest -- once, even=
 if
> > > the build was done after the VM booted and fs mounted.
> > >
> > > After it's been read once, it'll stay in cache until memory pressure =
(or
> > > an admin action like umount/mount or sysctl vm.drop_caches=3D3) clear=
s it.
> > >
> > > I believe that's why it appeared to work until you noticed the issue =
and
> > > had to change the mount option -- I'd expect in most case you'll run
> > > make install once and reboot/kexec into the new kernel.
> > >
> > > It's not safe for your usecase and cache=3Dnone definitely sounds bet=
ter
> > > to me, but people should use defaults make their own informed decisio=
n.
> >
> > It appears to me that read-only seems not to be the average use case fo=
r 9p,
> > at least from the command lines I received. It is often used in combina=
tion
> > with overlayfs though.
> >
> > I (think) the reason why cache=3Dloose was recommended as default optio=
n on the
> > QEMU wiki page ages ago, was because of its really poor performance at =
that
> > point. I would personally not go that far and discourage people from us=
ing
> > cache=3Dloose in general, as long as they get informed about the conseq=
uences.
> > You still get a great deal of performance boost, the rest is for each
> > individual to decide.
> >
> > Considering that Eric already has patches for revalidating the cache in=
 the
> > works, I think the changes I made on the other QEMU wiki page are appro=
priate,
> > including the word "might" as it's soon only a matter of kernel version=
.
> >
> > > > >   In the above example the folder /home/guest/9p_setup/ shared of=
 the
> > > > >   host is shared with the folder /tmp/shared on the guest. We use=
 no
> > > > >   cache because current caching mechanisms need more work and the
> > > > >   results are not what you would expect."
> > > >
> > > > I got a wiki account now and I was the one who had clarified this.
> > >
> > > Thanks for helping making this clearer.
> >
> > Yep, and thanks for making a wiki account and improving the content the=
re
> > directly. Always appreciated!
> >
>
> Catching up on this thread.
>
> Getting cache coherency right on a network filesystem is quite
> difficult. It's always a balance between correctness and performance.
>
> Some protocols (e.g. CIFS and Ceph) take a very heavy-handed approach to
> try ensure that the caches are always coherent. Basically, these clients
> are only allowed to cache when the server grants permission for it. That
> can have a negative effect on performance, of course.
>
> NFS as a protocol is more "loose", but we've generally beat its cache
> coherency mechanisms into shape over the years, so you don't see these
> sorts of problems there as much. FWIW, NFS uses a sliding time window to
> revalidate the cache, such that it'll revalidate frequently when an
> inodes is changing frequently, but less so when it's more stable.
>
> 9P I haven't worked with as much, but it sounds like it doesn't try to
> keep caches coherent (at least not with cache=3Dloose).
>
> Probably the simplest solution here is to simply unmount/mount before
> you have the clients call "make modules_install && make install". That
> should ensure that the client doesn't have any stale data in the cache
> when the time comes to do the reads. A full reboot shouldn't be
> required.
>
> --
> Jeff Layton <jlayton@kernel.org>
