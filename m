Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F05E57A6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 02:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiIVAv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 20:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiIVAvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 20:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3AA82757
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 17:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663807875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TlZPS68bRjdcIKk/zRKqggI7Hq6RMpYcMrdthSemclU=;
        b=Q0o7WDYWU7Nt0QxUHoatcNuXUxmux+txuK/PWKhtx4u58hHwg3oTsNXrIudDHTxl9kdoDu
        oV5iTlHd7021cXyZz6EwCiVf7pzKWApGbEbH5jYGRVVtgVURBJZuNA/UTLPSbbA5Cy60Xm
        /spZb7ba9PHmOPJoKd4gF4LvLexk1+o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-tDscr2fXOsmu8wDGfON-sw-1; Wed, 21 Sep 2022 20:51:14 -0400
X-MC-Unique: tDscr2fXOsmu8wDGfON-sw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D07D385A583;
        Thu, 22 Sep 2022 00:51:13 +0000 (UTC)
Received: from [10.22.32.114] (unknown [10.22.32.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C4812166B29;
        Thu, 22 Sep 2022 00:51:13 +0000 (UTC)
Message-ID: <56fe41a0-e2be-03bc-8539-204c3dc801ff@redhat.com>
Date:   Wed, 21 Sep 2022 20:51:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] locking: Provide a low overhead do_arch_spin_lock()
 API
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20220921132152.1622616-1-longman@redhat.com>
 <20220921132152.1622616-2-longman@redhat.com>
 <20220921180640.032d16fd@gandalf.local.home>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220921180640.032d16fd@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/21/22 18:06, Steven Rostedt wrote:
> On Wed, 21 Sep 2022 09:21:51 -0400
> Waiman Long <longman@redhat.com> wrote:
>
>> There are some code paths in the kernel like tracing or rcu where they
>> want to use a spinlock without the lock debugging overhead (lockdep,
>> etc). Provide a do_arch_spin_lock() API with proper preemption disabling
>> and enabling without any debugging or tracing overhead.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Please don't do this. arch_spin_lock() is very special, and if tracing did
> it wrong, then it needs to be fixed in the tracing code.
>
> Let's not add handlers to make it easier to use arch_spin_lock(). Tracing
> is special and arch_spin_lock() helps keep it from tracing itself.

That makes sense to me. Will remove this patch.

Thanks,
Longman

