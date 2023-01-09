Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCA4662933
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjAIPBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjAIPA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:00:56 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A742638B5
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673276454; x=1704812454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r9Y1g26n/Ssg2vcH2HKymnnb0cgq9vA0t781z6vBCYc=;
  b=WE2vuuPe+wGB802RFDaPErF7jyjzQsHXHMky8UMJHbeX2XrvQuSOYzwz
   JE5x44oKifITUwjhf8IVnZL2yenML3LlROKBPXcEcFB56i5ypiXh9uway
   Vqs/Hr+58MkAEoCgDtXU0pKWw+ZrViiS6qYCftXC7ogxERZHfKddP6vUI
   OAymY0dCn9qQpSr3DXD+23OJlSKPZAQO4H08jnZlexTHVD0fEB5BzmaeM
   msA+UZUj06ZVnusU7TjE3hiSiHAivIbaLnpzmm+WfUBJCOAFpRw3bttoz
   9d2+V23Zej3KnLWaUlup8yVtbJqd2NaON+RaBYGNKnxt7Z6n5bwhvSN5f
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350103025"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="350103025"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 07:00:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="799047989"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="799047989"
Received: from lherman-mobl.ger.corp.intel.com (HELO [10.213.209.244]) ([10.213.209.244])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 07:00:51 -0800
Message-ID: <9c86dff0-e7f4-60b9-ed3e-6ad51cacaa01@linux.intel.com>
Date:   Mon, 9 Jan 2023 15:00:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: LOOKS GOOD: Possible regression in drm/i915 driver: memleak
Content-Language: en-US
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        intel-gfx@lists.freedesktop.org
References: <f849cc70-b21f-6476-ba26-08989d1243c2@alu.unizg.hr>
 <05424a5351a847786377a548dba0759917d8046c.camel@linux.intel.com>
 <15ef1bb9-7312-5d98-8bf0-0af1a37cfd2a@linux.intel.com>
 <619bdecc-cf87-60a4-f50d-836f4c073ea7@alu.unizg.hr>
 <8e080674-36ab-9260-046e-f4e3c931a3b9@alu.unizg.hr>
 <96661293-32d7-0bb4-fb0e-28086eaaecc3@linux.intel.com>
 <edab9da6-df81-7167-acdd-f2ea22c7ed90@alu.unizg.hr>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <edab9da6-df81-7167-acdd-f2ea22c7ed90@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/12/2022 22:48, Mirsad Goran Todorovac wrote:
> On 22. 12. 2022. 09:04, Tvrtko Ursulin wrote:
>>
>> In the meantime definitely thanks a lot for testing this quickly and 
>> reporting back!
> 
> Don't think much of it - anyone with CONFIG_KMEMLEAK enabled could have 
> caught this bug.
> 
> I was surprised that you found the fix in less than an hour without me 
> having to bisect :)

Fix sadly has a problem handling shared buffers so different version 
will hopefully appear soon.

Regards,

Tvrtko
