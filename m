Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75F8738855
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjFUPD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjFUPDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FBB6EB9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687359306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QoQ+QeYRZBI9jaQiyXxbczTZh6h+sWjH6QRN7ho9+3I=;
        b=PXlw4fFbVtPopVT0jjMQ7T52cEYbd1ih7bBphEbiqh9DqwzbT2NMpNowDkqXYFhBa5xEJ3
        PuEvy+pp5r+qrgZRSLlLFmzduJDuSX2JHKak6L6p6vSBWvodI3mETx8D5LQ78tBQxWc4ds
        j04cCFJyciRaVFZRtl0wUVTxe5D+5N4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-ndiTCmUYMs-tAoTQ-IEshw-1; Wed, 21 Jun 2023 10:51:35 -0400
X-MC-Unique: ndiTCmUYMs-tAoTQ-IEshw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43F7B185A7AD;
        Wed, 21 Jun 2023 14:51:34 +0000 (UTC)
Received: from [10.22.17.140] (unknown [10.22.17.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8112B1121330;
        Wed, 21 Jun 2023 14:51:33 +0000 (UTC)
Message-ID: <309d15f5-0dd8-aee8-14a6-621a071bc363@redhat.com>
Date:   Wed, 21 Jun 2023 10:51:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/5] x86/idle: Disable IBRS when cpu is offline
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
References: <20230620140625.1001886-1-longman@redhat.com>
 <20230620140625.1001886-3-longman@redhat.com>
 <20230621072313.GA2046280@hirez.programming.kicks-ass.net>
 <7f2424df-1846-6c38-e446-b3d5aa693ecd@redhat.com>
 <20230621143602.GI2053369@hirez.programming.kicks-ass.net>
 <5cb81f3b-45a0-d566-3d63-569b5706e9fe@redhat.com>
 <20230621144848.GJ2053369@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230621144848.GJ2053369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/21/23 10:48, Peter Zijlstra wrote:
> On Wed, Jun 21, 2023 at 10:44:23AM -0400, Waiman Long wrote:
>
>> Well, hlt_play_dead() is only called if cpuidle_play_dead() returns an error
>> which is not the typical case. My testing does confirm that this patch is
>> able to keep the IBRS bit off when a CPU is offline via its online sysfs
>> file.
> The point is; your re-enable IBRS hunk at the end is dead-code. It
> should never ever run and having it is confusing.

What I meant is that hlt_play_dead() should never be called unless there 
is some serious problem with the system and native_play_dead() does 
return in normal usage.

Cheers,
Longman

