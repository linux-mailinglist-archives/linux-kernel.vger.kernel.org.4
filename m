Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1942B6AFD1A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 03:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCHC4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 21:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCHC4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 21:56:20 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C049BA57
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 18:56:18 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PWcQP106Fz4f3kpF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:56:13 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgAn16pI+Qdk9qjPEw--.56532S2;
        Wed, 08 Mar 2023 10:56:12 +0800 (CST)
Subject: Re: dm crypt: initialize tasklet in crypt_io_init()
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, houtao1@huawei.com,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Ignat Korchagin <ignat@cloudflare.com>, mpatocka@redhat.com
References: <20230306134930.2878660-1-houtao@huaweicloud.com>
 <ZAY/o9ew9AtrCLE5@redhat.com>
 <e9b61952-98a8-6e3b-2d85-6aaf07208a7b@huaweicloud.com>
 <ZAdOgUdqwLpUyPlc@redhat.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <6c2d07bf-828e-3aeb-3c02-6cdfd6e36ff3@huaweicloud.com>
Date:   Wed, 8 Mar 2023 10:56:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ZAdOgUdqwLpUyPlc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgAn16pI+Qdk9qjPEw--.56532S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw4kXrW8GF1UtF18ArWrZrb_yoWxZF4rpa
        93KayFkrZ5JFW7KwnFyr18ZFyY9rn7Gr9xCwsxGw1UZw1Y9ryvgr1I9rWFvF4qyFZ8uF13
        XFWIyFy5Cws8ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/7/2023 10:47 PM, Mike Snitzer wrote:
