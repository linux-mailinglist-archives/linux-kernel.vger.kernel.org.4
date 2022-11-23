Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34710635C48
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbiKWL7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiKWL7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:59:37 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFB05599
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669204776; x=1700740776;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=CRDfbn6JrM9WvJlXYd9GdDn0XWvhUnJMyQ8XXiBhvBE=;
  b=RQZQJYWX7jxAIJe8SDYbdJ04aaJyVtkOlW4Ii8NW1GLovCdlUdGIfRXc
   sc8ICIgNLOds46l3VskF5fTYuKswIWx09Spb6Vp9zboX32Ak/gqrHAM5q
   b/y1qky9L07QhwpcI71WzCE0yyat2a9Mypwz3YatLAEPRJClSPHDqURpr
   QIw0xLnxAciUyJ2obdYIG6r87sMxrT5RRDELr0Wur264R1dWAwOaI/HLK
   PSjvqjh8qB76uglHG3enBZ07Et7C1w10baPRrUQfPOR8gUijJMP6uDnJ1
   Wxm2bX5y9/w1QXmKoxSYWy38ziIv7QLE7zGBTwqxiZNAi27Ga8mw++S6B
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="311679851"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="311679851"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 03:59:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="710565583"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="710565583"
Received: from jgronski-mobl.ger.corp.intel.com (HELO localhost) ([10.252.16.163])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 03:59:31 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oded Gabbay <ogabbay@kernel.org>
Cc:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,
        Emma Anholt <emma@anholt.net>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Wambui Karuga <wambui@karuga.org>,
        Melissa Wen <mwen@igalia.com>,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [PATCH 1/6] drm/debugfs: create device-centered debugfs functions
In-Reply-To: <f95f2a71-5daf-332d-9971-55f1fca67ff6@igalia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221122190314.185015-1-mcanal@igalia.com>
 <20221122190314.185015-2-mcanal@igalia.com> <87mt8ivsk8.fsf@intel.com>
 <f95f2a71-5daf-332d-9971-55f1fca67ff6@igalia.com>
