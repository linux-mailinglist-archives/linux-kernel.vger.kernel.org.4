Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC99739DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjFVJu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjFVJul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:50:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997971A4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687426835; x=1718962835;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2NhxX3rdSOywNGKYmhtGB0pRTH8j8R7PfKDrsXNYHAo=;
  b=bqrSq7/kTCNAHdHVjvTbaageZ7rXJAVr/3WRJWZi1MYPOUw9zrsVLqZn
   cdHad3Gm09KArRZ9vezYQ+ZcwkGl8BBsp8kHXE1dOr4RxP/y034R5VpKu
   YokJKnE7f78zZ+6JBS9rJ7u+G8hn/In+ldNMfd0RxW1K7LAMqA4nOA3pB
   Z9VF7MusihKAY0LI3OSnRhqFDw1xrt0cRiI019AwJr5d+gVy/deXngyGF
   mSGRUh+lYxXSofVpbfaURLwxqvzDQq6Yzxn/+Py3bGWXBrLi5F3gok4XL
   6zMzSJRN7KngUbWQrIvZVJX/XIvMsRgMdaltJy0xTJdlfZPGNAwakZ/YC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="390129355"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="390129355"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 02:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="692179249"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="692179249"
Received: from gdoolan-mobl1.ger.corp.intel.com (HELO [10.213.228.155]) ([10.213.228.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 02:40:23 -0700
Message-ID: <b414a7af-7333-498c-55ba-d60ae0a0507c@linux.intel.com>
Date:   Thu, 22 Jun 2023 10:40:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/i915: Replace kmap() with kmap_local_page()
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>, Ira Weiny <ira.weiny@intel.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Fabio <fmdefrancesco@gmail.com>,
        Deepak R Varma <drv@mailo.com>
References: <20230620180759.GA419158@sumitra.com>
 <79e1f37f-3ffa-0195-860b-08cc890d810e@shipmail.org>
 <649326df1b895_1c0dd29486@iweiny-mobl.notmuch>
 <d58c3dfd-e1d5-a8c5-7f0f-295dbf99e91a@shipmail.org>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <d58c3dfd-e1d5-a8c5-7f0f-295dbf99e91a@shipmail.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/06/2023 19:51, Thomas Hellström (Intel) wrote:
> 
> On 6/21/23 18:35, Ira Weiny wrote:
>> Thomas Hellström (Intel) wrote:
>>> I think one thing worth mentioning in the context of this patch is that
>>> IIRC kmap_local_page() will block offlining of the mapping CPU until
>>> kunmap_local(), so while I haven't seen any guidelines around the usage
>>> of this api for long-held mappings, I figure it's wise to keep the
>>> mapping duration short, or at least avoid sleeping with a
>>> kmap_local_page() map active.
>>>
>>> I figured, while page compression is probably to be considered "slow"
>>> it's probably not slow enough to motivate kmap() instead of
>>> kmap_local_page(), but if anyone feels differently, perhaps it should be
>>> considered.
>> What you say is all true.  But remember the mappings are only actually
>> created on a HIGHMEM system.  HIGHMEM systems are increasingly rare.  
>> Also
>> they must suffer such performance issues because there is just no other
>> way around supporting them.
>>
>> Also Sumitra, and our kmap conversion project in general, is focusing on
>> not using kmap* if at all possible.  Thus the reason V1 tried to use
>> page_address().
>>
>> Could we guarantee the i915 driver is excluded from all HIGHMEM systems?
> 
> The i915 maintainers might want to chime in here, but I would say no, we 
> can't, although we don't care much about optimizing for them. Same for 
> the new xe driver.

AFAIK i915 works on such systems so I don't think we can drop support 
just like that. Not sure what the process would be. Perhaps as part of a 
wider kernel deprecation would make most sense.

Regards,

Tvrtko
