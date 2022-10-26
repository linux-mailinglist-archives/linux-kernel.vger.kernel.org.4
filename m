Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DF160E3B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiJZOs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiJZOsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:48:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDA8119BD7;
        Wed, 26 Oct 2022 07:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666795701; x=1698331701;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fLSv77D7+BpnQGBb1c2MahawwzWfUMVmEmx2oaf4MA8=;
  b=HR0eL3ha/r3V2+1C1pBXEDkLGaWQZViq8IAXMIegvFGAvJnYT4a8eEsh
   /FAh6ZqYv67mnzvWUEXTSOPAlAnIxfSC1jgSdlGYQBuaAzrF3ek27v7t5
   +Lra1jbqKS9sgZmX9IqITsFAKLD8bna6JEluoBcyCA7yZsuKznQz98Mny
   1aVVtst0gzpo4wC8gMgGfqV//+sxZrdbqUmapzIW/caKY9sROcK0ZXj18
   3cxbTVT2Umvu4ldwVZTdg4nBRV4eqUDushJEFrCdJNoW1/eoNahzbTTxS
   tRRoH9Yvl2oOPhoJUjvmJ2fto4Fu8h+VtopshCJsrSjwRZQg1Uq62VKpa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="287677707"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="287677707"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 07:48:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="609977863"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="609977863"
Received: from gkammela-mobl.amr.corp.intel.com (HELO [10.251.31.245]) ([10.251.31.245])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 07:48:19 -0700
Message-ID: <6fef55d0-5111-bde2-c4c2-8cb5b2794026@linux.intel.com>
Date:   Wed, 26 Oct 2022 07:48:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 2/2] platform/x86/intel: pmc/core: Add Raptor Lake
 support to pmc core driver
To:     Hans de Goede <hdegoede@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, irenic.rajneesh@gmail.com,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
References: <20220912233307.409954-1-gayatri.kammela@linux.intel.com>
 <20220912233307.409954-2-gayatri.kammela@linux.intel.com>
 <3537fa63-9015-c63d-2321-a77062e24d6f@redhat.com>
 <58855ea9-0d89-e17d-349a-657512068663@kernel.org>
 <8957290c-9499-a399-3e4e-e0276caccd65@redhat.com>
Content-Language: en-US
From:   "Kammela, Gayatri" <gayatri.kammela@linux.intel.com>
In-Reply-To: <8957290c-9499-a399-3e4e-e0276caccd65@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/24/2022 2:46 AM, Hans de Goede wrote:
> Hi,
>
> On 10/14/22 09:50, Jiri Slaby wrote:
>> On 19. 09. 22, 13:41, Hans de Goede wrote:
>>
>>> On 9/13/22 00:33, Gayatri Kammela wrote:
>>>> Add Raptor Lake client parts (both RPL and RPL_S) support to pmc core
>>>> driver. Raptor Lake client parts reuse all the Alder Lake PCH IPs.
>>>>
>>>> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
>>>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>> Cc: David Box <david.e.box@intel.com>
>>>> Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
>>>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>>>> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
>>>> ---
>>>> Changes since v1:
>>>> 1) Added a dependency patch- ea902bcc1943f7539200ec464de3f54335588774 :
>>>>    "x86/cpu: Add new Raptor Lake CPU model number".
>>>> 2) Rebased the above patch on v6.0-rc1 with "Acked-by" from Hans and
>>>>    Rajneesh.
>>> I still cannot take this, since patch 1/2 is *already merged* through
>>> another tree, so me cherry-picking it leads to potential conflicts.
>>>
>>> As I have already explained twice you need to submit this upstream
>>> throuh the same tree which has the original merge of patch 1/2.
>> Hi, friendly ping: has this ever happened, Gayatri?
> Since the necessary change are in 6.1-rc1 now, I have merged this
> patch now and I'll include this in the pdx86 fixes pull-req which
> I'm preparing for 6.1-rc3:
>
> Thank you for your patch, I've applied this patch to my review-hans
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
>
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
>
> Regards,
>
> Hans

hi Hans,

Thank you for merging this patch. I was planning on sending this patch 
to combine with other series as this could be dependency. Apologies for 
my late reply. Thank you!

>
