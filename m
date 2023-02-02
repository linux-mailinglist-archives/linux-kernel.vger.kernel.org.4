Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62327687C02
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjBBLQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBBLPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:15:46 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5217C8AC02;
        Thu,  2 Feb 2023 03:15:42 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pNXZ3-00021x-GU; Thu, 02 Feb 2023 12:15:37 +0100
Message-ID: <1f217c94-b90f-359a-2142-0d3ae5d84fc6@leemhuis.info>
Date:   Thu, 2 Feb 2023 12:15:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1] docs: describe how to quickly build Linux
Content-Language: en-US, de-DE
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>
References: <fabdb45fa44db2531f0dbe5e88545c49dfb87040.1675252073.git.linux@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <fabdb45fa44db2531f0dbe5e88545c49dfb87040.1675252073.git.linux@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675336542;93058089;
X-HE-SMSGID: 1pNXZ3-00021x-GU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Konstantin and Greg to the list of recipients]

On 01.02.23 12:52, Thorsten Leemhuis wrote:
> Add a text explaining how to quickly build a kernel, as that's something
> users will often have to do when they want to report an issue or test
> proposed fixes. This is a huge and frightening task for quite a few
> users these days, as many rely on pre-compiled kernels and have never
> built their own. They find help on quite a few websites explaining the
> process in various ways, but those howtos often omit important details
> or make things too hard for the 'quickly build just for testing' case
> that 'localmodconfig' is really useful for. Hence give users something
> at hand to guide them, as that makes it easier for them to help with
> testing, debugging, and fixing the kernel.

