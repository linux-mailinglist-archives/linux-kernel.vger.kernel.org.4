Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BC6686CBA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjBARUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjBARUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:20:47 -0500
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED95A5CE7A;
        Wed,  1 Feb 2023 09:20:43 -0800 (PST)
Received: by mail-pf1-f179.google.com with SMTP id g9so13098876pfo.5;
        Wed, 01 Feb 2023 09:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/m5EN+3VdeWh1OMObW1zbnBPYL38BrWixkk4sUJ7ZQ=;
        b=bMbpXTH8p3ntjbe6qSoF7braFyRcZAqI6Wmt+3xf62Sw2p9ZvRgJA7zbSpPreNDTf8
         yU1bRoOsdXy3k8Mo78rauUVTYYjdEtZLsqOg2Xehwltd2GiWMcd3zlatsXerhqsp5fHA
         lPnRiDuK3xDqiiXP0N+aNt0/I5Pwh2+gX/+lwNgyImiGBqhlpHokHW7hsq/3PrwHdV42
         PaXzUNB1o64SyjdGcGVSDX0xw56PMU26roeeJQhrjTxm+NscwAba8Hx58J++6DQQYqjA
         4yOyYiuuDRw6CcFj/p821eOi5rTSVyEJCpMN27hvAW7RAoKB8UnObrTP29gAKKUCHlaF
         lHyA==
X-Gm-Message-State: AO0yUKW6T94HmCEw2WWtbeL6M1V2ru4ko10CS4b6lTQLJz5VBJT4BTm3
        TKnGmJwxHMOZR2LBERtRN3Q=
X-Google-Smtp-Source: AK7set/7Sg43RCqeO0j24bZVWFb7mbonwYPKYBQa0jAvf+8TBoY5Sb5oEMP5EanhSM5rOlqHMRBfdw==
X-Received: by 2002:a05:6a00:1f04:b0:593:adeb:39a9 with SMTP id be4-20020a056a001f0400b00593adeb39a9mr2748694pfb.33.1675272042391;
        Wed, 01 Feb 2023 09:20:42 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:f3cf:17ca:687:af15? ([2620:15c:211:201:f3cf:17ca:687:af15])
        by smtp.gmail.com with ESMTPSA id x5-20020a056a00188500b0059072da44f3sm5879618pfh.130.2023.02.01.09.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 09:20:41 -0800 (PST)
Message-ID: <b9bc20f3-cf68-6546-1979-6b36f622913f@acm.org>
Date:   Wed, 1 Feb 2023 09:20:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] scsi: ufs: core: Limit DMA alignment check
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mani@kernel.org
References: <20230201034917.1902330-1-quic_bjorande@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230201034917.1902330-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/23 19:49, Bjorn Andersson wrote:
> The three DMA memory regions allocated for the host memory space is
> documented to require alignment of 128, 1024 and 1024 respectively, but
> the returned address is checked for PAGE_SIZE alignment.
> 
> In the case these allocations are serviced by e.g. the Arm SMMU, the
> size and alignment will be determined by its supported page sizes. In
> most cases SZ_4K and a few larger sizes are available.
> 
> In the typical configuration this does not cause problems, but in the
> event that the system PAGE_SIZE is increased beyond 4k, it's no longer
> reasonable to expect that the allocation will be PAGE_SIZE aligned.
> 
> Limit the DMA alignment check to the actual alignment requirements
> written in the comments in the code, to avoid the UFS core refusing to
> initialize with such configuration.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
