Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36130640B64
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiLBQ4S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Dec 2022 11:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbiLBQzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:55:36 -0500
X-Greylist: delayed 554 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Dec 2022 08:55:34 PST
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB24EDA7E6;
        Fri,  2 Dec 2022 08:55:34 -0800 (PST)
Received: from smtpclient.apple (p4fefca0f.dip0.t-ipconnect.de [79.239.202.15])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4E9A4CECFF;
        Fri,  2 Dec 2022 17:46:19 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [regression] Bug 216753 - 6e 6 ghz bands are disabled since 5.16
 on intel ax211
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <9a03c244-adff-afaf-7385-d8e89cd3f338@leemhuis.info>
Date:   Fri, 2 Dec 2022 17:46:18 +0100
Cc:     Dave Chiluk <chiluk@ubuntu.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <02F8DDF1-EC0D-4EBD-88F5-7E000841C337@holtmann.org>
References: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info>
 <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
 <CAMfi-DRE-u5TNu2zAL-7A-ENHM9EiJeYJ38BL_FMdk6QmW7c9w@mail.gmail.com>
 <9a03c244-adff-afaf-7385-d8e89cd3f338@leemhuis.info>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

>> The other possibility is that this is actually a bios bug, as the DSM
>> is being read out of ACPI.  In which case that would be Dell's fault.
> 
> Yes and no, but no:
> 
> A kernel change exposed this problem, hence it doesn't matter if the
> BIOS is faulty: it's makes it a kernel regression and those are not
> allowed. For more on this see
> https://docs.kernel.org/admin-guide/reporting-issues.html
> 
> That at least would be the normal approach. But the thing is: the legal
> implications when it comes to things like wifi make this somewhat
> trickier. :-/

so you need to set your country code first before any of the regulatory
enabled channels on 6Ghz get used. Otherwise you are stuck in the world
domain that doesn’t allow 6Ghz at all.

Two choices, either you run iwd and just set Country=DE where this than
would be persistent; see iwd.config(5). Or you do this via iw reg set DE
manually. wpa_supplicant has a set_country wrapper, but I don’t see it
being used anywhere, so I assume you have to do this manually when using
wpa_supplicant.

And of course tools like crda etc. need to be fully functional to load
the appropriate regulatory information. Since any 6Ghz operation is
blocked by default.

Regards

Marcel

