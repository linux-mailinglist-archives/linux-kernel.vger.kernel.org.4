Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A6B664C34
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjAJTSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjAJTSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:18:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78924BD49
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673378277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jZ+feJ2m4yA2ArXeG0OVBpYB1BtZroDRB1kQQe7pS8k=;
        b=jFbsPqEzDFyMDnt/PzhOtazi/ABRUfy4U8HtaLLAEqf6i4wjrKFxQjNVu0qQrMQ67y/eWz
        vHxt5iixHi4c8fF3RWLVsoYcQ4P1eMTZ9Virrus4DwbSZGQwtAq3RC+oN9rs2xYbBhqArY
        cNpfnYNZ10eR81B49cAQfIhUd7nPOSw=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-32-oVecO06kPhCycvbITSDLnw-1; Tue, 10 Jan 2023 14:17:56 -0500
X-MC-Unique: oVecO06kPhCycvbITSDLnw-1
Received: by mail-vs1-f71.google.com with SMTP id i189-20020a6722c6000000b003c51e0f417bso3068818vsi.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZ+feJ2m4yA2ArXeG0OVBpYB1BtZroDRB1kQQe7pS8k=;
        b=Lr6+gCyKIJaULZvsYnH51Ti70LAKLMLaMHX7RVJxov/epPU3sFOMl5pe7Vh0s/cgwB
         iDYslsr1a2+15DRzvXTkbOVFOc8leSsMDxEIxQD8SchWIfg38Mekd8yCfYzJZd8+v1Kl
         nTmuquMuA1JKO9wHoURUGz6DZM12glPLQ5lRGS56WvkFVWucqfBRXvmnVv6l7ltkuWHO
         GRofME2xQ6PhRXoKoY5ZxrEPoDsqS8NHCE/A9TbFNNCN1cG+Is24CHJvfEIEjfgA7uJd
         XmbcRi1yuhdPn3YtUn7IV9m+eqXILTiUnkcyxz7kxpBopvZ6uTtJEzp5BKbgHgh6eziC
         wtjw==
X-Gm-Message-State: AFqh2kpzw4OOaOGcE/ColLfo+alBnwFlXcWRgTcnhtU2AIYgVUHb+BhT
        I6XzHtxA5Rt/Fb0kiERTdTK5MMOBbnSEDc2fooedrEgO4lwJOdUwkhMWlKy37yWabvaBTGjFuLV
        CSej2PPe68hYtXGRST7o2Dby/
X-Received: by 2002:a05:6102:3e14:b0:3ce:c94b:6d51 with SMTP id j20-20020a0561023e1400b003cec94b6d51mr12742931vsv.12.1673378275958;
        Tue, 10 Jan 2023 11:17:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsbo2og8gbo8Ze9movt1n1dfsAP51A0XmFQmYuL+E/Gs7Loks7hc/RhXnvxBkHi6FGu6wrPZQ==
X-Received: by 2002:a05:6102:3e14:b0:3ce:c94b:6d51 with SMTP id j20-20020a0561023e1400b003cec94b6d51mr12742903vsv.12.1673378275703;
        Tue, 10 Jan 2023 11:17:55 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a258400b006fca1691425sm7672197qko.63.2023.01.10.11.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 11:17:55 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 5/7] x86/sched: Remove SD_ASYM_PACKING from the "SMT"
 domain
In-Reply-To: <20221229190249.GA14462@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-6-ricardo.neri-calderon@linux.intel.com>
 <Y5IKuJTjE6Pjrw9I@arm.com>
 <20221214165900.GA972@ranerica-svr.sc.intel.com>
 <xhsmhwn6s62b5.mognet@vschneid.remote.csb>
 <20221220004238.GB23844@ranerica-svr.sc.intel.com>
 <xhsmhr0wre5rg.mognet@vschneid.remote.csb>
 <20221229190249.GA14462@ranerica-svr.sc.intel.com>
Date:   Tue, 10 Jan 2023 19:17:51 +0000
Message-ID: <xhsmh1qo2dwrk.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/22 11:02, Ricardo Neri wrote:
> On Thu, Dec 22, 2022 at 04:56:51PM +0000, Valentin Schneider wrote:
>> diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
>> index 57bde66d95f7a..8dc16942135b4 100644
>> --- a/include/linux/sched/sd_flags.h
>> +++ b/include/linux/sched/sd_flags.h
>> @@ -132,12 +132,12 @@ SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
>>  /*
>>   * Place busy tasks earlier in the domain
>>   *
>> - * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
>> - *               up, but currently assumed to be set from the base domain
>> - *               upwards (see update_top_cache_domain()).
>> + * SHARED_PARENT: Usually set on the SMT level. Can be set further up if all
>> + *                siblings of an SMT core are identical, but SMT cores themselves
>> + *                have different priorites.
>>   * NEEDS_GROUPS: Load balancing flag.
>>   */
>> -SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
>> +SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
>
> But this would not work for Power7. It only has SD_ASYM_PACKING in the SMT
> sched domain. Must it have either of these flags?
>

It's not mandatory, but making sure SD flags conform to either of them
means the topology debugging infra can help spot misshapen topologies...

> In Power7 SMT siblings have the different priority but, IIUC, physical
> cores are identical.
>


...But you're right, this doesn't work with Power7 as it would need
SD_ASYM_PACKING all the way up the topology to conform with
SDF_SHARED_PARENT, which clearly doesn't work with how Power7 uses
asym_packing.

> It seems to me that asym_packing is specific to a domain.
>

For Power7 it is, since the asymmetry is only between siblings of a given
core. For other systems where the asymmetry is between cores, that could
theoretically affect several levels. Consider:

  DIE [                      ]
  MC  [          ][          ]
  SMT [    ][    ][    ][    ]
  CPU  0  1  2  3  4  5  6  7
  prio 3  3  2  2  1  1  0  0

As done in your patch, here asym_packing doesn't make sense for SMT, but it
does for MC and DIE.

Anywho, I think what this means if we should drop the SDF_SHARED_* metaflag
for SD_ASYM_PACKING, unless we can think of a nice way to programmatically
describe how SD_ASYM_PACKING should be set.

> Thanks and BR,
> Ricardo

