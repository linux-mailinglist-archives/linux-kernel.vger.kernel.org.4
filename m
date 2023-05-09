Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9F16FC9B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbjEIO6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbjEIO6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4977935AD
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683644277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WV3ICBhDilalYvw5NIcAe47IfKOm4v6QiFKkGmV7pEE=;
        b=C4ZL4UYmfizpsNLW5paLTAf7J1mQ/9/LET2BGIfIMMdisWnKqsxa4QHdYSfS7zF1wSMCZT
        FsLBZQQdGz7yviLRCHSmZmRHqLJuXV2eagpSbUdpj2vjdjEXVX/pGwcjOVqyRLLuC2DHMp
        GGj1YUpPCC7v9DrqCHifV2M+iRq4pgA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-qvokO9jTPlyPb_dSWUZxPQ-1; Tue, 09 May 2023 10:57:46 -0400
X-MC-Unique: qvokO9jTPlyPb_dSWUZxPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7A64100F656;
        Tue,  9 May 2023 14:57:45 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABE471121314;
        Tue,  9 May 2023 14:57:45 +0000 (UTC)
Message-ID: <43868b82-4f13-ebcc-ea7a-86f11f6096f6@redhat.com>
Date:   Tue, 9 May 2023 10:57:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] locking/qspinlock: Fix state-transition changes in
 comments
Content-Language: en-US
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230506062934.69652-1-qiuxu.zhuo@intel.com>
 <10d3a11a-8591-e49d-e010-867a05078ff0@redhat.com>
 <IA1PR11MB617110DB70F92AFC0D40D26089769@IA1PR11MB6171.namprd11.prod.outlook.com>
 <3e580bf2-2c76-739e-7636-4aa03f5628bd@redhat.com>
 <IA1PR11MB6171282A1E2CF22740398F8989769@IA1PR11MB6171.namprd11.prod.outlook.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <IA1PR11MB6171282A1E2CF22740398F8989769@IA1PR11MB6171.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 02:57, Zhuo, Qiuxu wrote:
> Hi Longman,
>
> OK, so, you are from the point of view of the CPU (the lock word value it read last time)
> doing state transition in the uncontended scenario:
>
>       [1]:  Old lock word value (this CPU read it last time) ---> New lock word value
>
> I'm from the point of view of the current lock word possible value that its state is
> transited to the new lock word possible value (I don't think I'm the only one from
> this point of view when reading the qspinlock code ;-).
>
>       [2]: Current lock word possible value ---> New lock word possible value
>
> I'm fine to keep the view of [1] in the current code and get [2] as the backup.
> I'll send out a v2 with just two minor comments' fixes.

The purpose of those transition flow charts is to help understand what 
the code is doing. So they should reflect the running CPU point of view. 
If you want to show what all the possible values can be, you have to 
explicitly state that to avoid the confusion.

Thanks,
Longman

