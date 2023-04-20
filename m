Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D0C6E9A78
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjDTRRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjDTRRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:17:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6998C30F8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:17:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f17fdb5062so8738915e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682011051; x=1684603051;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QG0pWKhg00K0GoVywBEm4/H503vgg5ftRkPAl0FnNsA=;
        b=u3Uyf15Hur77NzuRmS2Ijqx7/Cgx4Yk5NzfYwVpZZ7tGCTbDq3FIaSG8c+JfeOmnMq
         vHEW1pr6zfECX2PQPbFCnzkyI1285fq1dJL56xSpAEkMKw8eHx0KIevu37Rr855huRAc
         ttHqSi2bFfRizmcKqzoTocrMZ52fWtR+XHB/oDwNO26ozwpQHVeZdnHQr870ygb3HrAm
         QLUR20qWgnIl/OUic1XUFU1K9AmDEtC/fot5KjJOwyxDTtyOeEd6QOXCSYKjua2TB3T5
         9DW33MKOMDMTbX/9mw8SulW6IDk1S8HDS5f1NKA/U6QjCHcX2rFAr318ks+FGFO52RUQ
         TS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011051; x=1684603051;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QG0pWKhg00K0GoVywBEm4/H503vgg5ftRkPAl0FnNsA=;
        b=W/C9ohtxZ+McSy3EiuVEwpyHWkmYRP+TJjCsmZbJncheJoK1GB96xn9QWXc/KMMqTz
         Bm3FerURQhfJVbuQ+FSwQ423jzVPd8iiRH4t0r+R0cPW+kVUkpMd4hPrthWzLTkWWFSC
         +OyLVfLhjzwFsnN49MIIg3irHCM+02MhdnZlVSNaOysjaFvOpDQR2SAFkTnJLb2ZypSk
         8GzJ0SoD7oetl6oH/omh8Aq4Tq022qW/oIxa0ZuguZHYCLEd3g3Frl6K470eHnIN2g10
         7n2ePgfYfEtMbX8rwq5aXvedxWnmSzraNxpVt1RcIGkrUFp5OVY87H0nC8YBxxG7Vv5F
         NZdA==
X-Gm-Message-State: AAQBX9drWTwI9DQiwxqOwe7B63Cfl9ij2to9+BFJiLVQHkFR2bLHJB8N
        cpKIYcRCAEN6vN0ExR24U0FTTA==
X-Google-Smtp-Source: AKy350bBvWmh1CIYAFolFtcwrJjTAeHbdsZabDeihNWi2nOsM5lK3gNSDkadryhGo2N9EwQbAX8gQw==
X-Received: by 2002:adf:feca:0:b0:2fb:9e73:d5eb with SMTP id q10-20020adffeca000000b002fb9e73d5ebmr1770927wrs.46.1682011050714;
        Thu, 20 Apr 2023 10:17:30 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d6892000000b002f9bfac5baesm2450752wru.47.2023.04.20.10.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 10:17:30 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH LSM v2 0/2] security: SELinux/LSM label with MPTCP and
 accept
Date:   Thu, 20 Apr 2023 19:17:12 +0200
Message-Id: <20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v2-0-e7a3c8c15676@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJhzQWQC/6WOQQ6CMBBFr0Jm7ZiCgOLKA+jKpXHRlkGaQCGdg
 hjD3S0kegGX/7/k5b2ByRliOEZvcDQaNp0NI9lEoGtpH4SmDBsSkexEGhc49OwdyRYbbtHS5PG
 H2t7rHnlQTfdkHIIZtZ+QiPLsUMlKKwnBqyQTKietrhfz17Og3lFlpjXnBufrBe7hrA37zr3Wx
 DFe0R81Y4wCizIVeaqVEPvs5IlZOuKtJQ/3eZ4/l2EKCBUBAAA=
To:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, mptcp@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3103;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=kIXu2fyfQa8O7KLci2YSVLhtJxzQ4pVEKqSM7NOk2MQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkQXOpLKMDt+UdFrUsdSqBbRy5+6vX80VYO1ozd
 SHNYsWkU/SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZEFzqQAKCRD2t4JPQmmg
 c68pD/40GQbAT8dVRVD6xxWsm+mm9xmRCFYRHWANz7GK5+0TbERSxm8e3ClaDvoN/Vv8SxWYAu4
 t4+TtT44BAx7Do30pszv4U/ZFiJT0UFqu7TFsChwxYIUTEX8lYGNHuvHmadBYBbsWSSAPa+NoKB
 7qRUzdxUen0lb1bLSH2dqD6uC9/QhuOxwpleIwILadHX5s+qSMIp5TN013a8RO8ERAiri492tYf
 GHTlBP4p9gsn6gNKeAZuZ93DNILuHgqhOE72NM9F9xRPyolPLskoyegDlBTplD/0VSj2bmgHZDb
 yKe/IaKWhUEa4cy2pIMIG5MYoVxVVaLbavemmM8NMe5ZKqvSXUd+TQNcwwFB9OTCC6R2hn6M2+q
 eCQsbrXKFpEkw5bvMwJY00IP12DBaQ9nHPTq8LThGEY4hepNB0ZLp7JRDnimtWSTxTKBx4yWxkR
 OS7zrYa2nu5uV6gxWh457XFdA8EQS/HEMt0lzRzCp2Cy1wk3Go7frkdSvgpTTkZDeOUNCRKqPU9
 g0q4AkkqhOtCkMtHtW9FRVePvwXQUzWGH+KUVgqg3d0aJesMnAGqGPCORgK+VInJZ2+XCy2eTPH
 UuzkigrBK/fs9uAke9c0VtzsKh/IZLlQGi22JwDaHAFQhnEwffXhtoyeQGU0H8C0gPDViEapTwZ
 tB9rIE3wJEdVkUA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In [1], Ondrej Mosnacek explained they discovered the (userspace-facing)
sockets returned by accept(2) when using MPTCP always end up with the
label representing the kernel (typically system_u:system_r:kernel_t:s0),
while it would make more sense to inherit the context from the parent
socket (the one that is passed to accept(2)). Thanks to the
participation of Paul Moore in the discussions, modifications on MPTCP
side have started and the result is available here.

Paolo Abeni worked hard to refactor the initialisation of the first
subflow of a listen socket. The first subflow allocation is no longer
done at the initialisation of the socket but later, when the connection
request is received or when requested by the userspace. This was a
prerequisite to proper support of SELinux/LSM labels with MPTCP and
accept. The last batch containing the commit ddb1a072f858 ("mptcp: move
first subflow allocation at mpc access time") [2] has been recently
accepted and applied in netdev/net-next repo [3].

This series of 2 patches is based on top of the lsm/next branch. Despite
the fact they depend on commits that are in netdev/net-next repo to
support the new feature, they can be applied in lsm/next without
creating conflicts with net-next or causing build issues. These two
patches on top of lsm/next still passes all the MPTCP-specific tests.
The only thing is that the new feature only works properly with the
patches that are on netdev/net-next. The tests with the new labels have
been done on top of them.

Regarding the two patches, the first one introduces a new LSM hook
called from MPTCP side when creating a new subflow socket. This hook
allows the security module to relabel the subflow according to the owing
process. The second one implements this new hook on the SELinux side.

Link: https://lore.kernel.org/netdev/CAFqZXNs2LF-OoQBUiiSEyranJUXkPLcCfBkMkwFeM6qEwMKCTw@mail.gmail.com/ [1]
Link: https://git.kernel.org/netdev/net-next/c/ddb1a072f858 [2]
Link: https://lore.kernel.org/netdev/20230414-upstream-net-next-20230414-mptcp-refactor-first-subflow-init-v1-0-04d177057eb9@tessares.net/ [3]
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Changes in v2:
- Address Paul's comments, see the notes on each patch
- Link to v1: https://lore.kernel.org/r/20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v1-0-9d4064cb0075@tessares.net

---
Paolo Abeni (2):
      security, lsm: Introduce security_mptcp_add_subflow()
      selinux: Implement mptcp_add_subflow hook

 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 ++++++
 net/mptcp/subflow.c           |  6 ++++++
 security/security.c           | 17 +++++++++++++++++
 security/selinux/hooks.c      | 16 ++++++++++++++++
 security/selinux/netlabel.c   |  8 ++++++--
 6 files changed, 52 insertions(+), 2 deletions(-)
---
base-commit: d82dcd9e21b77d338dc4875f3d4111f0db314a7c
change-id: 20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-eee658fafcba

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

