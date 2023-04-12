Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F86C6DEA1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDLEGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDLEGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:06:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C321BE6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 21:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1681272336; i=efault@gmx.de;
        bh=fDqMdg5Dk+RoXAUeHNM9UNKYcp3mHr8CpSIifuktGfw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=mvGB+CGnydkAc+7lxLDA15GlSzgylX56UgeHoXTvt8iOi47xGB59Of+pe54DDqNE3
         R/4pHtxeENNe7m+XnncODd4UQhbm5aPpQMJ+zabOM5jTYoZqmPkcQ0KYvsZT/3fmAz
         MBZL7w65jyPuv6Ag5/uVUvvLGsiy4EjOLyrnHmOVTKYuGDwFGGiPSUI50BQK/FsJ13
         KqpBn9Bw1vw//oIOoBWwsGF6t09F3fNsom3IRX35J//VA80Si38hJ93E3B5mrTI5yk
         kRN/kDH9V0xZSPmJWmxhKejwSfCsRzGzSQth8Rj7IqTjvxaAoZpwdZH07xZw7jkLoJ
         v1GOqsLovZ7GQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.149.173]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeI2-1puAzs1ZSO-00RVTU; Wed, 12
 Apr 2023 06:05:36 +0200
Message-ID: <9954d9bb880bd1a2736853e19602f3b552b961e4.camel@gmx.de>
Subject: Re: [PATCH 00/17] sched: EEVDF using latency-nice
From:   Mike Galbraith <efault@gmx.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, bristot@redhat.com,
        corbet@lwn.net, kprateek.nayak@amd.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Date:   Wed, 12 Apr 2023 06:05:34 +0200
In-Reply-To: <20230412025042.1413-1-hdanton@sina.com>
References: <20230328092622.062917921@infradead.org>
         <20230410082307.1327-1-hdanton@sina.com>
         <20230411133333.1790-1-hdanton@sina.com>
         <20230412025042.1413-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZsIro73K9oEtSFjuh0yUwv6oaDl9aG7TSfqILiIisv+yf5UXPr5
 Hv5gnqadA2N+FWneWD7JQMzLAL61e2FSCOfj+GVNXrGmq4GwqkXl8TNAarSohBUYC22GFgn
 3zBOGn5yAMJkaeN+hD1o69BjkTd9QAfdrhDWJN7Axh7aodw5pkLPdn3UuoL/8Uh/mfdku2m
 ebPRxsu3LpH6VVB9040ZA==
UI-OutboundReport: notjunk:1;M01:P0:omXiVLhlkRM=;NjBSGlFVjdGC2kL9huaQT8uiKca
 GQRzH/gAgCGqQDT0eA82uEPa4C9r+ipx5X0FECOduOkpdUmwIS5G6uzidlDkdtkrMbNPJ2+5i
 CmvF4If2oeb0xuNO4xc0sZGGT4EePpryUKoQrE03q4kLSN5+813TatyHhCf13s1hAgxBa1nA9
 vq3F3ehXjjxYAju0cPur8QR3rOjPXUkgxUcls9hxU5rgRK3/KdMtEb6zxMyH5/GQJnOs0fhWS
 LOdQrw2F9jbJQ5ig/7j0A8GtxYmYzI3R3vqMGegXmMgA359M9nj1ggbAiEpzDXlZGhKWQdI4H
 JGFYp1IH9GCAfrgy31iBmiKDZFka3+e5Go4qhNeBlb9YfaKUJUCBzeQllfqZxYJa00nA3+6ms
 iFAC91P0EEaSHidbEsWacAM6c/0OwCVjtQ76kcIe28u0g+uHRTuyP8qFc9Vh/mGHDYHSlKixc
 qRy58tv/XRNRKUAWqVscNOOK0adQGG7cHFP1AkbCICwhzXMcfUT2HngAqQ4XFidZ8+vhD9FCv
 +a6HWbtdVhwmRkK2w0TBll/uCTRJJuNzc5AoqrrZUKezA/0URVDz542MpEQWWtJp2t6mJ22+k
 8TtGX/YDiQw1IG0JcBy//j2jl8R0PrkLxpZZffqjHbd++0EUw0JUBKjMkdonOjo+hOfdWmQqy
 jRAdYz0YzWQuVC07VpnQFXMEt1jwLikbyx55s8psIf9ijxseEdBsCDh5bNCM5X8YPOyW4tJjY
 2CMgshqmtHOmh7kJUTk0V0wfvNkoAkeXGfFjpC37+AwrTdY0j/nfjsMxGXGD30xGoeKzOq9kI
 e6seU4TJ+9m4kqDAa37snRT4754bdI1JP0p/MpWcds/Zs/VuwP5BTsVbyuEvsloShT/lCAtZq
 A9XZDzaG+FYPOwLfSNFMbYbYRXlr6okigi2ikibJtO3d690i3wlRDtD0NcqEY9+SbBsoQXkBX
 8CRBxifG0MleUE9BxNhN0jIarIY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-12 at 10:50 +0800, Hillf Danton wrote:
> On Tue, 11 Apr 2023 16:56:24 +0200 Mike Galbraith <efault@gmx.de>
>
>
> The data from you and David (lat_nice: -12 throughput: -.9% to 0.25%) is
> supporting eevdf, given a optimization <5% could be safely ignored in ge=
neral
> (while 10% good and 20% standing ovation).
>

There's nothing pro or con here, David's testing seems to agree with my
own testing that a bit of adjustment may be necessary and that's it.
Cold hard numbers to developer, completely optional mitigation tweak to
fellow tester.. and we're done.

	-Mike
