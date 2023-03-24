Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DA86C856B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCXSxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjCXSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:53:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A1D46BD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 11:53:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso3278093wmo.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 11:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679683985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7Ag8LgquLb9swcmj3Ap1TkwSEPJR8gJ4XTdooxy75I=;
        b=PwKU/S1uNTKCUjSqu21IRFJ/VHqigiHPAr5kY3c7OTFkCJCp0bV7vDM8wBakkdfhHY
         nLcrQN1BwZV9ikoQQgM+uUkwioAeChdyqmAT3kyV8MCi4AQhxlRkVjAxLrZtcuLiXxU5
         w7lN7Eq9mr4TX0MIWp8tID/xTL200a3UroDP7S9jswmjVo5VaKOuhFe9KVO2p+GxOYGi
         bmoLhmv3T+W9GGFu2TeADSV+L2Lh2pg87td281/ZpL51mkvflb2FK8r0Vg74CrGFOgIR
         X2HwSIMP/6fGFQ6YkHScj+QsWjk8yo8VrgDqzF6RNFNapciEBkLQQNMgW9i4P0HvKzpX
         8oXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679683985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7Ag8LgquLb9swcmj3Ap1TkwSEPJR8gJ4XTdooxy75I=;
        b=0r7pKfoN2sYOr7KILSIcIkb57H9FVhm86XBv4Z82nISzw6T3RJs4oMyisizEC19foD
         ynV0/NidDlusZuCRRQRXtAm2DP0kjP1vnmIBQbll+Wk/X8pkY4acTWNr9MgnvId7wqaU
         clQwkS6redZcLAUZDTitoZ2bJWvZIjkQ+7xTm/t5LZwRu98Z4oRQ+xvWd3Sh4zB6sXyR
         sBtEU8QIgYBpAD9pQaOM4rohkLZ/3wZ8bQ/x0GEbXeF/MDt03n0+YBWWT5+Q9nyQqiMH
         DmZH8goR2K/AmSCal3LnKQyLA0GbgKTllfJFn/7DDYI4Tj8MiiLBz5EsTay7xycefNgT
         mblg==
X-Gm-Message-State: AO0yUKW4sTeU2cKibsshjZQArOZGs0J+N+dK7kbpHyIr6U0w1Wk25y3X
        ly118vJET0FopMRttq3csdIgpuQvzz7ECX9L9GnxOw==
X-Google-Smtp-Source: AK7set+U2gRhd/99ko6nuuESFMgm1EeQlB2yaCuPd56hmfxtJgnK+LbD6isEP5l21e3IBei2H/32zQ==
X-Received: by 2002:a7b:c7ce:0:b0:3ed:8360:e54 with SMTP id z14-20020a7bc7ce000000b003ed83600e54mr3375807wmk.8.1679683984686;
        Fri, 24 Mar 2023 11:53:04 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002cfe685bfd6sm18948878wrw.108.2023.03.24.11.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 11:53:04 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri, 24 Mar 2023 19:52:46 +0100
Subject: [PATCH v2 1/2] docs: process: allow Closes tags with links
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-doc-checkpatch-closes-tag-v2-1-f4a417861f6d@tessares.net>
References: <20230314-doc-checkpatch-closes-tag-v2-0-f4a417861f6d@tessares.net>
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v2-0-f4a417861f6d@tessares.net>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?utf-8?q?Kai_Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5855;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=edGpQ0BeCcJTi2TLPbtt2wWdKMXaJ2uJbxsWrRXW6Do=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkHfGOMTwGxkWFrQtYk1IL/cTzIxE11Fo4TXAr8
 mmYZOR5/IeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZB3xjgAKCRD2t4JPQmmg
 cyoYD/9/vZcwEMNvsfiwM7wxqJ7TEjA+ysHRvXlpNugJ7fTbWHXaJP4Nb/nOtoG3XNw79G3hmQf
 BmlDsVRc3h0fETZkWBE8LXY1xb4rDrIgGGYJYD+jQa9N+E49VE5bjL1QnN0HS01pMVjNQcfqJip
 tpTpseCy0/RUJjUBYGkkz1y2WI9n2xlwkQ3flnBnh1uZOL0HDf+/8ptWCU7LW2QYcBuUbjVujjM
 NFRdDHH/yMHGn+nUB/us1lfBf5DWcQpu15GOVBRVMq6gJZPUFmkuY1inQ6H14I+TIFg+O6kPMAx
 5faNij8KE1IQdXBQaVm/WBgMqkIQVhEhM6EcOSVuXjfMVzFytXZzvcm7Vm6FwFbs772vGYQ83Oa
 vBfqmcWXV75ajglQzDI77TlNdh3TucK1kpBj6p4E46koBy7cRkodQakNcpQMvoT+YWigXogQ1aI
 y5xLV7QKenuRz7+6DqLvQN3Zblu/J7/dqWQataUADZgIAy2Xdw3rdQu57uU54JxwJ15QbZpQAeq
 aW8N0GamzpyNd4Kt3uAUpr5mXLWA4GbTp6kdpfb182HJy4cdAebOKIQhUrIowaKI3Ku2NsGFsgh
 QJGrtmpdXo9ydAC35IzKFu3Bz/O3PHa21LdivKrSKY/ItAIGuz/88h5cBCo7rju371KoxOPH3a4
 icfzJL9EwQ08tNw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making sure a bug tracker is up to date is not an easy task. For
