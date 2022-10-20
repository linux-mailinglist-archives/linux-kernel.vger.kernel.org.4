Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FB2606715
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJTReA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Oct 2022 13:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJTRd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:33:56 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA981DB261;
        Thu, 20 Oct 2022 10:33:55 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 993AB20002;
        Thu, 20 Oct 2022 17:33:53 +0000 (UTC)
Message-ID: <d2085225eb652a885b9c2b5700175ab820a35a35.camel@hadess.net>
Subject: Re: [PATCH] Add rumble support to latest xbox controllers
From:   Bastien Nocera <hadess@hadess.net>
To:     Siarhei Vishniakou <svv@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 20 Oct 2022 19:33:53 +0200
In-Reply-To: <20221020161401.941927-1-svv@google.com>
References: <20221020161401.941927-1-svv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.0 (3.46.0-2.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-20 at 09:14 -0700, Siarhei Vishniakou wrote:
> Currently, rumble is only supported via bluetooth on a single xbox
> controller, called 'model 1708'. On the back of the device, it's
> named
> 'wireless controller for xbox one'. However, in 2021, Microsoft
> released
> a firmware update for this controller. As part of this update, the
> HID
> descriptor of the device changed. The product ID was also changed
> from
> 0x02fd to 0x0b20. On this controller, rumble was supported via
> hid-microsoft, which matched against the old product id (0x02fd). As
> a
> result, the firmware update broke rumble support on this controller.
> 
> The hid-microsoft driver actually supports rumble on the new
> firmware,
> as well. So simply adding new product id is sufficient to bring back
> this support.
> 
> After discussing further with the xbox team, it was pointed out that
> other xbox controllers, such as xbox elite, should also be possible
> to
> support in a similar way. However, I could only verify this on 2
> controllers so far.
> 
> In this patch, add rumble support for the following 2 controllers:
> 1. 'wireless controller for xbox one', model 1708, after applying the
>    most recent firmware update as of 2022-10-20.
> 2. 'xbox wireless controller', model 1914. This is also sometimes
>    referred to as 'xbox series S|X'.

This is a good summary of the different models:
https://en.wikipedia.org/wiki/Xbox_Wireless_Controller#Summary

You can remove the mention of the other names it might have, or the
names at the back of the joypad, and use the model numbers instead.

I think I have a model of each one of the devices in the list (except
1797 and 1537 IIRC), so I could test this if needed. Do you have a good
test case for the various forces of rumble that would exercise both
motors?
