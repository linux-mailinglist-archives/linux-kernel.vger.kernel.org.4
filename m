Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE1D6AD474
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCGCMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCGCMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:12:14 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D063A846
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 18:12:12 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PVzTz68WSz4f3jYq
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:12:07 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgCHOa12nQZks2uNEw--.20984S2;
        Tue, 07 Mar 2023 10:12:09 +0800 (CST)
Subject: Re: dm crypt: initialize tasklet in crypt_io_init()
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
        linux-kernel@vger.kernel.org, houtao1@huawei.com
References: <20230306134930.2878660-1-houtao@huaweicloud.com>
 <ZAY/o9ew9AtrCLE5@redhat.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <e9b61952-98a8-6e3b-2d85-6aaf07208a7b@huaweicloud.com>
Date:   Tue, 7 Mar 2023 10:12:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ZAY/o9ew9AtrCLE5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgCHOa12nQZks2uNEw--.20984S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr13Gr4fGr4xAFWkKr45KFg_yoWDKFXE9a
        1FgFyxGw409Fn7tF1qyr43Jr93Xa1kJa1DKrWUX3y7Kr93Z39Yq3ZY9ryfC3W8Za4ayF9x
        ursIvasFvw1qgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
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
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/7/2023 3:31 AM, Mike Snitzer wrote:
> On Mon, Mar 06 2023 at  8:49P -0500,
> Hou Tao <houtao@huaweicloud.com> wrote:
>
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When neither no_read_workqueue nor no_write_workqueue are enabled,
>> tasklet_trylock() in crypt_dec_pending() may still return false due to
>> an uninitialized state, and dm-crypt will do io completion in io_queue
>> instead of current context unnecessarily.
> Have you actually experienced this?
Yes. I had written a bpftrace script to check the completion context of
blkdev_bio_end_io_simple() when doing direct io read on dm-crypt device. The
expected context should be unbound workers of crypt_queue, but sometimes the
context is the bound worker of io_queue.
>
>> Fix it by initializing io->tasklet in crypt_io_init().
> Really would rather avoid always calling tasklet_init(). But I can
> optimize it away with a later patch.
My first though was "io->tasklet.state = 0", but it may be fragile because it
operated on the internal status of tasklet, so I switch to tasklet_init().
>
> Mike

