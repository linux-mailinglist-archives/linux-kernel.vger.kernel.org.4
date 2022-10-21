Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90344606CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJUBWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJUBWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8CF22D5BB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 18:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666315341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26/1wx3sTPstBaBhkT8PKMNM7SbmIMCHT4MScRzd8Fo=;
        b=V/WHJqvMBbLWs+6A83ugkY6UVmN9PSv5+FW8B8YoNWhiR/V1iZcVtrYnZNWeIiOrPTkwTV
        Z9LzzoJvv9ugLyEufMAqTsLqz2te02LlN8DdQJDCr4qzyS8p7tw3ueb7QSIYYFr91LJciC
        oJacHTuGNB1KYwXBuZKld80PlMihjkE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-8FAL97uqNDiWba6a9NrXiw-1; Thu, 20 Oct 2022 21:22:15 -0400
X-MC-Unique: 8FAL97uqNDiWba6a9NrXiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4224829AB409;
        Fri, 21 Oct 2022 01:22:15 +0000 (UTC)
Received: from [10.22.17.11] (unknown [10.22.17.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C79BB40C98EC;
        Fri, 21 Oct 2022 01:22:14 +0000 (UTC)
Message-ID: <af778779-77b8-15db-d5dc-36c4992483b3@redhat.com>
Date:   Thu, 20 Oct 2022 21:22:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] mm/kmemleak: Prevent soft lockup in kmemleak_scan()'s
 object iteration loops
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20221020175619.366317-1-longman@redhat.com>
 <20221020175823.d7aa5cfeefd8673429f42081@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221020175823.d7aa5cfeefd8673429f42081@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/20/22 20:58, Andrew Morton wrote:
> On Thu, 20 Oct 2022 13:56:19 -0400 Waiman Long <longman@redhat.com> wrote:
>
>> Commit 6edda04ccc7c ("mm/kmemleak: prevent soft lockup in first object
>> iteration loop of kmemleak_scan()") adds cond_resched() in the first
>> object iteration loop of kmemleak_scan(). However, it turns that the
>> 2nd objection iteration loop can still cause soft lockup to happen in
>> some cases. So add a cond_resched() call in the 2nd and 3rd loops as
>> well to prevent that and for completeness.
>>
> Seems reasonable, although not an object of beauty.
>
> We didn't include a Fixes: or cc:stable in 6edda04ccc7c, even though it
> addresses softlockups.  I think I'll add a cc:stable to this, with a
> Fixes:6edda04ccc7c.  So any kenrel which included 6edda04ccc7c will
> hopefully add this as well.

That sounds good to me. I consider commit 6edda04ccc7c incomplete and 
this patch complete it. Technically it can be considered a fix.

Thanks,
Longman

