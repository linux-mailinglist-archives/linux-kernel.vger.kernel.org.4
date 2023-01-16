Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1376066CE1F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjAPR6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjAPR5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:57:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4305C0DF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673890607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7aEA9Zb0uDCPpMjGds8ZZV+xITOhP/XEPwhcG9Jlbk=;
        b=cgiPpwLh4y4qlQIn8LRnxjdmmIWTdtmUyrOJSXxCK/NfAf9gy1sy8vG/yI3QyaDtl6jV9W
        pJh6baEpv5NaptVsLJPLo/6iFqHSzEFxFmzYU+iKb243VecKN7LJ6xFda2QPLTVLWsO7Ke
        012DrN9e5+CBDL9NYnsJUj1u+pJeMBI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-355-DXZO5TfwOK2Q0A52n6Z6nA-1; Mon, 16 Jan 2023 12:36:46 -0500
X-MC-Unique: DXZO5TfwOK2Q0A52n6Z6nA-1
Received: by mail-ej1-f70.google.com with SMTP id qa18-20020a170907869200b007df87611618so19852986ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7aEA9Zb0uDCPpMjGds8ZZV+xITOhP/XEPwhcG9Jlbk=;
        b=F2juD9JQ5h0IdPvehbwz//XqkylOVId4D1vw3niYrmvRfsEfiEg9Nt3T6ko2p2bt54
         hd/5o2OiqueNvP6UO5OPUUQGY5BcYkxzdsXiSBCru79bdJJaAOn8U+OCcuOxkCWhKaJz
         +pfX6iGV5oJ6wtI8DjNCrbvX4X/HX56zRt3cS1pr7Jepqycttzu59GJUTIqUQ/d645EM
         dWXhKsDspZYxWQdridU39zWBdtZm49RWWPskOcIxhod8HuVV5ra2ZSo0redN60aCguPG
         SxqY1MWnLsA7DQmkAcokZsCV1oVnMPcb/9yMiumdzNcVXBak4jnEn9UJ7CVGDvAgpwvc
         K6Gw==
X-Gm-Message-State: AFqh2kqgmFu/YFiKxnMY5LRXu/l2dJWq2rxoYjX1TOIs2eL5t0htSlnb
        5WsYFR2aJQ2eyRGDSYcNIKaSi221AwZwSMt7Gr5wVO2DpiL34hPRpy6zslXvEHSYw6qAP0so3I2
        Zo0g7lvrCYXuXmtf4yEFNeQg7
X-Received: by 2002:a17:906:cd0b:b0:84d:463f:3787 with SMTP id oz11-20020a170906cd0b00b0084d463f3787mr26828243ejb.5.1673890605559;
        Mon, 16 Jan 2023 09:36:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvwkGf/AMfNoy3aPwRb/Z8qBXr1VRjGO1z90RbOn2KENCWUu1gPXT7V040gp3/OtMwrPzsLHg==
X-Received: by 2002:a17:906:cd0b:b0:84d:463f:3787 with SMTP id oz11-20020a170906cd0b00b0084d463f3787mr26828236ejb.5.1673890605384;
        Mon, 16 Jan 2023 09:36:45 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id e6-20020a170906314600b00781be3e7badsm12131965eje.53.2023.01.16.09.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 09:36:44 -0800 (PST)
Message-ID: <456f6c15-3043-6da2-349d-c0c3880c1a55@redhat.com>
Date:   Mon, 16 Jan 2023 18:36:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/3] rcu: Equip sleepable RCU with lockdep dependency
 graph checks
Content-Language: en-US
To:     paulmck@kernel.org, Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Woodhouse <dwmw2@infradead.org>, seanjc@google.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Luczaj <mhal@rbox.co>
References: <20230113065955.815667-1-boqun.feng@gmail.com>
 <20230113065955.815667-3-boqun.feng@gmail.com>
 <20230113112949.GX4028633@paulmck-ThinkPad-P17-Gen-1>
 <Y8GdYgSBtyKwf/qj@boqun-archlinux>
 <20230113191120.GB4028633@paulmck-ThinkPad-P17-Gen-1>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230113191120.GB4028633@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/23 20:11, Paul E. McKenney wrote:
> On Fri, Jan 13, 2023 at 10:05:22AM -0800, Boqun Feng wrote:
>> On Fri, Jan 13, 2023 at 03:29:49AM -0800, Paul E. McKenney wrote:
>> I prefer that the first two patches go through your tree, because it
>> reduces the synchronization among locking, rcu and KVM trees to the
>> synchronization betwen rcu and KVM trees.
> 
> Very well, I have queued and pushed these with the usual wordsmithing,
> thank you!

I'm worried about this case:

	CPU 0				CPU 1
	--------------------		------------------
	lock A				srcu lock B
	srcu lock B			lock A
	srcu unlock B			unlock A
	unlock A			srcu unlock B

While a bit unclean, there is nothing that downright forbids this; as 
long as synchronize_srcu does not happen inside lock A, no deadlock can 
occur.

However, if srcu is replaced with an rwlock then lockdep should and does 
report a deadlock.  Boqun, do you get a false positive or do your 
patches correctly suppress this?

Paolo

