Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEAB5E7F99
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiIWQVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbiIWQUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:20:47 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0A51A209;
        Fri, 23 Sep 2022 09:19:52 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so6323859pjq.3;
        Fri, 23 Sep 2022 09:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vnSOT79vZm2Z1X3vBb9NByt6VpxGbBF310FVdgigcRo=;
        b=AnKstt4jHs13SEIbBQjTLVpMdnTxp4iC2lGMr97kEGL1/nOIMX0wGXSLJwEh1C5DlN
         svQxtFNscoAO8ZSQZ63YeMluOLAqXUJDAInRhIfuoY0NzEIXDl5gqYnU09ECmEGFzk0a
         UFiMH1aAcfdJqW9jA+1dAatW4jqSZ/2vM1nDfX1fdC+Uu3o5rbcWTEYFsZejw5iDtds/
         sI+1ODLNtPx6DymzjNwVQK5M5DGz95m9VyrnYuEY8YgFBynAix3esmnBHdHNNIJZQhtZ
         0ey4mWjMjpp8HV1LlaovCGgPh6i5/Y7kyxBcROp2sknAO3wcGAoU+yq2GNWy6/IyFNK0
         6AEQ==
X-Gm-Message-State: ACrzQf2SQr4ao71itcMWsdL3xicS+Ect41LPwxz/q+x7FhKbUXepj1/C
        vg4ExZPJwad8K5Gt1DFuDdU=
X-Google-Smtp-Source: AMsMyM5CMCm0D86HYnpQDo/X7/UqnWT+5BzKuiOzTeV53omgR+X965yxoHmyOZ/dbkOcdr27tB35Ow==
X-Received: by 2002:a17:90a:c782:b0:202:c73e:5488 with SMTP id gn2-20020a17090ac78200b00202c73e5488mr21574508pjb.202.1663949991522;
        Fri, 23 Sep 2022 09:19:51 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:aa13:bc38:2a63:318e? ([2620:15c:211:201:aa13:bc38:2a63:318e])
        by smtp.gmail.com with ESMTPSA id x18-20020a634852000000b004388f33b80esm5811710pgk.2.2022.09.23.09.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 09:19:50 -0700 (PDT)
Message-ID: <396ddf4d-5a81-f6dc-b98f-a6cdad553e91@acm.org>
Date:   Fri, 23 Sep 2022 09:19:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: Please further explain Linux's "zoned storage" roadmap [was: Re:
 [PATCH v14 00/13] support zoned block devices with non-power-of-2 zone sizes]
Content-Language: en-US
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Cc:     "agk@redhat.com" <agk@redhat.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>
References: <CGME20220920091120eucas1p2c82c18f552d6298d24547cba2f70b7fc@eucas1p2.samsung.com>
 <20220920091119.115879-1-p.raghav@samsung.com> <YytJhEywBhqcr7MX@redhat.com>
 <7dd9dbc0-b08b-fa47-5452-d448d86ca56b@opensource.wdc.com>
 <8fd1d8b1-9f43-eb03-4a7f-187723d1c483@acm.org>
 <BYAPR04MB4968EB5E341049DFF973B9B1F1519@BYAPR04MB4968.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <BYAPR04MB4968EB5E341049DFF973B9B1F1519@BYAPR04MB4968.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/22 23:29, Matias Bjørling wrote:
> With UFS, in the proposed copy I have (may been changed) - there's
> the concept of gap zones, which is zones that cannot be accessed by
> the host. The gap zones are essentially "LBA fillers", enabling the
> next writeable zone to start at a X * pow2 size offset. My
> understanding is that this specific approach was chosen to simplify
> standardization in UFS and avoid updating T10's ZBC with zone
> capacity support.
> 
> While UFS would technically expose non-power of 2 zone sizes, they're
> also, due to the gap zones, could also be considered power of 2 zones
> if one considers the seq. write zone + the gap zone as a single
> unit.
> 
> When I think about having UFS support in the kernel, the SWR and the
> gap zone could be represented as a single unit. For example:
> 
> UFS - Zone Report
>    Zone 0: SWR, LBA 0-11
>    Zone 1: Gap, LBA 12-15
>    Zone 2: SWR, LBA 16-27
>    Zone 3: Gap, LBA 28-31
>    ...
> 
> Kernel representation - Zone Report (as supported today)
>    Zone 0: SWR, LBA 0-15, Zone Capacity 12
>    Zone 1: SWR, LBA 16-31, Zone Capacity 12
>    ...
> 
> If doing it this way, it removes the need for filesystems,
> device-mappers, user-space applications having to understand gap
> zones, and allows UFS to work out of the box with no changes to the
> rest of the zoned storage eco-system.
> 
> Has the above representation been considered?

Hi Matias,

What has been described above is the approach from the first version of 
the zoned storage for UFS (ZUFS) draft standard. Support for this 
approach is available in the upstream kernel. See also "[PATCH v2 0/9] 
Support zoned devices with gap zones", 2022-04-21 
(https://lore.kernel.org/linux-scsi/20220421183023.3462291-1-bvanassche@acm.org/).

Since F2FS extents must be split at gap zones, gap zones negatively 
affect sequential read and write performance. So we abandoned the gap 
zone approach. The current approach is as follows:
* The power-of-two restriction for the offset between zone starts has 
been removed. Gap zones are no longer required. Hence, we will need the 
patches that add support for zone sizes that are not a power of two.
* The Sequential Write Required (SWR) and Sequential Write Preferred 
(SWP) zone types are supported. The feedback we received from UFS 
vendors is that which zone type works best depends on their firmware and 
ASIC design.
* We need a queue depth larger than one (QD > 1) for writes to achieve 
the full sequential write bandwidth. We plan to support QD > 1 as follows:
   - If writes have to be serialized, submit these to the same hardware
     queue. According to the UFS host controller interface (UFSHCI)
     standard, UFS host controllers are not allowed to reorder SCSI
     commands that are submitted to the same hardware queue. A source of
     command reordering that remains is the SCSI retry mechanism. Retries
     happen e.g. after a command timeout.
   - For SWP zones, require the UFS device firmware to use its garbage
     collection mechanism to reorder data in the unlikely case that
     out-of-order writes happened.
   - For SWR zones, retry writes that failed because these were received
     out-of-order by a UFS device. ZBC-1 requires compliant devices to
     respond with ILLEGAL REQUEST / UNALIGNED WRITE COMMAND to out-of-
     order writes.

We have considered the zone append approach but decided not to use it 
because if zone append commands get reordered the data ends up 
permanently out-of-order on the storage medium. This affects sequential 
read performance negatively.

Bart.
