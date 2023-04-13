Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8A76E0B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjDMKRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjDMKRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:17:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB7D8A46;
        Thu, 13 Apr 2023 03:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681381048; x=1712917048;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=REU7xvvp4/yPLj0SRKMympYAFmOVApNx2qAjvW28LKk=;
  b=KJr+rEQfFZJgaXBtRqwLASYY0Y8r3f/buzgZ2r5e/D31hkxXiLxb8+MB
   JtfIzFgulMfm4+04fSottbq5h/VTWR0v7bWSoBfEqtp/6DW7MYhmP40CW
   aySjnjJNHwAqCOSxvHtTAm/Y+P9SimW+zOQ0NLBJxa9FxV8uNEt6ywLvJ
   O8pik4OJzplpP6SfUwG1gKYtYjl7v+yOmZJFloLonCu+qBY2Mu7l6A8zc
   0Fsr4XDccBzP93xjnp5g9ZzinBhWza8kryrF1/6qzEGA6ZGF8VhZrjMhu
   hFSGaIWsyBwPC0g/L/qvWpa0adls8OL00nR2WFAJZMxB1JOad0JUTYCHL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="324503422"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="324503422"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 03:17:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="813409927"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="813409927"
Received: from pkudryav-mobl1.ger.corp.intel.com ([10.252.45.220])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 03:17:20 -0700
Date:   Thu, 13 Apr 2023 13:17:18 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/intel/sdsi: Change mailbox timeout
In-Reply-To: <20230413013230.1521584-1-david.e.box@linux.intel.com>
Message-ID: <66b5cf7-391-8d63-b7da-267fe8a639bd@linux.intel.com>
References: <20230413013230.1521584-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1122177158-1681381042=:1987"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1122177158-1681381042=:1987
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 12 Apr 2023, David E. Box wrote:

> On some platforms, it may take up to 400ms for the ready bit to be set in a
> successful mailbox transaction. Set the timeout to 500ms to cover the worst
> case.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/sdsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
> index 9e0ea2cdd704..556e7c6dbb05 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -49,7 +49,7 @@
>  #define SDSI_MBOX_CMD_SUCCESS		0x40
>  #define SDSI_MBOX_CMD_TIMEOUT		0x80
>  
> -#define MBOX_TIMEOUT_US			2000
> +#define MBOX_TIMEOUT_US			500000
>  #define MBOX_TIMEOUT_ACQUIRE_US		1000
>  #define MBOX_POLLING_PERIOD_US		100
>  #define MBOX_ACQUIRE_NUM_RETRIES	5

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1122177158-1681381042=:1987--
