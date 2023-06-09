Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E5472A00E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbjFIQUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242187AbjFIQTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:19:49 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C0C2D44
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:19:27 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-565c7399afaso18199717b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1686327564; x=1688919564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAnp8nk8Drs+fq4PdxH7Z2zYNvsqX1dlZYid/tf+cvs=;
        b=SLp7IGyKSJoCTguMmsNixX9DK6sIfLRmf/EiprLy0WjCbpPucAcellFr4CPKJGGFXu
         Gh6PQn7NuEez3HFUfq0voV7Yfx4MB66r3eFCUY9aGHefS1LzJRmajyg6sh8kNgLpGhOW
         rc9AhbRUCNiHEvoCWubcC7/fPGRRDluLIi2ZxqwJSZfEBIAUTsDxW+TjbZIajZv/Q7+l
         ko5dX7ZYTayX3egnEQLj+d0LiYStVSTTLRS+CRdj088jycaT8+UU8bKJBLUevkF7A3Jj
         3SyMSrv7dWr+FzaJkU2W6j5xZqZmGdCx+foxgz3cQF/Df6rQTfngZ4zH20ksb62WtdHi
         0MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327564; x=1688919564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAnp8nk8Drs+fq4PdxH7Z2zYNvsqX1dlZYid/tf+cvs=;
        b=kwusLqGDa3+pWjGDtjH2Hv47mT2Yryo2qgqWYM4krLAqKOdgLE7Mzv/oNFKcQprPeM
         zmyu+OqlPCP/DcDNgTrfhPDxInp97Yh7SMjwXjyoYo3V4sK9cPOTFB2UCDjWYtlu41Kt
         LkJCd3/aKX7SUvxcYji76+pYkUCUl/mirdf6vFQ1ECPwhRAebt3GzUqL232EsH8QzeOV
         0yGIpGtltyn2H4GVtRWUDhheRyz+FxaZ2LsF2sccHEXEGGXDW9SpxMZTDgYhHBHoGsdn
         S8rHGvJ6/kXn/6AgBxW1xL1ToNmo+yOL4ILuJp3jREGxY8zez8RZuOSuJOBbOHLOWDtl
         tuBw==
X-Gm-Message-State: AC+VfDyhHtj22Gx9hCrP6pPAa/2eezL6fPE0gCs5COPUuTdEtcP+J/lI
        c2X9wQg1r7V9Go1Mp8q8GU8eK8NOCuUrz7eyBMFVTA==
X-Google-Smtp-Source: ACHHUZ4xbcwQos5stjR3+NPVH/GCf1ZFjClpbdt0fY+rge7tSC352F82rfJVp2d0njY9tuSktNEtB/iP5FzdgEbmth4=
X-Received: by 2002:a81:9145:0:b0:567:c388:3552 with SMTP id
 i66-20020a819145000000b00567c3883552mr1892389ywg.6.1686327564258; Fri, 09 Jun
 2023 09:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230602103750.2290132-1-vladimir.oltean@nxp.com>
 <20230602103750.2290132-6-vladimir.oltean@nxp.com> <CAM0EoM=P9+wNnNQ=ky96rwCx1z20fR21EWEdx+Na39NCqqG=3A@mail.gmail.com>
 <20230609121043.ekfvbgjiko7644t7@skbuf>
