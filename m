Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2C06B818E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjCMTP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCMTPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:15:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D969A233F6;
        Mon, 13 Mar 2023 12:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678734906; x=1710270906;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CnRGi2DlXQHfjc8Y7yJwp04BFPdrnOE5EboKtIok3mM=;
  b=YiJzlyJxPJSQbqBWbO9ztCgPJVykLkaTQNbJj7/tPS0hbxyoRNbV7GF5
   qBTr5MgUk1ip7bJI9Mo02g2lJTBknGlhud/+3f0QwoRm2CvWepiOiwfjl
   DzfKcoFk6mVKdLMTFcrCcsxgrqUbELcSdEvi+gT/SL55FXCrVNwVGEkmu
   lFFsYwcQnEGq0axblY2aLz9HdV9PRvr1xDceWz2SA+QlX4EMh1EnQ5yBh
   TRWuL5J0HjwvhqFZPBDWMmgyaawq9FfW842qJIYf8HNm2UP7gQDo8q+DX
   76Elrpg85utpXBpQqyC1HJ8CS1XcaxPsLAi7yNqWy2Vqp33cCVqTdHXbM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316879856"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="316879856"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 12:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="708990227"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="708990227"
Received: from igodinez-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.87.244])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 12:14:33 -0700
Message-ID: <cb7a82e9becb35231ac87681a1861348bd27047d.camel@linux.intel.com>
Subject: Re: [PATCH 05/36] platform/x86: intel-uncore-freq: move to use
 bus_get_dev_root()
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
Date:   Mon, 13 Mar 2023 12:14:32 -0700
In-Reply-To: <20230313182918.1312597-5-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
         <20230313182918.1312597-5-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-13 at 19:28 +0100, Greg Kroah-Hartman wrote:
> Direct access to the struct bus_type dev_root pointer is going away
> soon
> so replace that with a call to bus_get_dev_root() instead, which is
> what
> it is there for.
> 
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2
> on
> its own, but I'd prefer if I could take it through my driver-core
> tree
> so that the driver core changes can be taken through there for 6.4-
> rc1.
> 
>  .../intel/uncore-frequency/uncore-frequency-common.c | 12 +++++++++-
> --
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-
> frequency-common.c b/drivers/platform/x86/intel/uncore-
> frequency/uncore-frequency-common.c
> index cb24de9e97dc..1a300e14f350 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> common.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> common.c
> @@ -224,9 +224,15 @@ int uncore_freq_common_init(int
> (*read_control_freq)(struct uncore_data *data, u
>         uncore_write = write_control_freq;
>         uncore_read_freq = read_freq;
>  
> -       if (!uncore_root_kobj)
> -               uncore_root_kobj =
> kobject_create_and_add("intel_uncore_frequency",
> -                                                          
> &cpu_subsys.dev_root->kobj);
> +       if (!uncore_root_kobj) {
> +               struct device *dev_root =
> bus_get_dev_root(&cpu_subsys);
> +
> +               if (dev_root) {
> +                       uncore_root_kobj =
> kobject_create_and_add("intel_uncore_frequency",
> +                                                                
> &dev_root->kobj);
> +                       put_device(dev_root);
> +               }
> +       }
>         if (uncore_root_kobj)
>                 ++uncore_instance_count;
>         mutex_unlock(&uncore_lock);

