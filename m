Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5258C65DAD8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbjADQ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240403AbjADQ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:57:26 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3C713CCF;
        Wed,  4 Jan 2023 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672851336; x=1704387336;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9M4xV21Pk9We3A7X02xZcAVZ8pYRkx8urRXNfwjIpDw=;
  b=hA5lbl8lAcIlGQuAX621evWoVdP+QZamrpD5szx/AMbHP7hJGwua7wlp
   7WHqeggQsl+8++AHNMuYgnQDic9jOrbLpnBWCZBhUubBkPMqbkDJyqL7x
   S11UQvieFxzwyEfVfBROI65UtBDjblioxjB9jLSchyV/qpwnyU4s0Kki2
   uKeF5nD8FBcUFsNmTZBaMsGcoVwYTNGpFiP4ZdUg5OhCPqmreHN1oDJ6q
   uTo6nKjayEpoU46xmmQiMy5l3eCkw0Z7kJEr35+1FmBfB/plItUsvc5WV
   zovUOIJmI+XaouM3l0BYLyURHCpKMF/+dBB2WeI4xHfGA8fC6b65+k1M/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="349204673"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="349204673"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 08:55:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="743922587"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="743922587"
Received: from cheungbr-mobl.amr.corp.intel.com (HELO [10.209.91.155]) ([10.209.91.155])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 08:55:15 -0800
Message-ID: <25d07838-3904-a086-4238-f56c9424b53a@intel.com>
Date:   Wed, 4 Jan 2023 08:55:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, peterz@infradead.org
Cc:     mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@linux.intel.com
References: <20230104145831.25498-1-rui.zhang@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230104145831.25498-1-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/23 06:58, Zhang Rui wrote:
> @@ -807,6 +807,8 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&model_skl),
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&model_skl),
>  	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&model_skl),
> +	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&model_skl),
> +	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&model_skl),
>  	{},
>  };

Any chance this will ever get architectural enumeration?  Or, are we
doomed to grow this model list until the end of time?
