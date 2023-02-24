Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96016A1495
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 02:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBXBUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 20:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBXBUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 20:20:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F0F14E9E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 17:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677201595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qjp481qPgrzUiPMjEjVJgds/tnUMHD8NHuhe/hy/1oQ=;
        b=OQPmJbMG/mHZXLuBgGolrOOoALD7Dwo+BeHfr6glIzju33GK3i6Ci6jWNVbaqKpIwBrAok
        ilu/UXm31VTkOVxx/YppBMAP+G+nMT3UqgBpHPbnHB418BGC4Su7tlXwdsjfNpfCsyjNrO
        qL3UYXRkbZmCRVfOsIySHQe6hix7eGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-Sswt8SwMNiiKYDXj8LU5iA-1; Thu, 23 Feb 2023 20:19:47 -0500
X-MC-Unique: Sswt8SwMNiiKYDXj8LU5iA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46953811E9C;
        Fri, 24 Feb 2023 01:19:47 +0000 (UTC)
Received: from [10.22.16.134] (unknown [10.22.16.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BC8F492C3E;
        Fri, 24 Feb 2023 01:19:47 +0000 (UTC)
Message-ID: <55b63346-1445-30f6-3b8a-06068377bad6@redhat.com>
Date:   Thu, 23 Feb 2023 20:19:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/6] locking/rwsem: Rework writer wakeup and handoff
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com
References: <20230223122642.491637862@infradead.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230223122642.491637862@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/23 07:26, Peter Zijlstra wrote:
> Hi,
>
> these here few patches boot but are otherwise very much untested. Please test.

I like the unification that you have done with this series.

However, I got the following task hanging message when doing a kernel build:

[ 2215.893058]  </TASK>
[ 2215.895252] INFO: task pahole:65220 blocked for more than 123 seconds.
[ 2215.901776]       Tainted: G S         OE      6.2.0-test+ #1
[ 2215.907520] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 2215.915347] task:pahole          state:D stack:0     pid:65220 
ppid:65065  flags:0x00000000
[ 2215.923690] Call Trace:
[ 2215.926146]  <TASK>
[ 2215.928250]  __schedule+0x367/0x950
[ 2215.931741]  schedule+0x50/0xc0
[ 2215.934888]  schedule_preempt_disabled+0x11/0x20
[ 2215.939507]  rwsem_down_read_slowpath+0x28c/0x520
[ 2215.944215]  down_read+0x98/0xc0
[ 2215.947446]  do_user_addr_fault+0x410/0x700
[ 2215.951633]  exc_page_fault+0x64/0x140
[ 2215.955385]  asm_exc_page_fault+0x22/0x30
[ 2215.959394] RIP: 0033:0x7f37f8808dd2
[ 2215.962974] RSP: 002b:00007ffe7bc89e80 EFLAGS: 00010246
[ 2215.968199] RAX: 00007f377d7fb000 RBX: 00007f377dffb700 RCX: 
00007f37f8439a1b
[ 2215.975332] RDX: 0000000000000003 RSI: 0000000000800000 RDI: 
00007f377d7fc000
[ 2215.982465] RBP: 00007ffe7bc89f50 R08: 00000000ffffffff R09: 
0000000000000000
[ 2215.989594] R10: 0000000000000000 R11: 0000000000000206 R12: 
0000000000001000
[ 2215.996728] R13: 00007ffe7bc89ee0 R14: 0000000000000000 R15: 
0000000000801000
[ 2216.003862]  </TASK>

I am a bit tired now. I will look at the series again tomorrow to see if 
there is something missing.

Cheers,
Longman

