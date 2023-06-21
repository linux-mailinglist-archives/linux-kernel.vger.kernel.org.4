Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCDE7389F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjFUPmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjFUPmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:42:39 -0400
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3654819B5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
        content-transfer-encoding:cc:content-type:from:subject:to;
        s=s1; bh=8+jSZYNVSR48321s/oSCWt0Vx0TuZhHVNXzSvj6Jubw=;
        b=ZMJbFTe/D3Y3fpJsgbD+xG8inBdcqgJJm4S+6tintXoPTGXQ7Y2APOwTQPySoEH+AEvV
        lnahvLL3hgEmCak2r7ltJIJvut9FCvRUr3rgV4bYtQKbAJiYR3BAphQ7077tyUaYdlyPUB
        caU5+aRl66KAgrYL1AUlXXnXjdcIFWJGZXgVs+ZdROmPzZd3X7MDiv0PPYHa19a0MVj1Un
        CM1gKbzCGYVWqei89WIEzlBE1x0wM/2yV66HHD1cKsTcwfZtKTxRmAj+oL4oX6S8pq+LDp
        syffKEZiJiNM9h1K06nMqnOTRvCXYcz3m9vMmagvRPqygV1hjResjDCdLVodnWPg==
Received: by filterdrecv-77869f68cc-4lhvt with SMTP id filterdrecv-77869f68cc-4lhvt-1-64931A39-63
        2023-06-21 15:41:45.772147988 +0000 UTC m=+3600334.020172255
Received: from [192.168.1.50] (unknown)
        by geopod-ismtpd-5 (SG) with ESMTP
        id 1CQkqm0ERMy9gnj9PBUTmw
        Wed, 21 Jun 2023 15:41:45.457 +0000 (UTC)
Message-ID: <1f20a832-6339-0feb-3647-cea7598e60be@kwiboo.se>
Date:   Wed, 21 Jun 2023 15:41:46 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] drm/rockchip: vop2: Add missing call to crtc reset
 helper
References: <20230620064732.1525594-1-jonas@kwiboo.se>
 <20230620064732.1525594-5-jonas@kwiboo.se>
 <20230621081151.GY18491@pengutronix.de>
Content-Language: en-US
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20230621081151.GY18491@pengutronix.de>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h7SRAqrjZghh+BUwH?=
 =?us-ascii?Q?PaDHTn0zfJUkykOFCOQaqgs9WhKZwljx1UFMUli?=
 =?us-ascii?Q?64cy78z0MEgFsiULaIXkYPjkvJPN0lJKOsBrzgo?=
 =?us-ascii?Q?zVj+NjeBW0XaXTzBuM8tJbnyUuz50xZc1=2FeMU2T?=
 =?us-ascii?Q?NoCo7xctEjTmPlTrOPb3HQKdLkrk23cU7aK5+q?=
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Yao <markyao0591@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-21 10:11, Sascha Hauer wrote:
> On Tue, Jun 20, 2023 at 06:47:39AM +0000, Jonas Karlman wrote:
>> Add missing call to crtc reset helper to properly vblank reset.
>>
>> Also move vop2_crtc_reset and call vop2_crtc_destroy_state to simplify
>> and remove duplicated code.
>>
>> Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 28 ++++++++------------
>>  1 file changed, 11 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>> index f725487d02ef..1be84fe0208f 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
>> @@ -2080,23 +2080,6 @@ static const struct drm_crtc_helper_funcs vop2_crtc_helper_funcs = {
>>  	.atomic_disable = vop2_crtc_atomic_disable,
>>  };
>>  
>> -static void vop2_crtc_reset(struct drm_crtc *crtc)
>> -{
>> -	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(crtc->state);
>> -
>> -	if (crtc->state) {
>> -		__drm_atomic_helper_crtc_destroy_state(crtc->state);
>> -		kfree(vcstate);
>> -	}
>> -
>> -	vcstate = kzalloc(sizeof(*vcstate), GFP_KERNEL);
>> -	if (!vcstate)
>> -		return;
>> -
>> -	crtc->state = &vcstate->base;
>> -	crtc->state->crtc = crtc;
>> -}
>> -
>>  static struct drm_crtc_state *vop2_crtc_duplicate_state(struct drm_crtc *crtc)
>>  {
>>  	struct rockchip_crtc_state *vcstate;
>> @@ -2123,6 +2106,17 @@ static void vop2_crtc_destroy_state(struct drm_crtc *crtc,
>>  	kfree(vcstate);
>>  }
>>  
>> +static void vop2_crtc_reset(struct drm_crtc *crtc)
>> +{
>> +	struct rockchip_crtc_state *vcstate =
>> +		kzalloc(sizeof(*vcstate), GFP_KERNEL);
>> +
>> +	if (crtc->state)
>> +		vop2_crtc_destroy_state(crtc, crtc->state);
>> +
>> +	__drm_atomic_helper_crtc_reset(crtc, &vcstate->base);
>> +}
> 
> You missed to check for allocation failures before using vcstate.

Good catch, I will fix for both vop and vop2 driver in v2.

Regards,
Jonas

> 
> Sascha
> 

