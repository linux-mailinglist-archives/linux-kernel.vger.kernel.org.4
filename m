Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91AF678A61
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjAWWJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjAWWJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:09:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD4337F32
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674511657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+uwa4A3CnG0VcC1BvTjREmLd4y+hXARwVDElm4zCfw4=;
        b=J4SrGlPKG8ZJnCpOblDKFb6gD5Eyw8+mJ6On+rspwGHAlEfhtMOnspVUGpWIE+yOFdhqlR
        Pk45zGHqWkMKRIcqG8StxSMiw4oFSWAMZEC0xW0+P4XWXy8go7vAr6dP2JxqfbzRzsnDHX
        gtfLKJjLTuLiQyliWttW3WfaSk/yK1U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-_IedzoDXMLaMKmwAzJ1Qbw-1; Mon, 23 Jan 2023 17:07:35 -0500
X-MC-Unique: _IedzoDXMLaMKmwAzJ1Qbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98C4984AF53;
        Mon, 23 Jan 2023 22:07:09 +0000 (UTC)
Received: from [10.22.34.140] (unknown [10.22.34.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFADB2166B32;
        Mon, 23 Jan 2023 22:07:08 +0000 (UTC)
Message-ID: <284b7d75-42cd-ddab-8431-dfbde8bea2b2@redhat.com>
Date:   Mon, 23 Jan 2023 17:07:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 5/6] locking/rwsem: Enable direct rwsem lock handoff
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20221118022016.462070-1-longman@redhat.com>
 <20221118022016.462070-6-longman@redhat.com>
 <Y86gzkVHlsOTY8QL@hirez.programming.kicks-ass.net>
 <9fb531a9-0951-f7c0-316d-749d2c59ade8@redhat.com>
In-Reply-To: <9fb531a9-0951-f7c0-316d-749d2c59ade8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 12:30, Waiman Long wrote:
> I will update the patch description to highlight the points that I 
> discussed in this email. 

I am planning to update the patch description to as follows:

     The lock handoff provided in rwsem isn't a true handoff like that in
     the mutex. Instead, it is more like a quiescent state where optimistic
     spinning and lock stealing are disabled to make it easier for the first
     waiter to acquire the lock.

     For mutex, lock handoff is done at unlock time as the owner value and
     the handoff bit is in the same lock word and can be updated atomically.

     That is the not case for rwsem which has a separate count value for
     locking and an owner value. The only way to update them in a 
quasi-atomic
     way is to use the wait_lock for synchronization as the handoff bit can
     only be updated while holding the wait_lock. So for rwsem, the new
     lock handoff mechanism is done mostly at rwsem_wake() time when the
     wait_lock has to be acquired anyway to minimize additional overhead.

     Passing the count value at unlock time down to rwsem_wake() to 
determine
     if handoff should be done is not safe as the waiter that set the
     RWSEM_FLAG_HANDOFF bit may have been interrupted out or killed in the
     interim. So we need to recheck the count value again after taking the
     wait_lock. If there is an active lock, we can't perform the handoff
     even if the handoff bit is set at both the unlock and rwsem_wake()
     times. It is because there is a slight possibility that the original
     waiter that set the handoff bit may have bailed out followed by a read
     lock and then the handoff bit is set by another waiter.

     It is also likely that the active lock in this case may be a transient
     RWSEM_READER_BIAS that will be removed soon. So we have a secondary
     handoff done at reader slow path to handle this particular case.

     For reader-owned rwsem, the owner value other than the 
RWSEM_READER_OWNED
     bit is mostly for debugging purpose only. So it is not safe to use
     the owner value to confirm a handoff to a reader has happened. On the
     other hand, we can do that when handing off to a writer. However, it
     is simpler to use the same mechanism to notify a handoff has happened
     for both readers and writers. So a new HANDOFF_GRANTED state is added
     to enum rwsem_handoff_state to signify that. This new value will be
     written to the handoff_state value of the first waiter.

     With true lock handoff, there is no need to do a NULL owner spinning
     anymore as wakeup will be performed if handoff is successful. So it
     is likely that the first waiter won't actually go to sleep even when
     schedule() is called in this case.

Please let me know what you think.

Cheers,
Longman

