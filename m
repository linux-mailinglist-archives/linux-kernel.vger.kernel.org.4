Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E48691E79
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjBJLiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjBJLiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:38:17 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3146472DC2;
        Fri, 10 Feb 2023 03:38:15 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pQRjE-0005l1-Q8; Fri, 10 Feb 2023 12:38:08 +0100
Message-ID: <66fc12cd-65b6-0831-89a8-57636453883b@leemhuis.info>
Date:   Fri, 10 Feb 2023 12:38:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] docs: describe how to quickly build Linux
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <fabdb45fa44db2531f0dbe5e88545c49dfb87040.1675252073.git.linux@leemhuis.info>
 <1f217c94-b90f-359a-2142-0d3ae5d84fc6@leemhuis.info>
In-Reply-To: <1f217c94-b90f-359a-2142-0d3ae5d84fc6@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1676029095;3d0088ce;
X-HE-SMSGID: 1pQRjE-0005l1-Q8
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quick update, in case anyone wants an early look at the reworked
sections that likely will soon be posted as part of a v2:

On 02.02.23 12:15, Linux kernel regression tracking (Thorsten Leemhuis)
wrote:
> [adding Konstantin and Greg to the list of recipients]
> 
> On 01.02.23 12:52, Thorsten Leemhuis wrote:
>> Add a text explaining how to quickly build a kernel, as that's something
>> users will often have to do when they want to report an issue or test
>> proposed fixes. This is a huge and frightening task for quite a few
>> users these days, as many rely on pre-compiled kernels and have never
>> built their own. They find help on quite a few websites explaining the
>> process in various ways, but those howtos often omit important details
>> or make things too hard for the 'quickly build just for testing' case
>> that 'localmodconfig' is really useful for. Hence give users something
>> at hand to guide them, as that makes it easier for them to help with
>> testing, debugging, and fixing the kernel.
> 
> Side note: after feedback on social media I'll likely switch to a title
> like "how to quickly configure & build a trimmed-down Linux kernel", as
> some people from the current title assumed this would be about things
> like ccache.

I for now settled for "How to quickly build a trimmed Linux kernel". I
wonder if "adapt" or "attuned" might be better than "trimmed". I'd
appreciate any input from native speakers here.

