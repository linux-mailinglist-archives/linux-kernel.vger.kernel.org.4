Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AF36F84B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjEEORb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjEEOR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8016711623
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 07:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683296203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQtfdULdSvD0JHxZLBgiy4HejSjwOhquH5OGzliVEtg=;
        b=hkKBfQ1EWuIUMG9cMKB3DGzNWGNlYGVefS8Z3mCj093A/lb913tD1d6KvyiQPS2xbqDCpq
        Yjz4hi50/EqCp/veIXi5kPUhNgn/ZI203hK2xOn46Sgt4B1r/lEJaK6bMa+fBuJpkLqPnn
        8KyBYomMxsKqDLwHadxkRzcnZyBMSVE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-hjtPL0Y8PJCNnzHKUv7BVQ-1; Fri, 05 May 2023 10:16:42 -0400
X-MC-Unique: hjtPL0Y8PJCNnzHKUv7BVQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6438c8a0cb5so945836b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 07:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683296200; x=1685888200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQtfdULdSvD0JHxZLBgiy4HejSjwOhquH5OGzliVEtg=;
        b=a7lHMeWCVP5y6e03J1nsz/fs3Sg+wXnWgEaLa/Jz4pYz7N33rPiA4WMGKJ8x0XpCpL
         6DASmaVzbxXqDn1W1vEwR6whwndZqika2vOeOgUNkxlA0I1G22vljWRA7kpnAVGahb/K
         QQpUfYigLPhy1uXeZQLMAakFrF3qj3rqWNpYaF3ziYLa6lG1t8FAOq16rjf124bFxaBc
         rw96pjteMUEuLUE/uVhi+QUOXFJNW0NQpjHaJZUL3nR6lcYs3zErk/laYiFHoaa1PFpI
         CpIYwmEwHwQkCR3eAe6b9qVg1+BWqNEirIG/LspxzkVCNbAWvi0eqY7/qY3TrC0lQBiM
         1SYg==
X-Gm-Message-State: AC+VfDzlkRMKNHiFWHjtx8g8or14oLqiqZnrIH1XewjvoOO6J4JpZtXJ
        tOBP/hwKnStlC+1Ft4bJrRqUEp6Rk7pH4qsfK8lCe5K8zpqAhLbyB/Vn1nY05OLi1pR/bCF7qO5
        tidGW3SqB11+4WHXJr8CG4EQVrqnVVQT0odyzC47q
X-Received: by 2002:a05:6a00:1747:b0:63c:e253:a692 with SMTP id j7-20020a056a00174700b0063ce253a692mr2409777pfc.15.1683296200109;
        Fri, 05 May 2023 07:16:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6mtxXj7DMVyAnEBbSIbKGOxmXfWEDkrJMvTzQz3xakLYGwlu3RNE//5PvMJFJvDrwgPGQHOJBcCZUFZi6smSg=
X-Received: by 2002:a05:6a00:1747:b0:63c:e253:a692 with SMTP id
 j7-20020a056a00174700b0063ce253a692mr2409748pfc.15.1683296199774; Fri, 05 May
 2023 07:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v2-0-e7a3c8c15676@tessares.net>
 <CAFqZXNt16B5A2o6fZeN5b1coNCW2m6kp7JToJFDorvPajhFyxA@mail.gmail.com> <11201df515ec41db88ad915fd1e425e62c4f81e5.camel@redhat.com>