In-Reply-To: <20230609121043.ekfvbgjiko7644t7@skbuf>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Fri, 9 Jun 2023 12:19:12 -0400
Message-ID: <CAM0EoMmkSZCePo1Y49iMk=9oYKR8xfVDncWF0E4xRhp2ER2PRQ@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next 5/5] net/sched: taprio: dump class stats
 for the actual q->qdiscs[]
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 8:10=E2=80=AFAM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:
>
> On Thu, Jun 08, 2023 at 02:44:46PM -0400, Jamal Hadi Salim wrote:
> > Other than the refcount issue i think the approach looks reasonable to
> > me. The stats before/after you are showing below though are
> > interesting; are you showing a transient phase where packets are
> > temporarily in the backlog. Typically the backlog is a transient phase
> > which lasts a very short period. Maybe it works differently for
> > taprio? I took a quick look at the code and do see to decrement the
> > backlog in the dequeue, so if it is not transient then some code path
> > is not being hit.
>
> It's a fair concern. The thing is that I put very aggressive time slots
> in the schedule that I'm testing with, and my kernel has a lot of
> debugging stuff which bogs it down (kasan, kmemleak, lockdep, DMA API
> debug etc). Not to mention that the CPU isn't the fastest to begin with.
>
> The way taprio works is that there's a hrtimer which fires at the
> expiration time of the current schedule entry and sets up the gates for
> the next one. Each schedule entry has a gate for each traffic class
> which determines what traffic classes are eligible for dequeue() and
> which ones aren't.
>
> The dequeue() procedure, though also invoked by the advance_schedule()
> hrtimer -> __netif_schedule(), is also time-sensitive. By the time
> taprio_dequeue() runs, taprio_entry_allows_tx() function might return
> false when the system is so bogged down that it wasn't able to make
> enough progress to dequeue() an skb in time. When that happens, there is
> no mechanism, currently, to age out packets that stood too much in the
> TX queues (what does "too much" mean?).
>
> Whereas enqueue() is technically not time-sensitive, i.e. you can
> enqueue whenever you want and the Qdisc will dequeue whenever it can.
> Though in practice, to make this scheduling technique useful, the user
> space enqueue should also be time-aware (though you can't capture this
> with ping).
>
> If I increase all my sched-entry intervals by a factor of 100, the
> backlog issue goes away and the system can make forward progress.
>
> So yeah, sorry, I didn't pay too much attention to the data I was
> presenting for illustrative purposes.
>

So it seems to me it is a transient phase and that at some point the
backlog will clear up and the sent stats will go up. Maybe just say so
in your commit or show the final result after the packet is gone.

I have to admit, I dont know much about taprio - that's why i am
asking all these leading questions. You spoke of gates etc and thats
klingon to me; but iiuc there's some time sensitive stuff that needs
to be sent out within a deadline. Q: What should happen to skbs that
are no longer valid?
On the aging thing which you say is missing, shouldnt the hrtimer or
schedule kick not be able to dequeue timestamped packets and just drop
them?

cheers,
jamal



cheers,
jamal

