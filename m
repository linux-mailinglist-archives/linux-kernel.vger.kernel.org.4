Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7198663A728
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiK1LZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiK1LZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:25:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F7BD6C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669634661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgEuVwr/lmoaUkwtJRv3fcPpNyiihXcpeLIB+gbkxTg=;
        b=BwyvhNTs15KH15W/QyH8/KgmRRSn/w4cOwhiUR0x+rqTNmA8W9WTtHYc0yPLY+IyOoiDSU
        4HmskkSpWmQQn7pQxLca+VPOr5TT8mIAY3PhadulPWB3dEFZQNe7uoSsNyAQ8u6vmZnIlF
        nJ+I7yiVqm09qKY00mkmLwmf+wO5Ias=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-471-bzvdg8CMMMmhWvtIYJGUgQ-1; Mon, 28 Nov 2022 06:24:19 -0500
X-MC-Unique: bzvdg8CMMMmhWvtIYJGUgQ-1
Received: by mail-wr1-f72.google.com with SMTP id j30-20020adfa55e000000b00241b49be1a3so1786372wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:24:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TgEuVwr/lmoaUkwtJRv3fcPpNyiihXcpeLIB+gbkxTg=;
        b=IA+46JykdAnoFhwOd5fd8tOXSEphuMJcqdauONGv8WclwBMFmDcpz0ydX90juW7qM/
         F3IYwvVP4Tz0Q+fGkurJ12JyJy0HbVH3fRGabJe17LBco+jLQHHowpJjfXID8RsdZIBT
         0T41zt8Jd42E9Glu5jFaQOfTjHBfQxZrbbvkh7M51tTKoAuS59ED9sZt3A/G4H12C3mX
         3es45awOXQMHrddXHX6zj+92Wr/5jIFL9DZfOHDs8vouK8eLOYPzzxbxGsZq2ZkcaLAD
         LYr/g+aD2CqctX+0+c8va7xEUAE3VTortauS+zcmtjB+QHC8x5nNYcRDYlJRzwab9dg4
         YJvQ==
X-Gm-Message-State: ANoB5plkj13xngfwC7OChUnQqlaeDDKbSp70IH0POudl7qJZejtn3ICz
        428omX+6N12E9V9PW2AyLD+9RbtS12cOMrLmKFNDeqVfj7M93zXZhdlS4ECbhAnx995RLEpAMTr
        5xVtSBjHpZfbfrxd5ZaX1RJsG
X-Received: by 2002:a5d:5957:0:b0:22e:3e9:ba15 with SMTP id e23-20020a5d5957000000b0022e03e9ba15mr29705734wri.180.1669634658603;
        Mon, 28 Nov 2022 03:24:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5lXkK47G//R0Blw0UXQBU9TYWc2d0eHuQmZUBkfLyu+cdpW5Dz9AAyP5KPxrAfIEojFKrF1g==
X-Received: by 2002:a5d:5957:0:b0:22e:3e9:ba15 with SMTP id e23-20020a5d5957000000b0022e03e9ba15mr29705719wri.180.1669634658427;
        Mon, 28 Nov 2022 03:24:18 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b003cffd3c3d6csm15905340wmq.12.2022.11.28.03.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:24:17 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v5 3/5] workqueue: Make too_many_workers() return the
 worker excess
In-Reply-To: <Y30uY/Y8pffIhrUp@slm.duckdns.org>
References: <20221122192937.2386494-1-vschneid@redhat.com>
 <20221122192937.2386494-4-vschneid@redhat.com>
 <Y30uY/Y8pffIhrUp@slm.duckdns.org>
Date:   Mon, 28 Nov 2022 11:24:16 +0000
Message-ID: <xhsmhbkorl3tr.mognet@vschneid.remote.csb>
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

On 22/11/22 10:17, Tejun Heo wrote:
> Hello,
>
> On Tue, Nov 22, 2022 at 07:29:35PM +0000, Valentin Schneider wrote:
> ...
>> The function currently returns true when
>>   (nr_idle - 2) * MAX_IDLE_WORKERS_RATIO >= nr_busy
>> thus, the desired number of idle workers is expressed by
>>   (nr_idle - 2) * MAX_IDLE_WORKERS_RATIO == nr_busy - 1
>> IOW
>>    nr_idle == ((nr_busy - 1) / MAX_IDLE_WORKERS_RATIO) + 2
>> +/* How many idle workers should we get rid of, if any? */
>> +static unsigned int worker_cull_count(struct worker_pool *pool)
>
> Can we name it nr_workers_to_cull()?
>

Ack

>>  {
>>  	bool managing = pool->flags & POOL_MANAGER_ACTIVE;
>>  	int nr_idle = pool->nr_idle + managing; /* manager is considered idle */
>>  	int nr_busy = pool->nr_workers - nr_idle;
>>  
>> -	return nr_idle > 2 && (nr_idle - 2) * MAX_IDLE_WORKERS_RATIO >= nr_busy;
>> +	lockdep_assert_held(&pool->lock);
>> +
>> +	/*
>> +	 * We keep at least 2 spare idle workers, but overall aim to keep at
>> +	 * most (1 / MAX_IDLE_WORKERS_RATIO) workers idle.
>> +	 */
>> +	return max(0, nr_idle - 2 - ((nr_busy - 1) / MAX_IDLE_WORKERS_RATIO));
>
> I think we can do away with the subtraction on nr_busy. I don't think it'd
> make any material difference, so maybe we can do:
>
>         return max(0, nr_idle - 2 - nr_busy / MAX_IDLE_WORKERS_RATIO);
>

I'll do that if this survives in the next revision :)

> Thanks.
>
> -- 
> tejun

