Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF3E69DF31
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjBULoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjBULoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:44:25 -0500
X-Greylist: delayed 517 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Feb 2023 03:43:57 PST
Received: from out-18.mta1.migadu.com (out-18.mta1.migadu.com [IPv6:2001:41d0:203:375::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D374A1F90A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:43:57 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676979317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0gXYNRzzbITxqC5/S0B+BHx0Ap4RLzkH7+/YGE5Q3gI=;
        b=VdfJz94FNlNZxmcM6B8iVNMtf676v7YOehY7uKZdLEjaW33iyhyVPy3uWZ+jQVY+x7NY7Z
        kzcTk8Ye5VaOUN7/tOHgaumBhba5ge0zZPjyREl28q4u/SYXrGFdyJdsSqSmpxhvcZ43ON
        iw1rIbEm1rmVKLSPi2/jjNbJlpV/59s=
Date:   Tue, 21 Feb 2023 11:35:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   qu.huang@linux.dev
Message-ID: <eb49be7c44ae95c4d18e66b59874ef1c@linux.dev>
Subject: [PATCH] drm/amdkfd: Fix an illegal memory access
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, qu.huang@linux.dev
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Huang <qu.huang@linux.dev>=0A=0AIn the kfd_wait_on_events() func=
tion, the kfd_event_waiter structure is=0Aallocated by alloc_event_waiter=
s(), but the event field of the waiter=0Astructure is not initialized; Wh=
en copy_from_user() fails in the=0Akfd_wait_on_events() function, it will=
 enter exception handling to=0Arelease the previously allocated memory of=
 the waiter structure;=0ADue to the event field of the waiters structure =
being accessed=0Ain the free_waiters() function, this results in illegal =
memory access=0Aand system crash, here is the crash log:=0A=0Alocalhost k=
ernel: RIP: 0010:native_queued_spin_lock_slowpath+0x185/0x1e0=0Alocalhost=
 kernel: RSP: 0018:ffffaa53c362bd60 EFLAGS: 00010082=0Alocalhost kernel: =
RAX: ff3d3d6bff4007cb RBX: 0000000000000282 RCX: 00000000002c0000=0Alocal=
host kernel: RDX: ffff9e855eeacb80 RSI: 000000000000279c RDI: ffffe7088f6=
a21d0=0Alocalhost kernel: RBP: ffffe7088f6a21d0 R08: 00000000002c0000 R09=
: ffffaa53c362be64=0Alocalhost kernel: R10: ffffaa53c362bbd8 R11: 0000000=
000000001 R12: 0000000000000002=0Alocalhost kernel: R13: ffff9e7ead15d600=
 R14: 0000000000000000 R15: ffff9e7ead15d698=0Alocalhost kernel: FS:  000=
0152a3d111700(0000) GS:ffff9e855ee80000(0000) knlGS:0000000000000000=0Alo=
calhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0Alocal=
host kernel: CR2: 0000152938000010 CR3: 000000044d7a4000 CR4: 00000000003=
506e0=0Alocalhost kernel: Call Trace:=0Alocalhost kernel: _raw_spin_lock_=
irqsave+0x30/0x40=0Alocalhost kernel: remove_wait_queue+0x12/0x50=0Alocal=
host kernel: kfd_wait_on_events+0x1b6/0x490 [hydcu]=0Alocalhost kernel: ?=
 ftrace_graph_caller+0xa0/0xa0=0Alocalhost kernel: kfd_ioctl+0x38c/0x4a0 =
[hydcu]=0Alocalhost kernel: ? kfd_ioctl_set_trap_handler+0x70/0x70 [hydcu=
]=0Alocalhost kernel: ? kfd_ioctl_create_queue+0x5a0/0x5a0 [hydcu]=0Aloca=
lhost kernel: ? ftrace_graph_caller+0xa0/0xa0=0Alocalhost kernel: __x64_s=
ys_ioctl+0x8e/0xd0=0Alocalhost kernel: ? syscall_trace_enter.isra.18+0x14=
3/0x1b0=0Alocalhost kernel: do_syscall_64+0x33/0x80=0Alocalhost kernel: e=
ntry_SYSCALL_64_after_hwframe+0x44/0xa9=0Alocalhost kernel: RIP: 0033:0x1=
52a4dff68d7=0A=0ASigned-off-by: Qu Huang <qu.huang@linux.dev>=0A---=0A dr=
ivers/gpu/drm/amd/amdkfd/kfd_events.c | 1 +=0A 1 file changed, 1 insertio=
n(+)=0A=0Adiff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/=
gpu/drm/amd/amdkfd/kfd_events.c=0Aindex 729d26d..e5faaad 100644=0A--- a/d=
rivers/gpu/drm/amd/amdkfd/kfd_events.c=0A+++ b/drivers/gpu/drm/amd/amdkfd=
/kfd_events.c=0A@@ -787,6 +787,7 @@ static struct kfd_event_waiter *alloc=
_event_waiters(uint32_t num_events)=0A 	for (i =3D 0; (event_waiters) && =
(i < num_events) ; i++) {=0A 		init_wait(&event_waiters[i].wait);=0A 		ev=
ent_waiters[i].activated =3D false;=0A+		event_waiters[i].event =3D NULL;=
=0A 	}=0A=0A 	return event_waiters;=0A--=0A1.8.3.1
