Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2295F1895
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 04:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiJACO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 22:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiJACO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 22:14:26 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD521AF919;
        Fri, 30 Sep 2022 19:14:25 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id w2so5726613pfb.0;
        Fri, 30 Sep 2022 19:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=39nUKBxMEtQ4k/548GHzcQvvgKYGFvJDlLo/dLbAsKs=;
        b=KiIOaV2jNyWSXEnAp14gftW4nVj10JyEXuPtUbQaD3OFG3eFoPFiFsqD1wLXYlwzDE
         obmzxzwHHPlcGcCSs29WCcm0FOjy3z5PVgmFRWxY8B6c0WCBaMssBHeQgf8b/ntAbJXR
         Oabw6iewh1FQR3GEiwuWPmAAmD6x7GrZ214r74XzLo0Ii93rPjLquziL66Gz2bO2SrSG
         BVgyyYMCwBCWmfASUQXX80zabn9Ccy1uaHI+lLdlst8Lb2bDxEBO7XkO9rwQFZKCvgFG
         /9oRoPFODRqlhtgx++j6edPBuHeI1JUYELCj9zZlHW9hLbr/y1oTMY0/aIP4uf/AG1W5
         gl/A==
X-Gm-Message-State: ACrzQf02q0VgbraXm5U69/2bmcE3Lm6Fh0GPuOk3j3Mpo9dkeGhGt5s4
        VrT7i/KNaAPulRm3AmAdTqs=
X-Google-Smtp-Source: AMsMyM5IZ9SWdvy+3MR23M5okJI2LPj5kq09p3lxCfop3u62wqmizBiTv5Ld8kTbr49f1xoKgTuRYA==
X-Received: by 2002:a65:42c8:0:b0:41a:8138:f47f with SMTP id l8-20020a6542c8000000b0041a8138f47fmr10062728pgp.476.1664590464635;
        Fri, 30 Sep 2022 19:14:24 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id o3-20020a17090ac08300b0020a73eec389sm69517pjs.3.2022.09.30.19.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 19:14:23 -0700 (PDT)
Message-ID: <c54b3271-1e3f-75cc-2a90-0d5b9b5e93b2@acm.org>
Date:   Fri, 30 Sep 2022 19:14:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v15 00/13] support zoned block devices with non-power-of-2
 zone sizes
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        Keith Busch <kbusch@kernel.org>
Cc:     jaegeuk@kernel.org, agk@redhat.com, gost.dev@samsung.com,
        snitzer@kernel.org, linux-kernel@vger.kernel.org, hare@suse.de,
        matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CGME20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65@eucas1p1.samsung.com>
 <20220923173618.6899-1-p.raghav@samsung.com>
 <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
 <bd9479f4-ff87-6e5d-296e-e31e669fb148@kernel.dk>
 <0e5088a5-5408-c5bd-bf97-00803cb5faed@acm.org>
 <bb2b3784-422f-fc82-e5be-e4d24412e21f@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <bb2b3784-422f-fc82-e5be-e4d24412e21f@opensource.wdc.com>
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

On 9/30/22 17:45, Damien Le Moal wrote:
> On 10/1/22 04:38, Bart Van Assche wrote:
>> Since this has not been mentioned in the cover letter, I want to add
>> that in the near future we will need these patches for Android devices.
>> JEDEC is working on supporting zoned storage for UFS devices, the
>> storage devices used in all modern Android phones. Although it would be
>> possible to make the offset between zone starts a power of two by
>> inserting gap zones between data zones, UFS vendors asked not to do this
>> and hence need support for zone sizes that are not a power of two. An
>> advantage of not having to deal with gap zones is better filesystem
>> performance since filesystem extents cannot span gap zones. Having to
>> split filesystem extents because of gap zones reduces filesystem
>> performance.
> 
> As mentioned many times, my opinion is that a good implementation should
> *not* have any extent span zone boundaries. So personally, I do not
> consider such argument as a valid justification for the non-power-of-2
> zone size support.

Hi Damien,

Although the filesystem extent issue probably can be solved in software, 
the argument that UFS vendors strongly prefer not to have gap zones and 
hence need support for zone sizes that are not a power of two remains.

Thanks,

Bart.

