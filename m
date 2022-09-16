Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399D15BB3C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 23:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiIPVDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 17:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIPVDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 17:03:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3F214D0D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 14:03:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7AA6033FB1;
        Fri, 16 Sep 2022 21:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663362218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCV5EZdfU84ij2ZO2M+Di6Bc/CgprZmSWf4mi7uvB7M=;
        b=OXtRrELUmCHW+HUpfugiwflpU3CQhdhdStd7lc1zbUcmEXHB1x+YkKrddiIJccT+jloowG
        Fwvp5EB8dYkiZOmufy5o3/Oi+tZWObMQ6eUhcpdr8jN+ap7gMBJMWLQUX4OAfjeedNg1vw
        7f+jCUeB50fLwCs0WAFS9Bgs+qnR+2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663362218;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCV5EZdfU84ij2ZO2M+Di6Bc/CgprZmSWf4mi7uvB7M=;
        b=UPZOsUaqoNWet1TNH2baY6Z+38D0VnpXSUL8kHSWuy5EZghXUD4Mz+98cg2Q1bGp45ol/N
        i2c32D5wp4hu0hBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EC891332E;
        Fri, 16 Sep 2022 21:03:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y960EqrkJGOrWwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 16 Sep 2022 21:03:38 +0000
Message-ID: <efd29abd-9c32-2a28-d7b8-1fabba3b418f@suse.cz>
Date:   Fri, 16 Sep 2022 23:03:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH V2] mm: slub: fix flush_cpu_slab()/__free_slab()
 invocations in task context.
Content-Language: en-US
To:     Maurizio Lombardi <mlombard@redhat.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20220912161140.34281-1-mlombard@redhat.com>
 <YyMe8LvKxc5juCfr@hyeyoo>
 <CAFL455kQaTb=6NFUbDdpP051nc2=LwpJxAOFicdAeoFjDXvgMQ@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAFL455kQaTb=6NFUbDdpP051nc2=LwpJxAOFicdAeoFjDXvgMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/22 09:27, Maurizio Lombardi wrote:
> čt 15. 9. 2022 v 14:48 odesílatel Hyeonggon Yoo <42.hyeyoo@gmail.com> napsal:
>> No objection about this patch,
>> but it seems create_workqueue is deprecated?
> 
> You're right, the documentation says that create_workqueue() is deprecated,
> too bad there is not a comment in the source code.

Let's make Tejun and Lai aware of this.

> Thanks for reporting this.
> 
> I will wait for the maintainers to review this one and eventually I
> will submit a V3.
> 
> Maurizio
> 
> 
> 
>>
>>
>> --
>> Thanks,
>> Hyeonggon
>>
> 

