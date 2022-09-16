Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BD35BB3BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 23:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiIPVCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 17:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiIPVCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 17:02:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03E214D0D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 14:02:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4280E20CF8;
        Fri, 16 Sep 2022 21:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663362138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EnUlU4GPTlbzAm676zNN6UXCmqBifxtwq13DXpup998=;
        b=jbBKo8azTesEbIFpJup5auX/08CPvZrOvZu9uDcTI9wbT8ZQKdTnlH0ArSu+y2cUbo9hDp
        NKjGVQrrycH3lMeeE29wFsynCe6y7RL4TCf7vJoP45Z8zFpPcmyjKSbe2ZO3iHFJLXU3GX
        sSV7c3UEX9QPaNluprL1dJb4+2rE1o0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663362138;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EnUlU4GPTlbzAm676zNN6UXCmqBifxtwq13DXpup998=;
        b=TcKYfBQBE3/AL3Mw4dfCYMRpzua6IjeMok82SYpDu84V8FFV+FJ1zoOVwPFfrrFBz9oMHP
        9yfKEiAfvCwSskDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 212231332E;
        Fri, 16 Sep 2022 21:02:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ef9nB1rkJGMiWwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 16 Sep 2022 21:02:18 +0000
Message-ID: <084d7ef4-15a8-1d4e-6b20-5a848102ac03@suse.cz>
Date:   Fri, 16 Sep 2022 23:02:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH V2] mm: slub: fix flush_cpu_slab()/__free_slab()
 invocations in task context.
Content-Language: en-US
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     linux-mm@kvack.org, rientjes@google.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20220912161140.34281-1-mlombard@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220912161140.34281-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 18:11, Maurizio Lombardi wrote:
> @@ -2730,7 +2735,7 @@ static void flush_all_cpus_locked(struct kmem_cache *s)
>  		INIT_WORK(&sfw->work, flush_cpu_slab);
>  		sfw->skip = false;
>  		sfw->s = s;
> -		schedule_work_on(cpu, &sfw->work);
> +		queue_work_on(cpu, flushwq, &sfw->work);
>  	}
>  
>  	for_each_online_cpu(cpu) {
> @@ -4858,6 +4863,8 @@ void __init kmem_cache_init(void)
>  
>  void __init kmem_cache_init_late(void)
>  {
> +	flushwq = create_workqueue("slub_flushwq");
> +	BUG_ON(!flushwq);

Adding new BUG_ON is essentially prohibited these days, so please use WARN_ON().
Other than that deprecation issue, looks fine to me.

>  }
>  
>  struct kmem_cache *

