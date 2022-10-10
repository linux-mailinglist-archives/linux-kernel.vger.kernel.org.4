Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41655F9A33
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiJJHmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiJJHlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:41:15 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8439218E3F;
        Mon, 10 Oct 2022 00:36:31 -0700 (PDT)
X-QQ-mid: bizesmtpipv601t1665387382tp83
Received: from SJRobe ( [255.42.121.1])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Oct 2022 15:36:20 +0800 (CST)
X-QQ-SSF: 01100000000000G0Z000000A0000000
X-QQ-FEAT: +ynUkgUhZJmOErIScuxpTx/+0Yy0w+SE0SOStwMtyuLup+vynL+Az30prc0Ug
        +wzeVBNTlFUDbI3+TALPy/YBcuVY/smxl75x4UEFnR0MsE2NXAumFx73qIl2khhQxTN/R68
        gbzUL+loxLJkv5p7OcNl+f9sVvmJCZnllcOarracExwPMgxYiYTJHBXXgHvTCBakJHbNeQw
        FGMFpx9ryMSI58IO42MT13wlNAV2K3UARp0CE0CLea4rjdUpvUceh+VyzQiZ1yeKBYu5EI2
        t1i/mtz5QQAM3dO+0O8f/zwSwjEX0P56tFFX8tnk67RKp6fXSkXi1Wy4p9OJJEd3jm25+U3
        ueyPI7Wc/fvBjBkbQyeWpDb/8IJR8wZSFH++CYDJekPX/p385KmZIjUAM9F1A==
X-QQ-GoodBg: 0
From:   "Soha Jin" <soha@lohu.info>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        "'Rob Herring'" <robh+dt@kernel.org>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Daniel Scally'" <djrscally@gmail.com>,
        "'Heikki Krogerus'" <heikki.krogerus@linux.intel.com>,
        "'Sakari Ailus'" <sakari.ailus@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20221009162155.1318-1-soha@lohu.info> <20221009162155.1318-2-soha@lohu.info> <Y0MR+uSDEm2bPgcD@kroah.com> <EE2940315EA6EAA4+1b3101d8dc54$c2f83680$48e8a380$@lohu.info> <Y0O6kDQ9Bxi9jMfo@kroah.com>
In-Reply-To: <Y0O6kDQ9Bxi9jMfo@kroah.com>
Subject: RE: [PATCH 1/3] string: add match_string_nocase() for case-insensitive match
Date:   Mon, 10 Oct 2022 15:36:17 +0800
Message-ID: <9963070D38F093DB+25d201d8dc7a$fca3e570$f5ebb050$@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ3YxYd+FPcuiJVmWEOx+0wAFDAtAEC1QTIAidE924DQPre+AIsXv4YrIVsQLA=
Content-Language: fr
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:lohu.info:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Andy,

> From: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
> Sent: Monday, October 10, 2022 2:24 PM
> 
> > I am writing regarding the compatibility. In
> > `of_device_is_compatible`, it uses `of_compat_cmp` which calls
> `strcasecmp` to match compatible property.
> >
> > As the `fwnode_is_compatible` should be the replacement of the OF way,
> > I think we should make the fwnode way and the OF way the same, i.e.
> > either both case-insensitive or case-sensitive, to keep the
> > consistency. I am afraid that make `of_compat_cmp` case-sensitive may
> > break a great many of devices, that is why I am doing this.
> 
> Ok, but if you change this with the series, what will break? 

My changeset will not break something, and make comparison case-sensitive
does. Some old device firmwares that did not care about letter case might
not function correctly in a newer kernel, because the current kernel checks
compatibility case-insensitively and the former developer did not notice
this with the just working kernel.

> What needs this
> new case-insensitive comparison that does not work today?

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Monday, October 10, 2022 2:24 PM
> 
> So, why do we have such in the OF code and do we really need it in the
> modern world?

Frankly speaking, I think case-insensitive comparison is not needed TODAY,
and before I compose this change, I can see codes in kernel like this:
    of_device_is_compatible(np, "U4-pcie") ||
    of_device_is_compatible(np, "u4-pcie")
which means kernel codes is de facto case-sensitive, although this function
calls `strcasecmp`.

I do not know kernel maintainers' mind when I am composing this change, I
just chose the way which will not break anything. Anyway, I am also glad to
edit the patch to make it case-sensitive once maintainers have made the
final decision.

Regards,
Soha

