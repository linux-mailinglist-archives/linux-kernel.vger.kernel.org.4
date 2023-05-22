Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5032B70BFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjEVNZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjEVNY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:24:56 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288E5CF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:24:54 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DC4B13F4B8
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684761889;
        bh=jBwY3Jev0F1roDoq+3KM8EdpdjL5E3/34qCkhdloqzQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=WBrqyo2cFrD3c5+Gc1WcuidljsECDrCRoYPxiLy+GThvmptEj7oW4sYs2fWws0iN7
         g70L3UwzK4s/0UPNffMuE1HJ2A+0cqGtC50akzDbzasnK7F8gPY+30Y+5KWhNJC4F5
         CFHC7e0qFuX0oAyPJ7r15nxWq2ZB1iiEkdSoSEVJqJ4Pa4nldfWIAGWcar9aRdlYx9
         ze2jWrgArGAxYBbZA535alD6qsgdImlJjtIJ3gqqilYRNMgZsOVQLZMc/6IMu78E81
         YNuunYtYF63iIQb0TbEm/Fak12UK73XmqeduhoSu+7ey0bCRPVmGYE6p3HmvdrpdUB
         B4sJZvICetsHg==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-510d8e4416cso6422862a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684761889; x=1687353889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBwY3Jev0F1roDoq+3KM8EdpdjL5E3/34qCkhdloqzQ=;
        b=PmEKF9HmHtg0SymyN8oFKIGVQEf0iGuVAKRoSul5StZg0f9dBIKyH8lDbGW0jxBDam
         TEG8C7eucWgZBWX2jLAJxuSOkLzgMJLkVaCw/Xp+GVHzC8LcSQ/5C4y1B6TG/MfFyPTx
         dwS5B3Tw6Zxhh/9GS4/W+DgJOnFuOO0WEZHxgH7htketl0++1OebzCNi6IazGFbpkm/2
         lA7cXB490yLhII+OZ+2VEKk0i+Rig5QV/Q2ij9uIAp4R9EsDT3nC0U1I7XERM8kWRchr
         zBiYjQN5UKwXm4pLaQ1dfs5fC5pmLxw+Ro6pKyLSv7MPYtJ1+zXsExwnwiz6BuQ1ocVc
         KGFg==
X-Gm-Message-State: AC+VfDybBeDbni3BQDry4Son62fVT2JhScg/66Ssz01BlsWom0JoNp52
        inXOxfHSD5N/47xR59tPW1oTySxJmEnBGUADscqcTIVb79pEzCRdG2lOJKXVTF899AIwl9IcjH8
        J3zkRKlQdonpMw5Shf3N9cHZUgP4lRldXTbmYaWKgaA==
X-Received: by 2002:a17:907:84b:b0:957:12a6:a00f with SMTP id ww11-20020a170907084b00b0095712a6a00fmr9626836ejb.21.1684761889562;
        Mon, 22 May 2023 06:24:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4UU9Qz7NO/E8nQ+/USrJfWRBGE1QmN+xfvw0Mp1O4Tf7zK0AZ2wrAVSblPMslQI7MRsNuaAQ==
X-Received: by 2002:a17:907:84b:b0:957:12a6:a00f with SMTP id ww11-20020a170907084b00b0095712a6a00fmr9626810ejb.21.1684761889171;
        Mon, 22 May 2023 06:24:49 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-074-206-207.088.074.pools.vodafone-ip.de. [88.74.206.207])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709060dd000b0094f698073e0sm3044509eji.123.2023.05.22.06.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 06:24:48 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Luca Boccassi <bluca@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH net-next v6 0/3] Add SCM_PIDFD and SO_PEERPIDFD
Date:   Mon, 22 May 2023 15:24:36 +0200
Message-Id: <20230522132439.634031-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Implement SCM_PIDFD, a new type of CMSG type analogical to SCM_CREDENTIALS,
but it contains pidfd instead of plain pid, which allows programmers not
to care about PID reuse problem.

2. Add SO_PEERPIDFD which allows to get pidfd of peer socket holder pidfd.
This thing is direct analog of SO_PEERCRED which allows to get plain PID.

3. Add SCM_PIDFD / SO_PEERPIDFD kselftest

Idea comes from UAPI kernel group:
https://uapi-group.org/kernel-features/

Big thanks to Christian Brauner and Lennart Poettering for productive
discussions about this and Luca Boccassi for testing and reviewing this.

=== Motivation behind this patchset

Eric Dumazet raised a question:
> It seems that we already can use pidfd_open() (since linux-5.3), and
> pass the resulting fd in af_unix SCM_RIGHTS message ?

