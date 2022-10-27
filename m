Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928F560F1C0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiJ0ICX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbiJ0IB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:01:58 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A2C27911
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:01:55 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666857713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vVjJzq3U20aYMF/dJkFMJFu3ZKsg/eho1ketNisEpgI=;
        b=NubST/zblFSFf3RDRcfxowq05OdFMo1aMiZVzokilLMCp97dwkDbtC+L01d0fJoRfrfEbh
        ehsLLqZXLerM/wmoZdk7ZGzMzBAlkpK2dEsaEcOll3E2tQAr8+N7shzqrWU9zexBgzbX6L
        Y5WYI/vJN7t0hAJ557vRJgzwXfCkwu0=
Date:   Thu, 27 Oct 2022 08:01:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <d57108689d0ab40cf6e51829bb938a2b@linux.dev>
Subject: Re: [PATCH] sched/fair: Remove max_vruntime() and min_vruntime()
To:     "Peter Zijlstra" <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y1o5i1Trk2aRZY4q@hirez.programming.kicks-ass.net>
References: <Y1o5i1Trk2aRZY4q@hirez.programming.kicks-ass.net>
 <20221027015351.2511149-1-yajun.deng@linux.dev>
 <Y1o5ILxBd9erW5zR@hirez.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

October 27, 2022 3:55 PM, "Peter Zijlstra" <peterz@infradead.org> wrote:=
=0A=0A> On Thu, Oct 27, 2022 at 09:54:09AM +0200, Peter Zijlstra wrote:=
=0A> =0A>> On Thu, Oct 27, 2022 at 09:53:51AM +0800, Yajun Deng wrote:=0A=
>> There is no need to write max_vruntime() and min_vruntime() functions,=
=0A>> we can use max_t() and min_t() instead.=0A>> =0A>> Here; I did your=
 homework for you:=0A>> =0A=0AThanks for your guidance.=0A=0A>> /* max.c =
*/=0A>> #include <stdio.h>=0A>> #include <stdint.h>=0A>> #include <stdlib=
.h>=0A>> =0A>> typedef unsigned long long u64;=0A>> typedef unsigned long=
 long s64;=0A> =0A> This should obviously be just 'long long', but the re=
sult doesn't=0A> change.=0A> =0A> /me goes goes get more wake-up juice.=
=0A> =0A>> static u64 max_vruntime(u64 max_vruntime, u64 vruntime)=0A>> {=
=0A>> s64 delta =3D (s64)(vruntime - max_vruntime);=0A>> if (delta > 0)=
=0A>> max_vruntime =3D vruntime;=0A>> return max_vruntime;=0A>> }=0A>> =
=0A>> static u64 max(u64 a, u64 b)=0A>> {=0A>> return a > b ? a : b;=0A>>=
 }=0A>> =0A>> int main(int argc, char **argv)=0A>> {=0A>> u64 a, b;=0A>> =
=0A>> if (argc < 3)=0A>> return 0;=0A>> =0A>> a =3D strtoll(argv[1], NULL=
, 10);=0A>> b =3D strtoll(argv[2], NULL, 10);=0A>> printf(" max(%lu, %lu)=
 =3D %lu\n", a, b, max(a,b));=0A>> printf("max_vruntime(%lu, %lu) =3D %lu=
\n", a, b, max_vruntime(a,b));=0A>> =0A>> return 0;=0A>> }=0A>> =0A>> $ .=
/max -1 0=0A>> max(18446744073709551615, 0) =3D 18446744073709551615=0A>>=
 max_vruntime(18446744073709551615, 0) =3D=200
