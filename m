Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928415BCC1B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiISMpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiISMpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:45:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA0C2A70E;
        Mon, 19 Sep 2022 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663591547; x=1695127547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nTdFWlp48VZPIupFKHt9Tiw7GdXCoXMKvJ7imFE6yPI=;
  b=BIYpYxak9D0Vae2xMQytEWAA9e7mj0Wo646ACuQ6q0OqvbXCrfj/g887
   fYU5SgDghDsP3R0uZdpjgte3g73Gx34WJC51KyzHwE/lONyc3/yAmRD7W
   HBUguyn4wjLahS7kfgHX5AlU4O8NGu387Pf23a4yVul9bkENbnK3RNYRb
   CQTpkYj8o3eWepbFDwcj5l3Mqt9nqb059tf2POPEf+q70c0ZDlRhN7Ucb
   A56sUXdvQuE88bjCL4jUmeprFLuOY+kPJ8PIqpzQiz/1xIKNfwBcz7a1p
   0g1li46ldyjbsAlHrGTAFvzqqwca1pU8Se+CRyxgLYp0x6bN8H0tl/ASS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="385678401"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="385678401"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 05:45:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="613985517"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 05:45:44 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 6FB16202D2;
        Mon, 19 Sep 2022 15:45:42 +0300 (EEST)
Date:   Mon, 19 Sep 2022 12:45:42 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, laurent.pinchart+renesas@ideasonboard.com,
        akinobu.mita@gmail.com, jacopo+renesas@jmondi.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] media: mt9m111: fix device power usage
Message-ID: <YyhkdtFzXn36AytN@paasikivi.fi.intel.com>
References: <20220916135713.143890-1-m.felsch@pengutronix.de>
 <20220916135713.143890-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916135713.143890-2-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Fri, Sep 16, 2022 at 03:57:12PM +0200, Marco Felsch wrote:
> @@ -758,10 +751,14 @@ static int mt9m111_g_register(struct v4l2_subdev *sd,
>  	if (reg->reg > 0x2ff)
>  		return -EINVAL;
>  
> +	mt9m111_s_power(sd, 1);

It would be nice to have this driver converted to runtime PM. Up to you.

-- 
Sakari Ailus
