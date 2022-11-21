Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E1631B52
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiKUIZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKUIZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:25:52 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A496563FB;
        Mon, 21 Nov 2022 00:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669019151; x=1700555151;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tRC91gf0tMNQxTUnM2kVX03iZwsnDeqc3G8jXCJ98P4=;
  b=FTJoKZdYqC73wBb5/oFkoikhGuAFAu1DDJfA0ljAXI6KQeSoeiCUWW/C
   IH3b6HJhZiXpkM0kZ750gAvu1J4g3919b8XqB9OVcdrTyPP7Bx4xJcbIx
   oB1VLt/bUIAUP/XCoa4R93VMK0k9xNGjjJzt++RAYvZ/es1MFu/xGtSv9
   HIMpt1TSnCAJkASjTCyC42GyHcC2ID42BqpK9WGQREPzgEv5ezESv2qL8
   wzWtLobjjnTVTdkBismYbCLaJzsI6xd5S+H+I3h7EGXBVNKF0iJgW3CWp
   0+v+1undo/S+5F0FGgRBr5zKKshBztdXhV0rCw2HXxVqfGsmccJYFSAOA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="301046507"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="301046507"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 00:25:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="635104678"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="635104678"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 00:25:48 -0800
Message-ID: <5df2c4d5-f426-e3ea-8e6d-f772ec7091b6@intel.com>
Date:   Mon, 21 Nov 2022 10:25:44 +0200
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <d1a1340a-f5f8-6953-e066-b8c6095d63fd@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/22 19:27, Bart Van Assche wrote:
> On 11/18/22 02:47, Adrian Hunter wrote:
>> On 26/10/22 10:30, Christian Löhle wrote:
>>> Mmcblk relies on block layer requeueing to fulfill some requests under
>>> certain conditions. Improve the handling to get nicely ordered requests.
>>>
>>> Using the terms a bit loosely to get a point across:
>>> Current behavior for 512 blksz and max_blk_count = 1 the scenario would
>>> be as follows:
>>>
>>> - request for page 0 lba 0 to 7
>>> - request for page 1 lba 8 to 15
>>> - request for page 2 lba 16 to 23
>>> - request for page 3 lba 24 to 31
>>>
>>> mmcblk modifies data->blocks = 1 for each and requeues,
>>> this leads to:
>>>
>>> Access lba 0
>>> Access lba 8
>>> Access lba 16
>>> Access lba 24
>>> Access lba 1 (1. Requeue for page 0)
>>> Access lba 9 (1. Requeue for page 1)
>>> Access lba 17 (1. Requeue for page 2)
>>> Access lba 25 (1. Requeue for page 3)
>>> Access lba 2 (2. Requeue for page 0)
>>> ...
>>>
>>> Of course we would rather have lbas consecutive.
>>
>> Does anyone know why the block layer does not support
>> (max_hw_sectors << 9) < PAGE_SIZE ?
> 
> Hi Adrian,
> 
> Does this mean that the following patch series would not only be
> useful for UFS but also for MMC? "[PATCH 00/10] Support DMA segments
> smaller than the page size"
> (https://lore.kernel.org/linux-block/20221019222324.362705-1-bvanassche@acm.org/).

That patchset still does not allow max_hw_sectors = 1 which is
what Christian's case needs.

