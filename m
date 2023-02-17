Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A7569A8B8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBQJ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBQJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:58:25 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303A3F766
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676627895; x=1708163895;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=p+cYQG0JeB2tj2iGZFqrQ2nipqXUkgH/8lWd3cyiDFo=;
  b=bSWSqgYG5yQFwSTIJUV0Kani8/SHfpN+aPgb4g/ier4C1WAGKjIwjgdq
   ZXObcRwxnHg2harPnPAPJnGgc5TWkEz/kFpwAR2k+t83LVufUypAcRbzE
   gbN4fW8pH/MEvKXT+vSgIuLO8ai0otnzoqk4h2i5w0d0GmCMOYUrKkTuX
   ZpcinQLmCgCVzXDhocQpbI6EQ2pr3fPTx1xx/hfxpAlyfPeclg4k3GVe3
   ZuQyJTnY0VunFrix2agQTWRdWkOluu0Uq/TdLvPdSumTz9O/SJD99SqyG
   eZyLqJj2P+ByhoE5EBRBqm41Fn9UyPFJcGeVVgJOOHeToawTnFW8HDUNk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="334152914"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="334152914"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 01:58:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="759307458"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="759307458"
Received: from akocherg-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.53.1])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 01:58:10 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] drm/i915: Make kobj_type structures constant
In-Reply-To: <87sff5293w.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230216-kobj_type-i915-v1-1-ca65c9b93518@weissschuh.net>
 <87sff5293w.fsf@intel.com>
Date:   Fri, 17 Feb 2023 11:58:08 +0200
Message-ID: <877cwgzk9b.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Thu, 16 Feb 2023, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> wrote:
>> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
>> the driver core allows the usage of const struct kobj_type.
>>
>> Take advantage of this to constify the structure definitions to prevent
>> modification at runtime.
>>
>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

And pushed to drm-intel-gt-next, thanks for the patch.

BR,
Jani.

>
>> ---
>>  drivers/gpu/drm/i915/gt/intel_gt_sysfs.c | 2 +-
>>  drivers/gpu/drm/i915/gt/sysfs_engines.c  | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_sysfs.c b/drivers/gpu/drm/=
i915/gt/intel_gt_sysfs.c
>> index 9486dd3bed99..df15b17caf89 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_gt_sysfs.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_gt_sysfs.c
>> @@ -71,7 +71,7 @@ static void kobj_gt_release(struct kobject *kobj)
>>  {
>>  }
>>=20=20
>> -static struct kobj_type kobj_gt_type =3D {
>> +static const struct kobj_type kobj_gt_type =3D {
>>  	.release =3D kobj_gt_release,
>>  	.sysfs_ops =3D &kobj_sysfs_ops,
>>  	.default_groups =3D id_groups,
>> diff --git a/drivers/gpu/drm/i915/gt/sysfs_engines.c b/drivers/gpu/drm/i=
915/gt/sysfs_engines.c
>> index f2d9858d827c..b5e0fe5dbf6c 100644
>> --- a/drivers/gpu/drm/i915/gt/sysfs_engines.c
>> +++ b/drivers/gpu/drm/i915/gt/sysfs_engines.c
>> @@ -421,7 +421,7 @@ static void kobj_engine_release(struct kobject *kobj)
>>  	kfree(kobj);
>>  }
>>=20=20
>> -static struct kobj_type kobj_engine_type =3D {
>> +static const struct kobj_type kobj_engine_type =3D {
>>  	.release =3D kobj_engine_release,
>>  	.sysfs_ops =3D &kobj_sysfs_ops
>>  };
>>
>> ---
>> base-commit: 033c40a89f55525139fd5b6342281b09b97d05bf
>> change-id: 20230216-kobj_type-i915-886bebc36129
>>
>> Best regards,

--=20
Jani Nikula, Intel Open Source Graphics Center
