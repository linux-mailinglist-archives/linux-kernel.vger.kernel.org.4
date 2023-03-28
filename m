Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9516CC1BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjC1OKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjC1OKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:10:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACE6D307;
        Tue, 28 Mar 2023 07:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680012568; x=1711548568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p+jhuM41Z8A7O30nRgxLD83meAEpxjYd5HkJJ3O8Yq0=;
  b=PPqi/5lfUs954+tjLjkUQaxge/WoJMmRr3Jj+m6Co8gEz8bH6is7yVMZ
   wG+/IYSzIVy/icNnXUf868tlDlQ6voEOGYkE3WyJS0+rIuMSfmEIi5vyo
   hwmJu0mxw8tedlMFUfpEOvju3sxQSP1CHJkimxxdMPYXCTfb22/no4SpU
   F55I/gaxs6/afsP+DGszMQUcJo4OYD52fFv38YERU3wAbHTpauQZcq8+Z
   s/WeMHvhvtu4iKbV1DRA+woMS5Cxj/KqVtbLljAt1nY/sxnQhGGzLOwOv
   UDkZLbQp/ebeZC2w6RNSsLOfF1ejMOAA8CfCtgyll0Q/7yz1HCKCa60LR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="342161339"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="342161339"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 07:09:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="827491097"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="827491097"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 28 Mar 2023 07:08:57 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 28 Mar 2023 17:08:56 +0300
Date:   Tue, 28 Mar 2023 17:08:56 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux@roeck-us.net, andersson@kernel.org, robh@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] usb: typec: tcpm: Support role-switch remote
 endpoint in connector
Message-ID: <ZCL0+COeAkinuaBL@kuha.fi.intel.com>
References: <20230325011552.2241155-1-bryan.odonoghue@linaro.org>
 <20230325011552.2241155-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325011552.2241155-2-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 01:15:52AM +0000, Bryan O'Donoghue wrote:
> Right now in TCPM when we want to send a role-switch message the
> remote-endpoint must appear inside of the TCPM bound node, not in the
> connector associated with TCPM.
> 
> &typec {
> 	status = "okay";
> 
> 	port {
> 		typec_role_switch: endpoint {
> 			remote-endpoint = <&dwc3_role_switch>;
> 		};
> 	};
> 
> 	connector {
> 		compatible = "usb-c-connector";
> 
> 		power-role = "source";
> 		data-role = "dual";
> 		self-powered;
> 
> 		ports {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			port@0 {
> 				reg = <0>;
> 				typec_mux: endpoint {
> 					remote-endpoint = <&phy_typec_mux>;
> 				};
> 			};
> 		};
> 	};
> };
> 
> This change makes it possible to declare the remote-endpoint inside of the
> connector of the TCPM e.g.
> 
> &typec {
> 	status = "okay";
> 
> 	connector {
> 		compatible = "usb-c-connector";
> 
> 		power-role = "source";
> 		data-role = "dual";
> 		self-powered;
> 
> 		ports {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			port@0 {
> 				reg = <0>;
> 				typec_role_switch: endpoint {
> 					remote-endpoint = <&dwc3_role_switch>;
> 				};
> 			};
> 			port@1 {
> 				reg = <1>;
> 				typec_mux: endpoint {
> 					remote-endpoint = <&phy_typec_mux>;
> 				};
> 			};
> 		};
> 	};
> };
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 1ee774c263f08..a62fecf3bb44c 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -6515,6 +6515,7 @@ static enum hrtimer_restart send_discover_timer_handler(struct hrtimer *timer)
>  struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  {
>  	struct tcpm_port *port;
> +	struct fwnode_handle *fwnode;
>  	int err;
>  
>  	if (!dev || !tcpc ||
> @@ -6582,6 +6583,14 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  		goto out_destroy_wq;
>  	}
>  
> +	if (!port->role_sw) {
> +		fwnode = device_get_named_child_node(port->dev, "connector");

You already have that assigned to tcpc->fwnode, no?

At least drivers/usb/typec/tcpm/tcpci.c assignes it there, and I think
so do the other port controller drivers.

> +		if (fwnode) {
> +			port->role_sw = fwnode_usb_role_switch_get(fwnode);
> +			fwnode_handle_put(fwnode);
> +		}
> +	}

If that is the case, then I think this is enough:

        if (!port->role_sw)
		port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);

Or maybe I missed something. If I did then sorry for the noise :-)

thanks,

-- 
heikki
