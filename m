Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030D65B5E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 18:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiILQZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 12:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiILQZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:25:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2761F186DE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 09:25:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l8so2093815wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date;
        bh=+W4RwbnM9iJia/4aPMhM+WCdWfyK6Tj6lF9Eemtu3jk=;
        b=ZPucHOAy+10NmutrrL2sIozNf5Fd/aDc4bZbhWnN0Ma1N1hN8DTcTm8ZARd3L4WBJF
         0a4i8BiawUeCwUD4R2msSLyYFVBwNkrsosC+hiT+BZbzilZv+z7A7IbMCuAi7rBa6WU9
         IVX5r0JLe5zRF5ni07MVkCoby6+Xtrbhh54DTTLcpvRNN5oZ9BYl2GudSgUziMhOeBBw
         XoSc8xvYzIbs3dGE/Dhq/RH0QM0TJjY0Yrwd/GS+DjKhl7KjpFtFKXMi0z5n3GfA0+Ep
         cmA6yqfi3a4K35ojuLrxfd36r/7OzCzwggaBEEI0WUVimiUPIN9Ksft7RxHBCgnu0iqR
         nrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=+W4RwbnM9iJia/4aPMhM+WCdWfyK6Tj6lF9Eemtu3jk=;
        b=A7akssJ3pzbaF6uvvTUNle+ZMEo2CpmpRIRihNlu/961QMUQDWWcCneRksA92Fou+t
         S59RymsO7hfSArYTmAk5Gt5ZmesFwTfPVhKRhtyrp7APSy4A1vtcddz+7vN2LT8nYKD2
         Su9VHtZbxKXhlVz3Yar0dFC7OaMtk2zA4wcS5A4CEXAFEpGTLnyPJb5HiRw1GVSEredB
         lWpAZo854RTxcmWWFRjzalM0gvo61DOPfjpn7u656sJNwGVlYLYNkwAlAav5daD19mFL
         iDQqaxqeriI664fF3lGXPArcrEoatZrvHfO+g/KaQiKgp448jhPGLi/D8plRmssVUDoo
         aYpA==
X-Gm-Message-State: ACgBeo0hhVDygTWy0qLmkpCgaUhsMXRC0Uz4Aq3F23AJJZdJA+qnUhtD
        aw96JVw+GJLJwubLtoysrBw=
X-Google-Smtp-Source: AA6agR56PDr4OxOxbVTZb7lN/D2NQdjbVP+0IiFu7zoc5JeUSqc/Eks2uvKKljnFawEFtrhWVF35uQ==
X-Received: by 2002:a05:600c:502c:b0:3a8:41e9:cd32 with SMTP id n44-20020a05600c502c00b003a841e9cd32mr14638183wmr.177.1662999921388;
        Mon, 12 Sep 2022 09:25:21 -0700 (PDT)
Received: from fedora ([2a01:e0a:1d2:1f90:be95:f3a2:4d99:a3b3])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b003a540fef440sm12241168wmp.1.2022.09.12.09.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 09:25:20 -0700 (PDT)
Date:   Mon, 12 Sep 2022 18:25:14 +0200
From:   Matthieu CHARETTE <matthieu.charette@gmail.com>
Subject: Re: [PATCH] drm: Fix EDID firmware load on resume
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org, tzimmermann@suse.de,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, andrealmeid@igalia.com
Message-Id: <2YU3IR.4394CFYXZPEZ1@gmail.com>
In-Reply-To: <87edxqodq2.fsf@intel.com>
References: <202207172035.mtErdlaw-lkp@intel.com>
        <20220727074152.43059-1-matthieu.charette@gmail.com>
        <87wnbqen2f.fsf@intel.com> <PDYAGR.ODW3J0YFOA5G3@gmail.com>
        <87edxqodq2.fsf@intel.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for late reply.

How do you propose to go then?
Can we still use a persistent platform device to load the firmware and 
cache it? But, in this case the system will still crash in case the 
user change drm.edid_firmware then, without replugging the device, he 
suspends and resumes the machine.
Or you may have a better idea?

Thanks,
Matthieu

