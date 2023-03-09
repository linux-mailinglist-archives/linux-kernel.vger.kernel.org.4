Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9616B2E76
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjCIUTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCIUTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:19:32 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EA81CF46
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 12:19:29 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 329KJMU0021692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Mar 2023 15:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678393163; bh=4+VVfN0Z2UXOxj8kTZFltDiLYI5XRoXG0kaXodukGqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Egbe2+Oe1EigwRWFdUsY0KDhTjRkEFEC+MRAnxl8DjhQtVvgPX9xoGw7CqXbLCMk+
         dVOmpShsTp4rRQ8BA6hH/JKBnbHc2wdNCyfdjjJ8BBSKji9+iiorkaVZ6eaZHXgnxu
         29OiV73e8j2LED/BXb9JHP32kPTf/CTJTB+pYBZRon5uwokJ7FkpNQNgrEwXenGcK+
         Cngk7HFcj3SJW/+bSdI/Mh4v6I6QPBqJyPVfqIoB8Q4ESETgtai5oElYy0uu8QvdV5
         FpdAy1exdV1wJrvKaktLa1+jNKTQyWW4MRb8IiBK0/Rb8m4yCvjWq5qeDyA3UlEE3V
         Bhcaf9S1ZhIgw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E5E7515C42F6; Thu,  9 Mar 2023 15:19:16 -0500 (EST)
Date:   Thu, 9 Mar 2023 15:19:16 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     tjcw@cantab.net
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Shutdown causes fsck on USB disks
Message-ID: <20230309201916.GA2393375@mit.edu>
References: <CAC=wTOhzzjrynMZv9iKSFKY7ef+YVz=iE38iVxiVuOuXoWzY-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC=wTOhzzjrynMZv9iKSFKY7ef+YVz=iE38iVxiVuOuXoWzY-w@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 09:05:08AM +0000, Chris Ward wrote:
> I have a (Ubuntu 22.04) system with a number of external USB disks.
> When I do a 'shutdown now' with these disks mounted, on the next start
> the disks have to be fsck-ed. So it seems that the disks are not
> unmounted cleanly on shutdown; maybe the disks report 'completion'
> before the data is really written, and the machine powers off before
> allowing the unmount writes to complete.
> 
> Is this a kernel problem, or should I take it up with the Ubuntu maintainers ?

What file system do you have on these disks?  And when you say that
they have to be fsck'ed, was this a fast fsck to just replay the
journal, or was it a longer running fsck to fix corruption?  Does this
happen reliably, every single time when you run "shutdown now"?  What
if you run "reboot now" and don't actually power off the machine
instead?

The reason why I ask these questions is that even if the machine was
powered off without allowing the unmount to complete, for file systems
with journals, the journal replay should allow the file system to be
mounted without requiring a full fsck, and the file system should not
have any corruption issues that would need to be fixed by fsck.

Assuming that you are using ext4, if the kernel had discovered some
kind of file system inconsistency, it will set an indication that file
system has issues that need to be fixed, and then on the next reboot,
a full fsck run will be triggered.  You can check to see whether this
is the case by running dumpe2fs -h and checking the file system state.


# In a test kvm environment, mount a testing file system found on /dev/vdc
root@kvm-xfstests:~# mount /dev/vdc /vdc
[  312.217838] EXT4-fs (vdc): mounted filesystem 43d49992-65a8-4fb4-b20e-f7c0682c2720 with ordered data mode. Quota mode: none.

# This is an example of how to trigger a file system corruption report
root@kvm-xfstests:~# echo testing > /sys/fs/ext4/vdc/trigger_fs_error
[  315.186334] EXT4-fs error (device vdc): trigger_test_error:126: comm bash: testing

# Above is the sort of thing you will see on the console, and in your
# system logs, although if there is real (non-testing) file system problem
# detected by the kernel, then you might something like this instead:
# EXT-fs error (device vdc): __extf4_find_entry:1531 inode #4512: comm main: reading directory block 0


# And this is what you will see if you run dumpe2fs and check on the filesystem state
root@kvm-xfstests:~# dumpe2fs -h /dev/vdc | grep state
dumpe2fs 1.47.0 (5-Feb-2023)
Filesystem state:         clean with errors

# And then when you run fsck, you'll see a message stating that the file system
# contains errors.  In the case of a real corruption, you'll probably see fsck
# reporting that one or more inconsistencies will have been corrupted.   Nothing
# is reported this time since the file system inconsistency was triggred as
# a synthetic test via /sys/fs/ext4/$DEVICE/trigger_fs_error
root@kvm-xfstests:~# umount /dev/vdc
[  317.173855] EXT4-fs (vdc): unmounting filesystem 43d49992-65a8-4fb4-b20e-f7c0682c2720.
root@kvm-xfstests:~# fsck.ext4 -p /dev/vdc
/dev/vdc contains a file system with errors, check forced.     <=========================
/dev/vdc: 15/327680 files (0.0% non-contiguous), 42399/1310720 blocks


All of this being said, I suspect the most likely cause is actually a
problem with your hardware.  Note that file system inconsistencies
could be kernel bugs, but more commonly, they are caused by storage
failures due to flaky hardware --- for example, if you purchased cr*p
USB thumb drives at the bargain bin at the checkout aisle of your
local Micro Center, or cheap street vendor selling hardware that may
have fallen off the back of a truck in the back alleys of Shenzhen.  :-)

So I always ask if you can replicate the problem on other systems and
using different storage devices.

    	     	    		  	       - Ted
