Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA0266619C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjAKRTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbjAKRTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:19:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B7D27C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673457502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hv64DJ6WuEPbf885EGRUJg/4DId2W4WwX5BHU7l5sj0=;
        b=fixBEaRzRrJbNhcvyNN1QzxDOTlCaa5GWFpEJqmTWTybl9KCzFbQE7IKZRu/wrquoVD+W4
        /knK13O8Ij35MBCvJ+GLRtukbrMP+g3X8aviQSokBQ12fWn//kaRMi+rKQ3S/Z7yf/V7xX
        0pKWmZ/bak9ymaxF2qTxMrLPXt6FyPc=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-501-DdhGveSYNAGB1HOU4FeIYw-1; Wed, 11 Jan 2023 12:18:18 -0500
X-MC-Unique: DdhGveSYNAGB1HOU4FeIYw-1
Received: by mail-vs1-f70.google.com with SMTP id s62-20020a675e41000000b003cefb1730d9so3158733vsb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hv64DJ6WuEPbf885EGRUJg/4DId2W4WwX5BHU7l5sj0=;
        b=aMhUmh7ZVFlUBu6EOoy8ZNgIFSZXYW1Djc1uwH4naMSL+iM7F7RNyCGPIPTJAf18Pb
         c/8SoQZfsUNYSkKYI0o8ahdlTGXznk5EI3UYNBp90xpLQtT+BLUsohg1q6yxF7tbsSbt
         IEwbUtNMCeVSswHH7ik9ZTul9gVixxAwpeVRo7wrhLf98zxKRGxRYshg4lnPDjhboCjb
         RMb//vX+yDCPsec1Vyh6QyZHk0Yhv2+ARo3UFkglqDg0hSO0mFltOljfBngFURNj7RmX
         Oa+GCgKPX526NH8Mvx0TFM5yBYLsAjKT8C6nM2k+TlRst5pCaqAXpy8vz2Ws71kKDpOi
         ToLA==
X-Gm-Message-State: AFqh2kqimCdIHp3g0JgyDag5/cNa77pcf+9WkqNwSLD340FSuqWy/T1l
        qzpM7hwtrjYBv966/fdRaxVER8C2tIha/hGOt1eqt84XZByL8mYu8V37cQ9bwZAiQafDv9Er8vI
        mGyD1+4fDsVwD5XrAIhUfoodb
X-Received: by 2002:a1f:9b88:0:b0:3da:f117:619c with SMTP id d130-20020a1f9b88000000b003daf117619cmr3408483vke.12.1673457497535;
        Wed, 11 Jan 2023 09:18:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvlHFd9m8+IAvitZcNNE88GPBLlvguoVp2rEOgrT1OZc3yRQLmvuxrN7qoo8pm54O2dYtSxig==
X-Received: by 2002:a1f:9b88:0:b0:3da:f117:619c with SMTP id d130-20020a1f9b88000000b003daf117619cmr3408468vke.12.1673457497296;
        Wed, 11 Jan 2023 09:18:17 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id u2-20020a05620a0c4200b006f9f3c0c63csm9408341qki.32.2023.01.11.09.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 09:18:16 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v7 4/4] workqueue: Unbind kworkers before sending them
 to exit()
In-Reply-To: <Y77qEu1fQHMWr6F1@slm.duckdns.org>
References: <20230109133316.4026472-1-vschneid@redhat.com>
 <20230109133316.4026472-5-vschneid@redhat.com>
 <Y73KeZ3g0WdukMQo@slm.duckdns.org>
 <xhsmhv8ldck2a.mognet@vschneid.remote.csb>
 <Y77qEu1fQHMWr6F1@slm.duckdns.org>
Date:   Wed, 11 Jan 2023 17:18:13 +0000
Message-ID: <xhsmhpmblc7my.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/23 06:55, Tejun Heo wrote:
> On Wed, Jan 11, 2023 at 12:49:49PM +0000, Valentin Schneider wrote:
>> While we're here, for my own education I was trying to figure out in what
>> scenarios we can hit this manager-already-active condition. When sending
>> out v6 I had convinced myself it could happen during failed
>> initialization of a new unbound pool, but having another look at it now I'm
>> not so sure anymore.
>> 
>> The only scenario I can think of now is around maybe_create_worker()'s
>> release of pool->lock, as that implies another worker can drain the
>> pool->worklist and thus let pool->refcnt reach 0 while another worker is
>> being the pool manager. Am I looking at the right thing?
>
> To be frank, I'm not sure and can't remember why the code is like that off
> the top of my head. It could well be that I was just habitually thinking
> that MANAGER can be contended while in practice the scenario can never
> happen in this particular case. I'll need to look harder at it but maybe we
> can leave that to another day?
>

For sure :-)

> Thanks.
>
> -- 
> tejun

