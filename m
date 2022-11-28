Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A8563ACD5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiK1Po3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiK1PoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:44:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13E11DA63
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669650198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kf5JsraFrf1EIzInt/eR+PAefoERXJjRW/gfIONg0yU=;
        b=VNzaTQImaaJYFJ2IhYi+yTNgI+iSNi3BUsXB1mm4iJD4Bo/ByIkbVK6EzgT9W6dGYckNXm
        n+1x/cM+N4IeGzYP219QTl61Hp2LxStg8NbEA+MXOsEL/dG1iTEigp15QjwTPSvtWLqRQt
        axXa+eNyq6lpHA34yLtVa8b51eKMnAc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-079oyaslMQOyBKwnN5LnbQ-1; Mon, 28 Nov 2022 10:43:14 -0500
X-MC-Unique: 079oyaslMQOyBKwnN5LnbQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BD168828C8;
        Mon, 28 Nov 2022 15:43:13 +0000 (UTC)
Received: from [10.22.10.34] (unknown [10.22.10.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D77282024CBB;
        Mon, 28 Nov 2022 15:43:11 +0000 (UTC)
Message-ID: <f5abd919-c996-6549-8d48-a93a66daaef8@redhat.com>
Date:   Mon, 28 Nov 2022 10:43:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW0V4dGVybmFsIE1haWxdW1BBVENILXRpcF0gc2No?=
 =?UTF-8?Q?ed=3a_Fix_use-after-free_bug_in_dup=5fuser=5fcpus=5fptr=28=29?=
Content-Language: en-US
To:     =?UTF-8?B?RGF2aWQgV2FuZyDnjovmoIc=?= <wangbiao3@xiaomi.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Wenjie Li <wenjieli@qti.qualcomm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20221128014441.1264867-1-longman@redhat.com>
 <63373bf9adfc4e0abd9480d40afa2c5a@xiaomi.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <63373bf9adfc4e0abd9480d40afa2c5a@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/28/22 08:34, David Wang 王标 wrote:
> Hi, Waiman
>
> We use 140 devices to test this patch 72 hours.  The issue can not be reproduced.  If no this patch,  the issue can be reproduced.
> Could you help merge this patch to mailine?
>
> https://lore.kernel.org/all/20221125023943.1118603-1-longman@redhat.com/
>
> If this patch is applied to the maintainer's tree,  we can request google to help cherrypick to ACK to fix issue.

Just want to clarify if you are testing the patch using the latest tip 
tree or on top of an existing linux version without the persistent user 
requested affinity patchset.

PeterZ is the scheduler maintainer who is responsible for merging 
scheduler related patch. It is up to him as to when that will happen.

Cheers,
Longman

