Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02092707809
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjERCXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjERCXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:23:38 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE633C26;
        Wed, 17 May 2023 19:23:23 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ae50da739dso10847985ad.1;
        Wed, 17 May 2023 19:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684376603; x=1686968603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0HO+zrjQx0EnGmBwSxKYED9w5RWjcQswIihNrV1+/s=;
        b=Zf9NCC82DJeZNg02XdyvqXmBF684gctyWcQQKNwhZMh17HIJqYx/ZGyfz9BBLuBQKy
         AQjAuUWs5qoObQJkj9o0yuMLXj+4YeDL6D6SFK4akpzFJRNiSlfrE2FzzcAsxVhWksd6
         O/+bO9sM0oebqBoTgE97ooA+yYsyhUHWGbGd7ryB2emK4gRLEPCiH6EU5R4FL0v/MPZi
         ZMmEwgu8wbAxL+QUYyIraYfmMxoKvdQP1r9q+OD2eDhXAgVbyyPBh2EkvhdDng6kfnlA
         jnpGuAOXYSlbBU7je3PVZA/w0/ZaoswpajWfYwpK6SXINon2DMlzO1DXUkIj1/bhjym2
         WuLQ==
X-Gm-Message-State: AC+VfDw3wjxm1bpU3HQOWT+OjB7GpQj9Mv7CHHF4U9BqzOgGInmH8DDI
        D/ZUPCwPixlVIOWEcGyBlXKpKGOCbQ8=
X-Google-Smtp-Source: ACHHUZ5v65/veJm9sVIzAkJDP7o32IKI922Z1/Q9bxhyqCvGbAvUdzZp8moIlHPKev+trVh+zhXN6g==
X-Received: by 2002:a17:902:d48c:b0:1a6:ebc1:c54c with SMTP id c12-20020a170902d48c00b001a6ebc1c54cmr1275890plg.1.1684376603188;
        Wed, 17 May 2023 19:23:23 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902dac300b001ac2c3e436asm69404plx.186.2023.05.17.19.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 19:23:22 -0700 (PDT)
Message-ID: <66906bd5-d73f-af96-bf38-c6aee576fa73@acm.org>
Date:   Wed, 17 May 2023 19:23:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] ufs: don't use the fair tag sharings
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ed Tsai <ed.tsai@mediatek.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, alice.chao@mediatek.com,
        powen.kao@mediatek.com, naomi.chu@mediatek.com,
        wsd_upstream@mediatek.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230509065230.32552-1-ed.tsai@mediatek.com>
 <20230509065230.32552-3-ed.tsai@mediatek.com>
 <ZF0K7A6G2cYBjSgn@infradead.org>
 <aa9af9ae-62a4-6469-244c-b5d9106bb044@acm.org>
 <ZF5G5ztMng8Xbd1W@infradead.org>
 <2740ee82-e35f-1cbf-f5d0-373f94eb14a5@acm.org>
 <de3f41a0-b13d-d4f6-765a-19b857bce53e@huaweicloud.com>
 <86065501-ab2e-09b4-71cd-c0b18ede00ed@acm.org>
 <a26e28a6-91e0-e803-749e-2ce957711c64@huaweicloud.com>
 <097caed2-10b3-7cd1-7c06-90f983e5c720@acm.org>
 <f9ccab59-91a1-69d5-6d20-2c6ea0e24b5a@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f9ccab59-91a1-69d5-6d20-2c6ea0e24b5a@huaweicloud.com>
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

On 5/17/23 18:49, Yu Kuai wrote:
> Currently, fair share from hctx_may_queue() requires two
> atomic_read(active_queues and active_requests), I think this smoothing
> method can be placed into get_tag fail path, for example, the more times
> a disk failed to get tag in a period of time, the more tag this disk can
> get, and all the information can be updated here(perhaps directly
> record how many tags a disk can get, then hctx_may_queue() still only
> require 2 atomic_read()).

That sounds interesting to me. Do you perhaps plan to implement this 
approach and to post it as a patch?

Thanks,

Bart.

