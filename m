Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E838469C7E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjBTJqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjBTJqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:46:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42478E06F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676886342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tL8B2IJ3QzRjEOlJw+TCCa9hYcVo1HGY2XFkCu5e8NI=;
        b=O5lqptU2bUjoKHvtGKoKPaScAj6An8wHfKE+sUJETylCRv6KqQqJ9ftp2uQFTvmvAeWxAi
        y7m2Azq2rTNhfJaw9OzzZUwipMLS6+lhE3GICyzwAo9U+lez5eibzS79wvY7RN7o7oLOtP
        djWbaCZJbAbFqMwFq2+17wykZSXUcic=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-C2BuXo-rMZC4MV1cKKxWXA-1; Mon, 20 Feb 2023 04:45:41 -0500
X-MC-Unique: C2BuXo-rMZC4MV1cKKxWXA-1
Received: by mail-wm1-f72.google.com with SMTP id x18-20020a1c7c12000000b003e1e7d3cf9fso406589wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tL8B2IJ3QzRjEOlJw+TCCa9hYcVo1HGY2XFkCu5e8NI=;
        b=zJ0VZ2sQfvzRCP12VN85gho77K1DP+WFKhaTZAqI4TbLIbWh0H8jyVfr0cDO5g9Lcc
         gyNAa4lZ3e0uBexz5Fez4Tzdk/8VbxbxoPDuj3HCj4ytaMnfnB3p4BA+61ZmVpV2QUgp
         tAOOr1J5u/UBBxNzEqNARX3RlAm9zw6Vb1euUOflvPQLfN1k8bbu+mDPoncbXaIaPdyz
         3vR+TPWzlzUy4dZrRQx4dg6DfTzBztIZz/H4WZ61wqHgh+lhtGmHqK31X/a69vEhzhht
         zN73JE0NksVAKEhEcdO2neIqhaYGRrEs2Ms8/h5LMawdN1CslbEXrd6X6DmmQsLEH4Wt
         RB+g==
X-Gm-Message-State: AO0yUKVrREISMOd5OGbIHqoZOqLseaJxYpSXXhbVlylyKB7MKR+yz3OF
        MTt8U8NdCHTyQZ/EtMjC6n5TOEqbnHYxBfLFdMrP3JAnS0zOJglA7x2QE7itpSrggaXwX/RMf5L
        2k4/lfIJ+SJEVMcYUYKkCIp5j
X-Received: by 2002:a5d:5282:0:b0:2c5:41f4:36bd with SMTP id c2-20020a5d5282000000b002c541f436bdmr704099wrv.47.1676886339781;
        Mon, 20 Feb 2023 01:45:39 -0800 (PST)
X-Google-Smtp-Source: AK7set/XicA+TezDyiF74kH58sVg9Np57+nw/agJ2OvASBXeKXA2tss81GAKb8Z02B2A8tB1lzkhCg==
X-Received: by 2002:a5d:5282:0:b0:2c5:41f4:36bd with SMTP id c2-20020a5d5282000000b002c541f436bdmr704074wrv.47.1676886339471;
        Mon, 20 Feb 2023 01:45:39 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id e16-20020adfe390000000b002c54c8e70b1sm1092395wrm.9.2023.02.20.01.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 01:45:38 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     hupu <921889738@qq.com>, peterz@infradead.org
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, juri.lelli@redhat.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org, mgorman@suse.de,
        rafael.j.wysocki@intel.com, ravi.v.shankar@intel.com,
        ricardo.neri-calderon@linux.intel.com, ricardo.neri@intel.com,
        rostedt@goodmis.org, srinivas.pandruvada@linux.intel.com,
        tim.c.chen@intel.com, tim.c.chen@linux.intel.com,
        vincent.guittot@linaro.org, x86@kernel.org, hupu@oppo.com
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
In-Reply-To: <tencent_60A804570F09C0CFE0495D5B984941123A05@qq.com>
References: <Y+Z2b/OtZDk9cT53@hirez.programming.kicks-ass.net>
 <tencent_60A804570F09C0CFE0495D5B984941123A05@qq.com>
Date:   Mon, 20 Feb 2023 09:45:37 +0000
Message-ID: <xhsmh1qmkr7pa.mognet@vschneid.remote.csb>
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

On 20/02/23 15:22, hupu wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>> Specifically, I'm thinking something in the degenerate area where it
>> looks if a given domain has equal depth children or so.
>
> By the way, in the last email you mentioned "the degenerate area". I can't understand what it means because of cultural differences. Does it refer to this scenario: sched_domain at the SMT layer is destroyed after an SMT thread goes offline, so mc_domain->child is NULL?
>

This references sched domain degeneration, cf. sd_parent_degenerate() and
sd_degenerate() in sched/topology.c

Sched domains are built following a layout described in
sched_domain_topology[], and depending on the actual CPU layout some
domains end up not being worth keeping (e.g. they only contain one CPU - we
need at least 2 to balance things), so we destroy (degenerate) them.

> hupu

