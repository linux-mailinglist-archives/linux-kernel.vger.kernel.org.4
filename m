Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE46A74146B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjF1PAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:00:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45710 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjF1PAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:00:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 65CEF21860;
        Wed, 28 Jun 2023 15:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687964418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9CR37uQiwm1asElSZ3bEZlRLiaAveFIzzgBUB68uggQ=;
        b=e3Re6unHuBiffFAXxG6nuCseD+DgbqVyUv6IQB2qwK3gc8BdA+tzWkQn54L8fISjR7Bf+o
        SyKjki7jFld3fuMMt5HbJv+2dp07qQuZ1utLfydzHH0MgAe5sNG2sP87scRlkbE1h/ktur
        Qz9T9ZonsWOOfu1I4fmL9LMVJjnU6/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687964418;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9CR37uQiwm1asElSZ3bEZlRLiaAveFIzzgBUB68uggQ=;
        b=Y76jjcsjy6OxdkD6gogSK2CzIqDbGp+ZwB1ngf4tgTLAJF/lHpBdyM2mWuCCkxQlVhYMBu
        CV/Ht9uvZQsV+0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43A7B138EF;
        Wed, 28 Jun 2023 15:00:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rp1rDwJLnGSKMQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 28 Jun 2023 15:00:18 +0000
Date:   Wed, 28 Jun 2023 17:00:17 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Message-ID: <6g53yj5afhhonwf2psf7ft2gkakkwewy7klkix3y3u6uclpa5w@tt2yfzigyxgg>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <oyhlgbqq6pjwln5ly47rt5iyjtai4jeepkascfaskn2z7nu3ks@te7yrwbcpsmi>
 <ygfgqglmntpqiopzq44aqegehnlroarteqjtmih7mulan4oukv@jmtupz2jnafv>
 <c6x53xzjqlmhvxpvrlhkuoclzslcogonznypuqlowcegygemyb@754b3ynn5xfu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6x53xzjqlmhvxpvrlhkuoclzslcogonznypuqlowcegygemyb@754b3ynn5xfu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:04:01AM +0000, Shinichiro Kawasaki wrote:
> > BTW, when the udev rule is active I observed crashes when running blktests. So
> > there is more to fix, though one thing at the time.

FTR, this is typical hanger/crash I see when the udev rule is active:

 run blktests nvme/005 at 2023-06-28 16:30:07
 loop0: detected capacity change from 0 to 32768
 nvmet: adding nsid 1 to subsystem blktests-subsystem-1
 nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
 (NULL device *): {0:0} Association created
 [43] nvmet: ctrl 1 start keep-alive timer for 5 secs
 nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8.
 [7] nvmet: adding queue 1 to ctrl 1.
 [363] nvmet: adding queue 2 to ctrl 1.
 [43] nvmet: adding queue 3 to ctrl 1.
 [45] nvmet: adding queue 4 to ctrl 1.
 nvme nvme2: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1"
 nvme nvme3: NVME-FC{1}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
 (NULL device *): {0:1} Association created
 [43] nvmet: ctrl 2 start keep-alive timer for 120 secs
 nvmet: creating discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8.
 nvme nvme3: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
 nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
 (NULL device *): {0:2} Association created
 [24] nvmet: ctrl 3 start keep-alive timer for 5 secs
 nvmet: creating nvm controller 3 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8.
 [7] nvmet: adding queue 1 to ctrl 3.
 [24] nvmet: adding queue 2 to ctrl 3.
 [43] nvmet: adding queue 3 to ctrl 3.
 [45] nvmet: adding queue 4 to ctrl 3.
 nvme nvme2: NVME-FC{0}: controller connect complete
 nvme nvme2: Removing ctrl: NQN "blktests-subsystem-1"
 block nvme2n1: no available path - failing I/O
 block nvme2n1: no available path - failing I/O
 Buffer I/O error on dev nvme2n1, logical block 0, async page read
 [363] nvmet: ctrl 1 stop keep-alive
 (NULL device *): {0:0} Association deleted
 (NULL device *): {0:0} Association freed
 (NULL device *): Disconnect LS failed: No Association
 general protection fault, probably for non-canonical address 0xdffffc00000000a4: 0000 [#1] PREEMPT SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000520-0x0000000000000527]
 CPU: 1 PID: 363 Comm: kworker/1:4 Tainted: G    B   W          6.4.0-rc2+ #4 451dee9b3635bb59af0c91bc19227b1b3bbbbf3f
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown unknown
 Workqueue: nvmet-wq fcloop_fcp_recv_work [nvme_fcloop]
 RIP: 0010:nvmet_execute_disc_get_log_page+0x23f/0x8c0 [nvmet]
 Code: e8 c6 12 63 e3 4c 89 6c 24 40 48 89 5c 24 08 4c 8b 3b 49 8d 9f 20 05 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 93 12 63 e3 4c 89 74 24 30 4c 8b 2b
 RSP: 0018:ffff88811ab378a0 EFLAGS: 00010202
 RAX: 00000000000000a4 RBX: 0000000000000520 RCX: dffffc0000000000
 RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffffa95d2d70
 RBP: ffff88811ab37ab0 R08: dffffc0000000000 R09: fffffbfff52ba5af
 R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff11023566f20
 R13: ffff888107db3260 R14: ffff888107db3270 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff88815a600000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000002394000 CR3: 000000011e5e8006 CR4: 0000000000370ee0
 Call Trace:
  <TASK>
  ? prepare_alloc_pages+0x1c5/0x580
  ? __cfi_nvmet_execute_disc_get_log_page+0x10/0x10 [nvmet f0c9e080f6cf521f454ee104d12dafd11a5a7613]
  ? __alloc_pages+0x30e/0x650
  ? slab_post_alloc_hook+0x67/0x350
  ? __cfi___alloc_pages+0x10/0x10
  ? alloc_pages+0x30e/0x530
  ? sgl_alloc_order+0x118/0x320
  nvmet_fc_queue_fcp_req+0xa19/0xda0 [nvmet_fc f192e753efa6aca39b2b3b72c07e648aac01348b]
  ? nvmet_fc_rcv_fcp_req+0x9c0/0x9c0 [nvmet_fc f192e753efa6aca39b2b3b72c07e648aac01348b]
  ? do_raw_spin_unlock+0x116/0x8a0
  ? nvmet_fc_rcv_fcp_req+0x4de/0x9c0 [nvmet_fc f192e753efa6aca39b2b3b72c07e648aac01348b]
  nvmet_fc_rcv_fcp_req+0x4f0/0x9c0 [nvmet_fc f192e753efa6aca39b2b3b72c07e648aac01348b]
  fcloop_fcp_recv_work+0x173/0x440 [nvme_fcloop dcecfb508887e13f93cf8f37ef42c0fab90cbd00]
  process_one_work+0x80f/0xfb0
  ? rescuer_thread+0x1130/0x1130
  ? do_raw_spin_trylock+0xc9/0x1f0
  ? lock_acquired+0x4a/0x9a0
  ? wq_worker_sleeping+0x1e/0x200
  worker_thread+0x91e/0x1260
  ? do_raw_spin_unlock+0x116/0x8a0
  kthread+0x25d/0x2f0
  ? __cfi_worker_thread+0x10/0x10
  ? __cfi_kthread+0x10/0x10
  ret_from_fork+0x29/0x50
  </TASK>
