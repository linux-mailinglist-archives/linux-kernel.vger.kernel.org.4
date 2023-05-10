Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD606FE7C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjEJW4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236594AbjEJW4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:56:16 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BE07EF4;
        Wed, 10 May 2023 15:56:06 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-24df161f84bso5574536a91.3;
        Wed, 10 May 2023 15:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683759365; x=1686351365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nisiLdB8YvztSzgK+xwlknRcIDe1797ySbT6V+jwQCk=;
        b=gPU8tf+Jr8+mJeEggLF0IBYh3XCDryTh2BK+48GuAnxn4F6Cj8Yiv6WMr2qXQbuw2U
         Qk9tGHqXPykbFhV1oUxeM+KdjTp4QoOEtrBFnaYCUxccJSuDT8oEIbGZWmsnxOPkDxHD
         zTjSIu/YE+WSs6yEfOMPI4ZnKv2MPJ527Xppy17cFWiT4DgBTpPjdQ+aYthh0lKZMPua
         27N6fjU/9Dw8fzKhxHDPg+VWRvbGlRYGL98tNPR9JCJ8VR3SBny7hP6kOwe2qCRJRjlB
         7hhicTrxfx83JkJeVr7Q03HvSM9plDA2YXlftYEh9YGHjignTpBTCD406iZahvEDFss/
         bBmw==
X-Gm-Message-State: AC+VfDw4kSUdQJr46kscHhtZovJbvd0YLOgo5NvGyrMj5RyMWyD79qlk
        /bHCftaDiASTWiCS9LtDY+w=
X-Google-Smtp-Source: ACHHUZ5setZPdY2I/a8GzOPENYkm6C4TcWEQbx0V5J9Ab+xSrae8W8bQIiOlbvRXXOpqvaFSKCejrA==
X-Received: by 2002:a17:90b:198c:b0:244:9385:807f with SMTP id mv12-20020a17090b198c00b002449385807fmr18503926pjb.44.1683759365396;
        Wed, 10 May 2023 15:56:05 -0700 (PDT)
Received: from ?IPV6:2001:4958:15a0:30:63c6:648e:7352:e65e? ([2001:4958:15a0:30:63c6:648e:7352:e65e])
        by smtp.gmail.com with ESMTPSA id g24-20020a17090a579800b0024dee5cbe29sm18658135pji.27.2023.05.10.15.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 15:56:04 -0700 (PDT)
Message-ID: <8947b1be-3dfb-4c9f-469f-d1c31d1ec994@acm.org>
Date:   Wed, 10 May 2023 15:56:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] block: improve the share tag set performance
Content-Language: en-US
To:     axboe@kernel.dk
Cc:     Ed Tsai <ed.tsai@mediatek.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        alice.chao@mediatek.com, powen.kao@mediatek.com,
        naomi.chu@mediatek.com, wsd_upstream@mediatek.com
References: <20230509065230.32552-1-ed.tsai@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230509065230.32552-1-ed.tsai@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 23:52, Ed Tsai wrote:
> The tag allocation is limited by the number of active queues and a
> queue is marked as inactive by the queue timeout worker after up to 30Hz
> by default.
> 
> UFS devices have multiple logical units, and they can limit the depth of
> data LUNs by the fair tag sharing algorithm. Make the fair tag sharing
> configurable and improve the performance for UFS devices.
> 
> See also https://lore.kernel.org/all/20230103195337.158625-1-bvanassche@acm.org

Hi Jens,

This patch series is slightly more complicated than the patch that I 
posted in January. Do you prefer the approach of this patch series or 
rather the approach of the patch that I posted in January?

Thank you,

Bart.


