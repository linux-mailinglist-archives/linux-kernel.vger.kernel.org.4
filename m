Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5788766CF57
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjAPTKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjAPTKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:10:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2134A2798D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 11:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673896167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wr8XmZu9EBjO0WPK0qtcecPC5MDD0nBa8oSRFLTxPhE=;
        b=JQWu72Jh7htehXwpSmgFHeKqhVX0FOescV9wmj0dM+o18M5b+i5aN9ZgexgWdYxKuqYCgz
        gfT0dfRFbolIq8oiH6W93OXuBxUhtNqlf5i2V95fd6yo21tkiSz9UZ/SJlhcaimcn3uxtV
        /QS7HQ78eiTarwcoOBTIzuQ3pO2bD4U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-658-xeGHPpgqO2W4Gwmu3zG50w-1; Mon, 16 Jan 2023 14:08:17 -0500
X-MC-Unique: xeGHPpgqO2W4Gwmu3zG50w-1
Received: by mail-wm1-f70.google.com with SMTP id bi18-20020a05600c3d9200b003d991844dbcso18869019wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 11:08:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr8XmZu9EBjO0WPK0qtcecPC5MDD0nBa8oSRFLTxPhE=;
        b=T1k7eBlfSSurVg0TxcA44VtfZfO0fb3Y9rmHfuSW71pYx8NYpUwdRPZ1HfWImA5XY3
         CpUsZWHI2ctaSSx+q4R/QF3gKsyeUAuEJBYj9eqfZ02vLmX8OD9GyFiqOfRovMmJbUVi
         KSDwcSrCTiGqA8aqeNGjcsKngC8oGiJPEPq/YZNtFtegtrt9PSG9njr9w1ZWyK7NQpQ3
         AI0bSnpGEf+VfH+z7EADBKgwpzouNoUUZHIli3axowlcMtnARcF6L7xmOxdcXXVaIUmO
         tbbthge+WenH8NcCRB5mrmFasZ4NG8fhIV2oFXlDBy3/D2JcRUeDvb1lVQjy9pKDBe/n
         Wx9A==
X-Gm-Message-State: AFqh2ko4kIb260v5xYMD0Umwq2DIpmzGeqdYxmSyHM064HYi6HJ+fezB
        LbnOBkZXhDqPRgrk9c+RLKd9B7PJ+t/oVori2J9SjDKOkfW4OWl1FQfPwI7qpxuVcC8aBRXkJ/l
        /prJqPGfbHbDXZGxEboI5FXp8
X-Received: by 2002:a7b:c849:0:b0:3da:f651:7828 with SMTP id c9-20020a7bc849000000b003daf6517828mr577914wml.2.1673896076799;
        Mon, 16 Jan 2023 11:07:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvkoKy9I7yPBD2CNVxNnI4pXi5wuPin4AEuobT/WUTYYNfhQPzvWrzNXiZexaf5oOnuZMOYcA==
X-Received: by 2002:a7b:c849:0:b0:3da:f651:7828 with SMTP id c9-20020a7bc849000000b003daf6517828mr577892wml.2.1673896076501;
        Mon, 16 Jan 2023 11:07:56 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b003d34faca949sm34611196wmb.39.2023.01.16.11.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 11:07:55 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
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
Subject: Re: [PATCH v2 1/7] sched/fair: Generalize asym_packing logic for
 SMT local sched group
In-Reply-To: <20230116040529.GA16654@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-2-ricardo.neri-calderon@linux.intel.com>
 <xhsmhv8m3e5sx.mognet@vschneid.remote.csb>
 <20221229040003.GA11497@ranerica-svr.sc.intel.com>
 <xhsmhsfghcb20.mognet@vschneid.remote.csb>
 <20230113190226.GA1379@ranerica-svr.sc.intel.com>
 <20230116040529.GA16654@ranerica-svr.sc.intel.com>
Date:   Mon, 16 Jan 2023 19:07:54 +0000
Message-ID: <xhsmhtu0qi9h1.mognet@vschneid.remote.csb>
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

On 15/01/23 20:05, Ricardo Neri wrote:
>> >
>> > It should be set on any topology level below the NUMA ones, we do remove it
>> > on SD_ASYM_CPUCAPACITY levels because this used to interfere with misfit
>> > balancing (it would override the group_type), things are a bit different
>> > since Vincent's rewrite of load_balance() but I think we still want it off
>> > there.
>
> Your comment got me thinking. Whose child sched domain wants prefer_sibling?
> It sounds to me that is busiest's. I could not think of any reason of *having*
> to use the flags of the local group.
>

Hm, given that on systems without SD_ASYM_CPUCAPACITY, SD_PREFER_SIBLING is
set all the way from SMT up to the last !NUMA domain, should we just get
rid of the child/parent weirdness of SD_PREFER_SIBLING and stick with the
flags we are given at the level we're balancing at?

i.e.

        sds->prefer_sibling = env->sd & SD_PREFER_SIBLING;

Unless I'm reading this wrong, this also eliminates the effect of
SD_PREFER_SIBLING on the first NUMA level - DIE level has SD_PREFER_SIBLING
set, but we don't necessarily want to evenly spread things out when accross
NUMA nodes.


> We can use the flags of the sched group (as per 16d364ba6ef2 ("sched/topology:
> Introduce sched_group::flags"), these are the flags of the child domain).
>
> The patch below works for me and I don't have to even the number of busy CPUs.
> It should not interfere with misfit balancing either:
>

We remove that flag on systems where misfit balancing happens anyway, so
that's safe vs. SD_PREFER_SIBLING.

