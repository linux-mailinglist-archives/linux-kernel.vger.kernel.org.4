Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A09E67F2A1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 01:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjA1AHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 19:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjA1AG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 19:06:58 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F98B7A4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:06:40 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso6199152pjp.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8g/ThgcNbD2/aX07jf+/YqhhYrBFTriZoMIQ/MFUbWI=;
        b=eqFtSh1QLj+acU2gwXnpxbAelvLB58DPeB4DQAski2quWDZzuDDp9OPNjo0x7PfRkL
         vxvKQ6AcUSbD9BqrQCnovg4LVVxN2voFYwt2Oom/gUHLAys4N4VdIZLmWuHHo78/oQMe
         wfZu6/kE0w2HGoJ/mmSVAeqxyk0FpRY2SMLAufOLipcWNSTWOMIhOhXBJSJ1eE86T9fY
         DHnBL+Rvox8zzYn+VugXoB2athS7utYT0LgF2MDmBWP6LONR+IjVl0F9Qgy1yteUF8yQ
         IvzDKeY/gy/ED2IvlSgXCYIKkbD1AYwESob6Z4B+xNPd6CgQ2CZtYFyq47G6W4jU+Vyj
         +hnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8g/ThgcNbD2/aX07jf+/YqhhYrBFTriZoMIQ/MFUbWI=;
        b=lK2Z4AA1qETmkIqxgme5/HpTGfmZDNU6+fGXKtcEeKTBZOWXMbpaLY70md7bv0pwfk
         fLEPkKPS2klzDlkMzseVYlwvmBZH3OzEI0N3YGAb9BUPE0uAJu44MyMSQAeP5l5lKtGF
         mkh40JQAHFsrTaREbnbgubzO0cOXF2GRr7oMoZbBGO2reBFakaA7MTIWkXE+XqoACryn
         FWWO7eAY752SMeZ7rM1N3/dtuuh6NoFuYd/PbpyMGIUj4vhlw+7KYzYxI282Oa3C01/m
         YXFiiAUkjCkOimu93NB0yZ6QBWYedRTsr0xnHED0Xr2zPcHzwWOWfMFfIwoVmnFtb7F/
         lEAA==
X-Gm-Message-State: AFqh2ko9nzE73nkE6oL0SyH6daTJrUYDmAlzUkkzRmWEyy1cjs50kP4c
        gRn4QatfrBm1QM9iu7+pgVpxgdFhuijoEbs+RE1N
X-Google-Smtp-Source: AMrXdXvd2n9LymBXSkWurnSC6yLqKTNaVZHkRdO3cpr85aGd59eC4S1pbTeWxWCVZHBbNBrCPS7QoA7JXjF/sJC/xPU=
X-Received: by 2002:a17:90a:5b0c:b0:223:fa07:7bfb with SMTP id
 o12-20020a17090a5b0c00b00223fa077bfbmr5401548pji.38.1674864399412; Fri, 27
 Jan 2023 16:06:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674682056.git.rgb@redhat.com> <f602429ce0f419c2abc3ae5a0e705e1368ac5650.1674682056.git.rgb@redhat.com>
 <CAHC9VhQiy9vP7BdQk+SXG7gQKAqOAqbYtU+c9R0_ym0h4bgG7g@mail.gmail.com> <Y9RX0QhHKfWv3TGL@madcap2.tricolour.ca>
In-Reply-To: <Y9RX0QhHKfWv3TGL@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 27 Jan 2023 19:06:28 -0500
Message-ID: <CAHC9VhSN+XSYGh0TBsCPftNvVNBN1JHugrrsp3gbF-in5S1PoA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] io_uring,audit: do not log IORING_OP_*GETXATTR
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Stefan Roesch <shr@fb.com>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 6:01 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2023-01-27 17:43, Paul Moore wrote:
> > On Fri, Jan 27, 2023 at 12:24 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > Getting XATTRs is not particularly interesting security-wise.
> > >
> > > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > > Fixes: a56834e0fafe ("io_uring: add fgetxattr and getxattr support")
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  io_uring/opdef.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > Depending on your security policy, fetching file data, including
> > xattrs, can be interesting from a security perspective.  As an
> > example, look at the SELinux file/getattr permission.
> >
> > https://github.com/SELinuxProject/selinux-notebook/blob/main/src/object_classes_permissions.md#common-file-permissions
>
> The intent here is to lessen the impact of audit operations.  Read and
> Write were explicitly removed from io_uring auditing due to performance
> concerns coupled with the denial of service implications from sheer
> volume of records making other messages harder to locate.  Those
> operations are still possible for syscall auditing but they are strongly
> discouraged for normal use.

We need to balance security needs and performance needs.  You are
correct that general read() and write() operations are not audited,
and generally not checked from a LSM perspective as the auditing and
access control happens at open() time instead (access to fds is
revalidated when they are passed).  However, in the case of getxattr
and fgetxattr, these are not normal file read operations, and do not
go through the same code path in the kernel; there is a reason why we
have xattr_permission() and security_inode_getxattr().

We need to continue to audit IORING_OP_FGETXATTR and IORING_OP_GETXATTR.

-- 
paul-moore.com
