Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7AE64DEF8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiLOQtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiLOQtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:49:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C1B28E3F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671122900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AeRjj+8MmWxdEAxV6EReDqV2Agf4+dnbFZCe9Hm4o40=;
        b=HMemZ0jXpmTWxyTVjuq9MsEtKw2AcQMguoG7WY+LwvbA7JkaIGBxZY/4G61YuGG9yVTjCu
        zXAndzez0Uu5HJzVhzSFoqKwIbkn7vHHx75GLHHSy52n7kCUb/HZXh6ozDj6buL36S2SGi
        l4gjDUFpF5vQwGHpnMo4LDlyfnGbpDo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-104-bv-F7urUPxO32L38EuCpGQ-1; Thu, 15 Dec 2022 11:48:17 -0500
X-MC-Unique: bv-F7urUPxO32L38EuCpGQ-1
Received: by mail-wr1-f71.google.com with SMTP id a7-20020adfbc47000000b002421f817287so820810wrh.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AeRjj+8MmWxdEAxV6EReDqV2Agf4+dnbFZCe9Hm4o40=;
        b=kxUGRK9IRGD8e96z745tJpaA43Cttf/xq0RZE+gwtfUOywzs6003O8oPNOeJou7cUN
         vjTXPQJBXLqQLSLkm+g25ZuPB6s1G0xJEpbW3vmu/aOqOtB4MxTHvNs9XWaNAnVBhzzV
         8l0GiguifPAgYlu89FrQqMpO4DLi6T7la7gPrqOq5pfJbw5Mp42gTedu8NDPkgWqCkze
         9bJUn0aHdSgQ0TuAf6VLblUwr6PByXL0YK/jYNOD8zHmdkn31KP1OLIJ45z3Cj8oWvaO
         VfkitO1vyPQo64WI5w2DiePi+GhnIuaX+vcoB0cpJHCIIY0E7C/0xgWr3FD0gmhH/Yyt
         Ibuw==
X-Gm-Message-State: ANoB5pkHGsNEoP83zNFrADpiC/RjPpzH5OIiexLsdXrHwivQAv1b6zm9
        TxKvpiN137sBNi1OyNek1oR0nJWfYJmTBnkbCyPB39K9/TLhTHHGJwbIGUF/MpU0a6kdajzPyzq
        iJp8GsJW++oOw/a/ry5Wy/z6T
X-Received: by 2002:a5d:6543:0:b0:242:13bf:29de with SMTP id z3-20020a5d6543000000b0024213bf29demr17989487wrv.52.1671122896256;
        Thu, 15 Dec 2022 08:48:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6DRv5Bp89myhWTqGPIdEFD+SPDYJgrUlDzaMfNYrkf2hJCJ0XC7Q1Yl/SsB6Z+vWgeMXDuYw==
X-Received: by 2002:a5d:6543:0:b0:242:13bf:29de with SMTP id z3-20020a5d6543000000b0024213bf29demr17989469wrv.52.1671122896017;
        Thu, 15 Dec 2022 08:48:16 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4bd2000000b00236488f62d6sm6397672wrt.79.2022.12.15.08.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 08:48:15 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
In-Reply-To: <20221214165900.GA972@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-6-ricardo.neri-calderon@linux.intel.com>
 <Y5IKuJTjE6Pjrw9I@arm.com>
 <20221214165900.GA972@ranerica-svr.sc.intel.com>
Date:   Thu, 15 Dec 2022 16:48:14 +0000
Message-ID: <xhsmhwn6s62b5.mognet@vschneid.remote.csb>
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

On 14/12/22 08:59, Ricardo Neri wrote:
> On Thu, Dec 08, 2022 at 04:03:04PM +0000, Ionela Voinescu wrote:
>> Based on:
>>
>> kernel/sched/topology.c:
>> sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
>> rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
>>
>> and described at:
>>
>> include/linux/sched/sd_flags.h:
>> /*
>>  * Place busy tasks earlier in the domain
>>  *
>>  * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
>>  *               up, but currently assumed to be set from the base domain
>>  *               upwards (see update_top_cache_domain()).
>>  * NEEDS_GROUPS: Load balancing flag.
>>  */
>> SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
>>
>> doesn't your change result in sd_asym_packing being NULL?
>
> Yes. This is a good catch. Thanks!
>

Nice to see those being useful :-) FYI if you run your kernel with
CONFIG_SCHED_DEBUG=y and sched_debug on the cmdline, you should get a
warning at boot time from the topology debug code checking assertions
against those flags.

>>
>> The SD_ASYM_PACKING flag requires all children of a domain to have it set
>> as well. So having SMT not setting the flag, while CLUSTER and MC having
>> set the flag would result in a broken topology, right?
>
> I'd say that highest_flag_domain(..., flag) requires all children to have
> `flag`, but clearly the comment you quote allows for SD_ASYM_PACKING to
> be located in upper domains.
>
> Perhaps this can be fixed with a variant of highest_flag_domain() that do
> not require all children to have the flag?
>

So I gave that flag SDF_SHARED_CHILD because its cached SD pointer was set
up using highest_flag_domain(). Looking for the highest level where it is
set matches how it is used in nohz_balancer_kick(), so you might want a new
helper.

With that said, so far all but one flag (SD_PREFER_SIBLING, and that's
because of big.LITTLE woes) follow the SDF_SHARED_{CHILD, PARENT} pattern,
if SD_ASYM_PACKING no longer does then we need to think whether we're
trying to make it do funky things. I need to look at the rest of your
series to get an idea, that unfortunately won't be today but it's now in my
todolist.

> Thanks and BR,
> Ricardo

