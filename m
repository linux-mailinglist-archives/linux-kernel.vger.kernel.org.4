Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E3C62731E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 23:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiKMW72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 17:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbiKMW71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 17:59:27 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87353DED3;
        Sun, 13 Nov 2022 14:59:25 -0800 (PST)
Received: from zn.tnic (p200300ea9733e773329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e773:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1AC381EC02DD;
        Sun, 13 Nov 2022 23:59:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668380364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Oas9F0wtXybTRTTzPZachjZwGtcIAX+ns8IXE6OPciY=;
        b=j9IPFGYKPrOyhh97vec2lylSkfCbCmfRNuL+mZhywfUIVkPh/DZRIxTGzZYXY8p1SknfRt
        oihJkFMwTq/fBy/1DSV//OFCuCKgb0pxQQEf0Ds3lsdwOFWNkZK4yVV+RcAeMlcRZuqUYg
        EDpt1udJMTXwX0ZV7bBYmjzUN+kvIZg=
Date:   Sun, 13 Nov 2022 23:59:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thiago Macieira <thiago.macieira@intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Message-ID: <Y3F2y7Y3ASh/X4BG@zn.tnic>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <Y3EJ93xzgC/1v0WV@a4bf019067fa.jf.intel.com>
 <Y3EUPKWDefnkeObR@zn.tnic>
 <1745359.VLH7GnMWUR@tjmaciei-mobl5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1745359.VLH7GnMWUR@tjmaciei-mobl5>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 01:40:56PM -0800, Thiago Macieira wrote:
> On Sunday, 13 November 2022 07:58:52 PST Borislav Petkov wrote:
> > * simply try *all* files in a directory
> 
> By the way, we don't want that.
> 
> It's possible that different steppings of the same generation will have the 
> same test scan files, with the extended signature informing that they are valid 
> for this stepping too (see find_matching_signature())), because these files are 
> going to be pretty big, in the order of a hundred MB each. That means we will 
> either see symlinked or hardlinked files in the directory.
> 
> If you blindly try them all, you're going to spend twice or three times as 
> long as necessary to complete the scan. With the timeout in question for at 
> least Sapphire Rapids, we're talking about a difference measured in hours.

You either have files which are valid and which will get run on the CPU
or those which will fail the header check. The header check happens in
msecs.

So I have no clue what "hours" you're talking about here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
