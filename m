Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46480686EC3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjBATTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjBATSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:18:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C891E5F0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 11:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675279087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e12sH+zkKNX78AjXSikDkdXZisiXuIfpSmor0Y5G9UI=;
        b=CFs2hZfLMcp37Zzcq4pJiuaHgjOTxuOEzRUJb2oAMJjsdvaphu64GqtNtoh4O0D5N8rGtg
        aLkP1jH80qgDHd8gEvjS+666Aa9AkP6SfmLYEiGRHsbZBLW1GNPfWyD6MvNSnioUMyFsws
        4k88tdjDGFonMauUl/lIFmWtBjx+adI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-fBKH_8vvMiqjz2R-AbG-Dg-1; Wed, 01 Feb 2023 14:18:00 -0500
X-MC-Unique: fBKH_8vvMiqjz2R-AbG-Dg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F243100DEA3;
        Wed,  1 Feb 2023 19:18:00 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1694BC15BAE;
        Wed,  1 Feb 2023 19:18:00 +0000 (UTC)
Message-ID: <5a1a6e1f-2d19-e2ff-8f2c-63d185aa057b@redhat.com>
Date:   Wed, 1 Feb 2023 14:17:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zefan Li <lizefan.x@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
 <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
 <Y9otWX+MGOLDKU6t@hirez.programming.kicks-ass.net>
 <83e53632-27ed-8dde-84f4-68c6776d6da8@redhat.com>
 <a892d340-ea99-1562-0e70-176f02f195c2@redhat.com>
 <37f158af-6ca8-9f5a-c87a-0266d8bb21a6@redhat.com>
In-Reply-To: <37f158af-6ca8-9f5a-c87a-0266d8bb21a6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/23 14:14, Waiman Long wrote:
> One possible solution is to use cpuset_cpus_allowed_fallback() in case 
> none of the cpus in the current cpuset is allowed to be used to run a 
> given task.

It looks like we will need to enhance cpuset_cpus_allowed_fallback() to 
walk up cpuset tree to find one that have useable cpus.

Cheers,
Longman

