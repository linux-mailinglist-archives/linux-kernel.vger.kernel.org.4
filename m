Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E332B738C69
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjFUQzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjFUQz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:55:26 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02262E9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:55:24 -0700 (PDT)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 578DA3F188
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687366522;
        bh=+9U0XU2Gxr37XDMHjv7vr70CfmLrF445b9aXRviWook=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=IyBcBKPRnUsfvP0QQo7YVlJgWBWzNsIlvntgcWcAO+UtTlv8PSLkl3zgPSVJgJqBw
         TDfNr+Zg+4W8SrOuiJKLyvLeTE1wBOt9LXvhDQq6VC6B2jQHz6REnvrAxYr+IXz1Vz
         pwC+PPzfwokHvd6EX4wLtHsptWQCLUw/B1RQMn1a6+4P5s17BPsPCx5CRLMZpdBwjE
         xxcl0exohWRb9GmeWmT4llGpTPu3hLYLGgXBVf/muG6ZGyAJ5XB+VIuKHgHbn+vLVa
         c9DHfuGmq+AVDYR1vaAi1STS6Kh8wACXSjdavmvK0jV74MUaMOpuX5KCIcjIf5Hpzu
         fqE4oppHmkSig==
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-bacd408046cso7966247276.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687366519; x=1689958519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9U0XU2Gxr37XDMHjv7vr70CfmLrF445b9aXRviWook=;
        b=EVmvpgXScG3x0uqlkCJbtpKi8zmhvgrBDxR5LMCgJxGNyfQ7wqgxckh0sQ329wyv4y
         9lM2HD50e+mx7Gpn3m4vrFME5Vo5sun8fmhae1Ysko7ffUZjqjQfWpzoKiDCsClEH8wU
         Xt4nUzPIdwgO2VwQP2Tx2iQVDrxZJP9rnt179Zn6/in4NLmXktYkyUkZ7dux9W8sGFwQ
         RqsaciOAnu+rySsTjI0TdLqHZzBKa3kDsLesswxx7L7OfLnchhKbZn53UivGpAtSGn87
         Af6Ng7xNUwFUbBN2k7BgMmgu5WkDERIPWi//zHpVO/0EO8kLQDg+PRVExmJP1gNMYUxa
         2FVQ==
X-Gm-Message-State: AC+VfDwOgHXz4DUO9wjpY1MGdo2q8YECvR6IIHr6kWeSZhKGWZR1kdu+
        oz8eNSaaohK5JWCjNSnNbPdSpxRhWvLwYLw1njG/2VZxV9YmYWUZwdDw1dBHL9P3OAd0CCpV0Es
        FPvMSvz/bHBYhqiYSOhd5lZ6Kr/BFTK0k1/7MNR5gmUYWMktfJjlrJQ0LNA==
X-Received: by 2002:a25:748e:0:b0:bc7:b120:1ea0 with SMTP id p136-20020a25748e000000b00bc7b1201ea0mr13025467ybc.3.1687366519284;
        Wed, 21 Jun 2023 09:55:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4r9CExidg5ZT0PtvLMtlOMLooYGnRuySf8LXaLqhUHu8Kb5ASFxq8JUOv24NUG+4q3/LpHPwK2//3UFeLziL0=
X-Received: by 2002:a25:748e:0:b0:bc7:b120:1ea0 with SMTP id
 p136-20020a25748e000000b00bc7b1201ea0mr13025454ybc.3.1687366519013; Wed, 21
 Jun 2023 09:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com> <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner> <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com> <CAJ4mKGby71qfb3gd696XH3AazeR0Qc_VGYupMznRH3Piky+VGA@mail.gmail.com>
 <977d8133-a55f-0667-dc12-aa6fd7d8c3e4@redhat.com> <CAEivzxcr99sERxZX17rZ5jW9YSzAWYvAjOOhBH+FqRoso2=yng@mail.gmail.com>
 <626175e2-ee91-0f1a-9e5d-e506aea366fa@redhat.com> <bb20aebe-e598-9212-1533-c777ea89948a@redhat.com>
 <CAEivzxdBoWrN1cNrotAcKrfRHg+0oajwSFT3OBAKTrjvmn=MKA@mail.gmail.com>