example, a first version of a patch fixing a tracked issue can be sent a
long time after having created the issue. But also, it can take some
time to have this patch accepted upstream in its final form. When it is
done, someone -- probably not the person who accepted the patch -- has
to remember about closing the corresponding issue.

This task of closing and tracking the patch can be done automatically by
bug trackers like GitLab [1], GitHub [2] and hopefully soon [3]
bugzilla.kernel.org when the appropriated tag is used. The two first
ones accept multiple tags but it is probably better to pick one.

According to commit 76f381bb77a0 ("checkpatch: warn when unknown tags are used for links"),
the "Closes" tag seems to have been used in the past by a few people and
it is supported by popular bug trackers. Here is how it has been used in
the past:

 $ git log --no-merges --format=email -P --grep='^Closes: http' | \
       grep '^Closes: http' | cut -d/ -f3-5 | sort | uniq -c | sort -rn
    391 gitlab.freedesktop.org/drm/intel
     79 github.com/multipath-tcp/mptcp_net-next
      8 gitlab.freedesktop.org/drm/msm
      3 gitlab.freedesktop.org/drm/amd
      2 gitlab.freedesktop.org/mesa/mesa
      1 patchwork.freedesktop.org/series/73320
      1 gitlab.freedesktop.org/lima/linux
      1 gitlab.freedesktop.org/drm/nouveau
      1 github.com/ClangBuiltLinux/linux
      1 bugzilla.netfilter.org/show_bug.cgi?id=1579
      1 bugzilla.netfilter.org/show_bug.cgi?id=1543
      1 bugzilla.netfilter.org/show_bug.cgi?id=1436
      1 bugzilla.netfilter.org/show_bug.cgi?id=1427
      1 bugs.debian.org/625804

Likely here, the "Closes" tag was only properly used with GitLab and
GitHub. We can also see that it has been used quite a few times (and
still used recently) and this is then not a "random tag that makes no
sense" like it was the case with "BugLink" recently [4]. It has also
been misused but that was a long time ago, when it was common to use
many different random tags.

checkpatch.pl script should then stop complaining about this "Closes"
tag. As suggested by Thorsten [5], if this tag is accepted, it should
first be described in the documentation. This is what is done here in
this patch.

Note that thanks to this "Closes" tag, the mentioned bug trackers can
also locate where a patch has been applied in different branches and
repositories. If only the "Link" tag is used, the tracking can also be
done but the ticket will not be closed and a manual operation will be
needed. Also, these bug trackers have some safeguards: the closure is
only done if a commit having the "Closes:" tag is applied in a specific
branch. It will then not be closed if a random commit having the same
tag is published elsewhere. Also in case of closure, a notification is
sent to the owners.

Link: https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#default-closing-pattern [1]
Link: https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/using-keywords-in-issues-and-pull-requests [2]
Link: https://lore.kernel.org/linux-doc/20230315181205.f3av7h6owqzzw64p@meerkat.local/ [3]
Link: https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/ [4]
Link: https://lore.kernel.org/all/688cd6cb-90ab-6834-a6f5-97080e39ca8e@leemhuis.info/ [5]
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/373
Suggested-by: Thorsten Leemhuis <linux@leemhuis.info>
Acked-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 Documentation/process/5.Posting.rst          | 9 +++++++++
 Documentation/process/submitting-patches.rst | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index 7a670a075ab6..20f0b6b639b7 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -217,6 +217,15 @@ latest public review posting of the patch; often this is automatically done
 by tools like b4 or a git hook like the one described in
 'Documentation/maintainer/configure-git.rst'.
 
+Similarly, there is also the "Closes:" tag that can be used to close issues
+when the underlying public bug tracker can do this operation automatically.
+For example::
+
+	Closes: https://example.com/issues/1234
+
+Private bug trackers and invalid URLs are forbidden. For other public bug
+trackers not supporting automations, keep using the "Link:" tag instead.
+
 A third kind of tag is used to document who was involved in the development of
 the patch. Each of these uses this format::
 
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 69ce64e03c70..759c99e34085 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -134,6 +134,15 @@ resources. In addition to giving a URL to a mailing list archive or bug,
 summarize the relevant points of the discussion that led to the
 patch as submitted.
 
+It might be interesting to use the 'Closes:' tag to close issues when the
+underlying public bug tracker can do this operation automatically. For
+example::
+
+	Closes: https://example.com/issues/1234
+
+Private bug trackers and invalid URLs are forbidden. For other public bug
+trackers not supporting automations, keep using the "Link:" tag instead.
+
 If your patch fixes a bug in a specific commit, e.g. you found an issue using
 ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
 the SHA-1 ID, and the one line summary.  Do not split the tag across multiple

-- 
2.39.2