In-Reply-To: <11201df515ec41db88ad915fd1e425e62c4f81e5.camel@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 5 May 2023 16:16:28 +0200
Message-ID: <CAFqZXNsR4cTTFbToszUhOPr5pJNET3jJMDFPXB73RD-eqRg5_Q@mail.gmail.com>
Subject: Re: [PATCH LSM v2 0/2] security: SELinux/LSM label with MPTCP and accept
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 6:13=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
> On Thu, 2023-05-04 at 16:14 +0200, Ondrej Mosnacek wrote:
> > On Thu, Apr 20, 2023 at 7:17=E2=80=AFPM Matthieu Baerts
> > <matthieu.baerts@tessares.net> wrote:
> > >
> > > In [1], Ondrej Mosnacek explained they discovered the (userspace-faci=
ng)
> > > sockets returned by accept(2) when using MPTCP always end up with the
> > > label representing the kernel (typically system_u:system_r:kernel_t:s=
0),
> > > while it would make more sense to inherit the context from the parent
> > > socket (the one that is passed to accept(2)). Thanks to the
> > > participation of Paul Moore in the discussions, modifications on MPTC=
P
> > > side have started and the result is available here.
> > >
> > > Paolo Abeni worked hard to refactor the initialisation of the first
> > > subflow of a listen socket. The first subflow allocation is no longer
> > > done at the initialisation of the socket but later, when the connecti=
on
> > > request is received or when requested by the userspace. This was a
> > > prerequisite to proper support of SELinux/LSM labels with MPTCP and
> > > accept. The last batch containing the commit ddb1a072f858 ("mptcp: mo=
ve
> > > first subflow allocation at mpc access time") [2] has been recently
> > > accepted and applied in netdev/net-next repo [3].
> > >
> > > This series of 2 patches is based on top of the lsm/next branch. Desp=
ite
> > > the fact they depend on commits that are in netdev/net-next repo to
> > > support the new feature, they can be applied in lsm/next without
> > > creating conflicts with net-next or causing build issues. These two
> > > patches on top of lsm/next still passes all the MPTCP-specific tests.
> > > The only thing is that the new feature only works properly with the
> > > patches that are on netdev/net-next. The tests with the new labels ha=
ve
> > > been done on top of them.
> > >
> > > Regarding the two patches, the first one introduces a new LSM hook
> > > called from MPTCP side when creating a new subflow socket. This hook
> > > allows the security module to relabel the subflow according to the ow=
ing
> > > process. The second one implements this new hook on the SELinux side.
> > >
> > > Link: https://lore.kernel.org/netdev/CAFqZXNs2LF-OoQBUiiSEyranJUXkPLc=
CfBkMkwFeM6qEwMKCTw@mail.gmail.com/ [1]
> > > Link: https://git.kernel.org/netdev/net-next/c/ddb1a072f858 [2]
> > > Link: https://lore.kernel.org/netdev/20230414-upstream-net-next-20230=
414-mptcp-refactor-first-subflow-init-v1-0-04d177057eb9@tessares.net/ [3]
> > > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > > ---
> > > Changes in v2:
> > > - Address Paul's comments, see the notes on each patch
> > > - Link to v1: https://lore.kernel.org/r/20230419-upstream-lsm-next-20=
230419-mptcp-sublows-user-ctx-v1-0-9d4064cb0075@tessares.net
> > >
> > > ---
> > > Paolo Abeni (2):
> > >       security, lsm: Introduce security_mptcp_add_subflow()
> > >       selinux: Implement mptcp_add_subflow hook
> > >
> > >  include/linux/lsm_hook_defs.h |  1 +
> > >  include/linux/security.h      |  6 ++++++
> > >  net/mptcp/subflow.c           |  6 ++++++
> > >  security/security.c           | 17 +++++++++++++++++
> > >  security/selinux/hooks.c      | 16 ++++++++++++++++
> > >  security/selinux/netlabel.c   |  8 ++++++--
> > >  6 files changed, 52 insertions(+), 2 deletions(-)
> > > ---
> > > base-commit: d82dcd9e21b77d338dc4875f3d4111f0db314a7c
> > > change-id: 20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx=
-eee658fafcba
> > >
> > > Best regards,
> > > --
> > > Matthieu Baerts <matthieu.baerts@tessares.net>
> > >
> >
> > I haven't yet looked closer at the code in this series, but I can at
> > least confirm that with the series (applied on top of net-next) the
> > selinux-testsuite now passes when run under mptcpize, with one caveat:
> >
> > The "client" test prog in the inet_socket subtest sets the SO_SNDTIMEO
> > socket option on the client socket, but the subtest takes
> > significantly longer to complete than when run without mptcpize. That
> > suggests to me that there is possibly some (pre-existing) issue with
> > MPTCP where the send/receive timeouts are not being passed to the
> > subflow socket(s), leading to a longer wait (I guess the default is
> > higher?)
>
> Indeed the behavior you describe is due to some mptcp bug in handling
> the SO_{SND,RCV}TIMEO socket tions, and it's really unrelated to the
> initially reported selinux issue.

Definitely unrelated, just wanted to report the bug :)

> If you could file an issue on our tracker, that would help ;)

I was about to ask where that tracker is, but then it occured to me to
check MAINTAINERS and the link is right there, so yes, will do :)


--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

