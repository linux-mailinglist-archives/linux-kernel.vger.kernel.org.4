Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AE462731A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 23:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiKMW4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 17:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbiKMW4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 17:56:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE55E10040;
        Sun, 13 Nov 2022 14:55:57 -0800 (PST)
Received: from zn.tnic (p200300ea9733e773329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e773:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E0691EC02DD;
        Sun, 13 Nov 2022 23:55:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668380156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=omkKJP3QRSJ1TQMFymyT/Q913sb0v8rXOPsXoq9txnY=;
        b=o7voXxnp8sns/BkqtUykHJvs6FoBv16oER5WblDLI0Cja/mXKdsws6uEMTDyF1jEffs7NP
        on7UlHI08l0QKFaWuuDc7Fwaldm9cjmPH9g2owbwmGF80jnAKUboUXg8QNNVO4JwakpCqJ
        ItEZFOq+n35qnw3k9CJehTbMUsU7VsI=
Date:   Sun, 13 Nov 2022 23:55:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thiago Macieira <thiago.macieira@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Message-ID: <Y3F1+GRxRXO0YeUj@zn.tnic>
References: <20221107225323.2733518-13-jithu.joseph@intel.com>
 <Y2/JNAmSoYlLKq3A@zn.tnic>
 <CC3629D6-B205-4150-80E5-FC7A7A76DD25@intel.com>
 <Y3CevK2zhAmiUyG9@kroah.com>
 <Y3DZmKYV+8HBtZ+Q@zn.tnic>
 <5e65889d-d68c-b29d-6cea-7b4ce4c87b4a@intel.com>
 <Y3EiKUzpShqwzEf6@zn.tnic>
 <f307b37f-26de-cb8f-e199-f327f2c7f807@intel.com>
 <Y3E3DkX4wHRgSUlJ@zn.tnic>
 <Y3Fivuffbh2QE/s6@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3Fivuffbh2QE/s6@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 01:33:50PM -0800, Tony Luck wrote:
> IMHO option 1 is following the microcode precedent of having the kernel
> construct the filename based on the {x86,model,stepping} fields of
> struct cpuinfo_x86.

You can't follow the microcode precedent if you have more than one file.

> I think option 2 isn't really doing the user any favors. Having them
> feed all the *.scan files they find in /lib/firmware/intel/ifs_0 to the
> driver to see which ones work becomes progressively worse in every CPU
> generation. Any script/app running tests is likely to do the ff-mm-ss
> filter itself ... so why have the kernel do it too?

So you think that feeding a sequence number is more intuitive?

I guess I've given all my arguments here but you folks don't see things
this way.

I guess time will show whether the sequence number thing was a good
idea.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
