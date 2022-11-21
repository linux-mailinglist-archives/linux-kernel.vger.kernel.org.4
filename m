Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6EB6319AF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKUGTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKUGTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:19:04 -0500
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEDE29C9B;
        Sun, 20 Nov 2022 22:19:01 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07477166|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.041814-0.000814244-0.957372;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.QCt.C5w_1669011516;
Received: from 192.168.220.136(mailfrom:michael@allwinnertech.com fp:SMTPD_---.QCt.C5w_1669011516)
          by smtp.aliyun-inc.com;
          Mon, 21 Nov 2022 14:18:58 +0800
Message-ID: <23c0a4ae-d714-cfb1-aeb5-68b66b5bf0ee@allwinnertech.com>
Date:   Mon, 21 Nov 2022 14:18:36 +0800
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
From:   Michael Wu <michael@allwinnertech.com>
In-Reply-To: <CA+Da2qxP2gvUc2=n5xW7_YEcgevGpDhqbcVFWVbF0c6DqXDXHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/2022 7:43 PM, Wenchao Chen wrote:
> On Fri, Nov 18, 2022 at 1:52 PM Michael Wu <michael@allwinnertech.com> wrote:
>>
>> Current next_tag selection will cause a large delay in some requests and
>> destroy the scheduling results of the block scheduling layer. Because the
>> issued mrq tags cannot ensure that each time is sequential, especially when
>> the IO load is heavy. In the fio performance test, we found that 4k random
>> read data was sent to mmc_hsq to start calling request_atomic It takes
>> nearly 200ms to process the request, while mmc_hsq has processed thousands
>> of other requests. So we use fifo here to ensure the first in, first out
>> feature of the request and avoid adding additional delay to the request.
>>
> 
> Hi Michael
> Is the test device an eMMC?
> Could you share the fio test command if you want?
> Can you provide more logs?
> 
Hi Wenchao,
Yes, the tested device is emmc.
The test command we used is `./fio -name=Rand_Read_IOPS_Test 
-group_reporting -rw=random -bs=4K -numjobs=8 -directory=/data/data 
-size=1G -io_size=64M -nrfiles=1 -direct=1 -thread && rm 
/data/Rand_Read_IOPS_Test *`,  which replaces the io performance random 
read performance test of androidbench, and the file size is set to 1G, 8 
thread test configuration. Where /data uses f2fs and /data/data is a 
file encrypted path.

After enabling the hsq configuration, we can clearly see from below fio 
test log that the minimum value of random reading is 3175 iops and the 
maximum value is 8554iops, and the maximum delay of io completion is 
about 200ms.
```
     clat percentiles (usec):
      |  1.00th=[   498],  5.00th=[   865], 10.00th=[   963], 20.00th=[ 
  1045],
      | 30.00th=[  1090], 40.00th=[  1139], 50.00th=[  1172], 60.00th=[ 
  1221],
      | 70.00th=[  1254], 80.00th=[  1319], 90.00th=[  1401], 95.00th=[ 
  1614],
      | 99.00th=[  2769], 99.50th=[  3589], 99.90th=[ 31589], 99.95th=[ 
66323],
      | 99.99th=[200279]
    bw (  KiB/s): min=12705, max=34225, per=100.00%, avg=23931.79, 
stdev=497.40, samples=345
    iops        : min= 3175, max= 8554, avg=5981.67, stdev=124.38, 
samples=345
```


```
     clat percentiles (usec):
      |  1.00th=[  799],  5.00th=[  938], 10.00th=[  963], 20.00th=[  979],
      | 30.00th=[  996], 40.00th=[ 1004], 50.00th=[ 1020], 60.00th=[ 1045],
      | 70.00th=[ 1074], 80.00th=[ 1106], 90.00th=[ 1172], 95.00th=[ 1237],
      | 99.00th=[ 1450], 99.50th=[ 1516], 99.90th=[ 1762], 99.95th=[ 2180],
      | 99.99th=[ 9503]
    bw (  KiB/s): min=29200, max=30944, per=100.00%, avg=30178.91, 
stdev=53.45, samples=272
    iops        : min= 7300, max= 7736, avg=7544.62, stdev=13.38, 
samples=272
```
When NOT enabling hsq, the minimum value of random reading is 7300 iops 
and the maximum value is 7736 iops, and the maximum delay of io is only 
9 ms. Finally, we added debug to the mmc driver. The reason for locating 
the 200ms delay of hsq is due to the next tag selection of hsq.

---
Michael Wu
