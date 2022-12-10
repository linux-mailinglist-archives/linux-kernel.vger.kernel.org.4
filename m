Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B5A648EB4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 13:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLJMfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 07:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiLJMfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 07:35:31 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E5E13D5F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:35:30 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p3z4g-00033k-Vs; Sat, 10 Dec 2022 13:35:27 +0100
Message-ID: <b1b7935d-0785-2e57-bad9-ab2476f0acf2@leemhuis.info>
Date:   Sat, 10 Dec 2022 13:35:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: Fwd: nvmem-cells regression after adding 'call
 of_platform_populate() for MTD partitions'
Content-Language: en-US, de-DE
To:     Maxim Kiselev <bigunclemax@gmail.com>,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CALHCpMgSZOZdOGpLwTYf0sFD5EMNL7CuqHuFJV_6w5VPSWZnUw@mail.gmail.com>
 <CALHCpMgEZjnR39upkR6iozSk-b5A_GHRo9rcDSPXzzQi6x_qCw@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CALHCpMgEZjnR39upkR6iozSk-b5A_GHRo9rcDSPXzzQi6x_qCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1670675730;7ba875b6;
X-HE-SMSGID: 1p3z4g-00033k-Vs
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression mailing list, as it should be in the loop for all
regressions, as explained in
https://docs.kernel.org/admin-guide/reporting-regressions.html ]

Hi, this is your Linux kernel regression tracker. Thx for the report.

On 10.12.22 10:52, Maxim Kiselev wrote:
> 
> After applying

This makes me wonder: "applying" as in "applying it to some version that
doesn't contain this change normally" or as it "after it was applied to
mainline I have the following problem with vanilla kernel version <???>"?

> this commit 'mtd: call of_platform_populate() for MTD
> partitions' (bcdf0315),

CCing Rafał, who authored bcdf0315.

> I faced with a problem that my ethernet device can't be probed because it
> wait when 'nvmem-cells' device will be probed first.

FWIW, there is a discussion about a problems that at least to my
untrained eyes looks similar:
https://lore.kernel.org/all/Yyj7wJlqJkCwObRn@lx2k/

Rafał, has some progress been made to resolve this?

To me it sounds like this might warrant a "revert, and reapply later
when the cause for the regression was addressed". Rafał, it seems you
suggested something like that, but it doesn't look like that happened
for one reason or another. Or am I missing something?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

> But there is no such driver which is compatible with 'nvmem-cells' because
> 'nvmem-cells' is just a mark used by the 'mtd_nvmem_add' function.
> 
> So this leads to appeating of unresolved dependency for the ethernet device.
> And that's why the ethernet device can't be added and probed.
> 
> Here is a part of kernel log when spi flash probe start:
> 
>> device: 'spi0': device_add
>> device: 'spi0.0': device_add
>> spi-nor spi0.0: mx66l51235f (65536 Kbytes)
>> 7 fixed-partitions partitions found on MTD device spi0.0
> 
> After 'm25p80' probe 'f1070000.ethernet' linked to 'partition@1' :
> 
>> device: 'f1010600.spi:m25p80@0:
> partitions:partition@1': device_add
>> device: 'platform:f1010600.spi:m25p80@0:partitions:partition@1--platform:f1070000.ethernet': device_add
>> devices_kset: Moving f1070000.ethernet to end of list
>> platform f1070000.ethernet: Linked as a consumer to f1010600.spi:m25p80@0:partitions:partition@1
>> ethernet@70000 Dropping the fwnode link to partition@1
> 
> And as a result I got `-EPROBE_DEFER` for `f1070000.ethernet`
> 
>> platform f1070000.ethernet: error -EPROBE_DEFER: supplier f1010600.spi:m25p80@0:partitions:partition@1 not ready
> 
> Here is a part of my device tree:
> 
>     enet1: ethernet@70000 {
>         status = "okay";
>         nvmem-cells = <&macaddr>;
>         nvmem-cell-names = "mac-address";
>         phy-mode = "rgmii";
>         phy = <&phy0>;
>     };
> 
>     spi@10600 {
>         status = "okay";
> 
>         m25p80@0 {
>             compatible = "mx66l51235l";
>             reg = <0>;
>             #address-cells = <1>;
>             #size-cells = <1>;
> 
>             partitions {
>                 compatible = "fixed-partitions";
>                 #address-cells = <1>;
>                 #size-cells = <1>;
> 
>                 partition@0 {
>                     reg = <0x00000000 0x000080000>;
>                     label = "SPI.U_BOOT";
>                 };
> 
>                 partition@1 {
>                     compatible = "nvmem-cells";
>                     reg = <0x000A0000 0x00020000>;
>                     label = "SPI.INV_INFO";
>                     #address-cells = <1>;
>                     #size-cells = <1>;
>                     ranges = <0 0x000A0000 0x00020000>;
> 
>                     macaddr: mac@6 {
>                         reg = <0x6 0x6>;
>                     };
>                 };
> 
>             };
>         };
>     };
> 
> In the example above 'ethernet@70000' requires 'macaddr: mac@6' which is
> located inside mtd 'partition@1' of 'm25p80@0' spi flash.

P.P.S.: let me add this to the regression tracking:

#regzbot ^introduced bcdf0315
#regzbot title mtd: ethernet device can't be probed anymore due to
broken nvmem-cells dep
#regzbot monitor: https://lore.kernel.org/all/Yyj7wJlqJkCwObRn@lx2k/
#regzbot ignore-activity