Side note: after feedback on social media I'll likely switch to a title
like "how to quickly configure & build a trimmed-down Linux kernel", as
some people from the current title assumed this would be about things
like ccache. I'll also likely will switch to using a localversion file
in the buildroot instead of modifying the EXTRAVERSION in the top-level
makefile (but I haven't actually tried it yet).

> [...]
>
> The text currently describes two approaches to retrieve Linux' sources
> using git: the regular clone with linux-stable as a remote and a shallow
> clone with just one branch from linux-stable. The shallow clone approach
> is a little bit more tricky to describe and handle, but downloads way
> less data – and thus is a lot quicker, unless you have a really really
> quick link to the internet (which in some parts of the world is hard to
> come by). That's why I wonder if the text should switch to making the
> shallow clone with selected stable branches the default. What do you
> think, dear reader?

So, I looked into what Greg suggested (e.g.
https://kernel.org/best-way-to-do-linux-clones-for-your-ci.html and
https://www.kernel.org/cloning-linux-from-a-bundle.html
). Assuming users have a up2date git (afaics 2.38+) I could use commands
like this in my text:

curl -L
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/clone.bundle
-o ~/linux/linux-stable.git.bundle
git clone --bundle-uri=linux-stable.git.bundle
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
~/linux/sources
rm ~/linux/linix-stable.git.bundle

This took roundabout 16 minutes with my 100 Mbit cable internet
connection (~9 min for the download, 7 for the clone [the machine used
is somewhat old]) and downloads & stores ~4,5 GByte data (without checkout).

[side note: using
"--bundle-uri=https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/clone.bundle"
does not work (due to the redirect? whatever) -- but that might be
unwise anyway in case the download is interrupted]


Then I tried creating a shallow clone like this:

git clone
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
--depth 1 -b v6.1
git remote set-branches --add origin master
git fetch --all --shallow-exclude=v6.1
git remote add -t linux-6.1.y linux-stable
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
git fetch --all --shallow-exclude=v6.1

This took only roundabout 2 minutes and downloads & stores ~512 MByte
data (without checkout).


Not totally sure, but the shallow clone somehow feels more appropriate
for the use case (reminder, there is a "quickly" in the document title),
even if such a clone is less flexible (e.g. users have to manually add
stable branches they are interested it; and they need to be careful when
using git fetch).

That's why I now strongly consider using the shallow clone method by
default in v2 of this text. Or does that also create a lot of load on
the servers? Or are there other strong reason why using a shallow clone
might be a bad idea for this use case?

Ciao, Thorsten

> [...]
> +.. _sources_sbs:
> +
> + * Retrieve the sources of the Linux version you intend to build; then change
> +   into the directory holding them, as all further commands in this guide are
> +   meant to be executed from there.
> +
> +   If you plan to only build one particular kernel version, download its source
> +   archive from https://kernel.org; afterwards extract its content to '~/linux/'
> +   and change into the directory created during extraction.
> +
> +   In most other situations your best choice is to fetch the sources using git::
> +
> +          git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git \
> +            ~/linux/sources
> +          cd ~/linux/sources/
> +
> +   Now you can check out any mainline release with a command like
> +   ``git checkout --detach v6.1``; pre-release like v6.2-rc2 work, too.
> +   Specifying 'origin/master' will hand you the latest mainline code, which is
> +   automatically checked out by the above 'git clone […]' command.
> +
> +   In case you want to build a stable or longterm kernel, run this, too::
> +
> +          git remote add linux-stable \
> +            https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> +          git fetch --all
> +
> +   Afterwards you can use a command like ``git checkout --detach v6.1.5`` to
> +   access any such release.
> +
> +   This flexibility comes at a cost, as cloning the sources like this will
> +   download quite a bit of data: roundabout 2,5 Gigabyte for mainline and 1,8
> +   for stable/longterm releases as of early 2022. See the reference section for
> +   a somewhat more complicated approach which is also using git, but downloads
> +   only slightly more data than downloading a compressed tarball would.
> +
> +   [:ref:`details<sources>`]
> +
> [...]
> +
> +.. _sources:
> +
> +Download the sources
> +--------------------
> +
> +  *Retrieve the sources of the Linux version you intend to build.*
> +  [:ref:`...<sources_sbs>`]
> +
> +Fetching the complete stable git repository as explained in the step-by-step
> +guide above is easy and offers the most flexibility, but also downloads quite a
> +bit of data (more than 4 Gigabyte as of late 2022). If you want something
> +lighter, you instead might want to create a 'shallow clone' that omits some of
> +the history and only contains stable series you are interested in::
> +
> +       git clone --no-checkout \
> +         https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git \
> +         --depth 1 -b v6.0 ~/linux/sources/
> +       cd ~/linux/sources/
> +       git remote set-branches --add origin master
> +       git remote add -t linux-6.1.y linux-stable \
> +         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> +       git fetch --all --shallow-exclude=v6.0
> +
> +The initial command creates a clone with the sources of just Linux v6.0; this
> +downloads just a little more data than retrieving a xz-compressed tarball of
> +that version would (~230 vs 204 Megabyte); afterwards the master branch is added
> +to the list of tracked branches, which allows you to retrieve anything state of
> +mainline since Linux 6.0 was released. The linux-stable repository is then added
> +as a remote which just tracks the linux-6.1.y branch. In early 2022 as of Linux
> +v6.2-rc4 the last two steps downloaded ~95 and ~2 Megabyte.
> +
> +With this tree you can check out the latest mainline code using ``git checkout
> +--detach origin/master``. All versions and individual changes released between
> +6.0 and the latest 6.1.y version are at hand, too -- this tree thus also allows
> +you to bisect a problem introduced in that range.
> +
> +Later run above 'git fetch [...]' command again, when you want to retrieve the
> +latest mainline codebase or access 6.1.y versions released in between. If you
> +want to switch to a release from a newer stable series (say Linux v6.2.y), you
> +first need to add its remote branch with a command like ``git remote
> +set-branches --add linux-stable linux-6.2.y``; once you run 'git fetch [...]'
> +again you'll be able to check out versions from that series.
> +
> +[:ref:`back to step-by-step guide <sources_sbs>`]
> +

