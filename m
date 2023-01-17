Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883F0670CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjAQXNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAQXLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:11:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF457683F8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673988809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kK9jjV9LP02qyv4y6+sL2kQpufhJ4FqsFgh0MZZolJ4=;
        b=c5lMSLWVkMbtouTkpAileyhU2gC59N2OMdVgltfXYfjtmDSkAayTZ44UMLMeiT7u1tlYGY
        UqpT5GvCkJiWmPx+D6m+EEaS8QiDkN8Wgk6KcVDPXex2RjfOfx8I1Sxn4J4IIVGUApxKgm
        wlL/xjvyY9Rq96HT3AvZRqmcb9OmuOg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-XDlHVebtNmCyO3FtIvn-Ag-1; Tue, 17 Jan 2023 15:53:23 -0500
X-MC-Unique: XDlHVebtNmCyO3FtIvn-Ag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5B7A811E9C;
        Tue, 17 Jan 2023 20:53:22 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58FBF7AE5;
        Tue, 17 Jan 2023 20:53:22 +0000 (UTC)
Message-ID: <d373d20d-50ff-1413-e2cc-4f9918633493@redhat.com>
Date:   Tue, 17 Jan 2023 15:53:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v6 0/6] lockinig/rwsem: Fix rwsem bugs & enable true lock
 handoff
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20221118022016.462070-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221118022016.462070-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/22 21:20, Waiman Long wrote:
> v6:
>   - Fix an error in patch 2 reported by kernel test robot.
>
> v5:
>   - Drop patch 2 and replace it with 2 new patches disabling preemption on
>     all reader functions and writer functions respectively. The other
>     patches are adjusted accordingly.
>
> v4:
>   - Update patch descriptions in patches 1 & 2 to make clear the live
>     lock conditions that are being fixed by these patches. There is no code
>     change from v3.
>
> It turns out the current waiter optimistic spinning code does not work
> that well if we have RT tasks in the mix. This patch series include two
> different fixes to resolve those issues. The last 3 patches modify the
> handoff code to implement true lock handoff similar to that of mutex.
>
> Waiman Long (6):
>    locking/rwsem: Prevent non-first waiter from spinning in down_write()
>      slowpath
>    locking/rwsem: Disable preemption at all down_read*() and up_read()
>      code paths
>    locking/rwsem: Disable preemption at all down_write*() and up_write()
>      code paths
>    locking/rwsem: Change waiter->hanodff_set to a handoff_state enum
>    locking/rwsem: Enable direct rwsem lock handoff
>    locking/rwsem: Update handoff lock events tracking
>
>   kernel/locking/lock_events_list.h |   6 +-
>   kernel/locking/rwsem.c            | 240 ++++++++++++++++++++++--------
>   2 files changed, 182 insertions(+), 64 deletions(-)
>
Peter,

I know that you are busy these days. Do have any further comment or 
suggestion on this patch series?

Looking forward to your reply.

Thanks,
Longman

