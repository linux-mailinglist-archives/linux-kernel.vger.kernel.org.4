Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA445BEEF0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 23:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiITVEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 17:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiITVEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 17:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC13DE0AD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663707880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dndBUUyTd8Rbt5rH1+UqxAoWeyUi1+M1Mj7FGWIu6ys=;
        b=U7otvNj+AURB4XDxgQTRd8Sexo49EgnBCuI5/YLgP0gPjpqQ3t6dXgrfSZQg5LT090dVbF
        xxyScyK0WopElQbHk36hdksA4lSyJ69koGmZyNFNCaGa7h/MTl8s/vOsqL8mzw1GGHweNU
        OJ1JEkanduzsGsLT56SGXigkQvB4i8k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-SJmcUg02OIm0wnXFFQkUtQ-1; Tue, 20 Sep 2022 17:04:36 -0400
X-MC-Unique: SJmcUg02OIm0wnXFFQkUtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D92B882823;
        Tue, 20 Sep 2022 21:04:36 +0000 (UTC)
Received: from [10.22.34.82] (unknown [10.22.34.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D08BC15BA8;
        Tue, 20 Sep 2022 21:04:36 +0000 (UTC)
Message-ID: <a9b00df6-cacc-56e7-82d9-e7b2875aa898@redhat.com>
Date:   Tue, 20 Sep 2022 17:04:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] locking/qspinlock: Do spin-wait in slowpath if
 preemptible
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220920195542.1548164-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220920195542.1548164-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 15:55, Waiman Long wrote:
> There are some code paths in the kernel where arch_spin_lock() will be
> called directly when the lock isn't expected to be contended and critical
> section is short. For example, tracing_saved_cmdlines_size_read()
> in kernel/trace/trace.c does that.
>
> In most cases, preemption is also not disabled. This creates a problem
> for the qspinlock slowpath which expects preemption to be disabled
> to guarantee the safe use of per cpu qnodes structure. To work around
> these special use cases, add a preemption count check in the slowpath
> and do a simple spin-wait when preemption isn't disabled.
>
> Fixes: a33fda35e3a7 ("Introduce a simple generic 4-byte queued spinlock")
> Signed-off-by: Waiman Long <longman@redhat.com>

On second thought, I believe the proper way to fix this is to make sure 
that all the callers of arch_spin_lock() has preemption properly 
disabled. Will work on another patch set to do that. So please ignore 
this patch and sorry for the noise.

Cheers,
Longman

