Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470AB737939
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjFUCgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFUCf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:35:58 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB1AB4;
        Tue, 20 Jun 2023 19:35:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qm70S63Xkz4f3jLf;
        Wed, 21 Jun 2023 10:35:52 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbAFYpJk9pSxMA--.19888S3;
        Wed, 21 Jun 2023 10:35:51 +0800 (CST)
Subject: Re: [PATCH -next 1/8] md: move initialization and destruction of
 'io_acct_set' to md.c
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230619204826.755559-1-yukuai1@huaweicloud.com>
 <20230619204826.755559-2-yukuai1@huaweicloud.com>
 <CALTww281XOxzFXFQmZ-HWcekMzC30bryJ3YtYGRoERTrk2SHCQ@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <849ddead-2a0c-38e8-b578-a85f843a6920@huaweicloud.com>
Date:   Wed, 21 Jun 2023 10:35:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww281XOxzFXFQmZ-HWcekMzC30bryJ3YtYGRoERTrk2SHCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbAFYpJk9pSxMA--.19888S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw18try5Gr1kWw1DGrW3KFg_yoWfKryDpa
        92qF1Ygr40qFWag34Ut3yv9a4Fvr1kKr97KrW3J348Aws2vr1DKFy5Wr4rur9rA34rCr1r
        Zw4rKFZrur1xKFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9
        -UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/06/20 16:35, Xiao Ni 写道:
> On Mon, Jun 19, 2023 at 8:50 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> 'io_acct_set' is only used for raid0 and raid456, prepare to use it for
>> raid1 and raid10, so that io accounting from different levels can be
>> consistent.
>>
>> By the way, follow up patches will also use this io clone mechanism to
>> make sure 'active_io' represents in flight io, not io that is dispatching,
>> so that mddev_suspend will wait for io to be done as desgined.
> 
> Hi Kuai
> 
> typo error: s/desgined/designed/g
> 
> Before this patch the personality uses ->quiesce method to wait until
> all inflight ios come back. But I like this solution. It makes the
> codes simpler. Not sure if it can cause problems because it changes
> the meaning of ->active_io. I'm doing regression tests to check.

Yes, actually this is the first step that I'm tring to synchronize io
and raid configuration, and I'm planing to use 'active_io' to check if
normal io exist, following are follow up plans:

1. add a new counter(perhaps we can reuse queue->q_usage_counter), and
grab it for sync io;
2. refactor and expand 'pers->quiesce', allow normal io and sync io
to be both quiesced;
3. call 'pers->quiesce' before raid configuration;
4. add a new helper to iterate rdev, grab the new counter first;
5. a lot of cleanups;

