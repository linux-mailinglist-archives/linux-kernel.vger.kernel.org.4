Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF320640C81
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiLBRrk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Dec 2022 12:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbiLBRrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:47:22 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C4D8E1195;
        Fri,  2 Dec 2022 09:46:39 -0800 (PST)
Received: from smtpclient.apple (p4fefca0f.dip0.t-ipconnect.de [79.239.202.15])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9FA51CED00;
        Fri,  2 Dec 2022 18:46:38 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [regression] Bug 216753 - 6e 6 ghz bands are disabled since 5.16
 on intel ax211
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAMfi-DQfuro4c_VUrFHBTv8sPnwuV8XhTV_W7qswGeCC2t-wzg@mail.gmail.com>
Date:   Fri, 2 Dec 2022 18:46:38 +0100
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <457D8649-B855-43BB-B3AD-334E166FED31@holtmann.org>
References: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info>
 <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
 <CAMfi-DRE-u5TNu2zAL-7A-ENHM9EiJeYJ38BL_FMdk6QmW7c9w@mail.gmail.com>
 <9a03c244-adff-afaf-7385-d8e89cd3f338@leemhuis.info>
 <02F8DDF1-EC0D-4EBD-88F5-7E000841C337@holtmann.org>
 <CAMfi-DQfuro4c_VUrFHBTv8sPnwuV8XhTV_W7qswGeCC2t-wzg@mail.gmail.com>
To:     Dave Chiluk <chiluk@ubuntu.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

> Running
> $ iw reg set US
> or
> $ iw reg set DE
> do not result in the bands becoming enabled.  I should have included
> that in the initial bug report.   Additionally shouldn't the country
> code should be getting gathered through 802.11d from the broadcast APs
> within region?
> 
> Also crda is now disabled in both debian and Ubuntu.
> https://bugs.debian.org/1003903
> https://bugs.launchpad.net/ubuntu/jammy/+source/crda/+bug/1958918
> 
> I'm specifically on 22.04, and the 6ghz band works on the 5.15 ubuntu
> kernel and the 5.15.79 linux-stable kernel.
> The 6ghz band becomes disabled as soon as I upgrade to the 5.16+
> linux-stable kernels. So from a user perspective this really is a case
> of a kernel upgrade breaking user-space.  This is what led me down
> this rabbit hole here.
> 
> If there's something that needs to be done differently from a
> userspace perspective I'm all ears, but this seems as if it's a hard
> disable by the above mentioned commit.

can you run iwd and set Country=DE (or US) in its main.conf. I think
most distros have a 2.0 package of iwd available. With iwd we have
implemented all the handling and re-scanning to make sure we actually
get to use 6Ghz is available.

Btw. you can run iwd from its source tree. No need to install it if
You don’t want to mess up your system. Just make sure to disable
wpa_supplicant so it doesn’t interfere.

I have this working on 6.0 kernel (not with ax211 hardware though) and
it needed some help to get the regdom loaded correctly. I think the key
part was to install crda on Fedora.

$ iw reg get
global
country DE: DFS-ETSI
	(2400 - 2483 @ 40), (N/A, 20), (N/A)
	(5150 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
	(5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
	(5470 - 5725 @ 160), (N/A, 26), (0 ms), DFS
	(5725 - 5875 @ 80), (N/A, 13), (N/A)
	(5945 - 6425 @ 160), (N/A, 23), (N/A), NO-OUTDOOR
	(57000 - 66000 @ 2160), (N/A, 40), (N/A)

Unless you see it available in iw reg get, then it is also not available,
but I remember that you also have per PHY regdom and other fun stuff. As
I said, it was a breath to get it running with iwd once you set your
country code in the config file.

On a note, you could run iwmon and see what nl80211 related calls to
regdom handling actually happen.

Regards

Marcel

