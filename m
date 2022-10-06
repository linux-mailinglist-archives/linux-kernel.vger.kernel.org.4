Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16025F6296
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJFI1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJFI1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:27:42 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242CA398
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:27:41 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id a23so1235058pgi.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 01:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=YtNry7EbJtDtEtddA9DqqPAajzIvH2ExTf+f1d2BLeE=;
        b=m3LijaQHN2fYQ2T7ERgZYDL+BgBTB6ceIx6mWj4l3PzhhegxpcZYfw0oJpq7U5aVp+
         ymLFLr4VKrZL1nDWxTEYN9WbYGJanBHvMdoknEBk1NqeBZm0YRTLCq1FzOsG/eN/Ivvc
         Zs1S1r5o12z/ZfBZ2oahpULeypLty4UAhN1eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=YtNry7EbJtDtEtddA9DqqPAajzIvH2ExTf+f1d2BLeE=;
        b=v++NHGNOaDYQAY+PGJE+34ufAC7onVbS2eur5uT6D5IjPuLOa3JB2DilKDokab0Ynz
         l3Dn91qLVgCs6iZ11h8cfSJqafFg0Yllb/SYV139Uht5vsq5Tp9VxEcno78u5rBEFhMw
         5ZPoJIYq0wFQFW+oRdO0W2w7gSPrHD0w73dt1suyY/v/pQworJWJwEEMeD5hPrjlHjMg
         sSNVc7OnH8Tsj9jyBMjyL+xt1kqH5KihM/o7eBmt+tZIiiDe3rEJesGnpDmuWmaJwoIz
         +2iHCEwPb1YSl42C2tT54O+rSVfTqggPx7juP/HLXDiGAFSYFMZ51WHKL+74qj31n61d
         MvCw==
X-Gm-Message-State: ACrzQf2nWkNf/kJohboYaeTFgl/pTC/B5T3C0WKOEbuQteQKKu5PfgsE
        El5952DvZuiC7A9CSCXE8frK2A==
X-Google-Smtp-Source: AMsMyM4q9XFSyeeW5dDI6ls3ylAYRaVXWsGFe+w0sCZM05fMKSjTImuW/1lBuGiaytgnMKa0rdlF2w==
X-Received: by 2002:a63:6581:0:b0:434:9482:c243 with SMTP id z123-20020a636581000000b004349482c243mr3499412pgb.448.1665044860443;
        Thu, 06 Oct 2022 01:27:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902da8400b0017eb2d62bbesm6014743plx.99.2022.10.06.01.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 01:27:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jorge Merlino <jorge.merlino@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Todd Kjos <tkjos@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Prashanth Prahlad <pprahlad@redhat.com>,
        Micah Morton <mortonm@chromium.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] fs/exec: Explicitly unshare fs_struct on exec
Date:   Thu,  6 Oct 2022 01:27:33 -0700
Message-Id: <20221006082735.1321612-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; h=from:subject; bh=8JXgAWBrUCWySpKU2akeepLoIo1ngoevmTcyBBHjAt0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjPpF3qES4cYgipY9Yg66d58hnI1s34HzpasPEsrcs AdJZe+KJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYz6RdwAKCRCJcvTf3G3AJvuPD/ sEFuqb2jJFVbuCOokYGoNQsjw0c9Jmc0XwKWYipIHX1SMMd2WkotpH8FIpOwZ4FyBWjaC7R1DvZeLq wpDvCMawMGqka4y/+7g515eraCONHoJNn0oj2fukbMyqECfinzpw5/d4oLtWkFvyiE4HCoYP/6kmKK 0R8NWKCoSDvGWq7Usrp1Ra1BUXvG1UZHbw7j4g9ItLOqgALdmExlSixoeozIYoogVyhKH0WKOVKYth 6CRkWQcZ/xYBwGsWX7qmIQbUWoTiCbt1fTDMB4IZf5Cn6zrxQL7XNaEUK5j1dcf9ZKTqux5G32e7Of 81YIltR3K2wnhH4qLNhRec5guNWZ3ILs2c6YZDh2TFkb9rGX4cajkAKcAV/vMrP3Kjr9vZKHBdRtPd rsnr6zOL9FYSWR+4i8yhrgvEsVDvenhdlfscGxtpeM7wExsxxiICpUQTRZxDvkLJhahLlKMWnxHm1y N2eVoeyvRe9j7JMCjfOqfKyKLHBZfoqFWmfSVi88JV/Gr797J1kRDlGaszfz7SxKiINHJQK1POiTOc Eic3WPt1/rLSOcANGevkuLKRQkzZ0waIkzKR/ddRrxXv/kszRk/EvoQpjPnt81zaCBe+7jXDXKm4N3 wH+iXTk/Lc17bTuykzisNHzRgsTueD8b0Epfk0nQ+rUUKSa20mimgCQla6rA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These changes seek to address an issue reported[1] by Jorge Merlino where
high-thread-count processes would sometimes fail to setuid during a
setuid execve().

It looks to me like the solution is to explicitly do an unshare_fs(),
which should almost always be a no-op. Current testing seems to indicate
that only the swapper->init exec triggers this condition (and I'm unclear
on whether that's expected or undesirable). This has only received very
light testing so far, but I wanted to share it so other folks could look
it over.

Jorge, can you test with these patches? Your PoC triggered immediately
for me on an unpatched kernel, and did not trigger on a patched one.

I added this patch on top of the series to see if the code ever fired:

diff --git a/kernel/fork.c b/kernel/fork.c
index 53b7248f7a4b..3c197d9d8daa 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3113,6 +3113,7 @@ int unshare_fs(void)
 	if (error || !new_fs)
 		return error;
 
+	pr_notice("UNSHARE of \"%s\" [%d]\n", current->comm, current->pid);
 	unshare_fs_finalize(&new_fs);
 
 	if (new_fs)

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20220910211215.140270-1-jorge.merlino@canonical.com/

Kees Cook (2):
  fs/exec: Explicitly unshare fs_struct on exec
  exec: Remove LSM_UNSAFE_SHARE

 fs/exec.c                  | 26 ++++------------
 fs/fs_struct.c             |  1 -
 include/linux/fdtable.h    |  1 +
 include/linux/fs_struct.h  |  1 -
 include/linux/security.h   |  5 ++-
 kernel/fork.c              | 62 ++++++++++++++++++++++++++------------
 security/apparmor/domain.c |  5 ---
 security/selinux/hooks.c   | 10 ------
 8 files changed, 51 insertions(+), 60 deletions(-)

-- 
2.34.1

