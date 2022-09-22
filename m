Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DC15E6593
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiIVOaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiIVOaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:30:14 -0400
Received: from radex-web.radex.nl (smtp.radex.nl [178.250.146.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53B8C9C2ED;
        Thu, 22 Sep 2022 07:30:11 -0700 (PDT)
Received: from [192.168.1.35] (cust-178-250-146-69.breedbanddelft.nl [178.250.146.69])
        by radex-web.radex.nl (Postfix) with ESMTPS id 1872B2408B;
        Thu, 22 Sep 2022 16:30:10 +0200 (CEST)
Message-ID: <b533e337-3d5f-c514-f0d1-e4684e3a5d64@gmail.com>
Date:   Thu, 22 Sep 2022 16:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon is
 present
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com>
Content-Language: en-US
In-Reply-To: <Yyw0K/hcTZ02UP+A@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NICE_REPLY_A,NML_ADSP_CUSTOM_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Resending this due to html reject, sorry.

On 22-09-2022 12:08, Andy Shevchenko wrote:
> On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
>> If the extcon device exists, get the mode from the extcon device. If
>> the controller is DRD and the driver is unable to determine the mode,
>> only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
> According to Ferry (Cc'ed) this broke Intel Merrifield platform. Ferry, can you
> share bisect log?

I can but not right now. But what I did was bisect between 5.18.0 (good) 
and 5.19.0 (bad) then when I got near the culprit (~20 remaining) based 
on the commit message I tried 0f01017191384e3962fa31520a9fd9846c3d352f 
"usb: dwc3: Don't switch OTG -> peripheral if extcon is present" (bad) 
and commit before that (good).

The effect of the patch is that on Merrifield (I tested with Intel 
Edison Arduino board which has a HW switch to select between host and 
device mode) device mode works but in host mode USB is completely not 
working.

Currently on host mode - when working - superfluous error messages from 
tusb1210 appear. When host mode is not working there are no tusb1210 
messages in the logs / on the console at all. Seemingly tusb1210 is not 
probed, which points in the direction of a relation to extcon.

> Taking into account the late cycle, I would like to revert the change. And
> Ferry and I would help to test any other (non-regressive) approach).
>
I have not yet tested if a simple revert fixes the problem but will tonight.


I would be happy to test other approaches too.
