Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA766A7B60
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCBG1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCBG1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:27:46 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52591BF9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 22:27:44 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id cl18-20020a17090af69200b0023470d96ae6so1624396pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 22:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1s9VZXOhJ7DsOR8N1/cvuhFDdJDJYtoiVm83KN71Avo=;
        b=sS4d3/dlStG8D73OoSC5Gh4GlPDzm5bigEQTEoTH5Rsdt+9eAchZ+PIbrl6RGoJB1u
         ZpHwXibPE5F3+gnZcTnrR0AeAn9Zp3++9pAD7s4Fskd0cnPzN/t9OPd7B4q03tXobnEA
         6qF5DCbrXoy0UmUi9fBP/s5bjV1eMUaf6Mmz2mWLvnkjLsY/gDM2YVo9pBNbOuHtMrQN
         jf3gI1XceQ0y8HsBqz5HG+hHXHfHR6t7ApqIkK9cDO9fJYn8LYMJ9+9CQduvYiUnKxXF
         LYV5ZsCzmlnOrHmPrn1+oMbYR/RP3bgbZGjcHPX1rWlZd2tvqzQxcjizAXMdg8cq86RQ
         Xs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1s9VZXOhJ7DsOR8N1/cvuhFDdJDJYtoiVm83KN71Avo=;
        b=Vx+TYq0hOmybsKYED5VvcZi3ftJylSj+H8J/bOLdsQDGSCk5JMqeQ36ESvxfqk8sZo
         N4GNDhhggkAJC8U7Qip4hLbL97NPxx+0t7wNfFc9UvSl7QBWcFXcG2cdJIdXuluqFQv+
         d3/+jqVmRKPtmWYRpqvPd83E2fK3G136OZPvQUTlt0lt+ZlJurWvO+J32jp/YErLfzdD
         y0LOFWxaXaTZ6DyzaI+G5lvdXBP1DF3RHfgpYf5R9PM3CIV1iv1vFPcqnmvj3RGEaJYe
         X+NcGn28TmAGhDCZmoruAypV1kolD7TGM8Nsl7Q37xCm5QBB/vNwQCXGEuJbCM3ITdGM
         yQFQ==
X-Gm-Message-State: AO0yUKUnd4m9pJ7leUPYC9hN0looJ2LX3c3iR2sC6wZ9D58kpfWW1Elg
        sfiewmhcpzzgnS98bAnbjppfC9w7qe1o8QuWFcBAx2Ku1aYikUjR0QdhF0Bmb2SCwvDe+9C3Tso
        Kc4YflAtA949HO0DYsLt6I9WQXThJ9ULmOOxkse3qBPrDF7Eeze0+JigjbO3AcB/5dTyetbw=
X-Google-Smtp-Source: AK7set9kj1lE0RtF/CbpcTvi8LZqcI4CFVpapVVclots2Yp5QpJRrNhoMA3vDtZ7ljf1AeHBJazbbjs2g6XN
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:be1:b0:5aa:310c:e65b with SMTP id
 x33-20020a056a000be100b005aa310ce65bmr3419431pfu.2.1677738463969; Wed, 01 Mar
 2023 22:27:43 -0800 (PST)
Date:   Thu,  2 Mar 2023 06:27:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230302062741.483079-1-jstultz@google.com>
Subject: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 76d62f24db07f22ccf9bc18ca793c27d4ebef721.

So while priority inversion on the pmsg_lock is an occasional
problem that an rt_mutex would help with, in uses where logging
is writing to pmsg heavily from multiple threads, the pmsg_lock
can be heavily contended.

Normal mutexes can do adaptive spinning, which keeps the
contention overhead fairly low maybe adding on the order of 10s
of us delay waiting, but the slowpath w/ rt_mutexes makes the
blocked tasks sleep & wake. This makes matters worse when there
is heavy contentention, as it just allows additional threads to
run and line up to try to take the lock.

It devolves to a worse case senerio where the lock acquisition
and scheduling overhead dominates, and each thread is waiting on
the order of ~ms to do ~us of work.

Obviously, having tons of threads all contending on a single
lock for logging is non-optimal, so the proper fix is probably
reworking pstore pmsg to have per-cpu buffers so we don't have
contention.

But in the short term, lets revert the change to the rt_mutex
and go back to normal mutexes to avoid a potentially major
performance regression.

Cc: Wei Wang <wvw@google.com>
Cc: Midas Chien<midaschieh@google.com>
Cc: Chunhui Li (=E6=9D=8E=E6=98=A5=E8=BE=89)" <chunhui.li@mediatek.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: kernel-team@android.com
Fixes: 76d62f24db07 ("pstore: Switch pmsg_lock to an rt_mutex to avoid prio=
rity inversion")
Reported-by: Chunhui Li (=E6=9D=8E=E6=98=A5=E8=BE=89)" <chunhui.li@mediatek=
.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 fs/pstore/pmsg.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
index ab82e5f05346..b31c9c72d90b 100644
--- a/fs/pstore/pmsg.c
+++ b/fs/pstore/pmsg.c
@@ -7,10 +7,9 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
-#include <linux/rtmutex.h>
 #include "internal.h"
=20
-static DEFINE_RT_MUTEX(pmsg_lock);
+static DEFINE_MUTEX(pmsg_lock);
=20
 static ssize_t write_pmsg(struct file *file, const char __user *buf,
 			  size_t count, loff_t *ppos)
@@ -29,9 +28,9 @@ static ssize_t write_pmsg(struct file *file, const char _=
_user *buf,
 	if (!access_ok(buf, count))
 		return -EFAULT;
=20
-	rt_mutex_lock(&pmsg_lock);
+	mutex_lock(&pmsg_lock);
 	ret =3D psinfo->write_user(&record, buf);
-	rt_mutex_unlock(&pmsg_lock);
+	mutex_unlock(&pmsg_lock);
 	return ret ? ret : count;
 }
=20
--=20
2.39.2.722.g9855ee24e9-goog

