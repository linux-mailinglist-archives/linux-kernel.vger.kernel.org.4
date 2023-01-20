Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C406750F3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjATJZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjATJZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:25:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A223A2946
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674206549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcgb4AWInvRFGMvemLC1b9tF/CflE/dOe40pqP7k7hM=;
        b=NoWGXP4LwATpOlB209+B5JQJGvgak8UZsW9cytZelw+0Zlej5LAPQuRWei4WNDEDirBbs4
        ptBjfvG7JxQEqzgLVH47W/PeJeaalWgwIRmPjjNrwnP491dJv1dY9H3BEz1wiug1gvFus6
        G3TN21Q+Vx1TX6J6Oh7PDT5sJOv74Jk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-145-ExoMbCATNEyTwI7ickV7vg-1; Fri, 20 Jan 2023 04:22:27 -0500
X-MC-Unique: ExoMbCATNEyTwI7ickV7vg-1
Received: by mail-ej1-f69.google.com with SMTP id sb39-20020a1709076da700b0086b1cfb06f0so3414136ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcgb4AWInvRFGMvemLC1b9tF/CflE/dOe40pqP7k7hM=;
        b=B7wP2SMAr1Z2ZDqypcGwD5GQSrE7vB0hR1YyYV/I2wKXhpber+WFhynm8NQCWxbQ/T
         EQVZCg0h33texDL4SOE8KaLXXPosFHM0Kl/H41ZfHox/8S4PXGIy7fzNWOLb+Vvvm54x
         Mpk0J/CHKAAfB4krKVQvN/Cwv+WwkHzCmSbxshv/J9GLmnInlm4a0cQQulXM/93jR/G9
         gLAVbH3pCbPZ8imxdvD7bUwpTRVBybY3JiHt4PopuGUDTAvg87Ym2ZgNInlJ5c5b93ln
         O1NA/yW5JSDxjZHOadli+Edmv6PvYqKYXDCudU0GbbTXMKWVF0bx8cqxJ8rrrKWJgSZV
         076Q==
X-Gm-Message-State: AFqh2kpTrivWoPOwLppl0L3obAWejRD02qkr5xO4Vx0yJQ4zXz0bKxsU
        +syF/S+f8Yax1uB0f2WPeO2GILKHubCSH6svwzrX0wafqWpfMM4HVGcH9hKE3C6Et0nO64Q/NBu
        A7Q9HUwm+Ypk7xXA2cyIhlxvw
X-Received: by 2002:a17:906:5acf:b0:86c:8f4a:58b4 with SMTP id x15-20020a1709065acf00b0086c8f4a58b4mr14440441ejs.13.1674206546301;
        Fri, 20 Jan 2023 01:22:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtFrxhhFxAuF+GcMJQRNThLC5DHRALaKEBBMEZuV+AoIhuADVBBTjDNmuZw1VHTaPQLSTkolw==
X-Received: by 2002:a17:906:5acf:b0:86c:8f4a:58b4 with SMTP id x15-20020a1709065acf00b0086c8f4a58b4mr14440421ejs.13.1674206545963;
        Fri, 20 Jan 2023 01:22:25 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id hq15-20020a1709073f0f00b0084c7029b24dsm17794966ejc.151.2023.01.20.01.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 01:22:25 -0800 (PST)
Message-ID: <46f05b5f986b4377f02907c2660f2d144030c3b8.camel@redhat.com>
Subject: Re: [PATCH v2 0/6] Composefs: an opportunistically sharing verified
 image filesystem
From:   Alexander Larsson <alexl@redhat.com>
To:     Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        Yurii Zubrytskyi <zyy@google.com>,
        Eugene Zemtsov <ezemtsov@google.com>,
        Vivek Goyal <vgoyal@redhat.com>
Date:   Fri, 20 Jan 2023 10:22:24 +0100
In-Reply-To: <20230117101202.4v4zxuj2tbljogbx@wittgenstein>
References: <cover.1673623253.git.alexl@redhat.com>
         <3065ecb6-8e6a-307f-69ea-fb72854aeb0f@linux.alibaba.com>
         <d3c63da908ef16c43a6a65a22a8647bf874695c7.camel@redhat.com>
         <0a144ffd-38bb-0ff3-e8b2-bca5e277444c@linux.alibaba.com>
         <9d44494fdf07df000ce1b9bafea7725ea240ca41.camel@redhat.com>
         <d7c4686b-24cc-0991-d6db-0dec8fb9942e@linux.alibaba.com>
         <2856820a46a6e47206eb51a7f66ec51a7ef0bd06.camel@redhat.com>
         <8f854339-1cc0-e575-f320-50a6d9d5a775@linux.alibaba.com>
         <CAOQ4uxh34udueT-+Toef6TmTtyLjFUnSJs=882DH=HxADX8pKw@mail.gmail.com>
         <20230117101202.4v4zxuj2tbljogbx@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-17 at 11:12 +0100, Christian Brauner wrote:
