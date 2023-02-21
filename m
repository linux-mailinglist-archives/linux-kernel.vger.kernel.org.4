Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7027569E73E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBUSQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBUSQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4B52E0D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677003341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7gsp6c5zC+n8RdVfxNnpTz1aW0fmy91m04gbSxIcYaY=;
        b=f/FwpVtIW7OnOXV20Dzdr5Bb0pLww7M+DSGv0YLrpk/zqKB9e3YjzWfswVoUa5Pk3MKku7
        wSrfOEbuKK75L1Q9j9elpgndG74TMDX5tidAFuxMARk3pK11JUkgNTNCKzABxxEw5VoFfE
        RW92zhRW7zax8a8TGhF58oNt++/MHIA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-582-qvwLPZBNOW-ZLPX5W6FTJA-1; Tue, 21 Feb 2023 13:15:38 -0500
X-MC-Unique: qvwLPZBNOW-ZLPX5W6FTJA-1
Received: by mail-wm1-f71.google.com with SMTP id bg26-20020a05600c3c9a00b003e21a3f4e84so2001254wmb.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gsp6c5zC+n8RdVfxNnpTz1aW0fmy91m04gbSxIcYaY=;
        b=AFfiaAPYXYMHUrhYLcQZ0UZWSd64ztyyTWMIHDsK9mkV0dyZHtAL6WSDiGoxqd1nDe
         5Orlq9oNk9vgY/7caFUSrxoR6pObFTn0bJkUJ2/oR65rWsKN/0+Ez0WDByFrVWO256Pr
         fNtgCRp5irQXFJcmpIHaiyTmDsR3Kr1oIRyxAvsDjVoGXWuTj6/66LtW6iUqLulCISGc
         cGOKueU0KqDD+8EYTVHYF7az6ClVEQPh/Wi4D6wPUP/3sQbUf4Schtb8+2H/L7IqIKYX
         SLZzbviZfL2VdTwAfhpFY1WX7DAoDMDgxTA9GhK5op3SdcRsyg+V7XfUs9/3QiD3tvlF
         rkHA==
X-Gm-Message-State: AO0yUKUKR+7H3gqTvLvud8yyhl2iCOeYk9eGeb0PO4BZxbDkkikEWfRR
        Y0sqGYe4v9X793JraH90cq1lOn8jUDSe5wyQkhAR4vRPy8af5zphd15Xt7GYyU8sVkO6SwjJK7b
        T4IjWzvNtBVpK2N6bExw5FzKq
X-Received: by 2002:a05:600c:4b28:b0:3e2:9b4:4303 with SMTP id i40-20020a05600c4b2800b003e209b44303mr3598101wmp.19.1677003337667;
        Tue, 21 Feb 2023 10:15:37 -0800 (PST)
X-Google-Smtp-Source: AK7set8O4E4dOLUoULcTz2JAxG5OwJjd8ems/WBAnuxq0Oi5RF8s5cxsUvpQuFeERCpIG6csS53cpQ==
X-Received: by 2002:a05:600c:4b28:b0:3e2:9b4:4303 with SMTP id i40-20020a05600c4b2800b003e209b44303mr3598077wmp.19.1677003337374;
        Tue, 21 Feb 2023 10:15:37 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id s14-20020a5d510e000000b002c569acab1esm5494874wrt.73.2023.02.21.10.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:15:36 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     tmmdh <921889738@qq.com>, hupu <921889738@qq.com>,
        peterz@infradead.org
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        hupu@oppo.com, ionela.voinescu@arm.com, juri.lelli@redhat.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org, mgorman@suse.de,
        rafael.j.wysocki@intel.com, ravi.v.shankar@intel.com,
        ricardo.neri-calderon@linux.intel.com, ricardo.neri@intel.com,
        rostedt@goodmis.org, srinivas.pandruvada@linux.intel.com,
        tim.c.chen@intel.com, tim.c.chen@linux.intel.com,
        vincent.guittot@linaro.org, x86@kernel.org
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
In-Reply-To: <tencent_6C38D389245FD03C6E1312999FEDD394F606@qq.com>
References: <xhsmh1qmkr7pa.mognet@vschneid.remote.csb>
 <tencent_6C38D389245FD03C6E1312999FEDD394F606@qq.com>
Date:   Tue, 21 Feb 2023 18:15:34 +0000
Message-ID: <xhsmhttzeq3zt.mognet@vschneid.remote.csb>
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

On 21/02/23 17:49, tmmdh wrote:
> From: Valentin Schneider <vschneid@redhat.com>
> But I am still confused by Peter's description about prefer_sibling in the last email, linked at
> https://lore.kernel.org/all/Y+Z2b%2FOtZDk9cT53@hirez.programming.kicks-ass.net/
>> this morning -- conceptually, prefer siblings says you want to try
>> sibling domains before filling up your current domain.
>
> Why should we try sibling domains before filling up your current domain? Why does Peter think that sibling domains is better than current domain.
> My understanding about this problem is described as follows, but I am not
> sure if it is correct. I think the sibling domain is a domain lower than
> the current level. Just like SMT is the sibling of MC, while DIE is the
> sibling of NUMA.

That's the wrong way around; going up (or down) the sched_domain hierarchy is
done via parent (or child) pointers. Sibling means going sideways (i.e. the
same topology level but viewed from a different CPU)

> Is it because the cpus covered by sibling domains share more resources (such as cache), which can improve the performance of task running?
>

If sibling domains are in same cache hierarchy then spreading tasks between
them can improve overall performance. That doesn't work with NUMA or
big.LITTLE domains, so we don't have the flag on those.

