Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7D46AD6BD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCGFWq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Mar 2023 00:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCGFW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:22:29 -0500
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CE5567BF;
        Mon,  6 Mar 2023 21:22:25 -0800 (PST)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 08FCC1C4A58;
        Tue,  7 Mar 2023 05:22:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 0FFBA8000E;
        Tue,  7 Mar 2023 05:22:17 +0000 (UTC)
Message-ID: <912474d3804791ef5757a44bae6ab72701e15bc3.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Error out if deprecated RCU API used
From:   Joe Perches <joe@perches.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        Uladzislau Rezki <urezki@gmail.com>
Date:   Mon, 06 Mar 2023 21:22:17 -0800
In-Reply-To: <CAEXW_YQt976k6tRJBoYy=S-CpacgB+MpMr-H=TEtZBaP=CPwnQ@mail.gmail.com>
References: <20230307030457.3499834-1-joel@joelfernandes.org>
         <753b72f5ecd03f94511495a333eb192c5fc42087.camel@perches.com>
         <CAEXW_YRYnikDRTQXwrTpTsQ1r-32FRPABj_Viu+X6Qr7EWqh4g@mail.gmail.com>
         <802731d7bf187573a9084cb23196c096be81b5e1.camel@perches.com>
         <20230307044104.GA3532764@google.com>
         <497c07579fb51ed6f0b8a72471017b4dec258e9e.camel@perches.com>
         <CAEXW_YQt976k6tRJBoYy=S-CpacgB+MpMr-H=TEtZBaP=CPwnQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0FFBA8000E
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: j3t64s8w1tou5tg9qaksxwzr8a6kry5o
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18dD60VU4TcNc6X9YoMwW5z72oj27v1Oz0=
X-HE-Tag: 1678166537-328782
X-HE-Meta: U2FsdGVkX19SZ/s76yRrDn7PMrAGvf7jxoeLgQRwVGYu61ycYnAdDJmb0sMqW1jyhvKEnGE12joQbhDTkgjdZg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-07 at 00:11 -0500, Joel Fernandes wrote:

> Do you mind sharing which tree you are looking at? I checked both
> 6.3-rc1 and linux-next.
> 
> Your grep returned:
> 
> kernel/trace/trace_osnoise.c:   kvfree_rcu(inst);
> kernel/trace/trace_probe.c:     kvfree_rcu(link);
> lib/test_vmalloc.c:             kvfree_rcu(p);
> mm/list_lru.c:   * We need kvfree_rcu() here. And the walking of the list
> net/core/pktgen.c:      /* Don't need rcu_barrier() due to use of kfree_rcu() */
> net/core/sysctl_net_core.c:
> kvfree_rcu(orig_sock_table);
> net/core/sysctl_net_core.c:                             kfree_rcu(cur);
> net/mac802154/scan.c:   kfree_rcu(request);
> net/mac802154/scan.c:   kfree_rcu(request);

rather old.  I'm not subscribed and haven't been following much.

Add linux-next specific files for 20230217

Updating to today's next:

Add linux-next specific files for 20230307

I get several instances:

$ git grep -P '\bkv?free_rcu\s*\(' -- '*.[ch]' | grep -v -P 'kv?free_rcu\s*\([^,]+,.*\)'
drivers/block/drbd/drbd_nl.c:	kvfree_rcu(old_disk_conf);
drivers/block/drbd/drbd_nl.c:	kvfree_rcu(old_net_conf);
drivers/block/drbd/drbd_nl.c:		kvfree_rcu(old_disk_conf);
drivers/block/drbd/drbd_receiver.c:	kvfree_rcu(old_net_conf);
drivers/block/drbd/drbd_receiver.c:			kvfree_rcu(old_disk_conf);
drivers/block/drbd/drbd_state.c:		kvfree_rcu(old_conf);
drivers/infiniband/core/device.c:		kfree_rcu(container_of(dev->port_data, struct ib_port_data_rcu,
drivers/infiniband/core/rdma_core.c:	 * kfree_rcu(). However the object may still have been released and
drivers/infiniband/sw/rxe/rxe_mr.c:	kfree_rcu(mr);
drivers/misc/vmw_vmci/vmci_context.c:		kvfree_rcu(notifier);
drivers/misc/vmw_vmci/vmci_event.c:	kvfree_rcu(s);
drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c:	kfree_rcu(int_port);
drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c:	kfree_rcu(tx_sa);
drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c:	kfree_rcu(rx_sc);
drivers/target/target_core_configfs.c:			 * callbacks to complete post kfree_rcu(), before allowing
fs/ext4/super.c:				kfree_rcu(qname);
include/linux/rcupdate.h: *     kvfree_rcu(ptr);
include/linux/rcupdate.h:#define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_ARGS__,		\
include/linux/rcutiny.h:	// kvfree_rcu(one_arg) call.
include/rdma/ib_verbs.h:	struct rcu_head		rcu;		/* kfree_rcu() overhead */
include/scsi/scsi_device.h: * @rcu: For kfree_rcu().
kernel/rcu/rcuscale.c:		pr_alert("CONFIG_RCU_LAZY is disabled, falling back to kfree_rcu() for delayed RCU kfree'ing\n");
kernel/rcu/tree.c: * struct kvfree_rcu_bulk_data - single block to store kvfree_rcu() pointers
kernel/rcu/tree.c: * @records: Array of the kvfree_rcu() pointers
kernel/rcu/tree.c: * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
kernel/rcu/tree.c: * @head_free: List of kfree_rcu() objects waiting for a grace period
kernel/rcu/tree.c: * @bulk_head_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
kernel/rcu/tree.c: * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
kernel/rcu/tree.c: * @head: List of kfree_rcu() objects not yet waiting for a grace period
kernel/rcu/tree.c: * @bulk_head: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
kernel/rcu/tree.c: * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
kernel/rcu/tree.c:	 * double-argument of kvfree_rcu().  This happens when the
kernel/rcu/tree.c: * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
kernel/rcu/tree.c:		// Probable double kfree_rcu(), just leak.
kernel/trace/trace_osnoise.c:	kvfree_rcu(inst);
kernel/trace/trace_probe.c:	kvfree_rcu(link);
net/core/pktgen.c:	/* Don't need rcu_barrier() due to use of kfree_rcu() */
net/core/sysctl_net_core.c:				kvfree_rcu(orig_sock_table);
net/core/sysctl_net_core.c:				kfree_rcu(cur);

