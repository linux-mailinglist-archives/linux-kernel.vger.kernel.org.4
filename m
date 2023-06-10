Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F4F72AA39
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjFJIMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 04:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFJIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 04:12:11 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593B313E;
        Sat, 10 Jun 2023 01:12:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VkkjLK1_1686384721;
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VkkjLK1_1686384721)
          by smtp.aliyun-inc.com;
          Sat, 10 Jun 2023 16:12:02 +0800
Message-ID: <319aa379-2694-5bb7-b79e-5401e894f390@linux.alibaba.com>
Date:   Sat, 10 Jun 2023 16:12:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC] block: relax permission for Persistent Reservations ioctl
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com,
        xiang@kernel.org, casey@schaufler-ca.com
References: <20230609102122.118800-1-jefflexu@linux.alibaba.com>
 <20230610060626.GA1595@lst.de>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230610060626.GA1595@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/23 2:06 PM, Christoph Hellwig wrote:
> On Fri, Jun 09, 2023 at 06:21:22PM +0800, Jingbo Xu wrote:
>> When the shared storage is accessed from containers [1], it's not
>> recommended to grant CAP_SYS_ADMIN to containers for access to
>> Persistent Reservations in risk of container escape.
>>
>> Remove the extra CAP_SYS_ADMIN permission constraint for Persistent
>> Reservations ioctl which shall do no harm [2].
> 
> I think we still to check that if CAP_SYS_ADMIN is not present,
> the file descriptors needs to be open for write, and we're not called
> on a partition (the latter should probbaly be always checked,
> as a reservation for a partitions doesn't make sense).
> 
> But in general I think relaxing this is a good idea, we just need to
> be very careful.  Looking at the discussion of unprivileged nvme
> command passthrough might be a good start.

Hi,

Thanks for the reply.

It seems I need to dive deeper into details of Persistent Reservations
protocol and the permission control you mentioned in nvme command
passthrough.

Thanks for your suggestions.  I will send a new version later.

-- 
Thanks,
Jingbo
