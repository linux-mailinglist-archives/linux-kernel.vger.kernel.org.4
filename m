Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52F86278ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiKNJW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbiKNJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:22:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6056D15704
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:22:54 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p21so9522613plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eVNw2mPbfqBEOy/HCY6VcrsdwOvpz9Ffl1CPRifap0g=;
        b=O1IrDD1zxS5hQJ/v9uBJ9862+2HarsFwIsB0rqaY0B5HS12CpQtDe2Di6/j9/H136N
         /CpSzn+HaTrDMUhBtwD/fWLhUkJBbkUtw5ajCrlnB1Nv/ICZosYYvWHZD/Owjr8bMivn
         DCRercGA79frTX26k2uxISLTeVYXQMZ0gxfsaCSB+2TkNleGUashUxfNKVGlVN4N1fUh
         o+aDN6L8kXZbU76xlChuhNNSrYlCv/4fE9bBF9c3dfEwoVpLlyVk+3Lt+9+wiJXJrqjt
         cfBn8fZjSP09y0nNXu58RsXHt/GAMQ0pHlHJVjeNyfaPX/jTdyRkCsDUYFbx122Zob4v
         EAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVNw2mPbfqBEOy/HCY6VcrsdwOvpz9Ffl1CPRifap0g=;
        b=C8wQDIvn+XAzkUvnQQT7iL1CtoxzaHVluQQL/XEa8CH+ezdjHeJp/jAtwSR25I9rXg
         Bda+PjpvqMIzhylxSDQqWlUrYr/ISrD4CuoYcT6FnOpCHYta17WQENh5zqWcpm4PbRjM
         hlCKhqKb25RlgZhHnzAiHUffkb1EfO80w6nD1UqmWHs1rhoidMV9LklaJWVAphFY0Q2i
         lfxklqCfcR0h8kOowo9WAjCmOMH55wtM+Vb9O+41fijgwefwdIkbMO+BLrXlsk/MroHq
         bK7Q/+MqLULZvuCAvTGWH8jZJTkJzR3a2/qJSoAWtkj40BcjE/MBsL5ZhZTq2YUQGRoR
         2Esw==
X-Gm-Message-State: ANoB5plW3AYRGX2y9zhdnSTkZlkXUpv5+8UALxvaJUrCRqZzienAMi/K
        m/KbhafAFAGQv0brdmrzErI=
X-Google-Smtp-Source: AA0mqf4oDz4M/tfZJ7decIw6P/l4Nm6FsUZaavDiELHKXy28G5KPc+JQTxPnRQ97SgBv5ilfWci18g==
X-Received: by 2002:a17:90a:d808:b0:213:9c67:1b09 with SMTP id a8-20020a17090ad80800b002139c671b09mr12657149pjv.221.1668417773326;
        Mon, 14 Nov 2022 01:22:53 -0800 (PST)
Received: from debian.me (subs28-116-206-12-49.three.co.id. [116.206.12.49])
        by smtp.gmail.com with ESMTPSA id ch16-20020a17090af41000b00210125b789dsm6000972pjb.54.2022.11.14.01.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 01:22:52 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 52C91103ED3; Mon, 14 Nov 2022 16:22:47 +0700 (WIB)
Date:   Mon, 14 Nov 2022 16:22:47 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Paul Bone <pbone@mozilla.com>
Subject: Re: [PATCH] Documentation: sched: Add a new sched-util-clamp.rst
Message-ID: <Y3II59dyKuvQGIhG@debian.me>
References: <20221105232343.887199-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GLa0IuTWsGzJ3iko"
Content-Disposition: inline
In-Reply-To: <20221105232343.887199-1-qyousef@layalina.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GLa0IuTWsGzJ3iko
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 05, 2022 at 11:23:43PM +0000, Qais Yousef wrote:
> +2.  DESIGN:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Why ALLCAPS and trailing colon for section title?

> +When a task is attached to a CPU controller, its uclamp values will be i=
mpacted
> +as follows:
> +
> +* cpu.uclamp.min is a protection as described in section 3-3 in
> +  Documentation/admin-guide/cgroup-v2.rst.
> <snipped>...
> +* cpu.uclamp.max is a limit as described in section 3-2 in
> +  Documentation/admin-guide/cgroup-v2.rst.
> +

Exactly what section on cgroup doc do you refer? I don't see any section
number there. Did you mean this?:

---- >8 ----

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-=
guide/cgroup-v2.rst
index dc254a3cb95686..fd448069c11562 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -619,6 +619,8 @@ process migrations.
 and is an example of this type.
=20
=20
+.. _cgroupv2-limits-distributor:
+
 Limits
 ------
=20
@@ -635,6 +637,7 @@ process migrations.
 "io.max" limits the maximum BPS and/or IOPS that a cgroup can consume
 on an IO device and is an example of this type.
=20
+.. _cgroupv2-protections-distributor:
=20
 Protections
 -----------
