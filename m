Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3CE73CF3B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjFYINc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 04:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjFYIN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:13:28 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF799BB;
        Sun, 25 Jun 2023 01:13:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QpkHz3Kgpz4f3rr5;
        Sun, 25 Jun 2023 16:13:19 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgCH77Ic95dk7kn3MQ--.7333S3;
        Sun, 25 Jun 2023 16:13:18 +0800 (CST)
Message-ID: <b2004583-6e9c-9282-b59c-95cae9187378@huaweicloud.com>
Date:   Sun, 25 Jun 2023 16:13:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/4] block/badblocks: fix badblocks setting error
To:     Ashok Raj <ashok_raj@linux.intel.com>, linan666@huaweicloud.com
Cc:     axboe@kernel.dk, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        Ashok Raj <ashok.raj@intel.com>
References: <20230621172052.1499919-1-linan666@huaweicloud.com>
 <ZJL73Zhyq4d/oaXd@araj-dh-work>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <ZJL73Zhyq4d/oaXd@araj-dh-work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77Ic95dk7kn3MQ--.7333S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw48AF4DKw1UJrW8ZryDtrb_yoWxKrg_Ca
        yvk3s8CryrJFnxJ3W3trWUXrsYyF1DGFWrG3y5GrykW3s8tay8GFs5Gr98Z3W3J3W8Ja98
        Gwn3XrWYvw4jqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbSxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
        xwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
        w20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/21 21:32, Ashok Raj 写道:
> On Thu, Jun 22, 2023 at 01:20:48AM +0800, linan666@huaweicloud.com wrote:
>> From: Li Nan <linan122@huawei.com>
>>
>> This patch series fixes some simple bugs of setting badblocks and
>> optimizing struct badblocks. Coly Li has been trying to refactor badblocks
>> in patch series "badblocks improvement for multiple bad block ranges", but
>> the workload is significant. Before that, I will fix some easily triggered
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> You mean the refactor is going to take longer to complete?

Yes, refer to the link:
https://lore.kernel.org/all/20220721121152.4180-1-colyli@suse.de

> If so, maybe state it that way...
> 
> .

-- 
Thanks,
Nan

