Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C651463A03F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 04:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiK1D4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 22:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiK1D4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 22:56:01 -0500
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EF75F83;
        Sun, 27 Nov 2022 19:55:58 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436302|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00377063-0.00017739-0.996052;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.QITOHN5_1669607722;
Received: from 192.168.220.136(mailfrom:michael@allwinnertech.com fp:SMTPD_---.QITOHN5_1669607722)
          by smtp.aliyun-inc.com;
          Mon, 28 Nov 2022 11:55:25 +0800
Message-ID: <d4ecd7cf-0dd0-570f-0560-a5886f464429@allwinnertech.com>
Date:   Mon, 28 Nov 2022 11:55:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mmc:mmc-hsq:use fifo to dispatch mmc_request
Content-Language: en-US
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     ulf.hansson@linaro.org, wenchao.chen@unisoc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221118054725.80414-1-michael@allwinnertech.com>
 <CA+Da2qxP2gvUc2=n5xW7_YEcgevGpDhqbcVFWVbF0c6DqXDXHA@mail.gmail.com>
 <23c0a4ae-d714-cfb1-aeb5-68b66b5bf0ee@allwinnertech.com>
 <CA+Da2qwXLapwUDX+GrFkNQE9so2Tj=ymY1YS396J_N_c+9EHYw@mail.gmail.com>
From:   Michael Wu <michael@allwinnertech.com>
In-Reply-To: <CA+Da2qwXLapwUDX+GrFkNQE9so2Tj=ymY1YS396J_N_c+9EHYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/2022 10:56 AM, Wenchao Chen wrote:
> On Mon, Nov 21, 2022 at 2:19 PM Michael Wu <michael@allwinnertech.com> wrote:
>>
>> On 11/18/2022 7:43 PM, Wenchao Chen wrote:
>>> On Fri, Nov 18, 2022 at 1:52 PM Michael Wu <michael@allwinnertech.com> wrote:
>>>>
>>>> Current next_tag selection will cause a large delay in some requests and
>>>> destroy the scheduling results of the block scheduling layer. Because the
>>>> issued mrq tags cannot ensure that each time is sequential, especially when
>>>> the IO load is heavy. In the fio performance test, we found that 4k random
>>>> read data was sent to mmc_hsq to start calling request_atomic It takes
>>>> nearly 200ms to process the request, while mmc_hsq has processed thousands
>>>> of other requests. So we use fifo here to ensure the first in, first out
>>>> feature of the request and avoid adding additional delay to the request.
>>>>
>>>
>>> Hi Michael
>>> Is the test device an eMMC?
>>> Could you share the fio test command if you want?
>>> Can you provide more logs?
>>>
>> Hi Wenchao,
>> Yes, the tested device is emmc.
>> The test command we used is `./fio -name=Rand_Read_IOPS_Test
>> -group_reporting -rw=random -bs=4K -numjobs=8 -directory=/data/data
>> -size=1G -io_size=64M -nrfiles=1 -direct=1 -thread && rm
>> /data/Rand_Read_IOPS_Test *`,  which replaces the io performance random
>> read performance test of androidbench, and the file size is set to 1G, 8
>> thread test configuration. Where /data uses f2fs and /data/data is a
>> file encrypted path.
>>
>> After enabling the hsq configuration, we can clearly see from below fio
>> test log that the minimum value of random reading is 3175 iops and the
>> maximum value is 8554iops, and the maximum delay of io completion is
>> about 200ms.
>> ```
>>       clat percentiles (usec):
>>        |  1.00th=[   498],  5.00th=[   865], 10.00th=[   963], 20.00th=[
>>    1045],
>>        | 30.00th=[  1090], 40.00th=[  1139], 50.00th=[  1172], 60.00th=[
>>    1221],
>>        | 70.00th=[  1254], 80.00th=[  1319], 90.00th=[  1401], 95.00th=[
>>    1614],
>>        | 99.00th=[  2769], 99.50th=[  3589], 99.90th=[ 31589], 99.95th=[
>> 66323],
>>        | 99.99th=[200279]
>>      bw (  KiB/s): min=12705, max=34225, per=100.00%, avg=23931.79,
>> stdev=497.40, samples=345
>>      iops        : min= 3175, max= 8554, avg=5981.67, stdev=124.38,
>> samples=345
>> ```
>>
>>
>> ```
>>       clat percentiles (usec):
>>        |  1.00th=[  799],  5.00th=[  938], 10.00th=[  963], 20.00th=[  979],
>>        | 30.00th=[  996], 40.00th=[ 1004], 50.00th=[ 1020], 60.00th=[ 1045],
>>        | 70.00th=[ 1074], 80.00th=[ 1106], 90.00th=[ 1172], 95.00th=[ 1237],
>>        | 99.00th=[ 1450], 99.50th=[ 1516], 99.90th=[ 1762], 99.95th=[ 2180],
>>        | 99.99th=[ 9503]
>>      bw (  KiB/s): min=29200, max=30944, per=100.00%, avg=30178.91,
>> stdev=53.45, samples=272
>>      iops        : min= 7300, max= 7736, avg=7544.62, stdev=13.38,
>> samples=272
>> ```
>> When NOT enabling hsq, the minimum value of random reading is 7300 iops
>> and the maximum value is 7736 iops, and the maximum delay of io is only
>> 9 ms. Finally, we added debug to the mmc driver. The reason for locating
>> the 200ms delay of hsq is due to the next tag selection of hsq.
>>
> 
> Thank you very much for your Log. This patch can reduce latency, but I
> have some questions:
> 1. FIO -rw does not have random, but it does have randread. Do you use
> randread? In addition, "IO_SIZE=64M" means only 64M data is tested?
> Refer to FIO:
> https://fio.readthedocs.io/en/latest/fio_doc.html?highlight=io_size#cmdoption-arg-io-size
Hi Wenchao,