diff --git a/Documentation/scheduler/sched-util-clamp.rst b/Documentation/s=
cheduler/sched-util-clamp.rst
index 6601bda176d16e..5741acb35b7db2 100644
--- a/Documentation/scheduler/sched-util-clamp.rst
+++ b/Documentation/scheduler/sched-util-clamp.rst
@@ -364,8 +364,8 @@ There are two uclamp related values in the CPU cgroup c=
ontroller:
 When a task is attached to a CPU controller, its uclamp values will be imp=
acted
 as follows:
=20
-* cpu.uclamp.min is a protection as described in section 3-3 in
-  Documentation/admin-guide/cgroup-v2.rst.
+* cpu.uclamp.min is a protection as described in :ref:`section 3-3 of cgro=
up
+  v2 documentation <cgroupv2-protections-distributor>`.
=20
   If a task uclamp_min value is lower than cpu.uclamp.min, then the task w=
ill
   inherit the cgroup cpu.uclamp.min value.
@@ -373,8 +373,8 @@ as follows:
   In a cgroup hierarchy, effective cpu.uclamp.min is the max of (child,
   parent).
=20
-* cpu.uclamp.max is a limit as described in section 3-2 in
-  Documentation/admin-guide/cgroup-v2.rst.
+* cpu.uclamp.max is a limit as described in :ref:`section 3-2 of cgroup v2
+  documentation <cgroupv2-limits-distributor>`.
=20
   If a task uclamp_max value is higher than cpu.uclamp.max, then the task =
will
   inherit the cgroup cpu.uclamp.max value.


IMO, the doc wording can be improved (applied on top of your fixup [1]):

---- >8 ----

diff --git a/Documentation/scheduler/sched-util-clamp.rst b/Documentation/s=
cheduler/sched-util-clamp.rst
index 728ffa364fc7ad..6601bda176d16e 100644
--- a/Documentation/scheduler/sched-util-clamp.rst
+++ b/Documentation/scheduler/sched-util-clamp.rst
@@ -2,31 +2,29 @@
 Utilization Clamping
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-1.  INTRODUCTION
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+1. Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Utilization clamping is a scheduler feature that allows user space to help=
 in
-managing the performance requirement of tasks. It was introduced in v5.3
-release. The CGroup support was merged in v5.4.
-
-It is often referred to as util clamp and uclamp. You'll find all variatio=
ns
-used interchangeably in this documentation and in the source code.
+Utilization clamping, also known as util clamp or uclamp, is a scheduler
+feature that allows user space to help in managing the performance require=
ment
+of tasks. It was introduced in v5.3 release. The CGroup support was merged=
 in
+v5.4.
=20
 Uclamp is a hinting mechanism that allows the scheduler to understand the
-performance requirements and restrictions of the tasks. Hence help it make
-a better placement decision. And when schedutil cpufreq governor is used, =
util
-clamp will influence the frequency selection as well.
+performance requirements and restrictions of the tasks, thus it helps the
+scheduler to make a better decision. And when schedutil cpufreq governor is
+used, util clamp will influence the frequency selection as well.
=20
 Since scheduler and schedutil are both driven by PELT (util_avg) signals, =
util
 clamp acts on that to achieve its goal by clamping the signal to a certain
-point; hence the name. I.e: by clamping utilization we are making the syst=
em
-run at a certain performance point.
+point; hence the name. That is, by clamping utilization we are making the
+system run at a certain performance point.
=20
-The right way to view util clamp is as a mechanism to make performance
-constraints request/hint. It consists of two components:
+The right way to view util clamp is as a mechanism to make request or hint=
 on
+performance constraints. It consists of two tunables:
=20
-        * UCLAMP_MIN, which sets a lower bound.
-        * UCLAMP_MAX, which sets an upper bound.
+        * UCLAMP_MIN, which sets the lower bound.
+        * UCLAMP_MAX, which sets the upper bound.
=20
 These two bounds will ensure a task will operate within this performance r=
ange
 of the system. UCLAMP_MIN implies boosting a task, while UCLAMP_MAX implies
@@ -35,18 +33,18 @@ capping a task.
 One can tell the system (scheduler) that some tasks require a minimum
 performance point to operate at to deliver the desired user experience. Or=
 one
 can tell the system that some tasks should be restricted from consuming too
-much resources and should NOT go above a specific performance point. Viewi=
ng
+much resources and should not go above a specific performance point. Viewi=
ng
 the uclamp values as performance points rather than utilization is a better
 abstraction from user space point of view.
=20
 As an example, a game can use util clamp to form a feedback loop with its
 perceived FPS. It can dynamically increase the minimum performance point
 required by its display pipeline to ensure no frame is dropped. It can also
-dynamically 'prime' up these tasks if it knows in the coming few 100ms
-a computationally intensive scene is about to happen.
+dynamically 'prime' up these tasks if it knows in the coming few hundred
+milliseconds a computationally intensive scene is about to happen.
=20
 On mobile hardware where the capability of the devices varies a lot, this
