Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A81C62113A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiKHMqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiKHMqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:46:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A55B52892
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667911582; x=1699447582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yInpcuBqffNpHyEIyvcFabmM7Yq7M2fOh2s3ydZG1aI=;
  b=EgrUu4+lFEHjZaTsop4n9Pfpmf4en4wLkYLz3jOBF/PF2N921Z8fBWp3
   JNbkI4GfDBOemmjkIpu15eBSLyWzGqJzd3lS+gC8EBtIAkHMT7W4QhRBP
   54SpafbE1eTLXHNnLdu9Bt/Lc1MHyriAhRc6ccd16BZStS8qiJg9sGe02
   p+Usb1ZrohNj6qcjrO52YZUni9yyIaKvTe8wZgUqD8fem/t3amy7R/kZb
   ra6RXox3FJ3C229Pz7cYp19R2hhO3yMTXDmsudmnurml5EfN6LhPkyx0B
   +cVFeK9cg4R2pWcHH52tnGnjKG3czrzLFpPJws/TALdCC7M+83TnLbkZ4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="337410746"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="337410746"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 04:46:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="778913220"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="778913220"
Received: from joe-255.igk.intel.com (HELO localhost) ([172.22.229.67])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 04:46:17 -0800
Date:   Tue, 8 Nov 2022 13:46:14 +0100
From:   Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH v3 1/3] drivers/accel: define kconfig and register a
 new major
Message-ID: <20221108124614.GA6397@linux.intel.com>
References: <20221106210225.2065371-1-ogabbay@kernel.org>
 <20221106210225.2065371-2-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106210225.2065371-2-ogabbay@kernel.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 11:02:23PM +0200, Oded Gabbay wrote:
> Add a new Kconfig for the accel subsystem. The Kconfig currently
> contains only the basic CONFIG_DRM_ACCEL option that will be used to
> decide whether to compile the accel registration code. Therefore, the
> kconfig option is defined as bool.
> 
> The accel code will be compiled as part of drm.ko and will be called
> directly from the DRM core code. The reason we compile it as part of
> drm.ko and not as a separate module is because of cyclic dependency
> between drm.ko and the separate module (if it would have existed).
> This is due to the fact that DRM core code calls accel functions and
> vice-versa.
> 
> The accelerator devices will be exposed to the user space with a new,
> dedicated major number - 261.
> 
> The accel init function registers the new major number as a char device
> and create corresponding sysfs and debugfs root entries, similar to
> what is done in DRM init function.
> 
> I added a new header called drm_accel.h to include/drm/, that will hold
> the prototypes of the drm_accel.c functions. In case CONFIG_DRM_ACCEL
> is set to 'N', that header will contain empty inline implementations of
> those functions, to allow DRM core code to compile successfully
> without dependency on CONFIG_DRM_ACCEL.
> 
> I Updated the MAINTAINERS file accordingly with the newly added folder
> and I have taken the liberty to appropriate the dri-devel mailing list
> and the dri-devel IRC channel for the accel subsystem.
> 
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>

Tested-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

I tested those patches with intel_vpu driver. After initial troubles,
I got things worked with our driver and user mode components.

Regards
Stanislaw