Yes, I used "randread". (Sorry, I wrote the parameter "random" 
incorrectly.) The reason why I used "io_size=64M" is that I found the 
performance of hsq was degraded when using the AndroBench for testing on 
android13. Therefore, fio is used to simulate the AndroBench for 
debugging. The AndroBench is configured with 8 threads while 1G files 
per thread, and only 64M data for random read testing（This item is not 
configurable）.

> 2. The style of "tag_tail" should remain the same as that of
> "next_tag". Would "tail_tag" be better?
Thank you for your suggestion. I'll modify 'tag_tail' as 'tail_tag'.

> 3. It is better to provide a comparison of sequential read, sequential
> write and random writeHere is the performance data tested by AndroBench:

-------------------------------------------------------------------------
       io performance data from AndroBench (filesize=1G, 8 threads)
-------------------------------------------------------------------------
mmc configure     | original hsq  |  without hsq  |  hsq with this patch
-------------------------------------------------------------------------
Sequential write      58.23 MB/s       51.35 MB/s        56.15 MB/s
Sequential read      138.24 MB/s      143.65 MB/s        146.4 MB/s
random write        2900.11 iops     1887.13 iops      2982.02 iops
random read         4764.45 iops     5485.19 iops      6786.42 iops

Here's a preview of patch-v2. If it's OK, I'll submit it soon. Thank you.

--
mmc:mmc-hsq:use fifo to dispatch mmc_request

Current next_tag selection will cause a large delay in some requests and 
destroy the scheduling results of the block scheduling layer. Because 
the issued mrq tags cannot ensure that each time is sequential, 
especially when the IO load is heavy. In the fio performance test, we 
found that 4k random read data was sent to mmc_hsq to start calling 
request_atomic It takes nearly 200ms to process the request, while 
mmc_hsq has processed thousands of other requests. So we use fifo here 
to ensure the first in, first out feature of the request and avoid 
adding additional delay to the request.

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index 9d35453e7371..424dc7b07858 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -13,9 +13,6 @@

  #include "mmc_hsq.h"

