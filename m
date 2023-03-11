Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7196B58CA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjCKFzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCKFy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:54:57 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF868123CEF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 21:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678514017; i=efault@gmx.de;
        bh=IwzSAScobmfd78FErPnx42SFOemeZXNUNnUrL/k41ZM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=EMmhOgI7K962FJMZzgTKP+86Mw8Jej46BfxNC1vT0rdto82e4V9+j3Va5+SasljpB
         sgzpzjBDXmmMOsabkon4oZhsdDVNDEn1A1sNI+MCoE40npluMNRey7KPidCHWhW3wL
         61gpyk6n9VNmeIOyBqziPYtQ0PaEbNdSdWD2Wucl4CgQqJLmjBLIqhOuz0lDkjDBug
         xl7pFQ34WqwOppXfXvgaaDMJuF/+lBOGnSDye5qma4xpmut8TxNUTEprVrSIZqXLr/
         cSmxQ5o/JBRN0TyspbX35qFl4CxXKfYr7Qt6SIfq7Qpko6N8YPKVN5E0FVrNZGP1lU
         8t0a8sq+eLHFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.217.251]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOREc-1puAut2MwA-00PtED; Sat, 11
 Mar 2023 06:53:37 +0100
Message-ID: <58e8015255706fbe83e3a83df8c781bbc734e2a0.camel@gmx.de>
Subject: Re: [PATCH 10/10] sched/fair: Implement an EEVDF like policy
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Date:   Sat, 11 Mar 2023 06:53:30 +0100
In-Reply-To: <20230310203814.GA1605437@hirez.programming.kicks-ass.net>
References: <20230306132521.968182689@infradead.org>
         <20230306141502.810909205@infradead.org>
         <bfbfbf041854e2cd1a8ed14e64081062e5d632d3.camel@gmx.de>
         <9fd2c37a05713c206dcbd5866f67ce779f315e9e.camel@gmx.de>
         <5b567c5aecabf0a89d92593d99a73bef41bd65da.camel@gmx.de>
         <20230310203814.GA1605437@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ed1LjBiQiZHBSdVVkhauKtKGmXEjy9PEdYyxFhNNj++4coTxVKc
 CwhbZaIsumvjLomxmxRrMUUFZLGz6StpITgO98G1zd7LX3FBjMnWxz6xS4rqhIywQejNp/Y
 HrR+BvXND9HUtHULOvHsADgfkN9PGJx6eWhmy95ztLx9yI9VPNWLGGEx19TiVJlwMd5RyTU
 h7DZiZflpNwoRf4MIT3wQ==
UI-OutboundReport: notjunk:1;M01:P0:nInOxpftR4w=;XN4h1gB0gwkuuJhAZbBSZ+r15YZ
 //emXcTn8LhEta9UnM84WDYrj9bKq8zv16Ss5bwcU32xfVQdh4iqHxYC6L/UkG92gk0IJzyfl
 TqpYB3VI6DPHQWTsYkm+YI4fadQk/3klQpRUWkfUwfVWv+q7bPGmtN/r98Y4jre5XjPn+4vyq
 xbW2mPkLnlz5TJbiOwLG593tMFQDoe3qHBxoUWCKMreJodpK7gmH6G2QWU0RANrGna+udelmr
 wKTA1FhiXH+nPJjlxl5yeWetYSM+wzdCrjpRxwjEmuFtkithFVHYppF7CmAChaVr37ffBW/1f
 eakVUvNegPDNIrZ6vCeon6zydcGf4rEeK4+vBFlo0qqV28pVjsDjwTrW/aFXfwBkD2OZDq+hQ
 MxS4SU9Fscz9xE/vJry8hqYICFXvDpgRgdhTGTXVfL1Bvl6OmW0uTH0PCmABd+QL3b1yizQbq
 XIDBvDuanVj3aVTp1nwkAcI9k2dlmMX4jfffOiqEZD7wsD+zkGFnrLwFY76dTk56Jd2jUUZxH
 cVZornNZSwjP+MMqBMKa/wxEA6K41cs8v2+WUaksmeBifWqV2o9K4Z+hDLApcIAxsXDc3ZEKt
 WCRFmtGqCKsIPA/lZfV0Rg9PhZ5zcDgEllGY+Ij9Yg3DcyrUITP0FujZGhn6Ov5p7US8HUbaz
 PksPsSxaRf57A8pimV46RaA6sdC3TaLaOQ3eRVMK+EVtNun/UaTE9JTSml7i8s57hxsm+l9e0
 ls9xX6U3iWB3Gk93qe9WAIgLtUE4aMVtUkLCEW9HphLG15/UwkG0rJixGz92lxwir9HjPlUxj
 hTzIRUUCNgiXR7diC9IAtiRwoSeImD4Ybe/WQBjDEbefkcmU2oLq2sZWR73L73BVQB0dMOYSk
 gz9i9vEsw1RTj9Qmcg5WOKc26dd6oX8IR2FFGFdRLiDpx6/Hwg69XWNx4/5UBAvIllfp/BWcm
 2erynjDOKebKFbsk1KJj19rYssY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-03-10 at 21:38 +0100, Peter Zijlstra wrote:
> On Thu, Mar 09, 2023 at 05:23:33AM +0100, Mike Galbraith wrote:
> > Ok, seems there must be a math booboo lurking.
>
> Yep that.. please try the version I pushed out here:
>
> =C2=A0 https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/=
log/?h=3Dsched/eevdf
>
> (It's based on 6.3-rc1, but it should be trivial to rebase onto v6.2 if
> you so wish.)

I stuffed it into .today.  Yup, extreme sleeper stinginess is gone.

tbench/netperf numbers look roughly as previously.  massive_intr vs
desktop CPU distribution improved as expected, but (to me) oddly, the
amount of desktop beating up itself did not.

These are all .today

perf.data.eevdf
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     | Max delay start           | Max delay en=
d          |
  massive_intr:(9)      |1499451.694 ms |   647385 | avg:   0.940 ms | max=
:  27.969 ms | sum:608348.424 ms | max start:   467.219496 s | max end:   =
467.247465 s
  TOTAL:                |2369880.457 ms |  2797272 |                      =
               |   1243484.857 ms |
perf.data.eevdf_FAIR_SLEEPERS
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     | Max delay start           | Max delay en=
d          |
  massive_intr:(9)      |1415743.272 ms |   714999 | avg:   1.013 ms | max=
:  73.722 ms | sum:724624.600 ms | max start:  2678.846216 s | max end:  2=
678.919938 s
  TOTAL:                |2362333.392 ms |  2871586 |                      =
               |   1238748.802 ms |
perf.data.master
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     | Max delay start           | Max delay en=
d          |
  massive_intr:(9)      |1463798.673 ms |   598383 | avg:   0.730 ms | max=
:  40.029 ms | sum:437069.674 ms | max start:   945.022965 s | max end:   =
945.062994 s
  TOTAL:                |2370011.937 ms |  1109828 |                      =
               |    616408.789 ms |
