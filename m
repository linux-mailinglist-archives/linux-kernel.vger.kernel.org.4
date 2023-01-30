Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B776816C7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbjA3QqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbjA3Qpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:45:55 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F8E3D0AE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675097155; x=1706633155;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9zSXS+O/50vqmmTlNQH8/vfvi/eXbxp8sMusT3tI+u8=;
  b=MHGSyhskmEpTHwIxs0A+1R/nje7c6hZ+i8zG/hkNzY9ocf97Ke5MHB7l
   I70zcbTPuPP3CWzb7IS3wlis/4jyf1Cv8ScfAKGWpR1nupLmhyaCWMAuG
   JLJzs/ZgHG0eoMg6cOAluRC8TnCD6wp2QxJQsYJHRMtafWxV/s6BFCiU2
   1QIGXdQ8nh/JE/s+/Mj25G7N/K8LlwnqAPlm44cQYYGX72DSyyfnOiQrf
   Tsp7n52vvtMDLZc7SzwE+gLNaE2zCrLLUlJmudWpmVQy22dhcryJvRgeP
   Lu7xxIcF6ki7r7JoDOyxnWAEN8cJweSjH2RV6peY7eWh8V5momLnIaZLm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="307260876"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="307260876"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:45:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="732763634"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="732763634"
Received: from inuber-mobl5.amr.corp.intel.com (HELO [10.212.58.60]) ([10.212.58.60])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:45:53 -0800
Message-ID: <1e5e1312-18f5-e70f-3237-c2ffc851eef7@linux.intel.com>
Date:   Mon, 30 Jan 2023 10:45:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v3 8/8] ASoC: cs42l42: Wait for debounce interval after
 resume
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
 <20230127165111.3010960-9-sbinding@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230127165111.3010960-9-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/23 10:51, Stefan Binding wrote:
> Since clock stop causes bus reset on Intel controllers, we need

nit-pick: It's more that the Intel controller has a power optimization
where the context is lost when stopping the clock, which requires a bus
reset and full re-enumeration/initialization when the clock resumes.

The rest of the patch is fine so

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> to wait for the debounce interval on resume, to ensure all the
> interrupt status registers are set correctly.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
