Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AC475076E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjGLMEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjGLMEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:04:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB86F1BB;
        Wed, 12 Jul 2023 05:04:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3DBC71F8D9;
        Wed, 12 Jul 2023 12:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689163467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ap+QNitX+e6MRC8SQ0bLPNBwW2tubj8UT9M6bHBYlBE=;
        b=sYskPm0NVGFr+tC94pDyuO0YQW+kf2A1FjOWiGySDClmhS2TDp2oTjxktW07PFVUYXn+3G
        uRGQc9dTxxeZtR6gbsfnCsA81MgzF9eQCbf2cyloAeZWVTkdwn+AjkBEQD7tt39vnuRuRR
        0c5pqkmwnuyY2WF3i3R5TiKKYsgQFnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689163467;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ap+QNitX+e6MRC8SQ0bLPNBwW2tubj8UT9M6bHBYlBE=;
        b=tfddiOsQHVUnKCEwN68pfV54/o3yVGco7YmcZmVY/JGS04Wf9WLVUcuoyjXv3K8Xu5AXLM
        D0xpgUrv/W6Kt7BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E1DE133DD;
        Wed, 12 Jul 2023 12:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M7g7C8uWrmRZQQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 12 Jul 2023 12:04:27 +0000
Date:   Wed, 12 Jul 2023 14:04:26 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Message-ID: <eadl5bkyysdcymgy7ra4hm6cqn6ngcxbyvz2qzg3fdffsssnpo@d3rzegyurzn5>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <9c07e4f6-2cf5-b53b-6b48-bd4df8798ee9@nvidia.com>
 <bz2s6nyjwl6l7yfrd4wtjdtousv23ypcdleckibps5lyjpwi4x@wqq6qqesevpk>
 <39f9977e-b34c-f2dd-d356-8c78414a60d1@nvidia.com>
 <jdsoqllqmrqu5j5bt3fudkksmjskgs4ooodynm6yh3b4oc5scn@t3hydrmbb22f>
 <972a06e0-6841-043e-fc00-db7596f664c4@nvidia.com>
 <cskolyrp3s47gnn4nwtqpfxtafzhpirn3hv7ovhnnzpbb3ll2z@oum3v3n7go6l>
 <6dced1ba-c468-c88e-f861-9c202e803894@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dced1ba-c468-c88e-f861-9c202e803894@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 07:30:20PM +0300, Max Gurtovoy wrote:
> 
> 
> On 10/07/2023 18:03, Daniel Wagner wrote:
> > On Mon, Jul 10, 2023 at 03:31:23PM +0300, Max Gurtovoy wrote:
> > > I think it is more than just commit message.
> > 
> > Okay, starting to understand what's the problem.
> > 
> > > A lot of code that we can avoid was added regarding the --context cmdline
> > > argument.
> > 
> > Correct and it's not optional to get the tests passing for the fc transport.
> 
> why the fc needs the --context to pass tests ?

A typical nvme test consists out of following steps (nvme/004):

// nvme target setup (1)
	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}" \
		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"

// nvme host setup (2)
	_nvme_connect_subsys "${nvme_trtype}" blktests-subsystem-1

	local nvmedev
	nvmedev=$(_find_nvme_dev "blktests-subsystem-1")
	cat "/sys/block/${nvmedev}n1/uuid"
	cat "/sys/block/${nvmedev}n1/wwid"

// nvme host teardown (3)
	_nvme_disconnect_subsys blktests-subsystem-1

// nvme target teardown (4)
	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
	_remove_nvmet_subsystem "blktests-subsystem-1"


The corresponding output with --context

 run blktests nvme/004 at 2023-07-12 13:49:50
// (1)
 loop0: detected capacity change from 0 to 32768
 nvmet: adding nsid 1 to subsystem blktests-subsystem-1
 nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
 (NULL device *): {0:0} Association created
 [174] nvmet: ctrl 1 start keep-alive timer for 5 secs
// (2)
 nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
 [374] nvmet: adding queue 1 to ctrl 1.
 [1138] nvmet: adding queue 2 to ctrl 1.
 [73] nvmet: adding queue 3 to ctrl 1.
 [174] nvmet: adding queue 4 to ctrl 1.
 nvme nvme2: NVME-FC{0}: controller connect complete
 nvme nvme2: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1"
// (3)
 nvme nvme2: Removing ctrl: NQN "blktests-subsystem-1"
// (4)
 [1138] nvmet: ctrl 1 stop keep-alive
 (NULL device *): {0:0} Association deleted
 (NULL device *): {0:0} Association freed
 (NULL device *): Disconnect LS failed: No Association


and without --context

 run blktests nvme/004 at 2023-07-12 13:50:33
// (1)
 loop1: detected capacity change from 0 to 32768
 nvmet: adding nsid 1 to subsystem blktests-subsystem-1
 nvme nvme2: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
 (NULL device *): {0:0} Association created
 [1235] nvmet: ctrl 1 start keep-alive timer for 120 secs
