Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B005D5F9A84
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiJJHzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJJHzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:55:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4031DA70;
        Mon, 10 Oct 2022 00:55:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 21BA768AA6; Mon, 10 Oct 2022 09:55:05 +0200 (CEST)
Date:   Mon, 10 Oct 2022 09:55:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, axboe@kernel.dk, efremov@linux.com,
        josef@toxicpanda.com, idryomov@gmail.com,
        dongsheng.yang@easystack.cn, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, mst@redhat.com, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com, ohad@wizery.com,
        andersson@kernel.org, baolin.wang@linux.alibaba.com,
        ulf.hansson@linaro.org, richard@nod.at, miquel.raynal@bootlin.com,
        vigneshr@ti.com, marcan@marcan.st, sven@svenpeter.dev,
        alyssa@rosenzweig.io, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, sth@linux.ibm.com, hoeppner@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, bhelgaas@google.com,
        john.garry@huawei.com, christophe.jaillet@wanadoo.fr,
        vaibhavgupta40@gmail.com, wsa+renesas@sang-engineering.com,
        damien.lemoal@opensource.wdc.com, johannes.thumshirn@wdc.com,
        bvanassche@acm.org, ming.lei@redhat.com,
        shinichiro.kawasaki@wdc.com, vincent.fu@samsung.com,
        christoph.boehmwalder@linbit.com, joel@jms.id.au,
        vincent.whitchurch@axis.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, asahi@lists.linux.dev
Subject: Re: [RFC PATCH 00/21] block: add and use init tagset helper
Message-ID: <20221010075504.GA21272@lst.de>
References: <20221005032257.80681-1-kch@nvidia.com> <Y0BvRaVO0iUVmHgB@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0BvRaVO0iUVmHgB@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 11:26:13AM -0700, Luis Chamberlain wrote:
> *If* there were commonalities at init and these could be broken up into
> common groups, each having their own set of calls, then we simplify and
> can abstract these. I say this without doing a complete review of the
> removals, but if there really isn't much of commonalities I tend to
> agree with Bart that open coding this is better.

The commonality is that there are various required or optional
fields to fill out.  I actually have a WIP series to make the tag_set
dynamically allocated and refcounted to fix some long standing life time
issues.  That creates a new alloc helper that will take a few mandatory
arguments and would heavily clash with this series.
