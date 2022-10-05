Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A6F5F5208
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJEJsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJEJsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:48:13 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD1C6CF4F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 02:48:11 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 70so15110359pjo.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 02:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uAiOjs73GnPtRWDKlCBYpOmHeG3ElDSPTXYVbLmJn3Y=;
        b=dh/s9gbrJ1NP2il6j7m7392rb5m/0olUhLw6ywfYrwbm+b05mgthbXGVeHCne6faSe
         nEB8FWIww9/Mh3TPJYBTwQxHk9YQhBfOYEWSgISGS3x2V+1PSzpPW0fGwHCNvRUrDmsC
         V4LPjNBP1ZNWd2lWycmQ+cVlk2hOYpk0wbD3BQW90ktRdTfHVQoOGdzFfsVLA+UV8P0L
         yaYjHeb70WMgWdHpn0iX5L8LgNN78O1ThcYXr+GHqSaFRNBAWLFYqLr8IpSUK6wbVOaM
         BO7XUtm7Hdl6sqI52mxM7YweUuOKwjFV07IZc9k6gah2y9PsEzpdZlxqQ3TbFVT9xR+n
         gOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uAiOjs73GnPtRWDKlCBYpOmHeG3ElDSPTXYVbLmJn3Y=;
        b=l7SghzjNpVSxuJCqfRtM+wmrKqWfQtksWWApP0OedKTDjrR5yc43hU1ykbDLl8aAsK
         JCUN8l8xLMOwMULStbefMhbxELp9zY5haoZoZDbI7UsjSeuU70vduh8cULhr5dQMDhUM
         Cd8mXp4K4Tx3fc8voDEN0Sg+cZhrK6JlQPkjBTlhNE/WQh1lZhxuYIzx3P3X3SUgE5Ew
         MlgzGp4X8GuLcqmWEhsarsdbhwyefZhS3XYyiw3UclR8gZl4TPJtJOBVqg2QMCO/+9wJ
         cxZE1fUSZvYaCCWCXOFZXqm3zy8tl3NNLwDqmhkyrVUsJRRdyrazsvViP9NqEB6fJ5jy
         PFvw==
X-Gm-Message-State: ACrzQf1nrXvbpy6x/TCjpoD+9RMz4wgyh5FgQvRCPEv7IV+EqfiDH3uZ
        vICp0ju5d/eTy5arRflYHL8mfityD19iAuyOk/Mx8g==
X-Google-Smtp-Source: AMsMyM6eqXlNc1atZOkkKgiG1yV3Y78Coz+AbzCXphLyt0GPdUFcokJxxEDnXeFGnrVe0bHv3fHf9rWqZFSPgK8TTJI=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr4350723pjb.164.1664963290949; Wed, 05
 Oct 2022 02:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221005032257.80681-1-kch@nvidia.com> <20221005032257.80681-2-kch@nvidia.com>
 <6fee2d7a-7fd1-73ee-2911-87a4ed3e8769@opensource.wdc.com>
In-Reply-To: <6fee2d7a-7fd1-73ee-2911-87a4ed3e8769@opensource.wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Oct 2022 11:47:34 +0200
Message-ID: <CAPDyKFpBpiydQn+=24CqtaH_qa3tQfN2gQSiUrHCjnLSuy4=Kg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/21] block: add and use init tagset helper
To:     Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
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
        bvanassche@acm.org, ming.lei@redhat.com,
        shinichiro.kawasaki@wdc.com, vincent.fu@samsung.com,
        christoph.boehmwalder@linbit.com, joel@jms.id.au,
        vincent.whitchurch@axis.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2022 at 07:11, Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 10/5/22 12:22, Chaitanya Kulkarni wrote:
> > Add and use the helper to initialize the common fields of the tag_set
> > such as blk_mq_ops, number of h/w queues, queue depth, command size,
> > numa_node, timeout, BLK_MQ_F_XXX flags, driver data. This initialization
> > is spread all over the block drivers. This avoids the code repetation of
> > the inialization code of the tag set in current block drivers and any
>
> s/inialization/initialization
> s/repetation/repetition
>
> > future ones.
> >
> > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> > ---
> >  block/blk-mq.c                | 20 ++++++++++++++++++++
> >  drivers/block/null_blk/main.c | 10 +++-------
> >  include/linux/blk-mq.h        |  5 +++++
> >  3 files changed, 28 insertions(+), 7 deletions(-)
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 8070b6c10e8d..e3a8dd81bbe2 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -4341,6 +4341,26 @@ static int blk_mq_alloc_tag_set_tags(struct blk_mq_tag_set *set,
> >       return blk_mq_realloc_tag_set_tags(set, 0, new_nr_hw_queues);
> >  }
> >
> > +void blk_mq_init_tag_set(struct blk_mq_tag_set *set,
> > +             const struct blk_mq_ops *ops, unsigned int nr_hw_queues,
> > +             unsigned int queue_depth, unsigned int cmd_size, int numa_node,
> > +             unsigned int timeout, unsigned int flags, void *driver_data)
>
> That is an awful lot of arguments... I would be tempted to say pack all
> these into a struct but then that would kind of negate this patchset goal.
> Using a function with that many arguments will be error prone, and hard to
> review... Not a fan.

I completely agree.

But there is also another problem going down this route. If/when we
realize that there is another parameter needed in the blk_mq_tag_set.
Today that's quite easy to add (assuming the parameter can be
optional), without changing the blk_mq_init_tag_set() interface.

>
> > +{
> > +     if (!set)
> > +             return;
> > +
> > +     set->ops = ops;
> > +     set->nr_hw_queues = nr_hw_queues;
> > +     set->queue_depth = queue_depth;
> > +     set->cmd_size = cmd_size;
> > +     set->numa_node = numa_node;
> > +     set->timeout = timeout;
> > +     set->flags = flags;
> > +     set->driver_data = driver_data;
> > +}
> > +
>

[...]

Kind regards
Uffe
