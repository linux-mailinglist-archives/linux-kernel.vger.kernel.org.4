Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FB862F895
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242098AbiKRO6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242101AbiKRO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:57:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B0A93732;
        Fri, 18 Nov 2022 06:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668783364; x=1700319364;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0OtRaUHayEMkGM0LZpQdloZpzT7G+P2JPi1mC2cyIyg=;
  b=RIlc8WCCUfEX1Rj3CNuGIT7/m4bg3rZ5vuiVVbU5exbh5hhAAbCVUYsX
   89J1BuALE+hwlrYzkS6TP3nX25DUJJ3waFzAyFPzLUcFnyHtjI/5pHzio
   oKaQ4KTKMPvYvAGJdo6T3QSm/yWy899eYjPPEub4Le7j+2jJVa2SLwh6R
   hGSU+JqNMrCwpu5JpqLmI0TLv7mXtXBTBqYh9vIuKrAHngEEj9dgWmJWc
   3bietnlDki07eXtfpYv4lQ1DRtJCwnIPZ1YA1ii4PmM3YGWB2vJ5L1lN/
   oNwwVKnED5wZvpylPdTnX98kMh+c9f35bdAewVp1feer8gqd9eVA6zo+H
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="293539780"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="293539780"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 06:56:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="746028573"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="746028573"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.138])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 06:56:01 -0800
Message-ID: <a5e2aab6-7f0e-7f3b-f34b-6d222450c97d@intel.com>
Date:   Fri, 18 Nov 2022 16:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: PM-runtime: supplier looses track of consumer during probe
Content-Language: en-US
To:     Tushar Nimkar <quic_tnimkar@quicinc.com>, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        bjorn.andersson@kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        quic_mkshah@quicinc.com, quic_lsrao@quicinc.com,
        bvanassche@acm.org, Peter Wang <peter.wang@mediatek.com>
References: <36aed941-a73e-d937-2721-4f0decd61ce0@quicinc.com>
 <8c0a715a-d626-aa70-15f1-79f1e23fbc67@quicinc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <8c0a715a-d626-aa70-15f1-79f1e23fbc67@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 11:19, Tushar Nimkar wrote:
> Hi linux-pm/linux-scsi,
> 
> Gentle reminder!
> 
> Can you please provide your suggestions on below race?
> 
> Thanks, Tushar Nimkar
> 
> On 10/14/2022 4:20 PM, Tushar Nimkar wrote:
>> Hi linux-pm/linux-scsi,
>>
>> We have included fix [1] but continuing to observe supplier loosing track of consumer.
>>
>> Below is trace snippet with additional logging added.
>> Here consumer is 0:0:0:0 and supplier is 0:0:0:49488. In Last three lines consumer resume is completed but supplier is put down.
>>
>>     kworker/u16:0-7     0.880014: rpm_idle:             0:0:0:0 flags-4 cnt-0  dep-0  auto-1 p-0 irq-0 child-0
>>     kworker/u16:0-7     0.880017: bprint: pm_runtime_mark_last_busy.46700: :#205 dev_name:0:0:0:0 ktime_get_mono_fast_ns():852365364
>>     kworker/u16:0-7     0.880019: rpm_suspend:          0:0:0:0 flags-8 cnt-0  dep-0  auto-1 p-0 irq-0 child-0
>>     kworker/u16:0-7     0.880022: bprint: pm_runtime_put_noidle.44083: pm_runtime_put_noidle: #112 dev_name:0:0:0:49488 dev usage_count:5 decremented usage count
>>     kworker/u16:0-7     0.880023: bprint: pm_runtime_put_noidle.44083: pm_runtime_put_noidle: #112 dev_name:0:0:0:49488 dev usage_count:4 decremented usage count
>>     kworker/u16:2-142   0.880024: rpm_resume:           0:0:0:0 flags-4 cnt-1  dep-0  auto-1 p-0 irq-0 child-0
>>     kworker/u16:0-7     0.880025: bprint: __rpm_put_suppliers: __rpm_put_suppliers: #348 consumer:0:0:0:0 supplier:0:0:0:49488 usage_count:4
>>     kworker/u16:0-7     0.880061: rpm_idle:             0:0:0:49488 flags-1 cnt-4  dep-0  auto-1 p-0 irq-0 child-0
>>     kworker/u16:0-7     0.880062: rpm_return_int: rpm_idle+0x16c:0:0:0:49488 ret=-11
>>     kworker/u16:2-142   0.880062: bprint: __pm_runtime_resume: __pm_runtime_resume: #1147 dev_name:0:0:0:49488 dev usage_count:5 incremented usage count
>>     kworker/u16:2-142   0.880063: rpm_resume:           0:0:0:49488 flags-4 cnt-5  dep-0  auto-1 p-0 irq-0 child-0
>>     kworker/u16:2-142   0.880063: rpm_return_int: rpm_resume+0x690:0:0:0:49488 ret=1
>>     kworker/u16:0-7     0.880063: rpm_return_int: rpm_suspend+0x68:0:0:0:0 ret=0
>>     kworker/u16:2-142   0.880063: bprint: rpm_get_suppliers: rpm_get_suppliers: #300 consumer:0:0:0:0 supplier:0:0:0:49488 usage_count:5
>>     kworker/u16:0-7     0.880065: bprint: pm_runtime_put_noidle.44083: pm_runtime_put_noidle: #112 dev_name:0:0:0:49488 dev usage_count:4 decremented usage count
>>     kworker/u16:2-142   0.880065: bprint: pm_runtime_mark_last_busy.44088: :#205 dev_name:0:0:0:0 ktime_get_mono_fast_ns():852413749
>>     kworker/u16:2-142   0.880065: rpm_idle:             0:0:0:0 flags-1 cnt-1  dep-0  auto-1 p-0 irq-0 child-0
>>     kworker/u16:2-142   0.880065: rpm_return_int: rpm_idle+0x16c:0:0:0:0 ret=-11
>>     kworker/u16:0-7     0.880066: bprint: __rpm_put_suppliers: __rpm_put_suppliers: #348 consumer:0:0:0:0 supplier:0:0:0:49488 usage_count:4
>>     kworker/u16:0-7     0.880067: rpm_return_int: rpm_idle+0x16c:0:0:0:0 ret=-16
>>     kworker/u16:2-142   0.880067: rpm_return_int: rpm_resume+0x690:0:0:0:0 ret=0
>>
>> Upon looking into this further the race looks to be in below two processes running in parallel and process-1 is putting down supplier at [C] because process-2 is setting runtime_status as resuming at [D].
>>
>> Also as per runtime PM documentation
>> In order to use autosuspend, subsystems or drivers must call
>> pm_runtime_use_autosuspend(), and thereafter they should use the various `*_autosuspend()` helper functions...
>>
>> It was also observed that *_autosuspend() API at point [A] was invoked without first invoking pm_runtime_use_autosuspend() which return expiration as zero at point [B] and proceeds ahead for immediate runtime suspend of device which seems lead to this race condition.
>>
>> Process -1
>> ufshcd_async_scan context (process 1)
>> scsi_autopm_put_device() //0:0:0:0