-dynamic feedback loop offers a great flexibility in ensuring best user
+dynamic feedback loop offers a great flexibility to ensure best user
 experience given the capabilities of any system.
=20
 Of course a static configuration is possible too. The exact usage will dep=
end
@@ -68,17 +66,17 @@ stay on the little cores which will ensure that:
            are CPU intensive tasks.
=20
 By making these uclamp performance requests, or rather hints, user space c=
an
-ensure system resources are used optimally to deliver the best user experi=
ence
-the system is capable of.
+ensure system resources are used optimally to deliver the best possible us=
er
+experience.
=20
 Another use case is to help with overcoming the ramp up latency inherit in=
 how
 scheduler utilization signal is calculated.
=20
-A busy task for instance that requires to run at maximum performance point=
 will
-suffer a delay of ~200ms (PELT HALFIFE =3D 32ms) for the scheduler to real=
ize
-that. This is known to affect workloads like gaming on mobile devices where
-frames will drop due to slow response time to select the higher frequency
-required for the tasks to finish their work in time.
+On the other hand, a busy task for instance that requires to run at maximum
+performance point will suffer a delay of ~200ms (PELT HALFIFE =3D 32ms) fo=
r the
+scheduler to realize that. This is known to affect workloads like gaming on
+mobile devices where frames will drop due to slow response time to select =
the
+higher frequency required for the tasks to finish their work in time.
=20
 The overall visible effect goes beyond better perceived user
 experience/performance and stretches to help achieve a better overall
@@ -101,11 +99,12 @@ when an RT task wakes up. This cost is unchanged by us=
ing uclamp. Uclamp only
 helps picking what frequency to request instead of schedutil always reques=
ting
 MAX for all RT tasks.
=20
-See section 3.4 for default values and 3.4.1 on how to change RT tasks def=
ault
-value.
+See :ref:`section 3.4 <uclamp-default-values>` for default values and
+:ref:`3.4.1 <sched-util-clamp-min-rt-default>` on how to change RT tasks
+default value.
=20
-2.  DESIGN:
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+2. Design
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Util clamp is a property of every task in the system. It sets the boundari=
es of
 its utilization signal; acting as a bias mechanism that influences certain
@@ -123,10 +122,10 @@ which have implications on the utilization value at r=
q level, which brings us
 to the main design challenge.
=20
 When a task wakes up on an rq, the utilization signal of the rq will be
-impacted by the uclamp settings of all the tasks enqueued on it. For examp=
le if
+affected by the uclamp settings of all the tasks enqueued on it. For examp=
le if
 a task requests to run at UTIL_MIN =3D 512, then the util signal of the rq=
 needs
-to respect this request as well as all other requests from all of the enqu=
eued
-tasks.
+to respect to this request as well as all other requests from all of the
+enqueued tasks.
=20
 To be able to aggregate the util clamp value of all the tasks attached to =
the
 rq, uclamp must do some housekeeping at every enqueue/dequeue, which is the
@@ -138,19 +137,21 @@ The way this is handled is by dividing the utilizatio=
n range into buckets
 (struct uclamp_bucket) which allows us to reduce the search space from eve=
ry
 task on the rq to only a subset of tasks on the top-most bucket.
=20
-When a task is enqueued, we increment a counter in the matching bucket. An=
d on
-dequeue we decrement it. This makes keeping track of the effective uclamp =
value
-at rq level a lot easier.
+When a task is enqueued, the counter in the matching bucket is incremented,
+and on dequeue it is decremented. This makes keeping track of the effective
+uclamp value at rq level a lot easier.
=20
-As we enqueue and dequeue tasks we keep track of the current effective ucl=
amp
-value of the rq. See section 2.1 for details on how this works.
+As tasks are enqueued and dequeued, we keep track of the current effective
+uclamp value of the rq. See :ref:`section 2.1 <uclamp-buckets>` for detail=
s on
+how this works.
=20
 Later at any path that wants to identify the effective uclamp value of the=
 rq,
 it will simply need to read this effective uclamp value of the rq at that =
exact
 moment of time it needs to take a decision.
=20
 For task placement case, only Energy Aware and Capacity Aware Scheduling
-(EAS/CAS) make use of uclamp for now. This implies heterogeneous systems o=
nly.
+(EAS/CAS) make use of uclamp for now, which implies that it is applied on
+heterogeneous systems only.
 When a task wakes up, the scheduler will look at the current effective ucl=
amp
 value of every rq and compare it with the potential new value if the task =
were
 to be enqueued there. Favoring the rq that will end up with the most energy
@@ -159,17 +160,19 @@ efficient combination.
 Similarly in schedutil, when it needs to make a frequency update it will l=
ook
 at the current effective uclamp value of the rq which is influenced by the=
 set
 of tasks currently enqueued there and select the appropriate frequency that
