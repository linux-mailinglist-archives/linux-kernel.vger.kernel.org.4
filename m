Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BFF638245
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 03:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKYCJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 21:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKYCJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 21:09:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1298E1A209
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 18:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669342112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMmONmj+ol7x4HeyBpwd5zn1kLNvVxKSDvKoM7cuIFY=;
        b=TziYKnUaUDV/qYLNpQt6kzGPQ38qV3lTGLI18ofRLAkK9vOayRkwnvRyOxMiHBVv9T/HMD
        Nm0ll2kTAWcxZzVFbde//CFtCLQAZpXhkV03JEUiETkDSrafKNbEsRNjr95/qCEwsHCmtC
        khvUaLtgwZntxyIKnlwPyQnLST0n8Zo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-ZV6AULafOdSXGCttSdxPVA-1; Thu, 24 Nov 2022 21:08:29 -0500
X-MC-Unique: ZV6AULafOdSXGCttSdxPVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85D8A85A588;
        Fri, 25 Nov 2022 02:08:28 +0000 (UTC)
Received: from [10.22.32.81] (unknown [10.22.32.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F1631415114;
        Fri, 25 Nov 2022 02:08:28 +0000 (UTC)
Message-ID: <8a48c522-afbc-f18f-5080-4c915f87e2bc@redhat.com>
Date:   Thu, 24 Nov 2022 21:08:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW0V4dGVybmFsIE1haWxdUmU6IFtQQVRDSCAxLzFd?=
 =?UTF-8?Q?_sched=3a_fix_user=5fmask_double_free?=
Content-Language: en-US
To:     "Wenjie Li (Evan)" <wenjieli@qti.qualcomm.com>,
        =?UTF-8?B?RGF2aWQgV2FuZyDnjovmoIc=?= <wangbiao3@xiaomi.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6ZmI5Yag5pyJ?= <chenguanyou@xiaomi.com>,
        Will Deacon <will@kernel.org>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <cover.1669020858.git.wangbiao3@xiaomi.com>
 <b8970a530d420109ee9fe0b268e097fb839211b0.1669020858.git.wangbiao3@xiaomi.com>
 <Y3zXDZeTUgDz2hJ8@hirez.programming.kicks-ass.net>
 <a7fb3cac-176f-3928-f3a3-23c25ab9677e@redhat.com>
 <1c3ce8c4-354d-2f00-1dc6-e13cbe389828@redhat.com>
 <1fe9abbdd12b41fc87c92b60550fc909@xiaomi.com>
 <9a6b10cd-855d-ca15-01e9-2c95a8b692be@redhat.com>
 <9cc51697705f472e99a620eee8569a32@xiaomi.com>
 <0b50b719-b8df-decb-b6ed-12be8f623ad0@redhat.com>
 <DM8PR02MB80559373BC22C4051AE30073ED0F9@DM8PR02MB8055.namprd02.prod.outlook.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <DM8PR02MB80559373BC22C4051AE30073ED0F9@DM8PR02MB8055.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/24/22 07:04, Wenjie Li (Evan) wrote:
> Hi, Waiman.
>
> "The clearing of user_cpus_ptr is protected by pi_lock. IOW, racing between dup_user_cpus_ptr() and do_set_cpus_allowed is not possible and double free like what you have suggested should not happen." We still can understand why it is impossible to happen. Because we indeed met this issue. Following is we got from ftrace.
>
> 1. Task  A  pid 27961 run on core6 and is forking/cloning task pid 28051, and task B  pid 28051 will copy task struct data from task A pid 27961. So task A p->user_cpus_ptr = ffffff884fbf9200 is equal to task B p->user_cpus_ptr=ffffff884fbf9200 through arch_dup_task_struct.

You are right. I forgot the fact that the value of dst->user_cpus_ptr is 
a copy of src. I have posted a v3 patch to address that. Thanks for the 
spotting that.

Cheers,
Longman


