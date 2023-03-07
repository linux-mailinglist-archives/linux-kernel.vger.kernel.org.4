Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ACC6AD692
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCGExc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Mar 2023 23:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCGExa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:53:30 -0500
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018CD298EA;
        Mon,  6 Mar 2023 20:53:28 -0800 (PST)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 814D8A84B8;
        Tue,  7 Mar 2023 04:53:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id A823120029;
        Tue,  7 Mar 2023 04:53:21 +0000 (UTC)
Message-ID: <497c07579fb51ed6f0b8a72471017b4dec258e9e.camel@perches.com>
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
Date:   Mon, 06 Mar 2023 20:53:20 -0800
In-Reply-To: <20230307044104.GA3532764@google.com>
References: <20230307030457.3499834-1-joel@joelfernandes.org>
         <753b72f5ecd03f94511495a333eb192c5fc42087.camel@perches.com>
         <CAEXW_YRYnikDRTQXwrTpTsQ1r-32FRPABj_Viu+X6Qr7EWqh4g@mail.gmail.com>
         <802731d7bf187573a9084cb23196c096be81b5e1.camel@perches.com>
         <20230307044104.GA3532764@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: A823120029
X-Stat-Signature: z43jerggxb78akyou4zor71yes7cykjj
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+HsV7Szsdkqy4jPajx8bHmTNRLkp0MMJM=
X-HE-Tag: 1678164801-754252
X-HE-Meta: U2FsdGVkX19Qa4xs5zLgtyRpUQgVhfDs78AKgrNx32VElAnc+uGKDGfcGhHaulgeR0Ae31s3dvWZ9G28Mv7ezA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-07 at 04:41 +0000, Joel Fernandes wrote:
> On Mon, Mar 06, 2023 at 07:23:23PM -0800, Joe Perches wrote:
> > On Mon, 2023-03-06 at 22:10 -0500, Joel Fernandes wrote:
> > > On Mon, Mar 6, 2023 at 10:08 PM Joe Perches <joe@perches.com> wrote:
> > > > 
> > > > On Tue, 2023-03-07 at 03:04 +0000, Joel Fernandes (Google) wrote:
> > > > > Single-argument kvfree_rcu() usage is being deprecated [1] [2] as it is
> > > > > error-prone. However, till all users are converted, we would like to introduce
> > > > > checkpatch errors for new patches submitted.
> > > > > 
> > > > > This patch adds support for the same. Tested with a trial patch.
> > > > > 
> > > > > For now, we are only considering usages that don't have compound
> > > > > nesting, for example ignore: kvfree_rcu( (rcu_head_obj), rcu_head_name).
> > > > > This is sufficient as such usages are unlikely.
> > > > > 
> > > > > Once all users are converted and we remove the old API, we can also revert this
> > > > > checkpatch patch then.
> > > > 
> > > > I think this should be added to the deprecated_apis hash instead
> > > > 
> > > > our %deprecated_apis = (
> > > >         "synchronize_rcu_bh"                    => "synchronize_rcu",
> > > >         "synchronize_rcu_bh_expedited"          => "synchronize_rcu_expedited",
> > > >         "call_rcu_bh"                           => "call_rcu",
> > > >         "rcu_barrier_bh"                        => "rcu_barrier",
> > > >         "synchronize_sched"                     => "synchronize_rcu",
> > > >         "synchronize_sched_expedited"           => "synchronize_rcu_expedited",
> > > >         "call_rcu_sched"                        => "call_rcu",
> > > >         "rcu_barrier_sched"                     => "rcu_barrier",
> > > >         "get_state_synchronize_sched"           => "get_state_synchronize_rcu",
> > > >         "cond_synchronize_sched"                => "cond_synchronize_rcu",
> > > >         "kmap"                                  => "kmap_local_page",
> > > >         "kunmap"                                => "kunmap_local",
> > > >         "kmap_atomic"                           => "kmap_local_page",
> > > >         "kunmap_atomic"                         => "kunmap_local",
> > > > );
> > > 
> > > This is not an API name change though, it is a "number of arguments"
> > > or argument list change. Is there a different way to do it?
> > 
> > Ah, no, not really.
> > 
> > btw: I don't see a single use of this call without a comma in the tree.
> 
> Did you look for kvfree_rcu? It is either kvfree_rcu() or kfree_rcu().

$ git grep -P '\bkv?free_rcu\s*\(' -- '*.[ch]' | grep -v -P 'kv?free_rcu\s*\([^,]+,.*\)'
drivers/infiniband/core/device.c:		kfree_rcu(container_of(dev->port_data, struct ib_port_data_rcu,
drivers/infiniband/core/rdma_core.c:	 * kfree_rcu(). However the object may still have been released and
drivers/target/target_core_configfs.c:			 * callbacks to complete post kfree_rcu(), before allowing
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
net/core/pktgen.c:	/* Don't need rcu_barrier() due to use of kfree_rcu() */

