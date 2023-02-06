Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95D168B8F6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBFJtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBFJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:49:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0289A1EFEC;
        Mon,  6 Feb 2023 01:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675676993; x=1707212993;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cPNOF/KGCNTaTD7ws/KG8t6ZmILIczV7qBsWBv38hkM=;
  b=P3qKHrDZbRqvt3QPkBUhNIQ/y53SNrRCzHtbxv87UfPpvQk1ntE8ZVpy
   jy/q/lOTp5A/uPB9HXFkJSiE+D3SzbJZCuS8zx6f8vtFv8sD8QDsr+y5S
   YVdIfLfUlCWXKVSDiltT8uN+Q/blanbQbt5XSsP7iOdFQCRqt9IeDTXtH
   1Ea5hSuRiM87eesnL18ce9iNuir7wtb9Bvo22w2MxJn1ZcYfJLCXFZ3o5
   8qckRADuGSbwVUPyc63JfV5/DIqoZwy26w8ASzQyYvgJ4zWpHlCs5kVXa
   xgLIo6Ie04Rtdyztu5SQ6tgI1NM8Rh5TvRhE/O3xSQhbDcociijwVeKuh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="356525695"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="356525695"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 01:49:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="696815786"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="696815786"
Received: from zhoufuro-mobl.ccr.corp.intel.com (HELO [10.249.168.28]) ([10.249.168.28])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 01:49:47 -0800
Message-ID: <cd6bd118-68ef-1742-fd9d-08a65872b02c@linux.intel.com>
Date:   Mon, 6 Feb 2023 17:49:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCHv2 2/4] wiegand: add Wiegand bus driver
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Za=c5=a5ovi=c4=8d?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, martin.petersen@oracle.com,
        beanhuo@micron.com, arnd@arndb.de, avri.altman@wdc.com,
        iwona.winiarska@intel.com, fmdefrancesco@gmail.com,
        dipenp@nvidia.com, ogabbay@kernel.org, bvanassche@acm.org,
        mathieu.poirier@linaro.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, Greg KH <gregkh@linuxfoundation.org>
References: <20230202143305.21789-1-m.zatovic1@gmail.com>
 <20230202143305.21789-3-m.zatovic1@gmail.com> <Y9ynYmIhygqp3U5u@kroah.com>
From:   Zhou Furong <furong.zhou@linux.intel.com>
In-Reply-To: <Y9ynYmIhygqp3U5u@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/wiegand.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/property.h>
>> +

please order headers