> > Aside: I realize you are busy - but if you get time and provide some
> > sample tc command lines for testing we could help create the tests for
> > you, at least the first time. The advantage of putting these tests in
> > tools/testing/selftests/tc-testing/ is that there are test tools out
> > there that run these tests and so regressions are easier to catch
> > sooner.
>
> Yeah, ok. The script posted in a reply on the cover letter is still what
> I'm working with. The things it intends to capture are:
> - attaching a custom Qdisc to one of taprio's classes doesn't fail
> - attaching taprio to one of taprio's classes fails
> - sending packets through one queue increases the counters (any counters)
>   of just that queue
>
> All the above, replicated once for the software scheduling case and once
> for the offload case. Currently netdevsim doesn't attempt to emulate
> taprio offload.
>
> Is there a way to skip tests? I may look into tdc, but I honestly don't
> have time for unrelated stuff such as figuring out why my kernel isn't
> configured for the other tests to pass - and it seems that once one test
> fails, the others are completely skipped, see below.
>
> Also, by which rule are the test IDs created?
>
> root@debian:~# cd selftests/tc-testing/
> root@debian:~/selftests/tc-testing# ./tdc.sh
> considering category qdisc
>  -- ns/SubPlugin.__init__
> Test 0582: Create QFQ with default setting
> Test c9a3: Create QFQ with class weight setting
> Test d364: Test QFQ with max class weight setting
> Test 8452: Create QFQ with class maxpkt setting
> Test 22df: Test QFQ class maxpkt setting lower bound
> Test 92ee: Test QFQ class maxpkt setting upper bound
> Test d920: Create QFQ with multiple class setting
> Test 0548: Delete QFQ with handle
> Test 5901: Show QFQ class
> Test 0385: Create DRR with default setting
> Test 2375: Delete DRR with handle
> Test 3092: Show DRR class
> Test 3460: Create CBQ with default setting
> exit: 2
> exit: 0
> Error: Specified qdisc kind is unknown.
>
>
> -----> teardown stage *** Could not execute: "$TC qdisc del dev $DUMMY ha=
ndle 1: root"
>
> -----> teardown stage *** Error message: "Error: Invalid handle.
> "
> returncode 2; expected [0]
>
> -----> teardown stage *** Aborting test run.
>
>
> <_io.BufferedReader name=3D3> *** stdout ***
>
>
> <_io.BufferedReader name=3D5> *** stderr ***
> "-----> teardown stage" did not complete successfully
> Exception <class '__main__.PluginMgrTestFail'> ('teardown', 'Error: Speci=
fied qdisc kind is unknown.\n', '"-----> teardown stage" did not complete s=
uccessfully') (caught in test_runner, running test 14 3460 Create CBQ with =
default setting stage teardown)
> ---------------
> traceback
>   File "/root/selftests/tc-testing/./tdc.py", line 495, in test_runner
>     res =3D run_one_test(pm, args, index, tidx)
>   File "/root/selftests/tc-testing/./tdc.py", line 434, in run_one_test
>     prepare_env(args, pm, 'teardown', '-----> teardown stage', tidx['tear=
down'], procout)
>   File "/root/selftests/tc-testing/./tdc.py", line 245, in prepare_env
>     raise PluginMgrTestFail(
> ---------------
> accumulated output for this test:
> Error: Specified qdisc kind is unknown.
> ---------------
>
> All test results:
>
> 1..336
> ok 1 0582 - Create QFQ with default setting
> ok 2 c9a3 - Create QFQ with class weight setting
> ok 3 d364 - Test QFQ with max class weight setting
> ok 4 8452 - Create QFQ with class maxpkt setting
> ok 5 22df - Test QFQ class maxpkt setting lower bound
> ok 6 92ee - Test QFQ class maxpkt setting upper bound
> ok 7 d920 - Create QFQ with multiple class setting
> ok 8 0548 - Delete QFQ with handle
> ok 9 5901 - Show QFQ class
> ok 10 0385 - Create DRR with default setting
> ok 11 2375 - Delete DRR with handle
> ok 12 3092 - Show DRR class
> ok 13 3460 - Create CBQ with default setting # skipped - "-----> teardown=
 stage" did not complete successfully
>
> ok 14 0592 - Create CBQ with mpu # skipped - skipped - previous teardown =
failed 14 3460
>
> ok 15 4684 - Create CBQ with valid cell num # skipped - skipped - previou=
s teardown failed 14 3460
>
> ok 16 4345 - Create CBQ with invalid cell num # skipped - skipped - previ=
ous teardown failed 14 3460
>
> ok 17 4525 - Create CBQ with valid ewma # skipped - skipped - previous te=
ardown failed 14 3460
>
> ok 18 6784 - Create CBQ with invalid ewma # skipped - skipped - previous =
teardown failed 14 3460
>
> ok 19 5468 - Delete CBQ with handle # skipped - skipped - previous teardo=
wn failed 14 3460
>
> ok 20 492a - Show CBQ class # skipped - skipped - previous teardown faile=
d 14 3460
>
> ok 21 9903 - Add mqprio Qdisc to multi-queue device (8 queues) # skipped =
- skipped - previous teardown failed 14 3460
>
> ok 22 453a - Delete nonexistent mqprio Qdisc # skipped - skipped - previo=
us teardown failed 14 3460
>
> ok 23 5292 - Delete mqprio Qdisc twice # skipped - skipped - previous tea=
rdown failed 14 3460
>
> ok 24 45a9 - Add mqprio Qdisc to single-queue device # skipped - skipped =
- previous teardown failed 14 3460
>
> ok 25 2ba9 - Show mqprio class # skipped - skipped - previous teardown fa=
iled 14 3460
>
> ok 26 4812 - Create HHF with default setting # skipped - skipped - previo=
us teardown failed 14 3460
>
> ok 27 8a92 - Create HHF with limit setting # skipped - skipped - previous=
 teardown failed 14 3460
>
> ok 28 3491 - Create HHF with quantum setting # skipped - skipped - previo=
us teardown failed 14 3460
> (...)
