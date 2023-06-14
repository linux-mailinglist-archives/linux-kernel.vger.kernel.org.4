Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B7672F8CA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbjFNJOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242689AbjFNJOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:14:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9FD19A;
        Wed, 14 Jun 2023 02:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686734053; x=1718270053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vWNmYjv0AVEHtHoQ50oVHbX2PauCeZ/QhwOzxPZqGhw=;
  b=KjPNSHbFvTEcSKJnbOuN6NwUmL56xjWWKyMsCsHpWOftQvEHnnOPbnCD
   rCFkdCRlCoLYhBlaHfqZNgL6tI28NNBYcqR8U8F6K5cZDHGOAl3eA6kjK
   eyhGcNM2g+pVrWdsVooofEMkPW3IT+ewaRrBsNbBDX9Mjn+B5GSg0BA/u
   cjiFtrEYmH2ZBcd9tNQ1+2hZwMXiJy8VzVRgJeVlKVvQzALhnWzXwCzGg
   9mVBnVA6B/KQ2AWiOAa0lTMcw4+vNu8F+0JdpBzNkQounqPqyTWLIaIvr
   MfhZyjkYusoBlmKMJh19bwn2V5hPgvF7Iv2D3q0tWsICz7iG7Gyjp2pOL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="422165960"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="422165960"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="856440693"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="856440693"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 14 Jun 2023 02:14:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 14 Jun 2023 12:14:08 +0300
Date:   Wed, 14 Jun 2023 12:14:08 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Message-ID: <ZImE4L3YgABnCIsP@kuha.fi.intel.com>
References: <1685544074-17337-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685544074-17337-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 08:11:14PM +0530, Prashanth K wrote:
> Currently if we bootup a device without cable connected, then
> usb-conn-gpio won't call set_role() since last_role is same as
> current role. This happens because during probe last_role gets
> initialised to zero.
> 
> To avoid this, added a new constant in enum usb_role, last_role
> is set to USB_ROLE_UNKNOWN before performing initial detection.
> 
> While at it, also handle default case for the usb_role switch
> in cdns3, intel-xhci-usb-role-switch & musb/jz4740 to avoid
> build warnings.
> 
> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> v7: Added default case in musb/jz4740.c & intel-xhci-usb-role-switch.c to
>     avoid build warnings.
> v6: Moved USB_ROLE_UNKNOWN towards the end of enum usb_role.
> v5: Update commit text to mention the changes made in cdns3 driver.
> v4: Added Reviewed-by tag.
> v3: Added a default case in drivers/usb/cdns3/core.c as pointed out by
>     the test robot.
> v2: Added USB_ROLE_UNKNWON to enum usb_role.
> 
>  drivers/usb/cdns3/core.c                       | 2 ++
>  drivers/usb/common/usb-conn-gpio.c             | 3 +++
>  drivers/usb/musb/jz4740.c                      | 2 ++
>  drivers/usb/roles/intel-xhci-usb-role-switch.c | 2 ++
>  include/linux/usb/role.h                       | 1 +
>  5 files changed, 10 insertions(+)

Just to be clear to everybody, that USB_ROLE_UNKNOWN is not handled in
drivers/usb/roles/class.c, so this patch is broken.

But the whole approach is wrong. That USB_ROLE_UNKNOWN is clearly a
flag where the other values in enum usb_role are actual switch states.
So it does not belong there.

In general, adding globals states like that just in order to work
around issues in single drivers is never a good idea IMO.

thanks,

-- 
heikki
