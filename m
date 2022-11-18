Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3F062F2F5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241632AbiKRKro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241569AbiKRKri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:47:38 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F821326F3;
        Fri, 18 Nov 2022 02:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668768457; x=1700304457;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LZLmUknSd1/aIfUwWzdJ0VDIOATUMOVkhWKDwKyeJuA=;
  b=V++wbEwMv4nIeYmHAwlmzWVRMNpiWXZgD1SboDeEFJSl/Mv6ttfwVqDM
   7k1xNTjoMTGk2p8pqOL5UCuigIUefihfH0ux/UFksJdh6+m1ms/RfGX9R
   8IDTM3ueTH7UgxKXwbYEzaGVSA02/ZxyeNUOBbzSt3pxW97FUsbTjZk/A
   /n72S3Jfev2hkiw1gIpb5FTRGnZKWRriDWBjrF/t90cw1Yb659GmZaf/x
   ibHtdzPC1BfIy7OKz7hwcc5mKqlIG9fGnUxKcwXA7HV0cWkkP9cRHBZl9
   DlthzfJWOUaS5ubZdJuz8y/BOyqNYZ5IYrUKv4XLqHJ8VIZXU91jkYxHS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="293500091"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="293500091"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 02:47:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="782605566"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="782605566"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.138])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 02:47:34 -0800
Message-ID: <c1e1281e-0977-cbf7-041e-db911ee722a7@intel.com>
Date:   Fri, 18 Nov 2022 12:47:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH 0/3] mmc: Improve block layer requeueing behavior
Content-Language: en-US
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>
References: <f30ec7fe7d834c1d8e116508500110cf@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <f30ec7fe7d834c1d8e116508500110cf@hyperstone.com>
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

On 26/10/22 10:30, Christian Löhle wrote:
> Mmcblk relies on block layer requeueing to fulfill some requests under
> certain conditions. Improve the handling to get nicely ordered requests.
> 
> Using the terms a bit loosely to get a point across:
> Current behavior for 512 blksz and max_blk_count = 1 the scenario would
> be as follows:
> 
> - request for page 0 lba 0 to 7
> - request for page 1 lba 8 to 15
> - request for page 2 lba 16 to 23
> - request for page 3 lba 24 to 31
> 
> mmcblk modifies data->blocks = 1 for each and requeues,
> this leads to:
> 
> Access lba 0
> Access lba 8
> Access lba 16
> Access lba 24
> Access lba 1 (1. Requeue for page 0)
> Access lba 9 (1. Requeue for page 1)
> Access lba 17 (1. Requeue for page 2)
> Access lba 25 (1. Requeue for page 3)
> Access lba 2 (2. Requeue for page 0)
> ...
> 
> Of course we would rather have lbas consecutive.

Does anyone know why the block layer does not support
(max_hw_sectors << 9) < PAGE_SIZE ?

