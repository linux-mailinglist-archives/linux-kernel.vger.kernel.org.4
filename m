Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9F55B6DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiIMNGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiIMNGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:06:40 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35791FCCD;
        Tue, 13 Sep 2022 06:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663074400; x=1694610400;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=BykdxPFWKamfb0oV6qvLgKDHPSq/P2Bpyfv/MiGBYsM=;
  b=mcxfcp1Uw0ty3x3tFhBqudcV4jDP7FvvU3YH6LJT+oSjO1MOQ9Iu1Dim
   D+6dJNwVUJoc2l07vPJ0DNhAngOJ4yHajmKIFZRVWDmI9hq1okdJpRGtW
   RDSTcu316hBAy9HcJqH1BdDQpa/S0bMEuoJ61m3kgqk/DVZo1Zf+aDWz/
   4=;
Subject: Re: [PATCH v5 20/21] hwmon: (mr75203) add debugfs to read and write
 temperature coefficients
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-8be8ed69.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 13:06:28 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-8be8ed69.us-east-1.amazon.com (Postfix) with ESMTPS id 72C3AC085A;
        Tue, 13 Sep 2022 13:06:25 +0000 (UTC)
Received: from EX19D013UWA002.ant.amazon.com (10.13.138.210) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Tue, 13 Sep 2022 13:06:24 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D013UWA002.ant.amazon.com (10.13.138.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Tue, 13 Sep 2022 13:06:24 +0000
Received: from [192.168.151.102] (10.85.143.178) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Tue, 13 Sep 2022 13:06:21 +0000
Message-ID: <581a4a0b-8e0e-b7a2-f873-77ed74b54e96@amazon.com>
Date:   Tue, 13 Sep 2022 16:06:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, "Farber, Eliav" <farbere@amazon.com>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-21-farbere@amazon.com>
 <YxowTBIODMLjf1Ek@smile.fi.intel.com>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <YxowTBIODMLjf1Ek@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/2022 9:11 PM, Andy Shevchenko wrote:
> On Thu, Sep 08, 2022 at 03:24:48PM +0000, Eliav Farber wrote:
>> This change adds debugfs to read and write temperature sensor 
>> coefficients
>> - g, h, j and cal5.
>>
>> The coefficients can vary between product and product, so it can be very
>> useful to be able to modify them on the fly during the calibration
>> process.
>>
>> e.g.:
>>
>> cat /sys/kernel/debug/940f23d0000.pvt/ts_coeff_cal5
>> 4096
>>
>> echo 83000 > sys/kernel/debug/940f23d0000.pvt/ts_coeff_g
>
> ...
>
>> - Return j coefficient to use debugfs_create_file() instead of
>>   debugfs_create_u32() because j is signed.
>
> You can use
>
> DEFINE_DEBUGFS_ATTRIBUTE(ts_coeff_j, ts_coeff_j_get, ts_coeff_j_set, 
> "%lld\n");
>
> which still makes code compact. 


I tried your suggestion to use DEFINE_DEBUGFS_ATTRIBUTE but I can't set
j to be a negative value:

root@alpine:~# cat /sys/kernel/debug/940f23d0000.pvt/ts_coeff_j
0
root@alpine:~# echo 100 > /sys/kernel/debug/940f23d0000.pvt/ts_coeff_j
root@alpine:~# cat /sys/kernel/debug/940f23d0000.pvt/ts_coeff_j
100
root@alpine:~# echo -100 > /sys/kernel/debug/940f23d0000.pvt/ts_coeff_j
sh: write error: Invalid argument

This is the code I added:

static int ts_coeff_j_set(void *data, u64 val)
{
     struct pvt_device *pvt = data;

     pvt->ts_coeff.j = val;
     return 0;
}

static int ts_coeff_j_get(void *data, u64 *val)
{
     struct pvt_device *pvt = data;

     *val = pvt->ts_coeff.j;
     return 0;
}

DEFINE_DEBUGFS_ATTRIBUTE(ts_coeff_j_fops, ts_coeff_j_get,
              ts_coeff_j_set, "%lld\n");

static void devm_pvt_ts_dbgfs_remove(void *data)
{
     struct pvt_device *pvt = (struct pvt_device *)data;

     debugfs_remove_recursive(pvt->dbgfs_dir);
     pvt->dbgfs_dir = NULL;
}

static int pvt_ts_dbgfs_create(struct pvt_device *pvt, struct device *dev)
{
     ...
     debugfs_create_file("ts_coeff_j", 0644, pvt->dbgfs_dir, pvt,
                 &ts_coeff_j_fops);
     ...

I'm using kernel 5.10.112.
Can you please see if I'm did anything wrong?

--
Thanks, Eliav

