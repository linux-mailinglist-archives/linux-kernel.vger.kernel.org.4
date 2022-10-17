Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90D8600BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiJQJ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiJQJ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:58:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0E25D700;
        Mon, 17 Oct 2022 02:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666000706; x=1697536706;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=zxbYmgJ1tFJXZUq2wDDYpxgs+/4K8DC3Ye2JTdPk2dI=;
  b=kgmcE0tZPcS2PXV7vpHunmlGC1cwB9/0X9xfZ4z9ojlX6h6xWpOuw4jx
   DpsELBkKSt+hU7DEfPuOKWdbTzmQeLuzNHLOdqPQ2lP4ezEJGtaXXrb2Y
   fZguvN7K8Q7/XSOebEG53I8pGBeWO7CPmta4uVs8o8hFq1xSpnypwmOJo
   5shE6JRSH5kl8mciQBzHsi6x3adALvU4F5MBImKpiuyv5QrAC0CQNozNU
   kqULGOuigWG4QqIyHSaHb3DMPNwHQhboK5MSpExK/WMcfz4oKcr49o8SS
   Le3tjjQ4HehYWSxSXiSKQhwadcwUmQ/Ja21eeWmhMFNExD8uweh70tA9I
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="285480892"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="285480892"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 02:58:26 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="630627154"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="630627154"
Received: from cgarnier-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.44.27])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 02:58:23 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Inki Dae <inki.dae@samsung.com>, hongao <hongao@uniontech.com>,
        jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@linux.ie, daniel@ffwll.ch,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/exynos: replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
In-Reply-To: <4e8d94c9-7dc0-039f-7d67-36f6c099ab75@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CGME20220616072357epcas1p4921f90a2fe077e360688e0df00a5dde8@epcas1p4.samsung.com>
 <20220616072233.8302-1-hongao@uniontech.com>
 <4e8d94c9-7dc0-039f-7d67-36f6c099ab75@samsung.com>
Date:   Mon, 17 Oct 2022 12:59:03 +0300
Message-ID: <871qr6srdk.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2022, Inki Dae <inki.dae@samsung.com> wrote:
> 22. 6. 16. 16:22=EC=97=90 hongao =EC=9D=B4(=EA=B0=80) =EC=93=B4 =EA=B8=80:
>> Once EDID is parsed, the monitor HDMI support information is available
>> through drm_display_info.is_hdmi.
>>=20
>> This driver calls drm_detect_hdmi_monitor() to receive the same
>> information, which is less efficient.
>>=20
>> Avoid calling drm_detect_hdmi_monitor() and use drm_display_info.is_hdmi
>> instead.
>>=20
>
> Applied.

Sorry, but this is broken. The commit message contains the clue: "Once
EDID is parsed". drm_get_edid() does not parse the EDID, you need to
call drm_connector_update_edid_property() first.

This is what I posted some time ago [1] but apparently was working on a
different baseline.

BR,
Jani.


[1] https://patchwork.freedesktop.org/patch/msgid/f21588dcb93bdb6cf76724506=
063bdfcdb0a6bb4.1662036058.git.jani.nikula@intel.com


>
> Thanks,
> Inki Dae
>
>> Signed-off-by: hongao <hongao@uniontech.com>
>> ---
>>  drivers/gpu/drm/exynos/exynos_hdmi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exyn=
os/exynos_hdmi.c
>> index 7655142a4651..17e9f5efbcfc 100644
>> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
>> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
>> @@ -893,7 +893,7 @@ static int hdmi_get_modes(struct drm_connector *conn=
ector)
>>  	if (!edid)
>>  		return -ENODEV;
>>=20=20
>> -	hdata->dvi_mode =3D !drm_detect_hdmi_monitor(edid);
>> +	hdata->dvi_mode =3D !connector->display_info.is_hdmi;
>>  	DRM_DEV_DEBUG_KMS(hdata->dev, "%s : width[%d] x height[%d]\n",
>>  			  (hdata->dvi_mode ? "dvi monitor" : "hdmi monitor"),
>>  			  edid->width_cm, edid->height_cm);

--=20
Jani Nikula, Intel Open Source Graphics Center
