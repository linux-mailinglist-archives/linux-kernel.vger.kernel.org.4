Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C786ABA0D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjCFJjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCFJjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:39:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996E8231FB;
        Mon,  6 Mar 2023 01:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678095558; x=1709631558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H0vudKCEv+648TR8R5/Nekbb3fSSrqwQNldZiKE3Fq8=;
  b=mag4xD1tPpQnqf9K7kFqS6Ns1PB7p92jxVFw1+8vV4egy/5h/SzNnIRQ
   bdVclnDxymYB92mg/CoX8/XrZHN7XobXK6mimaEv8PCFq+56D5xK0ZZ/x
   3WR83AW970a3M/NT4jhjNh1sb17LyLfz0urkLLTk0dehrZA0eVRr7KAK2
   uaFxDchhWKRC3KrMKPwF0Nfl437o8O7eE26mW4VJe6Rb2B1h4euQuUzp0
   UFEe/ijCyWf3Kg6eLK6pucDQxUcH/Xvg3gFoN7V+yKH9Qgceq5qZ/TxUH
   bTLjAF3AXu9s+/UYmm5ZHoa/H/avFAlaLYJGCkoQfpX4pzeWMr7hBsnFJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="337029375"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="337029375"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 01:39:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="819244394"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="819244394"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 06 Mar 2023 01:39:13 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 06 Mar 2023 11:39:12 +0200
Date:   Mon, 6 Mar 2023 11:39:12 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 2/4] usb: typec: tipd: Remove use of
 fw_devlink_purge_absent_suppliers()
Message-ID: <ZAW0wNt634Ipja+A@kuha.fi.intel.com>
References: <20230301214952.2190757-1-saravanak@google.com>
 <20230301214952.2190757-3-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301214952.2190757-3-saravanak@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 01:49:49PM -0800, Saravana Kannan wrote:
> After recent changes to fw_devlink that ended with commit 4a032827daa8
> ("of: property: Simplify of_link_to_phandle()"), fw_devlink no longer
> cares about the "compatible" property and figures out the correct struct
> device at runtime. So, we no longer need to call
> fw_devlink_purge_absent_suppliers().
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Cc: Martin Kepplinger <martin.kepplinger@puri.sm>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 485b90c13078..92401622bc4e 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -764,16 +764,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		goto err_clear_mask;
>  
> -	/*
> -	 * This fwnode has a "compatible" property, but is never populated as a
> -	 * struct device. Instead we simply parse it to read the properties.
> -	 * This breaks fw_devlink=on. To maintain backward compatibility
> -	 * with existing DT files, we work around this by deleting any
> -	 * fwnode_links to/from this fwnode.
> -	 */
>  	fwnode = device_get_named_child_node(&client->dev, "connector");
> -	if (fwnode)
> -		fw_devlink_purge_absent_suppliers(fwnode);
>  
>  	tps->role_sw = fwnode_usb_role_switch_get(fwnode);
>  	if (IS_ERR(tps->role_sw)) {
> -- 
> 2.39.2.722.g9855ee24e9-goog

-- 
heikki
