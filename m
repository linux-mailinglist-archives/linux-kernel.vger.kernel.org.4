Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB63717013
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjE3V7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjE3V7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:59:01 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE175C7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:58:59 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-565ba6aee5fso59800577b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685483939; x=1688075939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQoGchsSYLFgDGtKxP1mVS/CZXkXh4qFE/pv/LNSQuo=;
        b=I58pVp5UoG7JekWqlQgu9H7gbDWzorvSFEIR88RHP+5qm8Deb3oL1y8Fl5ODG9agIt
         OMr8/kUENChrpol77H+hXxUqN4cIGnbSfIV5aXmVfEnmKNvLfJI8xD8ld334JjUUg8Ni
         CxJF/6DIA+yE3SRqroGNwNjPhetCB+AmLq9KjrOZEjBzQ0W8zpKV/hnn6TBSYBBtdqzv
         SHJmdjMJznZZp4Pgs2UHQpFK/alP+KIbF44u0EFdK8U32srHi1MzZml8K6IMCFzrgGrU
         ehzSXLkk7KX8xkbnWOkKEhUrOiRuluFsglwCXrFm8xTUeIYtLgc2YprnJU24apRzQn/5
         /FJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685483939; x=1688075939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQoGchsSYLFgDGtKxP1mVS/CZXkXh4qFE/pv/LNSQuo=;
        b=HrpZuBddJUkOS5bA4mE8WHl+KOLAvuSROM2vLwyAGI0WiUFvvnDRGii+7ERbZ6GMuJ
         VufnB2M9WC99M460NXERu5b/zPfl23jDklqBeMbVqBdVneDKAdCjK9rsrpMqWeMV/pV2
         1umzzu13g8UGu3kGebACIZzJ2mLzkfwa8C9qLkul36gvubEE+HsxZXgfgeo9XgedPdIO
         kSUF2VAo1vRSc6n1lPzoXySc2+hY5AH5WhNXsGe/WJn0z648QiE6K1eURCkhRTawceDI
         LL+0Hqlk776VB6GYtkrY/2R+6yznhs+MmJr65O58jaOawB6BiezpZijCeBNuuh7Ll4Kf
         1/SA==
X-Gm-Message-State: AC+VfDwsf+0TYdLCRsZUEk+TeA6FBJdRZIlKeSWLneIT0e4put42geSz
        p6f8Bgcsgk1xJjc1X7O/Ren0q7txR0CuUh370DsL
X-Google-Smtp-Source: ACHHUZ5Rr4U8IiQqr1FQQUIU42pfTWPDmHu8puY69Kll0+NCN2xgzBGgAkp4/xkEiMk3hsrQPlRJxUHkAyap/0f9ZB8=
X-Received: by 2002:a0d:db92:0:b0:559:e180:2197 with SMTP id
 d140-20020a0ddb92000000b00559e1802197mr4160911ywe.21.1685483938843; Tue, 30
 May 2023 14:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <168547265011.24337.4306067683997517082-0@git.sr.ht>
In-Reply-To: <168547265011.24337.4306067683997517082-0@git.sr.ht>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 May 2023 17:58:48 -0400
Message-ID: <CAHC9VhQhBBPyZE24LM6KvYrET2huW-W_YYsyPndpNkn70Mu3Ug@mail.gmail.com>
Subject: Re: [PATCH linux 0/3] [PATCH] userns: add sysctl "kernel.userns_group_range"
To:     "~akihirosuda" <suda.kyoto@gmail.com>
Cc:     linux-kernel@vger.kernel.org, containers@lists.linux.dev,
        serge@hallyn.com, brauner@kernel.org, ebiederm@xmission.com,
        akihiro.suda.cz@hco.ntt.co.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 2:50=E2=80=AFPM ~akihirosuda <akihirosuda@git.sr.ht=
> wrote:
>
> This sysctl limits groups who can create a new userns without
> CAP_SYS_ADMIN in the current userns, so as to mitigate potential kernel
> vulnerabilities around userns.
>
> The sysctl value format is same as "net.ipv4.ping_group_range".
>
> To disable creating new unprivileged userns, set the sysctl value to "1
> 0" in the initial userns.
>
> To allow everyone to create new userns, set the sysctl value to "0
> 4294967294". This is the default value.
>
> This sysctl replaces "kernel.unprivileged_userns_clone" that is found in
> Ubuntu [1] and Debian GNU/Linux.
>
> Link: https://git.launchpad.net/~ubuntu-
> kernel/ubuntu/+source/linux/+git/jammy/commit?id=3D3422764 [1]

Given the challenges around adding access controls to userns
operations, have you considered using the LSM support that was added
upstream last year?  The relevant LSM hook can be found in commit
7cd4c5c2101c ("security, lsm: Introduce security_create_user_ns()"),
and although only SELinux currently provides an access control
implementation, there is no reason you couldn't add support for your
favorite LSM, or even just a simple BPF LSM to enforce the group
controls as you've described them here.

> Akihiro Suda (3):
>   net/ipv4: split group_range logic to kernel/group_range.c
>   group_range: allow GID from 2147483648 to 4294967294
>   userns: add sysctl "kernel.userns_group_range"
>
>  include/linux/group_range.h    |  18 +++++
>  include/linux/user_namespace.h |   5 ++
>  include/net/netns/ipv4.h       |   9 +--
>  include/net/ping.h             |   6 --
>  kernel/Makefile                |   2 +-
>  kernel/fork.c                  |  24 +++++++
>  kernel/group_range.c           | 123 +++++++++++++++++++++++++++++++++
>  kernel/sysctl.c                |  30 ++++++++
>  kernel/user.c                  |   9 +++
>  net/ipv4/ping.c                |  39 +----------
>  net/ipv4/sysctl_net_ipv4.c     |  56 ++-------------
>  11 files changed, 219 insertions(+), 102 deletions(-)
>  create mode 100644 include/linux/group_range.h
>  create mode 100644 kernel/group_range.c

--=20
paul-moore.com
