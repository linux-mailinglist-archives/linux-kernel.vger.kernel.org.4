Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754C560FD2E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbiJ0Qey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiJ0Qeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:34:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D42820F72
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666888488; x=1698424488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ReW4mTL/Qrx5Ie4wYNRyXd3fjjAfU0EotIXdjdbjQJo=;
  b=TiG5/djuNiwXm9UndN9KcIMicSqCLxVD9ZEgVcp2Ve3zA/qCPEHn7bGL
   /TEqM651zPGCQCLNSbv9rd6pghCulApu8o6zAkdUArkAQ1Fa77MzGQziB
   5tEHnYZ8ZKQOY+PPx/q4e24PjggBj4YT8KMDTlB1gDXHBSHKnDgte/z5d
   YJGOy4mhYjXWkVurvY1yvsORfUHa2HrN1Yw0G62S+SQdWtgyxifbak0Ge
   ZOj7/YldmeaVHbHA0HLb2K1IqI/VbyhcJiTSSdPfNDO/wZijAogzvCKzy
   3vUM0OzytpIKVzPGB9Lrpw6B6T7wzWiU7w+Fav2kyMC85uKZXV1d6qgCq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="370339955"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="370339955"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 09:34:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="807513294"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="807513294"
Received: from djohn1-mobl1.amr.corp.intel.com (HELO [10.212.54.86]) ([10.212.54.86])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 09:34:46 -0700
Message-ID: <f8fd25fc-a866-fcee-8bd3-9281bb328900@linux.intel.com>
Date:   Thu, 27 Oct 2022 12:34:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [BUG][v6.1-rc2] [SOF] max98373 i2c-MX98373:00: Runtime PM usage
 count underflow!
To:     Lukasz Majczak <lma@semihalf.com>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, upstream@semihalf.com,
        Curtis Malainey <cujomalainey@google.com>,
        Takashi Iwai <tiwai@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <CAFJ_xbqwaOQ+NVbVuT-TqTJ5fcp6fvVfaUxxwLW1FLZDCjrAxQ@mail.gmail.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAFJ_xbqwaOQ+NVbVuT-TqTJ5fcp6fvVfaUxxwLW1FLZDCjrAxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/22 12:12, Lukasz Majczak wrote:
> Hi,
> 
> I have noticed Runtime PM usage count underflow on my Chromebook (12th
> Gen Intel(R) Core(TM) i3-1215U) running vanilla v6.1-rc2:
> 
> [    7.558178] max98373 i2c-MX98373:00: Runtime PM usage count underflow!
> [    7.558188] max98373 i2c-MX98373:01: Runtime PM usage count underflow!
> [    7.558206] snd-soc-dummy snd-soc-dummy: Runtime PM usage count underflow!
> [    7.558421] snd-soc-dummy snd-soc-dummy: Runtime PM usage count underflow!
> 
> Link to the full dmesg:
> https://gist.github.com/semihalf-majczak-lukasz/d6a6d61d5937f762a524ed50fed93f25

You need to apply this:

[PATCH] Revert "ASoC: soc-component: using pm_runtime_resume_and_get
instead of pm_runtime_get_sync"
