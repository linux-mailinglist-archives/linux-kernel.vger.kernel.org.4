Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045076AB631
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 07:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCFGDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 01:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCFGDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:03:52 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0303D501;
        Sun,  5 Mar 2023 22:03:51 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pZ3wr-0000bP-JK; Mon, 06 Mar 2023 07:03:49 +0100
Message-ID: <80c249ca-fe51-7a7b-da1d-ab14873170aa@leemhuis.info>
Date:   Mon, 6 Mar 2023 07:03:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
References: <1a788a8e7ba8a2063df08668f565efa832016032.1678021408.git.linux@leemhuis.info>
 <ZAVopho26SPotT6v@debian.me>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v3] docs: describe how to quickly build a trimmed kernel
In-Reply-To: <ZAVopho26SPotT6v@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1678082631;294b445a;
X-HE-SMSGID: 1pZ3wr-0000bP-JK
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx for the feedback

On 06.03.23 05:14, Bagas Sanjaya wrote:
> On Sun, Mar 05, 2023 at 02:04:44PM +0100, Thorsten Leemhuis wrote:
>> +.. _patching_sbs:
>> +
>> + * In case you want to apply a kernel patch, do so now. Often a command like
>> +   this will do the trick::
>> +
>> +     patch -p1 < ../proposed-fix.patch
>> +
>> +   If the ``-p1`` is actually needed, depends on how the patch was created; in
>> +   case it does not apply thus try without it.
>> +
>> +   If you cloned the sources with git and anything goes sideways, run ``git
>> +   reset --hard`` to undo any changes to the sources.
> 
> Alternatively, if you have ``b4`` installed, you can prepare the patch
> with ``b4 am -l <message-id of the patch>``. The -l option adds a Link:
> to lore.kernel.org for the patch. Apply the resulting patch with
> ``git am``.
> 
> It is often wise to branch-off from mainline before applying patches, to
> keep the remote-tracking mainline pristine. Create a branch with ``git
> checkout -b <branch name>``.

Well, for developers of course all that is helpful, but at the same time
it's just overhead and complicated stuff for people that just want to
quickly compile a kernel (maybe for the first time) and might or might
not apply a patch for testing -- hence I'd say that this text is the
wrong place to explain such things.

I wonders if I needs to describe the target audience more explicitly in
the text, but OTOH it kinda feels like it's clear enough already. But
well, maybe adding something like "this document is not intended for
kernel developers" somewhere might be worth it.

>> +Changes merged into the mainline repository are only synced to the master branch
>> +of the Linux stable repository  every few hours. This lag most of the time is
>> +not something to worry about; but in case you really need the latest code, just
>> +add the mainline repo as additional remote and checkout the code from there::
>> +
>> +    git remote add mainline \
>> +      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> +    git fetch mainline
>> +    git checkout --detach mainline/master
> 
> You will most likely change the tracking remote for your master branch
> to mainline by ``git branch --set-upstream-to=mainline/master``.

Why? The document doesn't even use that branch, git is just used to
retrieve the sources.

>> +The step-by-step guide uses the default make targets (e.g. 'bzImage' and
>> +'modules' on x86) to build the image and the modules of your kernel, which later
>> +steps of the guide then install. You instead can also directly build everything
>> +and directly package it up by using one of the following targets:
>> +
>> + * ``make -j $(nproc --all) bindeb-pkg`` to generate a deb package
>> +
>> + * ``make -j $(nproc --all) binrpm-pkg`` to generate a rpm package
>> +
>> + * ``make -j $(nproc --all) tarbz2-pkg`` to generate a bz2 compressed tarball
> 
> I used to try compiling kernel in rpm-based systems (at that time
> CentOS). make binrpm-pkg generates kernel headers, image, and sanitized
> kernel headers for libc packages. These three packages have to be
> installed together.> However, the generated libc headers package most
> likely overwrite distro-installed one, thus rebuilding the world is
> necessary.

Is it? This is totally not my area of expertise, but I thought updating
those is not a problem, as long as you don't expect stuff compiled
against those headers to work on older kernels all the time. At least
Fedora updates its kernel-headers package (which contains the C header
files that specify the interface between the Linux kernel and userspace
libraries) occasionally to newer mainline versions within a release and
doesn't rebuild the world when they do so.

Ciao, Thorsten
