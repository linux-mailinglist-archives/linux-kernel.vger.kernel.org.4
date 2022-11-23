Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F810635BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiKWLnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiKWLnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:43:10 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF10CDFDD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bjsZatlDfk0Hep6fXrRlj2Nci2uR52FF1b6AJV0In0g=; b=ABk8KNOmV+jXiFUwcbLAuSBX+D
        xUWs99JhxEyrzliXUS8fPrM8uUg9MJmb/WsuC0ug3yMWoky2mlAGOOE1POWVO3WoroBcjFp9IIN3n
        DXi1x5rpcB9P9tCUt02dAPc3sI7QWxv5WLRIXHixhll4tpz/7cXeBo9uSXz46HsEgkdS3P1X7Gz5D
        r3/9x9cxE3QHIKE8oyaWrjSu58EP4lFQ0XnsS2IQ1hIGlbj5Xyus/V3Z6nKRpu5CpZ6Y4rgGxQkQM
        Hrv2lP5u/wAd4htQAGSK4kbmry91CzcSXFymyi77BkTJoTtWsgI32QrBfhLyDafgnev5wsI2PVNZ1
        /oVBs/fg==;
Received: from [177.34.169.227] (helo=[192.168.0.8])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oxo9N-007fNZ-Jp; Wed, 23 Nov 2022 12:42:45 +0100
Message-ID: <f95f2a71-5daf-332d-9971-55f1fca67ff6@igalia.com>
Date:   Wed, 23 Nov 2022 08:42:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/6] drm/debugfs: create device-centered debugfs functions
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oded Gabbay <ogabbay@kernel.org>
Cc:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        Emma Anholt <emma@anholt.net>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Wambui Karuga <wambui@karuga.org>,
        Melissa Wen <mwen@igalia.com>,
        Wambui Karuga <wambui.karugax@gmail.com>
References: <20221122190314.185015-1-mcanal@igalia.com>
 <20221122190314.185015-2-mcanal@igalia.com> <87mt8ivsk8.fsf@intel.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <87mt8ivsk8.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

