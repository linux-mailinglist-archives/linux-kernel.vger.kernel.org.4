Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78A4726546
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241414AbjFGP5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241545AbjFGP5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5541BE8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686153384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0iRncZtFQPeT5Zv7xlQjJ3xhPc1E7UX/btxzeRK2d/U=;
        b=MXQsK+R6K9eFUkXx/RGqarXRBP1EB1TrD32Jnxmkulxr2nbJ6sYRm2eoP9JlVxY25tlIPk
        cMQMaAV1Hs9BDsSyj/DkIOiut3mKkDfgRPahKtEsFjy5ne2FcY7sau3EQG5uGrYj0lhRz8
        l3C43lGaNZGU6wO1PPJjmTFcNpAymL8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-zg9DgWtQMomHxvW08qOtQw-1; Wed, 07 Jun 2023 11:56:22 -0400
X-MC-Unique: zg9DgWtQMomHxvW08qOtQw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b1ebdccb9bso19133931fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686153381; x=1688745381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0iRncZtFQPeT5Zv7xlQjJ3xhPc1E7UX/btxzeRK2d/U=;
        b=aet3ncmzuQ6qisLhQkO0vz1LetoAAY4SLdbUw24UZ0cKmkWqFhk/M0FsCePt4muDFa
         QClTs59lYsGx5ILSJFTIbRjAoCgIUqWor3SCs55NHUobaoB0pDNZRq3JECrZBF3DxhJ+
         zwe2/ficHkLAIbQtSACFm4yVzW797LDOybJOCoTbMSvtyFZ6H4PYPFFFHHRuxEKRPPxQ
         vzYWEliyZBTJOuZE60579p6CkqOlve3SbSu8TC8zy/SfF6yrcrs/+6y0P1vKAfjiRoA2
         jorilVMmEimt8KIU8MHZK7P93nUezQ0QvL9FFkMbgHHyFfMnre9yhXRGju9TaZg3E7T2
         rxdg==
X-Gm-Message-State: AC+VfDwIjdjGYrypzdMqO/Q8lK4mrGar2Xv9bw7MsP7RbX5xCDXJrEpn
        G5+4fVUpQ188yRnt0Ow152VEjAZEClVCVFE0xSF6EWSoGd3eMMVxpfFTQ00oQlbRe1YtncHr4Og
        icAjpeguX5bu8Z73aNNr2HMg=
X-Received: by 2002:a2e:88c9:0:b0:2b2:b55:bd7e with SMTP id a9-20020a2e88c9000000b002b20b55bd7emr292160ljk.49.1686153380853;
        Wed, 07 Jun 2023 08:56:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7WgO2URV3ehemb/IvEATLG6LBwf3kZ2WjPiaWjIzpHWdRWQGzYz1P+l9nmx08Zyhxdl9ubmg==
X-Received: by 2002:a2e:88c9:0:b0:2b2:b55:bd7e with SMTP id a9-20020a2e88c9000000b002b20b55bd7emr292150ljk.49.1686153380496;
        Wed, 07 Jun 2023 08:56:20 -0700 (PDT)
Received: from [192.168.1.121] (62-78-130-207.bb.dnainternet.fi. [62.78.130.207])
        by smtp.gmail.com with ESMTPSA id x13-20020a2e880d000000b002ac7b0fc473sm2293149ljh.38.2023.06.07.08.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 08:56:19 -0700 (PDT)
Message-ID: <43460b82-06c0-dfca-1cfd-d99208e2c647@redhat.com>
Date:   Wed, 7 Jun 2023 18:56:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] mm/migrate_device: Try to handle swapcache pages
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Huang, Ying" <ying.huang@intel.com>
References: <20230606050149.25699-1-mpenttil@redhat.com>
 <ZICPx7RU0Qzh5zQY@infradead.org>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <ZICPx7RU0Qzh5zQY@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 7.6.2023 17.10, Christoph Hellwig wrote:
> On Tue, Jun 06, 2023 at 08:01:49AM +0300, mpenttil@redhat.com wrote:
>> From: Mika Penttilä <mpenttil@redhat.com>
>>
>> Migrating file pages and swapcache pages into device memory is not supported.
>> The decision is done based on page_mapping(). For now, swapcache pages are not migrated.
> 
> Please fix the commit log formatting, it should not exceed 7 lines.
> 
>>   		if (is_device_private_page(newpage) ||
>>   		    is_device_coherent_page(newpage)) {
>> -			/*
>> -			 * For now only support anonymous memory migrating to
>> -			 * device private or coherent memory.
>> -			 */
>> +
>>   			if (mapping) {
> 
> Very nitpicky, but this empty line looks odd.  Also isn't the comment
> still (mostly) correct given that file backed memory is still not
> supported?

Yes the comment is mostly correct and moved a few lines lower, 
complemented with a comment about the swap cache.

> 
>> +				/*
>> +				 * For now only support anonymous memory migrating to
>> +				 * device private or coherent memory.
>> +				 *
>> +				 * Try to get rid of swap cache if possible.
>> +				 *
>> +				 */
>> +				if (!folio_test_anon(folio) || !folio_free_swap(folio)) {
> 
> Please avoid the overly long lines.
> 

Thanks,
Mika

