Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EF9646001
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiLGRT4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Dec 2022 12:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiLGRTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:19:35 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBBD218E;
        Wed,  7 Dec 2022 09:19:33 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 7DD24E0003;
        Wed,  7 Dec 2022 17:19:30 +0000 (UTC)
Message-ID: <91367d07a72ecb2065faebe974c54ebd966e0d59.camel@hadess.net>
Subject: Re: [Regression] Logitech BT mouse unusable after commit
 532223c8ac57 (still in 6.1-rc8)
From:   Bastien Nocera <hadess@hadess.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Date:   Wed, 07 Dec 2022 18:19:29 +0100
In-Reply-To: <CAJZ5v0gRm1NG=QuDFDFdcZgTu7Q0Z3cW3fwGg09sD+3BBV8E1A@mail.gmail.com>
References: <2262737.ElGaqSPkdT@kreacher>
         <1df12728a2e788788fd387588bac62023e123d16.camel@hadess.net>
         <2145955.irdbgypaU6@kreacher>
         <CAJZ5v0ic+pm+NWD8g4O2MwQEvi+xuB-W9Wpd6c1RhprhoxuK1g@mail.gmail.com>
         <8281ddcc16cc950f9cde4b196cf208adcc798319.camel@hadess.net>
         <CAJZ5v0gjAGZFS6ap+NAbsi96hq7y9MRGE0h_A-n6xfB1CMs=2g@mail.gmail.com>
         <cd8b2a2160f5d36d1b73bc0567cd0f6e7e5751c4.camel@hadess.net>
         <CAJZ5v0gRm1NG=QuDFDFdcZgTu7Q0Z3cW3fwGg09sD+3BBV8E1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-12-07 at 12:07 +0100, Rafael J. Wysocki wrote:
> # hidpp-list-features /dev/hidraw1
> Bluetooth Mouse M336/M337/M535 (046d:b016) is a HID++ 4.5 device
> Feature 0x01: [0x0001] Feature set
> Feature 0x02: [0x0003] Device FW version
> Feature 0x03: [0x0005] Device name
> Feature 0x04: [0x0020] Reset
> Feature 0x05: [0x1e00] Enable hidden features (hidden)
> Feature 0x06: [0x1800] Generic Test (hidden, internal)
> Feature 0x07: [0x1000] Battery status
> Feature 0x08: [0x1b04] Reprog controls v4
> Feature 0x09: [0x2100] Vertical scrolling
> Feature 0x0a: [0x2200] Mouse pointer
> Feature 0x0b: [0x2205] Pointer speed
> Feature 0x0c: [0x18b1] ? (hidden, internal)
> Feature 0x0d: [0x2121] Hi-res wheel
> Feature 0x0e: [0x1f03] ? (hidden, internal)

Would you be able to enable debugging for the hid subsystem to get some
debug data when getting the version from the device fails?

I can't see any problems in there that wouldn't also have impacted all
the other Logitech Bluetooth devices listed in the support devices
list.

If the problem is a timeout, maybe we should lower the timeouts we
currently have (5*HZ = 5 seconds, right?), so we can retry 5 times one
second instead.

Still, as I mentioned earlier, I can't reproduce the problem on another
Bluetooth Classic device...
