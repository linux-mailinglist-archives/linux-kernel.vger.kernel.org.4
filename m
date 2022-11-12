Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93471626BC7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbiKLVMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKLVMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:12:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB2E101E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 13:12:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87A1DB80B28
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 21:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A71C433C1;
        Sat, 12 Nov 2022 21:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668287539;
        bh=eN/1gqh33s+K0iVSkFE4yXmQFf/WUXGh7AkLnYWClqM=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=EzCIdCTCE4CLJzDRPV8itJ9W39MfSPrMGHtF4fs48olZ7VAHJ1/jyvtCVhoPpK5H5
         aFXlp3U6VSzaEwpAscFSbjKO30DZgYhxGNuoefYIWpSmjY7pacUrrPeEtaRx9xLWQg
         EF1XUKitougw9fWpAgkuiLQsuTI0PRlPm10duejZeH7ut8hc5Lj77/7yq2qO0bCfMZ
         IifkdPOAuBdajA6f6MaQQQByVmDaCs+gQ+1gQhG4A/OH4/N5w8I7LFLrn9SpUULHDQ
         rQtLEcj4lkmCsyDPfWSHNeYIEUgpWZoW+smaXx/h0UFI012e/RB4Ow4M/+gGsDyBiL
         Qwbtfhb6MdxAQ==
Message-ID: <1b1d42582c2c9957dc47cd25b50f566b305fb14b.camel@kernel.org>
Subject: Re: [PATCH 1/2] tracing: Fix memory leak in test_gen_synth_cmd()
 and test_empty_synth_event()
From:   Tom Zanussi <zanussi@kernel.org>
To:     Shang XiaoJing <shangxiaojing@huawei.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 12 Nov 2022 15:12:17 -0600
In-Reply-To: <20221108083124.27218-2-shangxiaojing@huawei.com>
References: <20221108083124.27218-1-shangxiaojing@huawei.com>
         <20221108083124.27218-2-shangxiaojing@huawei.com>
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

Thanks for finding this bug, comment below...

