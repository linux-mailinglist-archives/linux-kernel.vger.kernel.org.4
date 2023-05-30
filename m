Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E00B715CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjE3LHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjE3LHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:07:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5A0EA0;
        Tue, 30 May 2023 04:07:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D21132F4;
        Tue, 30 May 2023 04:08:23 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4961B3F67D;
        Tue, 30 May 2023 04:07:36 -0700 (PDT)
Message-ID: <45bd04e4-d5f4-3469-d3f0-62e8fdcaacf4@arm.com>
Date:   Tue, 30 May 2023 13:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 00/17] Introduce runtime modifiable Energy Model
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230512095743.3393563-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 11:57, Lukasz Luba wrote:
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

Why is the feature set called Dynamic Energy Model?

Dynamic Energy Model:

  Runtime modifiable EM

  Proper CPU performance state evaluation

  CPU idle wakeup costs

  CPU capacity as new EM data

Didn't this `Dynamic` stand for the modifiability of the EM only?

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

This only mentions memory allocation and locking? A global design
overview, containing e.g.

  Why 2 tables, modifiable (a) and default (b)?

  Why does only EAS use (a)?

  (a) and (b) being the same performance state table until first call to
  modify (a) ()

as an introduction into the patches would be more helpful here.

> More detailed explanation and background can be found in presentations
> during LPC2022 [1][2] or in the documentation patches.

I checked 15/17 as well but could find any of this information there either.

[...]
