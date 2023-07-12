Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1884E74FD40
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjGLCnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjGLCnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:43:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD0771BE8;
        Tue, 11 Jul 2023 19:43:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A4872F4;
        Tue, 11 Jul 2023 19:43:35 -0700 (PDT)
Received: from [10.162.42.6] (unknown [10.162.42.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F1D93F73F;
        Tue, 11 Jul 2023 19:42:47 -0700 (PDT)
Message-ID: <b234c859-75f4-ca3d-eee6-17af7680365d@arm.com>
Date:   Wed, 12 Jul 2023 08:12:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V13 - RESEND 06/10] arm64/perf: Enable branch stack events
 via FEAT_BRBE
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
 <20230711082455.215983-7-anshuman.khandual@arm.com>
 <cde1fd99-04ae-f604-a5d0-5af3ddf57f7d@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <cde1fd99-04ae-f604-a5d0-5af3ddf57f7d@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/23 00:56, Randy Dunlap wrote:
> Hi--
> 
> On 7/11/23 01:24, Anshuman Khandual wrote:
>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>> index f4572a5cca72..7c8448051741 100644
>> --- a/drivers/perf/Kconfig
>> +++ b/drivers/perf/Kconfig
>> @@ -180,6 +180,17 @@ config ARM_SPE_PMU
>>  	  Extension, which provides periodic sampling of operations in
>>  	  the CPU pipeline and reports this via the perf AUX interface.
>>  
>> +config ARM64_BRBE
>> +	bool "Enable support for Branch Record Buffer Extension (BRBE)"
>> +	depends on PERF_EVENTS && ARM64 && ARM_PMU
>> +	default y
>> +	help
>> +	  Enable perf support for Branch Record Buffer Extension (BRBE) which
>> +	  records all branches taken in an execution path. This supports some
>> +	  branch types and privilege based filtering. It captured additional
> 
> preferably:
> 	                                                 captures

Agreed, will change.

> 
>> +	  relevant information such as cycle count, misprediction and branch
>> +	  type, branch privilege level etc.
> 
