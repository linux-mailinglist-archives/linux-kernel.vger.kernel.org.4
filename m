Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3395870CB1C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjEVUdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjEVUdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:33:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB4994
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684787614; x=1716323614;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nx56cbf63OXaAUSBYAnLL+ze08ugHBspK4d6BmMPYso=;
  b=ErcmfpzhBRHj7mT8wG0vIoPYcdDH3GbZfG4KbPndKz780MpzFNOx7eRG
   59rksMpS0ft4BO5Tu/hjIcqUojkf7L0rwBGOHGaPA5I7YLZLR9GA+JLNi
   D6s7IPv8tCY3FCav13yFSdQBBEw/lE4Qx2hpyUdTuG1tnv3y/Y0GJMB+p
   eYScPI5CFPc1f1DMviW+B6domlDq/WFF1VGkBXMFBrwnwraF3WhOKOTOt
   X2VNLJG4kB8eGur169eX1fzjKKMQu2pL4vXnAQUSTLSY118MficQldmu6
   NA7t2DAFHUShRQYib9WjbnEqdLxrjWrFz2eVc3JgZHwlp5Jgcqb7a2Nto
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="439389508"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="439389508"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 13:33:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="1033750097"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="1033750097"
Received: from avelapox-mobl.amr.corp.intel.com ([10.212.71.122])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 13:33:16 -0700
Message-ID: <ffc0ebdded5e8ec3a00c07347f17f1b78640324f.camel@linux.intel.com>
Subject: Re: [PATCH -next] ASoC: SOF: ipc4-topology: Fix an unsigned
 comparison which can never be negative
From:   Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, perex@perex.cz
Cc:     tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, daniel.baluta@nxp.com,
        kai.vehmanen@linux.intel.com, broonie@kernel.org,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Date:   Mon, 22 May 2023 13:33:16 -0700
In-Reply-To: <20230516081116.71370-1-yang.lee@linux.alibaba.com>
References: <20230516081116.71370-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-16 at 16:11 +0800, Yang Li wrote:
> The return value from the call to sof_ipc4_get_valid_bits() is int.
> However, the return value is being assigned to an unsigned
> int variable 'out_ref_valid_bits', so making it an int.
> 
> Eliminate the following warning:
> ./sound/soc/sof/ipc4-topology.c:1537:6-24: WARNING: Unsigned
> expression compared with zero: out_ref_valid_bits < 0
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4985
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

LGTM, thanks!
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

