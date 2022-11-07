Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A86620009
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiKGVAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiKGVAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:00:09 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91DF254
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667854806; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AInEwYmBubDQ6V6OhoS8/DlKJ2T55utDNAWwTZfVpEs=;
        b=jBWCwoeyZYRizpyaR+kfAx7UlmgKvWtEqzqgW0CK2RuM7UTF6Uv3LcDseUJt+2VtHoYFpv
        Kcue/ozBs2v7BF75dXwjLfqT/omGKYDVxxYTKd0MOaF3HDVxK2b1r5njQM+sLu5SPcsVYg
        AGbmaf1bxY/RQg6jP0MxmEoWmo+ZZvo=
Date:   Mon, 07 Nov 2022 20:59:55 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 26/26] drm/i915/gt: Remove #ifdef guards for PM related
 functions
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Message-Id: <VZWZKR.3K3MGKLWDLB12@crapouillou.net>
In-Reply-To: <Y2lrNbA4t8RHOwPB@intel.com>
References: <20221107175106.360578-1-paul@crapouillou.net>
        <20221107175510.361051-1-paul@crapouillou.net>
        <20221107175510.361051-3-paul@crapouillou.net> <Y2lrNbA4t8RHOwPB@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

Le lun. 7 nov. 2022 =E0 15:31:49 -0500, Rodrigo Vivi=20
<rodrigo.vivi@intel.com> a =E9crit :
> On Mon, Nov 07, 2022 at 05:55:10PM +0000, Paul Cercueil wrote:
>>  Instead of defining two versions of intel_sysfs_rc6_init(), one for=20
>> each
>>  value of CONFIG_PM, add a check on !IS_ENABLED(CONFIG_PM) early in=20
>> the
>>  function. This will allow the compiler to automatically drop the=20
>> dead
>>  code when CONFIG_PM is disabled, without having to use #ifdef=20
>> guards.
>=20
> Making the RC6 to depend on the CONFIG_PM is probably an historical
> mistake and probably the right solution is simply to remove that
> dependency.

I don't know anything about i915, so the best I can do is update the=20
code without changing the functionality.

Then someone with a better understanding can send a patch to remove the=20
check on CONFIG_PM.

Cheers,
-Paul

>>=20
>>  This has the advantage of always compiling these functions in,
>>  independently of any Kconfig option. Thanks to that, bugs and other
>>  regressions are subsequently easier to catch.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>  Cc: Jani Nikula <jani.nikula@linux.intel.com>
>>  Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>>  Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>  Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
>>  Cc: intel-gfx@lists.freedesktop.org
>>  ---
>>   drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>=20
>>  diff --git a/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c=20
>> b/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
>>  index 2b5f05b31187..decf892a4508 100644
>>  --- a/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
>>  +++ b/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
>>  @@ -164,7 +164,6 @@ sysfs_gt_attribute_r_func(struct kobject *kobj,=20
>> struct attribute *attr,
>>   								 NULL);			\
>>   	INTEL_GT_ATTR_RO(_name)
>>=20
>>  -#ifdef CONFIG_PM
>>   static u32 get_residency(struct intel_gt *gt, i915_reg_t reg)
>>   {
>>   	intel_wakeref_t wakeref;
>>  @@ -300,7 +299,7 @@ static void intel_sysfs_rc6_init(struct=20
>> intel_gt *gt, struct kobject *kobj)
>>   {
>>   	int ret;
>>=20
>>  -	if (!HAS_RC6(gt->i915))
>>  +	if (!IS_ENABLED(CONFIG_PM) || !HAS_RC6(gt->i915))
>>   		return;
>>=20
>>   	ret =3D __intel_gt_sysfs_create_group(kobj, rc6_attr_group);
>>  @@ -329,11 +328,6 @@ static void intel_sysfs_rc6_init(struct=20
>> intel_gt *gt, struct kobject *kobj)
>>   				 gt->info.id, ERR_PTR(ret));
>>   	}
>>   }
>>  -#else
>>  -static void intel_sysfs_rc6_init(struct intel_gt *gt, struct=20
>> kobject *kobj)
>>  -{
>>  -}
>>  -#endif /* CONFIG_PM */
>>=20
>>   static u32 __act_freq_mhz_show(struct intel_gt *gt)
>>   {
>>  --
>>  2.35.1
>>=20


