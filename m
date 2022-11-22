Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1416063448A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiKVT3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiKVT3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:29:12 -0500
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B8E920B4;
        Tue, 22 Nov 2022 11:29:10 -0800 (PST)
Received: by mail-pl1-f181.google.com with SMTP id 4so14655223pli.0;
        Tue, 22 Nov 2022 11:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+SZqUZBgX2LO2pgTHb7GO+NG50V5PkmPLMToKbj5so=;
        b=DG4ukGImo8LHmQsEO03H1pAAfj00GvI+GieFthEfBWBVK7wuTI2RYlLNtfLaAKGGIO
         hbrQR39R1/+vbc5M18gGQzjLz37Zc3P/gmgYo4iHZd4uINhcNA3YDg17NZxKl/lxUQY1
         6PRq8Iv7SMgz+t2VbKiLlEha4Thbfoji8WImyEDOq+nf16YUs+/9CRQ0CJqDqKVxjm71
         NxtSM6vG5E3liFSegHSl2QQ4gPW2spUjsaw5JwFXayHHAogpCobpma4qpijPI8mwrtcD
         2FI0+tdytVNT4hlK6xq1xDfDNqaedw5kzrJ0oeEXnJFWM+EZl9v3JzTfSJGGYh3qdaaQ
         +mWQ==
X-Gm-Message-State: ANoB5pma7w4gjszYU4KWWYa4gXOqViE4PNiY/rJM5ZTpsSh4esaZwVzK
        FcrV2U9hcf9vhQ98mP7a514=
X-Google-Smtp-Source: AA0mqf4SNRdsRpa8tN/44ALl0pdVPsCbKhnsc3zVPfln7ViBeFvMKPlgN/7R3U4cgv2axH203OuinA==
X-Received: by 2002:a17:902:a38e:b0:189:1c93:c3a1 with SMTP id x14-20020a170902a38e00b001891c93c3a1mr8943069pla.26.1669145350031;
        Tue, 22 Nov 2022 11:29:10 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:3c88:9479:e09c:9acb? ([2620:15c:211:201:3c88:9479:e09c:9acb])
        by smtp.gmail.com with ESMTPSA id lb9-20020a17090b4a4900b00218772ceaa3sm10282394pjb.41.2022.11.22.11.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 11:29:08 -0800 (PST)
Message-ID: <6c34dfee-0ed6-be99-4180-1239ed495437@acm.org>
Date:   Tue, 22 Nov 2022 11:29:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 0/3] mmc: Improve block layer requeueing behavior
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>
References: <f30ec7fe7d834c1d8e116508500110cf@hyperstone.com>
 <c1e1281e-0977-cbf7-041e-db911ee722a7@intel.com>
 <d1a1340a-f5f8-6953-e066-b8c6095d63fd@acm.org>
 <5df2c4d5-f426-e3ea-8e6d-f772ec7091b6@intel.com>
 <bade026a-ec83-7516-d5ef-bb373df48a6e@acm.org>
 <1c9b3db6-3443-5580-08f2-42520d6a3318@intel.com>
 <4bba6b72-c361-f212-a8c3-9e33aab80c99@acm.org>
 <DM6PR04MB6575EDCCDD993EEEA14A99A2FC0D9@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB6575EDCCDD993EEEA14A99A2FC0D9@DM6PR04MB6575.namprd04.prod.outlook.com>
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

On 11/21/22 23:21, Avri Altman wrote:
> Once you do, please publish it to the scsi mailing list as well.

I will Cc the linux-scsi mailing list.

Thanks,

Bart.

