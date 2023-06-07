Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D446B726572
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbjFGQHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjFGQHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3541BF7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 09:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686153971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dly7/nCBzZZXC5QhcTqk+CJwOsMviqDWt2wg2OFJMg4=;
        b=fahrywINHLJ/rJ4Csko7oUXxB9Buv7tz7CPmdD20lkLWBLTNm0LsjeUVa86qMANWkKDb91
        0cf5EpUsfGMfsf9Qf0T9/JStB0/gd2J40DSKXDlSjvwHVUzcpO1eOMR0W2VkylaC6a26hS
        uIsjWN6SgP20OY6NavnplJ9vd7CBBiI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-5pqzWyuaNBqYMHYSp5CUZQ-1; Wed, 07 Jun 2023 12:06:09 -0400
X-MC-Unique: 5pqzWyuaNBqYMHYSp5CUZQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b1bbe83720so27279581fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 09:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686153968; x=1688745968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dly7/nCBzZZXC5QhcTqk+CJwOsMviqDWt2wg2OFJMg4=;
        b=CCqZ+MPjEfC0fymWDpaUd2Oo7BOxsxLsYkym78imCLxhUypRwDY6LXZs2K1nrM7Hl4
         XwAzdxaSfpUOFKvhnWNOyZVrs2LnrN5KPK7F1u47jXtVfkApJ2t3LtKnVyT2y+YyBG8c
         4Slh5++5qrgcfi+O62+u8r5qOWkmwzhfpVU17gopxfGrrhmscs7fC/KzXmGpyxOrulxs
         RNKpeQg/Lbd+1u7zyUCHgGph4U3x25oAC3Yg7m4sDFdoO/Qu2+IY/OYcbE4ges5KFSKe
         JtZ1FjRoFTQzEnA2rzjUoBTzJ4QaV1gBW4yh9RTgxSwXfM6NvGc6aUkRw9XyIXrkAsPh
         L0fw==
X-Gm-Message-State: AC+VfDwhYq0HAniWgJwJ7B4U5ARYsGCMGuc26Bo4121x1hVXrBOZRbGv
        bwB1rn/xOYAkO3mIqrqXw8FzMa+2ZK3kCu+92Fhcvg7eyg5SUhHduKWI2jus+5CCWS/PNckFDrA
        uBu77sxkoCSQxVkEB4c7J9Qk=
X-Received: by 2002:a2e:9d02:0:b0:2af:19dd:ecda with SMTP id t2-20020a2e9d02000000b002af19ddecdamr2192502lji.45.1686153967992;
        Wed, 07 Jun 2023 09:06:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72H24p2aVmEA9IsU80u724sMI1SEKXyYKX0eGrwkbztULL+CZPTfOOpYAT4LEIRcCJ2GK2aQ==
X-Received: by 2002:a2e:9d02:0:b0:2af:19dd:ecda with SMTP id t2-20020a2e9d02000000b002af19ddecdamr2192494lji.45.1686153967707;
        Wed, 07 Jun 2023 09:06:07 -0700 (PDT)
Received: from [192.168.1.121] (62-78-130-207.bb.dnainternet.fi. [62.78.130.207])
        by smtp.gmail.com with ESMTPSA id y12-20020ac2446c000000b004f388c5f25dsm1861049lfl.257.2023.06.07.09.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 09:06:07 -0700 (PDT)
Message-ID: <20adfaff-054f-ab5e-0ff4-4ce3952fbd58@redhat.com>
Date:   Wed, 7 Jun 2023 19:06:06 +0300
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



On 7.6.2023 17.10, Christoph Hellwig wrote:
> On Tue, Jun 06, 2023 at 08:01:49AM +0300, mpenttil@redhat.com wrote:
>> From: Mika Penttilä <mpenttil@redhat.com>
>>
>> Migrating file pages and swapcache pages into device memory is not supported.
>> The decision is done based on page_mapping(). For now, swapcache pages are not migrated.
> 
> Please fix the commit log formatting, it should not exceed 7 lines.

Not sure what you mean should not exceed 7 lines..?

