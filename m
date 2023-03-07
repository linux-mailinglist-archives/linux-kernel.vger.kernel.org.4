Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAF86AD6B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCGFLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjCGFLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:11:37 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE41567A5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 21:11:34 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id r27so15589190lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 21:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678165892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciKmOSJZqDuKZvgr9ceYGQTfxQjjQPGSAx7cECZjTfE=;
        b=DV80ICr6A37Pmft3psmmxyD9upkJ+xXbbgIqAO6JtifUoTYpYno5aPf4fx4VuYH60i
         LKIdBfWdgjFKpoYkdBjzeUvw0Sy9929c51Yh/c5+Cv+eBWAiP1WaK+odpj6dlRU/hS02
         NVi96EG9WbtDg/+CS6DIZnfkqTrGQMagWlLWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678165892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciKmOSJZqDuKZvgr9ceYGQTfxQjjQPGSAx7cECZjTfE=;
        b=NQg9sJNDVMsh1mYgn9e9uv+qns1qTgWgWEJqZqmSrGihdnzP3pAH4tOKZ//tGAGPLn
         WaNoqGTlbIcuEpl5KBwhkpKHnXnPz3pzYHrnW34NmHb9IGI/HLqHQHn0QY5c8qo/p0Jl
         OVsmRZZU0bNQcNidTs6oskK+P9v3X7C5cozG1rdeXyat84T2ncTpCHgZ/7p9PQ7xP6K7
         Gx1yDHsgmutPEyx4YOndBaI5pJMO2P9F4qKstjxO9HOe/CCF8lhDfAuYSClSwQPlL64R
         A+4Uzd425Ao1CxP4wXmpLHVDbzhYJuLS4HjCNXEGq2cIj6hl6d4k1OIMrn0hhT1pU9hq
         Pk3Q==
X-Gm-Message-State: AO0yUKXtZzWLR4cjQUl0VXZHc8Zp+pabzzrz6vnnYqqwaVdf7WYmlHIk
        qj+J8vbvynqKSaVzeVWdPWk6XyFhB3r9H6Wyc/dImQ==
X-Google-Smtp-Source: AK7set+x4pGBpQtZSzewoBFzZHpTCsSoM+foYjC6/2kfqcZIpxLXt+M1wNgynlswpNvWuaueDTE0Lqu4diZFlp0EL7c=
X-Received: by 2002:a19:750b:0:b0:4de:6514:2ee4 with SMTP id
 y11-20020a19750b000000b004de65142ee4mr3957772lfe.11.1678165892149; Mon, 06
 Mar 2023 21:11:32 -0800 (PST)
MIME-Version: 1.0
References: <20230307030457.3499834-1-joel@joelfernandes.org>
 <753b72f5ecd03f94511495a333eb192c5fc42087.camel@perches.com>
 <CAEXW_YRYnikDRTQXwrTpTsQ1r-32FRPABj_Viu+X6Qr7EWqh4g@mail.gmail.com>
 <802731d7bf187573a9084cb23196c096be81b5e1.camel@perches.com>
 <20230307044104.GA3532764@google.com> <497c07579fb51ed6f0b8a72471017b4dec258e9e.camel@perches.com>
In-Reply-To: <497c07579fb51ed6f0b8a72471017b4dec258e9e.camel@perches.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 7 Mar 2023 00:11:20 -0500
Message-ID: <CAEXW_YQt976k6tRJBoYy=S-CpacgB+MpMr-H=TEtZBaP=CPwnQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Error out if deprecated RCU API used
To:     Joe Perches <joe@perches.com>
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
        "Theodore Ts'o" <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 11:53=E2=80=AFPM Joe Perches <joe@perches.com> wrote=
