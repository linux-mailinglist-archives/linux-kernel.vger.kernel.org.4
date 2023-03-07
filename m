Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EFE6AF8FE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjCGWh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjCGWh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:37:29 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276F5A0F16;
        Tue,  7 Mar 2023 14:36:39 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n5so9067240pfv.11;
        Tue, 07 Mar 2023 14:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678228512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+Bqq7D35Ijae/QSGu2rlUEpNQBgDXK/ur3c6IQ+MQU=;
        b=DljTzZQp9L3sW2AZ0P6BMWDd2Sd5Ich4T+XMrHBi0uosLWxJZRLMmZr7ari8jWy9My
         tfoiu+j1Gbwv/myTOCfGdEnGeRl1ZATVej5lFEuv9hDA3exFlWKhtJk5jf1qmG0cnj5R
         Rq5KMk0sRlXxaTp8nAPOZsBnMZrQ+ACPPCb6XYZ1ggyOK0WnoP0PA6drONVwZ4Ngyrao
         XOnsmoTWjeYJrc1ErEZMsdMxreKcd6H0jiIXcXtG3b63uhGX5wboYotYe/lo7GshFgIb
         zDqy6df49yb2q4G2occPpn7Hnpu72f3XEVXPoeygs1NYlaALpxkTa3YX9zaStIH6kXAx
         Qimg==
X-Gm-Message-State: AO0yUKVJltixNSQdfKRm706vMxL/Z2x9jhTf3sk8fhBz2xd8bYw9YxBP
        shHEa9CODiKkbzETVHesvNg=
X-Google-Smtp-Source: AK7set/NEu636qUdnCcAM0+gzvLp5Lbojq0C5GqAaquPOS8o+c98P6qhQI9mtw0SnkIPpbkC4gbHvA==
X-Received: by 2002:aa7:941d:0:b0:5f1:f57a:b0c3 with SMTP id x29-20020aa7941d000000b005f1f57ab0c3mr14790449pfo.5.1678228511844;
        Tue, 07 Mar 2023 14:35:11 -0800 (PST)
Received: from [192.168.132.235] ([63.145.95.70])
        by smtp.gmail.com with ESMTPSA id z19-20020aa785d3000000b005ded4825201sm8337199pfn.112.2023.03.07.14.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 14:35:10 -0800 (PST)
Message-ID: <d119fcba-a323-d0cd-0d36-759ad2fb8252@acm.org>
Date:   Tue, 7 Mar 2023 14:35:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH-next v2 Resend] scsi: fix use-after-free problem in
 scsi_remove_target
Content-Language: en-US
To:     Zhong Jinghua <zhongjinghua@huaweicloud.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huaweicloude.com, yi.zhang@huawei.com,
        yukuai3@huawei.com
References: <20230306121636.3183761-1-zhongjinghua@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230306121636.3183761-1-zhongjinghua@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 04:16, Zhong Jinghua wrote:
> +			/*
> +			 * If the reference count is already zero, skip this
> +			 * target is safe  because scsi_target_destroy()
> +			 * will wait until the host lock has been released
> +			 * before freeing starget.
> +			 */

The above comment has grammatical issues and is confusing. I think the 
comment that I suggested was much better than the above.

Bart.

