Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486D65F12D0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiI3Ti5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbiI3Tiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:38:54 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D112C149780;
        Fri, 30 Sep 2022 12:38:52 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id l12so4952850pjh.2;
        Fri, 30 Sep 2022 12:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gjDYcfQrPymPgf4zZHF6ExZnXFdO/ag78V3ukKEreZ8=;
        b=kb10rTWlUKTqJRtFUDbI2061gIYzUD719SiT2UKCGXQdo7XP3i1nx7UE5sII7iW6CQ
         fEr/CLkfds3t/VHl+4+rGM+6A01b87uRLNMgv7kxF3R5uFhUT/YFxil67oMyjjvxMdcr
         qvGu97KngDV4Mv5SGmhqKL9OUKDTJLXZWwvOEPsEm2PR++etO1w/1MLcuA2kTin98sub
         hQ8isdmZPD6NujUgigIuUNEYNbrwhOz7JBIcLosjeaXSgYu68/PyVIyHXaLcbe4nsyfx
         Kb1sUWNFc/E/nEyjUdaDtLYvHiTha96qUwa8RZef4qRnSr/+bg9y+iWLqW9aHOORtssj
         rPZg==
X-Gm-Message-State: ACrzQf2FFeInIXQiZTKPK3pOsN/3Top2QCWFt1df7J6KxxAf5LKxLorc
        Y1IlR/gDxyiUeg4AlqpHxoM=
X-Google-Smtp-Source: AMsMyM6wPTQbb/wpm4NYDTyzteu9Ju/f5nYNm4NlJda34lAJsiPgMThwpAp8l1Io6xLGw26w5R/LwQ==
X-Received: by 2002:a17:90b:3149:b0:202:e9e9:632f with SMTP id ip9-20020a17090b314900b00202e9e9632fmr24463065pjb.96.1664566732077;
        Fri, 30 Sep 2022 12:38:52 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:56f2:482f:20c2:1d35? ([2620:15c:211:201:56f2:482f:20c2:1d35])
        by smtp.gmail.com with ESMTPSA id z5-20020aa79f85000000b0052e6c058bccsm2187903pfr.61.2022.09.30.12.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 12:38:51 -0700 (PDT)
Message-ID: <0e5088a5-5408-c5bd-bf97-00803cb5faed@acm.org>
Date:   Fri, 30 Sep 2022 12:38:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v15 00/13] support zoned block devices with non-power-of-2
 zone sizes
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Pankaj Raghav <p.raghav@samsung.com>,
        hch@lst.de, Keith Busch <kbusch@kernel.org>
Cc:     jaegeuk@kernel.org, agk@redhat.com, gost.dev@samsung.com,
        snitzer@kernel.org, damien.lemoal@opensource.wdc.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CGME20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65@eucas1p1.samsung.com>
 <20220923173618.6899-1-p.raghav@samsung.com>
 <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
 <bd9479f4-ff87-6e5d-296e-e31e669fb148@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <bd9479f4-ff87-6e5d-296e-e31e669fb148@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/22 08:13, Jens Axboe wrote:
> On 9/29/22 12:31 AM, Pankaj Raghav wrote:
>>> Hi Jens,
>>>    Please consider this patch series for the 6.1 release.
>>>
>>
>> Hi Jens, Christoph, and Keith,
>>   All the patches have a Reviewed-by tag at this point. Can we queue this up
>> for 6.1?
> 
> It's getting pretty late for 6.1 and I'd really like to have both Christoph
> and Martin sign off on these changes.

Hi Jens,

Agreed that it's getting late for 6.1.

Since this has not been mentioned in the cover letter, I want to add 
that in the near future we will need these patches for Android devices. 
JEDEC is working on supporting zoned storage for UFS devices, the 
storage devices used in all modern Android phones. Although it would be 
possible to make the offset between zone starts a power of two by 
inserting gap zones between data zones, UFS vendors asked not to do this 
and hence need support for zone sizes that are not a power of two. An 
advantage of not having to deal with gap zones is better filesystem 
performance since filesystem extents cannot span gap zones. Having to 
split filesystem extents because of gap zones reduces filesystem 
performance.

Thanks,

Bart.


