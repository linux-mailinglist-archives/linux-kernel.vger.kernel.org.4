Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D8D6BD2D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjCPO77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCPO75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:59:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C59846AA;
        Thu, 16 Mar 2023 07:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678978797; x=1710514797;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gSkBRZP1Batv+iNg2i5f9JFlf1xzYofdNM0e35H6EGQ=;
  b=g4u4SQr1BPv38rykHtFFqrKT6K5PyWoIXgi4IRD4/UBEmYeF0l07GMjo
   W9uRHMQY5cMJDZ0iF8bHzjf2bQoxb5SLDUO7jT2hJS4dI34S7KHyxTAuw
   TRMpXlBroeWdlPNMv5mbezrY8BOVGqv/RfDmznW4n8jG29VYXUj93NHvM
   FIqSPrChAZJVRr7YNbwDFqurZzD4icgbmG21/quu/XWwJxPGnE52MS4sl
   VgiU569d7ur35ft+H7L7zN81sBKyVlgjzOycxqTuHmr1eJRbauCSBu26B
   F0FUtxPpItCXaxrY1eiF0SyzmwbPVQOBTGm2CyM5NikdbMGGJaRIa/EzX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424283965"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="424283965"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 07:59:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="790338783"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="790338783"
Received: from mvalent1-mobl2.amr.corp.intel.com (HELO [10.252.142.240]) ([10.252.142.240])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 07:59:55 -0700
Message-ID: <6f78ecfb-99c8-eee3-cad0-69bbd88a107c@intel.com>
Date:   Thu, 16 Mar 2023 07:59:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] perf/x86/zhaoxin: Add Yongfeng support
Content-Language: en-US
To:     silviazhao <silviazhao-oc@zhaoxin.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     cobechen@zhaoxin.com, louisqi@zhaoxin.com, silviazhao@zhaoxin.com,
        cooperyan@zhaoxin.com
References: <20230316021647.771-1-silviazhao-oc@zhaoxin.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230316021647.771-1-silviazhao-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 19:16, silviazhao wrote:
> +		case 0x5b:
> +			zx_pmon_event_map[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =
> +				X86_CONFIG(.event = 0x02, .umask = 0x01, .inv = 0x01,
> +						.cmask = 0x01);

On the Intel side of x86/ land, we used to have these open-coded
model/family numbers scattered about.  But, a few years ago, we started
populating arch/x86/include/asm/intel-family.h and using those instead.
I think it's been pretty successful.  It's a lot easier to grep for
INTEL_FAM6_NEHALEM_EX than for 0x2E.

Is there a chance we could start doing the same for other CPU vendors?
Perhaps start with:

#define ZHAOXIN_FAMILY_YONGFENG 0x5B
