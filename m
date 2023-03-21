Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03196C2B67
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCUHdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCUHdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:33:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E0249E1;
        Tue, 21 Mar 2023 00:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679383955; i=efault@gmx.de;
        bh=/Ww3gjQGQZcTzAYxQxATulnJBi0QHya7TGHCCXfWKGA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Hz1vkhEKqEev6KJdcQmS695AcU3BHN+eyIyBfz2wMMfclDRWwt4QM4Nn2VCP0v8mP
         4dIKKjlkWmwDBnZpbSRKwHWTF1z7Ky0VLT0TXOdrncGFc+jw9KK3Vg4HsVbu8zZ0sP
         COVAsDwxBBDMXwM45wzObjoAXBuC8r5vZ7+LDQeg/GwpGWccUytUEr2xlbllesiBVj
         sGozVEaC1ywRYH04kJLBpRxzeS6nPKzDZ6CPTuRFPBZ51W7Ys7CqieOmKBk//qcQSL
         AKD4KKTXtqnTRT0YRtaoGsDTuxXdfaro8f1LKQcX8uK7IWIvNmx6FK2guoz+Z9V8I6
         68gPlpccx5cSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.149.138]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1pjUZ7004w-00Dm5W; Tue, 21
 Mar 2023 08:32:35 +0100
Message-ID: <a32fe0a9986451d8713fced841df7d4b941f14f1.camel@gmx.de>
Subject: Re: [PATCH v3] perf sched: Fix sched latency analysis incorrect
From:   Mike Galbraith <efault@gmx.de>
To:     Chunxin Zang <zangchunxin@lixiang.com>, namhyung@kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Zhou <zhouchunhua@lixiang.com>
Date:   Tue, 21 Mar 2023 08:32:32 +0100
In-Reply-To: <20230317063246.1128219-1-zangchunxin@lixiang.com>
References: <20230317063246.1128219-1-zangchunxin@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V8GGcdSXjUpptc2+oP8VQLyOfg3Wjj6hobhXVazhAS9xcdFQkpM
 lGPPprT1uX0gYzpT2rEcJV2SqX0rX4X+dcKOcTRLStPCOjllqMlD5WfNdeH0e8uMTIaEgOr
 YbIZ0zCg485r+LA9g5e3OM5/0XQljSlZyga8xPHzuPjHXa22bs547NZb2BbZ/3WVZlfKTTj
 R00JFDxpX11Wj3KbFMmwQ==
UI-OutboundReport: notjunk:1;M01:P0:E6P9AvnU8BM=;cdC2BDuPxKpczD3tIeZUAWmv1Jl
 XRwKM9N+loJck0EC54RaT9dJGyeFlrUaJZe5RGRx6l5/3T3C77yXoM1gkPkyOCXlewQiwmsw/
 FPcZq+eV94lS3KG0OSOHnFCMJQVD2NpblQZdL7kgJAJKRqZ4nkEVNIthmJ8KpLmwUimjohRnV
 LGBWJHsDgdKFLOJ8VNlNMJQAujuZZXSE3uPy25eg2oQAs2GT+mej7WvLx0IZGlPj2qmitOG0Y
 A+G1WO3Hq/XN+VjrP1OPz6QHhkeYN/y/mo3XliX5NhH4Cb9/p6/h+3NjF89iDa6UmgeXE2u1j
 rdu650zmihnWHdrRf8c0l17TZbc1utkXytRxL1MPShhko03TCh9afHiXdEkFBhNQQFbT0zzXK
 le+XhhBBKm4dKgRpB23Idq7C8b12twajkoFlNgNq9AToOs04rXWXEBqnN0BCTL1qPlDrXszdx
 fdR4rr0whQc3cRQTI2reepXTryaDw2qmGEVEAUghIEEpkxtIxKZRJd9DljndnqQYwjKNCj70Q
 BeOviAPqgc6089LIbQa1vXYtmJCNhJxf/LP9NTmhuqRbPaBELoQ23XTh0/VipjW1iVQB1uBKo
 YRy/l3zKOctW5TuNIkZ2P/Veb7rZxD8/lIOYLdNoKAjmp+m46LW94idy0rZQTALlquFS+KJlr
 5ZEIjIQcd5iY2deAwkBb9xFgRaW8ztloz9oH03XtUC106WPSQAPqptxrAEgZhqEYEnAH8kAY3
 KR6i4P9yBL3Y1kGk+V4jZ0MPepHaNgHy0P5F+dwvTQ55iH16UHN50DsOwVUh3WBaA8vyLzWWg
 vakh4iYL4K8m9hReRe91fI3szGeUXCyoPZOhwe9NZgeYxnZzDLM/7GleBxNbRjXQLXyWU4uML
 f5dcIchWo8o+oNkf7iA/y5n4MPrIiKSWR2P7r6d2KJi5Jz9lh0KNZC+7bTq4MKCZB0s7WLJ2c
 oHUXeTkUMd06XX+Lsdo0SgYHijk=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-03-17 at 14:32 +0800, Chunxin Zang wrote:
