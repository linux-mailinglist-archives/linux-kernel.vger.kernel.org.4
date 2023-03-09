Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06746B2B08
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjCIQmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjCIQlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:41:46 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3F152F7B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 08:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678379444; i=efault@gmx.de;
        bh=HCeqSQSYA1yxVkl7HBp2yUk5YsQOvrOCKQIu3iuYloc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=HXxFGIDQAz8PYPNrIun1TMFp1hne8ktG9zSYeh096R8I0p0sHpkpjUUwqfFN2ZQ9s
         ObKhbpje2DVRX8Wku95CbdBuBP3fOIJfmiYTTHHklcy4zBuEvBp3091ntBNbmCJFOr
         sjj13i+lDrpvy7suIKmMhHdBBCPpItHi+595h+lkl0yOXB6uRwGulioUJCcqq+AS2q
         iFJhx+Iwq2eAVlcPl+Dkpb5jNpAsc/GpBnfyjXs9HkE8e84iIm8OdQpi6X4qrlBX5g
         pi/CxnxhLwxhbPwTZip5x/m3ypXvMWo5CETKsq8LJulj7wsAqRmQn2Ql4RN8zBORMt
         BcpUObkMC6DKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.148.100]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYXs-1qGp8z3zFm-00m1mT; Thu, 09
 Mar 2023 17:24:24 +0100
Message-ID: <a3a99571f589fc19152b0ad21bbe7cf70b13ede1.camel@gmx.de>
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
Date:   Thu, 09 Mar 2023 17:24:21 +0100
In-Reply-To: <ZAn7QAjQvw5q6aI5@hirez.programming.kicks-ass.net>
References: <20230306132521.968182689@infradead.org>
         <20230306141502.810909205@infradead.org>
         <bfbfbf041854e2cd1a8ed14e64081062e5d632d3.camel@gmx.de>
         <9fd2c37a05713c206dcbd5866f67ce779f315e9e.camel@gmx.de>
         <20230309090633.GK2017917@hirez.programming.kicks-ass.net>
         <ZAnUnSEJ92bKpim7@hirez.programming.kicks-ass.net>
         <ZAn7QAjQvw5q6aI5@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ysXXMcGvq2okLfT/Yj0myhqAOnNDxl2FiiTPE4qE/ONxiJm1kxO
 WnalVlTJ8w16zWDoihLJb/2nhD3GXmYIM/fW85MN0R58c2Dqpy4T5zqpDHJAfqQvGXmoHtp
 QAQ2gTWtqHONXbs9e5r9WLOHQttUXFYMuxb2e/hSopVZbxqnRZuKA+xucJy2AOVQcx7qB99
 isB5WC34XTy7Jd/UwZ22w==
UI-OutboundReport: notjunk:1;M01:P0:HmFnmlUcEXs=;OPPU6wJzac8jxKfzj6CzWo1CeqW
 Pnff4P7H++VMdjxH2ZA0s8wZawjfFg7MNvhFpUOpz6RDk3FtcBXJj7DF6enh1BCEAIunO4dta
 F6CvsHwHeONexlkJ5kencUDJBOnOvfe88S3nMZItNUpCJi2Gs0E9mvSpYd3LuumMqIWnF6p0j
 TwfzeFlQ8MiHS46OOljiQCKzjuT0t4lOqKEqUcdU1EcPWc1qs0RazZDr+5HMjLaeZHkHLZ3aC
 wwV/mKuOU4W2V3ZJtJvp3OW1uz/96uyKj5jt4gccyGSTqTB7H+jDo/NiKqxg6FHGVa8PLNGnX
 StdCPD+MrLN6rlxNFgU3a4fWjKffqWLONRDQMFBAKiJWwU3dVJa+iMmCfBOgvOHbx5AsprJ3a
 94xOwX3P7LNpuzfPGnhCQOCGGPgbyEmlckEnnjkNklAe7OXjuLdwMNb/1n0ggTdMEoHwBhJBE
 pVa+pnMucM/bMIkbDeSXF+XaDD2402PRor73nOQ46FUHakqbTkHynUVx1sKClEy52+SFxxmrX
 GyQcX5DSmiaN4HPCKfy7OV2rINOVxWIb6nXdeEa6wGsU5TeHIonAL+hOnb87XhyaOd3oyFC98
 BxGgG9Aaiu3ESvMtipwSUhc2SKbaPL7tJsl/A+0ptruyDt4LKDs4qvr/HI+ZupWa0eu7dWXoY
 NYzDYTkKkspoJ+RT1YzNGe1SrorabhUAJTY2B3L9T7yLkjiwiuLuPhqGeH0FWUjg6Sv9B5Fgr
 hzLmkUD+kISWizPlxHrOCc53VGtgNtVly5FsZrgZKX1nwky8ji9S00VQrHctHxD2DrJeAnnEJ
 m2fZ3zu9mNQeNSwvi1mRTmJYeDyOBk9RyttxpJjsh6rBslMczQSVcsMs2NUlpwmKoVC6QxsZT
 OoeodrjVtS/i9WKhLomwBT+HsBUfp+KlUy7E8j/3fYKWjYy8h/7J1H0cjPrpJYKrVPJQkHxfV
 BDcbNynK36nIRshZOc26yEkfJok=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-03-09 at 16:29 +0100, Peter Zijlstra wrote:
>
> So if I add TICK_NSEC based sleeper bonus (/2 for gentle), then starve
> works -- this is the absolutely minimal amount required. It sucks a bit
> it's HZ dependent, but alas.
>
> Also, the whole sleeper bonus gets us back into needing to track the old
> vruntime and the overflow crap for super long sleeps and all that fugly
> :/ I was so hoping we could delete that code.
>
> Oh well.

Yeah, it's a worthy target.

	-Mike