> On Tue, Jan 17, 2023 at 09:05:53AM +0200, Amir Goldstein wrote:
> > > It seems rather another an incomplete EROFS from several points
> > > of view.=C2=A0 Also see:
> > > https://lore.kernel.org/all/1b192a85-e1da-0925-ef26-178b93d0aa45@plex=
istor.com/T/#u
> > >=20
> >=20
> > Ironically, ZUFS is one of two new filesystems that were discussed
> > in LSFMM19,
> > where the community reactions rhyme with the reactions to
> > composefs.
> > The discussion on Incremental FS resembles composefs case even more
> > [1].
> > AFAIK, Android is still maintaining Incremental FS out-of-tree.
> >=20
> > Alexander and Giuseppe,
> >=20
> > I'd like to join Gao is saying that I think it is in the best
> > interest
> > of everyone,
> > composefs developers and prospect users included,
> > if the composefs requirements would drive improvement to existing
> > kernel subsystems rather than adding a custom filesystem driver
> > that partly duplicates other subsystems.
> >=20
> > Especially so, when the modifications to existing components
> > (erofs and overlayfs) appear to be relatively minor and the
> > maintainer
> > of erofs is receptive to new features and happy to collaborate with
> > you.
> >=20
> > w.r.t overlayfs, I am not even sure that anything needs to be
> > modified
> > in the driver.
> > overlayfs already supports "metacopy" feature which means that an
> > upper layer
> > could be composed in a way that the file content would be read from
> > an arbitrary
> > path in lower fs, e.g. objects/cc/XXX.
> >=20
> > I gave a talk on LPC a few years back about overlayfs and container
> > images [2].
> > The emphasis was that overlayfs driver supports many new features,
> > but userland
> > tools for building advanced overlayfs images based on those new
> > features are
> > nowhere to be found.
> >=20
> > I may be wrong, but it looks to me like composefs could potentially
> > fill this void,
> > without having to modify the overlayfs driver at all, or maybe just
> > a
> > little bit.
> > Please start a discussion with overlayfs developers about missing
> > driver
> > features if you have any.
>=20
> Surprising that I and others weren't Cced on this given that we had a
> meeting with the main developers and a few others where we had said
> the
> same thing. I hadn't followed this.=20

Sorry about that, I'm just not very used to the kernel submission
mechanism. I'll CC you on the next version.

>=20
> We have at least 58 filesystems currently in the kernel (and that's a
> conservative count just based on going by obvious directories and
> ignoring most virtual filesystems).
>=20
> A non-insignificant portion is probably slowly rotting away with
> little
> fixes coming in, with few users, and not much attention is being paid
> to
> syzkaller reports for them if they show up. I haven't quantified this
> of
> course.
>=20
> Taking in a new filesystems into kernel in the worst case means that
> it's being dumped there once and will slowly become unmaintained.
> Then
> we'll have a few users for the next 20 years and we can't reasonably
> deprecate it (Maybe that's another good topic: How should we fade out
> filesystems.).
>=20
> Of course, for most fs developers it probably doesn't matter how many
> other filesystems there are in the kernel (aside from maybe competing
> for the same users).
>=20
> But for developers who touch the vfs every new filesystems may
> increase
> the cost of maintaining and reworking existing functionality, or
> adding
> new functionality. Making it more likely to accumulate hacks, adding
> workarounds, or flatout being unable to kill off infrastructure that
> should reasonably go away. Maybe this is an unfair complaint but just
> from experience a new filesystem potentially means one or two weeks
> to
> make a larger vfs change.
>=20
> I want to stress that I'm not at all saying "no more new fs" but we
> should be hesitant before we merge new filesystems into the kernel.

Well, it sure reads as "no more new fs" to me. But I understand that
there is hesitation towards this. The new version will be even simpler
(based on feedback from dave), weighing in at < 2000 lines. Hopefully
this will make it easier to review and maintain and somewhat countering
the cost of yet another filesystem.

> Especially for filesystems that are tailored to special use-cases.
> Every few years another filesystem tailored to container use-cases
> shows
> up. And frankly, a good portion of the issues that they are trying to
> solve are caused by design choices in userspace.

Well, we have at least two use cases, but sure, it is not a general
purpose filesystem.

> And I have to say I'm especially NAK-friendly about anything that
> comes
> even close to yet another stacking filesystems or anything that
> layers
> on top of a lower filesystem/mount such as ecryptfs, ksmbd, and
> overlayfs. They are hard to get right, with lots of corner cases and
> they cause the most headaches when making vfs changes.

I can't disagree here, because I'm not a vfs maintainer, but I will say
that composefs is fundamentally much simpler that these examples. First
because it is completely read-only, and secondly because it doesn't
rely on the lower filesystem for anything but file content (i.e. lower
fs metadata or directory structure doesn't affect the upper fs).

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a jaded white trash astronaut haunted by an iconic dead American=20
confidante She's a brilliant extravagent femme fatale who can talk to=20
animals. They fight crime!=20