-will honour uclamp requests.
+will satisfy constraints from requests.
=20
 Other paths like setting overutilization state (which effectively disables=
 EAS)
 make use of uclamp as well. Such cases are considered necessary housekeepi=
ng to
 allow the 2 main use cases above and will not be covered in detail here as=
 they
 could change with implementation details.
=20
-2.1  BUCKETS:
--------------
+.. _uclamp-buckets:
=20
-.. code-block:: c
+2.1. Buckets
+------------
+
+.. code-block::
=20
                            [struct rq]
=20
@@ -189,7 +192,6 @@ could change with implementation details.
=20
=20
 .. note::
-  DISCLAMER:
    The diagram above is an illustration rather than a true depiction of the
    internal data structure.
=20
@@ -198,12 +200,11 @@ an rq as tasks are enqueued/dequeued, the whole utili=
zation range is divided
 into N buckets where N is configured at compile time by setting
 CONFIG_UCLAMP_BUCKETS_COUNT. By default it is set to 5.
=20
-The rq has a bucket for each uclamp_id: [UCLAMP_MIN, UCLAMP_MAX].
+The rq has a bucket for each uclamp_id tunables: [UCLAMP_MIN, UCLAMP_MAX].
=20
-The range of each bucket is 1024/N. For example for the default value of 5=
 we
-will have 5 buckets, each of which will cover the following range:
+The range of each bucket is 1024/N. For example, for the default value of =
5 there will be 5 buckets, each of which will cover the following range:
=20
-.. code-block:: c
+.. code-block::
=20
         DELTA =3D round_closest(1024/5) =3D 204.8 =3D 205
=20
@@ -213,21 +214,21 @@ will have 5 buckets, each of which will cover the fol=
lowing range:
         Bucket 3: [615:819]
         Bucket 4: [820:1024]
=20
-When a task p
+When a task p with following tunable parameters
=20
 .. code-block:: c
=20
         p->uclamp[UCLAMP_MIN] =3D 300
         p->uclamp[UCLAMP_MAX] =3D 1024
=20
-is enqueued into the rq, Bucket 1 will be incremented for UCLAMP_MIN and B=
ucket
+is enqueued into the rq, bucket 1 will be incremented for UCLAMP_MIN and b=
ucket
 4 will be incremented for UCLAMP_MAX to reflect the fact the rq has a task=
 in
 this range.
=20
 The rq then keeps track of its current effective uclamp value for each
 uclamp_id.
=20
-When a task p is enqueued, the rq value changes as follows:
+When a task p is enqueued, the rq value changes to:
=20
 .. code-block:: c
=20
@@ -235,7 +236,7 @@ When a task p is enqueued, the rq value changes as foll=
ows:
         rq->uclamp[UCLAMP_MIN] =3D max(rq->uclamp[UCLAMP_MIN], p->uclamp[U=
CLAMP_MIN])
         // repeat for UCLAMP_MAX
=20
-When a task is p dequeued the rq value changes as follows:
+Similarly, when p is dequeued the rq value changes to:
=20
 .. code-block:: c
=20
@@ -244,11 +245,11 @@ When a task is p dequeued the rq value changes as fol=
lows:
         // repeat for UCLAMP_MAX
=20
 When all buckets are empty, the rq uclamp values are reset to system defau=
lts.
-See section 3.4 for default values.
+See :ref:`section 3.4 <uclamp-default-values>` for details on default valu=
es.
=20
=20
-2.2  MAX AGGREGATION:
----------------------
+2.2. Max aggregation
+--------------------
=20
 Util clamp is tuned to honour the request for the task that requires the
 highest performance point.
@@ -268,19 +269,20 @@ values:
         p1->uclamp[UCLAMP_MIN] =3D 500
         p1->uclamp[UCLAMP_MAX] =3D 500
=20
-then assuming both p0 and p1 are enqueued to the same rq
+then assuming both p0 and p1 are enqueued to the same rq, both UCLAMP_MIN
+and UCLAMP_MAX become:
=20
 .. code-block:: c
=20
         rq->uclamp[UCLAMP_MIN] =3D max(300, 500) =3D 500
         rq->uclamp[UCLAMP_MAX] =3D max(900, 500) =3D 900
=20
-As we shall see in section 5.1, this max aggregation is the cause of one o=
f the
-limitations when using util clamp. Particularly for UCLAMP_MAX hint when u=
ser
-space would like to save power.
+As we shall see in :ref:`section 5.1 <uclamp-capping-fail>`, this max
+aggregation is the cause of one of limitations when using util clamp, in
+particular for UCLAMP_MAX hint when user space would like to save power.
=20
-2.3  HIERARCHICAL AGGREGATION:
-------------------------------
+2.3. Hierarchial aggregation
+----------------------------
=20
 As stated earlier, util clamp is a property of every task in the system. B=
ut
 the actual applied (effective) value can be influenced by more than just t=
he
@@ -293,80 +295,66 @@ The effective util clamp value of any task is restric=
ted as follows:
   2. The restricted value in (1) is then further restricted by the system =
