Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85B8626F58
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 12:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiKMLsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 06:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMLst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 06:48:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEB2A465;
        Sun, 13 Nov 2022 03:48:47 -0800 (PST)
Received: from zn.tnic (p200300ea9733e71a329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e71a:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3EF181EC05DE;
        Sun, 13 Nov 2022 12:48:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668340126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6rBi4qpHb53yThXNbSMZrkQBQAZAg4yKat497BxwlIQ=;
        b=hBFuAdZ1StgbH6614oYPBjeUN56VXXa/bqwa3hiPFFaylHXfmYNIdkKgHu3bQx9cEk3hRS
        2XnYO+/vNlajmpIFEfzeBkJqOdfWYuvTSMFoIO+7Yi00MmGyh0sRVivOVXBOSXrWL9JGzW
        AsVktaEkN8/rW8wW3Dn6KsrdFVD2wus=
Date:   Sun, 13 Nov 2022 12:48:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thiago Macieira <thiago.macieira@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
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
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Message-ID: <Y3DZmKYV+8HBtZ+Q@zn.tnic>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-13-jithu.joseph@intel.com>
 <Y2/JNAmSoYlLKq3A@zn.tnic>
 <CC3629D6-B205-4150-80E5-FC7A7A76DD25@intel.com>
 <Y3CevK2zhAmiUyG9@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3CevK2zhAmiUyG9@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to both with one mail because it still feels like there's a
misunderstanding.

On Sun, Nov 13, 2022 at 08:37:32AM +0100, gregkh@linuxfoundation.org wrote:
> No, please do not force the driver to resolve a filename path in the
> kernel.

No, I don't mean to do any filename path resolving - all I suggest is to
echo into sysfs the full filename instead of the number. I.e., this:

for i in $(ls /lib/firmware/intel/ifs_0/*.scan);
do
	echo $i /sys/devices/virtual/misc/intel_ifs_0/current_batch
done

What you end up echoing inside is only the full filename - *not* the
absolute filename - instead of a number. So those in a succession:

06-8f-06-00.scan
06-8f-06-01.scan
06-8f-06-02.scan
06-8f-06-03.scan
06-8f-06-04.scan
06-8f-06-05.scan

The advantage being, you don't need to remember which file sequence and
which family/model/stepping.

For all Intel employees here on the thread, there's a world outside
Intel and people do not talk (family model stepping) tuples like we do.
All they wanna do is run their damn tests.

So instead of what the code does now:

+	snprintf(scan_path, sizeof(scan_path), "intel/ifs_%d/%02x-%02x-%02x-%02x.scan",
+		 ifsd->test_num, boot_cpu_data.x86, boot_cpu_data.x86_model,
+		 boot_cpu_data.x86_stepping, ifsd->cur_batch);

It would still use the *same* scan_path - /lib/firmware/intel/ifs_0/ -
no one is proposing to give a full path name - it would only use the
filename string - 06-8f-06-00.scan, for example - instead of the "0" in
it to build that string.

And, ofcourse it would check the format of that string against family,
model, stepping and sequence number (btw this way you drop your
limitation of 256 for the sequence number which you don't really need
either).

And then if the format passes, it would check the headers.

And only if those pass too, then it would load.

> Right, it's no different from echoing file names, but it's much
> simpler to increment a number than do a directory listing and sort the
> file names, so it can pick up from where it left off.

It is no different - you still need to remember where you are in the
sequence wrt to testing.

So if you want to deal with the timeout, that same script above will
check the status and wait. Not rocket science.

As to this Thiago:

> You can't do it with a three-line shell script, but we're not
> expecting that shell scripts are the means to use this feature in the
> first place.

I consider it a serious design mistake of having to have a *special*
tool. A special tool is *always* a burden. You need to build it, supply
it, make sure it is installable on the target system and so on.

And I'm telling you this with my Linux distributor hat on. It is always
a pain - trust me.

For example, there's a reason why you can still control ftrace from the
command line and you don't need any tool. You *can* use a tool but you
don't have to. IOW, the KISS philosophy.

IOW, I really think that designing our interfaces with user friendliness
in mind should be of much more higher importance. And requiring the user
to remember or figure out anything she doesn't really need to, in order
to run the test is a burden.

Just look at microcode loading: early loading works automatically - you
only need to install the blobs in /lib/firmware/intel-ucode/. The initrd
builder figures out which to add to the image.

And not even that is required - I have a script which adds *all* blobs
to my image. It still loads the right one.

Late loading works also trivially:

echo 1 > /sys/devices/system/cpu/microcode/reload

And it goes and builds the filename from f/m/s and loads it from the
hardcoded path - no filename resolving.

But it doesn't ask the user to give a f/m/s or a sequence number.

I sincerely hope that makes more sense.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