> I'll also likely will switch to using a localversion file
> in the buildroot instead of modifying the EXTRAVERSION in the top-level
> makefile (but I haven't actually tried it yet).

The section in the step by step guide now reads:

```
 * If you patched your kernel or already have a kernel of the same
version installed, better tag the one you are about to build by
extending its release name::

     echo "-proposed_fix" > ~/linux/build/localversion

   If you build Linux 6.2-rc4 and later execute ``uname -r`` while
running that kernel, it will print '6.2-rc4-proposed_fix'.
```

>> [...]
>>
>> The text currently describes two approaches to retrieve Linux' sources
>> using git: the regular clone with linux-stable as a remote and a shallow
>> clone with just one branch from linux-stable. [...]
>
> [...]>
> That's why I now strongly consider using the shallow clone method by
> default in v2 of this text.

TWIMC, I went down that route and took a bit of back and forth to figure
out a good approach.

The segment in the step-by-step guide now looks like this:

```
 * Retrieve the sources of the Linux version you intend to build; then
change into the directory holding them, as all further commands in this
guide are meant to be executed from there.

   *[Note, the following paragraphs describe how to retrieve the sources
by partially cloning the Linux stable repository. The reference section
explains two alternatives to such a 'shallow clone': packaged archives
and a full clone. Use the latter, if downloading a lot of data does not
bother you, as that will avoid some quirks of shallow clones the
reference section explains.]*

   Execute the following command to retrieve a fresh mainline codebase::

     git clone --no-checkput --depth 1 -b master \
       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git\
       ~/linux/sources/
     cd ~/linux/sources/

   If you want to access recent mainline releases and pre-releases,
deepen you clone's history to the oldest version you are interested in::

     git fetch --shallow-exclude=v6.1

   In case you want to access a stable/longterm release (say v6.1.5),
simply add the branch holding that series; afterwards fetch the history
up to the mainline version that started the series (v6.1) or is older::

     git remote set-branches --add origin linux-6.1.y
     git fetch --shallow-exclude=v6.1

   Now check out the code you are interested in. If you just performed
the initial clone, you will be able to check out a fresh mainline
codebase ('origin/master') -- it is ideal for checking whether
developers already addressed an issue you face::

      git checkout --detach origin/master

   If you deepened your clone, you instead of 'origin/master' can
specify the version you deepened to; any later releases like 'v6.2' or
pre-release like 'v6.3-rc1' will work, too. Stable or longterm versions
like 'v6.1.5' work just the same, if you added the appropriate
stable/longterm branches as described.

```


The corresponding segment in the reference section got somewhat long and
now looks like this:


```
Download the sources
--------------------

  *Retrieve the sources of the Linux version you intend to build.*
  [:ref:`...<sources_sbs>`]

The step-by-step guide outlines how to retrieve Linux' sources using a
shallow git clone. There is more to tell about this method and two
alternate ways worth describing: packaged archives and a full git clone.
And the aspects 'wouldn't it be wiser to use a proper pre-release than
the latest mainline code' and 'how to get an even fresher mainline
codebase' need elaboration, too.

Unexpected aspects of shallow clones
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The step-by-step guide uses a shallow clone, as it's the best solution
for most of this document's target audience. There are a few quirks of
this approach worth mentioning:

 * This document in most places uses 'git fetch' with
'--shallow-exclude=' to specify the tag of the earliest version you care
about. You alternatively can use the parameter '--shallow-since=' to
specify an absolute (say '2023-07-15') or relative ('12 months') date to
define the depth of the history you want to download.

 * When running 'git fetch', remember to always specify the oldest
version or time you care about as shown in the step-by-step guide.
Otherwise you'll risk downloading nearly the entire git history, which
will consume quite a bit of time and bandwidth while also stressing the
servers.

   Note, you don't have to use the same version/date all the time, but
when you start using a different one git will deepen or flatten the
history to the specified point. That allows you to retrieve versions you
initially thought you did not need -- or it will discard the sources of
older versions, when you want to free up some disk space. The latter
will happen automatically when using '--shallow-since=' with a relative
date.

 * Be warned, when deepening the history you might encounter an error
like 'fatal: error in object: unshallow
1234567890abcdef1234567890abcdef12345678'. In that case run ``git repack
-d`` and try again.

 * In case you want to revert changes from a certain version (say Linux
6.3) or perform a bisection ending on it (v6.2..v6.3), better tell 'git
fetch' to retrieve objects up to three versions earlier (e.g. 6.0):
``git describe`` will then be able to describe most commits just like it
would in a full tree.

Downloading the sources using a packages archive
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

People new to compiling Linux often assume downloading an archive via
the front-page of https://kernel.org is the best approach to retrieve
Linux' sources. It actually can be, if you are certain to build just one
particular kernel version without changing any code. Thing is: you might
be sure this will be the case, but in practice it then often will turn
out to be a wrong assumption.

That's because when reporting or debugging an issue developers will
often ask to give an earlier or later version a try. They also might
suggest temporarily undoing a commit with 'git revert …' or provide
various patches to try. Sometimes reporters will also be asked to use
'git bisect' to find the change causing a problem. These things rely on
git or are a lot easier and quicker to handle with it.

Additionally, a shallow clone also doesn't add much overhead: when git
is creating one for just the latest mainline codebase it retrieves only
a little more data than downloading a packaged archive would.

A shallow clone therefore is often the better choice. If you
nevertheless want to use a packaged source archive, download one via
kernel.org; afterwards extract its content to '~/linux/' and change to
the directory created during extraction. The rest of the step-by-step
guide will work just fine, apart from things that rely on git -- but
this mainly concerns the section on successive builds of other versions.

Downloading the sources using a full git clone
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If downloading and storing a lot of data (~4,4 Gigabyte as of early
2023) is nothing that bothers you, instead of a shallow clone perform a
full git clone instead. They are a little easier to handle and will have
the complete development history at hand at any time::

	curl -L
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/clone.bundle
-o ~/linux/linux-stable.git.bundle
	git clone clone.bundle ~/linux/sources/
	rm ~/linux/linux-stable.git.bundle
	cd ~/linux/sources/
	git remote set-url origin
	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
	git fetch --all
	git checkout --detach origin/master


Proper pre-releases (RCs) vs. latest mainline
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When cloning the sources using git and checking out origin/master, you
often will retrieve a codebase that is somewhere between the latest and
the next release or pre-release. This almost always is the code you want
when giving mainline a shot: pre-releases like v6.1-rc5 are in no way
special, as they don't get any significant extra testing before being
published.

There is one exception: you might want to stick to the latest mainline
release (say v6.1) before its successor's first pre-release (v6.2-rc1)
is out. That's because compiler errors and other problems are more
likely to occur during this time, as mainline then is in its 'merge
window': a usually two week long phase, in which the bulk of the changes
for the next release is merged.

Avoiding the mainline lag
~~~~~~~~~~~~~~~~~~~~~~~~~

The explanations for both the shallow clone and the full clone both
retrieve the code from the Linux stable git repository. That makes
things simpler for this document's audience, as it allows easy access to
both mainline and stable/longterm releases. This approach has just one
downside:

Changes merged into the mainline repository are only synced to the
master branch of the Linux stable repository  every few hours. This lag
most of the time is not something to worry about; but in case you really
need the latest code, just add the mainline repo as additional remote
and checkout the code from there::

	git remote add mainline
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
	git fetch --all
	git checkout --detach mainline/master
```

Ciao, Thorsten
