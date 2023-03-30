Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A0D6CF8D4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjC3Bqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjC3Bqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:46:35 -0400
X-Greylist: delayed 432 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Mar 2023 18:46:34 PDT
Received: from out-43.mta1.migadu.com (out-43.mta1.migadu.com [95.215.58.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193864EC7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:46:34 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680140360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CRtAjEk3igZQIfTfM49ftQ5UoUsPoHAyKF9/5xPdqA0=;
        b=Qbo9lUC+8EgPM+NurBk2ORdUoJ0Cbpx+aomUAtpb0jTMeQjqGB8RBWvCBCTVtT8SbOX/9j
        G+Sux+WQA8TE5ni6IaT+idyFNo/5zJBlD82UgIbT8VC4Y/oTscJPSf1GQwQ2L64sEMRAVF
        AtL5GHkDMIPZhLt935xbGIJAg2fFeBo=
Date:   Thu, 30 Mar 2023 01:39:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <b0e52380c54775073d44bc97f823ec4f@linux.dev>
Subject: Re: [PATCH] cpufreq: Fix policy->freq_table is NULL in
 __cpufreq_driver_target()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <CAJZ5v0iWkJw3KP7sfyDOyYsEkdOxxPhkYiYZMvd78geofGEECQ@mail.gmail.com>
References: <CAJZ5v0iWkJw3KP7sfyDOyYsEkdOxxPhkYiYZMvd78geofGEECQ@mail.gmail.com>
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

March 29, 2023 10:21 PM, "Rafael J. Wysocki" <rafael@kernel.org> wrote:=
=0A=0A> On Wed, Mar 29, 2023 at 3:36 PM Yajun Deng <yajun.deng@linux.dev>=
 wrote:=0A> =0A>> __resolve_freq() may be return target_freq if policy->f=
req_table is=0A>> NULL. In this case, it should return -EINVAL before __t=
arget_index().=0A> =0A> Even so, __target_index() itself doesn't derefere=
nce freq_table=0A> AFAICS, so arguably the driver should be prepared to d=
eal with a NULL=0A> freq_table which comes from it after all.=0A> =0A=0AB=
ut there is a statement 'unsigned int newfreq =3D policy->freq_table[inde=
x].frequency;'=0Ain __target_index(), if driver doesn't provide freq_tabl=
e, __target_index()=0Awill fault before the driver itself.=0A=0A> Or, if =
you want to argue that drivers providing ->target_index() must=0A> also p=
rovide freq_table that is not NULL, a check to that effect needs=0A> to b=
e done at the driver registration time IMO.=0A> =0A>> Signed-off-by: Yaju=
n Deng <yajun.deng@linux.dev>=0A>> ---=0A>> drivers/cpufreq/cpufreq.c | 2=
 +-=0A>> 1 file changed, 1 insertion(+), 1 deletion(-)=0A>> =0A>> diff --=
git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c=0A>> index c0=
e5be0fe2d6..308a3df1a940 100644=0A>> --- a/drivers/cpufreq/cpufreq.c=0A>>=
 +++ b/drivers/cpufreq/cpufreq.c=0A>> @@ -2299,7 +2299,7 @@ int __cpufreq=
_driver_target(struct cpufreq_policy *policy,=0A>> return cpufreq_driver-=
>target(policy, target_freq, relation);=0A>> }=0A>> =0A>> - if (!cpufreq_=
driver->target_index)=0A>> + if (!cpufreq_driver->target_index || !policy=
->freq_table)=0A>> return -EINVAL;=0A>> =0A>> return __target_index(polic=
y, policy->cached_resolved_idx);=0A>> --
