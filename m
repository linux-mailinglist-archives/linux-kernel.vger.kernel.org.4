Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F66A63776A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiKXLSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiKXLRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:17:44 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BA26F834;
        Thu, 24 Nov 2022 03:17:10 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NHwSJ1RQmz4f3jqc;
        Thu, 24 Nov 2022 19:17:04 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgDH69ixUn9jsjZLBA--.43973S3;
        Thu, 24 Nov 2022 19:17:07 +0800 (CST)
Subject: Re: nbd: please don't spawn 16 threads when nbd is not even in use
To:     Pavel Machek <pavel@ucw.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Eric Blake <eblake@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, "yukuai (C)" <yukuai3@huawei.com>
References: <Y3y4+QqOlF00X9ET@duo.ucw.cz>
 <20221123200845.cuct5euvikqksojm@redhat.com> <Y36YHNVmbozzSdxH@duo.ucw.cz>
 <ccee0ff5-309c-b430-09c7-8d2081c9981d@huaweicloud.com>
 <Y39CFnRwNGBGIsCH@duo.ucw.cz>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f07f496d-3bf7-eb84-eb90-df2d43c5c01b@huaweicloud.com>
Date:   Thu, 24 Nov 2022 19:17:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y39CFnRwNGBGIsCH@duo.ucw.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDH69ixUn9jsjZLBA--.43973S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYF7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
        kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
        cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2js
        IEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
        5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
        CFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2
        V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/11/24 18:06, Pavel Machek 写道:
> 
> Can we get that reverted?
> 
> That is rather obscure bug (how many GFP_KERNEL failures do you
> normally see?) and it costs, dunno, 100KB? of unswappable memory.
> 

No, I don't think that can be reverted. Introduce a BUG just to save
some memory sounds insane.

If you really want to do this. I think the right thing to do is to move
the allocation of recv_workq back to start device, and also fix the
problem properly.

Thanks,
Kuai
> Best regards,
> 								Pavel
> 

