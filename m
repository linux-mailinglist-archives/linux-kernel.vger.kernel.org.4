Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919196F05A6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbjD0MVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243517AbjD0MVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:21:41 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FA510DA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:21:33 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f18176ea3aso15562075e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682598092; x=1685190092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTSpPIZe1Obt24YjnKDvoF2YqyJyc7UGd5/XTD7d67A=;
        b=EH2R5XqcSX0KaigC4hCdSITVGZR1XOoFOXcnHmAtpiviQy3YodqKvtdRiywdE8+Wuk
         EAh/IM9TdCo2tteWjGwF93DdsbupTxYXTqGwtUBGfRsleDDSIkvnL1ECAJB5k/rxDknX
         BI+Ha+osucaYd8QicQXRtBA+0TYqqUm1Q6L/6skm4mVMuXRX5rbvCdb7rHzFsU65AuoK
         BfxunSAsweO2LnSoGMy0rlVEVKpR/21RzyvbIdGIc1zOBdCScy5YRxOqgeGTM1yUWre9
         7EEGoapBY4WzrvbbLL2+5CulFOBex7qLpKe2Pg6xNJWXXp2JP2QECPJ/zRYF3YOWeMZ2
         dg6g==
X-Gm-Message-State: AC+VfDxvu7yXlR+F4Gs3yP561Nl3nxcShBug51nQPHytyin05oZo/Q/L
        WUG+npEwi1ia19VkEjqeU7E=
X-Google-Smtp-Source: ACHHUZ4T8PmiD4CF0X5gwaMJ87abzq+NR5j3tA/Ftzc3Qrje8wr1IebNXIaNzviQVPGGDiKi7s71GA==
X-Received: by 2002:a05:600c:1d02:b0:3f0:a845:f215 with SMTP id l2-20020a05600c1d0200b003f0a845f215mr1374344wms.3.1682598091745;
        Thu, 27 Apr 2023 05:21:31 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c181000b003f046ad52efsm24372335wmp.31.2023.04.27.05.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 05:21:31 -0700 (PDT)
Message-ID: <a2eff7fd-5670-8c15-a72a-589fe7d99f31@grimberg.me>
Date:   Thu, 27 Apr 2023 15:21:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, Li Feng <fengli@smartx.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413063317.2455680-1-fengli@smartx.com>
 <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me>
 <E23A9D5C-35CF-412C-AE35-37389242BC71@smartx.com>
 <03a47920-9165-1d49-1380-fb4c5061df67@grimberg.me>
 <CAHckoCzBBmn8kCuD+ssRKApvFYNxedj_RkqsvgDis+iwV8g-oA@mail.gmail.com>
 <c15d89c5-4cc2-68b9-d8fa-6c3a8590cfdf@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c15d89c5-4cc2-68b9-d8fa-6c3a8590cfdf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Not saying that this should be a solution though.
>>>
>>> How many queues does your controller support that you happen to use
>>> queue 0 ?
>> Our controller only support one io queue currently.
> 
> Ouch.
> Remember, NVMe gets most of the performance improvements by using 
> several queues, and be able to bind the queues to cpu sets.
> Exposing just one queue will be invalidating any assumptions we do,
> and trying to improve interrupt steering won't work anyway.
> 
> I sincerely doubt we should try to 'optimize' for this rather peculiar 
> setup.

I tend to agree. This is not a common setup that I'm particularly
interested in exporting something dedicated in the driver for fiddling
with it...
