Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541516271B5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 19:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiKMSmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 13:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbiKMSmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 13:42:03 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4EC1004F;
        Sun, 13 Nov 2022 10:42:02 -0800 (PST)
Received: from zn.tnic (p200300ea9733e71a329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e71a:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD0CB1EC0391;
        Sun, 13 Nov 2022 19:42:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668364920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nHVO2ZEo31Z8PfeL8SyoetYiSGutrzrm7MJ7D0K36Gk=;
        b=nYY3Mwp9CCSmvBnKIAiOm5EJi3yCcmKE5/2RtFYjP+Iun+wQZBmwgntg9fsC9Kj8OR9Sp1
        1gRpgwMd4w7pKQTe/ksjK4nz9VVCPxr6AC2YdZCD9buLLmk/rXF8r7OphhenshmKKBATdN
        0DUp4VkIastgBf4hm+ucEy/kl6Lc9t8=
Date:   Sun, 13 Nov 2022 19:41:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thiago Macieira <thiago.macieira@intel.com>,
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
Message-ID: <Y3E6dKTy+xos4pSi@zn.tnic>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-13-jithu.joseph@intel.com>
 <Y2/JNAmSoYlLKq3A@zn.tnic>
 <CC3629D6-B205-4150-80E5-FC7A7A76DD25@intel.com>
 <Y3CevK2zhAmiUyG9@kroah.com>
 <Y3DZmKYV+8HBtZ+Q@zn.tnic>
 <Y3EJ93xzgC/1v0WV@a4bf019067fa.jf.intel.com>
 <Y3EUPKWDefnkeObR@zn.tnic>
 <Y3Ei7Nc+1wGOF6fk@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3Ei7Nc+1wGOF6fk@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 09:01:32AM -0800, Ashok Raj wrote:
> If it's Ok to ask a question. "You" above is the kernel?

Of course the kernel. If you think about it, it makes sense only for the
kernel to do any checking. As it is enforcing that only the proper blobs
are loaded. Just like microcode.

Userspace is only doing the triggering of the actions.

> Microcode has no such functionality today right? User space 
> never inputs a filename, only performs echo 1 > reload.

Yes, because it is as user-friendly as possible. Users should not care
about filenames. But microcode needs only a single file.

If you have multiple files like IFS, you could just as well supply them
and the kernel would check every aspect before loading them.

> If a file name composed by the kernel exists, then it checks the header
> validity before proceeding.

Yes.

> So some of the files will work, some will fail, and user space doesn't
> care?

See my reply to Jithu:

https://lore.kernel.org/r/Y3EiKUzpShqwzEf6@zn.tnic

> You are reviewing the code and I'm simply discussing what each person
> means. I hope its OK to have a dialog.

I say

| Late loading works also trivially:
| 
| echo 1 > /sys/devices/system/cpu/microcode/reload
| 
| And it goes and builds the filename from f/m/s and loads it from the
| hardcoded path - no filename resolving.
| 
| But it doesn't ask the user to give a f/m/s or a sequence number.

You reply with

| I don't think the current proposed interface expects a f/m/s. The
| entire IFS design was sort of mimicking the microcode interface."
| 
| and you go on to explain what it used to do. I read what it used to do.

So how does your reply have any relevance to what I'm saying?

I go and give the full spiel on how it is important to support command
line loading and how you don't really need a special tool, you say

|The utility is more like icing, to run a simple test all you need is a
|simple script. It is not a baseline requirement."

which feels like you didn't read this part *at* *all*:

| A special tool is *always* a burden. You need to build it, supply
| it, make sure it is installable on the target system and so on.
| 
| And I'm telling you this with my Linux distributor hat on. It is always
| a pain - trust me.
| 
| For example, there's a reason why you can still control ftrace from the
| command line and you don't need any tool. You *can* use a tool but you
| don't have to. IOW, the KISS philosophy.

So now I ended up pasting practically the most of my text again.

Why?

Because your reply doesn't give me *any* signs that you actually read
what I said.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
