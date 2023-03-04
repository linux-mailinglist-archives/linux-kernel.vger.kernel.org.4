Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826586AAB57
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 17:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjCDQ7y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 4 Mar 2023 11:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCDQ7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:59:52 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5464216306
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 08:59:44 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 12B716382EFB;
        Sat,  4 Mar 2023 17:59:42 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VJ8KBk6rlIxq; Sat,  4 Mar 2023 17:59:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8477A61418B6;
        Sat,  4 Mar 2023 17:59:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2ZH0VCMlkC3U; Sat,  4 Mar 2023 17:59:41 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6554A6382EFB;
        Sat,  4 Mar 2023 17:59:41 +0100 (CET)
Date:   Sat, 4 Mar 2023 17:59:41 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yi zhang <yi.zhang@huawei.com>
Message-ID: <1472678614.203878.1677949181290.JavaMail.zimbra@nod.at>
In-Reply-To: <2d3b033a-5329-be95-fe38-2cceb17b9014@huawei.com>
References: <20230304014141.2099204-1-wangzhaolong1@huawei.com> <2d3b033a-5329-be95-fe38-2cceb17b9014@huawei.com>
Subject: Re: [PATCH] ubi: Fix deadlock caused by recursively holding
 work_sem
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix deadlock caused by recursively holding work_sem
Thread-Index: QdXMMi4X/w+/jvDCBA4SuSPx9dKZyQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
>> During the processing of the bgt, if the sync_erase() return -EBUSY
>> or some other error code in __erase_worker(),schedule_erase() called
>> again lead to the down_read(ubi->work_sem) hold twice and may get
>> block by down_write(ubi->work_sem) in ubi_update_fastmap(),
>> which cause deadlock.
>> 
>>            ubi bgt                        other task
>>   do_work
>>    down_read(&ubi->work_sem)          ubi_update_fastmap
>>    erase_worker                         # Blocked by down_read
>>     __erase_worker                      down_write(&ubi->work_sem)
>>      schedule_erase
>>       schedule_ubi_work
>>        down_read(&ubi->work_sem)
>> 
>> Fix this by changing input parameter @nested of the schedule_erase() to
>> 'true' to avoid recursively acquiring the down_read(&ubi->work_sem).
>> 
>> Also, fix the incorrect comment about @nested parameter of the
>> schedule_erase() because when down_write(ubi->work_sem) is held, the
>> @nested is also need be true.
>> 
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217093
>> Fixes: 2e8f08deabbc ("ubi: Fix races around ubi_refill_pools()")
>> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
>> ---
>>   drivers/mtd/ubi/wl.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

Applied to -next. Thanks everyone!

Thanks,
//richard
