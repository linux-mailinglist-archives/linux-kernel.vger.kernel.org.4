Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F61369ED51
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjBVDL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjBVDLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:11:20 -0500
X-Greylist: delayed 344 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Feb 2023 19:11:19 PST
Received: from out-29.mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A242327D49
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 19:11:19 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677035129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0XpiP3a7eswa+uhx2R0D1ryJ7VB+IJ+c2OKlL9Hke/I=;
        b=AoVTzoe2nwXiexTmppdlb8Phygr7AwPiE6zHQjdi7MRMyosesjM2wrRamP3V1be28LVW63
        GmdL0wiEHotDlGAiuWHg++/1+ktYZip7/MkqWbi0kR15djXhtdPdpMY5irZkqe7C1tv6wX
        5Tp2mWsE0uCPXQGPVAB6U0zwsSyNuOk=
Date:   Wed, 22 Feb 2023 03:05:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   qu.huang@linux.dev
Message-ID: <ea5b997309825b21e406f9bad2ce8779@linux.dev>
Subject: [PATCH v2] drm/amdkfd: Fix an illegal memory access
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

In the kfd_wait_on_events() function, the kfd_event_waiter structure is=
=0Aallocated by alloc_event_waiters(), but the event field of the waiter=
=0Astructure is not initialized; When copy_from_user() fails in the=0Akfd=
_wait_on_events() function, it will enter exception handling to=0Arelease=
 the previously allocated memory of the waiter structure;=0ADue to the ev=
ent field of the waiters structure being accessed=0Ain the free_waiters()=
 function, this results in illegal memory access=0Aand system crash, here=
 is the crash log:=0A=0Alocalhost kernel: RIP: 0010:native_queued_spin_lo=
ck_slowpath+0x185/0x1e0=0Alocalhost kernel: RSP: 0018:ffffaa53c362bd60 EF=
LAGS: 00010082=0Alocalhost kernel: RAX: ff3d3d6bff4007cb RBX: 00000000000=
00282 RCX: 00000000002c0000=0Alocalhost kernel: RDX: ffff9e855eeacb80 RSI=
: 000000000000279c RDI: ffffe7088f6a21d0=0Alocalhost kernel: RBP: ffffe70=
88f6a21d0 R08: 00000000002c0000 R09: ffffaa53c362be64=0Alocalhost kernel:=
 R10: ffffaa53c362bbd8 R11: 0000000000000001 R12: 0000000000000002=0Aloca=
lhost kernel: R13: ffff9e7ead15d600 R14: 0000000000000000 R15: ffff9e7ead=
15d698=0Alocalhost kernel: FS:  0000152a3d111700(0000) GS:ffff9e855ee8000=
0(0000) knlGS:0000000000000000=0Alocalhost kernel: CS:  0010 DS: 0000 ES:=
 0000 CR0: 0000000080050033=0Alocalhost kernel: CR2: 0000152938000010 CR3=
: 000000044d7a4000 CR4: 00000000003506e0=0Alocalhost kernel: Call Trace:=
=0Alocalhost kernel: _raw_spin_lock_irqsave+0x30/0x40=0Alocalhost kernel:=
 remove_wait_queue+0x12/0x50=0Alocalhost kernel: kfd_wait_on_events+0x1b6=
/0x490 [hydcu]=0Alocalhost kernel: ? ftrace_graph_caller+0xa0/0xa0=0Aloca=
lhost kernel: kfd_ioctl+0x38c/0x4a0 [hydcu]=0Alocalhost kernel: ? kfd_ioc=
tl_set_trap_handler+0x70/0x70 [hydcu]=0Alocalhost kernel: ? kfd_ioctl_cre=
ate_queue+0x5a0/0x5a0 [hydcu]=0Alocalhost kernel: ? ftrace_graph_caller+0=
xa0/0xa0=0Alocalhost kernel: __x64_sys_ioctl+0x8e/0xd0=0Alocalhost kernel=
: ? syscall_trace_enter.isra.18+0x143/0x1b0=0Alocalhost kernel: do_syscal=
l_64+0x33/0x80=0Alocalhost kernel: entry_SYSCALL_64_after_hwframe+0x44/0x=
a9=0Alocalhost kernel: RIP: 0033:0x152a4dff68d7=0A=0AChanges since v1:=0A=
  * Allocate the waiter structure using kzalloc, removing the initializat=
ion of activated;=0A  * '(event_waiters) &&' in the 'for' loop has also b=
een removed.=0A=0ASigned-off-by: Qu Huang <qu.huang@linux.dev>=0A---=0A d=
rivers/gpu/drm/amd/amdkfd/kfd_events.c | 5 ++---=0A 1 file changed, 2 ins=
ertions(+), 3 deletions(-)=0A=0Adiff --git a/drivers/gpu/drm/amd/amdkfd/k=
fd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c=0Aindex 729d26d..bb=
54f6c 100644=0A--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c=0A+++ b/driv=
ers/gpu/drm/amd/amdkfd/kfd_events.c=0A@@ -780,13 +780,12 @@ static struct=
 kfd_event_waiter *alloc_event_waiters(uint32_t num_events)=0A=0A 	event_=
waiters =3D kmalloc_array(num_events,=0A 					sizeof(struct kfd_event_wai=
ter),=0A-					GFP_KERNEL);=0A+					GFP_KERNEL | __GFP_ZERO);=0A 	if (!eve=
nt_waiters)=0A 		return NULL;=0A=0A-	for (i =3D 0; (event_waiters) && (i =
< num_events) ; i++) {=0A+	for (i =3D 0; i < num_events; i++) {=0A 		init=
_wait(&event_waiters[i].wait);=0A-		event_waiters[i].activated =3D false;=
=0A 	}=0A=0A 	return event_waiters;=0A--=0A1.8.3.1
