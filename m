Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D6065B06E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjABLUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjABLUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:20:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635956398
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672658408; x=1704194408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3cq0L5Iv2/i9BXBd9J/fMEC34Ut39Q9wrLY1eKunmx0=;
  b=Zrz7b5MsbQJFoZekBEQLogmbpTf8yBtSh1UNTzznQ706T44Xj89SPYMf
   YtfGAf/t0BtIM4qZ5EbFcCGfkYvVKdyVjpRBs27ROd7NWB7VVH+UY15y9
   1Yo7aKVOp3JvJwVfttmU3T02Qi7ga0NYfGKiVC+43BeZhd8Qug96hbyTK
   ysfwuj85yxSEtEjWxs3KUOKakbvEhaKk8pjaTOUSxcG56jXAk+Ajhtfym
   k3807USFAKZj61a++NkrdD3VHOyodoMRZdhhEYQHZJvX+dZVcZb+rvh9j
   pVydBIhMf+0zEUHZfzFl1gNCZ4Qd1NHU68xibtnjtas0QZrSM4zfakN+k
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="385903227"
X-IronPort-AV: E=Sophos;i="5.96,293,1665471600"; 
   d="scan'208";a="385903227"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 03:20:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10577"; a="796845036"
X-IronPort-AV: E=Sophos;i="5.96,293,1665471600"; 
   d="scan'208";a="796845036"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Jan 2023 03:20:02 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 02 Jan 2023 13:20:01 +0200
Date:   Mon, 2 Jan 2023 13:20:01 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Evan Green <evgreen@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, Lee Jones <lee@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: Re: [PATCH 00/10] platform/chrome: cros_ec_typec: VDM support
Message-ID: <Y7K94bWTsJ0r28f9@kuha.fi.intel.com>
References: <20221228004648.793339-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228004648.793339-1-pmalani@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 12:45:03AM +0000, Prashant Malani wrote:
> This series adds support for sending and receiving USB PD Vendor
> Defined Messages (VDMs) between the Application Processor's Type-C
> ports and connected peripherals.
> 
> Thir enables the Application processor to enter alternate modes and
> process VDMs directly, instead of relying on state machines that exist
> inside of co-processors like the ChromeOS Embedded Controller (EC).
> 
> Patch 1/10 reverts an incorrect EC header modification.
> Patch 2/10 to 5/10 update headers and existing Type-C structs to
> accommodate the VDM code.
> Patch 6/10 and 7/10 prepare the Type-C driver to have more than 1 file.
> Patch 8/10 to 10/10 introduce the VDM functionality.
> 
> Patch submissions suggestion (if approved):
> - Even though Patch 1 touches drivers/mfd, it would be better to take
>   the entire series through the cbrome-platform branch, to avoid
>   cross-dependencies across maintainer trees.

For the whole series, FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> Prashant Malani (10):
>   Revert "mfd: cros_ec: Add SCP Core-1 as a new CrOS EC MCU"
>   platform_chrome: cros_ec: Add Type-C VDM defines
>   platform/chrome: cros_ec_typec: Stash port driver info
>   platform/chrome: cros_ec_typec: Set port alt mode drvdata
>   platform/chrome: cros_ec_typec: Update port DP VDO
>   platform/chrome: cros_ec_typec: Move structs to header
>   platform/chrome: cros_ec_typec: Alter module name with hyphens
>   platform/chrome: cros_ec_typec: Add initial VDM support
>   platform/chrome: cros_typec_vdm: Add VDM reply support
>   platform/chrome: cros_typec_vdm: Add VDM send support
> 
>  MAINTAINERS                                   |   3 +-
>  drivers/mfd/cros_ec_dev.c                     |   5 -
>  drivers/platform/chrome/Kconfig               |   2 +-
>  drivers/platform/chrome/Makefile              |   3 +-
>  drivers/platform/chrome/cros_ec_typec.c       |  91 +++------------
>  drivers/platform/chrome/cros_ec_typec.h       |  85 ++++++++++++++
>  drivers/platform/chrome/cros_typec_vdm.c      | 106 ++++++++++++++++++
>  drivers/platform/chrome/cros_typec_vdm.h      |  12 ++
>  .../linux/platform_data/cros_ec_commands.h    |  53 ++++++++-
>  include/linux/platform_data/cros_ec_proto.h   |   1 -
>  10 files changed, 276 insertions(+), 85 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_ec_typec.h
>  create mode 100644 drivers/platform/chrome/cros_typec_vdm.c
>  create mode 100644 drivers/platform/chrome/cros_typec_vdm.h

-- 
heikki
