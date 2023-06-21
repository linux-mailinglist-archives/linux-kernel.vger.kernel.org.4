Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F85738F33
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjFUSvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFUSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:51:49 -0400
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C25199B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:51:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id C1BC03F338;
        Wed, 21 Jun 2023 20:51:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.201
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ste-pvt-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3-gXWQQZVyex; Wed, 21 Jun 2023 20:51:42 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 774123F23E;
        Wed, 21 Jun 2023 20:51:40 +0200 (CEST)
Received: from [192.168.0.209] (unknown [134.191.232.81])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 9061E3631FC;
        Wed, 21 Jun 2023 20:51:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1687373500; bh=UZ9dLzxvn9rMplig/F09sFuaqVn4QOtCtPf3MFkS8iM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=efkLibh8YRkRPojkYXPtoahK5+L9pTTxJFwWFY/E5z1KuLwVRIS1Ol/XayUG0SLw2
         4kPzN99a7iL/03cbcnusyeI7k9kWmZxSVsWPX00sJFSDsfVQ75/eolEVNOYBghgITU
         w+jgT8AhXHit/waEfolM1s4THtiLY3ETUGSMXvFU=
Message-ID: <d58c3dfd-e1d5-a8c5-7f0f-295dbf99e91a@shipmail.org>
Date:   Wed, 21 Jun 2023 20:51:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v2] drm/i915: Replace kmap() with kmap_local_page()
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Fabio <fmdefrancesco@gmail.com>,
        Deepak R Varma <drv@mailo.com>
References: <20230620180759.GA419158@sumitra.com>
 <79e1f37f-3ffa-0195-860b-08cc890d810e@shipmail.org>
 <649326df1b895_1c0dd29486@iweiny-mobl.notmuch>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
In-Reply-To: <649326df1b895_1c0dd29486@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/21/23 18:35, Ira Weiny wrote:
> Thomas Hellström (Intel) wrote:
>> I think one thing worth mentioning in the context of this patch is that
>> IIRC kmap_local_page() will block offlining of the mapping CPU until
>> kunmap_local(), so while I haven't seen any guidelines around the usage
>> of this api for long-held mappings, I figure it's wise to keep the
>> mapping duration short, or at least avoid sleeping with a
>> kmap_local_page() map active.
>>
>> I figured, while page compression is probably to be considered "slow"
>> it's probably not slow enough to motivate kmap() instead of
>> kmap_local_page(), but if anyone feels differently, perhaps it should be
>> considered.
> What you say is all true.  But remember the mappings are only actually
> created on a HIGHMEM system.  HIGHMEM systems are increasingly rare.  Also
> they must suffer such performance issues because there is just no other
> way around supporting them.
>
> Also Sumitra, and our kmap conversion project in general, is focusing on
> not using kmap* if at all possible.  Thus the reason V1 tried to use
> page_address().
>
> Could we guarantee the i915 driver is excluded from all HIGHMEM systems?

The i915 maintainers might want to chime in here, but I would say no, we 
can't, although we don't care much about optimizing for them. Same for 
the new xe driver.

Thanks,

/Thomas


>
>> With that said, my Reviewed-by: still stands.
> Thanks!
> Ira
