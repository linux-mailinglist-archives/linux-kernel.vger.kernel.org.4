Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC0B6AD5A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCGDXf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Mar 2023 22:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCGDXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:23:33 -0500
X-Greylist: delayed 326 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 19:23:31 PST
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05CC4C08;
        Mon,  6 Mar 2023 19:23:31 -0800 (PST)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 3755C1C521C;
        Tue,  7 Mar 2023 03:23:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 3361520029;
        Tue,  7 Mar 2023 03:23:24 +0000 (UTC)
Message-ID: <802731d7bf187573a9084cb23196c096be81b5e1.camel@perches.com>
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
Date:   Mon, 06 Mar 2023 19:23:23 -0800
In-Reply-To: <CAEXW_YRYnikDRTQXwrTpTsQ1r-32FRPABj_Viu+X6Qr7EWqh4g@mail.gmail.com>
References: <20230307030457.3499834-1-joel@joelfernandes.org>
         <753b72f5ecd03f94511495a333eb192c5fc42087.camel@perches.com>
         <CAEXW_YRYnikDRTQXwrTpTsQ1r-32FRPABj_Viu+X6Qr7EWqh4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 3361520029
X-Stat-Signature: dwdote97yxyhj594s6q1n864kpghm9kf
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18juX/JR6Jd6iQL8LhOemgwTWPbqJ2PXRE=
X-HE-Tag: 1678159404-83927
X-HE-Meta: U2FsdGVkX1/ciafKA+dxTQb6Q0YoF9ZfGA/qQzShCgMWlUt2nigBPA9vQ2xgIjQcHl/bLEGS9VJKgZim36jt4g==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-06 at 22:10 -0500, Joel Fernandes wrote:
> On Mon, Mar 6, 2023 at 10:08 PM Joe Perches <joe@perches.com> wrote:
> > 
> > On Tue, 2023-03-07 at 03:04 +0000, Joel Fernandes (Google) wrote:
> > > Single-argument kvfree_rcu() usage is being deprecated [1] [2] as it is
> > > error-prone. However, till all users are converted, we would like to introduce
> > > checkpatch errors for new patches submitted.
> > > 
> > > This patch adds support for the same. Tested with a trial patch.
> > > 
> > > For now, we are only considering usages that don't have compound
> > > nesting, for example ignore: kvfree_rcu( (rcu_head_obj), rcu_head_name).
> > > This is sufficient as such usages are unlikely.
> > > 
> > > Once all users are converted and we remove the old API, we can also revert this
> > > checkpatch patch then.
> > 
> > I think this should be added to the deprecated_apis hash instead
> > 
> > our %deprecated_apis = (
> >         "synchronize_rcu_bh"                    => "synchronize_rcu",
> >         "synchronize_rcu_bh_expedited"          => "synchronize_rcu_expedited",
> >         "call_rcu_bh"                           => "call_rcu",
> >         "rcu_barrier_bh"                        => "rcu_barrier",
> >         "synchronize_sched"                     => "synchronize_rcu",
> >         "synchronize_sched_expedited"           => "synchronize_rcu_expedited",
> >         "call_rcu_sched"                        => "call_rcu",
> >         "rcu_barrier_sched"                     => "rcu_barrier",
> >         "get_state_synchronize_sched"           => "get_state_synchronize_rcu",
> >         "cond_synchronize_sched"                => "cond_synchronize_rcu",
> >         "kmap"                                  => "kmap_local_page",
> >         "kunmap"                                => "kunmap_local",
> >         "kmap_atomic"                           => "kmap_local_page",
> >         "kunmap_atomic"                         => "kunmap_local",
> > );
> 
> This is not an API name change though, it is a "number of arguments"
> or argument list change. Is there a different way to do it?

Ah, no, not really.

btw: I don't see a single use of this call without a comma in the tree.