Thanks,
Kuai
> 
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c    | 27 ++++++++++-----------------
>>   drivers/md/md.h    |  2 --
>>   drivers/md/raid0.c | 16 ++--------------
>>   drivers/md/raid5.c | 41 +++++++++++------------------------------
>>   4 files changed, 23 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 8d62f85d2ab0..42347289195a 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -5886,6 +5886,13 @@ int md_run(struct mddev *mddev)
>>                          goto exit_bio_set;
>>          }
>>
>> +       if (!bioset_initialized(&mddev->io_acct_set)) {
>> +               err = bioset_init(&mddev->io_acct_set, BIO_POOL_SIZE,
>> +                                 offsetof(struct md_io_acct, bio_clone), 0);
>> +               if (err)
>> +                       goto exit_sync_set;
>> +       }
>> +
>>          spin_lock(&pers_lock);
>>          pers = find_pers(mddev->level, mddev->clevel);
>>          if (!pers || !try_module_get(pers->owner)) {
>> @@ -6063,6 +6070,8 @@ int md_run(struct mddev *mddev)
>>          module_put(pers->owner);
>>          md_bitmap_destroy(mddev);
>>   abort:
>> +       bioset_exit(&mddev->io_acct_set);
>> +exit_sync_set:
>>          bioset_exit(&mddev->sync_set);
>>   exit_bio_set:
>>          bioset_exit(&mddev->bio_set);
>> @@ -6286,6 +6295,7 @@ static void __md_stop(struct mddev *mddev)
>>          percpu_ref_exit(&mddev->active_io);
>>          bioset_exit(&mddev->bio_set);
>>          bioset_exit(&mddev->sync_set);
>> +       bioset_exit(&mddev->io_acct_set);
>>   }
>>
>>   void md_stop(struct mddev *mddev)
>> @@ -8651,23 +8661,6 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
>>   }
>>   EXPORT_SYMBOL_GPL(md_submit_discard_bio);
>>
>> -int acct_bioset_init(struct mddev *mddev)
>> -{
>> -       int err = 0;
>> -
>> -       if (!bioset_initialized(&mddev->io_acct_set))
>> -               err = bioset_init(&mddev->io_acct_set, BIO_POOL_SIZE,
>> -                       offsetof(struct md_io_acct, bio_clone), 0);
>> -       return err;
>> -}
>> -EXPORT_SYMBOL_GPL(acct_bioset_init);
>> -
>> -void acct_bioset_exit(struct mddev *mddev)
>> -{
>> -       bioset_exit(&mddev->io_acct_set);
>> -}
>> -EXPORT_SYMBOL_GPL(acct_bioset_exit);
>> -
>>   static void md_end_io_acct(struct bio *bio)
>>   {
>>          struct md_io_acct *md_io_acct = bio->bi_private;
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index 7cab9c7c45b8..11299d94b239 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -776,8 +776,6 @@ extern void md_error(struct mddev *mddev, struct md_rdev *rdev);
>>   extern void md_finish_reshape(struct mddev *mddev);
>>   void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
>>                          struct bio *bio, sector_t start, sector_t size);
>> -int acct_bioset_init(struct mddev *mddev);
>> -void acct_bioset_exit(struct mddev *mddev);
>>   void md_account_bio(struct mddev *mddev, struct bio **bio);
>>
>>   extern bool __must_check md_flush_request(struct mddev *mddev, struct bio *bio);
>> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
>> index f8ee9a95e25d..38d9209cada1 100644
>> --- a/drivers/md/raid0.c
>> +++ b/drivers/md/raid0.c
>> @@ -365,7 +365,6 @@ static void raid0_free(struct mddev *mddev, void *priv)
>>          struct r0conf *conf = priv;
>>
>>          free_conf(mddev, conf);
>> -       acct_bioset_exit(mddev);
>>   }
>>
>>   static int raid0_run(struct mddev *mddev)
>> @@ -380,16 +379,11 @@ static int raid0_run(struct mddev *mddev)
>>          if (md_check_no_bitmap(mddev))
>>                  return -EINVAL;
>>
>> -       if (acct_bioset_init(mddev)) {
>> -               pr_err("md/raid0:%s: alloc acct bioset failed.\n", mdname(mddev));
>> -               return -ENOMEM;
>> -       }
>> -
>>          /* if private is not null, we are here after takeover */
>>          if (mddev->private == NULL) {
>>                  ret = create_strip_zones(mddev, &conf);
>>                  if (ret < 0)
>> -                       goto exit_acct_set;
>> +                       return ret;
>>                  mddev->private = conf;
>>          }
>>          conf = mddev->private;
>> @@ -420,15 +414,9 @@ static int raid0_run(struct mddev *mddev)
>>
>>          ret = md_integrity_register(mddev);
>>          if (ret)
>> -               goto free;
>> +               free_conf(mddev, conf);
>>
>>          return ret;
>> -
>> -free:
>> -       free_conf(mddev, conf);
>> -exit_acct_set:
>> -       acct_bioset_exit(mddev);
>> -       return ret;
>>   }
>>
>>   static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index f8bc74e16811..29cf5455d7a5 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -7787,19 +7787,12 @@ static int raid5_run(struct mddev *mddev)
>>          struct md_rdev *rdev;
>>          struct md_rdev *journal_dev = NULL;
>>          sector_t reshape_offset = 0;
>> -       int i, ret = 0;
>> +       int i;
>>          long long min_offset_diff = 0;
>>          int first = 1;
>>
>> -       if (acct_bioset_init(mddev)) {
>> -               pr_err("md/raid456:%s: alloc acct bioset failed.\n", mdname(mddev));
>> +       if (mddev_init_writes_pending(mddev) < 0)
>>                  return -ENOMEM;
>> -       }
>> -
>> -       if (mddev_init_writes_pending(mddev) < 0) {
>> -               ret = -ENOMEM;
>> -               goto exit_acct_set;
>> -       }
>>
>>          if (mddev->recovery_cp != MaxSector)
>>                  pr_notice("md/raid:%s: not clean -- starting background reconstruction\n",
>> @@ -7830,8 +7823,7 @@ static int raid5_run(struct mddev *mddev)
>>              (mddev->bitmap_info.offset || mddev->bitmap_info.file)) {
>>                  pr_notice("md/raid:%s: array cannot have both journal and bitmap\n",
>>                            mdname(mddev));
>> -               ret = -EINVAL;
>> -               goto exit_acct_set;
>> +               return -EINVAL;
>>          }
>>
>>          if (mddev->reshape_position != MaxSector) {
>> @@ -7856,15 +7848,13 @@ static int raid5_run(struct mddev *mddev)
>>                  if (journal_dev) {
>>                          pr_warn("md/raid:%s: don't support reshape with journal - aborting.\n",
>>                                  mdname(mddev));
>> -                       ret = -EINVAL;
>> -                       goto exit_acct_set;
>> +                       return -EINVAL;
>>                  }
>>
>>                  if (mddev->new_level != mddev->level) {
>>                          pr_warn("md/raid:%s: unsupported reshape required - aborting.\n",
>>                                  mdname(mddev));
>> -                       ret = -EINVAL;
>> -                       goto exit_acct_set;
>> +                       return -EINVAL;
>>                  }
>>                  old_disks = mddev->raid_disks - mddev->delta_disks;
>>                  /* reshape_position must be on a new-stripe boundary, and one
>> @@ -7880,8 +7870,7 @@ static int raid5_run(struct mddev *mddev)
>>                  if (sector_div(here_new, chunk_sectors * new_data_disks)) {
>>                          pr_warn("md/raid:%s: reshape_position not on a stripe boundary\n",
>>                                  mdname(mddev));
>> -                       ret = -EINVAL;
>> -                       goto exit_acct_set;
>> +                       return -EINVAL;
>>                  }
>>                  reshape_offset = here_new * chunk_sectors;
>>                  /* here_new is the stripe we will write to */
>> @@ -7903,8 +7892,7 @@ static int raid5_run(struct mddev *mddev)
>>                          else if (mddev->ro == 0) {
>>                                  pr_warn("md/raid:%s: in-place reshape must be started in read-only mode - aborting\n",
>>                                          mdname(mddev));
>> -                               ret = -EINVAL;
>> -                               goto exit_acct_set;
>> +                               return -EINVAL;
>>                          }
>>                  } else if (mddev->reshape_backwards
>>                      ? (here_new * chunk_sectors + min_offset_diff <=
>> @@ -7914,8 +7902,7 @@ static int raid5_run(struct mddev *mddev)
>>                          /* Reading from the same stripe as writing to - bad */
>>                          pr_warn("md/raid:%s: reshape_position too early for auto-recovery - aborting.\n",
>>                                  mdname(mddev));
>> -                       ret = -EINVAL;
>> -                       goto exit_acct_set;
>> +                       return -EINVAL;
>>                  }
>>                  pr_debug("md/raid:%s: reshape will continue\n", mdname(mddev));
>>                  /* OK, we should be able to continue; */
>> @@ -7939,10 +7926,8 @@ static int raid5_run(struct mddev *mddev)
>>          else
>>                  conf = mddev->private;
>>
>> -       if (IS_ERR(conf)) {
>> -               ret = PTR_ERR(conf);
>> -               goto exit_acct_set;
>> -       }
>> +       if (IS_ERR(conf))
>> +               return PTR_ERR(conf);
>>
>>          if (test_bit(MD_HAS_JOURNAL, &mddev->flags)) {
>>                  if (!journal_dev) {
>> @@ -8140,10 +8125,7 @@ static int raid5_run(struct mddev *mddev)
>>          free_conf(conf);
>>          mddev->private = NULL;
>>          pr_warn("md/raid:%s: failed to run raid set.\n", mdname(mddev));
>> -       ret = -EIO;
>> -exit_acct_set:
>> -       acct_bioset_exit(mddev);
>> -       return ret;
>> +       return -EIO;
>>   }
>>
>>   static void raid5_free(struct mddev *mddev, void *priv)
>> @@ -8151,7 +8133,6 @@ static void raid5_free(struct mddev *mddev, void *priv)
>>          struct r5conf *conf = priv;
>>
>>          free_conf(conf);
>> -       acct_bioset_exit(mddev);
>>          mddev->to_remove = &raid5_attrs_group;
>>   }
>>
>> --
>> 2.39.2
>>
> 
> The patch is good for me.
> 
> Reviewed-by: Xiao Ni <xni@redhat.com>
> 
> .
> 

