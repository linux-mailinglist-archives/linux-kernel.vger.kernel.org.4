Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE146D6D3A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbjDDTdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbjDDTdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:33:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A8849D1;
        Tue,  4 Apr 2023 12:33:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b20so135039639edd.1;
        Tue, 04 Apr 2023 12:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680636791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ADWid2t9D+VuAIQH5kZ1bkuTOmJiZU2kCRqFxPkj/Bc=;
        b=UuWncv9syyeGG4Y//No6XkfwM4SYS2xpKQTWO8haw/hD/bETCY1QrLY5X1zwHCGGuw
         lKG5uT4mvuUCX93CkdFxTJnRVwq2/Y6C5mXtiau+/1eYq09NBDrzNQKnB2sd8+jO/o72
         YjWKtDo7efBcKszqDbOSRWyUdXZzhAb4rir6tiaUGtIWdU+PddqtE2ItrIS0HXuhhHlV
         wbGpAWoxhucRXESX0S+vRE8jhUk93E4+hF/nNzctyuzuJ+dVxz7U7O+VEqE0MDJWio+U
         LTNaK32km6Bf9SJrF7c7gvwXu5WiVZ4TN1WgqQPdme5QZtYAuyQo75wcV5BEI7usuftD
         blWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680636791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADWid2t9D+VuAIQH5kZ1bkuTOmJiZU2kCRqFxPkj/Bc=;
        b=dEWbivapCmvd0gHU5zAtaz9C00gfNR5FWzzrRchobTk53vKAaWt/WqWRNY/4CdRrcs
         Uu220yyyJqUvNWIF0Vi17ez4NRWHhAQtjG45lRBOaRAMDU4cm2Gi9nHbULhdjWvYE2GP
         4+A8KFiKXa43szZZu+Wo49KfJSw3RPR8UZS9kAWfLffskJs9n9q5geO0RU8kBYRHlNBw
         c1SvYZYnIYDRbiD21cU/1AQSyIIAzH7AiwFFCj2STQ42oHQl1GiiJPhncGfSOkevIZft
         PJf39gGLuR+/pu+Msyx4xxuLG+m3WU0mA9hyo5lE5PWcKBjY/HHb3/a8u5p7XZ2n0KMZ
         Sb2Q==
X-Gm-Message-State: AAQBX9d5KigNTovKlF2eLf6fjbCZa/LSN9pYy+3vaojD6jVQYtAqjnnz
        U/AfboB/BI1QnfNRKgmQwJ0=
X-Google-Smtp-Source: AKy350YcpT8yBBP1GJBzn1D6kk6cS4shrfAbfILfucso2ifapdcwIrAgq/cDTNIpC1bXkc7kWCaG1A==
X-Received: by 2002:a50:ef18:0:b0:4fa:d83b:f5da with SMTP id m24-20020a50ef18000000b004fad83bf5damr432482eds.30.1680636790457;
        Tue, 04 Apr 2023 12:33:10 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id r19-20020a50c013000000b004fd29e87535sm6267504edb.14.2023.04.04.12.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 12:33:09 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 4 Apr 2023 21:33:07 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     =?utf-8?B?5Luj5a2Q5Li6IChaaXdlaSBEYWkp?= <Ziwei.Dai@unisoc.com>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?546L5Y+MIChTaHVhbmcgV2FuZyk=?= <shuang.wang@unisoc.com>,
        =?utf-8?B?6L6b5L6d5YehIChZaWZhbiBYaW4p?= <Yifan.Xin@unisoc.com>,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
        =?utf-8?B?6Zer5a2m5paHIChYdWV3ZW4gWWFuKQ==?= 
        <Xuewen.Yan@unisoc.com>,
        =?utf-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= 
        <Zhiguo.Niu@unisoc.com>,
        =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= 
        <zhaoyang.huang@unisoc.com>
Subject: Re: Re: [PATCH V2] rcu: Make sure new krcp free business is handled
 after the wanted rcu grace period.
Message-ID: <ZCx7cwzJzGMEpImn@pc636>
References: <10f5eb13d7c741c2a0e83ff1d788f398@BJMBX01.spreadtrum.com>
 <c0d8b802-8931-44d9-8a04-6265dade23a2@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0d8b802-8931-44d9-8a04-6265dade23a2@paulmck-laptop>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > My concern is that running the channels separately might mean more grace
> > > periods (and thus more energy draw) on nearly idle devices, such devices
> > > usually being the ones for which energy efficiency matters most.
> > > 
> > > But perhaps Vlad, Neeraj, or Joel has some insight on this, given
> > > that they are the ones working on battery-powered devices.
> > > 
> > > > > Either way, this fixes only one bug of two.  The second bug is in the
> > > > > kfree_rcu() tests, which should have caught this bug.  Thoughts on a good fix
> > > > > for those tests?
> > > >
> > > > I inserted a msleep() between "rcu_read_lock(), get pointer via rcu_dereference()"
> > > > and "reference pointer, using the member", at the rcu scenario, then we can
> > > > reproduce this issue very soon in stress test. Can kfree_rcu() tests insert msleep()?
> > > 
> > > Another approach is to separate concerns, so that readers interact with
> > > grace periods in the rcutorture.c tests, and to add the interaction
> > > of to-be-freed memory with grace periods in the rcuscale kvfree tests.
> > > I took a step in this direction with this commit on the -rcu tree's
> > > "dev" branch:
> > > 
> > > efbe7927f479 ("rcu/kvfree: Add debug to check grace periods")
> > > 
> > > Given this, might it be possible to make rcuscale.c's kfree_rcu()
> > > testing create patterns of usage of the three channels so as to
> > > catch this bug that way?
> > > 
> > 
> > I can try it on my k5.15 device, and need some time.
> > I have a question. Do you mean add code in tree.c to create pattern
> > while channel data is being freed?
> > If so, both rcuscales.c and tree.c need to be modified for the test case.
> 
> My thought is to run the test on a system where very little else is
> happening, and then creating the temporal pattern only in rcuscale.c.
> One way would be to modify kfree_scale_thread(), perhaps using an
> additional module parameter using torture_param().
> 
> But just out of curiosity, what changes were you thinking of making
> in tree.c?
> 
OK. I can reproduce it on latest rcu-dev:

