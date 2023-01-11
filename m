Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4835666506F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbjAKAjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbjAKAjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:39:32 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2125D3D5D5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:39:31 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5897C10096E;
        Wed, 11 Jan 2023 00:39:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a248.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 483AB100D6C;
        Wed, 11 Jan 2023 00:39:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1673397569; a=rsa-sha256;
        cv=none;
        b=4v6UPN5SfyA0iJURp4Vpw71der+PcSVx9tPgkhlowH6X/Ne5j5AbnzRoargl/CS+CvBsCj
        ZmbS0ZKwdsASZsrGXICyIe15qIlRmlO59wh2p7EJOV5maZa3UBaENtIN+YI2hug069fXo2
        QdsRfkv7zD2Li38HFvFTNTc9XkgBJE6Jw+it0LA8Hwazd//Yhxf48OU19ZaEj72w7cyXQ+
        GVAELTNc/ybWWUwNUI/YfIG5gd4qENGT370nnCNYmwBwiF6K09cHmwBtAeBFRPS+dvYELj
        cNx4MHsBfcBjQf07QucOLjyXftEz8yr4FrGJpxx5Yl3Uz2BeEM58j+h4h4RnJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1673397569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=o8yEaYcRgiVvt7yHXPFiT7zox2nJmD44kCtYTtXc45I=;
        b=xMDiKumsooLDj4yhWokPg+7/VQbh2V3hsQxjziMEAO1vvLQQyX56LJXYsn+soxngNHlEFd
        zY/97naxJXtb1A5rPIcRlQKoIrzsaArWoP7uQHY+8DCSayhQWGgcvAzDtGutHzuV7aD+MR
        0c8ZXg/4Y9bJEbbkUgsxt+7r9UtDgbj/BUDTVNhAmUrlPpVThfqc1aPlHzaNBYZdO/Vkv4
        XP9WdeZzbrjFGbUXf1fZOIDHdhxtbQq/+X8ROuPGfZiUQmIaQqG7J17cSMeZ4Bm6ZNF5oa
        E5irqhIokyb2h3SFp7B+0ougzhP9ef9BQJhSnoIUi7dCKDdkmI7tKX8L2OuBCA==
ARC-Authentication-Results: i=1;
        rspamd-7cf955c847-95cc5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Reaction: 7153c6b5624d9204_1673397570082_815930916
X-MC-Loop-Signature: 1673397570082:2253401169
X-MC-Ingress-Time: 1673397570082
Received: from pdx1-sub0-mail-a248.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.45 (trex/6.7.1);
        Wed, 11 Jan 2023 00:39:30 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a248.dreamhost.com (Postfix) with ESMTPSA id 4Ns82Q1SxXz7M;
        Tue, 10 Jan 2023 16:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1673397569;
        bh=o8yEaYcRgiVvt7yHXPFiT7zox2nJmD44kCtYTtXc45I=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=fvVGLpB5u6C0euGhg1uhftkOix9hq0800aRoqQn0FfD/XsAZRRcVVzKCZWFiLwMHr
         6SbMStqI9JBKXDnHvoaz6Qhsb/IQMECSeQ8inaheo9GA79l/Vwrd1WNseCK3iR6jkC
         Es7W+EzwDI2P0Iv4Cu+OGEoglXmHjTXs1vsqJEQjar1BvbYE7I/JvIWxIITtOLrWLV
         Q0xiL0kCY6ryfoFp4EQfi9PzLg/W100y2AnqxALsmKU2iLebbG0yoHRz4kl1G3lEH6
         dencuMZZOtI43MOKNY88F/IXWrwfyI0jiisiCl9W3lpq9akVvdSdOlnWd1p3puoSW/
         Ux0VSz7seypsA==
Date:   Tue, 10 Jan 2023 16:13:31 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 08/41] mm: introduce CONFIG_PER_VMA_LOCK
Message-ID: <20230111001331.cxdeh52vvta6ok2p@offworld>
Mail-Followup-To: Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-9-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230109205336.3665937-9-surenb@google.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2023, Suren Baghdasaryan wrote:

>This configuration variable will be used to build the support for VMA
>locking during page fault handling.
>
>This is enabled by default on supported architectures with SMP and MMU
>set.
>
>The architecture support is needed since the page fault handler is called
>from the architecture's page faulting code which needs modifications to
>handle faults under VMA lock.

I don't think that per-vma locking should be something that is user-configurable.
It should just be depdendant on the arch. So maybe just remove CONFIG_PER_VMA_LOCK?

Thanks,
Davidlohr
