Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFDD686599
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjBALwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjBALwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:52:42 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4212D6187F;
        Wed,  1 Feb 2023 03:52:34 -0800 (PST)
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1pNBfC-0000S5-TT; Wed, 01 Feb 2023 12:52:31 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: [PATCH v1] docs: describe how to quickly build Linux
Date:   Wed,  1 Feb 2023 12:52:30 +0100
Message-Id: <fabdb45fa44db2531f0dbe5e88545c49dfb87040.1675252073.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1675252355;b8730951;
X-HE-SMSGID: 1pNBfC-0000S5-TT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a text explaining how to quickly build a kernel, as that's something
users will often have to do when they want to report an issue or test
proposed fixes. This is a huge and frightening task for quite a few
users these days, as many rely on pre-compiled kernels and have never
built their own. They find help on quite a few websites explaining the
process in various ways, but those howtos often omit important details
or make things too hard for the 'quickly build just for testing' case
that 'localmodconfig' is really useful for. Hence give users something
at hand to guide them, as that makes it easier for them to help with
testing, debugging, and fixing the kernel.

To keep the complexity at bay, the document explicitly focuses on how to
compile the kernel on commodity distributions running on commodity
hardware. People that deal with less common distributions or hardware
will often know their way around already anyway.

The text describes a few oddities of Arch and Debian that were found by
the author and a few volunteers that tested the described procedure.
There are likely more such quirks that need to be covered as well as a
few things the author will have missed -- but one has to start
somewhere.

The document heavily uses anchors and links to them, which makes things
slightly harder to read in the source tree. But the intended target
audience is way more likely to read rendered versions of this text on
pages like docs.kernel.org anyway -- and there those anchors and links
allow easy jumps to the reference section and back, which makes the
document a lot easier to work with for the intended target audience.

Aspects relevant for bisection were left out on purpose, as that is a
related, but in the end different use case. The rough plan is to have a
second document with a similar style to cover bisection. The idea is to
reuse a few bits from this document and link quite often to entries in
the reference section with the help of the anchors in this text.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

Hi! Above patch description covers nearly everything already, there is
just one thing where I'm unsure about the approach and would like to
hear other opinions on:

The text currently describes two approaches to retrieve Linux' sources
using git: the regular clone with linux-stable as a remote and a shallow
clone with just one branch from linux-stable. The shallow clone approach
is a little bit more tricky to describe and handle, but downloads way
less data – and thus is a lot quicker, unless you have a really really
quick link to the internet (which in some parts of the world is hard to
come by). That's why I wonder if the text should switch to making the
shallow clone with selected stable branches the default. What do you
think, dear reader?

Ciao, Thorsten

P.S.: a rendered version of this text is temporarily available at:
https://www.leemhuis.info/files/misc/How%20to%20quickly%20build%20a%20Linux%20kernel%20%E2%80%94%20The%20Linux%20Kernel%20documentation.html
---
 .../admin-guide/howto-quickly-build-linux.rst | 903 ++++++++++++++++++
 Documentation/admin-guide/index.rst           |   1 +
 MAINTAINERS                                   |   1 +
 3 files changed, 905 insertions(+)
 create mode 100644 Documentation/admin-guide/howto-quickly-build-linux.rst

