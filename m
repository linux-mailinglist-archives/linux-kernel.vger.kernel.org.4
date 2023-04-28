Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EAC6F151C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346028AbjD1KPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjD1KPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:15:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B181735;
        Fri, 28 Apr 2023 03:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682676942; x=1714212942;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=tY9j7XHZcOIvj/nj6JIdGLwj6rLfskNHJD+KKLvaILA=;
  b=kLcpJLvVO4DN+AGlcXsf0AuxwJcC9EXMWJRVPKWobb6cjnsHGIVRygni
   vpAY3B23RWdNbX5JwL+F4aPA101mFRnigtGs36JC1JkjhKstm/6B9Q3cE
   jOmf9d42y+xnQDfOZ5DH+RX9S2OfLmwhLK8cOXVHGCFeIrHWRi3911uut
   5hBCO7iWvBNv41BSiZaWQtazNAI1wfwl3F2crRmFr7aciEvXX6UL7Uef4
   F2jD5kmSwPvpHB/uG0Alico9C7pzOARcsxxZVBXPg5aWE7UA4+vQHrgu5
   IXDqtBuZIUD2L9d8kh7XamZpSe93n7X+lZh8KRlWy75qIFCYqZ8KsuEJc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="328044862"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="328044862"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 03:15:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="1024561051"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="1024561051"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 28 Apr 2023 03:15:40 -0700
Message-ID: <c22e7751-0367-a7e6-1fa5-c5afe5df7808@linux.intel.com>
Date:   Fri, 28 Apr 2023 13:17:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230427190145.4623-1-quic_wcheng@quicinc.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] usb: host: xhci: Avoid XHCI resume delay if SSUSB device
 is not present
In-Reply-To: <20230427190145.4623-1-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.4.2023 22.01, Wesley Cheng wrote:
> There is a 120ms delay implemented for allowing the XHCI host controller to
> detect a U3 wakeup pulse.  The intention is to wait for the device to retry
> the wakeup event if the USB3 PORTSC doesn't reflect the RESUME link status
> by the time it is checked.  As per the USB3 specification:
> 
>    tU3WakeupRetryDelay ("Table 7-12. LTSSM State Transition Timeouts")
> 
> This would allow the XHCI resume sequence to determine if the root hub
> needs to be also resumed.  However, in case there is no device connected,
> or if there is only a HSUSB device connected, this delay would still affect
> the overall resume timing.
> 
> Since this delay is solely for detecting U3 wake events (USB3 specific)
> then ignore this delay for the disconnected case and the HSUSB connected
> only case.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>   drivers/usb/host/xhci.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 78790dc13c5f..7a86cd683502 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -834,7 +834,8 @@ static bool xhci_pending_portevent(struct xhci_hcd *xhci)
>   	while (port_index--) {
>   		portsc = readl(ports[port_index]->addr);
>   		if (portsc & PORT_CHANGE_MASK ||
> -		    (portsc & PORT_PLS_MASK) == XDEV_RESUME)
> +		    (portsc & PORT_PLS_MASK) == XDEV_RESUME ||
> +		    !(portsc & PORT_CONNECT))
>   			return true;
This change will report a pending port event at the first empty roothub port.

I think we are looking for something like this instead (pseudo):

@@ -1116,7 +1116,7 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
                  * the first wake signalling failed, give it that chance.
                  */
                 pending_portevent = xhci_pending_portevent(xhci);
-               if (!pending_portevent) {
+               if (!pending_portevent && usb3_devices_connected && runtime_resume) {
                         msleep(120);
                         pending_portevent = xhci_pending_portevent(xhci);
                 }

Thanks
Mathias

