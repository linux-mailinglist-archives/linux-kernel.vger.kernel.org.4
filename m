Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F946CF103
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjC2RZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjC2RZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:25:31 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA304C18;
        Wed, 29 Mar 2023 10:25:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 94C82604EF;
        Wed, 29 Mar 2023 19:25:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680110720; bh=/58dhmX/l79hsed1d7Ni9oy4h5hfwoMRQ+RxaBNrXrw=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=iTNQpKQigHvrzd7xxiB+ZeXAyg1AHc0pSQVjO3k+TTvp8xv9R2x9rX47dppL9jB0Q
         rTYI+tiche4GyvBubohTDn+OX2EqR8o4W2rmZ8zVbOCsOJA9mgWp03alK3uo3Hjyrb
         tg15n7llIG6yIi6bmIqEYK00kKAAMNaMnwQKmXxozesa/2OPtCLiAGGU05D4n8LE8J
         IJn7BDrpiq7CMbdxDaokORd7UMz8Ssxq9vCgPB+Qt2iny7b6nC0DkBi3TMflgdbFmI
         NWSTwpH7zJPttHBELxlnVkyjdkCvWGf7vl+YXQmIJJ7Q8JBU6bxN8ipZQfF3blRFLk
         EeXGBGKupAgxA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k_RRq5yqKvqS; Wed, 29 Mar 2023 19:25:17 +0200 (CEST)
Received: from [10.0.1.78] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id E4BD6604EA;
        Wed, 29 Mar 2023 19:25:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680110717; bh=/58dhmX/l79hsed1d7Ni9oy4h5hfwoMRQ+RxaBNrXrw=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=FHJFlcWGv50yOpGDyH65l73HOOeXGgr+g+qBjmf3fPaQHmjaKgaEyZO9O+9LCos0Q
         3tMz8ed0KwlYyA+N8fyn/eHigkcCXKX9ItjhbtGlnBJciqUUoYs667wkJoTe7kmHsw
         Z4hSQhFTbG1cPLOfwNnw9yrjhZBx2AAZ32gUpGkAp7Q/4NLn0ZbuNFeBNPypN2LgGx
         BHGZViCm6szMRanNQiLc36fYDFwNikvxQjFT9i0ZlX4qukswFlDMB0wwfXLiK+LMap
         hhS8LBThgrUGUIhfp7DrYehnML00cnfeYjbgkfmbScgMKoIAn8dWlR8SZOqdDbK4r3
         T9fCdthcPb0cw==
Message-ID: <f74219a7-1607-deb4-a6ae-7b73e2467ac7@alu.unizg.hr>
Date:   Wed, 29 Mar 2023 19:25:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: BUG FIX: [PATCH v1] memstick_check() memleak in kernel 6.1.0+
 introduced pre 4.17
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hannes Reinecke <hare@suse.de>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        ye xingchen <ye.xingchen@zte.com.cn>, linux-mmc@vger.kernel.org
References: <7d873dd3-9bab-175b-8158-c458b61a7122@alu.unizg.hr>
In-Reply-To: <7d873dd3-9bab-175b-8158-c458b61a7122@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.12.2022. 14:20, Mirsad Goran Todorovac wrote:
> Hi all,
> 
> When building a RPM 6.1.0-rc3 for AlmaLinux 8.6, I have enabled CONFIG_DEBUG_KMEMLEAK=y
> and the result showed an unreferenced object in kworker process:
> 
> cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff888105028d80 (size 16):
>    comm "kworker/u12:5", pid 359, jiffies 4294902898 (age 1620.144s)
>    hex dump (first 16 bytes):
>      6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00  memstick0.......
>    backtrace:
>      [<ffffffffb6bb5542>] slab_post_alloc_hook+0xb2/0x340
>      [<ffffffffb6bbbf5f>] __kmem_cache_alloc_node+0x1bf/0x2c0
>      [<ffffffffb6af8175>] __kmalloc_node_track_caller+0x55/0x160
>      [<ffffffffb6ae34a6>] kstrdup+0x36/0x60
>      [<ffffffffb6ae3508>] kstrdup_const+0x28/0x30
>      [<ffffffffb70d0757>] kvasprintf_const+0x97/0xd0
>      [<ffffffffb7c9cdf4>] kobject_set_name_vargs+0x34/0xc0
>      [<ffffffffb750289b>] dev_set_name+0x9b/0xd0
>      [<ffffffffc12d9201>] memstick_check+0x181/0x639 [memstick]
>      [<ffffffffb676e1d6>] process_one_work+0x4e6/0x7e0
>      [<ffffffffb676e556>] worker_thread+0x76/0x770
>      [<ffffffffb677b468>] kthread+0x168/0x1a0
>      [<ffffffffb6604c99>] ret_from_fork+0x29/0x50
> 
> mtodorov@domac:~/linux/kernel/linux_stable$ git bisect log
> git bisect start
> # bad: [f0c4d9fc9cc9462659728d168387191387e903cc] Linux 6.1-rc4
> git bisect bad f0c4d9fc9cc9462659728d168387191387e903cc
> # bad: [fbd56ddcecab5a3623a89c8e941fdbcc55b41045] Linux 6.0.1
> git bisect bad fbd56ddcecab5a3623a89c8e941fdbcc55b41045
> # bad: [7e18e42e4b280c85b76967a9106a13ca61c16179] Linux 6.0-rc4
> git bisect bad 7e18e42e4b280c85b76967a9106a13ca61c16179
> # bad: [568035b01cfb107af8d2e4bd2fb9aea22cf5b868] Linux 6.0-rc1
> git bisect bad 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> # bad: [84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d] Linux 4.19
> git bisect bad 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d
> # bad: [94710cac0ef4ee177a63b5227664b38c95bbf703] Linux 4.18
> git bisect bad 94710cac0ef4ee177a63b5227664b38c95bbf703
> # bad: [29dcea88779c856c7dc92040a0c01233263101d4] Linux 4.17
> git bisect bad 29dcea88779c856c7dc92040a0c01233263101d4
> 
> Greg asked me if I would help bisect the bug, since I failed to reproduce it on pre 4.17 kernels, because they wouldn't boot (black 
> screen) on the Lenovo ALmaLinux 8.7 (CentOS fork) desktop box that only reproduced that bug:
> 
>      product: 10TX000VCR (LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB)
>      vendor: LENOVO
>      version: V530S-07ICB
> 
> I would welcome any advice.
> 
> Please find attached the lshw output and the build config from the last kernel version that also exhibits this bug, so the 
> conclusion is that it is not fixed since the report on November 29th 2022:
> 
> https://lore.kernel.org/regressions/0d9c3f6c-3948-d5d1-bcc1-baf31141beaa@alu.unizg.hr/T/#t
> 
> With the hint of Tvrtko, I was able to extract the correct list of maintainers this time.
> 
> The bug occurs in one kernel memory leak, and it is unobvious whether a skilled attacker could use an abusive program to trigger the 
> leak of enough 16 byte slabs (and overhead) to exhaust kernel memory and cause denial-of-service (crash of the system).
> 
> I apologise for the first unsuccessful attempt.