wide
      uclamp settings.
=20
-Section 3 discusses the interfaces and will expand further on that.
+:ref:`Section 3 <uclamp-interfaces>` discusses the interfaces and will exp=
and further on that.
=20
 For now suffice to say that if a task makes a request, its actual effective
 value will have to adhere to some restrictions imposed by cgroup and system
 wide settings.
=20
-The system will still accept the request even if effectively will look
-different; but as soon as the task moves to a different cgroup or a sysadm=
in
-modifies the system settings, it'll be able to get what it wants if the new
-settings allows it.
+The system will still accept the request even if effectively will be
+beyond the constraints, but as soon as the task moves to a different cgroup
+or a sysadmin modifies the system settings, the request will be satisfied
+only if it is within new constraints.
=20
 In other words, this aggregation will not cause an error when a task chang=
es
-its uclamp values. It just might not be able to achieve it based on those
-factors.
+its uclamp values, but rather the system may not be able to satisfy reques=
ts
+based on those factors.
=20
 2.4  Range:
 -----------
=20
-Uclamp performance request follow the utilization range: [0:1024] inclusiv=
e.
+Uclamp performance request has the range of 0 to 1024 inclusive.
=20
-For cgroup interface percentage is used: [0:100] inclusive.
-You can use 'max' instead of 100 like other cgroup interfaces.
+For cgroup interface percentage is used (that is 0 to 100 inclusive).
+Just like other cgroup interfaces, you can use 'max' instead of 100.
=20
-3.  INTERFACES:
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+.. _uclamp-interfaces:
=20
-3.1  PER TASK INTERFACE:
-------------------------
+3.  Interfaces
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+3.1  Per-task interface
+-----------------------
=20
 sched_setattr() syscall was extended to accept two new fields:
=20
 * sched_util_min: requests the minimum performance point the system should=
 run
-                  at when this task is running. Or lower performance bound.
+  at when this task is running. Or lower performance bound.
 * sched_util_max: requests the maximum performance point the system should=
 run
-                  at when this task is running. Or upper performance bound.
+  at when this task is running. Or upper performance bound.
=20
-For example:
+For example, the following scenario have 40% to 80% utilization constraint=
s:
=20
 .. code-block:: c
=20
         attr->sched_util_min =3D 40% * 1024;
         attr->sched_util_max =3D 80% * 1024;
=20
-Will tell the system that when task @p is running, it should try its best =
to
-ensure it starts at a performance point no less than 40% of maximum system=
's
-capability.
-
-And if the task runs for a long enough time so that its actual utilization=
 goes
-above 80%, then it should not cause the system to operate at a performance
-point higher than that.
+When task @p is running, the scheduler should try its best to ensure it st=
arts
+at 40% utilization. If the task runs for a long enough time so that its ac=
tual
+utilization goes above 80%, the utilization will be capped.
=20
 The special value -1 is used to reset the uclamp settings to the system
 default.
=20
 Note that resetting the uclamp value to system default using -1 is not the=
 same
-as setting the uclamp value to system default.
+as manually setting uclamp value to system default. This distinction is
+important because as we shall see in system interfaces, the default value =
for
+RT could be changed. SCHED_NORMAL/OTHER might gain similar knobs too in the
+future.
=20
-.. code-block:: c
-
-        attr->sched_util_min =3D -1  // p0 is reset to system default e.g:=
 0
-
-not the same as
-
-.. code-block:: c
-
-        attr->sched_util_min =3D 0   // p0 is set to 0, the fact it is the=
 same
-                                   // as system default is irrelevant
-
-This distinction is important because as we shall see in system interfaces=
, the
-default value for RT could be changed. SCHED_NORMAL/OTHER might gain simil=
ar
-knobs too in the future.
-
-3.2  CGROUP INTERFACE:
-----------------------
+3.2. cgroup interface
+---------------------
=20
 There are two uclamp related values in the CPU cgroup controller:
=20
@@ -394,7 +382,7 @@ as follows:
   In a cgroup hierarchy, effective cpu.uclamp.max is the min of (child,
   parent).
=20
-For example:
+For example, given following parameters:
=20
 .. code-block:: c
=20
@@ -410,7 +398,7 @@ For example:
         cgroup1->cpu.uclamp.min =3D 60% * 1024;
         cgroup1->cpu.uclamp.max =3D 100% * 1024;
=20
-when p0 and p1 are attached to cgroup0
+when p0 and p1 are attached to cgroup0, the values become:
=20
 .. code-block:: c
=20
@@ -420,7 +408,7 @@ when p0 and p1 are attached to cgroup0
         p1->uclamp[UCLAMP_MIN] =3D 40% * 1024; // intact
         p1->uclamp[UCLAMP_MAX] =3D 50% * 1024; // intact
=20
-when p0 and p1 are attached to cgroup1
+when p0 and p1 are attached to cgroup1, these instead become:
=20
 .. code-block:: c
