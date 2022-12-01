Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9ED63F144
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiLANKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiLANKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:10:19 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E189E45C;
        Thu,  1 Dec 2022 05:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669900209; x=1701436209;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s8L1eFbYp0vprVnbaMynMWJnquPml4BCuQIfirbAahA=;
  b=aDOYyqNe9JDsFTMer2wQzK6D56iO6HTdNCR7+NxxezTPDupMZbzRKfIl
   lA3zr2IAQ7cGqEXAVUUG+YvNknxd1D/FCWEgP+G/6Nor64tIdfDF8VTsC
   y3a07VVC/7BcoYdiNU6CnOcvxlpXfeIwbuhWOGZWkg9UjZx0/wLjgxnkn
   Nu/LXlbP6tKuPBBBPbirHRV+94BAWCakg19WiuDtkUfESodqHeb0s0QG0
   YEIzhByHDckff9AIV1XoxJvfaDFr2a1HazQLEEkgx9AfE+szR6pNAWGkr
   3DDO7ipbXGLIwkX3LTfNR4VFOwjqbXD+xswN8qZVH/jzOtvykqL44cnqR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="314379303"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="314379303"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 05:10:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="638384748"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="638384748"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.240])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 05:10:03 -0800
Message-ID: <20aae21e-62d2-8fdb-b57a-7b5a180266d8@intel.com>
Date:   Thu, 1 Dec 2022 15:09:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: PM-runtime: supplier looses track of consumer during probe
Content-Language: en-US
To:     Nitin Rawat <quic_nitirawa@quicinc.com>,
        Tushar Nimkar <quic_tnimkar@quicinc.com>,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        bjorn.andersson@kernel.org, quic_mkshah@quicinc.com,
        quic_lsrao@quicinc.com, bvanassche@acm.org,
        Peter Wang <peter.wang@mediatek.com>
References: <36aed941-a73e-d937-2721-4f0decd61ce0@quicinc.com>
 <8c0a715a-d626-aa70-15f1-79f1e23fbc67@quicinc.com>
 <a5e2aab6-7f0e-7f3b-f34b-6d222450c97d@intel.com>
 <8ca27fcb-b146-3ea7-a042-55f99e0ae3fb@quicinc.com>
 <2a1047a7-3121-6cbe-d4c5-46bbff0c5cc5@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <2a1047a7-3121-6cbe-d4c5-46bbff0c5cc5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/22 18:56, Nitin Rawat wrote:
> Hi Adrian,
> 
> On 11/21/2022 11:38 AM, Tushar Nimkar wrote:
>> Hi Adrian,
>>
>> On 11/18/2022 8:25 PM, Adrian Hunter wrote:
>>> On 4/11/22 11:19, Tushar Nimkar wrote:
>>>> Hi linux-pm/linux-scsi,
>>
>>>>> Process -1
>>>>> ufshcd_async_scan context (process 1)
>>>>> scsi_autopm_put_device() //0:0:0:0
>>>
>>> I am having trouble following your description.  What function is calling
>>> scsi_autopm_put_device() here?
>>>
>> Below is flow which calls scsi_autopm_put_device()
>> Process -1
>> ufshcd_async_scan()
>>      scsi_probe_and_add_lun()
>>          scsi_add_lun()
>>              slave_configure()
>>                  scsi_sysfs_add_sdev()
>>                      scsi_autopm_get_device()
>>                          device_add()     <- invoked [Process 2] sd_probe()
>>                              scsi_autopm_put_device()
>>
>>>>> pm_runtime_put_sync()
>>>>> __pm_runtime_idle()
>>>>> rpm_idle() -- RPM_GET_PUT(4)
>>>>>       __rpm_callback
>>>>>           scsi_runtime_idle()
>>>>>               pm_runtime_mark_last_busy()
>>>>>               pm_runtime_autosuspend()  --[A]
>>>>>                   rpm_suspend() -- RPM_AUTO(8)
>>>>>                       pm_runtime_autosuspend_expiration() use_autosuspend    is false return 0   --- [B]
>>>>>                           __update_runtime_status to RPM_SUSPENDING
>>>>>                       __rpm_callback()
>>>>>                           __rpm_put_suppliers(dev, false)
>>>>>                       __update_runtime_status to RPM_SUSPENDED
>>>>>                   rpm_suspend_suppliers()
>>>>>                       rpm_idle() for supplier -- RPM_ASYNC(1) return (-EAGAIN) [ Other consumer active for supplier]
>>>>>                   rpm_suspend() – END with return=0
>>>>>           scsi_runtime_idle() END return (-EBUSY) always.
>>>
>>> Not following here either.  Which device is EBUSY and why?
>>
>> scsi_runtime_idle() return -EBUSY always [3]
>> Storage/scsi team can better explain -EBUSY implementation.
> 
> EBUSY is returned from below code for consumer dev 0:0:0:0.
> scsi_runtime_idle is called from scsi_autopm_put_device which inturn is called from ufshcd_async_scan (Process 1 as per above call stack)
> static int scsi_runtime_idle(struct device *dev)
> {
>     :
> 
>     if (scsi_is_sdev_device(dev)) {
>         pm_runtime_mark_last_busy(dev);
>         pm_runtime_autosuspend(dev);
>         return -EBUSY; ---> EBUSY returned from here.
>     }
> 
>     
> }
> 
>>
>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/scsi/scsi_pm.c?h=next-20221118#n210
>>
>>
>>>>>
>>>>> [1]: https://lore.kernel.org/lkml/4748074.GXAFRqVoOG@kreacher/T/
>>>>> [2]: https://lkml.org/lkml/2022/10/12/259

It looks to me like __rpm_callback() makes assumptions about
dev->power.runtime_status that are not necessarily true because
dev->power.lock is dropped.  AFAICT the intention of the code
would be fulfilled by instead using the status as it was before
the lock was dropped.

Consequently, perhaps you could try this:

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index b52049098d4e..3cf9abc3b2c2 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -365,6 +365,7 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 {
 	int retval = 0, idx;
 	bool use_links = dev->power.links_count > 0;
+	enum rpm_status runtime_status = dev->power.runtime_status;
 
 	if (dev->power.irq_safe) {
 		spin_unlock(&dev->power.lock);
@@ -378,7 +379,7 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 		 * routine returns, so it is safe to read the status outside of
 		 * the lock.
 		 */
-		if (use_links && dev->power.runtime_status == RPM_RESUMING) {
+		if (use_links && runtime_status == RPM_RESUMING) {
 			idx = device_links_read_lock();
 
 			retval = rpm_get_suppliers(dev);
@@ -405,8 +406,8 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
 		 * Do that if resume fails too.
 		 */
 		if (use_links
-		    && ((dev->power.runtime_status == RPM_SUSPENDING && !retval)
-		    || (dev->power.runtime_status == RPM_RESUMING && retval))) {
+		    && ((runtime_status == RPM_SUSPENDING && !retval)
+		    || (runtime_status == RPM_RESUMING && retval))) {
 			idx = device_links_read_lock();
 
 			__rpm_put_suppliers(dev, false);


