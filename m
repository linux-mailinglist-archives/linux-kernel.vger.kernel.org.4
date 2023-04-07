Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FF26DB5D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjDGVe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDGVe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:34:27 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878952715
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:34:25 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f080fdb924so2465e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 14:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680903264; x=1683495264;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Datt06y6QOn3vVdQaOHrLIlblRQOgkrxQaZSIY+FYG0=;
        b=wtSCevor2na2EU+0BL4aP5lAXeMl8Pz6E8mAU3SufailvvJ7u5Fx1SDVz7Yd8RMfWu
         qbJ99JQmqSwmPdx9lFwluvembSeDi/zQpbNoJW577vSFH1QYIfBRKnUwKuDf7aSHxA4k
         pAGX8g1Knr/ag9FIIoNSmkVUZq6XJbjHKyHmLCpES1pfUJmM3wfSaeYs+b9qfpmFIZlR
         7+yx12UuebP2wWsFMdWZZ0w9KNZXRYS4eWtNIF9FoMRZFWeIesX7bBjd23hSVAOiGW5U
         MbPTblooWs2OZCoC+I4ZkdhhWLcRcNLzMeB+xkR6pfNKIY1p95adOYppPYzazmmLB5zX
         PlcQ==
X-Gm-Message-State: AAQBX9ezxvxmllaPCWrjEL9S+hnhohhpnrjdldPLzNqtbn69cW+FyZow
        pJh4J5ZTWBBgrABYr4gjD1s=
X-Google-Smtp-Source: AKy350baUMxCZkE2nsZcNtWR9Nkg/ifoAdbJKZh8R8Xpz+6OML1wgprg9hWp45VmnR6Dx/XJWz8FAg==
X-Received: by 2002:a05:600c:1ca4:b0:3ed:d2ae:9adb with SMTP id k36-20020a05600c1ca400b003edd2ae9adbmr562659wms.0.1680903263903;
        Fri, 07 Apr 2023 14:34:23 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c450600b003ee2a0d49dbsm9694305wmo.25.2023.04.07.14.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 14:34:23 -0700 (PDT)
Message-ID: <ab82c5fd-03d6-683d-2c8a-1b71b940d94a@grimberg.me>
Date:   Sat, 8 Apr 2023 00:34:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] nvme: fix double blk_mq_complete_request for timeout
 request with low probability
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Lei Lei2 Yin <yinlei2@lenovo.com>
Cc:     "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cybeyond@foxmail.com" <cybeyond@foxmail.com>
References: <PS1PR03MB4939C825BD5D9A135AA0EB9188919@PS1PR03MB4939.apcprd03.prod.outlook.com>
 <ZDBvTS1j26d3392/@kbusch-mbp.dhcp.thefacebook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZDBvTS1j26d3392/@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 53ef028596c6..c1cc384f4f3e 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -450,8 +450,8 @@ bool nvme_cancel_request(struct request *req, void *data)
>>   	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
>>   				"Cancelling I/O %d", req->tag);
>>   
>> -	/* don't abort one completed request */
>> -	if (blk_mq_request_completed(req))
>> +	/* don't abort one completed or idle request */
>> +	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
>>   		return true;
> 
> I was suspicious about this path too, and had the same change long ago, but
> shelved it when I couldn't produce any errors there. But the change makes sense
> to me!
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>

We need to change nvmf_complete_timed_out_request() too.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
