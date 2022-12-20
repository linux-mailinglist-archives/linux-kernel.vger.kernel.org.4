Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84A7651AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiLTGYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiLTGYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:24:33 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9D413E14;
        Mon, 19 Dec 2022 22:24:31 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p7W3B-0000Cx-FN; Tue, 20 Dec 2022 07:24:29 +0100
Message-ID: <3c03d717-7965-9d11-8dcd-0ccc3477d835@leemhuis.info>
Date:   Tue, 20 Dec 2022 07:24:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] usb: misc: onboard_usb_hub: Don't defer probing for
 'incomplete' DT nodes
Content-Language: en-US, de-DE
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
References: <20221220004427.1.If5e7ec83b1782e4dffa6ea759416a27326c8231d@changeid>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20221220004427.1.If5e7ec83b1782e4dffa6ea759416a27326c8231d@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1671517471;40c50abb;
X-HE-SMSGID: 1p7W3B-0000Cx-FN
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

On 20.12.22 01:45, Matthias Kaehlcke wrote:
> Some boards have device tree nodes for USB hubs supported by the
> onboard_usb_hub driver, but the nodes don't have all properties
> needed for the driver to work properly (which is not necessarily
> an error in the DT). Currently _find_onboard_hub() returns
> -EPROBE_DEFER in such cases, which results in an unusable USB hub,
> since successive probes fail in the same way. Use the absence of
> the "vdd" supply as an indicator of such 'incomplete' DT nodes
> and return -ENODEV.
> 
> Fixes: 8bc063641ceb ("usb: misc: Add onboard_usb_hub driver")
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Many thx for taking care of this. There is one small thing to improve,
please add the following tag here to make things easier for future code
archaeologists:

Link:
https://lore.kernel.org/r/d04bcc45-3471-4417-b30b-5cf9880d785d@i2se.com/

Basically: every time you use "Reported-by:" use a "Link:" to the report.

To explain: Linus[1] and others considered proper link tags important in
cases like this, as they allow anyone to look into the backstory of a
commit weeks or years later. That's nothing new, the documentation[2]
for some time says to place tags in cases like this. I care personally
(and made it a bit more explicit in the docs a while ago), because these
tags make my regression tracking efforts a whole lot easier, as they
allow my tracking bot 'regzbot' to automatically connect reports with
patches posted or committed to fix tracked regressions.

Apropos regzbot, let me tell regzbot to monitor this thread:

#regzbot ^backmonitor:
https://lore.kernel.org/r/d04bcc45-3471-4417-b30b-5cf9880d785d@i2se.com/
#regzbot fix: usb: misc: onboard_usb_hub: Don't defer probing for
'incomplete' DT nodes

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

[1] for details, see:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

[2] see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)


