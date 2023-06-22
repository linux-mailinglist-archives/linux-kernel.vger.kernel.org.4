Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD0273A103
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjFVMfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFVMfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5045B4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687437307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r5InBmmxDXVDwgBLrdcfId/Pttqu0CWzwtLP5BOUwdA=;
        b=LqrnpCuZKcLDtPcbo5TDYw9mmW3VoLxl2zHrPDSgxmSE/eO6D1yLUH9acFtVZMxRjproGr
        uwxPOtw9UwseaPK3GKM069cyX/hzy782ip5Cc7foVUrD+LVULaKMhmF6lIz7NckaFtYUDz
        ssbcYZAg0j8T30eoMiug9YUf+F7xTMA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-wjIUS_jCN0yMp1UHsQTgAw-1; Thu, 22 Jun 2023 08:35:04 -0400
X-MC-Unique: wjIUS_jCN0yMp1UHsQTgAw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42C8C3C1392C;
        Thu, 22 Jun 2023 12:35:00 +0000 (UTC)
Received: from [10.22.17.29] (unknown [10.22.17.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96A08200A3AD;
        Thu, 22 Jun 2023 12:34:59 +0000 (UTC)
Message-ID: <87c6e059-d010-a8aa-8e63-7b09d82be863@redhat.com>
Date:   Thu, 22 Jun 2023 08:34:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/3] intel_idle: Sync up the SPEC_CTRL MSR value to
 x86_spec_ctrl_current
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
References: <20230622003603.1188364-1-longman@redhat.com>
 <20230622003603.1188364-3-longman@redhat.com>
 <20230622054633.ulrurzzvzjijvdhn@treble>
 <20230622094051.GF4253@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230622094051.GF4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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


On 6/22/23 05:40, Peter Zijlstra wrote:
> On Wed, Jun 21, 2023 at 10:46:33PM -0700, Josh Poimboeuf wrote:
>> On Wed, Jun 21, 2023 at 08:36:02PM -0400, Waiman Long wrote:
>>> When intel_idle_ibrs() is called, it modifies the SPEC_CTRL MSR to
>>> 0 in order disable IBRS. However, the new MSR value isn't reflected
>>> in x86_spec_ctrl_current which is at odd with the other code that
>>> keep track of its state in that percpu variable. Fix that by updating
>>> x86_spec_ctrl_current percpu value to always match the content of the
>>> SPEC_CTRL MSR.
>> Is this fixing an actual bug or is there some other reason for doing
>> this?
> No actual bug, he did this for his debugfs file -- which is no longer
> part of the series. With that on, you can observe the
> x86_spec_ctrl_current value while idle.

Right. That is the main reason as I want the SPEC_CTRL MSRs value to be 
observable by some external mean:-)

Regards,
Longman

