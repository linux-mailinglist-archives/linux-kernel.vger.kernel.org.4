Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA396ED16D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjDXPdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjDXPds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:33:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A78187
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682350428; x=1713886428;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q6c/b6JvPvZ05H87DnLBjtNN0boRhEiG0scByVOexKA=;
  b=BpV1mWIWm4GyeCIqzbZ0QaiIrqmBzZysmYON+RJebrMMJIN5xETjr2IV
   gRXOnq2BoIL6K5xc37YMyPjQUc7/VE2y/eD+9jJ9qpLkjaVSshXhsJ9/g
   KcKsOP0+SZQAIsWiecjEcsbdekxd4A8Qf+Q6/cCbxIAo5KPgZRIAI2VBD
   tSaU2/Kyi1UUO2v92VI86x2A+2Y3yDXYCADL5WFviT2RhhkuDH5rjNxFS
   T/GahotNqcnG4E2u5IOV6HKcgcubQ6H4pBLLGkH4l+44GYArmZ4qAnZ8Y
   CKg7gyFU8ZHzPe/hAKuquvs4d9oSLwA3u1+BKep9TS+X2bkqxsAogRK+B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="374432909"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="374432909"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:33:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="817311279"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="817311279"
Received: from sridharn-mobl.amr.corp.intel.com (HELO [10.212.106.191]) ([10.212.106.191])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:33:47 -0700
Message-ID: <9479d2e4-8147-aee2-3a2b-1cd06a4ad4e0@intel.com>
Date:   Mon, 24 Apr 2023 08:33:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH] ntb: hw: intel: remove return value check of
 `ndev_init_debugfs`
To:     Yinhao Hu <dddddd@hust.edu.cn>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230422155634.483023-1-dddddd@hust.edu.cn>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230422155634.483023-1-dddddd@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/23 8:56 AM, Yinhao Hu wrote:
> Smatch complains that:
> ndev_init_debugfs() warn: 'ndev->debugfs_dir' is an error pointer or valid
> 
> Debugfs checks are generally not supposed to be checked for errors
> and it is not necessary here.

Can you please provide source on where this is true?

> 
> Just delete the dead code.
> 
> Signed-off-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> The issue is found by static analysis and remains untested.
> ---
>   drivers/ntb/hw/intel/ntb_hw_gen1.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> index 9ab836d0d4f1..9b0b2c43f1bb 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> @@ -778,13 +778,10 @@ static void ndev_init_debugfs(struct intel_ntb_dev *ndev)
>   		ndev->debugfs_dir =
>   			debugfs_create_dir(pci_name(ndev->ntb.pdev),
>   					   debugfs_dir);
> -		if (!ndev->debugfs_dir)
> -			ndev->debugfs_info = NULL;
> -		else
> -			ndev->debugfs_info =
> -				debugfs_create_file("info", S_IRUSR,
> -						    ndev->debugfs_dir, ndev,
> -						    &intel_ntb_debugfs_info);
> +		ndev->debugfs_info =
> +			debugfs_create_file("info", S_IRUSR,
> +					    ndev->debugfs_dir, ndev,
> +					    &intel_ntb_debugfs_info);
>   	}
>   }
>   
