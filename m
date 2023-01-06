Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B917660992
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbjAFWe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbjAFWex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:34:53 -0500
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FAF8728F;
        Fri,  6 Jan 2023 14:34:53 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id d83so108417pfd.7;
        Fri, 06 Jan 2023 14:34:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SL5CM6lTlaQHHI1bmsPCCVPxAY0au15n5abe/FQT3nc=;
        b=ASB6VjbRn323bvBk76ZKS9zAeYdz/r/MVHt9yITS87YHOWshrg1swxRqthnD9nNXmN
         nxze0aXcBvbPXKh0JZekd5kegY25hp+4o9X6Q6+LMkr3/CfmgOjdWqsORJCNyx7IlcUm
         58kvyPGZ57SLLy3MBWDTS91vfPrfAvufgvLR1Md41b3Ot4xS4kQbY1qd4yHs+y7pDZ7o
         T7qaQMsq2iuGdzqaGM9wk0yxruqmBbCe5ji4HjMNfCFFbZe2EV58f2L9Zht9myeIJJi4
         lyfVcgiZvRPSBJvyI8vqRe0dolQpBHdiQoovUHgbdclQQlL4Z83GXGkF7qVdl6GDaNdR
         Pyog==
X-Gm-Message-State: AFqh2koFCpicGDuXHbnblbETfqkXQDts+7ZBTEJgtRCLuNsElZ9x+vD8
        eT+S8yGB7MjfVct6Ei0XFnE=
X-Google-Smtp-Source: AMrXdXvz8DmkTBfjAMd1ozT8pHBw5/b6wdaTed0SKRZNVvC3PYsvERMHsoJSt6vghLCnFNKh8DJLdg==
X-Received: by 2002:a62:2903:0:b0:57f:f2cd:6180 with SMTP id p3-20020a622903000000b0057ff2cd6180mr54274027pfp.0.1673044492663;
        Fri, 06 Jan 2023 14:34:52 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:23c3:f25b:a19d:c75a? ([2620:15c:211:201:23c3:f25b:a19d:c75a])
        by smtp.gmail.com with ESMTPSA id a13-20020aa7970d000000b00582197fa7b4sm1597733pfg.7.2023.01.06.14.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 14:34:51 -0800 (PST)
Message-ID: <895e27b5-60cb-39f4-ce0c-774379453418@acm.org>
Date:   Fri, 6 Jan 2023 14:34:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/7] block: remove superfluous check for request queue in
 bdev_is_zoned
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, snitzer@kernel.org, dm-devel@redhat.com,
        damien.lemoal@opensource.wdc.com, linux-nvme@lists.infradead.org,
        hch@lst.de, linux-block@vger.kernel.org, gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083319eucas1p1e58f4ab0d3ff59a328a2da2922d76038@eucas1p1.samsung.com>
 <20230106083317.93938-2-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230106083317.93938-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/23 00:33, Pankaj Raghav wrote:
> Remove the superfluous request queue check in bdev_is_zoned() as the
> bdev_get_queue can never return NULL.

the bdev_get_queue -> bdev_get_queue()

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
