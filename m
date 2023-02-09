Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFB96902C7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBIJDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBIJDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:03:16 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9E8B45C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:03:15 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id y19so1281245ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 01:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Rw0L6Va6diQDvp094MQJTGkE+0LV3C/TK0OJjT1s08=;
        b=h8wuMLA+MgLBAFKKFyrMiipifqF72xDDMTTBAu4XPm1LhFYiMLXckwf65BYJO5YMQO
         cTAS20GKfPwLaDriDAZshCpSyjENwAQHEvGTQJATKbWVLeuwrkJ1/yYUG5/K186lp5wj
         yr9OODIC8D6MJ3pIZT22PJXZnn+vz4UT/RIIMiAtL0k0bmUtHQ+LCO2V8dC8vceAJx0a
         4WAvr9cw1koBKlq0H/8IuCyO8+q6UdlWJIMErFV645sg/8wTU4PvlJpBkOzeSKjWHPmp
         1HYYOnn17ONab/c0W/ltDjDywvtMhNSJZg3QZLh41ZdSKIc2on3+uQBfGcELn6jYNW/t
         /uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Rw0L6Va6diQDvp094MQJTGkE+0LV3C/TK0OJjT1s08=;
        b=Rzbo750Sqw63txox6JkVPPPGg3LLn6au1mAZU/+KeKazmAQIYwmZ1sgIB10xNZNjuc
         FHa3aSv5yPaR2D2fZ0iqX9MvtGVDFHt5HDRJrsAJkteEm95AP9cRa3A74GSAQ5d5DJ9j
         iqX3zDvbfUrt39XtxP4r+/MJi6Xw0X5vafbaou4RWKFGcFxmkpbmd5PC/ZxIeMIYIEo4
         jNa6ZRsFBkP1mUjqaE2xtH+XD3w0FxK4F3nB5zjCYMM5VrsuDVyjnwMHsfiGEeNLuJBJ
         qVs6rYII6l8vpGPqmSJX0hzB+lEudgptUbirPGPmQEkqISanzKsYksZ/kVHrn1Nwqemz
         EFgA==
X-Gm-Message-State: AO0yUKVyNvFbalFPN4mX3biCBr/6HlQ5o+SQVQwhkaSqZbBTpd8JziYX
        /+kQ6gmayErVtJtFirdZTtlg4Aew79ZnRGVt8hCQ5Q==
X-Google-Smtp-Source: AK7set+ZS2F4AKPqgewxK5a53tJil2dGzck8CgFQydNgnyawPi6bcGrUs+oMs1Wk/CvLV7mm9XG6qir+uMAqWgngs28=
X-Received: by 2002:a2e:91cb:0:b0:293:30ed:25d1 with SMTP id
 u11-20020a2e91cb000000b0029330ed25d1mr216508ljg.15.1675933393549; Thu, 09 Feb
 2023 01:03:13 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f2b07b05d5dc87cc@google.com> <0000000000003deeef05f43f8d47@google.com>
In-Reply-To: <0000000000003deeef05f43f8d47@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Feb 2023 10:03:00 +0100
Message-ID: <CACT4Y+YPy1Cf2hDHBXuGjX8QAnESEEN+iGHgeZ8mQiueY5JQ9Q@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
To:     syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, linux-cachefs-bounces@redhat.com,
        linux-cachefs-owner@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, mudongliangabcd@gmail.com,
        nogikh@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 at 08:44, syzbot
<syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com> wrote:
>
> This bug is marked as fixed by commit:
> fscache: fix GPF in fscache_free_cookie
>
> But I can't find it in the tested trees[1] for more than 90 days.
> Is it a correct commit? Please update it by replying:
>
> #syz fix: exact-commit-title

Let's remove this fixing commit, it apparently does not exist.

#syz unfix



> Until then the bug is still considered open and new crashes with
> the same signature are ignored.
>
> Kernel: Linux
> Dashboard link: https://syzkaller.appspot.com/bug?extid=5b129e8586277719bab3
>
> ---
> [1] I expect the commit to be present in:
>
> 1. for-kernelci branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
>
> 2. master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
>
> 3. master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
>
> 4. master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
>
> The full list of 10 trees can be found at
> https://syzkaller.appspot.com/upstream/repos