On Tue, 2022-11-08 at 16:31 +0800, Shang XiaoJing wrote:
> test_gen_synth_cmd() only free buf in fail path, hence buf will leak
> when there is no failure. Add kfree(buf) to prevent the memleak. The
> same reason and solution in test_empty_synth_event().
>=20
> unreferenced object 0xffff8881127de000 (size 2048):
> =C2=A0 comm "modprobe", pid 247, jiffies 4294972316 (age 78.756s)
> =C2=A0 hex dump (first 32 bytes):
> =C2=A0=C2=A0=C2=A0 20 67 65 6e 5f 73 79 6e 74 68 5f 74 65 73 74 20=C2=A0=
=C2=A0 gen_synth_test
> =C2=A0=C2=A0=C2=A0 20 70 69 64 5f 74 20 6e 65 78 74 5f 70 69 64 5f=C2=A0=
=C2=A0 pid_t next_pid_
> =C2=A0 backtrace:
> =C2=A0=C2=A0=C2=A0 [<000000004254801a>] kmalloc_trace+0x26/0x100
> =C2=A0=C2=A0=C2=A0 [<0000000039eb1cf5>] 0xffffffffa00083cd
> =C2=A0=C2=A0=C2=A0 [<000000000e8c3bc8>] 0xffffffffa00086ba
> =C2=A0=C2=A0=C2=A0 [<00000000c293d1ea>] do_one_initcall+0xdb/0x480
> =C2=A0=C2=A0=C2=A0 [<00000000aa189e6d>] do_init_module+0x1cf/0x680
> =C2=A0=C2=A0=C2=A0 [<00000000d513222b>] load_module+0x6a50/0x70a0
> =C2=A0=C2=A0=C2=A0 [<000000001fd4d529>] __do_sys_finit_module+0x12f/0x1c0
> =C2=A0=C2=A0=C2=A0 [<00000000b36c4c0f>] do_syscall_64+0x3f/0x90
> =C2=A0=C2=A0=C2=A0 [<00000000bbf20cf3>] entry_SYSCALL_64_after_hwframe+0x=
63/0xcd
> unreferenced object 0xffff8881127df000 (size 2048):
> =C2=A0 comm "modprobe", pid 247, jiffies 4294972324 (age 78.728s)
> =C2=A0 hex dump (first 32 bytes):
> =C2=A0=C2=A0=C2=A0 20 65 6d 70 74 79 5f 73 79 6e 74 68 5f 74 65 73=C2=A0=
=C2=A0 empty_synth_tes
> =C2=A0=C2=A0=C2=A0 74 20 20 70 69 64 5f 74 20 6e 65 78 74 5f 70 69=C2=A0 =
t=C2=A0 pid_t next_pi
> =C2=A0 backtrace:
> =C2=A0=C2=A0=C2=A0 [<000000004254801a>] kmalloc_trace+0x26/0x100
> =C2=A0=C2=A0=C2=A0 [<00000000d4db9a3d>] 0xffffffffa0008071
> =C2=A0=C2=A0=C2=A0 [<00000000c31354a5>] 0xffffffffa00086ce
> =C2=A0=C2=A0=C2=A0 [<00000000c293d1ea>] do_one_initcall+0xdb/0x480
> =C2=A0=C2=A0=C2=A0 [<00000000aa189e6d>] do_init_module+0x1cf/0x680
> =C2=A0=C2=A0=C2=A0 [<00000000d513222b>] load_module+0x6a50/0x70a0
> =C2=A0=C2=A0=C2=A0 [<000000001fd4d529>] __do_sys_finit_module+0x12f/0x1c0
> =C2=A0=C2=A0=C2=A0 [<00000000b36c4c0f>] do_syscall_64+0x3f/0x90
> =C2=A0=C2=A0=C2=A0 [<00000000bbf20cf3>] entry_SYSCALL_64_after_hwframe+0x=
63/0xcd
>=20
> Fixes: 9fe41efaca08 ("tracing: Add synth event generation test
> module")
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
> =C2=A0kernel/trace/synth_event_gen_test.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/kernel/trace/synth_event_gen_test.c
> b/kernel/trace/synth_event_gen_test.c
> index 0b15e975d2c2..db1ec4809ad1 100644
> --- a/kernel/trace/synth_event_gen_test.c
> +++ b/kernel/trace/synth_event_gen_test.c
> @@ -120,6 +120,7 @@ static int __init test_gen_synth_cmd(void)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Now generate a gen_syn=
th_test event */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D synth_event_trace=
_array(gen_synth_test, vals,
> ARRAY_SIZE(vals));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(buf);
> =C2=A0 out:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> =C2=A0 delete:
> @@ -227,6 +228,7 @@ static int __init test_empty_synth_event(void)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Now trace an empty_syn=
th_test event */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D synth_event_trace=
_array(empty_synth_test, vals,
> ARRAY_SIZE(vals));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(buf);
> =C2=A0 out:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> =C2=A0 delete:

Makes sense, and if you do this then you could probably remove the
other kfree() at the bottom and clean the code up a bit, like change
this:

       /* Now generate a gen_synth_test event */
       ret =3D synth_event_trace_array(gen_synth_test, vals, ARRAY_SIZE(val=
s));
       kfree(buf);
 out:
        return ret;
 delete:
        /* We got an error after creating the event, delete it */
	synth_event_delete("gen_synth_test");
 free:
        kfree(buf);

	goto out;
}

to this:

       /* Now generate a gen_synth_test event */
       ret =3D synth_event_trace_array(gen_synth_test, vals, ARRAY_SIZE(val=
s));
 free:
       kfree(buf);
       return ret;
 delete:
        /* We got an error after creating the event, delete it */
	synth_event_delete("gen_synth_test");
 	goto free;
}

What do you think?

Tom
