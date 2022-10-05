Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E6A5F58A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiJEQyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJEQyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:54:20 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168E24B9A8;
        Wed,  5 Oct 2022 09:54:19 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id a26so7312736pfg.7;
        Wed, 05 Oct 2022 09:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GFGmeXwzImdz1h+PmMN1s24FBEmejNYEC+q1xWfXEck=;
        b=JWf5VAz03AB4CkFEpVkfUEWgtmAjJ4wGjWY6babOa0PJChJcZ0ezYXykprUlrHwiZI
         v4HeZ+6jF5Zc9NjJfsUXsfGdHdhUlxn+xq8+UZhFtyFx10UOs5HuapVHHEEV1dBSSZKO
         KJB5TzZHCYSU9kh0p88M7P0C8IefFbGGgDi1G1GSt1/qTXGXsuU46m0CugrWM7VM16Ij
         RGFlghN5WfCPvJH5qA8zH13aK7nx54zJbv9rOfw076haEwshRGTTLkH5rvY0F/2rF6cE
         SDmINa9yM5lYV92oWR8yDyMsUAg7unn74YelZwFnJPrRzziKhlqSe/C0uegYbM6TGUdR
         Z4yA==
X-Gm-Message-State: ACrzQf1lcWB49zedkrBYX6YwlzM9c5IM6GtxENQxzEP5otYjmzY10mkW
        QrgsR6WdcKI8yP5lU4tDIQ4=
X-Google-Smtp-Source: AMsMyM5oX6qSPQ4HG3bu8E8hjU3lPQSUd8WrMcNcjR4MljBf6naYCl5wsAAwQMON9m5RMKfn4/SRMQ==
X-Received: by 2002:a62:2985:0:b0:544:77d4:f43b with SMTP id p127-20020a622985000000b0054477d4f43bmr726456pfp.9.1664988858370;
        Wed, 05 Oct 2022 09:54:18 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b00176c6738d13sm10795484plx.169.2022.10.05.09.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 09:54:17 -0700 (PDT)
Message-ID: <e0ea0b0a-5077-de37-046f-62902aca93b6@acm.org>
Date:   Wed, 5 Oct 2022 09:54:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 01/21] block: add and use init tagset helper
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, axboe@kernel.dk, efremov@linux.com,
        josef@toxicpanda.com, idryomov@gmail.com,
        dongsheng.yang@easystack.cn, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, mst@redhat.com, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com, ohad@wizery.com,
        andersson@kernel.org, baolin.wang@linux.alibaba.com,
        richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
        marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, sth@linux.ibm.com,
        hoeppner@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, bhelgaas@google.com,
        john.garry@huawei.com, mcgrof@kernel.org,
        christophe.jaillet@wanadoo.fr, vaibhavgupta40@gmail.com,
        wsa+renesas@sang-engineering.com, johannes.thumshirn@wdc.com,
        ming.lei@redhat.com, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com, christoph.boehmwalder@linbit.com,
        joel@jms.id.au, vincent.whitchurch@axis.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, asahi@lists.linux.dev
References: <20221005032257.80681-1-kch@nvidia.com>
 <20221005032257.80681-2-kch@nvidia.com>
 <6fee2d7a-7fd1-73ee-2911-87a4ed3e8769@opensource.wdc.com>
 <CAPDyKFpBpiydQn+=24CqtaH_qa3tQfN2gQSiUrHCjnLSuy4=Kg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAPDyKFpBpiydQn+=24CqtaH_qa3tQfN2gQSiUrHCjnLSuy4=Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/22 02:47, Ulf Hansson wrote:
> On Wed, 5 Oct 2022 at 07:11, Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:
>> On 10/5/22 12:22, Chaitanya Kulkarni wrote:
>>> +void blk_mq_init_tag_set(struct blk_mq_tag_set *set,
>>> +             const struct blk_mq_ops *ops, unsigned int nr_hw_queues,
>>> +             unsigned int queue_depth, unsigned int cmd_size, int numa_node,
>>> +             unsigned int timeout, unsigned int flags, void *driver_data)
>>
>> That is an awful lot of arguments... I would be tempted to say pack all
>> these into a struct but then that would kind of negate this patchset goal.
>> Using a function with that many arguments will be error prone, and hard to
>> review... Not a fan.
> 
> I completely agree.
> 
> But there is also another problem going down this route. If/when we
> realize that there is another parameter needed in the blk_mq_tag_set.
> Today that's quite easy to add (assuming the parameter can be
> optional), without changing the blk_mq_init_tag_set() interface.

Hi Chaitanya,

Please consider to drop the entire patch series. In addition to the 
disadvantages mentioned above I'd like to mention the following 
disadvantages:
* Replacing named member assignments with positional arguments in a
   function call makes code harder to read and harder to verify.
* This patch series makes tree-wide changes without improving the code
   in a substantial way.

Thanks,

Bart.

