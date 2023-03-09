Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7B76B1A63
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 05:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCIEYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 23:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCIEYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 23:24:34 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B30082367
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 20:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678335817; i=efault@gmx.de;
        bh=KfvLndxdTzmhoJRfLolpgNbL3nfQSK5TmGqgtH5dkts=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=milvhtugmHPH/rUMXitmpSiCc+u+dbJXyX2zoqs9mIHnLKXIfVHhrfHCTujMc8xxX
         Fz8RxmvgHlNW1Po5Iqrbvfuje10s1905RzbiET2NT5J9HN9EcxmjCABCpppZZWfGvM
         RQGkSLBmG5IuRCyePckAuejtcqHe6LrJBQywYfztr1Jag8j/4i3GWyCuj2FX4ykDYQ
         1eKTrCtgUrwQClRaCcO136WZT2L6/U7w9MQWVK2kk11usdZYlNhhmtHyoXljjmrRkU
         ckdOqAEZPQdzn8EPtpjlrJtGLTmWXxp9MajrfLtKF2MlPU1Lh9pAW53sO8s3OmZJLA
         wRkOn6nVwlHIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.148.100]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KUd-1qbiro0EFV-016jSQ; Thu, 09
 Mar 2023 05:23:37 +0100
Message-ID: <5b567c5aecabf0a89d92593d99a73bef41bd65da.camel@gmx.de>
Subject: Re: [PATCH 10/10] sched/fair: Implement an EEVDF like policy
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Date:   Thu, 09 Mar 2023 05:23:33 +0100
In-Reply-To: <9fd2c37a05713c206dcbd5866f67ce779f315e9e.camel@gmx.de>
References: <20230306132521.968182689@infradead.org>
         <20230306141502.810909205@infradead.org>
         <bfbfbf041854e2cd1a8ed14e64081062e5d632d3.camel@gmx.de>
         <9fd2c37a05713c206dcbd5866f67ce779f315e9e.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gyEVNLLsHh70EpY8nWEULGirPZSFS8ZDWHMYRuZtsZX2qgzTAmx
 bcsat0mo7pLoJNRR5/TVanemJJCjDaMhWxqzTQf6MoegZq5/xGUvhwjP/pBn8OfmbPtDIJO
 5SCMrMaaXEQmj6sO1UziqJOFOsfaEv83qToLKebjKaUsGMtsYmxhfkeBUoikmRGrbYyQYJF
 R7jo4STPDoc5ARIQh/82A==
UI-OutboundReport: notjunk:1;M01:P0:NdsbBeukE0A=;1rPHJLvjPT8sLS7sWDhN32NdEFV
 2BK8weVwvDfJwhJV8IPkYMld5+i/Ushims4pRnpOTD/SmB/N6nada6ciVZz2Dyc99vWTHpkm2
 gIC/t1onVDlH/MIDjeqUpdoxNTUEtmynsOHGYUBLa/1+RfNssFUtKdta45iehFaCekxKOr6Bf
 rZQ1P/0sCsMW6pL54uLEcK45+UAsvf9WOZL0mPng3Ye1j8stPtrD76atZwnY8P043r0QLJBbV
 vhi5Wxgkt4s8cOa2uxwdDVQaNs74YW9rXBY7n1Odc6GS2b4u4CFSuOrqnxgiQviNe7l6YHzDR
 WOFYSEC3vhMDnuvS1WWTdzE8Ad0Xg2kiijjvH3FhymO2XHT1tAD3p9qq0Znik0qX8W+wkUq5m
 CGz0SAk9+wYJOFZTovjywlJbM+EQbRru8fo9Q4u1xyo2E0OYEqqz/TWGCR77AqqqEogb0AHlw
 lHIplzhcXu8ewJKPY8ZFCH4isD4Egs9WCpGEwdk/ZKF27f0GsGD03kv4buP/9PweW6N5sD9pD
 t2zjzGRrLEt2tgE1EtcGMGysBrDSiUI1oBX7Jy9aHPywb7S58Zwtw5qzGybgAi9oe04EjC+YY
 nBistoXdavFi5sRpOgfwuEO0sjzI0JZYBTACxgGs7iuJXFVdsrVro5ITQuRV1pr56tlBv3lxy
 JXkwpckhLj18haPm90AgSLxNLPI9pfu9LR+hzxwbvHkw+Ps5AfcO5SljTKX+oZ9BZloxcnYcZ
 6gcRHV9Znp9IuLzhsUadaerX1ydyOB9nf6+gEnVjw3OkVX+B4t/N1hsc4KcMcIzXDM5lJ9tf+
 17NiAUlSJppvdDBg3dG5Ama81l4oPP10YgN5fkfzPZaiBjRsf30Sk78nfUp07TC8dfCiT6xki
 sMpQZ3INSbLTeZbCd9CCdVgvfvZtNMYmQuGdGniEd5W3AGmEHWVIrWQx+C1akjfnQ/zyXG/F1
 i1GoQUaUPObsBdKxQzHqaiJah/c=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-03-08 at 14:36 +0100, Mike Galbraith wrote:
>
> Remember this little bugger, allegedly distilled from a real
> application control thread starvation issue?
>
> 6.3.0.g8ca09d5-master
> homer:/root # time taskset -c 3 starve=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
> expecting to receive 10000000 signals
>
> real=C2=A0=C2=A0=C2=A0 0m24.424s
> user=C2=A0=C2=A0=C2=A0 0m4.468s
> sys=C2=A0=C2=A0=C2=A0=C2=A0 0m18.957s
>
> 6.3.0.g8ca09d5-eevdf
> homer:/root # time taskset -c 3 starve
> expecting to receive 10000000 signals
> zzzzzz
> ^C

Ok, seems there must be a math booboo lurking.

virgin source, 100% hog vs tbench buddy pair, all pinned.

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ P COM=
MAND
 5060 root      20   0    4420    680    680 R 96.01 0.004   0:41.40 3 cpu=
hog
 5058 root      20   0   25500   1920   1792 S 2.326 0.012   0:01.05 3 tbe=
nch
 5059 root      20   0    8796    896    768 R 1.661 0.006   0:00.78 3 tbe=
nch_srv

echo NO_PRESERVE_LAG > features

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ P COM=
MAND
 5060 root      20   0    4420    680    680 R 99.33 0.004   1:28.24 3 cpu=
hog
 5058 root      20   0   25500   1920   1792 R 0.333 0.012   0:01.75 3 tbe=
nch
 5059 root      20   0    8796    896    768 S 0.333 0.006   0:01.30 3 tbe=
nch_srv

