Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC596AD33D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 01:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCGAU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 19:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGAU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 19:20:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F31C64225
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 16:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678148409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3OO5g3ulKc98Lo7VM2vnzz9iptcrpwzftjrdFER2j9g=;
        b=UwKFFjM4K/uB00r3wno3wa0WslwUn961sKgDLA2gaQ1gQ4UPhfQVKLURa4+XETZowoFbkP
        xL6RZztMajIeVP/Xw2q7cNp73NoriE8mB2Uk/HKa0DcLeg2M32Fl+tVbotQH35SCKwrxn1
        9q3feOFNLmC8Cs0JFKD+wLXEma6D64Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-iM41GpmpM5if1P8jvZ3XDw-1; Mon, 06 Mar 2023 19:20:08 -0500
X-MC-Unique: iM41GpmpM5if1P8jvZ3XDw-1
Received: by mail-qt1-f198.google.com with SMTP id g13-20020ac8124d000000b003bfba5d76a3so6217506qtj.15
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 16:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678148407;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OO5g3ulKc98Lo7VM2vnzz9iptcrpwzftjrdFER2j9g=;
        b=H5DhSBV3fPbSO4++hoLmj0hO1CzELrPNj+/xjd9etrqjj/RefN8bCbbDsfqgvlYD4I
         N2np5obRc/7Btn/UITAg/XpQqWo50XsWuulCDWlas0CmZYe/wfOczpayhds5GAZTRzww
         E9s/cHC9cB8uHkwy9COlCCA8yMsAEJYYvmiKQ8XsDA+NSQBkUMSTEKgj+8NQKoWbFHmd
         Qf8vdvvWwrPv3B3mEgj61ROf/R2E3vLiTeze6lCbad1WSf3360wzJKjw4b3ArbykWB5l
         7SIeeQmqpYNdQCPLP1J5I4yj3CZ78CHCz96Gs2FSDp7BPZOAJvYt5kZgc6L4Eap5/P7d
         BG5Q==
X-Gm-Message-State: AO0yUKWerdgLCwH8dm7lJNKr/V/fKPEEd/GdLFrl4kevBfLLzzxrXhBn
        I68Z+0dKCI6Uy0dvSwgNDgalso0Bs55l7jKNmp3OqGvQgGmQgP4GHPMEO0BI/0n8muaF2mGkn1T
        3Gco62fZekJbAHx4c1TFgFDaQ
X-Received: by 2002:ac8:5e0c:0:b0:3bf:b1d6:359e with SMTP id h12-20020ac85e0c000000b003bfb1d6359emr17210011qtx.7.1678148407651;
        Mon, 06 Mar 2023 16:20:07 -0800 (PST)
X-Google-Smtp-Source: AK7set9G99b4/F24c6ODRtdenQOBsR+rNyjSK/ievkE2R8v6jyZs5TelbiEvYAAjwLxnvAJSnVjzCA==
X-Received: by 2002:ac8:5e0c:0:b0:3bf:b1d6:359e with SMTP id h12-20020ac85e0c000000b003bfb1d6359emr17209989qtx.7.1678148407373;
        Mon, 06 Mar 2023 16:20:07 -0800 (PST)
Received: from ?IPv6:2600:4040:5c68:6800::feb? ([2600:4040:5c68:6800::feb])
        by smtp.gmail.com with ESMTPSA id n132-20020a37408a000000b007425dade624sm8526056qka.41.2023.03.06.16.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 16:20:06 -0800 (PST)
Message-ID: <cf9f2bba28420dd19e14f449f4049ed23cfc41a2.camel@redhat.com>
Subject: Re: [PATCH RESEND] drm/nouveau/hwmon: Use sysfs_emit in show
 function callsbacks
From:   Lyude Paul <lyude@redhat.com>
To:     Deepak R Varma <drv@mailo.com>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Date:   Mon, 06 Mar 2023 19:20:05 -0500
In-Reply-To: <Y/+pDaHOgG1x8Py2@ubun2204.myguest.virtualbox.org>
References: <Y/+pDaHOgG1x8Py2@ubun2204.myguest.virtualbox.org>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push upstream in a moment

On Thu, 2023-03-02 at 01:05 +0530, Deepak R Varma wrote:
> According to Documentation/filesystems/sysfs.rst, the show() callback
> function of kobject attributes should strictly use sysfs_emit() instead
> of sprintf() family functions. So, make this change.
> Issue identified using the coccinelle device_attr_show.cocci script.
>=20
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Note:
>    Resending the patch for review and feedback. No functional changes.
>=20
>=20
>  drivers/gpu/drm/nouveau/nouveau_hwmon.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/no=
uveau/nouveau_hwmon.c
> index a7db7c31064b..e844be49e11e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> @@ -41,7 +41,7 @@ static ssize_t
>  nouveau_hwmon_show_temp1_auto_point1_pwm(struct device *d,
>  					 struct device_attribute *a, char *buf)
>  {
> -	return snprintf(buf, PAGE_SIZE, "%d\n", 100);
> +	return sysfs_emit(buf, "%d\n", 100);
>  }
>  static SENSOR_DEVICE_ATTR(temp1_auto_point1_pwm, 0444,
>  			  nouveau_hwmon_show_temp1_auto_point1_pwm, NULL, 0);
> @@ -54,8 +54,8 @@ nouveau_hwmon_temp1_auto_point1_temp(struct device *d,
>  	struct nouveau_drm *drm =3D nouveau_drm(dev);
>  	struct nvkm_therm *therm =3D nvxx_therm(&drm->client.device);
> =20
> -	return snprintf(buf, PAGE_SIZE, "%d\n",
> -	      therm->attr_get(therm, NVKM_THERM_ATTR_THRS_FAN_BOOST) * 1000);
> +	return sysfs_emit(buf, "%d\n",
> +			  therm->attr_get(therm, NVKM_THERM_ATTR_THRS_FAN_BOOST) * 1000);
>  }
>  static ssize_t
>  nouveau_hwmon_set_temp1_auto_point1_temp(struct device *d,
> @@ -87,8 +87,8 @@ nouveau_hwmon_temp1_auto_point1_temp_hyst(struct device=
 *d,
>  	struct nouveau_drm *drm =3D nouveau_drm(dev);
>  	struct nvkm_therm *therm =3D nvxx_therm(&drm->client.device);
> =20
> -	return snprintf(buf, PAGE_SIZE, "%d\n",
> -	 therm->attr_get(therm, NVKM_THERM_ATTR_THRS_FAN_BOOST_HYST) * 1000);
> +	return sysfs_emit(buf, "%d\n",
> +			  therm->attr_get(therm, NVKM_THERM_ATTR_THRS_FAN_BOOST_HYST) * 1000)=
;
>  }
>  static ssize_t
>  nouveau_hwmon_set_temp1_auto_point1_temp_hyst(struct device *d,

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

