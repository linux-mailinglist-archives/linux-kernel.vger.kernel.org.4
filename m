Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC85733A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjFPUPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjFPUPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E262035B8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686946496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3JQ9L36hZLZ9TAVM+ypgWl1na6I4Rf+gpRWjrdtaUpE=;
        b=GpAdSfVnVcgNeKzvna2nUA+tTW+KAiwJDYRwXupF4nbEWB4/tPnZcYT67enUKT46k/oSGk
        vGwJXsKA9uXtdY1k4gcSX6y/tQsNDVKsm1xtZxZ4DbtEcgcjbAAn14XiJtA8KeaTIfLSSU
        WQlvLTPUg36OECKLVQhqb+eWtXeApwA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-SBjuhV_AOXif94NypaoOtw-1; Fri, 16 Jun 2023 16:14:54 -0400
X-MC-Unique: SBjuhV_AOXif94NypaoOtw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f8f8e29771so3653495e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686946493; x=1689538493;
        h=in-reply-to:references:to:from:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3JQ9L36hZLZ9TAVM+ypgWl1na6I4Rf+gpRWjrdtaUpE=;
        b=a9dVjgPlA0jqOyO9EWWQNj9ZakTLB+5vJ6HUXoD896aYOjlgruj0EcXaPbzXUXJfYC
         6WOjdO820rRx+oiz5Bzx5O6pM1tzMFBQzKbUYOOfKWXG72Jol7lodQqdlM9v2zRtMwxr
         XcF6pQ2zPrn/FgAOTaXStyOzyhgtpmJemiQAkRs/Ndy0/CU91ywDpOHEsHEUl4iaI4o4
         WeKMsxQnSVoQSCg8SnPGQmpp9GocxGVCC9fifEcZ/mvfhqy2UTcbbmFHsvM6c3YHmZre
         jDPGOgXomFTOXOeFEx9xVKSSngM4Ciplg8vIOrCrwTNLdMfQTr4yGdcDb3UkXNfhx/cI
         ujHA==
X-Gm-Message-State: AC+VfDyep3ha/KUpMZQiJWiuK2q8el6Bb1Qrs5ypDp1lu0FxPw/ROSQC
        C1l/lqdo7pwSg+e8iKJLY9hv3POCH6zcAl8NTsblXrX8yriSh97phYFu0ihBdlvgLgwebVwWmAG
        6PuInN1D3xDPXZxRmoP5rEORN
X-Received: by 2002:a05:600c:84c3:b0:3f5:a54:9f97 with SMTP id er3-20020a05600c84c300b003f50a549f97mr7826908wmb.0.1686946493366;
        Fri, 16 Jun 2023 13:14:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5EaMjSu98pvp19fxL0jhIBvUrTBD2V4u7DP+Pu7477O03VOzPZ0jXMfQ1aRzvMdXLXrJZSAA==
X-Received: by 2002:a05:600c:84c3:b0:3f5:a54:9f97 with SMTP id er3-20020a05600c84c300b003f50a549f97mr7826895wmb.0.1686946493101;
        Fri, 16 Jun 2023 13:14:53 -0700 (PDT)
Received: from localhost (2a01cb000f8b970084d0c0d672c3677c.ipv6.abo.wanadoo.fr. [2a01:cb00:f8b:9700:84d0:c0d6:72c3:677c])
        by smtp.gmail.com with ESMTPSA id q9-20020a7bce89000000b003f7cb42fa20sm2969732wmj.42.2023.06.16.13.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 13:14:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 16 Jun 2023 22:14:52 +0200
Message-Id: <CTECMFWMMST3.9FTWRDG7FFKQ@ringo>
Subject: Re: [PATCH 0/5] x86/speculation: Disable IBRS when idle
Cc:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "Joe Mario" <jmario@redhat.com>
From:   "Robin Jarry" <rjarry@redhat.com>
To:     "Waiman Long" <longman@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H . Peter Anvin <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org> 
        , Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
        <pawan.kumar.gupta@linux.intel.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
        <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
        Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel
        Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider" 
        <vschneid@redhat.com>
X-Mailer: aerc/0.15.2-49-gd17c48e2f3c0-dirty
References: <20230616200003.745742-1-longman@redhat.com>
In-Reply-To: <20230616200003.745742-1-longman@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long, Jun 16, 2023 at 21:59:
> For Intel processors that need to turn on IBRS to protect against
> Spectre v2 and Retbleed, the IBRS bit in the SPEC_CTRL MSR affects
> the performance of the whole core even if only one thread is turning
> it on when running in the kernel. For user space heavy applications,
> the performance impact of occasionally turning IBRS on during syscalls
> shouldn't be significant. Unfortunately, that is not the case when the
> sibling thread is idling in the kernel. In that case, the performance
> impact can be significant.
>
> When DPDK is running on an isolated CPU thread processing network packets
> in user space while its sibling thread is idle. The performance of the
> busy DPDK thread with IBRS on and off in the sibling idle thread are:
>
>                                 IBRS on               IBRS off
>                                 -------               --------
>   packets/second:                  7.8M                  10.4M
>   avg tsc cycles/packet:         282.26                 209.86
>
> This is a 25% performance degradation. The test system is a Intel Xeon
> 4114 CPU @ 2.20GHz.
>
> This patch series turns off IBRS when in various idle mode to eliminate
> the performance impact of the idling thread on its busy sibling thread.

Hi Longman,

thanks a lot for the quick turnaround on this issue.

Tested-by: Robin Jarry <rjarry@redhat.com>

