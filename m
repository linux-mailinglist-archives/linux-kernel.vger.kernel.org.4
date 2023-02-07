Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DD668CB45
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 01:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjBGAg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 19:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGAg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 19:36:57 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948A9166C5;
        Mon,  6 Feb 2023 16:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675730216; x=1707266216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R+jmyc8Yo+yZhgpXm5gP0gSlIk1nuY366JOKTziSiOQ=;
  b=nctibp8mXPoL+mwAjFvBQ4ppbtm4ReUKZEZIUJNM85cmxQCVXA9dptIh
   oCjD+8u9pz58+Vfkzj6zyDvjgbeRyxu0k9b0p0w24ZXSHYu76iOIYRg1Q
   QjiqUW6Oj8Fab0FcsOu3lun3hekjc5VpQs1wzBVBWlI09pqimMHA3fohG
   OjxuBYb1D03OBAG6OatMUH3s6pfbNgIDEyNjYYR4XpyVcwOrKito3pUG0
   CW9vcfeJAgScE7S/s/ouxl0Wqrp8Ug1s9NtPa3JfnXHPdF9i6+FUU57EC
   8XbFjEzvJaNZqLLPDqQeDDIbQa5mVbHZPrQxWXovF7FlzjtXO/P6Wc2vr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="309693742"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309693742"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 16:36:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="790605344"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="790605344"
Received: from zhoufuro-mobl.ccr.corp.intel.com (HELO [10.254.211.142]) ([10.254.211.142])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 16:36:50 -0800
Message-ID: <581353bc-cc2c-295b-1f9a-04bcf705261b@linux.intel.com>
Date:   Tue, 7 Feb 2023 08:36:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCHv2 2/4] wiegand: add Wiegand bus driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Martin_Za=c5=a5ovi=c4=8d?= <m.zatovic1@gmail.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, martin.petersen@oracle.com,
        beanhuo@micron.com, arnd@arndb.de, avri.altman@wdc.com,
        iwona.winiarska@intel.com, fmdefrancesco@gmail.com,
        dipenp@nvidia.com, ogabbay@kernel.org, bvanassche@acm.org,
        mathieu.poirier@linaro.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
References: <20230202143305.21789-1-m.zatovic1@gmail.com>
 <20230202143305.21789-3-m.zatovic1@gmail.com> <Y9ynYmIhygqp3U5u@kroah.com>
 <cd6bd118-68ef-1742-fd9d-08a65872b02c@linux.intel.com>
 <Y+DVyPUXBliomobN@kroah.com>
Content-Language: en-US
From:   Zhou Furong <furong.zhou@linux.intel.com>
In-Reply-To: <Y+DVyPUXBliomobN@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/6 18:26, Greg KH wrote:
> On Mon, Feb 06, 2023 at 05:49:44PM +0800, Zhou Furong wrote:
>>
>>>> +
>>>> +#include <linux/device.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/of_device.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/wiegand.h>
>>>> +#include <linux/dma-mapping.h>
>>>> +#include <linux/dmaengine.h>
>>>> +#include <linux/property.h>
>>>> +
>>
>> please order headers
> 
> Why?  What order?  For what gain >

If all header file ordered in alphabet, it will be easy to find if a 
header file has been included or not when header file list is long.