On 11/23/22 08:06, Jani Nikula wrote:
> On Tue, 22 Nov 2022, Maíra Canal <mcanal@igalia.com> wrote:
>> Introduce the ability to track requests for the addition of DRM debugfs
>> files at any time and have them added all at once during
>> drm_dev_register().
>>
>> Drivers can add DRM debugfs files to a device-managed list and, during
>> drm_dev_register(), all added files will be created at once.
>>
>> Now, the drivers can use the functions drm_debugfs_add_file() and
>> drm_debugfs_add_files() to create DRM debugfs files instead of using the
>> drm_debugfs_create_files() function.
>>
>> Co-developed-by: Wambui Karuga <wambui.karugax@gmail.com>
>> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>  drivers/gpu/drm/drm_debugfs.c | 76 +++++++++++++++++++++++++++++++++++
>>  drivers/gpu/drm/drm_drv.c     |  3 ++
>>  include/drm/drm_debugfs.h     | 45 +++++++++++++++++++++
>>  include/drm/drm_device.h      | 15 +++++++
>>  4 files changed, 139 insertions(+)
>>>> +/**
>> + * drm_debugfs_add_file - Add a given file to the DRM device debugfs file list
>> + * @dev: drm device for the ioctl
>> + * @name: debugfs file name
>> + * @show: show callback
>> + * @data: driver-private data, should not be device-specific
>> + *
>> + * Add a given file entry to the DRM device debugfs file list to be created on
>> + * drm_debugfs_init.
>> + */
>> +int drm_debugfs_add_file(struct drm_device *dev, const char *name,
>> +			 int (*show)(struct seq_file*, void*), void *data)
>> +{
>> +	struct drm_debugfs_entry *entry = drmm_kzalloc(dev, sizeof(*entry), GFP_KERNEL);
>> +
>> +	if (!entry)
>> +		return -ENOMEM;
>> +
>> +	entry->file.name = name;
>> +	entry->file.show = show;
>> +	entry->file.data = data;
>> +	entry->dev = dev;
>> +
>> +	mutex_lock(&dev->debugfs_mutex);
>> +	list_add(&entry->list, &dev->debugfs_list);
>> +	mutex_unlock(&dev->debugfs_mutex);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(drm_debugfs_add_file);
>> +
>> +/**
>> + * drm_debugfs_add_files - Add an array of files to the DRM device debugfs file list
>> + * @dev: drm device for the ioctl
>> + * @files: The array of files to create
>> + * @count: The number of files given
>> + *
>> + * Add a given set of debugfs files represented by an array of
>> + * &struct drm_debugfs_info in the DRM device debugfs file list.
>> + */
>> +int drm_debugfs_add_files(struct drm_device *dev, const struct drm_debugfs_info *files, int count)
>> +{
>> +	int i, ret = 0, err;
>> +
>> +	for (i = 0; i < count; i++) {
>> +		err = drm_debugfs_add_file(dev, files[i].name, files[i].show, files[i].data);
>> +		if (err)
>> +			ret = err;
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(drm_debugfs_add_files);
> 
> Do we want to add return values and error handling to debugfs related
> functions at all?

Drivers such as vc4 can use the return values from debugfs-related
functions for error handling. Although the return values are not
explicitly necessary, some drivers can benefit from them for error handling.

Best Regards,
- Maíra Canal

> 
> BR,
> Jani.
> 
> 
>> +
>>  static int connector_show(struct seq_file *m, void *data)
>>  {
>>  	struct drm_connector *connector = m->private;
>> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
>> index 8214a0b1ab7f..803942008fcb 100644
>> --- a/drivers/gpu/drm/drm_drv.c
>> +++ b/drivers/gpu/drm/drm_drv.c
>> @@ -575,6 +575,7 @@ static void drm_dev_init_release(struct drm_device *dev, void *res)
>>  	mutex_destroy(&dev->clientlist_mutex);
>>  	mutex_destroy(&dev->filelist_mutex);
>>  	mutex_destroy(&dev->struct_mutex);
>> +	mutex_destroy(&dev->debugfs_mutex);
>>  	drm_legacy_destroy_members(dev);
>>  }
>>  
>> @@ -608,12 +609,14 @@ static int drm_dev_init(struct drm_device *dev,
>>  	INIT_LIST_HEAD(&dev->filelist_internal);
>>  	INIT_LIST_HEAD(&dev->clientlist);
>>  	INIT_LIST_HEAD(&dev->vblank_event_list);
>> +	INIT_LIST_HEAD(&dev->debugfs_list);
>>  
>>  	spin_lock_init(&dev->event_lock);
>>  	mutex_init(&dev->struct_mutex);
>>  	mutex_init(&dev->filelist_mutex);
>>  	mutex_init(&dev->clientlist_mutex);
>>  	mutex_init(&dev->master_mutex);
>> +	mutex_init(&dev->debugfs_mutex);
>>  
>>  	ret = drmm_add_action(dev, drm_dev_init_release, NULL);
>>  	if (ret)
>> diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
>> index 2188dc83957f..c5684d6c5055 100644
>> --- a/include/drm/drm_debugfs.h
>> +++ b/include/drm/drm_debugfs.h
>> @@ -79,12 +79,43 @@ struct drm_info_node {
>>  	struct dentry *dent;
>>  };
>>  
>> +/**
>> + * struct drm_debugfs_info - debugfs info list entry
>> + *
>> + * This structure represents a debugfs file to be created by the drm
>> + * core.
>> + */
>> +struct drm_debugfs_info {
>> +	const char *name;
>> +	int (*show)(struct seq_file*, void*);
>> +	u32 driver_features;
>> +	void *data;
>> +};
>> +
>> +/**
>> + * struct drm_debugfs_entry - Per-device debugfs node structure
>> + *
>> + * This structure represents a debugfs file, as an instantiation of a &struct
>> + * drm_debugfs_info on a &struct drm_device.
>> + */
>> +struct drm_debugfs_entry {
>> +	struct drm_device *dev;
>> +	struct drm_debugfs_info file;
>> +	struct list_head list;
>> +};
>> +
>>  #if defined(CONFIG_DEBUG_FS)
>>  void drm_debugfs_create_files(const struct drm_info_list *files,
>>  			      int count, struct dentry *root,
>>  			      struct drm_minor *minor);
>>  int drm_debugfs_remove_files(const struct drm_info_list *files,
>>  			     int count, struct drm_minor *minor);
>> +
>> +int drm_debugfs_add_file(struct drm_device *dev, const char *name,
>> +			 int (*show)(struct seq_file*, void*), void *data);
>> +
>> +int drm_debugfs_add_files(struct drm_device *dev,
>> +			  const struct drm_debugfs_info *files, int count);
>>  #else
>>  static inline void drm_debugfs_create_files(const struct drm_info_list *files,
>>  					    int count, struct dentry *root,
>> @@ -96,6 +127,20 @@ static inline int drm_debugfs_remove_files(const struct drm_info_list *files,
>>  {
>>  	return 0;
>>  }
>> +
>> +static inline int drm_debugfs_add_file(struct drm_device *dev, const char *name,
>> +				       int (*show)(struct seq_file*, void*),
>> +				       void *data)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline int drm_debugfs_add_files(struct drm_device *dev,
>> +					const struct drm_debugfs_info *files,
>> +					int count)
>> +{
>> +	return 0;
>> +}
>>  #endif
>>  
>>  #endif /* _DRM_DEBUGFS_H_ */
>> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
>> index 9923c7a6885e..fa6af1d57929 100644
>> --- a/include/drm/drm_device.h
>> +++ b/include/drm/drm_device.h
>> @@ -295,6 +295,21 @@ struct drm_device {
>>  	 */
>>  	struct drm_fb_helper *fb_helper;
>>  
>> +	/**
>> +	 * @debugfs_mutex:
>> +	 *
>> +	 * Protects &debugfs_list access.
>> +	 */
>> +	struct mutex debugfs_mutex;
>> +
>> +	/**
>> +	 * @debugfs_list:
>> +	 *
>> +	 * List of debugfs files to be created by the DRM device. The files
>> +	 * must be added during drm_dev_register().
>> +	 */
>> +	struct list_head debugfs_list;
>> +
>>  	/* Everything below here is for legacy driver, never use! */
>>  	/* private: */
>>  #if IS_ENABLED(CONFIG_DRM_LEGACY)
> 
