Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E776B5F10F7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiI3Ref (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiI3Reb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FECB1DA897
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 10:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664559269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W5r/tbUfhhoiK/xC0vLVUfLqgvHiQHsLsMvwp7l/rPM=;
        b=Aj6C+1uziRwMs3h/3By0q7fGPQDaB15jPAO5J/KBOmVyJMes+W3SEe+zGr9ia6p/5fVLiL
        qYA8BEQ1fst46hMQos7uRCmdQwWeHeJ3Zyk76Wr2n8M7zIzjMCnnZTr88sO2sBKN+rW4p3
        a4M2PBkB/1KSHR+R2LBVI6z96YhbCUM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-AuFcjDCWPkSTZyu5igLeVA-1; Fri, 30 Sep 2022 13:34:25 -0400
X-MC-Unique: AuFcjDCWPkSTZyu5igLeVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97AE4811E67;
        Fri, 30 Sep 2022 17:34:24 +0000 (UTC)
Received: from [10.22.32.123] (unknown [10.22.32.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 494352166B26;
        Fri, 30 Sep 2022 17:34:24 +0000 (UTC)
Message-ID: <5be617ad-0652-642f-aff8-7b7734f33973@redhat.com>
Date:   Fri, 30 Sep 2022 13:34:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] lockdep: Allow tuning tracing keys constant.
Content-Language: en-US
To:     Ryan Huang <tzukui@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20220930170058.2645213-1-tzukui@google.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220930170058.2645213-1-tzukui@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/30/22 13:00, Ryan Huang wrote:
> Tetsuo Handa made a change for tuning lockdep tracing capacity constants
> [1]. He created following tracing config constants:
>    - LOCKDEP_BITS
>    - LOCKDEP_CHAINS_BITS
>    - LOCKDEP_STACK_TRACE_BITS
> However there is a missing one for LOCKDEP_KEYS_BITS. We can see this is
> also hitting the upper limits in [2].
>
> [1] https://github.com/torvalds/linux/commit/5dc33592e95534dc8455ce3e9baaaf3dae0fff82
> [2] https://syzkaller.appspot.com/bug?id=df466e1151a7e45dd880d8c7033f1ad48acebfb4
>
> Fixes: 5dc33592e955 ("lockdep: Allow tuning tracing capacity constants.")
> Signed-off-by: Ryan Huang <tzukui@google.com>
> ---
>   include/linux/lockdep.h | 2 +-
>   lib/Kconfig.debug       | 8 ++++++++
>   2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 1f1099dac3f05..3bb1740296559 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -82,7 +82,7 @@ struct lock_chain {
>   	u64				chain_key;
>   };
>   
> -#define MAX_LOCKDEP_KEYS_BITS		13
> +#define MAX_LOCKDEP_KEYS_BITS		CONFIG_LOCKDEP_KEYS_BITS
>   #define MAX_LOCKDEP_KEYS		(1UL << MAX_LOCKDEP_KEYS_BITS)
>   #define INITIAL_CHAIN_KEY		-1
>   
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d3e5f36bb01e0..d15024bd14f1d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1398,6 +1398,14 @@ config LOCKDEP_CHAINS_BITS
>   	help
>   	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
>   
> +config LOCKDEP_KEYS_BITS
> +	int "Bitsize for MAX_LOCKDEP_KEYS"
> +	depends on LOCKDEP && !LOCKDEP_SMALL
> +	range 10 30
> +	default 13
> +	help
> +	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_KEYS too low!" message.
> +
>   config LOCKDEP_STACK_TRACE_BITS
>   	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
>   	depends on LOCKDEP && !LOCKDEP_SMALL

The lockdep key is embedded in a bit field within the held_lock 
structure to utilize all the 32 bits of an integer. Changing its size 
will require adjusting other bit fields or expand the bit field size 
from 32 bits to 64 bits. 13 bits allows up to 8k unique lock classes. 
Unless there is good evidence that we are going to run out of that, we 
shouldn't change it.

Thanks,
Longman

