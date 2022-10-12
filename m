Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9805FC64F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJLNV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJLNVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C94FC7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665580879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2zxeTJogUD9cP2j+RyPkvY7qkwjQo+DKnHIQ0ghc/Qs=;
        b=fYEAWsAs/+zCVvBmfwfM41AruLCcbxo291btXP0/ofJj7SshbMLiC5ytPDOujFBgsJ0gtA
        4uZkRlA6plyo8saZv/L40cOMoDxfF+NU4z/CVxRJNCpvWRzP6RWnWf704v3FDx0+aXs0+b
        rw/j95Aeltl6SrXGycPYiwBZ8EayIfg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-sFdv7FBfPiiOtLxZdxjoHw-1; Wed, 12 Oct 2022 09:21:13 -0400
X-MC-Unique: sFdv7FBfPiiOtLxZdxjoHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC445185A7AC;
        Wed, 12 Oct 2022 13:21:12 +0000 (UTC)
Received: from [10.22.33.120] (unknown [10.22.33.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36FB940C206B;
        Wed, 12 Oct 2022 13:21:12 +0000 (UTC)
Message-ID: <29d65c22-747a-2538-cc17-db619c85b8f8@redhat.com>
Date:   Wed, 12 Oct 2022 09:21:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] locking/rwsem: Prevent non-first waiter from spinning in
 down_write() slowpath
Content-Language: en-US
To:     =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "john.p.donnelly" <john.p.donnelly@oracle.com>,
        Hillf Danton <hdanton@sina.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20220929180413.107374-1-longman@redhat.com>
 <6530f135-e8ac-bb6c-4715-1ea8f76cf4c4@redhat.com>
 <7cbf49c9-d122-30e6-68b3-c61eca63e5dc@quicinc.com>
 <4c4e5208-ddf5-6191-64b0-54ae0bed1af6@redhat.com>
 <03421f0e453143f6ae4a9a7a8a4f47f4@xiaomi.com>
 <446288c6c7db4ab2b23f7041baa62335@xiaomi.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <446288c6c7db4ab2b23f7041baa62335@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 03:20, Ting11 Wang 王婷 wrote:
> Hi Waiman,
>
> Thanks for your quick reply.
> Regarding this issue, we have done a lot of testing on our devices and found that the first patch is the most effective,is it possible to using this patch?
>
> https://lore.kernel.org/lkml/e1cb435a-4471-ac3a-344f-04448f167c9f@quicinc.com/
>
Yes, I am going to resurrect this patch.

Cheers,
Longman

