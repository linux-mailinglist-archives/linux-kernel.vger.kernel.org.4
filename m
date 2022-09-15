Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F96F5B9591
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiIOHmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiIOHmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:42:04 -0400
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195649108B;
        Thu, 15 Sep 2022 00:42:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436284|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00286984-0.00393058-0.9932;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=kant@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.PG7-fu-_1663227690;
Received: from 192.168.220.136(mailfrom:kant@allwinnertech.com fp:SMTPD_---.PG7-fu-_1663227690)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 15:41:59 +0800
Message-ID: <8599d9df-3f56-1762-959d-01ee8c753a5b@allwinnertech.com>
Date:   Thu, 15 Sep 2022 15:41:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RESEND] devfreq: governor: Save void *data in the governor
 userspace
Content-Language: en-US
To:     myungjoo.ham@samsung.com,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allwinner-opensource-support@allwinnertech.com" 
        <allwinner-opensource-support@allwinnertech.com>
References: <a040e16c-e8e9-f550-7251-99ec1d18f508@allwinnertech.com>
 <20220329091449.105308-1-kant@allwinnertech.com>
 <CGME20220914091525epcas1p31c8a9b11ba7a36da4678e3254b0ea962@epcms1p8>
 <20220914094355epcms1p8d6eeb0834e2d7c782d49558fac0ce6c4@epcms1p8>
