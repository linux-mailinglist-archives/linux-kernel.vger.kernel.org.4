Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314DF66E3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjAQQkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjAQQk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:40:26 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE511A96C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:40:25 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qx13so18321358ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GTyuWKOr1pC2uxxQv0c/I7B5bCOz1bp3wZvtbLnWzUM=;
        b=v213DfEj6zbfToDjnHFZ99w6mhKN8uvBm0OrW4B1G28+ZNEKWD26+8YU/exk6WliTt
         kIDKHXTHYlA2eC7eZzA68j/zTf+ftQV8OYxWPVc3YKljrkq86UVcNX21pAtfUeDpKkx3
         MDxo1fFhWnn8IrDyvYfVCqRO8nfbjs1j4X7v7KN7FQB2L9y9fZEAMcKojBVMdhb54yZj
         G3GQwdhvsrj1RhFDobowgtPXKmTAiy9AQVbGeAv2JVVMOGBcMwFDF0W53byGz9251dy1
         oll3eGXE69rPxqub4kX9jpGkj+NGB8YDBkVonpxVWlFvHwqZWKIS3wshoQs0sX4ishmY
         Y18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTyuWKOr1pC2uxxQv0c/I7B5bCOz1bp3wZvtbLnWzUM=;
        b=y3/LeTwpVbMZ8Gw/F2l+K5y5c7EPws51CKRZpfw0HMFpxewWlJ82a8A5lZc5Bhjm5R
         wWaxjtuY6H83RhN1YghEO/nF8Mg2k0iwPW6cA2qIRv2bkMQJyPUbQjAvjgUs6D6IoWW4
         FsXukfiMPtKbENFajQG0Twm85BA3uzgPyUk1QZBvao3BcYubRpc1eAQy6nINsrNNDpCF
         aw4aysirv96tBjn0sHCAxa7uF1pQCiW5iElFGQRu4tQWJHj+zmkCiWMTvXsdDy6bSNx8
         PKJ789p8KycRLvpQokdhNVLME6VkJCyM7IfpTqhJ5Y+s0mtJ8bG0uOn/g+69b2roAQey
         OQKw==
X-Gm-Message-State: AFqh2kqYiEGlVAyRcFP6UclXcMhBpXlLXPh0OwJDiJ4QvDkxQf4FcUOm
        1pt6ZiySxW/sZbFd8b6OoS9X3Q==
X-Google-Smtp-Source: AMrXdXtfv7Zx+1b2Rk9pgBUGebmjPtnfekHeaPlnSGx0cYRqO6AkgYO98l6GclFO7hG4jgKIrlWWlQ==
X-Received: by 2002:a17:906:ad8c:b0:86c:f643:89cb with SMTP id la12-20020a170906ad8c00b0086cf64389cbmr3303465ejb.23.1673973623673;
        Tue, 17 Jan 2023 08:40:23 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id fj17-20020a1709069c9100b00872f634db3asm886529ejc.208.2023.01.17.08.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 08:40:23 -0800 (PST)
Date:   Tue, 17 Jan 2023 16:40:21 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        mingo@kernel.org, peterz@infradead.org, rafael@kernel.org,
        viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com
Subject: Re: [PATCH v2] sched/fair: unlink misfit task from cpu overutilized
Message-ID: <20230117164021.tzkacw6h5gvc2eqd@airbuntu>
References: <20221228165415.3436-1-vincent.guittot@linaro.org>
 <Y8FhfyVyUDZ98hKD@e126311.manchester.arm.com>
 <CAKfTPtCmDA8WPrhFc8YxFXSOPOKasvvNWA3iOmRYcC2VSyMMrw@mail.gmail.com>
 <20230114211854.nmvmhtd5yz5wgh2a@airbuntu>
 <487f0252-c697-eb62-989d-57ee731691a2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <487f0252-c697-eb62-989d-57ee731691a2@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/16/23 09:21, Dietmar Eggemann wrote:
> On 14/01/2023 22:18, Qais Yousef wrote:
> > On 01/13/23 15:28, Vincent Guittot wrote:
> >> Hi Kajetan,
> >>
> >> On Fri, 13 Jan 2023 at 14:50, Kajetan Puchalski
> >> <kajetan.puchalski@arm.com> wrote:
> 
> [...]
> 
> >>> sched/uclamp: Fix a uninitialized variable warnings
> >>> (baseline_ufc) sched/fair: Check if prev_cpu has highest spare cap in feec()
> >>> sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition
> >>> sched/uclamp: Make cpu_overutilized() use util_fits_cpu()
> >>> sched/uclamp: Make asym_fits_capacity() use util_fits_cpu()
> >>> sched/uclamp: Make select_idle_capacity() use util_fits_cpu()
> >>> sched/uclamp: Fix fits_capacity() check in feec()
> >>> sched/uclamp: Make task_fits_capacity() use util_fits_cpu()
> >>> sched/uclamp: Fix relationship between uclamp and migration margin
> >>> (previous 'baseline' was here)
> >>>
> >>> I omitted the 3 patches relating directly to capacity_inversion but in
> > 
> > This could lead to confusion. Was there a specific reason for this omission?
> > Did you hit some problem?
> 
> I thought Vincent's 'split MF from CPU OU' should replace 'CapInv'?

Ah I thought my version was tested with these removed. Got ya now.


Cheers

--
Qais Yousef

> 
> https://lkml.kernel.org/r/20221209164739.GA24368@vingu-book
> 
> ... I have reverted patches:
> Revert "sched/fair: Detect capacity inversion"
> Revert "sched/fair: Consider capacity inversion in util_fits_cpu()"
> Revert "sched/uclamp: Make cpu_overutilized() use util_fits_cpu()" ...
> 
> You also mentioned this in
> https://lkml.kernel.org/r/<20230115001906.v7uq4ddodrbvye7d@airbuntu
> 
> [...]
