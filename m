Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D870665EADA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjAEMoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjAEMoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:44:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895D244C6B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672922661; x=1704458661;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=03yRk3YUTRbtUlTbBX6g4yWRvlr9Bn2e6cwwlDOVhrs=;
  b=mtpyOPdi+uWW0lQOe1LOWDRqMUifCfKlhvO0CJL5EUT2z0iWxFdTiNip
   Hrtf2szOTIF+9fqf0lSWGgUUYRaB2+25I8aJlG5KHvEq7LGAmX8PZRZSv
   iOUrqpDafBKN/62xReB9hc5g25SzmiiljWSxMZsd4/WFFMzYZCWh7JzB3
   h27GXntTwOXRK8fTdasdlUpw8C2b6bnxL1JBDsm0ZayaTfH6ndcXz1AvK
   puGhp/S/Wi/0fJ4WIbZV1c9HNFa9qabsew1/b20VixCRQgNVJXXQKSZ6A
   Aq994JcLS0UbqfCjyo/4W4Y3gp/U+JtngdgBtYca04wuqxc9mGfrlkG2M
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="408445950"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="408445950"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 04:44:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="724050843"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="724050843"
Received: from swathish-mobl.ger.corp.intel.com (HELO localhost) ([10.252.10.152])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 04:44:16 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oded Gabbay <ogabbay@kernel.org>
Cc:     Melissa Wen <mwen@igalia.com>,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,
        Emma Anholt <emma@anholt.net>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Wambui Karuga <wambui@karuga.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v4 1/7] drm/debugfs: create device-centered debugfs
 functions
In-Reply-To: <20221219120621.15086-2-mcanal@igalia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221219120621.15086-1-mcanal@igalia.com>
 <20221219120621.15086-2-mcanal@igalia.com>
Date:   Thu, 05 Jan 2023 14:44:14 +0200
Message-ID: <87bkndw3q9.fsf@intel.com>
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

On Mon, 19 Dec 2022, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
> @@ -230,6 +247,12 @@ int drm_debugfs_init(struct drm_minor *minor, int mi=
nor_id,
>  	if (dev->driver->debugfs_init)
>  		dev->driver->debugfs_init(minor);
>=20=20
> +	list_for_each_entry_safe(entry, tmp, &dev->debugfs_list, list) {
> +		debugfs_create_file(entry->file.name, S_IFREG | S_IRUGO,

I know this was merged already, but S_IFREG is redundant, and the octal
values are preferred over S_IRUGO. See checkpatch SYMBOLIC_PERMS.

This would be just 0444.


BR,
Jani.


> +				    minor->debugfs_root, entry, &drm_debugfs_entry_fops);
> +		list_del(&entry->list);
> +	}
> +
>  	return 0;
>  }
>=20=20

--=20
Jani Nikula, Intel Open Source Graphics Center
