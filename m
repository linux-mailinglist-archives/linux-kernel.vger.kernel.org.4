Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6ED664C62
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbjAJTXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjAJTWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:22:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C3D5A8A3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673378489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0tcquH2WPqM6N2QYKoGswqk2PTA6lrKjh3bpNBpXPHI=;
        b=AkewyK9iW1bj9APddteJdQc2/4LESAtyU/+3DVBu7SIIQOWc4JUPjQlyoITHqb42Vjejm7
        z7uFd+zS11kz8mmDQmrpNXAEZ+be+cjEeK0lXVp9QU1scCx40YA+TQl3Yn49BYI48dPWbT
        wLiJsthkJ7WHUFK/PTD+yFYP96CYXzQ=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-438-A88E9aP9NIO02DFwJ754SQ-1; Tue, 10 Jan 2023 14:21:27 -0500
X-MC-Unique: A88E9aP9NIO02DFwJ754SQ-1
Received: by mail-ua1-f71.google.com with SMTP id o43-20020ab0596e000000b0038421e4c7deso5857430uad.19
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:21:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tcquH2WPqM6N2QYKoGswqk2PTA6lrKjh3bpNBpXPHI=;
        b=54rFJ7m/yeJ+Z/QQQhehLZHvGGR6ygzYa1yvYlr6s+yDqy/dWtGsKDqFHqD0d3DK3I
         JBK0bfB+Bm0Fhf5YEdJJjsfaRQX9ZqsDia2BU5LXmBODSMMhJ7bZOeMwiKBu+pMAZzf2
         Uya9PwAwj4QTq26vVKGS34h720WQZU8x4AgBZBY4HUX+R/hl8FDBUrqLjhmbno5kH96F
         Dg2tnuUZAA426ultGLbuqXZHyD0Ufl43C9iDtVsYLA33nuJs7ZgAj6pwVaNZObMfYB/I
         FmT7HVWY8jHKEa7WEVtwEBY7BbeYzzq4YuF6IyAFwkGNdwScDBrlPQA5BRX3WZujW9WM
         Xd3Q==
X-Gm-Message-State: AFqh2koXhqBliDR70wWrYhK4+NMu9ebRP71HXqFF5XPTsNVALYQ5D0dL
        C9PhCwoj4WvU6fJUcmnMjvOztm/KM7OdF86cHmYb2xfYr4yn5xPhFbZqybmagWe/FkxI1ncz0jW
        ZRJ5NInagaM0VHeIdW6XZs4Nz
X-Received: by 2002:a67:f149:0:b0:3ce:e2c7:d979 with SMTP id t9-20020a67f149000000b003cee2c7d979mr11336848vsm.30.1673378486531;
        Tue, 10 Jan 2023 11:21:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtBSeQ53sta0WKnbnjyQozoZjv/Y/VrcfVBysaolNsOfz55cVlYTn990cCrNzYmOp2VOQX/gg==
X-Received: by 2002:a67:f149:0:b0:3ce:e2c7:d979 with SMTP id t9-20020a67f149000000b003cee2c7d979mr11336829vsm.30.1673378486334;
        Tue, 10 Jan 2023 11:21:26 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b006fa12a74c53sm7534099qkp.61.2023.01.10.11.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 11:21:25 -0800 (PST)
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
Subject: Re: [PATCH v2 4/7] sched/fair: Introduce sched_smt_siblings_idle()
In-Reply-To: <20221224052850.GA8245@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-5-ricardo.neri-calderon@linux.intel.com>
 <xhsmhsfh7e5s9.mognet@vschneid.remote.csb>
 <20221224052850.GA8245@ranerica-svr.sc.intel.com>
Date:   Tue, 10 Jan 2023 19:21:23 +0000
Message-ID: <xhsmhy1qaci18.mognet@vschneid.remote.csb>
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

On 23/12/22 21:28, Ricardo Neri wrote:
> On Thu, Dec 22, 2022 at 04:56:22PM +0000, Valentin Schneider wrote:
>> On 22/11/22 12:35, Ricardo Neri wrote:
>> > Architectures that implement arch_asym_cpu_priority() may need to know the
>> > idle state of the SMT siblings of a CPU. The scheduler has this information
>> > and functionality. Expose it.
>> >
>> > Move the existing functionality outside of the NUMA code.
>> >
>> 
>> test_idle_cores() does something similar without an iteration, did you
>> consider using that instead?
>
> IIUC, test_idle_cores() returns true if there is at least one idle core in
> the package. In my case, I need to know the idle state of only the SMT
> siblings of a specific CPU. Am I missing something?
>

No, you're right, clearly I needed that end of the year break - sorry for
the noise.

> Thanks and BR,
> Ricardo

