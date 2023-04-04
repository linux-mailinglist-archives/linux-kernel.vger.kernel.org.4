Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB606D5703
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 05:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjDDDIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 23:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjDDDIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 23:08:43 -0400
Received: from out-53.mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683301705
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 20:08:39 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680577717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h2jWPezVO29/X7/c6BGQ5cVlKWQV5b6jUODU7F71l8g=;
        b=a8IcIEN7PmetPwAyDfihSGSTRo8CZoaaswAyktN+U/ZI87qi43VEdkEjA+wWSEGyLG9Cgc
        nZsQ5LbapVAiscw+UDxP/5dccH/+j3jBFAzFwtD8Th+/n+P9TSLdcpkVa48qCV3H7RhQyh
        Q6gKgeS/YD4HPHxFGp69ADhcSFyjUaw=
Date:   Tue, 04 Apr 2023 03:08:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <fa40602f182b028ec44c976a30a66ae6@linux.dev>
Subject: Re: [PATCH] cpufreq: Fix policy->freq_table is NULL in
 __cpufreq_driver_target()
To:     "Viresh Kumar" <viresh.kumar@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230403041128.jrsvbm4ddxdyhddg@vireshk-i7>
References: <20230403041128.jrsvbm4ddxdyhddg@vireshk-i7>
 <20230329133600.908723-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

April 3, 2023 12:11 PM, "Viresh Kumar" <viresh.kumar@linaro.org> wrote:=
=0A=0A> On 29-03-23, 21:36, Yajun Deng wrote:=0A> =0A>> __resolve_freq() =
may be return target_freq if policy->freq_table is=0A>> NULL. In this cas=
e, it should return -EINVAL before __target_index().=0A>> =0A>> Signed-of=
f-by: Yajun Deng <yajun.deng@linux.dev>=0A>> ---=0A>> drivers/cpufreq/cpu=
freq.c | 2 +-=0A>> 1 file changed, 1 insertion(+), 1 deletion(-)=0A>> =0A=
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c=0A>=
> index c0e5be0fe2d6..308a3df1a940 100644=0A>> --- a/drivers/cpufreq/cpuf=
req.c=0A>> +++ b/drivers/cpufreq/cpufreq.c=0A>> @@ -2299,7 +2299,7 @@ int=
 __cpufreq_driver_target(struct cpufreq_policy *policy,=0A>> return cpufr=
eq_driver->target(policy, target_freq, relation);=0A>> }=0A>> =0A>> - if =
(!cpufreq_driver->target_index)=0A>> + if (!cpufreq_driver->target_index =
|| !policy->freq_table)=0A>> return -EINVAL;=0A> =0A> Hi,=0A> =0A> I have=
 sent an alternate patch [1] for this, please try it.=0A>=0A =0AThanks, v=
2 is fine.=0A=0A> --=0A> viresh=0A> =0A> [1]=0A> https://lore.kernel.org/=
all/53d4ed4e5b18a59a48790434f8146fb207e11c49.1680494945.git.viresh.kumar@=
lin=0A> ro.org
