Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AB6636FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKXBSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 20:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiKXBR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:17:59 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8368A27B07;
        Wed, 23 Nov 2022 17:17:56 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NHg8v0M6Rz4f3v6w;
        Thu, 24 Nov 2022 09:17:51 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3GthAxn5jsBE0BA--.21372S3;
        Thu, 24 Nov 2022 09:17:53 +0800 (CST)
Subject: Re: nbd: please don't spawn 16 threads when nbd is not even in use
To:     Pavel Machek <pavel@ucw.cz>, Eric Blake <eblake@redhat.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>, josef@toxicpanda.com,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <Y3y4+QqOlF00X9ET@duo.ucw.cz>
 <20221123200845.cuct5euvikqksojm@redhat.com> <Y36YHNVmbozzSdxH@duo.ucw.cz>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ccee0ff5-309c-b430-09c7-8d2081c9981d@huaweicloud.com>
Date:   Thu, 24 Nov 2022 09:17:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y36YHNVmbozzSdxH@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3GthAxn5jsBE0BA--.21372S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy8WrWfWFyftrWfZFyxXwb_yoW3AFX_WF
        W7ZFyDGw4UXF18Ja1qkF1rWFW8Xrs7XF4jqasxtwsrJw43W3s3uF4DWry3Zw4UGw4YyFnx
        ur1UZay7Ar47ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/11/24 6:01, Pavel Machek 写道:
> Hi!
> 
>>> I see this... and it looks like there are 16 workqueues before nbd is
>>> even used. Surely there are better ways to do that?
>>
>> Yes, it would be nice to create a pool of workers that only spawns up
>> threads when actual parallel requests are made.  Are you willing to
>> help write the patch?
> 
> I was thinking more "only spawn a workqueue when nbd is opened" or so.
> 
> I have 16 of them, and I'm not using nbd. Workqueue per open device is
> okay, current situation... not so much.

You can take a look at this commit:

e2daec488c57 ("nbd: Fix hungtask when nbd_config_put")

Allocation of recv_workq is moved from start device to alloc device to
fix hungtask. You might need to be careful if you want to move this.

Thanks,
Kuai
> 
>        	       	    	  	  	    	     		Pavel
> 

