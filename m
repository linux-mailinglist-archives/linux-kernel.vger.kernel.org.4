Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A7870FC9D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjEXRZf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 13:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEXRZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:25:31 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1A21A1;
        Wed, 24 May 2023 10:25:19 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-96f66fbd770so34818066b.1;
        Wed, 24 May 2023 10:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684949118; x=1687541118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfy6ZF4afL0J7QBU8FDsTmh4rkOfTgkO/F08PTuQ2i0=;
        b=CPMWfAx+P7i4MkgNhxZArIHr/6tILS/F1yvQ7ayxxekXcP7ZaTNXkUuPkmLNSqdv5+
         Tpjg+ILFL9eyVgtNxj7O0WzYFMwKTWVHb2otVN4x0zxvHx5CltfHGw/7CiiUCUjDToKf
         FAV7ZnyTrdvLg8mze1b6TdyX5wSKtSny6JsPOGKivN/OtdCsa2Uu2GoGkB6y/V7KmY7+
         hpsniLEHnoh+rQ5802yjajvludySU4aLKUvcxG52fd5nmGOAiQKuphhyyLhH1M4lXYxc
         9TO6aNoTuh40ZpjSKvxAaXEhx6i1qn4Zmqc3xV5WkUHkSj7nPoyygXzmUl6cHK7uUNyw
         TRww==
X-Gm-Message-State: AC+VfDyneTcAcsLU63HDsVjAZtuZi6XkG53/U6FmAw89fGaNltEDj0zx
        ki6CRLt2peOqVQc35IfXEc0QtyP8D5afUlBRejU=
X-Google-Smtp-Source: ACHHUZ62HtPg0Ya/eYDJkq5f7Bfn91Vpe4lJNO/1jKLVHaOvrlKctqKg0UJg+4F6eK1KRc3M1Dy2WAEXkUZhzSvLYxY=
X-Received: by 2002:a17:906:7495:b0:94e:9efa:a9ed with SMTP id
 e21-20020a170906749500b0094e9efaa9edmr17370712ejl.7.1684949117892; Wed, 24
 May 2023 10:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
In-Reply-To: <20230512095743.3393563-1-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 19:25:06 +0200
Message-ID: <CAJZ5v0g5rTBiWOAzWSHqb+YgGxsLfMuYyYj7ChRZAYFHE1Aoaw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] Introduce runtime modifiable Energy Model
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Fri, May 12, 2023 at 11:58 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi all,
>
> This patch set adds a new feature which allows to modify Energy Model (EM)
> power values at runtime. It will allow to better reflect power model of
> a recent SoCs and silicon. Different characteristics of the power usage
> can be leveraged and thus better decisions made during task placement in EAS.
>
> It's part of feature set know as Dynamic Energy Model. It has been presented
> and discussed recently at OSPM2023 [3]. This patch set implements the 1st
> improvement for the EM.
>
> The concepts:
> 1. The CPU power usage can vary due to the workload that it's running or due
> to the temperature of the SoC. The same workload can use more power when the
> temperature of the silicon has increased (e.g. due to hot GPU or ISP).
> In such situation or EM can be adjusted and reflect the fact of increased
> power usage. That power increase is due to a factor called static power
> (sometimes called simply: leakage). The CPUs in recent SoCs are different.
> We have heterogeneous SoCs with 3 (or even 4) different microarchitectures.
> They are also built differently with High Performance (HP) cells or
> Low Power (LP) cells. They are affected by the temperature increase
> differently: HP cells have bigger leakage. The SW model can leverage that
> knowledge.
> 2. It is also possible to change the EM to better reflect the currently
> running workload. Usually the EM is derived from some average power values
> taken from experiments with benchmark (e.g. Dhrystone). The model derived
> from such scenario might not represent properly the workloads usually running
> on the device. Therefore, runtime modification of the EM allows to switch to
> a different model, when there is a need.
> 3. The EM can be adjusted after boot, when all the modules are loaded and
> more information about the SoC is available e.g. chip binning. This would help
> to better reflect the silicon characteristics. Thus, this EM modification
> API allows it now. It wasn't possible in the past and the EM had to be
> 'set in stone'.
>
> Some design details:
> The internal mechanisms for the memory allocation are handled internally in the
> EM. Kernel modules can just call the new API to update the EM data and the
> new memory would be provided and owned by the EM. The EM memory is used by
> EAS, which impacts those design decisions. The EM writers are protected by
> a mutex. This new runtime modified EM table is protected using RCU mechanism,
> which fits the current EAS hot path (which already uses RCU read lock).
> The unregister API handles only non-CPU (e.g. GPU, ISP) devices and uses the
> same mutex as EM modifiers to make sure the memory is safely freed.
>
> More detailed explanation and background can be found in presentations
> during LPC2022 [1][2] or in the documentation patches.
>
> Changelog:
> v2:
> - solved build warning of unused variable in patch 13/17 when EM is
>   not compiled in, e.g. on Intel platform for this cpufreq_cooling
> - re-based on top of v6.4-rc1
> v1:
> - implementation can be found here [4]
>
> [1] https://lpc.events/event/16/contributions/1341/attachments/955/1873/Dynamic_Energy_Model_to_handle_leakage_power.pdf
> [2] https://lpc.events/event/16/contributions/1194/attachments/1114/2139/LPC2022_Energy_model_accuracy.pdf
> [3] https://www.youtube.com/watch?v=2C-5uikSbtM&list=PL0fKordpLTjKsBOUcZqnzlHShri4YBL1H
> [4] https://lore.kernel.org/lkml/20230314103357.26010-1-lukasz.luba@arm.com/
>
> Lukasz Luba (17):
>   PM: EM: Refactor em_cpufreq_update_efficiencies() arguments
>   PM: EM: Find first CPU online while updating OPP efficiency
>   PM: EM: Refactor em_pd_get_efficient_state() to be more flexible
>   PM: EM: Create a new function em_compute_costs()
>   trace: energy_model: Add trace event for EM runtime modifications
>   PM: EM: Add update_power() callback for runtime modifications
>   PM: EM: Check if the get_cost() callback is present in
>     em_compute_costs()
>   PM: EM: Introduce runtime modifiable table
>   PM: EM: Add RCU mechanism which safely cleans the old data
>   PM: EM: Add runtime update interface to modify EM power
>   PM: EM: Use runtime modified EM for CPUs energy estimation in EAS
>   PM: EM: Add argument to get_cost() for runtime modification
>   PM: EM: Refactor struct em_perf_domain and add default_table
>   Documentation: EM: Add a new section about the design
>   Documentation: EM: Add a runtime modifiable EM design description
>   Documentation: EM: Add example with driver modifying the EM
>   Documentation: EM: Describe the API of runtime modifications

I haven't seen any responses from anyone having a vested interest in
the Energy Model code.

I'm not sure what this means, but I surely can't do much about it
myself without any input from the potentially interested parties.

Thanks!