diff --git a/Documentation/admin-guide/howto-quickly-build-linux.rst b/Documentation/admin-guide/howto-quickly-build-linux.rst
new file mode 100644
index 000000000000..d1ca349774a1
--- /dev/null
+++ b/Documentation/admin-guide/howto-quickly-build-linux.rst
@@ -0,0 +1,903 @@
+.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
+.. [see the bottom of this file for redistribution information]
+
+===================================
+How to quickly build a Linux kernel
+===================================
+
+This guide explains how to build Linux kernels that are ideal for testing
+purposes, but perfectly fine for day-to-day use, too.
+
+The essence of the process (aka 'TL;DR')
+========================================
+
+*[If you are new to compiling Linux, ignore this TLDR and head over to the next
+section below: it contains a step-by-step guide, which is more detailed, but
+still brief and easy to follow; that guide and its accompanying reference
+section also mention alternatives, pitfalls, and additional aspects, all of
+which might be relevant for you.]*
+
+If your platform uses techniques like Secure Boot, prepare the system to permit
+starting self-compiled Linux kernels; install compilers and everything else
+needed for building Linux; make sure to have 15 Gigabyte free space in your home
+directory. Now run the following commands to download the sources of Linux,
+which you then use to configure, build and install your own kernel::
+
+       mkdir ~/linux/ ~/linux/sources ~/linux/build
+       git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git \
+         ~/linux/sources
+       cd ~/linux/sources/
+       # hint: if you don't want to build any stable or longterm kernels, skip the
+       #   next two commands
+       git remote add linux-stable \
+         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
+       git fetch --all
+       # hint: if you want to apply patches, do it at this point (see below for details)
+       # hint: at this point it's recommended to tag your build (see below for details)
+       yes "" | make O=~/linux/build/ localmodconfig
+       # hint: at this point you might want or have to adjust the build configuration
+       #  (see below for details)
+       # note: if you are running a Debian kernel, you'll have to adjust the configuration
+       #  at this point (see below)
+       make -j $(nproc --all) O=~/linux/build/
+       command -v installkernel && sudo make O=~/linux/build/ modules_install install
+       # note: on quite a few distributions the last command does the trick; on others,
+       #   like Arch Linux, it's not enough (see below)
+
+Step-by-step guide
+==================
+
+Compiling your own Linux kernel is easy in principle. There are various ways to
+do it. Which of them actually work and is the best depends on the circumstances.
+
+This guide describes a way perfectly suited for those who want to quickly
+install Linux from sources without being bothered by complicated details; the
+goal is to cover everything typically needed on mainstream Linux distributions
+running on commodity PC or server hardware.
+
+The described approach is great for testing purposes, for example to try a
+proposed fix or check if the latest codebase still contains a problem.
+Nonetheless, kernels built this way are also totally fine for day-to-day use
+while at the same time being easy to keep up to date.
+
+The following steps describe the important aspects of the process; a
+comprehensive reference section later explains each of them in more detail. It
+sometimes also describes alternative approaches, pitfalls, as well as errors
+that might occur at a particular point -- and how to then get things rolling
+again.
+
+.. _backup_sbs:
+
+ * Create a fresh backup and put system repair and restore tools at hand, just
+   to be prepared for the unlikely case that something might go sideways.
+
+   [:ref:`details<backup>`]
+
+.. _secureboot_sbs:
+
+ * On platforms with 'Secure Boot' or similar techniques, prepare everything to
+   ensure the system will permit your self-compiled kernel to boot later. The
+   quickest and easiest way to achieve this on commodity x86 systems is to turn
+   such techniques off in the BIOS setup utility; alternatively remove their
+   restrictions through a process initiated by ``mokutil --disable-validation``.
+
+   [:ref:`details<secureboot>`]
+
+.. _buildrequires_sbs:
+
+ * Install all software required to build a Linux kernel. Often you will need:
+   'bc', 'binutils' ('ld' et al.), 'bison', 'flex', 'gcc', 'git', 'openssl',
+   'pahole', 'perl', and the development headers for 'libelf' and 'openssl'. The
+   reference section shows how to quickly install those on various Linux
+   distributions.
+
+   [:ref:`details<buildrequires>`]
+
+.. _diskspace_sbs:
+
+ * Ensure to have enough free space for building and installing Linux. For the
+   latter 150 Megabyte in /lib/ and 100 in /boot/ are a safe bet. For storing
+   sources and build artifacts 15 Gigabyte in your home directory should
+   typically suffice. If you have less available, be sure to check the reference
+   section for the steps about downloading the Linux sources and adjusting your
+   kernels build configuration: they mention tricks that reduce the amount of
+   required space in /home/ to around 3,5 Gigabyte.
+
+   [:ref:`details<diskspace>`]
+
+.. _directories_sbs:
+
+ * Create directories for sources and build artifacts::
+
+          mkdir ~/linux/ ~/linux/sources ~/linux/build
+
+   [:ref:`details<directories>`]
+
+.. _sources_sbs:
+
+ * Retrieve the sources of the Linux version you intend to build; then change
+   into the directory holding them, as all further commands in this guide are
+   meant to be executed from there.
+
+   If you plan to only build one particular kernel version, download its source
+   archive from https://kernel.org; afterwards extract its content to '~/linux/'
+   and change into the directory created during extraction.
+
+   In most other situations your best choice is to fetch the sources using git::
+
+          git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git \
+            ~/linux/sources
+          cd ~/linux/sources/
+
+   Now you can check out any mainline release with a command like
+   ``git checkout --detach v6.1``; pre-release like v6.2-rc2 work, too.
+   Specifying 'origin/master' will hand you the latest mainline code, which is
+   automatically checked out by the above 'git clone […]' command.
+
+   In case you want to build a stable or longterm kernel, run this, too::
+
+          git remote add linux-stable \
+            https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
+          git fetch --all
+
+   Afterwards you can use a command like ``git checkout --detach v6.1.5`` to
+   access any such release.
+
+   This flexibility comes at a cost, as cloning the sources like this will
+   download quite a bit of data: roundabout 2,5 Gigabyte for mainline and 1,8
+   for stable/longterm releases as of early 2022. See the reference section for
+   a somewhat more complicated approach which is also using git, but downloads
+   only slightly more data than downloading a compressed tarball would.
+
+   [:ref:`details<sources>`]
+
+.. _patching_sbs:
+
+ * In case you want to apply a kernel patch, do so now. Often a command like
+   this will do the trick::
+
+          patch -p1 < ../proposed-fix.patch
+
+   If the '-p1' is actually needed, depends on how the patch was created; in
+   case it doesn't apply thus try without it.
+
+   If you cloned the sources with git and anything goes sideways, run ``git
+   reset --hard`` to undo any changes to the sources.
+
+   [:ref:`details<patching>`]
+
+.. _tagging_sbs:
+
+ * If you patched your kernel or already have that kernel version installed,
+   better tag your kernel by extending its release name (the one 'uname -r'
+   prints when executed under a kernel)::
+
+          sed -i 's!^EXTRAVERSION =.*$!&-proposed-fix!' Makefile
+
+   [:ref:`details<tagging>`]
+
+ .. _configuration_sbs:
+
+ * Create the build configuration for your kernel based on an existing
+   configuration.
+
+   If you already prepared such a '.config' file yourself, copy it to
+   ~/linux/build/ and run ``make O=~/linux/build/ olddefconfig``.
+
+   Use the same command, if your distribution or somebody else already tailored
+   your running kernel to your or your hardware's needs: the make target
+   olddefconfig will then try to use that kernel's .config as base.
+
+   Using this make target is fine for everybody else, too -- but you often can
+   save a lot of time by using this command instead::
+
+          yes "" | make O=~/linux/build/ localmodconfig
+
+   This will also try to pick your distribution's kernel as base, but then
+   disable modules for any features apparently superfluous for your setup. This
+   will later reduce the compile time enormously, especially if you are running
+   an universal kernel from a mainstream Linux distribution.
+
+   There is a catch: localmodconfig will disable kernel features you haven't
+   actually utilized through some action or program since you booted the system.
+   You can reduce or even eliminate that risk by using tricks outlined in the
+   reference section; for quick testing purposes that risk is often negligible,
+   but it's an aspect you want to keep in mind in case your kernel behaves
+   oddly.
+
+   [:ref:`details<configuration>`]
+
+.. _configmods_sbs:
+
+ * Check if you might want to or have to adjust some kernel configuration
+   options:
+
+  * Evaluate how you want to handle debug symbols. Enable them, if you later
+    might need to decode a stack trace found for example in a 'panic', 'Oops',
+    'warning', or 'BUG'; on the other hand disable them, if you are short on
+    storage space or prefer a smaller kernel binary. See the reference section
+    for details on how to do either. If neither applies, it'll likely be fine
+    to simply not bother with this. [:ref:`details<configmods_debugsymbols>`]
+
+  * Are you running Debian? Then to avoid known problems you need to perform
+    additional adjustments explained in the reference section.
+    [:ref:`details<configmods_distros>`].
+
+.. _build_sbs:
+
+ * Build the image and the modules of your kernel::
+
+          make -j $(nproc --all) O=~/linux/build/
+
+   [:ref:`details<build>`]
+
+.. _install_sbs:
+
+ * Now install your kernel::
+
+          command -v installkernel && sudo make O=~/linux/build/ modules_install install
+
+   Often all left for you to do afterwards is a ``reboot``, as many commodity
+   Linux distributions will create an initramfs (also known as initrd) and an
+   entry for your kernel in your boot-loader's configuration when you execute
+   above command; but on some distributions you have to take care of these two
+   steps manually for reasons the reference section explains.
+
+   On a few distributions like Arch Linux and its derivatives the above command
+   does nothing at all; in that case you have to manually install your kernel,
+   as outlined in the reference section.
+
+   [:ref:`details<install>`]
+
+.. _another_sbs:
+
+ * To later build another kernel you need similar, but sometimes slightly
+   different commands.
+
+   In case you cloned the sources using git and want to build the latest
+   mainline codebase or update to a version released in between? Then first
+   update your git clone::
+
+          git fetch --all
+
+   To build another version or codebase you will have to first discard any local
+   modification, for example if you applied a patch or a tag as advertised; only
+   then you can switch to the code you are interested in::
+
+          git reset --hard
+          git checkout origin/master
+
+   At this point you might want to patch or tag the sources again, as explained
+   above. Afterwards adjust the build configuration to the new environment and
+   build your next kernel::
+
+          # reminder: if you want to apply patches, do it at this point
+          # reminder: at this point it's recommended to tag your build
+          make O=~/linux/build/ olddefconfig
+          make -j $(nproc --all) O=~/linux/build/
+
+   Install this kernel as described earlier; most of the time this command thus
+   will do the trick::
+
+           command -v installkernel && sudo make O=~/linux/build/ modules_install install
+
+   [:ref:`details<another>`]
+
+.. _uninstall_sbs:
+
+ * All parts of your installed kernel are normally identifiable by its release
+   name, which make them easy to locate and remove later. When doing so, ensure
+   to not remove the kernel you are running, as that might render your system
+   unbootable.
+
+   Start by deleting the directory holding your kernel's modules, which is named
+   after its release name -- '6.0.1-foobar' in the following example::
+
+          sudo rm -rf /lib/modules/6.9.1-foobar
+
+   Now try the following command, which on some distributions will delete all
+   other kernel files installed and remove the kernel's entry from the boot
+   loader configuration::
+
+          command -v kernel-install && sudo kernel-install -v remove 6.0.1-foobar
+
+   If that command doesn't output anything or fails, see the reference section;
+   do the same if any files named '*6.0.1-foobar*' remain in /boot/.
+
+   [:ref:`details<uninstall>`]
+
+.. _submit_improvements:
+
+Did you run into trouble following any of the above steps that is not cleared up
+by the reference section below? Or do you have ideas how to improve the text?
+Then please take a moment of your time and let the maintainer of this document
+know by email (Thorsten Leemhuis <linux@leemhuis.info>), ideally while CCing the
+Linux docs mailing list (linux-doc@vger.kernel.org). Such feedback is vital to
+improve this document further, which is in everybody's interest, as it will
+enable more people to master the task described here.
+
+Reference section for the step-by-step guide
+============================================
+
+This section holds additional information for each of the steps in the above
+guide.
+
+.. _backup:
+
+Prepare for emergencies
+-----------------------
+
+   *Create a fresh backup and put system repair and restore tools at hand*
+   [:ref:`... <backup_sbs>`]
+
+Remember, you are dealing with computers, which sometimes do unexpected things
+-- especially if you fiddle with crucial parts like the kernel of an operating
+system. That's what you are about to do in this process. Hence, better prepare
+for something going sideways, even if that shouldn't happen.
+
+[:ref:`back to step-by-step guide <backup_sbs>`]
+
+.. _secureboot:
+
+Dealing with techniques like Secure Boot
+----------------------------------------
+
+   *On platforms with 'Secure Boot' or similar techniques, prepare everything to
+   ensure the system will permit your self-compiled kernel to boot later.*
+   [:ref:`... <secureboot_sbs>`]
+
+Many modern systems allow only certain operating systems to start; they thus by
+default will reject booting self-compiled kernels.
+
+You ideally deal with this by making your platform trust your self-built kernels
+with the help of a certificate and signing. How to do that is not described
+here, as it requires various steps that would take the text too far away from
+its purpose; but you'll find many pages on the web that explain this in detail.
+
+Temporarily disabling solutions like Secure Boot is another way to make your own
+Linux boot. On commodity x86 systems it's possible to do this in the BIOS Setup
+utility; the steps to do so are not described here, as they greatly vary between
+machines.
+
+On mainstream x86 Linux distributions there is a third and universal option:
+disable all Secure Boot restrictions for your Linux environment. You can
+initiate this process by running ``mokutil --disable-validation``; this will
+tell you to create a one-time password, which is safe to write down. Now
+restart; right after your BIOS performed all self-tests the bootloader Shim will
+show a blue box with a message 'Press any key to perform MOK management'. Hit
+some key before the countdown exposes. This will open a menu and choose 'Change
+Secure Boot state' there. Shim's 'MokManager' will now ask you to enter three
+randomly chosen characters from the one-time password specified earlier. Once
+you provided them, confirm that you really want to disable the validation.
+Afterwards, permit MokManager to reboot the machine.
+
+[:ref:`back to step-by-step guide <secureboot_sbs>`]
+
+.. _buildrequires:
+
+Install build requirements
+--------------------------
+
+   *Install all software required to build a Linux kernel.*
+   [:ref:`...<buildrequires_sbs>`]
+
+The kernel is pretty stand-alone, but besides tools like the compiler you'll
+sometimes need a few libraries to build one. How to install everything needed
+depends on your Linux distribution and the configuration of the kernel you are
+about to build.
+
+Here are a few examples what you typically need on some mainstream
+distributions:
+
+ * Debian, Ubuntu, and derivatives::
+
+          sudo apt install bc binutils bison dwarves flex gcc git make openssl \
+            pahole perl-base libssl-dev libelf-dev
+
+ * Fedora and derivatives::
+
+          sudo dnf install binutils /usr/include/{libelf.h,openssl/pkcs7.h} \
+            /usr/bin/{bc,bison,flex,gcc,git,openssl,make,perl,pahole}
+
+ * openSUSE and derivatives::
+
+          sudo zypper install bc binutils bison dwarves flex gcc git make perl-base \
+            openssl openssl-devel libelf-dev
+
+In case you wonder why these lists include openssl and its development headers:
+they are needed for the Secure Boot support, which many distributions enable in
+their kernel configuration for x86 machines.
+
+Sometimes you'll need tools for compression formats like bzip2, gzip, lz4, lzma,
+lzo, xz, or zstd as well.
+
+You might need additional libraries and their development headers in case you
+perform tasks not covered in this guide. For example, zlib will be needed when
+building kernel tools from the tools/ directory; make targets like 'menuconfig'
+or 'xconfig' will require development headers for ncurses or Qt.
+
+[:ref:`back to step-by-step guide <buildrequires_sbs>`]
+
+.. _diskspace:
+
+Space requirements
+------------------
+
+   *Ensure to have enough free space for building and installing Linux.*
+   [:ref:`... <diskspace_sbs>`]
+
+The numbers mentioned are rough estimates with a big extra charge to be on the
+safe side, so often you will need less.
+
+If you have space constraints, remember to read the reference section for the
+steps :ref:`Downloading the Linux sources<sources>` and :ref:`Debug symbols in
+the section about configuration adjustments' <configmods>`: both mention tricks
+that reduce the consumed disk space by quite a lot.
+
+[:ref:`back to step-by-step guide <diskspace_sbs>`]
+
+
+.. _directories:
+
+Create dedicated directories
+----------------------------
+
+  *Create directories for sources and build artifacts:*
+  [:ref:`...<directories_sbs>`]
+
+You could build your kernel directly in the source tree, but it is good practice
+to keep it clean by storing the build artifacts separately. That's why this
+guide recommends creating a directory for the latter, which you hence must
+specify in later commands. Most of the time this is done by passing
+'O=~/linux/build/' to make.
+
+[:ref:`back to step-by-step guide <directories_sbs>`]
+
+.. _sources:
+
+Download the sources
+--------------------
+
+  *Retrieve the sources of the Linux version you intend to build.*
+  [:ref:`...<sources_sbs>`]
+
+Fetching the complete stable git repository as explained in the step-by-step
+guide above is easy and offers the most flexibility, but also downloads quite a
+bit of data (more than 4 Gigabyte as of late 2022). If you want something
+lighter, you instead might want to create a 'shallow clone' that omits some of
+the history and only contains stable series you are interested in::
+
+       git clone --no-checkout \
+         https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git \
+         --depth 1 -b v6.0 ~/linux/sources/
+       cd ~/linux/sources/
+       git remote set-branches --add origin master
+       git remote add -t linux-6.1.y linux-stable \
+         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
+       git fetch --all --shallow-exclude=v6.0
+
+The initial command creates a clone with the sources of just Linux v6.0; this
+downloads just a little more data than retrieving a xz-compressed tarball of
+that version would (~230 vs 204 Megabyte); afterwards the master branch is added
+to the list of tracked branches, which allows you to retrieve anything state of
+mainline since Linux 6.0 was released. The linux-stable repository is then added
+as a remote which just tracks the linux-6.1.y branch. In early 2022 as of Linux
+v6.2-rc4 the last two steps downloaded ~95 and ~2 Megabyte.
+
+With this tree you can check out the latest mainline code using ``git checkout
+--detach origin/master``. All versions and individual changes released between
+6.0 and the latest 6.1.y version are at hand, too -- this tree thus also allows
+you to bisect a problem introduced in that range.
+
+Later run above 'git fetch [...]' command again, when you want to retrieve the
+latest mainline codebase or access 6.1.y versions released in between. If you
+want to switch to a release from a newer stable series (say Linux v6.2.y), you
+first need to add its remote branch with a command like ``git remote
+set-branches --add linux-stable linux-6.2.y``; once you run 'git fetch [...]'
+again you'll be able to check out versions from that series.
+
+[:ref:`back to step-by-step guide <sources_sbs>`]
+
+.. _patching:
+
+Patch the sources (optional)
+----------------------------
+
+  *In case you want to apply a kernel patch, do so now.*
+  [:ref:`...<patching_sbs>`]
+
+This is the point where you might want to patch your kernel -- for example when
+a developer proposed a fix and asked you to check if it helps. The step-by-step
+guide already explains everything crucial here.
+
+[:ref:`back to step-by-step guide <patching_sbs>`]
+
+.. _tagging:
+
+Tagging this kernel build (optional, often wise)
+------------------------------------------------
+
+  *If you patched your kernel or already have that kernel version installed,
+  better tag your kernel by extending its release name:*
+  [:ref:`...<tagging_sbs>`]
+
+Tagging your kernel will help avoid confusion later, especially when you patched
+your kernel. Adding an individual tag will also ensure the kernel's image and
+its modules are installed in parallel to any existing kernels.
+
+The step-by-step guide uses a sed command to create a descriptive tag to your
+kernel's release name by adding it to the EXTRAVERSION line at the start of the
+main Makefile. To remove the tag later, simply delete it; if you cloned the
+sources with git, you can do this by discarding any changes to the Makefile by
+running ``git checkout Makefile``.
+
+[:ref:`back to step-by-step guide <tagging_sbs>`]
+
+.. _configuration:
+
+Define the build configuration for your kernel
+----------------------------------------------
+
+  *Create the build configuration for your kernel based on an existing
+  configuration.* [:ref:`... <configuration_sbs>`]
+
+There are various aspects for this steps that require a more careful
+explanation:
+
+Pitfalls when using another configuration file as base
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Make targets like localmodconfig and olddefconfig share a few common snares you
+want to be aware of:
+
+ * These targets will reuse a kernel build configuration in your build directory
+   (e.g. '~/linux/build/.config'), if one exists. In case you want to start from
+   scratch you thus need to delete it.
+
+ * The make targets try to find the configuration for your running kernel
+   automatically, but might choose poorly. A line like '# using defaults found in
+   /boot/config-6.0.7-250.fc36.x86_64' or 'using config:
+   '/boot/config-6.0.7-250.fc36.x86_64' tells you which file they picked. If that
+   is not the intended one, simply store it as '~/linux/build/.config' before
+   using these make targets.
+
+ * Unexpected things might happen if you try to use a config file prepared for
+   one kernel (say v6.0) on an older generation (say v5.15). In that case you
+   might want to use a configuration as base which your distribution utilized when
+   they used that or an slightly older kernel version.
+
+Influencing the configuration
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The make target 'olddefconfig' and the ``yes "" |`` used when utilizing
+localmodconfig will set any undefined build options to their default value. This
+among others will disable many kernel features that were introduced after your
+base kernel was released.
+
+If you want to set these configurations options manually, use 'oldconfig'
+instead of 'olddefconfig' or omit the ``yes "" |`` when utilizing
+localmodconfig. Then for each undefined configuration option you will be asked
+how to proceed. In case you are unsure what to answer, simply hit 'enter' to
+apply the default value.
+
+Big pitfall when using localmodconfig
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+As explained briefly in the step-by-step guide already: with localmodconfig it
+can easily happen that your self-built kernel will lack modules for tasks you
+didn't perform before utilizing this make target. That's because those tasks
+require kernel modules that are normally autoloaded when you perform that task
+for the first time; if you didn't perform that task at least once before using
+localmodonfig, the latter will thus assume these modules are superfluous and
+disable them.
+
+You can try to avoid this by performing typical tasks that often will autoload
+additional kernel modules: start a VM, establish VPN connections, loop-mount a
+CD/DVD ISO, mount network shares (CIFS, NFS, …), and connect all external
+devices (2FA keys, headsets, webcams, …) as well as storage devices with file
+systems you otherwise don't utilize (btrfs, ext4, FAT, NTFS, XFS, …). But it's
+hard to think of everything that might be needed -- even kernel developers often
+forget one thing or another at this point.
+
+Don't let that risk bother you, especially when compiling a kernel only for
+testing purposes: everything typically crucial will be there. And if you forget
+something important you can turn on a missing feature later and quickly run the
+commands to compile and install a better kernel.
+
+But if you plan to build and use self-built kernels regularly, you might want to
+reduce the risk by recording which modules your system loads over the course of
+a few weeks. You can automate this with `modprobed-db
+<https://github.com/graysky2/modprobed-db>`_. Afterwards use 'LSMOD=<path>' to
+point localmodconfig to the list of modules modprobed-db noticed being used::
+
+       yes "" | make O=~/linux/build/ LSMOD="${HOME}"/.config/modprobed.db localmodconfig
+
+Remote building with localmodconfig
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If you want to use 'localmodconfig' to build a kernel for another machine, run
+``lsmod > lsmod_foo-machine`` on it and transfer that file to your build host.
+Now point the build scripts to the file like this: ``yes "" | make
+O=~/linux/build/ LSMOD=~/lsmod_foo-machine localmodconfig``. Note, in this case
+you likely want to copy a base kernel configuration from the other machine over
+as well and place it as .config in your build directory.
+
+[:ref:`back to step-by-step guide <configuration_sbs>`]
+
+.. _configmods:
+
+Adjust build configuration
+--------------------------
+
+   *Check if you might want to or have to adjust some kernel configuration
+   options:*
+
+Depending on your needs you at this point might want or have to adjust some
+kernel configuration options.
+
+.. _configmods_debugsymbols:
+
+Debug symbols
+~~~~~~~~~~~~~
+
+   *Evaluate how you want to handle debug symbols.*
+   [:ref:`...<configmods_sbs>`]
+
+Most users don't need to care about this, it's often fine to leave everything as
+it is; but you should take a closer look at this, if you might need to decode a
+stack trace or want to reduce space consumption.
+
+Having debug symbols available can be important when your kernel throws a
+'panic', 'Oops', 'warning', or 'BUG' later when running, as then you will be
+able to find the exact place where the problem occurred in the code. But
+collecting and embedding the needed debug information takes time and consumes
+quite a bit of space: in late 2022 the build artifacts for a typical x86 kernel
+configured with localmodconfig consumed around 5 Gigabyte of space with debug
+symbols, but less than 1 when they were disabled. The resulting kernel image and
+the modules are bigger as well, which increases load times.
+
+Hence, if you want a small kernel and are unlikely to decode a stack trace
+later, you might want to disable debug symbols to avoid above downsides::
+
+       ./scripts/config --file ~/linux/build/.config -d DEBUG_INFO \
+         -d DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT -d DEBUG_INFO_DWARF4 \
+         -d DEBUG_INFO_DWARF5 -e CONFIG_DEBUG_INFO_NONE
+       make O=~/linux/build/ olddefconfig
+
+You on the other hand definitely want to enable them, if there is a decent
+chance that you need to decode a stack trace later (as explained by 'Decode
+failure messages' in Documentation/admin-guide/tainted-kernels.rst in more
+detail)::
+
+       ./scripts/config --file ~/linux/build/.config -d DEBUG_INFO_NONE -e DEBUG_KERNEL
+         -e DEBUG_INFO -e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT -e KALLSYMS -e KALLSYMS_ALL
+       make O=~/linux/build/ olddefconfig
+
+Note, many mainstream distributions enable debug symbols in their kernel
+configurations -- make targets like localmodconfig and olddefconfig thus will
+often pick that setting up.
+
+[:ref:`back to step-by-step guide <configmods_sbs>`]
+
+.. _configmods_distros:
+
+Distro specific adjustments
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+   *Are you running* [:ref:`... <configmods_sbs>`]
+
+The following sections help you to avoid build problems that are known to occur
+when following this guide on a few commodity distributions.
+
+**Debian:**
+
+ * Remove a stale reference to a certificate file that would cause your build to
+   fail::
+
+         ./scripts/config --file ~/linux/build/.config --set-str SYSTEM_TRUSTED_KEYS ''
+
+   Alternatively, download the needed certificate and make that configuration
+   option point to it, as `the Debian handbook explains in more detail
+   <https://debian-handbook.info/browse/stable/sect.kernel-compilation.html>`_ .
+
+[:ref:`back to step-by-step guide <configmods_sbs>`]
+
+.. _build:
+
+Build your kernel
+-----------------
+
+  *Build the image and the modules of your kernel* [:ref:`... <build_sbs>`]
+
+A lot can go wrong at this stage that will abort the build process. Sometimes
+this is caused by problems on your side, which you'll often be able to fix
+quickly; sometimes though the problem lies in the code and can only be fixed by
+a developer.
+
+A close examination of the failure messages coupled with some research on the
+internet will often tell you which of the two it is. Before doing this, restart
+the build process like this::
+
+       make O=~/linux/build/ V=1
+
+The 'V=1' activates verbose output, which might be needed to see the actual
+error. To make it easier to spot, this command also omits the '-j $(nproc
+--all)' used earlier to utilize every CPU core in the system for the job. But
+this parallelism results in some clutter when failures occur, which makes the
+actual error message harder to spot.
+
+Once the failure happens again, try to find the most crucial line describing the
+problem. Then search the internet for the most important and non-generic section
+of that line (say 4 to 8 words); avoid or remove anything that looks remotely
+system-specific, like your username or local path names like '~/linux/build/'.
+First try your regular internet search engine with that string, afterwards
+search Linux kernel mailing lists via `lore.kernel.org/all/
+<https://lore.kernel.org/all/>`_.
+
+This most of the time will find something that will explain what's wrong; quite
+often one of the hits will provide a solution for your problem, too. If you
+don't find anything that matches your problem, try again from a different angle
+by modifying your search terms or using another line from the printed error
+messages.
+
+In the end, most trouble you are to run into has likely been encountered and
+reported by others already. That includes issues where the cause is not your
+system, but lies the code. If you run into one of those, you might thus find a
+solution (e.g. a patch) or workaround for your problem, too.
+
+[:ref:`back to step-by-step guide <build_sbs>`]
+
+.. _install:
+
+Install your kernel
+-------------------
+
+  *Now install your kernel* [:ref:`... <install_sbs>`]
+
+What you need to do after executing the command in the step-by-step guide
+depends on the existence and the implementation of an 'installkernel'
+executable. Many commodity Linux distributions ship such a kernel installer in
+'/sbin/' that does everything needed, hence there is nothing left for you except
+rebooting. But some distributions contain an installkernel that does only part
+of the job -- and a few lack it completely and leave all the work to you.
+
+If 'installkernel' is found, the kernel's build system will delegate the actual
+installation of your kernel's image and related files to this executable. On
+almost all Linux distributions it will store the image as '/boot/vmlinuz-<your
+kernel's release name>' and put a 'System.map-<your kernel's release name>'
+alongside it. Your kernel will thus be installed in parallel to any existing
+ones, unless you already have one with exactly the same release name.
+Installkernel on many distributions will afterwards generate an 'initramfs'
+(often also called 'initrd'), which commodity distributions rely on for booting;
+hence be sure to keep the order of the two make targets used in the step-by-step
+guide, as things will go sideways if you install your kernel's image before its
+modules. Often installkernel will then add your kernel to the boot loader
+configuration, too. You have to take care of one or both of these tasks
+yourself, if your distributions installkernel doesn't handle them.
+
+A few distributions like Arch Linux and its derivatives totally lack an
+installkernel executable. On those just install the modules using the kernel's
+build system and then install the image and the System.map file manually::
+
+          sudo make O=~/linux/build/ modules_install
+          sudo install -m 0600 ~/linux/build/$(make O=~/linux/build/ -s image_name) \
+            /boot/vmlinuz-$(make O=~/linux/build/ -s kernelrelease)
+          sudo install -m 0600 ~/linux/build/System.map \
+            /boot/System.map-$(make O=~/linux/build/ -s kernelrelease)
+
+If your distribution boots with the help of an initramfs, now generate one for
+your kernel using the tools your distribution provides for this process.
+Afterwards add your kernel to your boot-loader configuration and reboot.
+
+[:ref:`back to step-by-step guide <install_sbs>`]
+
+.. _another:
+
+Another round later
+-------------------
+
+  *To later build another kernel you need similar, but sometimes slightly
+  different commands* [:ref:`... <another_sbs>`]
+
+The process to build later kernels is similar, but at some points slightly
+different. You for example don't want to use 'localmodconfig' for succeeding
+kernel builds, as you already created a trimmed down configuration you want to
+use from now on. Hence instead just use 'oldconfig' or 'olddefconfig' to adjust
+your build configurations to the needs of the kernel version you are about to
+build.
+
+If you created a shallow-clone with git, remember what the :ref:`section that
+explained the setup described in more detail <sources>`: you need to use a
+slightly different 'git fetch' command and when switching to another series need
+to add an additional remote branch.
+
+[:ref:`back to step-by-step guide <another_sbs>`]
+
+.. _uninstall:
+
+Uninstall the kernel later
+--------------------------
+
+  *All parts of your installed kernel are identifiable by its release name and
+  thus easy to remove later.* [:ref:`... <uninstall_sbs>`]
+
+Don't worry installing your kernel manually and thus bypassing your
+distribution's packaging system will totally mess up your machine: all parts of
+your kernel are easy to remove later, as files are stored in two places only and
+normally identifiable by the kernel's release name.
+
+One of the two places is a directory in /lib/modules/, which holds the modules
+for each installed kernel. This directory is named after the kernel's release
+name; hence, to remove all modules for one of your kernels, simply remove its
+modules directory in /lib/modules/.
+
+The other place is /boot/, where typically one to five files will be placed
+during installation of a kernel. All of them usually contain the release name in
+their file name, but how many files and their name depends somewhat on your
+distribution's installkernel executable (:ref:`see above <install>`) and its
+initramfs generator. On some distributions the 'kernel-install' command
+mentioned in the step-by-step guide will remove all of these files for you --
+and the entry for your kernel in the boot-loader configuration at the same time,
+too. On others you have to take care of these steps yourself. The following
+command should interactively remove the two main files of a kernel with the
+release name '6.0.1-foobar'::
+
+       rm -i /boot/{System.map,vmlinuz}-6.0.1-foobar
+
+Now remove the belonging initramfs, which often will be called something like
+'/boot/initramfs-6.0.1-foobar.img' or '/boot/initrd.img-6.0.1-foobar'.
+Afterwards check for other files in /boot/ that have '6.0.1-foobar' in their
+name and delete them as well. Now remove the kernel from your boot-loader's
+configuration.
+
+Note, be very careful with wildcards like '*' when deleting files or directories
+for kernels manually: you might accidentally remove files of a 6.0.11 kernel
+when all you want is to remove 6.0 or 6.0.1.
+
+[:ref:`back to step-by-step guide <uninstall_sbs>`]
+
+.. _faq:
+
+FAQ
+===
+
+Why doesn't this 'how-to' work on my system?
+--------------------------------------------
+
+As initially stated, this guide is "designed to cover everything typically
+needed [to build a kernel] on mainstream Linux distributions running on
+commodity PC or server hardware". The outlined approach despite this should work
+on many other setups as well. But trying to cover every possible use-case in one
+guide would defeat its purpose, as without such a focus you'd need dozens or
+hundreds of constructs along the lines of "in case you are having <insert
+machine or distro>, you at this point have to do <this and that>
+<instead|additionally>". Each of which would make the text longer, more
+complicated, and harder to follow.
+
+That being said: this of course is a balancing act. Hence, if you think an
+additional use-case is worth describing, suggest it to the maintainers of this
+document (:ref:`see above <submit_improvements>`).
+
+
+..
+   end-of-content
+..
+   This document is maintained by Thorsten Leemhuis <linux@leemhuis.info>. If
+   you spot a typo or small mistake, feel free to let him know directly and
+   he'll fix it. You are free to do the same in a mostly informal way if you
+   want to contribute changes to the text -- but for copyright reasons please CC
+   linux-doc@vger.kernel.org and 'sign-off' your contribution as
+   Documentation/process/submitting-patches.rst explains in the section 'Sign
+   your work - the Developer's Certificate of Origin'.
+..
+   This text is available under GPL-2.0+ or CC-BY-4.0, as stated at the top
+   of the file. If you want to distribute this text under CC-BY-4.0 only,
+   please use 'The Linux kernel development community' for author attribution
+   and link this as source:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/howto-quickly-build-linux.rst
+..
+   Note: Only the content of this RST file as found in the Linux kernel sources
+   is available under CC-BY-4.0, as versions of this text that were processed
+   (for example by the kernel's build system) might contain content taken from
+   files which use a more restrictive license.
+
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 5bfafcbb9562..e11cd4bcfb9c 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -37,6 +37,7 @@ problems and bugs in particular.
    reporting-issues
    reporting-regressions
    security-bugs
+   howto-quickly-build-linux
    bug-hunting
    bug-bisect
    tainted-kernels
diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427..3d6da1f76026 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6329,6 +6329,7 @@ DOCUMENTATION REPORTING ISSUES
 M:	Thorsten Leemhuis <linux@leemhuis.info>
 L:	linux-doc@vger.kernel.org
 S:	Maintained
+F:	Documentation/admin-guide/howto-quickly-build-linux.rst
 F:	Documentation/admin-guide/reporting-issues.rst
 
 DOCUMENTATION SCRIPTS

base-commit: a16abc68e66c86ca9d80c4a04a2103ef7ed1a40f
-- 
2.39.1