<snip>
[   75.302795] ------------[ cut here ]------------
[   75.302801] WARNING: CPU: 50 PID: 721 at kernel/rcu/tree.c:3043 kfree_rcu_work+0x157/0x1a0
[   75.302808] Modules linked in: test_vmalloc(E+) bochs(E) drm_vram_helper(E) snd_pcm(E) drm_ttm_helper(E) ppdev(E) snd_timer(E) joydev(E) ttm(E) drm_kms_helper(E) snd(E) parport_pc(E) soundcore(E) evdev(E) pcspkr(E) sg(E) serio_raw(E) parport(E) drm(E) qemu_fw_cfg(E) button(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E) jbd2(E) sd_mod(E) t10_pi(E) crc64_rocksoft(E) crc64(E) crc_t10dif(E) crct10dif_generic(E) sr_mod(E) cdrom(E) crct10dif_common(E) ata_generic(E) ata_piix(E) libata(E) scsi_mod(E) psmouse(E) e1000(E) scsi_common(E) i2c_piix4(E) floppy(E)
[   75.302865] CPU: 50 PID: 721 Comm: kworker/50:1 Kdump: loaded Tainted: G            E      6.3.0-rc1+ #58
[   75.302868] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[   75.302870] Workqueue: events kfree_rcu_work
[   75.302905] RIP: 0010:kfree_rcu_work+0x157/0x1a0
[   75.302907] Code: 8b 05 75 f9 37 01 4c 29 e8 48 83 f8 f8 76 40 48 8b 4c 24 08 48 83 f9 01 74 35 48 8b 05 ca b4 44 01 48 29 c8 48 83 f8 f8 76 25 <0f> 0b 48 8b 44 24 38 65 48 2b 04 25 28 00 00 00 75 23 48 83 c4 40
[   75.302910] RSP: 0018:ffffbd4642d8bde8 EFLAGS: 00010202
[   75.302913] RAX: fffffffffffffffc RBX: ffff9f693d5dd140 RCX: 000000000000003c
[   75.302914] RDX: 0000000000000002 RSI: ffffbd4642d8be08 RDI: ffff9f5a4d608000
[   75.302916] RBP: ffffbd4642d8be08 R08: 0000001188654ff5 R09: 0000000000000000
[   75.302918] R10: 0000000000000001 R11: 0000000000000001 R12: ffffbd46812d7000
[   75.302919] R13: 0000000000000260 R14: ffffbd4642d8bdf8 R15: ffff9f5a47637000
[   75.302922] FS:  0000000000000000(0000) GS:ffff9f693e200000(0000) knlGS:0000000000000000
[   75.302924] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   75.302926] CR2: 0000562dfe4307d0 CR3: 000000054ba26000 CR4: 00000000000006e0
[   75.302930] Call Trace:
[   75.302937]  <TASK>
[   75.302942]  ? lock_acquire+0xc8/0x1a0
[   75.302949]  process_one_work+0x29d/0x560
[   75.302957]  ? __pfx_worker_thread+0x10/0x10
[   75.302960]  worker_thread+0x52/0x3a0
[   75.302964]  ? __pfx_worker_thread+0x10/0x10
[   75.302967]  kthread+0xe7/0x110
[   75.302970]  ? __pfx_kthread+0x10/0x10
[   75.302973]  ret_from_fork+0x2c/0x50
[   75.302984]  </TASK>
[   75.302986] ---[ end trace 0000000000000000 ]---
<snip>

This is with:

<snip>
commit 8f6414680a0d539ca0e7fde80556c71b7b3da88a (HEAD -> dev)
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Apr 4 15:51:56 2023 +0200

    rcu/kvfree: Add debug check of GP ready for ptrs in a list

commit efbe7927f47958a6805da5560d9a5f469ba51e73 (origin/dev)
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon Apr 3 16:49:14 2023 -0700

    rcu/kvfree: Add debug to check grace periods

+ below revert

commit 6b4fef6ec689b1dda9c63be77e9a81a52cc39dc1
Author: Ziwei Dai <ziwei.dai@unisoc.com>
Date:   Fri Mar 31 20:42:09 2023 +0800

    rcu/kvfree: Avoid freeing new kfree_rcu() memory after old grace period
<snip>

The test is "sudo ./test_vmalloc.sh run_test_mask=768 nr_threads=64&"

it runs single argument and double argument to free vmalloc ptrs.,
number of threads are 64:

without revert(with a patch that is in question), i am not able to
reproduce it anymore.

--
Uladzislau Rezki