=20
@@ -433,49 +421,46 @@ when p0 and p1 are attached to cgroup1
 Note that cgroup interfaces allows cpu.uclamp.max value to be lower than
 cpu.uclamp.min. Other interfaces don't allow that.
=20
-3.3  SYSTEM INTERFACE:
+3.3.  System interface
 ----------------------
=20
-3.3.1  sched_util_clamp_min:
-----------------------------
+3.3.1  sched_util_clamp_min
+---------------------------
=20
-System wide limit of allowed UCLAMP_MIN range. By default set to 1024, whi=
ch
-means tasks are allowed to reach an effective UCLAMP_MIN value in the rang=
e of
-[0:1024].
+System wide limit of allowed UCLAMP_MIN range. By default it is set to 102=
4,
+which means that permitted effective UCLAMP_MIN range for tasks is [0:1024=
].
+By changing it to 512 for example the range reduces to [0:512]. This is us=
eful
+to restrict how much boosting tasks are allowed to acquire.
=20
-By changing it to 512 for example the effective allowed range reduces to
-[0:512].
-
-This is useful to restrict how much boosting tasks are allowed to acquire.
-
-Requests from tasks to go above this point will still succeed, but effecti=
vely
-they won't be achieved until this value is >=3D p->uclamp[UCLAMP_MIN].
+Requests from tasks to go above this knob value will still succeed, but
+they won't be satisfied until it is more than p->uclamp[UCLAMP_MIN].
=20
 The value must be smaller than or equal to sched_util_clamp_max.
=20
-3.3.2  sched_util_clamp_max:
-----------------------------
+3.3.2  sched_util_clamp_max
+---------------------------
=20
-System wide limit of allowed UCLAMP_MAX range. By default set to 1024, whi=
ch
-means tasks are allowed to reach an effective UCLAMP_MAX value in the rang=
e of
-[0:1024].
+System wide limit of allowed UCLAMP_MAX range. By default it is set to 102=
4,
+which means that permitted effective UCLAMP_MAX range for tasks is [0:1024=
].
=20
 By changing it to 512 for example the effective allowed range reduces to
-[0:512]. The visible impact of this is that no task can run above 512, whi=
ch in
-return means that all rqs are restricted too. IOW, the whole system is cap=
ped
-to half its performance capacity.
+[0:512]. This means is that no task can run above 512, which implies that =
all
+rqs are restricted too. IOW, the whole system is capped to half its perfor=
mance
+capacity.
=20
-This is useful to restrict the overall maximum performance point of the sy=
stem.
+This is useful to restrict the overall maximum performance point of the
+system. For example, it can be handy to limit performance when running low=
 on
+battery.
=20
-Can be handy to limit performance when running low on battery.
-
-Requests from tasks to go above this point will still succeed, but effecti=
vely
-they won't be achieved until this value is >=3D p->uclamp[UCLAMP_MAX].
+Requests from tasks to go above this knob value will still succeed, but
+they won't be satisfied until it is more than p->uclamp[UCLAMP_MAX].
=20
 The value must be greater than or equal to sched_util_clamp_min.
=20
-3.4  DEFAULT VALUES:
-----------------------
+.. _uclamp-default-values:
+
+3.4. Default values
+-------------------
=20
 By default all SCHED_NORMAL/SCHED_OTHER tasks are initialized to:
=20
@@ -484,7 +469,7 @@ By default all SCHED_NORMAL/SCHED_OTHER tasks are initi=
alized to:
         p_fair->uclamp[UCLAMP_MIN] =3D 0
         p_fair->uclamp[UCLAMP_MAX] =3D 1024
=20
-That is no boosting or restriction on any task. These default values can't=
 be
+That is, no boosting or restriction on any task. These default values can'=
t be
 changed at boot or runtime. No argument was made yet as to why we should
 provide this, but can be added in the future.
=20
@@ -495,33 +480,35 @@ For SCHED_FIFO/SCHED_RR tasks:
         p_rt->uclamp[UCLAMP_MIN] =3D 1024
         p_rt->uclamp[UCLAMP_MAX] =3D 1024
=20
-That is by default they're boosted to run at the maximum performance point=
 of
+That is, by default they're boosted to run at the maximum performance poin=
t of
 the system which retains the historical behavior of the RT tasks.
=20
 RT tasks default uclamp_min value can be modified at boot or runtime via
-sysctl. See section 3.4.1.
+sysctl. See below section.
+
+.. _sched-util-clamp-min-rt-default:
=20
 3.4.1  sched_util_clamp_min_rt_default:
 ---------------------------------------
=20
 Running RT tasks at maximum performance point is expensive on battery powe=
red
-devices and not necessary. To allow system designers to offer good perform=
ance
-guarantees for RT tasks without pushing it all the way to maximum performa=
nce
+devices and not necessary. To allow system developer to offer good perform=
ance
+guarantees for these tasks without pushing it all the way to maximum perfo=
rmance
 point, this sysctl knob allows tuning the best boost value to address the
 system requirement without burning power running at maximum performance po=
