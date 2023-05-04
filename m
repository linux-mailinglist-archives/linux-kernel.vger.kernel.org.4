Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573626F6D8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjEDOPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjEDOPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C898687
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683209687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4cdyKkEPxoDEMVbGTjlqEi5Ug+DxEbcQNE++nqieDU=;
        b=ehhpIIFUSuUXUykPdsw3tQStWuTyTwNdXSWpvpZ/D1PviBdVEZ5BM7yoysDTQzuBPkO/5B
        qTr5+U7wqwgC+bwyS7Cb+hIC8pfqKK7mxbN0C2MwW+0e0A6kI+E+WumZOenkFNIs/gO8Kb
        hbU78N4X1wjmqJuGGj1EtEV9mKtT/oA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-GDyL9pXOPW-ETGUqIVUSUQ-1; Thu, 04 May 2023 10:14:44 -0400
X-MC-Unique: GDyL9pXOPW-ETGUqIVUSUQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-63b6527a539so344370b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 07:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683209683; x=1685801683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4cdyKkEPxoDEMVbGTjlqEi5Ug+DxEbcQNE++nqieDU=;
        b=dKYrGV2QGFSxtI+UFXIKBdgSKDXsjqEo/5vhABY5hiAY/5n9obaiwWQ+OOb+l9jK89
         VxFTgCMrovXImebmvSThXCYaIFuag6cK+xrrEIjd8S5LBL7j87+VSojrCFOR7+2HvHlo
         Gg4fOG8JsHz3k/Ccr4n7ezyOKc9KRzyUHtqMztlyotXQoQFGL3SMf5dmFZOc/FPlNpYb
         zkHd9HIszVTNX9rmKJusFhCSqWr8uDD6+p6DmvFim7nBzcQ7GdG83RsI17NmXFXwMwx2
         TbB45TVEVF1UesHXNt5brV4HASM7qdHvGlkPEnmnsiYBNwQW83wniAVH1XwmJmRbJv8E
         +yGg==
X-Gm-Message-State: AC+VfDwzAEUw1IIx47r9N6lkSXCjVN913Wqeo55rq/bayybb4eztYAmw
        gNR6WeoqI8ozpTlchgH/bZKOQevplW3moSLQZgcgYVgH5dAp5kq4fNoh6lg0pp4tyzhUPTQ21E+
        xG4OW4/gfhrdHxhG42f1TFzua8xEoRwZLsDNeBOpR
X-Received: by 2002:a05:6a00:248b:b0:643:6fa2:9bef with SMTP id c11-20020a056a00248b00b006436fa29befmr2894113pfv.20.1683209683104;
        Thu, 04 May 2023 07:14:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4y7cBClrLOAGdXVFtpclUAEu+7WeDA4VqonOPsm46O5gkdhb1DHoEQcktMPokcUbxSTVmQhEARopB669XN6Qg=
X-Received: by 2002:a05:6a00:248b:b0:643:6fa2:9bef with SMTP id
 c11-20020a056a00248b00b006436fa29befmr2894069pfv.20.1683209682774; Thu, 04
 May 2023 07:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v2-0-e7a3c8c15676@tessares.net>
In-Reply-To: <20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v2-0-e7a3c8c15676@tessares.net>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 4 May 2023 16:14:31 +0200
Message-ID: <CAFqZXNt16B5A2o6fZeN5b1coNCW2m6kp7JToJFDorvPajhFyxA@mail.gmail.com>
Subject: Re: [PATCH LSM v2 0/2] security: SELinux/LSM label with MPTCP and accept
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Paolo Abeni <pabeni@redhat.com>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 7:17=E2=80=AFPM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> In [1], Ondrej Mosnacek explained they discovered the (userspace-facing)
> sockets returned by accept(2) when using MPTCP always end up with the
> label representing the kernel (typically system_u:system_r:kernel_t:s0),
> while it would make more sense to inherit the context from the parent
> socket (the one that is passed to accept(2)). Thanks to the
> participation of Paul Moore in the discussions, modifications on MPTCP
> side have started and the result is available here.
>
> Paolo Abeni worked hard to refactor the initialisation of the first
> subflow of a listen socket. The first subflow allocation is no longer
> done at the initialisation of the socket but later, when the connection
> request is received or when requested by the userspace. This was a
> prerequisite to proper support of SELinux/LSM labels with MPTCP and
> accept. The last batch containing the commit ddb1a072f858 ("mptcp: move
> first subflow allocation at mpc access time") [2] has been recently
> accepted and applied in netdev/net-next repo [3].
>
> This series of 2 patches is based on top of the lsm/next branch. Despite
> the fact they depend on commits that are in netdev/net-next repo to
> support the new feature, they can be applied in lsm/next without
> creating conflicts with net-next or causing build issues. These two
> patches on top of lsm/next still passes all the MPTCP-specific tests.
> The only thing is that the new feature only works properly with the
> patches that are on netdev/net-next. The tests with the new labels have
> been done on top of them.
>
> Regarding the two patches, the first one introduces a new LSM hook
> called from MPTCP side when creating a new subflow socket. This hook
> allows the security module to relabel the subflow according to the owing
> process. The second one implements this new hook on the SELinux side.
>
> Link: https://lore.kernel.org/netdev/CAFqZXNs2LF-OoQBUiiSEyranJUXkPLcCfBk=
MkwFeM6qEwMKCTw@mail.gmail.com/ [1]
> Link: https://git.kernel.org/netdev/net-next/c/ddb1a072f858 [2]
> Link: https://lore.kernel.org/netdev/20230414-upstream-net-next-20230414-=
mptcp-refactor-first-subflow-init-v1-0-04d177057eb9@tessares.net/ [3]
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Changes in v2:
> - Address Paul's comments, see the notes on each patch
> - Link to v1: https://lore.kernel.org/r/20230419-upstream-lsm-next-202304=
19-mptcp-sublows-user-ctx-v1-0-9d4064cb0075@tessares.net
>
> ---
> Paolo Abeni (2):
>       security, lsm: Introduce security_mptcp_add_subflow()
>       selinux: Implement mptcp_add_subflow hook
>
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  net/mptcp/subflow.c           |  6 ++++++
>  security/security.c           | 17 +++++++++++++++++
>  security/selinux/hooks.c      | 16 ++++++++++++++++
>  security/selinux/netlabel.c   |  8 ++++++--
>  6 files changed, 52 insertions(+), 2 deletions(-)
> ---
> base-commit: d82dcd9e21b77d338dc4875f3d4111f0db314a7c
> change-id: 20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-eee=
658fafcba
>
> Best regards,
> --
> Matthieu Baerts <matthieu.baerts@tessares.net>
>

I haven't yet looked closer at the code in this series, but I can at
least confirm that with the series (applied on top of net-next) the
selinux-testsuite now passes when run under mptcpize, with one caveat:

The "client" test prog in the inet_socket subtest sets the SO_SNDTIMEO
socket option on the client socket, but the subtest takes
significantly longer to complete than when run without mptcpize. That
suggests to me that there is possibly some (pre-existing) issue with
MPTCP where the send/receive timeouts are not being passed to the
subflow socket(s), leading to a longer wait (I guess the default is
higher?) when the timeout is expected to be hit (there are test cases
where we expect packets to be dropped due to SELinux access controls,
which we detect via timeout). I'm only taking a wild guess at the root
cause here, but I hope you guys will be able to figure it out and fix
whatever needs fixing :)

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

