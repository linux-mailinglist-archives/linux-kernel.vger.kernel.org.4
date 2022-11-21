Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96A1632CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiKUTPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKUTOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:14:54 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2878B61768;
        Mon, 21 Nov 2022 11:14:52 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id jn7so9605340plb.13;
        Mon, 21 Nov 2022 11:14:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LForrfw/k4kDBmpFT/eGtENaxzc1S7hFGEnquIpgcGI=;
        b=bfCe9HZQgalQtLkQdZb0zxWBRKaJ0aAaMSr4r+3df/7q8Bk4m3ugp3Xo/zhhyHPlN6
         +cRrQoY9Fh7OzBwDLAjqx13q8Mt/M66xU086aGwLxPBQZHcxPZL3wwjsnEOLyeI4ZTcj
         UUAXw0fhvUOA1W6UfsOF9Cg3f2+lwZ4or4sywQfeKxnW1ovvrdxcV3uGV0eD9k1pjYdn
         bqAFVnOWRI1QR9c8IS25cf8z9ZLaAO+CWuNqcVnnpLQe6NlrnqHT5dK703GD4uJcL6zF
         k2luIcEu3GbubiK45++zZrWrmYzR09FAnKHleOk5U41kdzd0eaVtbjhTm/O6nsDODRTO
         ztZg==
X-Gm-Message-State: ANoB5pknGcT0k7bqPFAAHGmRVN8B2vZl7yB3GWVSZpUqj1PYVvcSsJkv
        0nlC6/cxTBDdfMpHcFdajbL/ICMJ2dI=
X-Google-Smtp-Source: AA0mqf4Mn37XOmi0UK54FjPQM0Ylag6LcAD2uUA69TZL/zh+QUotfv8YF1utw0FPCTxUhZKU05z9AQ==
X-Received: by 2002:a17:90b:b17:b0:218:a733:25ec with SMTP id bf23-20020a17090b0b1700b00218a73325ecmr9090982pjb.152.1669058091521;
        Mon, 21 Nov 2022 11:14:51 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:545d:bfd:7b53:8e94? ([2620:15c:211:201:545d:bfd:7b53:8e94])
        by smtp.gmail.com with ESMTPSA id b8-20020a1709027e0800b0016c0c82e85csm10102490plm.75.2022.11.21.11.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 11:14:50 -0800 (PST)
Message-ID: <bade026a-ec83-7516-d5ef-bb373df48a6e@acm.org>
Date:   Mon, 21 Nov 2022 11:14:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 0/3] mmc: Improve block layer requeueing behavior
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>
References: <f30ec7fe7d834c1d8e116508500110cf@hyperstone.com>
 <c1e1281e-0977-cbf7-041e-db911ee722a7@intel.com>
 <d1a1340a-f5f8-6953-e066-b8c6095d63fd@acm.org>
 <5df2c4d5-f426-e3ea-8e6d-f772ec7091b6@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5df2c4d5-f426-e3ea-8e6d-f772ec7091b6@intel.com>
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

On 11/21/22 00:25, Adrian Hunter wrote:
> On 18/11/22 19:27, Bart Van Assche wrote:
>> On 11/18/22 02:47, Adrian Hunter wrote:
>>> Does anyone know why the block layer does not support
>>> (max_hw_sectors << 9) < PAGE_SIZE ?
>>
>> Does this mean that the following patch series would not only be
>> useful for UFS but also for MMC? "[PATCH 00/10] Support DMA segments
>> smaller than the page size"
>> (https://lore.kernel.org/linux-block/20221019222324.362705-1-bvanassche@acm.org/).
> 
> That patchset still does not allow max_hw_sectors = 1 which is
> what Christian's case needs.

Hi Adrian,

Why would that patch series not support max_hw_sectors = 1? What am I 
overlooking?

Thanks,

Bart.