int
 all the time.
=20
-Application designers are encouraged to use the per task util clamp interf=
ace
+Application developer are encouraged to use the per task util clamp interf=
ace
 to ensure they are performance and power aware. Ideally this knob should b=
e set
 to 0 by system designers and leave the task of managing performance
-requirements to the apps themselves.
+requirements to the apps.
=20
-4.  HOW TO USE UTIL CLAMP:
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+4. How to use util clamp
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Util clamp promotes the concept of user space assisted power and performan=
ce
-management. At the scheduler level the info required to make the best deci=
sion
-are non existent. But with util clamp user space can hint to the scheduler=
 to
+management. At the scheduler level there is no info required to make the b=
est
+decision. However, with util clamp user space can hint to the scheduler to
 make better decision about task placement and frequency selection.
=20
 Best results are achieved by not making any assumptions about the system t=
he
@@ -530,41 +517,41 @@ dynamically monitor and adjust. Ultimately this will =
allow for a better user
 experience at a better perf/watt.
=20
 For some systems and use cases, static setup will help to achieve good res=
ults.
-Portability will be a problem in this case. After all how much work one ca=
n do
-at 100, 200 or 1024 is unknown and a special property of every system. Unl=
ess
-there's a specific target system, static setup should be avoided.
+Portability will be a problem in this case. How much work one can do at 10=
0,
+200 or 1024 is different for each system. Unless there's a specific target
+system, static setup should be avoided.
=20
-All in all there are enough possibilities to create a whole framework base=
d on
+There are enough possibilities to create a whole framework based on
 util clamp or self contained app that makes use of it directly.
=20
-4.1  BOOST IMPORTANT AND DVFS-LATENCY-SENSITIVE TASKS:
-------------------------------------------------------
+4.1. Boost important and DVFS-latency-sensitive tasks
+-----------------------------------------------------
=20
 A GUI task might not be busy to warrant driving the frequency high when it
-wakes up. But it requires to finish its work within a specific period of t=
ime
+wakes up. However, it requires to finish its work within a specific time w=
indow
 to deliver the desired user experience. The right frequency it requires at
 wakeup will be system dependent. On some underpowered systems it will be h=
igh,
-on other overpowered ones, it will be low or 0.
+on other overpowered ones it will be low or 0.
=20
-This task can increase its UCLAMP_MIN value every time it misses a deadlin=
e to
-ensure on next wake up it runs at a higher performance point. It should tr=
y to
-approach the lowest UCLAMP_MIN value that allows to meet its deadline on a=
ny
+This task can increase its UCLAMP_MIN value every time it misses the deadl=
ine
+to ensure on next wake up it runs at a higher performance point. It should=
 try
+to approach the lowest UCLAMP_MIN value that allows to meet its deadline o=
n any
 particular system to achieve the best possible perf/watt for that system.
=20
 On heterogeneous systems, it might be important for this task to run on
-a bigger CPU.
+a faster CPU.
=20
 Generally it is advised to perceive the input as performance level or point
 which will imply both task placement and frequency selection.
=20
-4.2  CAP BACKGROUND TASKS:
---------------------------
+4.2. Cap background tasks
+-------------------------
=20
 Like explained for Android case in the introduction. Any app can lower
 UCLAMP_MAX for some background tasks that don't care about performance but
 could end up being busy and consume unnecessary system resources on the sy=
stem.
=20
-4.3  POWERSAVE MODE:
+4.3.  Powersave mode
 --------------------
=20
 sched_util_clamp_max system wide interface can be used to limit all tasks =
=66rom
@@ -575,8 +562,8 @@ This is not unique to uclamp as one can achieve the sam=
e by reducing max
 frequency of the cpufreq governor. It can be considered a more convenient
 alternative interface.
=20
-4.4  PER APP PERFORMANCE RESTRICTIONS:
---------------------------------------
+4.4.  Per-app performance restriction
+-------------------------------------
=20
 Middleware/Utility can provide the user an option to set UCLAMP_MIN/MAX fo=
r an
 app every time it is executed to guarantee a minimum performance point and=
/or
@@ -585,28 +572,31 @@ these apps.
=20
 If you want to prevent your laptop from heating up while on the go from
 compiling the kernel and happy to sacrifice performance to save power, but
-still would like to keep your browser performance intact; uclamp enables t=
hat.
+still would like to keep your browser performance intact, uclamp makes it
+possible.
=20
-5.  LIMITATIONS:
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+5. Limitations
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-5.1  CAPPING FREQUENCY WITH UCLAMP_MAX FAILS UNDER CERTAIN CONDITIONS:
-----------------------------------------------------------------------
+.. _uclamp-capping-fail:
=20
-If task p0 is capped to run at 512
+5.1. Capping frequency with uclamp_max fails under certain conditions
+---------------------------------------------------------------------
+
+If task p0 is capped to run at 512:
=20
 .. code-block:: c
