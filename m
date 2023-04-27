Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB246F047F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbjD0KwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243262AbjD0Kv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:51:58 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E9012D;
        Thu, 27 Apr 2023 03:51:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q6Xc82XKkz4f3pC1;
        Thu, 27 Apr 2023 18:51:52 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbDIU0pkDbYGIQ--.19858S3;
        Thu, 27 Apr 2023 18:51:53 +0800 (CST)
Subject: Re: [PATCH 3/3] md/raid10: fix wrong setting of max_corr_read_errors
To:     linan666@huaweicloud.com, song@kernel.org, neilb@suse.de,
        Rob.Becker@riverbed.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230427085612.1346752-1-linan666@huaweicloud.com>
 <20230427085612.1346752-4-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <686d8ef7-cbae-113c-fa48-e0c5dfa2f3d5@huaweicloud.com>
Date:   Thu, 27 Apr 2023 18:51:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230427085612.1346752-4-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbDIU0pkDbYGIQ--.19858S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKryfWF17ZF45Jw48GryUZFb_yoW7CF4Upa
        1DAas8Ar4UJ34UAw1DJrWq9a4Fy34SyayjyryxJa1xWwn3Jrn8ta4UWFyj9r18WF9xJw13
        XFZ8Gr4DCF48KFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/04/27 16:56, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> max_corr_read_errors should not be negative number. Change it to
> unsigned int where use it.
> 
> Fixes: 1e50915fe0bb ("raid: improve MD/raid10 handling of correctable read errors.")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/md.c     | 2 +-
>   drivers/md/raid10.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index faffbd042925..a365ed122960 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4484,7 +4484,7 @@ __ATTR_PREALLOC(array_state, S_IRUGO|S_IWUSR, array_state_show, array_state_stor
>   
>   static ssize_t
>   max_corrected_read_errors_show(struct mddev *mddev, char *page) {
> -	return sprintf(page, "%d\n",
> +	return sprintf(page, "%u\n",
>   		       atomic_read(&mddev->max_corr_read_errors));
>   }
>   
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 4fcfcb350d2b..28cdb2ae0e91 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2727,7 +2727,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   	int sect = 0; /* Offset from r10_bio->sector */
>   	int sectors = r10_bio->sectors;
>   	struct md_rdev *rdev;
> -	int max_read_errors = atomic_read(&mddev->max_corr_read_errors);
> +	unsigned int max_read_errors = atomic_read(&mddev->max_corr_read_errors);

This line exceed 80 columns.
>   	int d = r10_bio->devs[r10_bio->read_slot].devnum;
>   
>   	/* still own a reference to this rdev, so it cannot
> @@ -2743,7 +2743,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>   	check_decay_read_errors(mddev, rdev);
>   	atomic_inc(&rdev->read_errors);
>   	if (atomic_read(&rdev->read_errors) > max_read_errors) {
> -		pr_notice("md/raid10:%s: %pg: Raid device exceeded read_error threshold [cur %d:max %d]\n",
> +		pr_notice("md/raid10:%s: %pg: Raid device exceeded read_error threshold [cur %u:max %u]\n",
>   			  mdname(mddev), rdev->bdev,
>   			  atomic_read(&rdev->read_errors), max_read_errors);
>   		pr_notice("md/raid10:%s: %pg: Failing raid device\n",
> 

This is not critical, but I think it's better do some cleanup to fold
above code into check_decay_read_errors(), and rename it to
check_read_error():

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 7135cfaf75db..633aabfea452 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2636,18 +2636,17 @@ static void recovery_request_write(struct mddev 
*mddev, struct r10bio *r10_bio)
   * since the last recorded read error.
   *
   */
-static void check_decay_read_errors(struct mddev *mddev, struct md_rdev 
*rdev)
+static bool check_read_errors(struct mddev *mddev, struct md_rdev *rdev)
  {
-       long cur_time_mon;
+       time64_t cur_time_mon = ktime_get_seconds();
         unsigned long hours_since_last;
-       unsigned int read_errors = atomic_read(&rdev->read_errors);
-
-       cur_time_mon = ktime_get_seconds();
+       unsigned int read_errors;
+       unsigned int max_read_errors;

         if (rdev->last_read_error == 0) {
                 /* first time we've seen a read error */
                 rdev->last_read_error = cur_time_mon;
-               return;
+               goto increase;
         }

         hours_since_last = (long)(cur_time_mon -
@@ -2660,10 +2659,26 @@ static void check_decay_read_errors(struct mddev 
*mddev, struct md_rdev *rdev)
          * just set read errors to 0. We do this to avoid
          * overflowing the shift of read_errors by hours_since_last.
          */
+       read_errors = atomic_read(&rdev->read_errors);
         if (hours_since_last >= 8 * sizeof(read_errors))
                 atomic_set(&rdev->read_errors, 0);
         else
                 atomic_set(&rdev->read_errors, read_errors >> 
hours_since_last);
+
+increase:
+       max_read_errors = atomic_read(&mddev->max_corr_read_errors);
+       read_errors = atomic_inc_return(&rdev->read_errors);
+       if (read_errors > max_read_errors) {
+               pr_notice("md/raid10:%s: %pg: Raid device exceeded 
read_error threshold [cur %u:max %u]\n",
+                         mdname(mddev), rdev->bdev,
+                         read_errors, max_read_errors);
+               pr_notice("md/raid10:%s: %pg: Failing raid device\n",
+                         mdname(mddev), rdev->bdev);
+               md_error(mddev, rdev);
+               return true;
+       }
+
+       return false;
  }

  static int r10_sync_page_io(struct md_rdev *rdev, sector_t sector,
@@ -2703,7 +2718,6 @@ static void fix_read_error(struct r10conf *conf, 
struct mddev *mddev, struct r10
         int sect = 0; /* Offset from r10_bio->sector */
         int sectors = r10_bio->sectors;
         struct md_rdev *rdev;
-       int max_read_errors = atomic_read(&mddev->max_corr_read_errors);
         int d = r10_bio->devs[r10_bio->read_slot].devnum;

         /* still own a reference to this rdev, so it cannot
@@ -2716,15 +2730,7 @@ static void fix_read_error(struct r10conf *conf, 
struct mddev *mddev, struct r10
                    more fix_read_error() attempts */
                 return;

-       check_decay_read_errors(mddev, rdev);
-       atomic_inc(&rdev->read_errors);
-       if (atomic_read(&rdev->read_errors) > max_read_errors) {
-               pr_notice("md/raid10:%s: %pg: Raid device exceeded 
read_error threshold [cur %d:max %d]\n",
-                         mdname(mddev), rdev->bdev,
-                         atomic_read(&rdev->read_errors), max_read_errors);
-               pr_notice("md/raid10:%s: %pg: Failing raid device\n",
-                         mdname(mddev), rdev->bdev);
-               md_error(mddev, rdev);
+       if (check_read_errors(mddev, rdev)) {
                 r10_bio->devs[r10_bio->read_slot].bio = IO_BLOCKED;
                 return;
         }

Thanks,
Kuai


