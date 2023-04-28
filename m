Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A373E6F1047
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 04:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344786AbjD1CWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 22:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344621AbjD1CWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 22:22:11 -0400
Received: from emcscan.emc.com.tw (emcscan.emc.com.tw [192.72.220.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 748B5269D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:22:06 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,233,1677513600"; 
   d="scan'208";a="2695109"
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with ESMTP; 28 Apr 2023 10:21:56 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(80136:0:AUTH_RELAY)
        (envelope-from <jingle.wu@emc.com.tw>); Fri, 28 Apr 2023 10:21:55 +0800 (CST)
Received: from 192.168.33.11
        by webmail.emc.com.tw with Mail2000 ESMTP Server V7.00(118229:0:AUTH_RELAY)
        (envelope-from <jingle.wu@emc.com.tw>); Fri, 28 Apr 2023 10:21:53 +0800 (CST)
From:   "Jingle.Wu" <jingle.wu@emc.com.tw>
To:     "'Dmitry Torokhov'" <dmitry.torokhov@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <phoenix@emc.com.tw>, <josh.chen@emc.com.tw>,
        <dave.wang@emc.com.tw>
References: <20230320011456.986321-1-jingle.wu@emc.com.tw> <ZDBKwo4UMUm+TSnj@penguin> <000001d96b4b$6b30cda0$419268e0$@emc.com.tw> <ZEmsc0HyZuXlJARq@google.com>
In-Reply-To: <ZEmsc0HyZuXlJARq@google.com>
Subject: RE: [PATCH] Input: elan_i2c - Implement inhibit/uninhibit functions.
Date:   Fri, 28 Apr 2023 10:21:53 +0800
Message-ID: <000b01d97978$32775ca0$976615e0$@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJF62IY79PwBMHzbH32rexKKwKtngJcjz5NAs42hOUB1Ms3zK4vGXpg
Content-Language: zh-tw
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcMDYwMTFcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy02ZmQyMzM4NS1lNTZiLTExZWQtYTg2MC1mMDc5NTk2OWU3NWVcYW1lLXRlc3RcNmZkMjMzODYtZTU2Yi0xMWVkLWE4NjAtZjA3OTU5NjllNzVlYm9keS50eHQiIHN6PSIxOTM1IiB0PSIxMzMyNzEyMjExMjg5MjYxNzUiIGg9ImdWd2ZKYTFwbXluYU5yTFBxWHBBUGFCMHBVTT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry:
	During the initial process and when the users open/close device,
having the elan uninhibit/inhibit commands (low power mode) was not what
Elan expects to happen. Due to that touchpad would do the calibration in
uninhibit moment , we don't want the calibration to be affected by fingers
on the touchpad.
	However, the LID inhibit/uninhibit functions in the Linux kernel
driver calls open/close(), so we need to separate the inhibit/uninhibit
behavior from open/close() function
	
https://elixir.bootlin.com/linux/latest/source/drivers/input/input.c#L1783
	
https://elixir.bootlin.com/linux/latest/source/drivers/input/input.c#L1813

THANKS
JINGLE

-----Original Message-----
From: 'Dmitry Torokhov' [mailto:dmitry.torokhov@gmail.com] 
Sent: Thursday, April 27, 2023 6:58 AM
To: Jingle.Wu <jingle.wu@emc.com.tw>
Cc: linux-kernel@vger.kernel.org; linux-input@vger.kernel.org;
phoenix@emc.com.tw; josh.chen@emc.com.tw; dave.wang@emc.com.tw
Subject: Re: [PATCH] Input: elan_i2c - Implement inhibit/uninhibit
functions.

Hi Jingle,

On Mon, Apr 10, 2023 at 09:26:04AM +0800, Jingle.Wu wrote:
> HI Dmitry:
> 
> > +static void elan_close(struct input_dev *input_dev) {
> > +	if ((input_dev->users) && (!input_dev->inhibited))
> > +		elan_inhibit(input_dev);
> 
> This check is for "only inhibit request", and elan_open() its check is 
> for "only uninhibit request".
> Because input_dev-> open() close() will be executed 2-3 times when
initial.

I do not see why this would be an issue if what you are doing is putting the
device into a low power mode.

If this issue is about need to re-calibrate after opening the lid on certain
devices, then I think we need to do the same that we did for the I2C-HID
connected devices on Redrix and hook this functionality to a LID handler.

Thanks.

--
Dmitry

