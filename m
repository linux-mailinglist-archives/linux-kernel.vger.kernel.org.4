Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3752D62CB6C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiKPUu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbiKPUuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:50:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C34A657E1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:50:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 037EF61896
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 20:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6ACCC433D6;
        Wed, 16 Nov 2022 20:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668631845;
        bh=Teuqye5X5XKmGW+dW2s9vUDBvZBIQ8gXD7n+tkUXmic=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=TAaOD6fYCejEr3SAjo181o/QaYw1KamTTpxHZoL6F+cgmMeWPfL1n8s98WEYfG3EJ
         VVUcfOC2dN5sBb7o/zYkk5ojhzmR5vPSNUB85E/IwhN1k3KuYhiYLxXfJgdJKRPdq4
         BBKAqhfJxga+7bozsWwywyFR4IO6RmbPKI+B6HR5g3yQ6XhXYcfkO+GOTbH14t36vA
         CXoKAEdO9ZT9L1t6wkXw8t2zTNp0PnEuOI7JTGCrDZnU5GnzwALmU9dTVNqNHi2d4P
         9mNpsmmZsX2iM8N6UhXU0dNVSbs8Hq/+pg7H0CP2FRDR3waQIfChYMtFqSLbj6cDwV
         Z6+ROwp8lxG2g==
Message-ID: <d70c88eacdf4c79a658cd0698ac544c2e3510212.camel@kernel.org>
Subject: Re: [PATCH v2 2/2] tracing: Fix wild-memory-access in
 register_synth_event()
From:   Tom Zanussi <zanussi@kernel.org>
To:     Shang XiaoJing <shangxiaojing@huawei.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 16 Nov 2022 14:50:43 -0600
In-Reply-To: <20221113070920.26236-3-shangxiaojing@huawei.com>
References: <20221113070920.26236-1-shangxiaojing@huawei.com>
         <20221113070920.26236-3-shangxiaojing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shang,

On Sun, 2022-11-13 at 15:09 +0800, Shang XiaoJing wrote:
> In register_synth_event(), if set_synth_event_print_fmt() failed,
> then
> both trace_remove_event_call() and unregister_trace_event() will be
> called, which means the trace_event_call will call
> __unregister_trace_event() twice. As the result, the second
> unregister
> will causes the wild-memory-access.
>=20
> register_synth_event
> =C2=A0=C2=A0=C2=A0 set_synth_event_print_fmt failed
> =C2=A0=C2=A0=C2=A0 trace_remove_event_call
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event_remove
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if cal=
l->event.funcs then
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __unre=
gister_trace_event (first call)
> =C2=A0=C2=A0=C2=A0 unregister_trace_event
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __unregister_trace_event (seco=
nd call)
>=20
> Fix the bug by avoiding to call the second __unregister_trace_event()
> by
> checking if the first one is called.
>=20
> general protection fault, probably for non-canonical address
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xfbd59c0000000024: 0000 =
[#1] SMP KASAN PTI
> KASAN: maybe wild-memory-access in range
> [0xdead000000000120-0xdead000000000127]
> CPU: 0 PID: 3807 Comm: modprobe Not tainted
> 6.1.0-rc1-00186-g76f33a7eedb4 #299
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> RIP: 0010:unregister_trace_event+0x6e/0x280
> Code: 00 fc ff df 4c 89 ea 48 c1 ea 03 80 3c 02 00 0f 85 0e 02 00 00
> 48
> b8 00 00 00 00 00 fc ff df 4c 8b 63 08 4c 89 e2 48 c1 ea 03 <80> 3c
> 02
> 00 0f 85 e2 01 00 00 49 89 2c 24 48 85 ed 74 28 e8 7a 9b
> RSP: 0018:ffff88810413f370 EFLAGS: 00010a06
> RAX: dffffc0000000000 RBX: ffff888105d050b0 RCX: 0000000000000000
> RDX: 1bd5a00000000024 RSI: ffff888119e276e0 RDI: ffffffff835a8b20
> RBP: dead000000000100 R08: 0000000000000000 R09: fffffbfff0913481
> R10: ffffffff8489a407 R11: fffffbfff0913480 R12: dead000000000122
> R13: ffff888105d050b8 R14: 0000000000000000 R15: ffff888105d05028
> FS:=C2=A0 00007f7823e8d540(0000) GS:ffff888119e00000(0000)
> knlGS:0000000000000000
> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7823e7ebec CR3: 000000010a058002 CR4: 0000000000330ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> =C2=A0<TASK>
> =C2=A0__create_synth_event+0x1e37/0x1eb0
> =C2=A0create_or_delete_synth_event+0x110/0x250
> =C2=A0synth_event_run_command+0x2f/0x110
> =C2=A0test_gen_synth_cmd+0x170/0x2eb [synth_event_gen_test]
> =C2=A0synth_event_gen_test_init+0x76/0x9bc [synth_event_gen_test]
> =C2=A0do_one_initcall+0xdb/0x480
> =C2=A0do_init_module+0x1cf/0x680
> =C2=A0load_module+0x6a50/0x70a0
> =C2=A0__do_sys_finit_module+0x12f/0x1c0
> =C2=A0do_syscall_64+0x3f/0x90
> =C2=A0entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> Fixes: 4b147936fa50 ("tracing: Add support for 'synthetic' events")
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> Cc: stable@vger.kernel.org
> ---
> changes in v2:
> - remove the redundant if statement.
> ---
> =C2=A0kernel/trace/trace_events_synth.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/trace/trace_events_synth.c
> b/kernel/trace/trace_events_synth.c
> index e310052dc83c..63eccc50b492 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -829,8 +829,9 @@ static int register_synth_event(struct
> synth_event *event)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D set_synth_event_p=
rint_fmt(call);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0/* unregister_trace_event() will be called inside */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0trace_remove_event_call(call);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0goto err;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return ret;

Since 'return ret;' is already the next line below, you can just get
rid of this one.

Thanks,

Tom

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0 out:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;