I am having trouble following your description.  What function is calling
scsi_autopm_put_device() here?

>> pm_runtime_put_sync()
>> __pm_runtime_idle()
>> rpm_idle() -- RPM_GET_PUT(4)
>>      __rpm_callback
>>          scsi_runtime_idle()
>>              pm_runtime_mark_last_busy()
>>              pm_runtime_autosuspend()  --[A]
>>                  rpm_suspend() -- RPM_AUTO(8)
>>                      pm_runtime_autosuspend_expiration() use_autosuspend    is false return 0   --- [B]
>>                          __update_runtime_status to RPM_SUSPENDING
>>                      __rpm_callback()
>>                          __rpm_put_suppliers(dev, false)
>>                      __update_runtime_status to RPM_SUSPENDED
>>                  rpm_suspend_suppliers()
>>                      rpm_idle() for supplier -- RPM_ASYNC(1) return (-EAGAIN) [ Other consumer active for supplier]
>>                  rpm_suspend() – END with return=0
>>          scsi_runtime_idle() END return (-EBUSY) always.

Not following here either.  Which device is EBUSY and why?

>>       /* Do that if resume fails too.*/
>>      (dev->power.runtime_status == RPM_RESUMING && retval)))  return -EBUSY
>>          __rpm_put_suppliers(dev, false)  -- [C]
>> rpm_idle() END return -EBUSY
>>
>> Process -2
>> sd_probe context (Process 2)
>> scsi_autopm_get_device() //0:0:0:0
>> __pm_runtime_resume(RPM_GET_PUT)
>> rpm_resume() -- RPM_GET_PUT(4)
>>      __update_runtime_status to RPM_RESUMING --[D]
>>      __rpm_callback()
>>          rpm_get_suppliers()
>>              __pm_runtime_resume() - RPM_GET_PUT(4) – supplier
>>                  rpm_resume() for supplier.
>>      __update_runtime_status to RPM_ACTIVE
>>      pm_runtime_mark_last_busy ()
>> rpm_resume() END return 0
>>
>> Can you please provide your suggestions on addressing above race condition?
>>
>> This is also reported at [2].
>>
>> [1]: https://lore.kernel.org/lkml/4748074.GXAFRqVoOG@kreacher/T/
>> [2]: https://lkml.org/lkml/2022/10/12/259
>>
>> Thanks,
>> Tushar Nimkar

