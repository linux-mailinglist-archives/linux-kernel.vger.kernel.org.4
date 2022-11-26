Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C085639310
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 02:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiKZBUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 20:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiKZBUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 20:20:41 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFC62E9C2;
        Fri, 25 Nov 2022 17:20:40 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id md8so811847pjb.4;
        Fri, 25 Nov 2022 17:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XulCZ2usvgN6BqX4Yhk/qbQykf240rtD9jzmTcOHVKk=;
        b=xwgYXz2RpFhZIAqmNAAVp7dF42NmX746VSmJOtAY/VEHWf4OSwWxyz/G61wvcCf1DD
         J+qT7SlL4QhsdtgC3CT26RvQ1IO7tWVk+THEX052Jp8r3nNL4W47Ge4F1QOhJXhkEqrU
         UpoApIPHySqpnLeZ7j1fXrdmtyhsrkFaDX/6CNQIxS08/PVO8f/PJtlev6FiIxqe5mWt
         P9qXzAzGkCbtNoeKXaj95hVkv8Qy6o/0RVLa/kVO3/nQSpjFg8qSuEBn34iSkNANbb8G
         BDcAcyM5Nt1TwjuOKuZVWEoPzQIHy5BmvteC8SmKwcEYv5LIjERfOduzE0Yilnyc+I7P
         Ircg==
X-Gm-Message-State: ANoB5pkqgsD1j2nWNpCH3DikdgYkUt9UHb0+c2WvejGLCIvSmi0Y+WDJ
        uRbBh/snjTlGB+jzVxqnGws=
X-Google-Smtp-Source: AA0mqf67u9RYZWuIC8HPPon3znd1YWrtGAKfMBIB/J+2UVHsom3FCnTy5k2QIA3Nco4ef3hSjPmZDQ==
X-Received: by 2002:a17:902:7682:b0:182:6c84:7ff4 with SMTP id m2-20020a170902768200b001826c847ff4mr32232144pll.25.1669425639957;
        Fri, 25 Nov 2022 17:20:39 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902d4c900b00178b06fea7asm4057526plg.148.2022.11.25.17.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 17:20:39 -0800 (PST)
Message-ID: <02fdf311-5683-9932-f881-fc72e0ad8115@acm.org>
Date:   Fri, 25 Nov 2022 17:20:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 08/16] ufs: core: mcq: Allocate memory for mcq mode
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <ba753579ac3a349ee4ab61d3b0a8f705db2a9670.1669176158.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ba753579ac3a349ee4ab61d3b0a8f705db2a9670.1669176158.git.quic_asutoshd@quicinc.com>
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

On 11/22/22 20:10, Asutosh Das wrote:
> To read the bqueuedepth, the device descriptor is fetched
> in Single Doorbell Mode. This allocated memory may not be
> enough for MCQ mode because the number of tags supported
> in MCQ mode may be larger than in SDB mode.
> Hence, release the memory allocated in SDB mode and allocate
> memory for MCQ mode operation.
> Define the ufs hardware queue and Completion Queue Entry.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
