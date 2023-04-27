Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47866F09CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbjD0Q0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbjD0Q0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:26:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EDD19B;
        Thu, 27 Apr 2023 09:26:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7629163E3D;
        Thu, 27 Apr 2023 16:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB406C433D2;
        Thu, 27 Apr 2023 16:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682612769;
        bh=Df++tyKJAEiZJoJBg/dkh2ZJQnDTPcTkRcqZSnaNxqo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VczgIKPBfA/tofbNO+AA4uGsdxQTt6HjhyqKUk2gQdhZgxiB6k8maKW8ENIR4hzvR
         PmQyYoDKjNahbSUCUVbuitAooTbkL1D2DDE1hW8I1pbe6PcvFqBRCX4v9m5PynfP0M
         qmKZjM46BZMPukSUdxMYNnBj7hDlxTLg0/WjABwJuX/qz4avkx9NgEFvXo3JdhgoDH
         xcV0f/Wf7E4G31xDEyG0PVpIAYf0pxrh8LZPTn9OXzakkpf3uSkPCo7N9SB63qrESk
         UxE/Uv2Id4mJB0OIQ97DiEM1yXqhjEcsM0FkaTQGaZi4A4FeU+f0c8ip8y3EgxohWe
         5cVHv2C4fj6Bw==
Message-ID: <dafed705-292e-6c03-7599-1b1374b95122@kernel.org>
Date:   Thu, 27 Apr 2023 19:26:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: dwc3 gadget: controller stop times out on system sleep
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <24c9f271-ed74-fffa-a49f-6e83da857593@kernel.org>
 <20230426200140.xa4unnbaw2vog2je@synopsys.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230426200140.xa4unnbaw2vog2je@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/04/2023 23:01, Thinh Nguyen wrote:
> Hi,
> 
> On Wed, Apr 26, 2023, Roger Quadros wrote:
>> Hi Thinh,
>>
>> On Linux kernel v6.3
>> Test procedure: 
>>
>> - modprobe g_zero
>> - Connect to PC host
>> - systemctl suspend
>>
>> A large delay of 3 seconds is observed. The delay comes from dwc3_gadget_suspend()->dwc3_gadget_run_stop() waiting for DWC3_DSTS_DEVCTRLHLT to be set.
>> It returns -ETIMEDOUT.
>>
>> Are we missing something to do a clean stop during suspend?
>>
>> FYI. Unloading g_zero does not show this delay on stop.
>>
>> cheers,
>> -roger
> 
> When clearing run_stop bit and the controller doesn't halt, that usually
> means there are active transfers/endpoints that aren't ended yet.
> 
> The dwc3_gadget_suspend() doesn't properly do all the cleanup before
> clearing the run_stop bit. I think you just need to call
> dwc3_gadget_soft_disconnect() in dwc3_gadget_suspend() to fix this.

That seems to do the trick.
How does this look?

-------------------------- drivers/usb/dwc3/gadget.c --------------------------
@@ -4674,11 +4676,18 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
 	unsigned long flags;
+	int ret;
 
-	if (!dwc->gadget_driver)
+	if (!dwc->gadget_driver || !dwc->softconnect)
 		return 0;
 
-	dwc3_gadget_run_stop(dwc, false, false);
+	ret = dwc3_gadget_soft_disconnect(dwc);
+	if (ret)
+		goto err0;
+
+	ret = dwc3_gadget_run_stop(dwc, false, false);
+	if (ret)
+		goto err1;
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_disconnect_gadget(dwc);
@@ -4686,6 +4695,22 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
+
+err1:
+	/*
+	 * In the Synopsys DWC_usb31 1.90a programming guide section
+	 * 4.1.9, it specifies that for a reconnect after a
+	 * device-initiated disconnect requires a core soft reset
+	 * (DCTL.CSftRst) before enabling the run/stop bit.
+	 */
+	dwc3_core_soft_reset(dwc);
+	dwc3_event_buffers_setup(dwc);
+
+	ret = dwc3_gadget_run_stop(dwc, true, false);
+
+err0:
+	dev_info(dwc->dev, "%s error %d\n", __func__, ret);
+	return ret;
 }
 
 int dwc3_gadget_resume(struct dwc3 *dwc)
@@ -4695,6 +4720,15 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 	if (!dwc->gadget_driver || !dwc->softconnect)
 		return 0;
 
+	/*
+	 * In the Synopsys DWC_usb31 1.90a programming guide section
+	 * 4.1.9, it specifies that for a reconnect after a
+	 * device-initiated disconnect requires a core soft reset
+	 * (DCTL.CSftRst) before enabling the run/stop bit.
+	 */
+	dwc3_core_soft_reset(dwc);
+	dwc3_event_buffers_setup(dwc);
+
 	ret = __dwc3_gadget_start(dwc);
 	if (ret < 0)
 		goto err0;



--
cheers,
-roger
