Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69996692980
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjBJVuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjBJVt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:49:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEB33D09C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:49:57 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F11C1EC06C0;
        Fri, 10 Feb 2023 22:49:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676065795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aoz7bS9et9aIGm0OcKdmUFu0AmMnaNrDzjbYJ5AYcWE=;
        b=YUuOccxbhcbE9xhuxZJq+fn0Y5GAqFEE0OTgoBRpbpvvRjm2tfrzYizxHLKeGfTfdh3UPM
        CKYHy0i15MmW9z8ukyT8IJzlGOuX60IDZ98bL9feDRSn5neZOv96FynQGJ8FsGfNM0jo/+
        8+rxQfq2aJNdBbzzZslcrsiHIcO5QJI=
Date:   Fri, 10 Feb 2023 22:49:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Philip Li <philip.li@intel.com>
Cc:     kernel test robot <lkp@intel.com>, Babu Moger <babu.moger@amd.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [tip:x86/cache 9/13]
 arch/x86/kernel/cpu/resctrl/rdtgroup.c:1456:6: warning: variable 'h' set but
 not used
Message-ID: <Y+a7/2uOc2/maFX7@zn.tnic>
References: <202301242015.kbzkVteJ-lkp@intel.com>
 <Y8/XoT23HVXHSY73@zn.tnic>
 <Y+RjOpXP1Bbv268n@rli9-mobl>
 <Y+TCq4k+0AhfjZkL@zn.tnic>
 <Y+W2tFIfGJ1c8uml@rli9-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+W2tFIfGJ1c8uml@rli9-mobl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 11:15:00AM +0800, Philip Li wrote:
> Sorry for confusion, we do full make for the kernel to gather all issues.
> And we try to provide a quicker way for developer to reproduce the issue,
> thus the step in reproduce part shows the subdirectories that could reproduce
> the reported issue.

Aah, ok.

I guess those reproduction instructions should then say:

"... the fastest way to reproduce is ..."

Or so.

> Got it. Internally, we use the merge strategy to combine as many branches
> as we can to run build testing, and bisect the issues if found. We need
> further think of how to let high priority issues to be reported out earlier.

Hmm, I wouldn't do that.

If you test a whole bunch of patchsets, then you're not really testing
each of them but you're testing the common thing which you've created by
merging.

I think it makes most sense to test single patchsets, single tree
branches which should hopefully contain commits which belong to a single
topic - this is how we aim to do them in the tip tree, at least, but
others do different things, and so on.

And then test linux-next. But I think you do that.

> Thanks, so far, we recommend to use --base option in our report mail, like
> 
> 	[If your patch is applied to the wrong git tree, kindly drop us a note.
> 	And when submitting patch, we suggest to use '--base' as documented in
> 	https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> And we do need a place to put such information, so people can refer to. Without
> a public available site for us, we will update https://github.com/intel/lkp-tests/wiki
> firstly to host enough information.

Right, make that URL part of every report so that people can go and read
about it and know what are best practices. I'll try to remember myself
to use --base too.

> Thanks for the hint, this is doable, and we definitely need do this. I will
> plan it to have initial version ready by Q1.

You have a wiki page above already. Add a status subpage and dump into
it periodically what current trees are being tested. And this way you
have *something* to go with. You can always improve it later on.

> Thanks a lot Boris, these suggestions are very helpful to further improve the
> 0-day ci service.

You're welcome - I'm glad that can be of help.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
