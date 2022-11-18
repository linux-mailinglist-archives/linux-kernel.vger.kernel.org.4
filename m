Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3ED62FB9C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbiKRR1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiKRR1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:27:20 -0500
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54B5DF8B;
        Fri, 18 Nov 2022 09:27:16 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id 4so5179911pli.0;
        Fri, 18 Nov 2022 09:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSuXoCSwNdmGNsrLkM16f100zMEsciiCUvb+fP2+8Zo=;
        b=cPawLvqXPC8cgWmN4KX9KxRu94EJIvO2dV/L78M/j4Vk7fAKxjlI/918HZCqToKKE5
         RtmlLF1MkTfNFdYQVrxcGP0fWpRlL3unrHDcT/fY2KgQjO+O26d+MoUPLbdbwNUZWudA
         oXH5J1YFGQvl9NofnJM9Y6yhxXzByb5lwTrw54sHOuIBXqjhvpVSqTKGGmufnPrOiFej
         BiD45hKw0XtcpWKMRMNZ+YIpgvWWfIyGL3mnvxdbVuxLx0qmEXcuSzNeSny7frzqr0gW
         dde/PFWwEHBhv/dCSogKS68TpDOx6ycFSM+beUl14JsHsT02lBP3nlPnCULOp8agpkAf
         TOCA==
X-Gm-Message-State: ANoB5pmWZuRa5F240n6zPzMbcw12DRXlrg6j0UsZ2m0rzGQuG0p4U7Lw
        OHFiuppM7G+2Rjw20/odmIM=
X-Google-Smtp-Source: AA0mqf5ld9uUcm0BwXCXF/PhDgLbpxrFnPF34jlEiWKP2fqKrPMG4CMgkRh5sVdmyM/XgB/03ZXnQg==
X-Received: by 2002:a17:902:ec01:b0:186:878e:3b0d with SMTP id l1-20020a170902ec0100b00186878e3b0dmr357399pld.149.1668792436174;
        Fri, 18 Nov 2022 09:27:16 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:5392:f94c:13ff:af1a? ([2620:15c:211:201:5392:f94c:13ff:af1a])
        by smtp.gmail.com with ESMTPSA id h2-20020a63c002000000b0046b1dabf9a8sm3049437pgg.70.2022.11.18.09.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 09:27:15 -0800 (PST)
Message-ID: <d1a1340a-f5f8-6953-e066-b8c6095d63fd@acm.org>
Date:   Fri, 18 Nov 2022 09:27:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c1e1281e-0977-cbf7-041e-db911ee722a7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/22 02:47, Adrian Hunter wrote:
> On 26/10/22 10:30, Christian Löhle wrote:
>> Mmcblk relies on block layer requeueing to fulfill some requests under
>> certain conditions. Improve the handling to get nicely ordered requests.
>>
>> Using the terms a bit loosely to get a point across:
>> Current behavior for 512 blksz and max_blk_count = 1 the scenario would
>> be as follows:
>>
>> - request for page 0 lba 0 to 7
>> - request for page 1 lba 8 to 15
>> - request for page 2 lba 16 to 23
>> - request for page 3 lba 24 to 31
>>
>> mmcblk modifies data->blocks = 1 for each and requeues,
>> this leads to:
>>
>> Access lba 0
>> Access lba 8
>> Access lba 16
>> Access lba 24
>> Access lba 1 (1. Requeue for page 0)
>> Access lba 9 (1. Requeue for page 1)
>> Access lba 17 (1. Requeue for page 2)
>> Access lba 25 (1. Requeue for page 3)
>> Access lba 2 (2. Requeue for page 0)
>> ...
>>
>> Of course we would rather have lbas consecutive.
> 
> Does anyone know why the block layer does not support
> (max_hw_sectors << 9) < PAGE_SIZE ?

Hi Adrian,

Does this mean that the following patch series would not only be
useful for UFS but also for MMC? "[PATCH 00/10] Support DMA segments
smaller than the page size"
(https://lore.kernel.org/linux-block/20221019222324.362705-1-bvanassche@acm.org/).

Thanks,

Bart.


