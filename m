Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5C6626A8C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbiKLQ0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiKLQ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:26:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06D755B2;
        Sat, 12 Nov 2022 08:26:39 -0800 (PST)
Received: from zn.tnic (p200300ea9733e71c329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e71c:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C14C11EC0380;
        Sat, 12 Nov 2022 17:26:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668270397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+zWJSjqNFbAAWOwG+JMTCXP84uNjiJ6mgJ0Ccxf6YJk=;
        b=kkrWkEtbk/aSRyeXkzgDGFStxCxvaKtJnjXPlNLCnfuCgZyQBR1qmRIxWZ2FMd4/r5mSOq
        dHRnjKHrU+CcOu8DaSPVU0m8ApwsZeIcUShS17LFhkH5GUggZ3TEkudej3jIDVhyzQqOVy
        +Z0wRIWbMygItUyAnrIdXEbw+alorHo=
Date:   Sat, 12 Nov 2022 17:26:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, thiago.macieira@intel.com,
        athenas.jimenez.gonzalez@intel.com, sohil.mehta@intel.com
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Message-ID: <Y2/JNAmSoYlLKq3A@zn.tnic>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-13-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221107225323.2733518-13-jithu.joseph@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 02:53:21PM -0800, Jithu Joseph wrote:
> Initial implementation assumed a single IFS test image file with a
> fixed name ff-mm-ss.scan. (where ff, mm, ss refers to family, model
> and stepping  of the core)
> 
> Subsequently, it became evident that supporting more than one
> test image file is needed to provide more comprehensive
> test coverage. (Test coverage in this scenario refers to testing
> more transistors in the core to identify faults)
> 
> The other alternative of increasing the size of a single scan test image
> file would not work as the  upper bound is limited by the size of memory
> area reserved by BIOS for loading IFS test image.
> 
> Introduce "current_batch" file which accepts a number. Writing a
> number to the current_batch file would load the test image file by name
> ff-mm-ss-<xy>.scan, where <xy> is the number written to the
> "current_batch" file in hex. Range check of the input is done to verify
> it not greater than 0xff.

Dunno - sounds silly to me. Means one needs to go and look up which
files are there and echo those batch numbers into sysfs and so on.

What I would do is make it real trivial for the user so that latter can
simply do:

for f in $(ls /lib/firmware/intel/ifs_0/*.scan);
do
	echo $f > /sys/devices/virtual/misc/intel_ifs_0/test_file
done

and simply supply the full filename.

There will be no requirement on the naming - only on the filename length
and it should be in that directory /lib/firmware/intel/ifs_0/

  (btw, what's that appended "_0" supposed to mean there?)

So the kernel would simply open it, sanity-check it, if it passes, it
would run it - otherwise it would ignore it.

A usability win-win.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
