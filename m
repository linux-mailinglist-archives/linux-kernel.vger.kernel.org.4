Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2D269212E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjBJOzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjBJOzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:55:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3B26C7C1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676040902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Ckzaa96MQzkpgEFh6wXwi8nzrk686ctY0YwJBmPzA4=;
        b=efUn5mKkSuaG3sgdaajQ7MjQR9+ltdxlqsuJrs8CcA+YOx9949/4nEdH62k6PUrEzdx8Sn
        bQBaz7Ov+3NPIn8DbdTUofXVobWaxNFjB+jHjbNtIBHC1WMXUZhPbha9JT5oJUAANxZY2M
        EndlYjRbLYmW1/RcnVc9d8q8UizM+hI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-usrfqotgPuK7k7CAxxhteg-1; Fri, 10 Feb 2023 09:55:00 -0500
X-MC-Unique: usrfqotgPuK7k7CAxxhteg-1
Received: by mail-qv1-f69.google.com with SMTP id ib5-20020a0562141c8500b0053c23b938a0so3246341qvb.17
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ckzaa96MQzkpgEFh6wXwi8nzrk686ctY0YwJBmPzA4=;
        b=fypqwPWjhxfo3Ewln44HH0eG5K9yr5/oInnA7UaTam0JYNtqnrgDX+g3JUJhGjJvyq
         vvUtqG9L0WuqUqip5zQZD3OEUjTIFLfJfPnTgPh18V8ZEVkLvZzhmzoFEaSl0rWQnbor
         OXWr3Xs0ZlXqlHpuQ5yM+VQkqJHM5JVC+2GpB/x+ryvT8Bm35zs8pFj0MkEE7NXiPuya
         RxfXoABTB11zZFCOk/bVjl6HWbpYKgk4iCxFpYueRMUsWNy9IyxYO6ad4CmrF7F7sBoh
         JWaalGN+iFcmLG6vQ11fRzms2IVxXoGV+APN4Gr4MCN9tYGD+Q9UWqw4KRiIlv0lhNol
         dZnw==
X-Gm-Message-State: AO0yUKVBfPUekgB+c7UYhRp5PsEFX0V5xJLRJk3qZbsx9ddUX0mHfteZ
        id57CmJ74e8g4Yp8L2UA3hb5zLs5MgxjhbLyTy/dYPqn3r54bPTjd/Olt9W5cwKfhTEreM5iHkh
        w7i89wNUGZf+bUXiFyudorj8W
X-Received: by 2002:a05:622a:146:b0:3b9:b43e:5733 with SMTP id v6-20020a05622a014600b003b9b43e5733mr26222596qtw.61.1676040900184;
        Fri, 10 Feb 2023 06:55:00 -0800 (PST)
X-Google-Smtp-Source: AK7set9kjy0cA8dQn5RLtBgGL/jLZtONQgPcJhBhstbwfh2fA3ZsfqffcBvZc4QRFyIQwQ9LV9FQRQ==
X-Received: by 2002:a05:622a:146:b0:3b9:b43e:5733 with SMTP id v6-20020a05622a014600b003b9b43e5733mr26222570qtw.61.1676040899952;
        Fri, 10 Feb 2023 06:54:59 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id u63-20020a379242000000b00731c30ac2e8sm3673397qkd.74.2023.02.10.06.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 06:54:59 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
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
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
In-Reply-To: <Y+YXrk5NRuWaSOGR@hirez.programming.kicks-ass.net>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
 <Y+YXrk5NRuWaSOGR@hirez.programming.kicks-ass.net>
Date:   Fri, 10 Feb 2023 14:54:56 +0000
Message-ID: <xhsmhmt5lr2nz.mognet@vschneid.remote.csb>
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

On 10/02/23 11:08, Peter Zijlstra wrote:
> On Mon, Feb 06, 2023 at 08:58:34PM -0800, Ricardo Neri wrote:
>> SD_PREFER_SIBLING is set from the SMT scheduling domain up to the first
>> non-NUMA domain (the exception is systems with SD_ASYM_CPUCAPACITY).
>>
>> Above the SMT sched domain, all domains have a child. The SD_PREFER_
>> SIBLING is honored always regardless of the scheduling domain at which the
>> load balance takes place.
>>
>> There are cases, however, in which the busiest CPU's sched domain has
>> child but the destination CPU's does not. Consider, for instance a non-SMT
>> core (or an SMT core with only one online sibling) doing load balance with
>> an SMT core at the MC level. SD_PREFER_SIBLING will not be honored. We are
>> left with a fully busy SMT core and an idle non-SMT core.
>>
>> Avoid inconsistent behavior. Use the prefer_sibling behavior at the current
>> scheduling domain, not its child.
>>
>> The NUMA sched domain does not have the SD_PREFER_SIBLING flag. Thus, we
>> will not spread load among NUMA sched groups, as desired.
>>
>
> Like many of the others; I don't much like this.
>
> Why not simply detect this asymmetric having of SMT and kill the
> PREFER_SIBLING flag on the SMT leafs in that case?
>
> Specifically, I'm thinking something in the degenerate area where it
> looks if a given domain has equal depth children or so.
>
> Note that this should not be tied to having special hardware, you can
> create the very same weirdness by just offlining a few SMT siblings and
> leaving a few on.

So something like have SD_PREFER_SIBLING affect the SD it's on (and not
its parent), but remove it from the lowest non-degenerated topology level?
(+ add it to the first NUMA level to keep things as they are, even if TBF I
find relying on it for NUMA balancing a bit odd).