> On Mon, Mar 06 2023 at  9:12P -0500,
> Hou Tao <houtao@huaweicloud.com> wrote:
>
>> Hi,
>>
>> On 3/7/2023 3:31 AM, Mike Snitzer wrote:
>>> On Mon, Mar 06 2023 at  8:49P -0500,
>>> Hou Tao <houtao@huaweicloud.com> wrote:
>>>
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> When neither no_read_workqueue nor no_write_workqueue are enabled,
>>>> tasklet_trylock() in crypt_dec_pending() may still return false due to
>>>> an uninitialized state, and dm-crypt will do io completion in io_queue
>>>> instead of current context unnecessarily.
>>> Have you actually experienced this?
>> Yes. I had written a bpftrace script to check the completion context of
>> blkdev_bio_end_io_simple() when doing direct io read on dm-crypt device. The
>> expected context should be unbound workers of crypt_queue, but sometimes the
>> context is the bound worker of io_queue.
> OK, thanks for clarifying.  Curious to know the circumstance (I
> thought per-bio-data is zero'd -- but it may be I'm mistaken).
The circumstance is just a normal qemu VM running the vanilla kernel for test
purpose. According to the implementation of bio_alloc_bioset(), the front pad of
bio is not initialized and only bio itself is initialized. AFAIK if
CONFIG_INIT_ON_ALLOC_DEFAULT_ON is enabled, per-bio-data may be zeroed.
>
> I won't be marking this commit for stable@ but if others feel
> differently please let me know and I'll do so. (We can always propose
> it to stable@, after the fact, even if the commit header doesn't Cc
> stable@)
>
>>>> Fix it by initializing io->tasklet in crypt_io_init().
>>> Really would rather avoid always calling tasklet_init(). But I can
>>> optimize it away with a later patch.
>> My first though was "io->tasklet.state = 0", but it may be fragile because it
>> operated on the internal status of tasklet, so I switch to tasklet_init().
> Yes, I looked into it and came up with the same hack.. and I too felt
> it was too fragile due to open-coding direct access to the tasklet's
> members.
>
> I have a patch I just staged that staged that uses jump_labels to
> optimize this code.  If you might review/test/verify it works well for
> you that'd be appreciated:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.3&id=ae75a25bd83f7c541240449d2fff3a44433e506b
>
> It builds on your patch, which I added a comment to:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.3&id=d9fe0a98a2e0a1cf585e8a6555afb33be968bd13
Thanks for the comments. It is fine to me.
>
> From: Mike Snitzer <snitzer@kernel.org>
> Date: Mon, 6 Mar 2023 15:58:33 -0500
> Subject: [PATCH] dm crypt: conditionally enable code needed for tasklet usecases
>
> Use jump_label to limit the need for branching, and tasklet_init(),
> unless either of the optional "no_read_workqueue" and/or
> "no_write_workqueue" features are used.
>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  drivers/md/dm-crypt.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 641457e72603..2d0309ca07f5 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -40,6 +40,7 @@
>  #include <keys/user-type.h>
>  #include <keys/encrypted-type.h>
>  #include <keys/trusted-type.h>
> +#include <linux/jump_label.h>
>  
>  #include <linux/device-mapper.h>
>  
> @@ -85,6 +86,8 @@ struct dm_crypt_io {
>  	struct rb_node rb_node;
>  } CRYPTO_MINALIGN_ATTR;
>  
> +static DEFINE_STATIC_KEY_FALSE(use_tasklet_enabled);
> +
>  struct dm_crypt_request {
>  	struct convert_context *ctx;
>  	struct scatterlist sg_in[4];
> @@ -1730,12 +1733,15 @@ static void crypt_io_init(struct dm_crypt_io *io, struct crypt_config *cc,
>  	io->sector = sector;
>  	io->error = 0;
>  	io->ctx.r.req = NULL;
> -	/*
> -	 * tasklet_init() here to ensure crypt_dec_pending()'s
> -	 * tasklet_trylock() doesn't incorrectly return false
> -	 * even when tasklet isn't in use.
> -	 */
> -	tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
> +	if (static_branch_unlikely(&use_tasklet_enabled)) {
> +		/*
> +		 * tasklet_init() here to ensure crypt_dec_pending()'s
> +		 * tasklet_trylock() doesn't incorrectly return false
> +		 * even when tasklet isn't in use.
> +		 */
> +		tasklet_init(&io->tasklet, kcryptd_crypt_tasklet,
> +			     (unsigned long)&io->work);
> +	}
>  	io->integrity_metadata = NULL;
>  	io->integrity_metadata_from_pool = false;
>  	atomic_set(&io->io_pending, 0);
> @@ -1775,6 +1781,10 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
>  		kfree(io->integrity_metadata);
>  
>  	base_bio->bi_status = error;
> +	if (!static_branch_unlikely(&use_tasklet_enabled)) {
> +		bio_endio(base_bio);
> +		return;
> +	}
Because use_tasklet_enabled can be enabled concurrently, so I think it is still
possible that crypt_dec_pending will try-lock an unitialized tasklet if
use_tasklet_enabled is enabled when invoking crypt_dec_pending().
>  
>  	/*
>  	 * If we are running this function from our tasklet,
> @@ -2232,8 +2242,9 @@ static void kcryptd_queue_crypt(struct dm_crypt_io *io)
>  {
>  	struct crypt_config *cc = io->cc;
>  
> -	if ((bio_data_dir(io->base_bio) == READ && test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags)) ||
> -	    (bio_data_dir(io->base_bio) == WRITE && test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))) {
> +	if (static_branch_unlikely(&use_tasklet_enabled) &&
> +	    ((bio_data_dir(io->base_bio) == READ && test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags)) ||
> +	     (bio_data_dir(io->base_bio) == WRITE && test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags)))) {
>  		/*
>  		 * in_hardirq(): Crypto API's skcipher_walk_first() refuses to work in hard IRQ context.
>  		 * irqs_disabled(): the kernel may run some IO completion from the idle thread, but
> @@ -2746,6 +2757,10 @@ static void crypt_dtr(struct dm_target *ti)
>  	crypt_calculate_pages_per_client();
>  	spin_unlock(&dm_crypt_clients_lock);
>  
> +	if (test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags) ||
> +	    test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))
> +		static_branch_dec(&use_tasklet_enabled);
> +
>  	dm_audit_log_dtr(DM_MSG_PREFIX, ti, 1);
>  }
>  
> @@ -3375,6 +3390,10 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  	ti->limit_swap_bios = true;
>  	ti->accounts_remapped_io = true;
>  
> +	if (test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags) ||
> +	    test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))
> +		static_branch_inc(&use_tasklet_enabled);
> +
>  	dm_audit_log_ctr(DM_MSG_PREFIX, ti, 1);
>  	return 0;
>  