On Mon, Aug 8 2022 at 08:19:01 PM +0300, Jani Nikula 
<jani.nikula@linux.intel.com> wrote:
> On Mon, 08 Aug 2022, Matthieu CHARETTE <matthieu.charette@gmail.com> 
> wrote:
>>  Sorry, What do you mean?
> 
> You cache with one name at connector init time, but the name specified
> using drm.edid_firmware may be changed whenever, to cause the next 
> EDID
> read to use a different EDID firmware.
> 
> BR,
> Jani.
> 
> 
>> 
>>  Matthieu
>> 
>>  On Tue, Aug 2 2022 at 05:29:12 PM +0300, Jani Nikula
>>  <jani.nikula@linux.intel.com> wrote:
>>>  On Wed, 27 Jul 2022, Matthieu CHARETTE <matthieu.charette@gmail.com
>>>  <mailto:matthieu.charette@gmail.com>> wrote:
>>>>   Loading an EDID using drm.edid_firmware parameter makes resume to
>>>>  fail
>>>>   after firmware cache is being cleaned. This is because 
>>>> edid_load()
>>>>  use a
>>>>   temporary device to request the firmware. This cause the EDID
>>>>  firmware
>>>>   not to be cached from suspend. And, requesting the EDID firmware
>>>>  return
>>>>   an error during resume.
>>>>   So the request_firmware() call should use a permanent device for
>>>>  each
>>>>   connector. Also, we should cache the EDID even if no monitor is
>>>>   connected, in case it's plugged while suspended.
>>> 
>>>  AFAICT this breaks changing drm.edid_firmware runtime.
>>> 
>>>  BR,
>>>  Jani.
>>> 
>>>> 
>>>>   Link: <https://gitlab.freedesktop.org/drm/amd/-/issues/2061>
>>>>   Signed-off-by: Matthieu CHARETTE <matthieu.charette@gmail.com
>>>>  <mailto:matthieu.charette@gmail.com>>
>>>>   ---
>>>>    drivers/gpu/drm/drm_connector.c |  9 ++++
>>>>    drivers/gpu/drm/drm_edid_load.c | 81
>>>>  ++++++++++++++++++++++++++++-----
>>>>    include/drm/drm_connector.h     | 12 +++++
>>>>    include/drm/drm_edid.h          |  3 ++
>>>>    4 files changed, 94 insertions(+), 11 deletions(-)
>>>> 
>>>>   diff --git a/drivers/gpu/drm/drm_connector.c
>>>>  b/drivers/gpu/drm/drm_connector.c
>>>>   index 1c48d162c77e..e8819ebf1c4b 100644
>>>>   --- a/drivers/gpu/drm/drm_connector.c
>>>>   +++ b/drivers/gpu/drm/drm_connector.c
>>>>   @@ -31,6 +31,7 @@
>>>>    #include <drm/drm_privacy_screen_consumer.h>
>>>>    #include <drm/drm_sysfs.h>
>>>> 
>>>>   +#include <linux/platform_device.h>
>>>>    #include <linux/uaccess.h>
>>>> 
>>>>    #include "drm_crtc_internal.h"
>>>>   @@ -289,6 +290,9 @@ int drm_connector_init(struct drm_device 
>>>> *dev,
>>>> 
>>>>    	drm_connector_get_cmdline_mode(connector);
>>>> 
>>>>   +	connector->edid_load_pdev = NULL;
>>>>   +	drm_cache_edid_firmware(connector);
>>>>   +
>>>>    	/* We should add connectors at the end to avoid upsetting the
>>>>  connector
>>>>    	 * index too much.
>>>>    	 */
>>>>   @@ -473,6 +477,11 @@ void drm_connector_cleanup(struct
>>>>  drm_connector *connector)
>>>>    		connector->tile_group = NULL;
>>>>    	}
>>>> 
>>>>   +	if (connector->edid_load_pdev) {
>>>>   +		platform_device_unregister(connector->edid_load_pdev);
>>>>   +		connector->edid_load_pdev = NULL;
>>>>   +	}
>>>>   +
>>>>    	list_for_each_entry_safe(mode, t, &connector->probed_modes, 
>>>> head)
>>>>    		drm_mode_remove(connector, mode);
>>>> 
>>>>   diff --git a/drivers/gpu/drm/drm_edid_load.c
>>>>  b/drivers/gpu/drm/drm_edid_load.c
>>>>   index 37d8ba3ddb46..5a82be9917ec 100644
>>>>   --- a/drivers/gpu/drm/drm_edid_load.c
>>>>   +++ b/drivers/gpu/drm/drm_edid_load.c
>>>>   @@ -167,6 +167,19 @@ static int edid_size(const u8 *edid, int
>>>>  data_size)
>>>>    	return (edid[0x7e] + 1) * EDID_LENGTH;
>>>>    }
>>>> 
>>>>   +static struct platform_device *edid_pdev(const char
>>>>  *connector_name)
>>>>   +{
>>>>   +	struct platform_device *pdev =
>>>>  platform_device_register_simple(connector_name, -1, NULL, 0);
>>>>   +
>>>>   +	if (IS_ERR(pdev)) {
>>>>   +		DRM_ERROR("Failed to register EDID firmware platform device "
>>>>   +			"for connector \"%s\"\n", connector_name);
>>>>   +		return ERR_CAST(pdev);
>>>>   +	}
>>>>   +
>>>>   +	return pdev;
>>>>   +}
>>>>   +
>>>>    static void *edid_load(struct drm_connector *connector, const 
>>>> char
>>>>  *name,
>>>>    			const char *connector_name)
>>>>    {
>>>>   @@ -182,18 +195,17 @@ static void *edid_load(struct drm_connector
>>>>  *connector, const char *name,
>>>>    		fwdata = generic_edid[builtin];
>>>>    		fwsize = sizeof(generic_edid[builtin]);
>>>>    	} else {
>>>>   -		struct platform_device *pdev;
>>>>   +		struct platform_device *pdev = connector->edid_load_pdev;
>>>>    		int err;
>>>> 
>>>>   -		pdev = platform_device_register_simple(connector_name, -1, 
>>>> NULL,
>>>>  0);
>>>>   -		if (IS_ERR(pdev)) {
>>>>   -			DRM_ERROR("Failed to register EDID firmware platform device "
>>>>   -				  "for connector \"%s\"\n", connector_name);
>>>>   -			return ERR_CAST(pdev);
>>>>   +		if (WARN_ON(!pdev)) {
>>>>   +			pdev = edid_pdev(connector_name);
>>>>   +			if (IS_ERR(pdev))
>>>>   +				return ERR_CAST(pdev);
>>>>   +			connector->edid_load_pdev = pdev;
>>>>    		}
>>>> 
>>>>    		err = request_firmware(&fw, name, &pdev->dev);
>>>>   -		platform_device_unregister(pdev);
>>>>    		if (err) {
>>>>    			DRM_ERROR("Requesting EDID firmware \"%s\" failed 
>>>> (err=%d)\n",
>>>>    				  name, err);
>>>>   @@ -263,11 +275,9 @@ static void *edid_load(struct drm_connector
>>>>  *connector, const char *name,
>>>>    	return edid;
>>>>    }
>>>> 
>>>>   -struct edid *drm_load_edid_firmware(struct drm_connector
>>>>  *connector)
>>>>   +static char *edid_name(const char *connector_name)
>>>>    {
>>>>   -	const char *connector_name = connector->name;
>>>>    	char *edidname, *last, *colon, *fwstr, *edidstr, *fallback = 
>>>> NULL;
>>>>   -	struct edid *edid;
>>>> 
>>>>    	if (edid_firmware[0] == '\0')
>>>>    		return ERR_PTR(-ENOENT);
>>>>   @@ -310,8 +320,57 @@ struct edid *drm_load_edid_firmware(struct
>>>>  drm_connector *connector)
>>>>    	if (*last == '\n')
>>>>    		*last = '\0';
>>>> 
>>>>   -	edid = edid_load(connector, edidname, connector_name);
>>>>   +	edidname = kstrdup(edidname, GFP_KERNEL);
>>>>   +	if (!edidname) {
>>>>   +		kfree(fwstr);
>>>>   +		return ERR_PTR(-ENOMEM);
>>>>   +	}
>>>>   +
>>>>    	kfree(fwstr);
>>>>   +	return edidname;
>>>>   +}
>>>>   +
>>>>   +void drm_cache_edid_firmware(struct drm_connector *connector)
>>>>   +{
>>>>   +	const char *connector_name = connector->name;
>>>>   +	const char *edidname = edid_name(connector_name);
>>>>   +	struct platform_device *pdev;
>>>>   +	int err;
>>>>   +
>>>>   +	if (IS_ERR(edidname))
>>>>   +		return;
>>>>   +
>>>>   +	if (match_string(generic_edid_name, GENERIC_EDIDS, edidname) >=
>>>>  0) {
>>>>   +		kfree(edidname);
>>>>   +		return;
>>>>   +	}
>>>>   +
>>>>   +	pdev = edid_pdev(connector_name);
>>>>   +	if (IS_ERR(pdev)) {
>>>>   +		kfree(edidname);
>>>>   +		return;
>>>>   +	}
>>>>   +	connector->edid_load_pdev = pdev;
>>>>   +
>>>>   +	err = firmware_request_cache(&pdev->dev, edidname);
>>>>   +	if (err)
>>>>   +		DRM_ERROR("Requesting EDID firmware cache \"%s\" failed
>>>>  (err=%d)\n",
>>>>   +			edidname, err);
>>>>   +
>>>>   +	kfree(edidname);
>>>>   +}
>>>>   +
>>>>   +struct edid *drm_load_edid_firmware(struct drm_connector
>>>>  *connector)
>>>>   +{
>>>>   +	const char *connector_name = connector->name;
>>>>   +	const char *edidname = edid_name(connector_name);
>>>>   +	struct edid *edid;
>>>>   +
>>>>   +	if (IS_ERR(edidname))
>>>>   +		return ERR_CAST(edidname);
>>>>   +
>>>>   +	edid = edid_load(connector, edidname, connector_name);
>>>>   +	kfree(edidname);
>>>> 
>>>>    	return edid;
>>>>    }
>>>>   diff --git a/include/drm/drm_connector.h
>>>>  b/include/drm/drm_connector.h
>>>>   index 3ac4bf87f257..47c84741517e 100644
>>>>   --- a/include/drm/drm_connector.h
>>>>   +++ b/include/drm/drm_connector.h
>>>>   @@ -1573,6 +1573,18 @@ struct drm_connector {
>>>>    	 */
>>>>    	struct i2c_adapter *ddc;
>>>> 
>>>>   +	/**
>>>>   +	 * @edid_load_pdev: Platform device for loading EDID via 
>>>> firmware.
>>>>   +	 *
>>>>   +	 * The platform device is registered in drm_connector_init() in
>>>>  case a
>>>>   +	 * custom EDID firmware is used with `edid_firmware` parameter.
>>>>  Otherwise,
>>>>   +	 * it is set to NULL.
>>>>   +	 *
>>>>   +	 * Platform device is unregistered in drm_connector_cleanup() 
>>>> if
>>>>  it
>>>>   +	 * is not NULL.
>>>>   +	 */
>>>>   +	struct platform_device *edid_load_pdev;
>>>>   +
>>>>    	/**
>>>>    	 * @null_edid_counter: track sinks that give us all zeros for 
>>>> the
>>>>  EDID.
>>>>    	 * Needed to workaround some HW bugs where we get all 0s
>>>>   diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
>>>>   index b2756753370b..e907c928a35d 100644
>>>>   --- a/include/drm/drm_edid.h
>>>>   +++ b/include/drm/drm_edid.h
>>>>   @@ -378,10 +378,13 @@ int drm_av_sync_delay(struct drm_connector
>>>>  *connector,
>>>>    		      const struct drm_display_mode *mode);
>>>> 
>>>>    #ifdef CONFIG_DRM_LOAD_EDID_FIRMWARE
>>>>   +void drm_cache_edid_firmware(struct drm_connector *connector);
>>>>    struct edid *drm_load_edid_firmware(struct drm_connector
>>>>  *connector);
>>>>    int __drm_set_edid_firmware_path(const char *path);
>>>>    int __drm_get_edid_firmware_path(char *buf, size_t bufsize);
>>>>    #else
>>>>   +inline void
>>>>   +drm_cache_edid_firmware(struct drm_connector *connector);
>>>>    static inline struct edid *
>>>>    drm_load_edid_firmware(struct drm_connector *connector)
>>>>    {
>>> 
>>>  --
>>>  Jani Nikula, Intel Open Source Graphics Center
>> 
> 
> --
> Jani Nikula, Intel Open Source Graphics Center


