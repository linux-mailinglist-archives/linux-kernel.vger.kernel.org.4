Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBEA640BD8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiLBRLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiLBRLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:11:04 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECF9E51F5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670001063; x=1701537063;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1IRzqlMUWV5VXnaiNn611U+VEGSXJ4pseArlJj71lP0=;
  b=KnuJvQDwd2beX6gkYbJ5/G3jWU2GNkXwy8k0mX7dzrC1OyisdazgbhwE
   4WhEIFeymxjq5vs1ERDyL2Yj+jgA/7QMa4eDA0XzPJZmG6u0+xveM93oC
   TNLDBLqoRJK346VWhcUkhHUDdQHVNcbg/nN/kuRxGNarfREKh9J3IvbDw
   xfnXJHEqXGWscf1XuzajS6ykY2WZt8/vjvvO8FeqMPKEdDG/S3y8c4fzg
   AY8j69rtyPPwb1rw4W7RCO5/5bNvVes8pT+h8pjA/UlxtXgpxSYBRAGHE
   yAsZRtPO68k4OpmNrmXL/FhGN/xvqQAY9spGgBk9M7BDker7lWT2/Iwon
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="380286133"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="380286133"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 09:11:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="645091238"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="645091238"
Received: from ofaiz-mobl1.amr.corp.intel.com (HELO [10.212.59.186]) ([10.212.59.186])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 09:11:02 -0800
Message-ID: <4da03ca3-55b7-5c68-e424-ff23acb9cd0e@linux.intel.com>
Date:   Fri, 2 Dec 2022 11:10:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/3] soundwire: cadence: Fix oversized FIFO size define
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com
References: <20221202161812.4186897-1-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221202161812.4186897-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/2/22 10:18, Richard Fitzgerald wrote:
> As determined by experimentation and asking a hardware person, the FIFO
> in the Cadence IP is actually only 8 entries long, not 32. This is fixed
> in patch #1.
> 
> As a bonus, patches #2 and #3 fix two other things I noticed while
> debugging this.
> 
> Changes since v1:
> - Rewrite commit message of patch #1
> - Only reduce response_buf to 34 (32 + 2)
> - Trim RX_FIFO_AVAIL to length of response_buf instead of expected
>   FIFO size

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> Richard Fitzgerald (3):
>   soundwire: cadence: Don't overflow the command FIFOs
>   soundwire: cadence: Remove wasted space in response_buf
>   soundwire: cadence: Drain the RX FIFO after an IO timeout
> 
>  drivers/soundwire/cadence_master.c | 46 +++++++++++++++++++-----------
>  drivers/soundwire/cadence_master.h | 13 ++++++++-
>  2 files changed, 41 insertions(+), 18 deletions(-)
> 
