Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A3F7278BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbjFHHZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjFHHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:25:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C43D9E;
        Thu,  8 Jun 2023 00:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686209156; x=1717745156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sfNmgmPMVanuLL+3q2wGUF5ZoGfwANQwAmBIQBrBi1s=;
  b=WqB4QfEOUxS6+3zlu+Z6G4VyxvFCk53CkfoU/XFeIn4LNxYe2dTeN5yx
   w0u0W2f8nhB38lw3Rho64XJrGmhFIjpvWHEeFb+ysPo9dYxhsOQenprXg
   OyfkyGXLTPGGUWbwaUKci5jPPQmg53ehQwnFbUIC1FAAj2rvzs0qff4j3
   +mdGEG7TjpF1fzs6s+Eaf/bHFFCKuxKdgO1Yq8Q4walOQswCoigeImbPy
   On5KddHbNq7zkzdHRzSib4bxU8P7PZwID5lQzNA0zipxyl0iDiGiBkr/+
   W5h1LSk0pip2rY7qQrDNqvKK2ZXi2vhTo05iB5bQQ65oznvQZFSxZpiNU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="420799361"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="420799361"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 00:25:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="854237340"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="854237340"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 08 Jun 2023 00:25:53 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Jun 2023 10:25:52 +0300
Date:   Thu, 8 Jun 2023 10:25:52 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Pavan Holla <pholla@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bleung@chromium.org, pmalani@chromium.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: Fix fast_role_swap_current show function
Message-ID: <ZIGCgBfb3UUfvhrc@kuha.fi.intel.com>
References: <2023060611-coach-entitle-d4e4@gregkh>
 <20230607193328.3359487-1-pholla@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607193328.3359487-1-pholla@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 07:33:26PM +0000, Pavan Holla wrote:
> The current implementation mistakenly performs a & operation on
> the output of sysfs_emit. This patch performs the & operation before
> calling sysfs_emit.
> 
> Fixes: 662a60102c12 ("usb: typec: Separate USB Power Delivery from USB Type-C")
> Reported-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Pavan Holla <pholla@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/pd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
> index 0bcde1ff4d39..8cc66e4467c4 100644
> --- a/drivers/usb/typec/pd.c
> +++ b/drivers/usb/typec/pd.c
> @@ -95,7 +95,7 @@ peak_current_show(struct device *dev, struct device_attribute *attr, char *buf)
>  static ssize_t
>  fast_role_swap_current_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	return sysfs_emit(buf, "%u\n", to_pdo(dev)->pdo >> PDO_FIXED_FRS_CURR_SHIFT) & 3;
> +	return sysfs_emit(buf, "%u\n", (to_pdo(dev)->pdo >> PDO_FIXED_FRS_CURR_SHIFT) & 3);
>  }
>  static DEVICE_ATTR_RO(fast_role_swap_current);
>  
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog

-- 
heikki
