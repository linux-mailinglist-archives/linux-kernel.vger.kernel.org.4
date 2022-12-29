Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A39A658EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiL2P5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiL2P4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:56:36 -0500
Received: from mail.holmansrus.com (unknown [143.59.183.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FDF2BF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:54:43 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.holmansrus.com (Postfix) with ESMTP id 9831EE1D8B;
        Thu, 29 Dec 2022 09:54:42 -0600 (CST)
Received: from mail.holmansrus.com ([127.0.0.1])
        by localhost (mail.holmansrus.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SFOQwsu4wpPp; Thu, 29 Dec 2022 09:54:41 -0600 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.holmansrus.com (Postfix) with ESMTP id BBC9FE1D81;
        Thu, 29 Dec 2022 09:54:41 -0600 (CST)
X-Virus-Scanned: amavisd-new at holmansrus.com
Received: from mail.holmansrus.com ([127.0.0.1])
        by localhost (mail.holmansrus.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qCojwFhzkrdt; Thu, 29 Dec 2022 09:54:41 -0600 (CST)
Received: from mail.holmansrus.com (mail.holmansrus.com [10.90.0.246])
        by mail.holmansrus.com (Postfix) with ESMTP id 8E3BBE1D82;
        Thu, 29 Dec 2022 09:54:41 -0600 (CST)
Date:   Thu, 29 Dec 2022 09:54:41 -0600 (CST)
From:   Walt Holman <walt@holmansrus.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <308147064.5.1672329281388.JavaMail.zimbra@holmansrus.com>
In-Reply-To: <Y60+ClXkkBAfKhUf@kroah.com>
References: <933489772.83.1672266579857.JavaMail.zimbra@holmansrus.com> <Y60+ClXkkBAfKhUf@kroah.com>
Subject: Re: [PATCH 6.1 0000/1146] 6.1.2-rc1 review
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.90.0.246]
X-Mailer: Zimbra 8.8.15_GA_4484 (ZimbraWebClient - GC108 (Linux)/8.8.15_GA_4481)
Thread-Topic: 6.1.2-rc1 review
Thread-Index: FQOn6q/XNZPwbOB/ytDSaiKZEiPvAQ==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Dec 29, 2022, at 1:13 AM, Greg KH gregkh@linuxfoundation.org wrote:

> On Wed, Dec 28, 2022 at 04:29:39PM -0600, Walt Holman wrote:
>> > This is the start of the stable review cycle for the 6.1.2 release.
>> > There are 1146 patches in this series, all will be posted as a response
>> > to this one.  If anyone has any issues with these being applied, please
>> > let me know.
>> > 
>> > Responses should be made by Fri, 30 Dec 2022 14:41:29 +0000.
>> > Anything received after that time might be too late.
>> > 
>> > The whole patch series can be found in one patch at:
>> > [ https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.2-rc1.gz
>> > | https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.2-rc1.gz
>> > ] > or in the git tree and branch at:
>> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>> > 	linux-6.1.y
>> > and the diffstat can be found below.
>> > 
>> > thanks,
>> > 
>> > greg k-h
>> > 
>> > -------------
>> 
>> Hello,
>> 
>> I'm getting a NULL Pointer Dereference when shutting down or rebooting. It
>> happens just as it tries to shut down the swap device ( /dev/dm-3 ). This
>> happens late in the shutdown process and nothing gets saved in the logs.
>> However, I've attached a photo of my screen showing the Oops and stack trace.
>> Let me know if there's anything you'd like me to try.
> 
> Does this happen with 6.1.1 also?
> 
> Can you use 'git bisect' to track down the offending change?
> 
> thanks,
> 
> greg k-h

Bisecting the kernel results in the following:

273d29fa4beb3954c970b6377a2aa6ee442b1430 is the first bad commit
commit 273d29fa4beb3954c970b6377a2aa6ee442b1430
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Nov 1 16:00:47 2022 +0100

    blk-mq: move the srcu_struct used for quiescing to the tagset
    
    [ Upstream commit 80bd4a7aab4c9ce59bf5e35fdf52aa23d8a3c9f5 ]
    
    All I/O submissions have fairly similar latencies, and a tagset-wide
    quiesce is a fairly common operation.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Keith Busch <kbusch@kernel.org>
    Reviewed-by: Ming Lei <ming.lei@redhat.com>
    Reviewed-by: Chao Leng <lengchao@huawei.com>
    Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
    Reviewed-by: Hannes Reinecke <hare@suse.de>
    Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
    Link: https://lore.kernel.org/r/20221101150050.3510-12-hch@lst.de
    [axboe: fix whitespace]
    Signed-off-by: Jens Axboe <axboe@kernel.dk>
    Stable-dep-of: d36a9ea5e776 ("block: fix use-after-free of q->q_usage_counter")
    Signed-off-by: Sasha Levin <sashal@kernel.org>

 block/blk-core.c       | 27 +++++----------------------
 block/blk-mq.c         | 33 +++++++++++++++++++++++++--------
 block/blk-mq.h         | 14 +++++++-------
 block/blk-sysfs.c      |  9 ++-------
 block/blk.h            |  9 +--------
 block/genhd.c          |  2 +-
 include/linux/blk-mq.h |  4 ++++
 include/linux/blkdev.h |  9 ---------
 8 files changed, 45 insertions(+), 62 deletions(-)

-Walt