Date:   Wed, 23 Nov 2022 13:59:29 +0200
Message-ID: <87h6ypx4ny.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
> Hi Jani,
>
> On 11/23/22 08:06, Jani Nikula wrote:
>> On Tue, 22 Nov 2022, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>>> Introduce the ability to track requests for the addition of DRM debugfs
>>> files at any time and have them added all at once during
>>> drm_dev_register().
>>>
>>> Drivers can add DRM debugfs files to a device-managed list and, during
>>> drm_dev_register(), all added files will be created at once.
>>>
>>> Now, the drivers can use the functions drm_debugfs_add_file() and
>>> drm_debugfs_add_files() to create DRM debugfs files instead of using the
>>> drm_debugfs_create_files() function.
>>>
>>> Co-developed-by: Wambui Karuga <wambui.karugax@gmail.com>
>>> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
>>> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>>> ---
>>>  drivers/gpu/drm/drm_debugfs.c | 76 +++++++++++++++++++++++++++++++++++
>>>  drivers/gpu/drm/drm_drv.c     |  3 ++
>>>  include/drm/drm_debugfs.h     | 45 +++++++++++++++++++++
>>>  include/drm/drm_device.h      | 15 +++++++
>>>  4 files changed, 139 insertions(+)
>>>>> +/**
>>> + * drm_debugfs_add_file - Add a given file to the DRM device debugfs f=
ile list
>>> + * @dev: drm device for the ioctl
>>> + * @name: debugfs file name
>>> + * @show: show callback
>>> + * @data: driver-private data, should not be device-specific
>>> + *
>>> + * Add a given file entry to the DRM device debugfs file list to be cr=
eated on
>>> + * drm_debugfs_init.
>>> + */
>>> +int drm_debugfs_add_file(struct drm_device *dev, const char *name,
>>> +			 int (*show)(struct seq_file*, void*), void *data)
>>> +{
>>> +	struct drm_debugfs_entry *entry =3D drmm_kzalloc(dev, sizeof(*entry),=
 GFP_KERNEL);
>>> +
>>> +	if (!entry)
>>> +		return -ENOMEM;
>>> +
>>> +	entry->file.name =3D name;
>>> +	entry->file.show =3D show;
>>> +	entry->file.data =3D data;
>>> +	entry->dev =3D dev;
>>> +
>>> +	mutex_lock(&dev->debugfs_mutex);
>>> +	list_add(&entry->list, &dev->debugfs_list);
>>> +	mutex_unlock(&dev->debugfs_mutex);
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL(drm_debugfs_add_file);
>>> +
>>> +/**
>>> + * drm_debugfs_add_files - Add an array of files to the DRM device deb=
ugfs file list
>>> + * @dev: drm device for the ioctl
>>> + * @files: The array of files to create
>>> + * @count: The number of files given
>>> + *
>>> + * Add a given set of debugfs files represented by an array of
>>> + * &struct drm_debugfs_info in the DRM device debugfs file list.
>>> + */
>>> +int drm_debugfs_add_files(struct drm_device *dev, const struct drm_deb=
ugfs_info *files, int count)
>>> +{
>>> +	int i, ret =3D 0, err;
>>> +
>>> +	for (i =3D 0; i < count; i++) {
>>> +		err =3D drm_debugfs_add_file(dev, files[i].name, files[i].show, file=
s[i].data);
>>> +		if (err)
>>> +			ret =3D err;
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL(drm_debugfs_add_files);
>>=20
>> Do we want to add return values and error handling to debugfs related
>> functions at all?
>
> Drivers such as vc4 can use the return values from debugfs-related
> functions for error handling. Although the return values are not
> explicitly necessary, some drivers can benefit from them for error handli=
ng.

Arguably they should cease to do error handling on debugfs failures
too. No driver should stop probe if debugfs fails, and that's been the
direction for years.

BR,
Jani.

>
> Best Regards,
> - Ma=C3=ADra Canal
>
>>=20
>> BR,
>> Jani.
>>=20
>>=20
>>> +
>>>  static int connector_show(struct seq_file *m, void *data)
>>>  {
>>>  	struct drm_connector *connector =3D m->private;
>>> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
>>> index 8214a0b1ab7f..803942008fcb 100644
>>> --- a/drivers/gpu/drm/drm_drv.c
>>> +++ b/drivers/gpu/drm/drm_drv.c
>>> @@ -575,6 +575,7 @@ static void drm_dev_init_release(struct drm_device =
*dev, void *res)
>>>  	mutex_destroy(&dev->clientlist_mutex);
>>>  	mutex_destroy(&dev->filelist_mutex);
>>>  	mutex_destroy(&dev->struct_mutex);
>>> +	mutex_destroy(&dev->debugfs_mutex);
>>>  	drm_legacy_destroy_members(dev);
>>>  }
>>>=20=20
>>> @@ -608,12 +609,14 @@ static int drm_dev_init(struct drm_device *dev,
>>>  	INIT_LIST_HEAD(&dev->filelist_internal);
>>>  	INIT_LIST_HEAD(&dev->clientlist);
>>>  	INIT_LIST_HEAD(&dev->vblank_event_list);
>>> +	INIT_LIST_HEAD(&dev->debugfs_list);
>>>=20=20
>>>  	spin_lock_init(&dev->event_lock);
>>>  	mutex_init(&dev->struct_mutex);
>>>  	mutex_init(&dev->filelist_mutex);
>>>  	mutex_init(&dev->clientlist_mutex);
>>>  	mutex_init(&dev->master_mutex);
>>> +	mutex_init(&dev->debugfs_mutex);
>>>=20=20
>>>  	ret =3D drmm_add_action(dev, drm_dev_init_release, NULL);
>>>  	if (ret)
>>> diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
>>> index 2188dc83957f..c5684d6c5055 100644
>>> --- a/include/drm/drm_debugfs.h
>>> +++ b/include/drm/drm_debugfs.h
>>> @@ -79,12 +79,43 @@ struct drm_info_node {
>>>  	struct dentry *dent;
>>>  };
>>>=20=20
>>> +/**
>>> + * struct drm_debugfs_info - debugfs info list entry
>>> + *
>>> + * This structure represents a debugfs file to be created by the drm
>>> + * core.
>>> + */
>>> +struct drm_debugfs_info {
>>> +	const char *name;
>>> +	int (*show)(struct seq_file*, void*);
>>> +	u32 driver_features;
>>> +	void *data;
>>> +};
>>> +
>>> +/**
>>> + * struct drm_debugfs_entry - Per-device debugfs node structure
>>> + *
>>> + * This structure represents a debugfs file, as an instantiation of a =
&struct
>>> + * drm_debugfs_info on a &struct drm_device.
>>> + */
>>> +struct drm_debugfs_entry {
>>> +	struct drm_device *dev;
>>> +	struct drm_debugfs_info file;
>>> +	struct list_head list;
>>> +};
>>> +
>>>  #if defined(CONFIG_DEBUG_FS)
>>>  void drm_debugfs_create_files(const struct drm_info_list *files,
>>>  			      int count, struct dentry *root,
>>>  			      struct drm_minor *minor);
>>>  int drm_debugfs_remove_files(const struct drm_info_list *files,
>>>  			     int count, struct drm_minor *minor);
>>> +
>>> +int drm_debugfs_add_file(struct drm_device *dev, const char *name,
>>> +			 int (*show)(struct seq_file*, void*), void *data);
>>> +
>>> +int drm_debugfs_add_files(struct drm_device *dev,
>>> +			  const struct drm_debugfs_info *files, int count);
>>>  #else
>>>  static inline void drm_debugfs_create_files(const struct drm_info_list=
 *files,
>>>  					    int count, struct dentry *root,
>>> @@ -96,6 +127,20 @@ static inline int drm_debugfs_remove_files(const st=
ruct drm_info_list *files,
>>>  {
>>>  	return 0;
>>>  }
>>> +
>>> +static inline int drm_debugfs_add_file(struct drm_device *dev, const c=
har *name,
>>> +				       int (*show)(struct seq_file*, void*),
>>> +				       void *data)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>>> +static inline int drm_debugfs_add_files(struct drm_device *dev,
>>> +					const struct drm_debugfs_info *files,
>>> +					int count)
>>> +{
>>> +	return 0;
>>> +}
>>>  #endif
>>>=20=20
>>>  #endif /* _DRM_DEBUGFS_H_ */
>>> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
>>> index 9923c7a6885e..fa6af1d57929 100644
>>> --- a/include/drm/drm_device.h
>>> +++ b/include/drm/drm_device.h
>>> @@ -295,6 +295,21 @@ struct drm_device {
>>>  	 */
>>>  	struct drm_fb_helper *fb_helper;
>>>=20=20
>>> +	/**
>>> +	 * @debugfs_mutex:
>>> +	 *
>>> +	 * Protects &debugfs_list access.
>>> +	 */
>>> +	struct mutex debugfs_mutex;
>>> +
>>> +	/**
>>> +	 * @debugfs_list:
>>> +	 *
>>> +	 * List of debugfs files to be created by the DRM device. The files
>>> +	 * must be added during drm_dev_register().
>>> +	 */
>>> +	struct list_head debugfs_list;
>>> +
>>>  	/* Everything below here is for legacy driver, never use! */
>>>  	/* private: */
>>>  #if IS_ENABLED(CONFIG_DRM_LEGACY)
>>=20

--=20
Jani Nikula, Intel Open Source Graphics Center