> 'perf sched latency' is incorrect to get process schedule latency
> when it used 'sched:sched_wakeup' to analysis perf.data.
>
> Because 'perf record' prefer use 'sched:sched_waking' to
> 'sched:sched_wakeup' since commit d566a9c2d482 ("perf sched: Prefer
> sched_waking event when it exists"). It's very reasonable to
> evaluate process schedule latency.

Yeah, that makes a.. not so tiny difference.  Thanks.
(off to flush large pile of.. not data)

su - mikeg -c 'google-chrome-stable https://www.youtube.com/watch?v=3Daqz-=
KE-bpKQ > /dev/null 2>&1'&
massive_intr 8 9999&
# allow time to select display size/res
sleep 10
perf sched record -a -- cyclictest -Smqi 1234 -d 0&
sleep 300
killall cyclictest
sleep 1
killall massive_intr chrome

cyclictest output
T: 0 (10255) P: 0 I:1234 C: 194367 Min:      4 Act:   55 Avg:  484 Max:   =
22776
T: 1 (10256) P: 0 I:1234 C: 194346 Min:      6 Act:   57 Avg:  480 Max:   =
18589
T: 2 (10257) P: 0 I:1234 C: 194034 Min:      5 Act: 5214 Avg:  482 Max:   =
18530
T: 3 (10258) P: 0 I:1234 C: 192263 Min:      5 Act:   54 Avg:  513 Max:   =
19385
T: 4 (10259) P: 0 I:1234 C: 193350 Min:      6 Act:  728 Avg:  492 Max:   =
15951
T: 5 (10260) P: 0 I:1234 C: 196233 Min:      6 Act:   56 Avg:  469 Max:   =
17905
T: 6 (10261) P: 0 I:1234 C: 194181 Min:      5 Act:   67 Avg:  482 Max:   =
17997
T: 7 (10262) P: 0 I:1234 C: 196756 Min:      7 Act:  284 Avg:  468 Max:   =
16287

cyclictest bits of perf sched lat -p output, sorted ala cyclictest (local =
hackletlet sums delay)
 -------------------------------------------------------------------------=
----------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
----------------------------------
  cyclictest:10255      |   1280.359 ms |      294 | avg:   0.238 ms | max=
:   4.929 ms | sum:   69.921 ms |
  cyclictest:10256      |   1293.976 ms |      163 | avg:   0.463 ms | max=
:   6.619 ms | sum:   75.497 ms |
  cyclictest:10257      |   1259.701 ms |      206 | avg:   0.371 ms | max=
:   5.659 ms | sum:   76.453 ms |
  cyclictest:10258      |   1299.337 ms |      171 | avg:   0.440 ms | max=
:   4.210 ms | sum:   75.267 ms |
  cyclictest:10259      |   1436.543 ms |      181 | avg:   0.472 ms | max=
:   8.466 ms | sum:   85.473 ms |
  cyclictest:10260      |   1401.824 ms |      210 | avg:   0.386 ms | max=
:   7.007 ms | sum:   81.036 ms |
  cyclictest:10261      |   1336.621 ms |      190 | avg:   0.387 ms | max=
:   4.244 ms | sum:   73.593 ms |
  cyclictest:10262      |   1393.249 ms |      283 | avg:   0.268 ms | max=
:   4.381 ms | sum:   75.778 ms |
+patchlet
  cyclictest:10252      |    218.546 ms |    28657 | avg:   0.437 ms | max=
:  12.616 ms | sum:12514.777 ms | <=3D=3D *poof*
  cyclictest:10255      |   1280.359 ms |   194661 | avg:   0.431 ms | max=
:  22.722 ms | sum:83954.384 ms |
  cyclictest:10256      |   1293.976 ms |   194509 | avg:   0.427 ms | max=
:  18.537 ms | sum:83115.895 ms |
  cyclictest:10257      |   1259.701 ms |   194240 | avg:   0.429 ms | max=
:  18.509 ms | sum:83408.424 ms |
  cyclictest:10258      |   1299.337 ms |   192434 | avg:   0.460 ms | max=
:  19.331 ms | sum:88555.775 ms |
  cyclictest:10259      |   1436.543 ms |   193531 | avg:   0.439 ms | max=
:  15.897 ms | sum:84989.121 ms |
  cyclictest:10260      |   1401.824 ms |   196443 | avg:   0.417 ms | max=
:  17.852 ms | sum:81818.898 ms |
  cyclictest:10261      |   1336.621 ms |   194371 | avg:   0.429 ms | max=
:  17.944 ms | sum:83443.732 ms |
  cyclictest:10262      |   1393.249 ms |   197039 | avg:   0.415 ms | max=
:  16.232 ms | sum:81752.473 ms |


	-Mike
