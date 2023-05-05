Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C116F8109
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjEEKu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjEEKuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:50:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29865F4;
        Fri,  5 May 2023 03:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683283853; x=1714819853;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=ni/vJgiG6XHfX4g7uVzKoHiKBa270MzkVO6QSlgMSB8=;
  b=Mok0mXZbDE/F7skYfaLDy257RA9plQ717XTzF4C8UjIdaDUT4ybqlPi2
   Ytpie7O2Z5PdgqxLHKWtYCHiuF4ExzJfdWCqAQpZLRKI07mTOV0tH71+S
   0R77+nlX19xFFNIAoilIFZjkSs7J86hvfFEkMppOxn0azOW4i9haan5J0
   ezN7L05Xiu1r+vxgzXSOCRQaEPH3CdlowBp/dxMrmn7GS3hHlgXObA4un
   vA49Cz/lfNGMIRtUs/uQPVZn33xfpX6sk+gYEMXJGx5K22ig02DQWJiSx
   i9gHngkfR/RqaUnZQdkkA2hj/CT3qe/w5UBEcdk5kCdSsLk6kJsH+Uaif
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="412411064"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="412411064"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 03:50:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="871775693"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="871775693"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga005.jf.intel.com with ESMTP; 05 May 2023 03:50:50 -0700
Message-ID: <f6689241-9749-28a2-6da4-842f3253c678@linux.intel.com>
Date:   Fri, 5 May 2023 13:52:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Content-Language: en-US
To:     Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tonywwang@zhaoxin.com, weitaowang@zhaoxin.com
References: <20230421203853.387210-1-WeitaoWang-oc@zhaoxin.com>
 <20230421203853.387210-4-WeitaoWang-oc@zhaoxin.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2 3/4] xhci: Show zhaoxin xHCI root hub speed correctly
In-Reply-To: <20230421203853.387210-4-WeitaoWang-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.4.2023 23.38, Weitao Wang wrote:
> Some zhaoxin xHCI controllers follow usb3.1 spec,
> but only support gen1 speed 5G. While in Linux kernel,
> if xHCI suspport usb3.1,root hub speed will show on 10G.
> To fix this issue of zhaoxin xHCI platforms, read usb speed ID
> supported by xHCI to determine root hub speed.
> 
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
> ---
>   drivers/usb/host/xhci.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 6307bae9cddf..31d6ace9cace 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -5294,6 +5294,7 @@ static void xhci_hcd_init_usb2_data(struct xhci_hcd *xhci, struct usb_hcd *hcd)
>   static void xhci_hcd_init_usb3_data(struct xhci_hcd *xhci, struct usb_hcd *hcd)
>   {
>   	unsigned int minor_rev;
> +	unsigned int i, j;
>   
>   	/*
>   	 * Early xHCI 1.1 spec did not mention USB 3.1 capable hosts
> @@ -5323,6 +5324,27 @@ static void xhci_hcd_init_usb3_data(struct xhci_hcd *xhci, struct usb_hcd *hcd)
>   		hcd->self.root_hub->ssp_rate = USB_SSP_GEN_2x1;
>   		break;
>   	}
> +
> +	/* Usb3.1 has gen1 and gen2, Some zhaoxin's xHCI controller
> +	 * that follow usb3.1 spec but only support gen1.
> +	 */
> +	if (xhci->quirks & XHCI_ZHAOXIN_HOST) {
> +		minor_rev = 0;
> +		for (j = 0; j < xhci->num_port_caps; j++) {
> +			for (i = 0; i < xhci->port_caps[j].psi_count; i++) {
> +				if (XHCI_EXT_PORT_PSIV(xhci->port_caps[j].psi[i]) >= 5) {
> +					minor_rev = 1;
> +					break;
> +				}
> +			}
> +			if (minor_rev)
> +				break;
> +		}
> +		if (minor_rev != 1) {
> +			hcd->speed = HCD_USB3;
> +			hcd->self.root_hub->speed = USB_SPEED_SUPER;
> +		}
> +	}
>   	xhci_info(xhci, "Host supports USB 3.%x %sSuperSpeed\n",
>   		  minor_rev, minor_rev ? "Enhanced " : "");
>   

How about checking if port support over 5Gbps (psiv >= 5) when we parse the protocol speed ID
entries the first time? This way we could avoid looping through all the port_cap psiv values.

Something like:

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index c4170421bc9c..2e4c80eb4972 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1961,7 +1961,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
  {
         u32 temp, port_offset, port_count;
         int i;
-       u8 major_revision, minor_revision;
+       u8 major_revision, minor_revision, tmp_minor_revision;
         struct xhci_hub *rhub;
         struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
         struct xhci_port_cap *port_cap;
@@ -1981,6 +1981,11 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
                  */
                 if (minor_revision > 0x00 && minor_revision < 0x10)
                         minor_revision <<= 4;
+               if (xhci->quirks & XHCI_ZHAOXIN_HOST) {
+                       tmp_minor_revision = minor_revision;
+                       minor_revision = 0;
+               }
+
         } else if (major_revision <= 0x02) {
                 rhub = &xhci->usb2_rhub;
         } else {
@@ -1989,10 +1994,6 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
                 /* Ignoring port protocol we can't understand. FIXME */
                 return;
         }
-       rhub->maj_rev = XHCI_EXT_PORT_MAJOR(temp);
-
-       if (rhub->min_rev < minor_revision)
-               rhub->min_rev = minor_revision;
  
         /* Port offset and count in the third dword, see section 7.2 */
         temp = readl(addr + 2);
@@ -2010,8 +2011,6 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
         if (xhci->num_port_caps > max_caps)
                 return;
  
-       port_cap->maj_rev = major_revision;
-       port_cap->min_rev = minor_revision;
         port_cap->psi_count = XHCI_EXT_PORT_PSIC(temp);
  
         if (port_cap->psi_count) {
@@ -2032,6 +2031,10 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
                                   XHCI_EXT_PORT_PSIV(port_cap->psi[i - 1])))
                                 port_cap->psi_uid_count++;
  
+                       if (xhci->quirks & XHCI_ZHAOXIN_HOST &&
+                           XHCI_EXT_PORT_PSIV(port_cap->psi[i]) >= 5)
+                               minor_revision = tmp_minor_revision;
+
                         xhci_dbg(xhci, "PSIV:%d PSIE:%d PLT:%d PFD:%d LP:%d PSIM:%d\n",
                                   XHCI_EXT_PORT_PSIV(port_cap->psi[i]),
                                   XHCI_EXT_PORT_PSIE(port_cap->psi[i]),
@@ -2041,6 +2044,15 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
                                   XHCI_EXT_PORT_PSIM(port_cap->psi[i]));
                 }
         }
+
+       rhub->maj_rev = major_revision;
+
+       if (rhub->min_rev < minor_revision)
+               rhub->min_rev = minor_revision;
+
+       port_cap->maj_rev = major_revision;
+       port_cap->min_rev = minor_revision;
+
         /* cache usb2 port capabilities */
         if (major_revision < 0x03 && xhci->num_ext_caps < max_caps)
                 xhci->ext_caps[xhci->num_ext_caps++] = temp;

Thanks
Mathias