:
>
> On Tue, 2023-03-07 at 04:41 +0000, Joel Fernandes wrote:
> > On Mon, Mar 06, 2023 at 07:23:23PM -0800, Joe Perches wrote:
> > > On Mon, 2023-03-06 at 22:10 -0500, Joel Fernandes wrote:
> > > > On Mon, Mar 6, 2023 at 10:08=E2=80=AFPM Joe Perches <joe@perches.co=
m> wrote:
> > > > >
> > > > > On Tue, 2023-03-07 at 03:04 +0000, Joel Fernandes (Google) wrote:
> > > > > > Single-argument kvfree_rcu() usage is being deprecated [1] [2] =
as it is
> > > > > > error-prone. However, till all users are converted, we would li=
ke to introduce
> > > > > > checkpatch errors for new patches submitted.
> > > > > >
> > > > > > This patch adds support for the same. Tested with a trial patch=
.
> > > > > >
> > > > > > For now, we are only considering usages that don't have compoun=
d
> > > > > > nesting, for example ignore: kvfree_rcu( (rcu_head_obj), rcu_he=
ad_name).
> > > > > > This is sufficient as such usages are unlikely.
> > > > > >
> > > > > > Once all users are converted and we remove the old API, we can =
also revert this
> > > > > > checkpatch patch then.
> > > > >
> > > > > I think this should be added to the deprecated_apis hash instead
> > > > >
> > > > > our %deprecated_apis =3D (
> > > > >         "synchronize_rcu_bh"                    =3D> "synchronize=
_rcu",
> > > > >         "synchronize_rcu_bh_expedited"          =3D> "synchronize=
_rcu_expedited",
> > > > >         "call_rcu_bh"                           =3D> "call_rcu",
> > > > >         "rcu_barrier_bh"                        =3D> "rcu_barrier=
",
> > > > >         "synchronize_sched"                     =3D> "synchronize=
_rcu",
> > > > >         "synchronize_sched_expedited"           =3D> "synchronize=
_rcu_expedited",
> > > > >         "call_rcu_sched"                        =3D> "call_rcu",
> > > > >         "rcu_barrier_sched"                     =3D> "rcu_barrier=
",
> > > > >         "get_state_synchronize_sched"           =3D> "get_state_s=
ynchronize_rcu",
> > > > >         "cond_synchronize_sched"                =3D> "cond_synchr=
onize_rcu",
> > > > >         "kmap"                                  =3D> "kmap_local_=
page",
> > > > >         "kunmap"                                =3D> "kunmap_loca=
l",
> > > > >         "kmap_atomic"                           =3D> "kmap_local_=
page",
> > > > >         "kunmap_atomic"                         =3D> "kunmap_loca=
l",
> > > > > );
> > > >
> > > > This is not an API name change though, it is a "number of arguments=
"
> > > > or argument list change. Is there a different way to do it?
> > >
> > > Ah, no, not really.
> > >
> > > btw: I don't see a single use of this call without a comma in the tre=
e.
> >
> > Did you look for kvfree_rcu? It is either kvfree_rcu() or kfree_rcu().
>
> $ git grep -P '\bkv?free_rcu\s*\(' -- '*.[ch]' | grep -v -P 'kv?free_rcu\=
s*\([^,]+,.*\)'
> drivers/infiniband/core/device.c:               kfree_rcu(container_of(de=
v->port_data, struct ib_port_data_rcu,
> drivers/infiniband/core/rdma_core.c:     * kfree_rcu(). However the objec=
t may still have been released and
> drivers/target/target_core_configfs.c:                   * callbacks to c=
omplete post kfree_rcu(), before allowing
> include/linux/rcupdate.h: *     kvfree_rcu(ptr);
> include/linux/rcupdate.h:#define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_AR=
GS__,          \
> include/linux/rcutiny.h:        // kvfree_rcu(one_arg) call.
> include/rdma/ib_verbs.h:        struct rcu_head         rcu;            /=
* kfree_rcu() overhead */
> include/scsi/scsi_device.h: * @rcu: For kfree_rcu().
> kernel/rcu/rcuscale.c:          pr_alert("CONFIG_RCU_LAZY is disabled, fa=
lling back to kfree_rcu() for delayed RCU kfree'ing\n");
> kernel/rcu/tree.c: * struct kvfree_rcu_bulk_data - single block to store =
kvfree_rcu() pointers
> kernel/rcu/tree.c: * @records: Array of the kvfree_rcu() pointers
> kernel/rcu/tree.c: * struct kfree_rcu_cpu_work - single batch of kfree_rc=
u() requests
> kernel/rcu/tree.c: * @head_free: List of kfree_rcu() objects waiting for =
a grace period
> kernel/rcu/tree.c: * @bulk_head_free: Bulk-List of kvfree_rcu() objects w=
aiting for a grace period
> kernel/rcu/tree.c: * struct kfree_rcu_cpu - batch up kfree_rcu() requests=
 for RCU grace period
> kernel/rcu/tree.c: * @head: List of kfree_rcu() objects not yet waiting f=
or a grace period
> kernel/rcu/tree.c: * @bulk_head: Bulk-List of kvfree_rcu() objects not ye=
t waiting for a grace period
> kernel/rcu/tree.c: * @krw_arr: Array of batches of kfree_rcu() objects wa=
iting for a grace period
> kernel/rcu/tree.c:       * double-argument of kvfree_rcu().  This happens=
 when the
> kernel/rcu/tree.c: * reduce the number of grace periods during heavy kfre=
e_rcu()/kvfree_rcu() load.
> kernel/rcu/tree.c:              // Probable double kfree_rcu(), just leak=
.
> net/core/pktgen.c:      /* Don't need rcu_barrier() due to use of kfree_r=
cu() */
>

Do you mind sharing which tree you are looking at? I checked both
6.3-rc1 and linux-next.

Your grep returned:

kernel/trace/trace_osnoise.c:   kvfree_rcu(inst);
kernel/trace/trace_probe.c:     kvfree_rcu(link);
lib/test_vmalloc.c:             kvfree_rcu(p);
mm/list_lru.c:   * We need kvfree_rcu() here. And the walking of the list
net/core/pktgen.c:      /* Don't need rcu_barrier() due to use of kfree_rcu=
() */
net/core/sysctl_net_core.c:
kvfree_rcu(orig_sock_table);
net/core/sysctl_net_core.c:                             kfree_rcu(cur);
net/mac802154/scan.c:   kfree_rcu(request);
net/mac802154/scan.c:   kfree_rcu(request);
