Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208D66F0085
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 07:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbjD0FyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 01:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjD0FyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 01:54:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E033585
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 22:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682574820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TACSMy7Ug2sStH4pdeuOCgf93fUckqHIu/mqCYHofQw=;
        b=XVNW1wgPbTq2Wv5jTK68psaFLmA2e24+R4WpApAh78TzlYzXMcRSQTqC2zIsrPv9Nu9exk
        cczcLeDln4EAPEZHFMm5TY6vXfzygytot21LUI9Vo6ZB/TByQnfgW3Ovp9qGPHTzbRjdnW
        O5vT6uFbw03XRh9QX59vJOFFRwl3+ag=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-GUvXmIezPqCQDz1gc7gAbA-1; Thu, 27 Apr 2023 01:53:38 -0400
X-MC-Unique: GUvXmIezPqCQDz1gc7gAbA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3ef25aaeb5bso54395571cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 22:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682574817; x=1685166817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TACSMy7Ug2sStH4pdeuOCgf93fUckqHIu/mqCYHofQw=;
        b=Jq20SYKPdLHpKY/8xjw7SMHBVQCfjwvD0n0dH2Pq/dWUA85sqcVBWyqo7IORt4snXH
         VavYqlh3DtYhJD0A905c8cce1b4i23eTHBvdA2g0DIC6RArG9qOMNAE9KOnQ4vQZn3/d
         PFIynDrXCY63G9FUvpKiCE9ro759qRu7j0rNohlwz9koXxo48hWU9LvLuwlJnxSvKuY9
         t6TW065Sj07rS1n7oQgMjz0nHg47ti6l3eIA9fskiAxd/BCLdekps0N4diSHwPjvKbhn
         RtbKFSMwT10Su57b9S843ULn52MlfEkMR6TPbgIZYRXQWBTEbLTnRpuv8Sg4POSSTRzG
         b8RQ==
X-Gm-Message-State: AC+VfDxVyq5DcKHv4/fbyKx7FI9I5IxhwG9i8hwlODi1FMMMG1IqqX2H
        roq08X3IfDNYSrUDiLC7Dx/IAGF/ModIIsYqUBE7/MfDgTnWAGWZOBayx/OizciTpDzgj5CdI+H
        75ZBROJMiL7KGNnGH5PS2g1VT
X-Received: by 2002:a05:622a:654:b0:3ef:5ec1:dab3 with SMTP id a20-20020a05622a065400b003ef5ec1dab3mr525104qtb.30.1682574817511;
        Wed, 26 Apr 2023 22:53:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4j6nF3w+Z8LmcylCbGKc5D5+oYOrfLipDhTKW/WdKR3wbjN7mgXy+G02OxwfvQJQwd+S5TJA==
X-Received: by 2002:a05:622a:654:b0:3ef:5ec1:dab3 with SMTP id a20-20020a05622a065400b003ef5ec1dab3mr525086qtb.30.1682574817237;
        Wed, 26 Apr 2023 22:53:37 -0700 (PDT)
Received: from localhost.localdomain ([176.206.13.250])
        by smtp.gmail.com with ESMTPSA id gd21-20020a05622a5c1500b003f0af201a2dsm1921750qtb.81.2023.04.26.22.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 22:53:36 -0700 (PDT)
Date:   Thu, 27 Apr 2023 07:53:27 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
        zhiguo.niu@uniissoc.com
Subject: Re: [PATCH 2/6] sched/cpuset: Bring back cpuset_mutex
Message-ID: <ZEoN1wq47uhE201p@localhost.localdomain>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-3-juri.lelli@redhat.com>
 <fa585497-5c6d-f0ed-bdda-c71a81d315ad@redhat.com>
 <ZEkRq9iGkYP/8T5w@localhost.localdomain>
 <d53a8af3-46e7-fe6e-5cdd-0421796f80d2@redhat.com>
 <CAB8ipk-ns=d+jNkKi1sjkSQmQidziCj34COkHZt6ZkRiG47HHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8ipk-ns=d+jNkKi1sjkSQmQidziCj34COkHZt6ZkRiG47HHA@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/04/23 10:58, Xuewen Yan wrote:
> HI Juri,
> 
> Would this patch be merged tobe stable-rc? In kernel5.15, we also find
> that the rwsem would be blocked for a long  time, when we change the
> task's cpuset cgroup.
> And when we revert to the mutex, the delay would disappear.

Honestly, I'm not sure. This change is mostly improving performance, but
it is also true that it's fixing some priority inheritance corner cases.
So, I'm not sure it qualifies for stable, but it would be probably good to
have it there.

Thanks,
Juri