static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)

calls dev_set_name(&card->dev, "%s", dev_name(&host->dev)); that
calls err = kobject_set_name_vargs(&dev->kobj, fmt, vargs); that
executes:

	if (strchr(s, '/')) {
		char *t;

		t = kstrdup(s, GFP_KERNEL);
		kfree_const(s);
		if (!t)
			return -ENOMEM;
		strreplace(t, '/', '!');
		s = t;
	}
	kfree_const(kobj->name);
	kobj->name = s;

so, this kobj->name was never freed in the "goto err_out" case in line 404.

380 static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
381 {
382         struct memstick_dev *card = kzalloc(sizeof(struct memstick_dev),
383                                             GFP_KERNEL);
384         struct memstick_dev *old_card = host->card;
385         struct ms_id_register id_reg;
386
387         if (card) {
388                 card->host = host;
389                 dev_set_name(&card->dev, "%s", dev_name(&host->dev));
390                 card->dev.parent = &host->dev;
391                 card->dev.bus = &memstick_bus_type;
392                 card->dev.release = memstick_free_card;
393                 card->check = memstick_dummy_check;
394
395                 card->reg_addr.r_offset = offsetof(struct ms_register, id);
396                 card->reg_addr.r_length = sizeof(id_reg);
397                 card->reg_addr.w_offset = offsetof(struct ms_register, id);
398                 card->reg_addr.w_length = sizeof(id_reg);
399
400                 init_completion(&card->mrq_complete);
401
402                 host->card = card;
403                 if (memstick_set_rw_addr(card))
404                         goto err_out;
405
406                 card->next_request = h_memstick_read_dev_id;
407                 memstick_new_req(host);
408                 wait_for_completion(&card->mrq_complete);
409
410                 if (card->current_mrq.error)
411                         goto err_out;
412         }
413         host->card = old_card;
414         return card;
415 err_out:
416         host->card = old_card;
421         kfree(card);
422         return NULL;
423 }

This little patch fixes it, also at the release() method.

However, release() had not yet been tested, and I am not certain that in that case
kobj->name would not be kfree_const()-ed automatically.

Maybe it ought to be separated in two independent patches?

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index bf7667845459..403ab06e3ffa 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -191,6 +191,10 @@ static void memstick_free_card(struct device *dev)
  {
         struct memstick_dev *card = container_of(dev, struct memstick_dev,
                                                  dev);
+       if ((card->dev).kobj.name) {
+               kfree_const((card->dev).kobj.name);
+               (card->dev).kobj.name = NULL;
+       }
         kfree(card);
  }

@@ -410,6 +414,10 @@ static struct memstick_dev *memstick_alloc_card(struct memstick_host *host)
         return card;
  err_out:
         host->card = old_card;
+       if ((card->dev).kobj.name) {
+               kfree_const((card->dev).kobj.name);
+               (card->dev).kobj.name = NULL;
+       }
         kfree(card);
         return NULL;
  }

This morning I did not feel like we'd fix two memory leaks today.

This one was a nag for three months :-)

Of course, this requires peer review. The fact that it fixed the /sys/kernel/debug/kmemleak
output doesn't mean that it wouldn't break something, does it?

It is clearly the good wind of the Providence.

Best regards,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

