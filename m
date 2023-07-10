Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F099174DF60
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjGJUev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjGJUet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423A9195
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689021239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lJI+QBvgwcjI/292fBS/27avXozoLMIj5iHUDycp5v0=;
        b=WyGXVjMxe83Chzvr2Q3vnJyzuRQNMno7UUHyjzl0gMM2cRKU+OwpETua3RlimWwU56SFZy
        ARa2UoQQtK8np1FTiiryXZuiEoLebyAdoN0qA5y0eyVeR523iZVDWQUbisGRvULVGWRUX6
        cmsIQEso0Eg4GSC2K+GQc9yjovCpDgc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-1ZfCNy_tMZGHh_KN8xTygQ-1; Mon, 10 Jul 2023 16:33:58 -0400
X-MC-Unique: 1ZfCNy_tMZGHh_KN8xTygQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-765a632f342so531312485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689021238; x=1691613238;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJI+QBvgwcjI/292fBS/27avXozoLMIj5iHUDycp5v0=;
        b=hcTl4jOMW5+XHHlN+0a+xleryw/4+hgbTj4JVh+zIoE2KXYvbrtEzqiKlReCpkQyw+
         d9/FW9EESZFA1mKPlrS9KMFsZNHHBB4tOiAmkNVqUFfnpP8VcVcg5Kqa8p29aubEU5T1
         n6EpORjFvNnlTDwpyC760YEx0LzA1guqwEY+mmLHcDhHv1VVFNBauuvL1yminpnFmKaO
         1oidi/KBfBH4Hvv0KAKJwQzWG/B/nUU43shyg0OemVK/LTSZ8hLv/+XWVbyyP2TucHpY
         baRXMYhrIC7cvqzRQgrJENLzi/QeRX34OZ1UMr5adz1yke9qWA29fy/+dWTolCKSSNHh
         HjRw==
X-Gm-Message-State: ABy/qLYfURQhWzt9UNX1sXa2mXVdEhd2FliqAPVC3ZM05vLl20wL4F2n
        W79+nOhrdK232spDg2ThXr/fjRMLF3Xu0tsC6A4Q3r588Jtm972lVXhAZs5CPh7H/o0XqgakNqp
        l3WWMurJjhRxbj1FtuniR9XNq
X-Received: by 2002:a05:620a:40d2:b0:766:f9a5:c80e with SMTP id g18-20020a05620a40d200b00766f9a5c80emr16902829qko.61.1689021237870;
        Mon, 10 Jul 2023 13:33:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGe8Q24G/iQIwNmz+NfeqMejT5Gv3zwZfeqQL2PzLsUm2UrW6Azy1utNSi/7fDeS7vcjIUNcA==
X-Received: by 2002:a05:620a:40d2:b0:766:f9a5:c80e with SMTP id g18-20020a05620a40d200b00766f9a5c80emr16902816qko.61.1689021237674;
        Mon, 10 Jul 2023 13:33:57 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id e9-20020a05620a12c900b00767ccf42f3csm221739qkl.66.2023.07.10.13.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:33:57 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [Patch v3 6/6] sched/debug: Dump domains' sched group flags
In-Reply-To: <ed1749262d94d95a8296c86a415999eda90bcfe3.1688770494.git.tim.c.chen@linux.intel.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
 <ed1749262d94d95a8296c86a415999eda90bcfe3.1688770494.git.tim.c.chen@linux.intel.com>
Date:   Mon, 10 Jul 2023 21:33:53 +0100
Message-ID: <xhsmhcz0zv74e.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/23 15:57, Tim Chen wrote:
> From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>
> There have been a case where the SD_SHARE_CPUCAPACITY sched group flag
> in a parent domain were not set and propagated properly when a degenerate
> domain is removed.
>
> Add dump of domain sched group flags of a CPU to make debug easier
> in the future.
>
> Usage:
> cat /debug/sched/domains/cpu0/domain1/groups_flags
> to dump cpu0 domain1's sched group flags.
>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

