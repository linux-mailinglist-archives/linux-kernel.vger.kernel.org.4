Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1056D4DAB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjDCQ2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjDCQ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:28:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4021721
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=rduXwTxKJ2ZRTymjzDI20MsDownWzIgevWq9R+vDxik=; b=TSZEdqgE6wUJVAoZbc98O6N4CN
        T7zkdbIqBWkyalyEKEMQGpqWsqvIQPbE4PGtJv8WoxR52Zk9JeY/aptDay5H4s4ldoFBE2gtnUm1l
        X6H2W9UYsVbz37mB17y88zmPqno1Teo7HBxo1a8aYZzhLK2hK17HujPms41XiKW0T80Ict4FT3ibp
        OXgg+rANBS0Y3vWTvTEHf5B/y5xT97/SD0AG1cZIJHj53nZPk8fomj4gaZazcuRZa0I/ss0Pw2Rch
        51WoSM3cvTaYL7sEXzzX4hYx5e6esRZMJSRZy9pODPP6GFyQKDTG3GyMW/+8T9iZDnaO68t+4M1GW
        Xu/DhKvw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjN2i-00Fxh1-1q;
        Mon, 03 Apr 2023 16:28:28 +0000
Message-ID: <ef2ba536-a7ea-7cfb-7cf6-9e0c02aeba80@infradead.org>
Date:   Mon, 3 Apr 2023 09:28:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/vblank: Simplify drm_dev_has_vblank()
Content-Language: en-US
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        open list <linux-kernel@vger.kernel.org>
References: <20230403160735.1211468-1-robdclark@gmail.com>
 <ZCr9jrhTyGuZA+Qt@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZCr9jrhTyGuZA+Qt@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/23 09:23, Ville Syrjälä wrote:
> On Mon, Apr 03, 2023 at 09:07:35AM -0700, Rob Clark wrote:
>> From: Rob Clark <robdclark@chromium.org>
>>
>> What does vblank have to do with num_crtcs?  Well, this was technically
>> correct, but you'd have to go look at where num_crtcs is initialized to
>> understand why.  Lets just replace it with the simpler and more obvious
>> check.
>>
>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>> ---
>>  drivers/gpu/drm/drm_vblank.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
>> index 877e2067534f..ad34c235d853 100644
>> --- a/drivers/gpu/drm/drm_vblank.c
>> +++ b/drivers/gpu/drm/drm_vblank.c
>> @@ -575,7 +575,7 @@ EXPORT_SYMBOL(drm_vblank_init);
>>   */
>>  bool drm_dev_has_vblank(const struct drm_device *dev)
>>  {
>> -	return dev->num_crtcs != 0;
>> +	return !!dev->vblank;
> 
> The compiler knows how to turn things into a boolean.
>> Or I guess if we want to be a bit more explicit we could
> write this as
>  return dev->vblank != NULL;
> but IIRC that will make checkpatch complain because of
> someone's personal taste.

checkpatch isn't an absolute thing. :)

-- 
~Randy