From:   Kant Fan <kant@allwinnertech.com>
In-Reply-To: <20220914094355epcms1p8d6eeb0834e2d7c782d49558fac0ce6c4@epcms1p8>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/2022 5:43 PM, MyungJoo Ham wrote:
>> On 3/29/2022 5:14 PM, Kant Fan wrote:
>>>   The member void *data in the structure devfreq can be overwrite
>>>   by governor_userspace.
>>>   Signed-off-by: Kant Fan <kant@allwinnertech.com>
>>>   ---
>>>     drivers/devfreq/governor_userspace.c | 6 +++++-
>>>     1 file changed, 5 insertions(+), 1 deletion(-)
>>>   
>>>   diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
>>>   index ab9db7adb3ad..dbbb448dcbcf 100644
>>>   --- a/drivers/devfreq/governor_userspace.c
>>>   +++ b/drivers/devfreq/governor_userspace.c
>>>   @@ -17,6 +17,7 @@
>>>     struct userspace_data {
>>>             unsigned long user_frequency;
>>>             bool valid;
>>>   +        void *saved_data;
>>>     };
>>>     
>>>     static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
>>>   @@ -91,6 +92,7 @@ static int userspace_init(struct devfreq *devfreq)
>>>                     goto out;
>>>             }
>>>             data->valid = false;
>>>   +        data->saved_data = devfreq->data;
>>>             devfreq->data = data;
>>>     
>>>             err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
>>>   @@ -100,6 +102,8 @@ static int userspace_init(struct devfreq *devfreq)
>>>     
>>>     static void userspace_exit(struct devfreq *devfreq)
>>>     {
>>>   +        struct userspace_data *data = devfreq->data;
>>>   +        void *saved_data = data->saved_data;
>>>             /*
>>>              * Remove the sysfs entry, unless this is being called after
>>>              * device_del(), which should have done this already via kobject_del().
>>>   @@ -108,7 +112,7 @@ static void userspace_exit(struct devfreq *devfreq)
>>>                     sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
>>>     
>>>             kfree(devfreq->data);
>>>   -        devfreq->data = NULL;
>>>   +        devfreq->data = saved_data;
>>>     }
>>>     
>>>     static int devfreq_userspace_handler(struct devfreq *devfreq,
>>
>> Dear MyungJoo, Kyungmin & Chanwoo,
>> Gently ping this issue... Does this patch has a chance to be accepted?
>> This seems to be a bug in devfreq userspace governor, which affects the
>> switching between governors -- When switching from userspace to
>> ondemand, the ondemand governor would be invalid.
>> If there's any question, please let me know.
>> Thank you.
> 
> Yes, indeed. This is a bug.
> 
> Actually, it appears that allocating a new memory buffer for
> devfreq->data itself is a bug for a governor, this is supposed
> to be allocated by a device driver. Thus, the comment of
> "void *data" of "struct devfreq" should be updated:
> "/* private data for governors given by device drivers */"
> 
> It'd be better to have something like, "void *internal_data"
> for governors to freely handle within its context of init-exit,
> which is not touched by its users (device drivers).
> 
> @Chanwoo: what's your opinion on this?
> 
> Cheers,
> MyungJoo.
> 

Hi MyungJoo,
Thanks for your suggestion. Here's the patch-v2, please have a look:

--
Subject: [PATCH] devfreq: governor: Add a private governor_data for 
governors in devfreq

The member void *data in the structure devfreq can be overwrite
by governor_userspace. For example:
1. The device driver assigned the devfreq governor to simple_ondemand
by the function devfreq_add_device() and init the devfreq member
void *data to a pointer of a static structure devfreq_simple_ondemand_data
by the function devfreq_add_device().
2. The user changed the devfreq governor to userspace by the command
"echo userspace > /sys/class/devfreq/.../governor".
3. The governor userspace alloced a dynamic memory for the struct
userspace_data and assigend the member void *data of devfreq to
this memory by the function userspace_init().
4. The user changed the devfreq governor back to simple_ondemand
by the command "echo simple_ondemand > /sys/class/devfreq/.../governor".
5. The governor userspace exited and assigned the member void *data
in the structure devfreq to NULL by the function userspace_exit().
6. The governor simple_ondemand fetched the static information of
devfreq_simple_ondemand_data in the function
devfreq_simple_ondemand_func() but the member void *data of devfreq was
assigned to NULL by the function userspace_exit().
7. The information of upthreshold and downdifferential is lost
and the governor simple_ondemand can't work correctly.

The member void *data in the structure devfreq is designed for
a static pointer used in a governor and inited by the function
devfreq_add_device(). This patch add an element named governor_data
in the devfreq structure which can be used by a governor(E.g userspace)
who want to assign a private data to do some private things.

Signed-off-by: Kant Fan <kant@allwinnertech.com>
---

diff --git a/drivers/devfreq/governor_userspace.c 
b/drivers/devfreq/governor_userspace.c
index ab9db7a..d69672c 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -21,7 +21,7 @@

  static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
  {
-	struct userspace_data *data = df->data;
+	struct userspace_data *data = df->governor_data;

  	if (data->valid)
  		*freq = data->user_frequency;
@@ -40,7 +40,7 @@
  	int err = 0;

  	mutex_lock(&devfreq->lock);
-	data = devfreq->data;
+	data = devfreq->governor_data;

  	sscanf(buf, "%lu", &wanted);
  	data->user_frequency = wanted;
@@ -60,7 +60,7 @@
  	int err = 0;

  	mutex_lock(&devfreq->lock);
-	data = devfreq->data;
+	data = devfreq->governor_data;

  	if (data->valid)
  		err = sprintf(buf, "%lu\n", data->user_frequency);
@@ -91,7 +91,7 @@
  		goto out;
  	}
  	data->valid = false;
-	devfreq->data = data;
+	devfreq->governor_data = data;

  	err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
  out:
@@ -107,8 +107,8 @@
  	if (devfreq->dev.kobj.sd)
  		sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);

-	kfree(devfreq->data);
-	devfreq->data = NULL;
+	kfree(devfreq->governor_data);
+	devfreq->governor_data = NULL;
  }

  static int devfreq_userspace_handler(struct devfreq *devfreq,
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 34aab4d..d265af3 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -152,8 +152,8 @@
   * @max_state:		count of entry present in the frequency table.
   * @previous_freq:	previously configured frequency value.
   * @last_status:	devfreq user device info, performance statistics
- * @data:	Private data of the governor. The devfreq framework does not
- *		touch this.
+ * @data:	devfreq core pass to governors, governor should not change it.
+ * @governor_data:	private data for governors, devfreq core doesn't 
touch it.
   * @user_min_freq_req:	PM QoS minimum frequency request from user (via 
sysfs)
   * @user_max_freq_req:	PM QoS maximum frequency request from user (via 
sysfs)
   * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
@@ -193,7 +193,8 @@
  	unsigned long previous_freq;
  	struct devfreq_dev_status last_status;

-	void *data; /* private data for governors */
+	void *data;
+	void *governor_data;

  	struct dev_pm_qos_request user_min_freq_req;
  	struct dev_pm_qos_request user_max_freq_req;

-- 
Best Regards,
Kant Fan