-#define HSQ_NUM_SLOTS	64
-#define HSQ_INVALID_TAG	HSQ_NUM_SLOTS
-
  static void mmc_hsq_retry_handler(struct work_struct *work)
  {
  	struct mmc_hsq *hsq = container_of(work, struct mmc_hsq, retry_work);
@@ -73,7 +70,6 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)

  static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
  {
-	struct hsq_slot *slot;
  	int tag;

  	/*
@@ -82,29 +78,12 @@ static void mmc_hsq_update_next_tag(struct mmc_hsq 
*hsq, int remains)
  	 */
  	if (!remains) {
  		hsq->next_tag = HSQ_INVALID_TAG;
+		hsq->tail_tag = HSQ_INVALID_TAG;
  		return;
  	}

-	/*
-	 * Increasing the next tag and check if the corresponding request is
-	 * available, if yes, then we found a candidate request.
-	 */
-	if (++hsq->next_tag != HSQ_INVALID_TAG) {
-		slot = &hsq->slot[hsq->next_tag];
-		if (slot->mrq)
-			return;
-	}
-
-	/* Othersie we should iterate all slots to find a available tag. */
-	for (tag = 0; tag < HSQ_NUM_SLOTS; tag++) {
-		slot = &hsq->slot[tag];
-		if (slot->mrq)
-			break;
-	}
-
-	if (tag == HSQ_NUM_SLOTS)
-		tag = HSQ_INVALID_TAG;
-
+	tag = hsq->tag_slot[hsq->next_tag];
+	hsq->tag_slot[hsq->next_tag] = HSQ_INVALID_TAG;
  	hsq->next_tag = tag;
  }

@@ -233,8 +212,14 @@ static int mmc_hsq_request(struct mmc_host *mmc, 
struct mmc_request *mrq)
  	 * Set the next tag as current request tag if no available
  	 * next tag.
  	 */
-	if (hsq->next_tag == HSQ_INVALID_TAG)
+	if (hsq->next_tag == HSQ_INVALID_TAG) {
  		hsq->next_tag = tag;
+		hsq->tail_tag = tag;
+		hsq->tag_slot[hsq->tail_tag] = HSQ_INVALID_TAG;
+	} else {
+		hsq->tag_slot[hsq->tail_tag] = tag;
+		hsq->tail_tag = tag;
+	}

  	hsq->qcnt++;

@@ -339,8 +324,10 @@ static const struct mmc_cqe_ops mmc_hsq_ops = {

  int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
  {
+	int i;
  	hsq->num_slots = HSQ_NUM_SLOTS;
  	hsq->next_tag = HSQ_INVALID_TAG;
+	hsq->tail_tag = HSQ_INVALID_TAG;

  	hsq->slot = devm_kcalloc(mmc_dev(mmc), hsq->num_slots,
  				 sizeof(struct hsq_slot), GFP_KERNEL);
@@ -351,6 +338,9 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct 
mmc_host *mmc)
  	hsq->mmc->cqe_private = hsq;
  	mmc->cqe_ops = &mmc_hsq_ops;

+	for (i = 0; i < HSQ_NUM_SLOTS; i++)
+		hsq->tag_slot[i] = HSQ_INVALID_TAG;
+
  	INIT_WORK(&hsq->retry_work, mmc_hsq_retry_handler);
  	spin_lock_init(&hsq->lock);
  	init_waitqueue_head(&hsq->wait_queue);
diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
index ffdd9cd172c3..1808024fc6c5 100644
--- a/drivers/mmc/host/mmc_hsq.h
+++ b/drivers/mmc/host/mmc_hsq.h
@@ -2,6 +2,9 @@
  #ifndef LINUX_MMC_HSQ_H
  #define LINUX_MMC_HSQ_H

+#define HSQ_NUM_SLOTS	64
+#define HSQ_INVALID_TAG	HSQ_NUM_SLOTS
+
  struct hsq_slot {
  	struct mmc_request *mrq;
  };
@@ -17,6 +20,8 @@ struct mmc_hsq {
  	int next_tag;
  	int num_slots;
  	int qcnt;
+	int tail_tag;
+	int tag_slot[HSQ_NUM_SLOTS];

  	bool enabled;
  	bool waiting_for_idle;

-- 
Regards,
Michael Wu