Yes, it's possible, but it means that from the receiver side we need
to trust the sent pidfd (in SCM_RIGHTS),
or always use combination of SCM_RIGHTS+SCM_CREDENTIALS, then we can
extract pidfd from SCM_RIGHTS,
then acquire plain pid from pidfd and after compare it with the pid
from SCM_CREDENTIALS.

A few comments from other folks regarding this.

Christian Brauner wrote:

>Let me try and provide some of the missing background.

>There are a range of use-cases where we would like to authenticate a
>client through sockets without being susceptible to PID recycling
>attacks. Currently, we can't do this as the race isn't fully fixable.
>We can only apply mitigations.

>What this patchset will allows us to do is to get a pidfd without the
>client having to send us an fd explicitly via SCM_RIGHTS. As that's
>already possibly as you correctly point out.

>But for protocols like polkit this is quite important. Every message is
>standalone and we would need to force a complete protocol change where
>we would need to require that every client allocate and send a pidfd via
>SCM_RIGHTS. That would also mean patching through all polkit users.

>For something like systemd-journald where we provide logging facilities
>and want to add metadata to the log we would also immensely benefit from
>being able to get a receiver-side controlled pidfd.

>With the message type we envisioned we don't need to change the sender
>at all and can be safe against pid recycling.

>Link: https://gitlab.freedesktop.org/polkit/polkit/-/merge_requests/154
>Link: https://uapi-group.org/kernel-features

Lennart Poettering wrote:

>So yes, this is of course possible, but it would mean the pidfd would
>have to be transported as part of the user protocol, explicitly sent
>by the sender. (Moreover, the receiver after receiving the pidfd would
>then still have to somehow be able to prove that the pidfd it just
>received actually refers to the peer's process and not some random
>process. – this part is actually solvable in userspace, but ugly)

>The big thing is simply that we want that the pidfd is associated
>*implicity* with each AF_UNIX connection, not explicitly. A lot of
>userspace already relies on this, both in the authentication area
>(polkit) as well as in the logging area (systemd-journald). Right now
>using the PID field from SO_PEERCREDS/SCM_CREDENTIALS is racy though
>and very hard to get right. Making this available as pidfd too, would
>solve this raciness, without otherwise changing semantics of it all:
>receivers can still enable the creds stuff as they wish, and the data
>is then implicitly appended to the connections/datagrams the sender
>initiates.

>Or to turn this around: things like polkit are typically used to
>authenticate arbitrary dbus methods calls: some service implements a
>dbus method call, and when an unprivileged client then issues that
>call, it will take the client's info, go to polkit and ask it if this
>is ok. If we wanted to send the pidfd as part of the protocol we
>basically would have to extend every single method call to contain the
>client's pidfd along with it as an additional argument, which would be
>a massive undertaking: it would change the prototypes of basically
>*all* methods a service defines… And that's just ugly.

>Note that Alex' patch set doesn't expose anything that wasn't exposed
>before, or attach, propagate what wasn't before. All it does, is make
>the field already available anyway (the struct ucred .pid field)
>available also in a better way (as a pidfd), to solve a variety of
>races, with no effect on the protocol actually spoken within the
>AF_UNIX transport. It's a seamless improvement of the status quo.

===

Git tree:
https://github.com/mihalicyn/linux/tree/scm_pidfd

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Stanislav Fomichev <sdf@google.com>

Tested-by: Luca Boccassi <bluca@debian.org>

Alexander Mikhalitsyn (3):
  scm: add SO_PASSPIDFD and SCM_PIDFD
  net: core: add getsockopt SO_PEERPIDFD
  selftests: net: add SCM_PIDFD / SO_PEERPIDFD test

 arch/alpha/include/uapi/asm/socket.h          |   3 +
 arch/mips/include/uapi/asm/socket.h           |   3 +
 arch/parisc/include/uapi/asm/socket.h         |   3 +
 arch/sparc/include/uapi/asm/socket.h          |   3 +
 include/linux/net.h                           |   1 +
 include/linux/socket.h                        |   1 +
 include/net/scm.h                             |  43 +-
 include/uapi/asm-generic/socket.h             |   3 +
 net/core/sock.c                               |  48 ++
 net/mptcp/sockopt.c                           |   3 +
 net/unix/af_unix.c                            |  34 +-
 tools/include/uapi/asm-generic/socket.h       |   3 +
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/af_unix/Makefile  |   3 +-
 .../testing/selftests/net/af_unix/scm_pidfd.c | 430 ++++++++++++++++++
 15 files changed, 574 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_pidfd.c

-- 
2.34.1

