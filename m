Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C510871569E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjE3HYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjE3HXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:23:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6DCFA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:23:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6a6b9bebdso106615e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685431382; x=1688023382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNArBtEc+OxPox2YKaDrqEU5m4DU/ID2y9NiVG7rbIc=;
        b=SjZCOYQfisROpqOLh5PTIEJGH3YjTN1mt8GVLyo4CCBmlfKb/QyzTCs+sDny4ueXD9
         2+C8LuGZQ6w22kImrg38iw/g/UeT6Ono/ahU+daByvaLLSSb9awsOwhJoeZP1Xmz5zAf
         FQvPxQo1thFbyF9XQhXXiT8TdsYwoC9Z1aV6DiPzpEfnFnjALwBgvaaqVHHxjTebC4BR
         sch6c2xn9kfCDrjui5ama0fi70IUIYmdL58xir1MGImb+DCsOUo7GNvsznB8vLas/mxV
         78SktULbzpX5K4MiCljmW52YOo5A6jaCPNb0rhaSbpmvJuYZ38qDu1b4CfejaPStMent
         WI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685431382; x=1688023382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNArBtEc+OxPox2YKaDrqEU5m4DU/ID2y9NiVG7rbIc=;
        b=gxV0e2kf5yyrkPbxf6gfJrPFH4F63I7SRC8S7O2j983Z40K3m8kGdZpTTP2SqMAyxP
         4LJ2vogw5mLGfItcisimWDYCWerlpJFQ81U5ZGcDFAtc13vCzkGHoUi32dBf78+SGHtX
         bIJtRLuPEkEA0PMw+r3Gn5tUeO3vbmvgBiW2ReLVJFoSD9qlErQuOg1HGP4RzCz/+Vd7
         Bxe3SUT1tAUonXkTeAovUnBlNrdNYgvh08JWxkmaPbBDtVACdySJ7+WmfhL7TeeArQKS
         rv1rpp6qSncDyC8AgVrDxuHL4ZYsrecpNC6AhzSMy7kLN5YnnIEAy6ikkSYKwg7KXFJi
         jrzw==
X-Gm-Message-State: AC+VfDxScDt9UoDA9fxpiEne1YMIRMlzdThNtCnb7zptdCXvRCwUSlR2
        qN0lNlUtLmkucwFjIBwadAHMrJh8h1QvcMZQMHOZhg==
X-Google-Smtp-Source: ACHHUZ5pKkAdNoH5MjMz1N9azSb8H/CXsK+bvX5lvKB8dAEZGxAiU9tVrylqHcKg7LmmNbIBmC0pyC0FiQ6nNW+/gvQ=
X-Received: by 2002:a05:600c:3d86:b0:3f2:4fd2:e961 with SMTP id
 bi6-20020a05600c3d8600b003f24fd2e961mr94933wmb.0.1685431382265; Tue, 30 May
 2023 00:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <5fa8dfeb-8eb6-0de0-a335-e0b4336c29e0@I-love.SAKURA.ne.jp> <20230529190526.65d13658@kernel.org>
In-Reply-To: <20230529190526.65d13658@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 30 May 2023 09:22:50 +0200
Message-ID: <CANn89iLpeeJN=QA80c1wZZ0TB+ptzKN_Hq4Cf27C-URvKKbd2Q@mail.gmail.com>
Subject: Re: [PATCH] ref_tracker: add stack_depot_save() failure handling to ref_tracker_alloc()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 4:05=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 27 May 2023 20:04:11 +0900 Tetsuo Handa wrote:
> > stack_depot_save() cannot accept __GFP_NOFAIL flag because
> > __stack_depot_save() drops gfp flags which are not in
> > GFP_KERNEL | GFP_ATOMIC | __GFP_NOWARN. Also, changing
> > __stack_depot_save() to accept __GFP_NOFAIL is not possible
> > because rmqueue() does not want __GFP_NOFAIL flag for
> > order =3D=3D DEPOT_POOL_ORDER allocation request.
> >
> > Therefore, assume that stack_depot_save(GFP_KERNEL | __GFP_NOFAIL) from
> > ref_tracker_alloc() can silently fail, and emit "unreliable refcount
> > tracker." message.
>
> It's probably a good idea to CC netdev@vger. I'm not sure if anyone
> will pick this up from LKML.
>
> For the patch itself - I'm not sure it's needed, even if we don't
> record the stack we'll have a tracker object and still detect the leak.
> So printing the "unreliable refcount" message is not very precise.
> At least to me; Eric's opinion matters most.

Thanks Jakub (I was on a 3-days week end, computer turned off)

This patch looks wrong to me, or at very least not complete ?

If we really want this, why not remove all the code dealing with
tracker->alloc_stack_handle
being potentially NULL ?

Note: I never assumed stack_depot_save() would enforce/use NOFAIL.

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index dc7b14aa3431e2bf7a97a7e78220f04da144563d..530c51ab31f227a64e1210d108e=
9780f0bad72f7
100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -29,8 +29,7 @@ void ref_tracker_dir_exit(struct ref_tracker_dir *dir)
        }
        list_for_each_entry_safe(tracker, n, &dir->list, head) {
                pr_err("leaked reference.\n");
-               if (tracker->alloc_stack_handle)
-                       stack_depot_print(tracker->alloc_stack_handle);
+               stack_depot_print(tracker->alloc_stack_handle);
                leak =3D true;
                list_del(&tracker->head);
                kfree(tracker);
@@ -53,8 +52,7 @@ void ref_tracker_dir_print(struct ref_tracker_dir *dir,
        list_for_each_entry(tracker, &dir->list, head) {
                if (i < display_limit) {
                        pr_err("leaked reference.\n");
-                       if (tracker->alloc_stack_handle)
-                               stack_depot_print(tracker->alloc_stack_hand=
le);
+                       stack_depot_print(tracker->alloc_stack_handle);
                        i++;
                } else {
                        break;
@@ -124,10 +122,8 @@ int ref_tracker_free(struct ref_tracker_dir *dir,
        spin_lock_irqsave(&dir->lock, flags);
        if (tracker->dead) {
                pr_err("reference already released.\n");
-               if (tracker->alloc_stack_handle) {
-                       pr_err("allocated in:\n");
-                       stack_depot_print(tracker->alloc_stack_handle);
-               }
+               pr_err("allocated in:\n");
+               stack_depot_print(tracker->alloc_stack_handle);
                if (tracker->free_stack_handle) {
                        pr_err("freed in:\n");
                        stack_depot_print(tracker->free_stack_handle);
