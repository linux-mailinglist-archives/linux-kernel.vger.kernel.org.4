Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0566632D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiKUTmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKUTmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:42:47 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2673FD116;
        Mon, 21 Nov 2022 11:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669059767; x=1700595767;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hWmAqluuQ5/3puqN3B6aykKHCk3Z+rkcmnnsHtMfROk=;
  b=GXh6CtHT8xbLYvhFkj7CLYbd1UsdAY8igpNiazeCowXsnsyXTQwxzFrf
   tqBVJUq6NmdHnz+mCMk04xL/X0xyziXoifr+0lhGJQ45zaCD6tKK+hIH+
   z6EyjsxzTNJIRodojbOS2JL+WS8i46kfmwlKMfKWbgmSmC9yb82Cb01oL
   e+ymKjFQB1Ob6CvUkSnJ20IzVTdsKPgXR5h/mFkf7r0sR5sLQypq0Zjj9
   hLvC9KlYIyiKQrglWwyXCeedVLlpY2L9yu4Ki7jllgM/q7apJaCO0BFZr
   iJCqSTBrNPmEAiQIclXillKSDyx78iNVJWMHek4ZWW6WV2Ay/xOHVo/tA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="297004546"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="297004546"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 11:42:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672211423"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="672211423"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 11:42:43 -0800
Message-ID: <1c9b3db6-3443-5580-08f2-42520d6a3318@intel.com>
Date:   Mon, 21 Nov 2022 21:42:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH 0/3] mmc: Improve block layer requeueing behavior
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>
References: <f30ec7fe7d834c1d8e116508500110cf@hyperstone.com>
 <c1e1281e-0977-cbf7-041e-db911ee722a7@intel.com>
 <d1a1340a-f5f8-6953-e066-b8c6095d63fd@acm.org>
 <5df2c4d5-f426-e3ea-8e6d-f772ec7091b6@intel.com>
 <bade026a-ec83-7516-d5ef-bb373df48a6e@acm.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <bade026a-ec83-7516-d5ef-bb373df48a6e@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/22 21:14, Bart Van Assche wrote:
> On 11/21/22 00:25, Adrian Hunter wrote:
>> On 18/11/22 19:27, Bart Van Assche wrote:
>>> On 11/18/22 02:47, Adrian Hunter wrote:
>>>> Does anyone know why the block layer does not support
>>>> (max_hw_sectors << 9) < PAGE_SIZE ?
>>>
>>> Does this mean that the following patch series would not only be
>>> useful for UFS but also for MMC? "[PATCH 00/10] Support DMA segments
>>> smaller than the page size"
>>> (https://lore.kernel.org/linux-block/20221019222324.362705-1-bvanassche@acm.org/).
>>
>> That patchset still does not allow max_hw_sectors = 1 which is
>> what Christian's case needs.
> 
> Hi Adrian,
> 
> Why would that patch series not support max_hw_sectors = 1? What am I overlooking?

blk_queue_max_hw_sectors() does not allow it.