=20
         p0->uclamp[UCLAMP_MAX] =3D 512
=20
-is sharing the rq with p1 which is free to run at any performance point
+and it shares the rq with p1 which is free to run at any performance point:
=20
 .. code-block:: c
=20
         p1->uclamp[UCLAMP_MAX] =3D 1024
=20
 then due to max aggregation the rq will be allowed to reach max performance
-point
+point:
=20
 .. code-block:: c
=20
@@ -620,19 +610,19 @@ both are running at the same rq, p1 will cause the fr=
equency capping to be left
 from the rq although p1, which is allowed to run at any performance point,
 doesn't actually need to run at that frequency.
=20
-5.2  UCLAMP_MAX CAN BREAK PELT (UTIL_AVG) SIGNAL
+5.2. UCLAMP_MAX can break pelt (util_avg) signal
 ------------------------------------------------
=20
 PELT assumes that frequency will always increase as the signals grow to en=
sure
-there's always some idle time on the CPU. But with UCLAMP_MAX, we will pre=
vent
-this frequency increase which can lead to no idle time in some circumstanc=
es.
-When there's no idle time, then a task will look like a busy loop, which w=
ould
-result in util_avg being 1024.
+there's always some idle time on the CPU. But with UCLAMP_MAX, this freque=
ncy
+increase will be prevented which can lead to no idle time in some
+circumstances. When there's no idle time, a task will stuck in a busy loop,
+which would result in util_avg being 1024.
=20
-Combing with issue described in 5.2, this an lead to unwanted frequency sp=
ikes
+Combing with issue described below, this an lead to unwanted frequency spi=
kes
 when severely capped tasks share the rq with a small non capped task.
=20
-As an example if task p
+As an example if task p, which have:
=20
 .. code-block:: c
=20
@@ -646,35 +636,35 @@ of.
=20
         rq->uclamp[UCLAMP_MAX] =3D 0
=20
-If the ratio of Fmax/Fmin is 3, then
+If the ratio of Fmax/Fmin is 3, then maximum value will be:
=20
 .. code-block:: c
=20
         300 * (Fmax/Fmin) =3D 900
=20
-Which indicates the CPU will still see idle time since 900 is < 1024. The
-_actual_ util_avg will NOT be 900 though. It will be higher than 300, but =
won't
-approach 900. As long as there's idle time, p->util_avg updates will be of=
f by
-a some margin, but not proportional to Fmax/Fmin.
+which indicates the CPU will still see idle time since 900 is < 1024. The
+_actual_ util_avg will not be 900 though, but somewhere between 300 and 90=
0. As
+long as there's idle time, p->util_avg updates will be off by a some margi=
n,
+but not proportional to Fmax/Fmin.
=20
 .. code-block:: c
=20
         p0->util_avg =3D 300 + small_error
=20
-Now if the ratio of Fmax/Fmin is 4, then
+Now if the ratio of Fmax/Fmin is 4, the maximum value becomes:
=20
 .. code-block:: c
=20
         300 * (Fmax/Fmin) =3D 1200
=20
 which is higher than 1024 and indicates that the CPU has no idle time. When
-this happens, then the _actual_ util_avg will become 1024.
+this happens, then the _actual_ util_avg will become:
=20
 .. code-block:: c
=20
         p0->util_avg =3D 1024
=20
-If task p1 wakes up on this CPU
+If task p1 wakes up on this CPU, which have:
=20
 .. code-block:: c
=20
@@ -683,7 +673,7 @@ If task p1 wakes up on this CPU
=20
 then the effective UCLAMP_MAX for the CPU will be 1024 according to max
 aggregation rule. But since the capped p0 task was running and throttled
-severely, then the rq->util_avg will be 1024.
+severely, then the rq->util_avg will be:
=20
 .. code-block:: c
=20
@@ -693,7 +683,7 @@ severely, then the rq->util_avg will be 1024.
         rq->util_avg =3D 1024
         rq->uclamp[UCLAMP_MAX] =3D 1024
=20
-Hence lead to a frequency spike since if p0 wasn't throttled we should get
+Hence lead to a frequency spike since if p0 wasn't throttled we should get:
=20
 .. code-block:: c
=20

Thanks.

[1]: https://lore.kernel.org/lkml/20221113152629.3wbyeejsj5v33rvu@airbuntu/

--=20
An old man doll... just what I always wanted! - Clara

--GLa0IuTWsGzJ3iko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY3II4wAKCRD2uYlJVVFO
oyrKAQCtyOES98ZjGBXvk039yyVlMUyHz8zIIUQ1b0ZdIpHxJQD8ChCbVlzhRmmI
y1fLXHZ05FipXidZiwnDLA4hUvo10Q8=
=iGqW
-----END PGP SIGNATURE-----

--GLa0IuTWsGzJ3iko--