In-Reply-To: <CAEivzxdBoWrN1cNrotAcKrfRHg+0oajwSFT3OBAKTrjvmn=MKA@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Wed, 21 Jun 2023 18:55:07 +0200
Message-ID: <CAEivzxdyLz1ZukU=1OOxcLUDidkwN0WaMn82coya0cc9V67buQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Gregory Farnum <gfarnum@redhat.com>,
        Christian Brauner <brauner@kernel.org>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 2:54=E2=80=AFPM Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> On Thu, Jun 15, 2023 at 2:29=E2=80=AFPM Xiubo Li <xiubli@redhat.com> wrot=
e:
> >
> > [...]
> >
> >  > > >
> >  > > > I thought about this too and came to the same conclusion, that
> > UID/GID
> >  > > > based
> >  > > > restriction can be applied dynamically, so detecting it on mount=
-time
> >  > > > helps not so much.
> >  > > >
> >  > > For this you please raise one PR to ceph first to support this, an=
d in
> >  > > the PR we can discuss more for the MDS auth caps. And after the PR
> >  > > getting merged then in this patch series you need to check the
> >  > > corresponding option or flag to determine whether could the idmap
> >  > > mounting succeed.
> >  >
> >  > I'm sorry but I don't understand what we want to support here. Do we
> > want to
> >  > add some new ceph request that allows to check if UID/GID-based
> >  > permissions are applied for
> >  > a particular ceph client user?
> >
> > IMO we should prevent users to set UID/GID-based MDS auth caps from cep=
h
> > side. And users should know what has happened.
>
> ok, we want to restrict setting of UID/GID-based permissions if there is =
an
> idmapped mount on the client. IMHO, idmapping mounts is truly a
> client-side feature
> and server modification looks a bit strange to me.
>
> >
> > Once users want to support the idmap mounts they should know that the
> > MDS auth caps won't work anymore.
>
> They will work, but permission rule configuration should include
> non-mapped UID/GID-s.
> As I mentioned here [1] it's already the case even without mount idmappin=
gs.
>
> It would be great to discuss this thing as a concept and synchronize
> our understanding of this
> before going into modification of a server side.

Hi everyone,

I've spent some extra time analyzing this issue with UID/GID-based
path restriction feature and idmapped mounts
one more time and am still fully sure that we have two ways here:
I. Extend Cephfs protocol (add new fields to request arguments in the
"union ceph_mds_request_args")
There should be 2 new fields for the file/directory owner's UID and
GID respectively. With the help of these
new fields, we will be able to split the permission check logic (that
is based on the caller's UID/GID and should not be affected by
the mounts idmapping at all!) and file owner concept, which involves
mounts' idmapping.
II. ignore this issue as non-critical, because:
- idmapped mounts can be created only by privileged users
(CAP_SYS_ADMIN in the superblock owner's user namespace (currently,
it's always the initial user namespace!))
- the surface of the problem is really small (combination of idmapped
mount + UID/GID path-based restriction)
- problem *can* be workarounded by appropriate permission
configuration (UID/GID permissions should be configured to
include both the mount's idmapping UIDs/GIDs and the host ones).

Before that I've highlighted some existing problems of this UID/GID
path-based restriction feature:
- [kernel client] UID/GIDs are sent to the server always from the
initial user namespace (while the caller can be from inside the
container with a non-initial user namespace)
- [fuse client] UID/GIDs are always mapped to the fuse mount's
superblock user namespace
(https://github.com/ceph/ceph-client/blob/409e873ea3c1fd3079909718bbeb06ac1=
ec7f38b/fs/fuse/dev.c#L138)
It means that we already have analogical inconsistency between clients
(userspace one and kernel).
- [kernel client] We always take current user credentials instead of
using (struct file)->f_cred as it has usually done for other
filesystems

Please understand me in the right way, I'm not trying to say that we
need to be lazy and ignore the issue at all, but I'm
just trying to say that this issue is not local and is not caused by
an idmapped mounts, but it there is something to do on the cephfs
side,
we need to extend protocol and it's not obvious that it is worth it.
My understanding is that we need to clarify this limitation in
cephfs kernel client documentation and explain how to configure
UID/GID path-based permissions with idmapped mounts to work around
this.
And if we get requests from our users that this is interesting to
someone to support it in the right way then we can do all of this
crazy stuff
by extending ceph protocol. Btw, I've checked when "union
ceph_mds_request_args" was extended last time. It was 6 (!) years ago
:)

Kind regards,
Alex

>
> [1] https://lore.kernel.org/lkml/CAEivzxcBBJV6DOGzy5S7=3DTUjrXZfVaGaJX5z7=
WFzYq1w4MdtiA@mail.gmail.com/
>
> Kind regards,
> Alex
>
> >
> > Thanks
> >
> > - Xiubo
> >