// XXX udev auto connect
 nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8.
 nvme nvme2: NVME-FC{0}: controller connect complete
 nvme nvme2: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
 nvme nvme3: NVME-FC{1}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
 (NULL device *): {0:1} Association created
 [73] nvmet: ctrl 2 start keep-alive timer for 5 secs
// (2)
 nvmet: creating nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
 [374] nvmet: adding queue 1 to ctrl 2.
 [233] nvmet: adding queue 2 to ctrl 2.
 [73] nvmet: adding queue 3 to ctrl 2.
 [1235] nvmet: adding queue 4 to ctrl 2.
 nvme nvme3: NVME-FC{1}: controller connect complete
 nvme nvme3: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1"
// (3)
 nvme nvme3: Removing ctrl: NQN "blktests-subsystem-1"
 general protection fault, probably for non-canonical address 0xdffffc00000000a4: 0000 [#1] PREEMPT SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000520-0x0000000000000527]
 CPU: 1 PID: 2076 Comm: kworker/1:1 Tainted: G        W          6.4.0-rc2+ #7 f2a41a58e59b44ee1bb7bc68087ccbe6d76392dd
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown unknown
 Workqueue: nvmet-wq fcloop_fcp_recv_work [nvme_fcloop]
 RIP: 0010:nvmet_execute_disc_get_log_page+0x23f/0x8c0 [nvmet]
 Code: e8 c6 12 c7 e0 4c 89 6c 24 40 48 89 5c 24 08 4c 8b 3b 49 8d 9f 20 05 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 93 12 c7 e0 4c 89 74 24 30 4c 8b 2b
 RSP: 0018:ffff888139a778a0 EFLAGS: 00010202
 RAX: 00000000000000a4 RBX: 0000000000000520 RCX: dffffc0000000000
 RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffffa8af3a88
 RBP: ffff888139a77ab0 R08: dffffc0000000000 R09: fffffbfff515e752
 R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff1102734ef20
 R13: ffff888105563260 R14: ffff888105563270 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff88815a600000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000824220 CR3: 0000000106512005 CR4: 0000000000370ee0
 Call Trace:
  <TASK>
  ? prepare_alloc_pages+0x1c5/0x580
  ? __cfi_nvmet_execute_disc_get_log_page+0x10/0x10 [nvmet 1da13efcd047161c3381cb240a95399f951fd98f]
  ? __alloc_pages+0x30e/0x650
  ? slab_post_alloc_hook+0x67/0x350
  ? __cfi___alloc_pages+0x10/0x10
  ? alloc_pages+0x30e/0x530
  ? sgl_alloc_order+0x118/0x320
  nvmet_fc_queue_fcp_req+0xa19/0xda0 [nvmet_fc 11628cdb09a094fd591bfaf88be45b97e3b18e3a]
  ? nvmet_fc_rcv_fcp_req+0x9c0/0x9c0 [nvmet_fc 11628cdb09a094fd591bfaf88be45b97e3b18e3a]
  ? lockdep_hardirqs_on_prepare+0x2aa/0x5e0
  ? nvmet_fc_rcv_fcp_req+0x4de/0x9c0 [nvmet_fc 11628cdb09a094fd591bfaf88be45b97e3b18e3a]
  nvmet_fc_rcv_fcp_req+0x4f0/0x9c0 [nvmet_fc 11628cdb09a094fd591bfaf88be45b97e3b18e3a]
  fcloop_fcp_recv_work+0x173/0x440 [nvme_fcloop 05cf1144b564c4e1626f9f15422ccf61f2af41de]
  process_one_work+0x80f/0xfb0
  ? rescuer_thread+0x1130/0x1130
  ? do_raw_spin_trylock+0xc9/0x1f0
  ? lock_acquired+0x310/0x9a0
  ? worker_thread+0xd5e/0x1260
  worker_thread+0x91e/0x1260
  ? __cfi_lock_release+0x10/0x10
  ? do_raw_spin_unlock+0x116/0x8a0
  kthread+0x25d/0x2f0
  ? __cfi_worker_thread+0x10/0x10
  ? __cfi_kthread+0x10/0x10
  ret_from_fork+0x29/0x50
  </TASK>

> > > Maybe it's worth cleaning it..
> > 
> > It really solves the problem that the autoconnect setup of nvme-cli is
> > distrubing the tests (*). The only other way I found to stop the autoconnect is
> > by disabling the udev rule completely. If autoconnect isn't enabled the context
> > isn't necessary. Though changing system configuration from blktests seems at bit
> > excessive.
> 
> we should not stop any autoconnect during blktests. The autoconnect and all
> the system admin services should run normally.

I do not agree here. The current blktests are not designed for run as
intergration tests. Sure we should also tests this but currently blktests is
just not there and tcp/rdma are not actually covered anyway.

Thanks,
Daniel
