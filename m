Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08CB604F12
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJSRl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiJSRlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:41:23 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4179190469;
        Wed, 19 Oct 2022 10:41:22 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id pb15so634651pjb.5;
        Wed, 19 Oct 2022 10:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibazVU8VEWiKjzH5tdP3qJYeOezJN/1hV2XwUlu7gXQ=;
        b=ruK9PbxcCpCfLDahmXQss+5aP1CNhgBTBXb38XLXG7eZzQna9gvIvBVXoj/b4xx6x1
         ZoiursHj9+udLBP+8mzt2zmsf36TenfxfpsQ9gHacPrGQi+I3F2SOo0ep2RDFJK79VKr
         vY7irfw7yhbw3FJOAmllfxqQEOp4klJGcpaAuJV4HMal5bFeTdJCGD+pMfPJPvGDobDi
         IA60wGPUN86afUE1SlCcsO0mGTvrvCzwdU/UtWbZghtaJwgFCwuqbXY0KXg1EqJCO3tj
         i4oKlYUQtNOed6GDAYHEGiO6s6mBnyOC7WWlITklo0lIep+DLrqi+zKhYeavJB5YaHFT
         xtUA==
X-Gm-Message-State: ACrzQf3hYivM5dVv9j61OtJofwi15aB+nda1MffX7Di03trkHepkNfqT
        nSdRVixcBDBVtUSfx7TBQTE=
X-Google-Smtp-Source: AMsMyM5RiypiDpnGljhlkl0RiKjvcXhr7OYC9m9blVZ36DsY8NWaD1KWWSvz+ZwSfdwtcZyWqtaNcw==
X-Received: by 2002:a17:90b:1808:b0:20d:4e7f:5f53 with SMTP id lw8-20020a17090b180800b0020d4e7f5f53mr45790427pjb.170.1666201282060;
        Wed, 19 Oct 2022 10:41:22 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8280:2606:af57:d34? ([2620:15c:211:201:8280:2606:af57:d34])
        by smtp.gmail.com with ESMTPSA id u5-20020a170903124500b00174c0dd29f0sm11128116plh.144.2022.10.19.10.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 10:41:21 -0700 (PDT)
Message-ID: <b49d7e9b-fdee-915a-436a-bb624addf9a2@acm.org>
Date:   Wed, 19 Oct 2022 10:41:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] null_blk: allow teardown on request timeout
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
References: <20221016052006.11126-1-kch@nvidia.com>
 <f2baa3b4-81c9-a6d8-0c26-3e695dad5d10@acm.org>
 <d3e05b4e-466b-844c-b815-79233856e527@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d3e05b4e-466b-844c-b815-79233856e527@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 21:19, Chaitanya Kulkarni wrote:
> Also, I've listed the problem that I've seen first hand for keeping the
> device in the system that is non-responsive due to request timeouts, in
> that case we should let user decide whether user wants to remove or keep
> the device in the system instead of forcing user to keep the device in
> the system bringing down whole system, and these problems are really
> hard to debug even with Teledyne LeCroy [1]. This patch follows the same
> philosophy where user can decide to opt in for removal with module
> parameter. Once opt-in user knows what he is getting into.

Hi Chaitanya,

 From commit f2298c0403b0 ("null_blk: multi queue aware block test 
driver"): "Written to facilitate testing of the blk-mq code". I'm not 
sure of this but adding a mechanism like the one in this patch may fall 
outside the original scope of the null_blk driver.

Thanks,

Bart.
