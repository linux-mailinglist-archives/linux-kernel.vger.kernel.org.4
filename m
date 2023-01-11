Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3137766510C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 02:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjAKBUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 20:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbjAKBUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 20:20:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D3D6426
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 17:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673400021; x=1704936021;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=akataVV8/0DapSMoYhbnfdEzhpmfzhdfJCigD6PWqj0=;
  b=bRB1Q/1uyX3cdLdG/YHaUaSWgTNVHL42LResWvBd0fO3DsaeJIEk0vgH
   lj5XECVdDtRPwPLXlLqqi4eABuh3hVy5BpQl6Iv8iTtZNBh3iVRvsUJ7v
   4SLrykqM+kaBDFYQjK3jg2IFxgVACSfykeCUktu5gLUIBBtk+kDmWKQty
   3BMnrRUNYvwd+zBAb3FwdxYurTthUewMiupOpzKTLs1qx3WDCzWQBc3Hi
   9AZJQx/MC/qcot33VNYCzSXdQ1tPFN9fx14OKo2f5l/vbCobYhN5KdqDd
   Ph3uqQsAxzoa/msU7gYaQ72/mkpBJj7nHfhsBaz4gEh/6dn5RQWTcYv4E
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="409538743"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="409538743"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 17:20:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="689612544"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="689612544"
Received: from bphilli1-mobl1.amr.corp.intel.com (HELO [10.209.156.204]) ([10.209.156.204])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 17:20:08 -0800
Message-ID: <edde76c0-a444-1c3a-3541-af79897701fa@linux.intel.com>
Date:   Tue, 10 Jan 2023 19:20:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/6] ASoC: Intel: bytcht_es8316: Drop reference count
 of ACPI device after use
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20230102203014.16041-1-andriy.shevchenko@linux.intel.com>
 <20230102203014.16041-2-andriy.shevchenko@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230102203014.16041-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/2/23 14:30, Andy Shevchenko wrote:
> Theoretically the device might gone if its reference count drops to 0.
> This might be the case when we try to find the first physical node of
> the ACPI device. We need to keep reference to it until we get a result
> of the above mentioned call. Refactor the code to drop the reference
> count at the correct place.
> 
> While at it, move to acpi_dev_put() as symmetrical call to the
> acpi_dev_get_first_match_dev().
> 
> Fixes: 3c22a73fb873 ("ASoC: Intel: bytcht_es8316: fix HID handling")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

How do we proceed for this patchset? I am happy to ack a v2 if Andy
splits the AMD and Intel patches w/ a cover letter, but this could also
be added directly if there is no objection.
