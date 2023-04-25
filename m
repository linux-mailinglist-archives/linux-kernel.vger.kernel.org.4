Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC6C6EE278
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjDYNGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjDYNGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:06:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197B213F88
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:06:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-958bb7731a9so602879566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1682427988; x=1685019988;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuHaspB/oFBju3VrywE2adNd40q2V+OVQqVD9MlGFlg=;
        b=EMd7sTJ2x2uBAJLPOLVg4WRaYTt5IoWOoE2rU/Sw5g/fCHH3HzLLh6RC0wrw4vmC/d
         XMJA5VMM8yh4F7baqzjyKvnZHca5xz4mb235sSjvutjIwThJH81l0c17d5cJ9MFxpj1b
         xUBATU33B2JODpOB4ao/EbhH4HhKSiSa9GhAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682427988; x=1685019988;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuHaspB/oFBju3VrywE2adNd40q2V+OVQqVD9MlGFlg=;
        b=Na9yUj7OUv4vq3XFmbe7Ylwpf5xh5UYl13bYLAiYrYSHVaI1l9Dnt2AMYroFh4v5tm
         iw/pCc7p/CGQ32M+gwr7n7ANIvkyCoqeRICroXhY/oQtvHfvJ70N+optskWTxfqlhA9t
         2AKBNcYJHfptgdSPO2vgKJBnPGPpbgtco3tgKCVtBfjLYRnlbgyhijK4bUT2EOVTGGx6
         Vjme0n2ci8OVH6hqXAuJGvskZb/eG3IYjdQUM4p++G9hmLgfybnF6fh+Jp+R/sv+KgFK
         mz1zGiKNRAxIP5f5P5lAusrh6U4Tv4hD7A0jupFlRk/OlXizo0F2MRo4Znb7q+rZb9h5
         2l6w==
X-Gm-Message-State: AAQBX9dTNNyBfVQP5nzLLuBn2MHNjHs82azutU0e5dCR8dby3sJPiphJ
        nRSZ8a/AmaBd3TO3/haO6womhRSTGqErMOEoLLY=
X-Google-Smtp-Source: AKy350Y6dXNUbPZcVpfcpxh8a/7+pp1O6EVi8flCmr24oaxlsnxiRiUrkkI7OvjphvCMtAXJawTbeA==
X-Received: by 2002:a17:906:6c95:b0:946:f79b:e785 with SMTP id s21-20020a1709066c9500b00946f79be785mr13059279ejr.2.1682427987523;
        Tue, 25 Apr 2023 06:06:27 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:530d])
        by smtp.gmail.com with ESMTPSA id my17-20020a1709065a5100b0095728081944sm5423261ejc.146.2023.04.25.06.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:06:27 -0700 (PDT)
Date:   Tue, 25 Apr 2023 14:06:26 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: [PATCH v5 2/2] printk: console: Support console-specific loglevels
Message-ID: <4d3846bf2543de20aa071b2a12de924eea3e9574.1682427812.git.chris@chrisdown.name>
References: <cover.1682427812.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682427812.git.chris@chrisdown.name>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consoles can have vastly different latencies and throughputs. For
example, writing a message to the serial console can take on the order
of tens of milliseconds to get the UART to successfully write a message.
While this might be fine for a single, one-off message, this can cause
significant application-level stalls in situations where the kernel
writes large amounts of information to the console.

This means that while you might want to send at least INFO level
messages to (for example) netconsole, which is relatively fast, you may
only want to send at least WARN level messages to the serial console.
Such an implementation would permit debugging using the serial console
in cases that netconsole doesn't receive messages during particularly
bad system issues, while still keeping the noise low enough to avoid
inducing latency in userspace applications. This patch adds such an
interface, extending the existing console loglevel controls to allow
each console to have its own loglevel.

One can't just disable the serial console, because one may actually need
it in situations where the machine is in a bad enough state that nothing
is received on netconsole. One also can't just bump the loglevel at
runtime after the issue, because usually the machine is already so
wedged by this point that it isn't responsive to such requests.

In terms of technical implementation, this patch embeds a device pointer
in the console struct, and registers each console using it so we can
expose attributes in sysfs. We currently expose the following
attributes:

    % ls -l /sys/class/console/ttyS/
    total 0
    lrwxrwxrwx 1 root root    0 Jul 20 17:37 subsystem -> ../../../../class/console/
    -r--r--r-- 1 root root 4096 Jul 20 17:38 effective_loglevel
    -r--r--r-- 1 root root 4096 Jul 20 17:38 effective_loglevel_source
    -r--r--r-- 1 root root 4096 Jul 20 17:38 enabled
    -rw-r--r-- 1 root root 4096 Jul 20 17:38 loglevel
    -rw-r--r-- 1 root root 4096 Jul 20 17:37 uevent

The lifecycle of this classdev looks like this on registration:

    register_console(con)/printk_late_init()
      console_register_device(con)
        device_initialize(con->classdev) # refcount++
        device_add(con->classdev)        # refcount++

At stable state, the refcount is two.

Console unregistration looks like this:

    [con->classdev refcount drops to 0]
      console_classdev_release(con->classdev)
        kfree(con->classdev)

    unregister_console(con)
      device_unregister(con->classdev)
        device_del(con->classdev) # refcount--
          device_remove_class_symlinks()
            kernfs_remove_by_name_ns()
              kernfs_drain()
                kernfs_drain_open_files() # wait for close()
        put_device(con->classdev) # refcount--

We also deprecate the kernel.printk sysctl as it doesn't know about
per-console loglevels, and is generally pretty confusing.

For information on the precedence and application of the new controls,
see Documentation/ABI/testing/sysfs-class-console and
Documentation/admin-guide/per-console-loglevel.rst.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 Documentation/ABI/testing/sysfs-class-console |  47 ++
 Documentation/admin-guide/index.rst           |   1 +
 .../admin-guide/kernel-parameters.txt         |  28 +-
 .../admin-guide/per-console-loglevel.rst      |  92 ++++
 Documentation/admin-guide/serial-console.rst  |  17 +-
 Documentation/core-api/printk-basics.rst      |  35 +-
 Documentation/networking/netconsole.rst       |  17 +
 MAINTAINERS                                   |   3 +
 drivers/tty/sysrq.c                           |  15 +
 include/linux/console.h                       |   3 +
 include/linux/printk.h                        |   9 +
 kernel/printk/console_cmdline.h               |   2 +
 kernel/printk/printk.c                        | 410 +++++++++++++++++-
 kernel/printk/sysctl.c                        |  57 ++-
 14 files changed, 688 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-console
 create mode 100644 Documentation/admin-guide/per-console-loglevel.rst

diff --git a/Documentation/ABI/testing/sysfs-class-console b/Documentation/ABI/testing/sysfs-class-console
new file mode 100644
index 000000000000..35a117d521cf
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-console
@@ -0,0 +1,47 @@
+What:		/sys/class/console/
+Date:		April 2023
+Contact:	Chris Down <chris@chrisdown.name>
+Description:	Interface for viewing and setting per-console attributes, like
+		the per-console loglevel. For a high-level document describing
+		the motivations for this interface and related non-sysfs
+		controls, see
+		Documentation/admin-guide/per-console-loglevel.rst.
+
+What:		/sys/class/console/<C>/effective_loglevel
+Date:		April 2023
+Contact:	Chris Down <chris@chrisdown.name>
+Description:	Read only. The currently effective loglevel for this console.
+		All messages emitted with a loglevel below the effective value
+		will be emitted to the console.
+
+What:		/sys/class/console/<C>/effective_loglevel_source
+Date:		April 2023
+Contact:	Chris Down <chris@chrisdown.name>
+Description:	Read only. The currently effective loglevel source for this
+		console -- for example, whether it was set globally, or whether
+		it was set locally for this console.
+
+		Possible values are:
+			=============== ============================================
+			local           The loglevel comes from the per-console
+			                loglevel.
+			global          The loglevel comes from the global loglevel.
+			ignore_loglevel Both the per-console loglevel and global
+			                loglevels are ignored as ignore_loglevel is
+			                present on the kernel command line.
+			=============== ============================================
+
+What:		/sys/class/console/<C>/enabled
+Date:		April 2023
+Contact:	Chris Down <chris@chrisdown.name>
+Description:	Read only. "1" if the console is enabled, "0" otherwise.
+
+What:		/sys/class/console/<C>/loglevel
+Date:		April 2023
+Contact:	Chris Down <chris@chrisdown.name>
+Description:	Read write. The current per-console loglevel, which will take
+		effect if not overridden by other non-sysfs controls (see
+		Documentation/admin-guide/per-console-loglevel.rst). Bounds are
+		0 (LOGLEVEL_EMERG) to 8 (LOGLEVEL_DEBUG + 1) inclusive. Also
+		takes the special value "-1" to indicate that no per-console
+		loglevel is set, and we should defer to the global controls.
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 43ea35613dfc..6143a83c48f3 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -117,6 +117,7 @@ configure specific aspects of kernel behavior to your liking.
    namespaces/index
    numastat
    parport
+   per-console-loglevel
    perf-security
    pm/index
    pnp
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 10e2e5c3ff0b..d956424ccd35 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -722,13 +722,18 @@
 		ttyS<n>[,options]
 		ttyUSB0[,options]
 			Use the specified serial port.  The options are of
-			the form "bbbbpnf", where "bbbb" is the baud rate,
-			"p" is parity ("n", "o", or "e"), "n" is number of
-			bits, and "f" is flow control ("r" for RTS or
-			omit it).  Default is "9600n8".
+			the form "bbbbpnf,extra", where "bbbb" is the baud
+			rate, "p" is parity ("n", "o", or "e"), "n" is
+			number of bits, and "f" is flow control ("r" for RTS
+			or omit it). Default is "9600n8".
 
-			See Documentation/admin-guide/serial-console.rst for more
-			information.  See
+			At present the only extra option is "loglevel" to
+			set the per-console loglevel. For example:
+
+				console=ttyS0,9600n8,loglevel:3
+
+			See Documentation/admin-guide/serial-console.rst for
+			more information.  See
 			Documentation/networking/netconsole.rst for an
 			alternative.
 
@@ -2877,10 +2882,13 @@
 	logibm.irq=	[HW,MOUSE] Logitech Bus Mouse Driver
 			Format: <irq>
 
-	loglevel=	All Kernel Messages with a loglevel smaller than the
-			console loglevel will be printed to the console. It can
-			also be changed with klogd or other programs. The
-			loglevels are defined as follows:
+	loglevel=	Sets the global loglevel. All messages with a loglevel
+			smaller than the console loglevel will be printed to
+			the console. Note that this can be overridden
+			per-console, see
+			Documentation/admin-guide/per-console-loglevel.rst.
+
+			The loglevels are defined as follows:
 
 			0 (KERN_EMERG)		system is unusable
 			1 (KERN_ALERT)		action must be taken immediately
diff --git a/Documentation/admin-guide/per-console-loglevel.rst b/Documentation/admin-guide/per-console-loglevel.rst
new file mode 100644
index 000000000000..4a7ecce7ba8a
--- /dev/null
+++ b/Documentation/admin-guide/per-console-loglevel.rst
@@ -0,0 +1,92 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _per_console_loglevel:
+
+Per-console loglevel support
+============================
+
+Motivation
+----------
+
+Consoles can have vastly different latencies and throughputs. For example,
+writing a message to the serial console can take on the order of tens of
+milliseconds to get the UART to successfully write a message. While this might
+be fine for a single, one-off message, this can cause significant
+application-level stalls in situations where the kernel writes large amounts of
+information to the console.
+
+This means that while you might want to send at least INFO level messages to
+(for example) netconsole, which is relatively fast, you may only want to send
+at least WARN level messages to the serial console. This permits debugging
+using the serial console in cases that netconsole doesn't receive messages
+during particularly bad system issues, while still keeping the noise low enough
+to avoid inducing latency in userspace applications.
+
+Tunables
+--------
+
+In order to allow tuning this, the following controls exist:
+
+Global
+~~~~~~
+
+The global loglevel is set by the ``kernel.console_loglevel`` sysctl, which can
+also be set as ``loglevel=`` on the kernel command line.
+
+The printk module also takes two parameters which modify this behaviour
+further:
+
+* ``ignore_loglevel`` on the kernel command line or set in printk parameters:
+  Emit all messages. All other controls are ignored if this is present.
+* ``ignore_per_console_loglevel`` on the kernel command line or set in printk
+  parameters: Ignore all per-console loglevels and use the global loglevel.
+
+The default value for ``kernel.console_loglevel`` comes from
+``CONFIG_CONSOLE_LOGLEVEL_DEFAULT``, or ``CONFIG_CONSOLE_LOGLEVEL_QUIET`` if
+``quiet`` is passed on the kernel command line.
+
+Console attributes
+~~~~~~~~~~~~~~~~~~
+
+Registered consoles are exposed at ``/sys/class/console``. For example, if you
+are using ``ttyS0``, the console backing it can be viewed at
+``/sys/class/console/ttyS0/``. The following files are available:
+
+* ``effective_loglevel`` (r): The effective loglevel after considering all
+  loglevel authorities. For example, if the console-specific loglevel is 3, but
+  the global minimum console loglevel [*]_ is 5, then the value will be 5.
+* ``effective_loglevel_source`` (r): The loglevel authority which resulted in
+  the effective loglevel being set. The following values can be present:
+
+    * ``local``: The console-specific loglevel is in effect.
+    * ``global``: The global loglevel (``kernel.console_loglevel``) is in
+      effect. Set a console-specific loglevel to override it.
+    * ``ignore_loglevel``: ``ignore_loglevel`` was specified on the kernel
+      command line or at ``/sys/module/printk/parameters/ignore_loglevel``.
+      Disable it to use level controls.
+    * ``ignore_per_console_loglevel``: ``ignore_per_console_loglevel`` was
+      specified on the kernel command line or at
+      ``/sys/module/printk/parameters/ignore_per_console_loglevel``. Disable it
+      to use per-console level controls.
+
+* ``enabled`` (r): Whether the console is enabled.
+* ``loglevel`` (rw): The local, console-specific loglevel for this console.
+  This will be in effect if no other global control overrides it. Look at
+  ``effective_loglevel`` and ``effective_loglevel_source`` to verify that.
+
+.. [*] The existence of a minimum console loglevel is generally considered to
+   be a confusing and rarely used interface, and as such is not exposed through
+   the modern printk sysctl APIs that obsoleted ``kernel.printk``. Use the
+   legacy ``kernel.printk`` sysctl to control it if you have a rare use case
+   that requires changing it. The default value is ``CONSOLE_LOGLEVEL_MIN``.
+
+Deprecated
+~~~~~~~~~~
+
+* ``kernel.printk`` sysctl: this takes four values, setting
+  ``kernel.console_loglevel``, ``kernel.default_message_loglevel``, the minimum
+  console loglevel, and a fourth unused value. The interface is generally
+  considered to quite confusing, doesn't perform checks on the values given,
+  and is unaware of per-console loglevel semantics.
+
+Chris Down <chris@chrisdown.name>, 27-April-2023
diff --git a/Documentation/admin-guide/serial-console.rst b/Documentation/admin-guide/serial-console.rst
index 58b32832e50a..4e204115fe4a 100644
--- a/Documentation/admin-guide/serial-console.rst
+++ b/Documentation/admin-guide/serial-console.rst
@@ -32,15 +32,25 @@ The format of this option is::
 			and F is flow control ('r' for RTS). Default is
 			9600n8. The maximum baudrate is 115200.
 
+			One can also specify the per-console loglevel for this
+			console by providing a loglevel parameter, for example
+			"loglevel:4" to set this console's loglevel to 4. The
+			value provided can be from 0 (LOGLEVEL_EMERG) to 8
+			(LOGLEVEL_DEBUG + 1), and messages below that will be
+			emitted onto the console as they become available.
+
 You can specify multiple console= options on the kernel command line.
 Output will appear on all of them. The last device will be used when
 you open ``/dev/console``. So, for example::
 
-	console=ttyS1,9600 console=tty0
+	console=ttyS1,9600,loglevel:5 console=tty0
 
 defines that opening ``/dev/console`` will get you the current foreground
-virtual console, and kernel messages will appear on both the VGA
-console and the 2nd serial port (ttyS1 or COM2) at 9600 baud.
+virtual console, and kernel messages will appear on both the VGA console and
+the 2nd serial port (ttyS1 or COM2) at 9600 baud. The optional loglevel "5"
+indicates that this console will emit messages more serious than
+LOGLEVEL_NOTICE (that is, LOGLEVEL_WARNING and below, since more serious
+messages have lower ordering).
 
 Note that you can only define one console per device type (serial, video).
 
@@ -113,3 +123,4 @@ Replace the sample values as needed.
    the integration of these patches into m68k, ppc and alpha.
 
 Miquel van Smoorenburg <miquels@cistron.nl>, 11-Jun-2000
+Chris Down <chris@chrisdown.name>, 27-April-2023
diff --git a/Documentation/core-api/printk-basics.rst b/Documentation/core-api/printk-basics.rst
index 2dde24ca7d9f..bfad359505bb 100644
--- a/Documentation/core-api/printk-basics.rst
+++ b/Documentation/core-api/printk-basics.rst
@@ -54,32 +54,33 @@ string, the log level is not a separate argument). The available log levels are:
 
 The log level specifies the importance of a message. The kernel decides whether
 to show the message immediately (printing it to the current console) depending
-on its log level and the current *console_loglevel* (a kernel variable). If the
-message priority is higher (lower log level value) than the *console_loglevel*
-the message will be printed to the console.
+on its log level and the current global *console_loglevel* or local per-console
+loglevel (kernel variables). If the message priority is higher (lower log level
+value) than the effective loglevel the message will be printed to the console.
 
 If the log level is omitted, the message is printed with ``KERN_DEFAULT``
 level.
 
-You can check the current *console_loglevel* with::
+You can check the current console's loglevel -- for example if you want to
+check the loglevel for serial consoles:
 
-  $ cat /proc/sys/kernel/printk
-  4        4        1        7
+  $ cat /sys/class/console/ttyS0/effective_loglevel
+  6
+  $ cat /sys/class/console/ttyS0/effective_loglevel_source
+  local
 
-The result shows the *current*, *default*, *minimum* and *boot-time-default* log
-levels.
+To change the default loglevel for all consoles, simply write the desired level
+to ``/proc/sys/kernel/console_loglevel``. For example::
 
-To change the current console_loglevel simply write the desired level to
-``/proc/sys/kernel/printk``. For example, to print all messages to the console::
+  # echo 5 > /proc/sys/kernel/console_loglevel
 
-  # echo 8 > /proc/sys/kernel/printk
+This sets the console_loglevel to print KERN_WARNING (4) or more severe
+messages to console. Consoles with a per-console loglevel set will ignore it
+unless ``ignore_per_console_loglevel`` is set on the kernel command line or at
+``/sys/module/printk/parameters/ignore_per_console_loglevel``.
 
-Another way, using ``dmesg``::
-
-  # dmesg -n 5
-
-sets the console_loglevel to print KERN_WARNING (4) or more severe messages to
-console. See ``dmesg(1)`` for more information.
+For more information on per-console loglevels, see
+Documentation/admin-guide/per-console-loglevel.rst.
 
 As an alternative to printk() you can use the ``pr_*()`` aliases for
 logging. This family of macros embed the log level in the macro names. For
diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index dd0518e002f6..e2c094a96f16 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -67,6 +67,23 @@ Built-in netconsole starts immediately after the TCP stack is
 initialized and attempts to bring up the supplied dev at the supplied
 address.
 
+You can also set a loglevel at boot time on the kernel command line::
+
+  console=netcon0,loglevel:2
+
+This can also be changed at runtime::
+
+  $ ls -l /sys/class/console/netcon0/
+  total 0
+  lrwxrwxrwx 1 root root    0 May 18 13:28 subsystem -> ../../../../class/console/
+  -r--r--r-- 1 root root 4096 May 18 13:28 effective_loglevel
+  -r--r--r-- 1 root root 4096 May 18 13:28 effective_loglevel_source
+  -r--r--r-- 1 root root 4096 May 18 13:28 enabled
+  -rw-r--r-- 1 root root 4096 May 18 13:28 loglevel
+  -rw-r--r-- 1 root root 4096 May 18 13:28 uevent
+
+See Documentation/admin-guide/per-console-loglevel.rst for more information.
+
 The remote host has several options to receive the kernel messages,
 for example:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 14fadebf42fd..ecf906bb37ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16805,6 +16805,9 @@ R:	Steven Rostedt <rostedt@goodmis.org>
 R:	John Ogness <john.ogness@linutronix.de>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
+F:	Documentation/ABI/testing/sysfs-class-console
+F:	Documentation/admin-guide/per-console-loglevel.rst
+F:	Documentation/core-api/printk-basics.rst
 F:	include/linux/printk.h
 F:	kernel/printk/
 
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index b6e70c5cfa17..f62beafd5d49 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -51,6 +51,7 @@
 #include <linux/syscalls.h>
 #include <linux/of.h>
 #include <linux/rcupdate.h>
+#include <linux/console.h>
 
 #include <asm/ptrace.h>
 #include <asm/irq_regs.h>
@@ -101,12 +102,26 @@ __setup("sysrq_always_enabled", sysrq_always_enabled_setup);
 static void sysrq_handle_loglevel(int key)
 {
 	int i;
+	int cookie;
+	int warned = 0;
+	struct console *con;
 
 	i = key - '0';
 	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
 	pr_info("Loglevel set to %d\n", i);
 	console_loglevel = i;
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		if (!warned && per_console_loglevel_is_set(con)) {
+			warned = 1;
+			pr_warn("Overriding per-console loglevel from sysrq\n");
+		}
+		con->level = -1;
+	}
+	console_srcu_read_unlock(cookie);
 }
+
 static const struct sysrq_key_op sysrq_loglevel_op = {
 	.handler	= sysrq_handle_loglevel,
 	.help_msg	= "loglevel(0-9)",
diff --git a/include/linux/console.h b/include/linux/console.h
index d3195664baa5..77052f863571 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -17,6 +17,7 @@
 #include <linux/atomic.h>
 #include <linux/bits.h>
 #include <linux/rculist.h>
+#include <linux/device.h>
 #include <linux/types.h>
 
 struct vc_data;
@@ -203,6 +204,8 @@ struct console {
 	unsigned long		dropped;
 	void			*data;
 	struct hlist_node	node;
+	int			level;
+	struct device		*classdev;
 };
 
 #ifdef CONFIG_LOCKDEP
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8ef499ab3c1e..25ba0873dee8 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -69,6 +69,8 @@ extern int console_printk[];
 
 extern void console_verbose(void);
 
+int clamp_loglevel(int level);
+
 /* strlen("ratelimit") + 1 */
 #define DEVKMSG_STR_MAX_SIZE 10
 extern char devkmsg_log_str[];
@@ -139,6 +141,7 @@ void early_printk(const char *s, ...) { }
 #endif
 
 struct dev_printk_info;
+struct console;
 
 #ifdef CONFIG_PRINTK
 asmlinkage __printf(4, 0)
@@ -192,6 +195,8 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+
+bool per_console_loglevel_is_set(const struct console *con);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -271,6 +276,10 @@ static inline void dump_stack(void)
 static inline void printk_trigger_flush(void)
 {
 }
+static inline bool per_console_loglevel_is_set(const struct console *con)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/kernel/printk/console_cmdline.h b/kernel/printk/console_cmdline.h
index 3ca74ad391d6..40f1a1ff0965 100644
--- a/kernel/printk/console_cmdline.h
+++ b/kernel/printk/console_cmdline.h
@@ -6,6 +6,8 @@ struct console_cmdline
 {
 	char	name[16];			/* Name of the driver	    */
 	int	index;				/* Minor dev. to use	    */
+	int	level;				/* Log level to use */
+	short	flags;				/* Initial flags */
 	bool	user_specified;			/* Specified by command line vs. platform */
 	char	*options;			/* Options for the driver   */
 #ifdef CONFIG_A11Y_BRAILLE_CONSOLE
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 041c7bd56005..f006960ce18b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -44,6 +44,7 @@
 #include <linux/irq_work.h>
 #include <linux/ctype.h>
 #include <linux/uio.h>
+#include <linux/device.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
@@ -199,6 +200,12 @@ static int __init control_devkmsg(char *str)
 }
 __setup("printk.devkmsg=", control_devkmsg);
 
+int clamp_loglevel(int level)
+{
+	return clamp(level, minimum_console_loglevel,
+		     CONSOLE_LOGLEVEL_MOTORMOUTH);
+}
+
 char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE] = "ratelimit";
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
 int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
@@ -466,6 +473,14 @@ static struct latched_seq clear_seq = {
 	.val[1]		= 0,
 };
 
+static struct class *console_class;
+
+enum loglevel_source {
+	LLS_GLOBAL,
+	LLS_LOCAL,
+	LLS_IGNORE_LOGLEVEL,
+};
+
 #define LOG_LEVEL(v)		((v) & 0x07)
 #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
 
@@ -696,7 +711,8 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 	return len;
 }
 
-static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
+static bool printk_get_next_message(struct printk_message *pmsg,
+				    struct console *con, u64 seq,
 				    bool is_extended, bool may_supress);
 
 /* /dev/kmsg - userspace message inject/listen interface */
@@ -799,7 +815,8 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 
-	if (!printk_get_next_message(&pmsg, atomic64_read(&user->seq), true, false)) {
+	if (!printk_get_next_message(&pmsg, NULL, atomic64_read(&user->seq),
+				     true, false)) {
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			goto out;
@@ -816,8 +833,8 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		 * This pairs with __wake_up_klogd:A.
 		 */
 		ret = wait_event_interruptible(log_wait,
-				printk_get_next_message(&pmsg, atomic64_read(&user->seq), true,
-							false)); /* LMM(devkmsg_read:A) */
+				printk_get_next_message(&pmsg, NULL, atomic64_read(&user->seq),
+							true, false)); /* LMM(devkmsg_read:A) */
 		if (ret)
 			goto out;
 	}
@@ -1261,9 +1278,119 @@ module_param(ignore_loglevel, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(ignore_loglevel,
 		 "ignore loglevel setting (prints all kernel messages to the console)");
 
-static bool suppress_message_printing(int level)
+static bool __read_mostly ignore_per_console_loglevel;
+
+static int __init ignore_per_console_loglevel_setup(char *str)
+{
+	ignore_per_console_loglevel = true;
+	return 0;
+}
+
+early_param("ignore_per_console_loglevel", ignore_per_console_loglevel_setup);
+module_param(ignore_per_console_loglevel, bool, 0644);
+MODULE_PARM_DESC(
+	ignore_per_console_loglevel,
+	"ignore per-console loglevel setting (only respect global console loglevel)");
+
+bool per_console_loglevel_is_set(const struct console *con)
+{
+	return !ignore_per_console_loglevel && con && (con->level > 0);
+}
+
+/*
+ * Hierarchy of loglevel authority:
+ *
+ * 1. con->level. The locally set, console-specific loglevel. Optional, only
+ *    valid if >0.
+ * 2. console_loglevel. The default global console loglevel, always present.
+ *
+ * The behaviour can be further changed by the following printk module
+ * parameters:
+ *
+ * 1. ignore_loglevel. Can be set at boot or at runtime with
+ *    /sys/module/printk/parameters/ignore_loglevel. Overrides absolutely
+ *    everything since it's used to debug.
+ * 2. ignore_per_console_loglevel. Existing per-console loglevel values are left
+ *    intact, but are ignored in favour of console_loglevel as long as this is
+ *    true. Also manipulated through syslog(SYSLOG_ACTION_CONSOLE_{ON,OFF}).
+ */
+static enum loglevel_source
+console_effective_loglevel_source(const struct console *con)
+{
+	if (WARN_ON_ONCE(!con))
+		return LLS_GLOBAL;
+
+	if (ignore_loglevel)
+		return LLS_IGNORE_LOGLEVEL;
+
+	if (per_console_loglevel_is_set(con))
+		return LLS_LOCAL;
+
+	return LLS_GLOBAL;
+}
+
+static int console_effective_loglevel(const struct console *con)
 {
-	return (level >= console_loglevel && !ignore_loglevel);
+	enum loglevel_source source;
+	int level;
+
+	if (WARN_ON_ONCE(!con))
+		return default_console_loglevel;
+
+	source = console_effective_loglevel_source(con);
+
+	switch (source) {
+	case LLS_IGNORE_LOGLEVEL:
+		level = CONSOLE_LOGLEVEL_MOTORMOUTH;
+		break;
+	case LLS_LOCAL:
+		level = con->level;
+		break;
+	case LLS_GLOBAL:
+		level = console_loglevel;
+		break;
+	default:
+		pr_warn("Unhandled console loglevel source: %d", source);
+		level = default_console_loglevel;
+		break;
+	}
+
+	return level;
+}
+
+static const char *
+console_effective_loglevel_source_str(const struct console *con)
+{
+	enum loglevel_source source;
+	const char *str;
+
+	if (WARN_ON_ONCE(!con))
+		return "unknown";
+
+	source = console_effective_loglevel_source(con);
+
+	switch (source) {
+	case LLS_IGNORE_LOGLEVEL:
+		str = "ignore_loglevel";
+		break;
+	case LLS_LOCAL:
+		str = "local";
+		break;
+	case LLS_GLOBAL:
+		str = "global";
+		break;
+	default:
+		pr_warn("Unhandled console loglevel source: %d", source);
+		str = "unknown";
+		break;
+	}
+
+	return str;
+}
+
+static bool suppress_message_printing(int level, struct console *con)
+{
+	return level >= console_effective_loglevel(con);
 }
 
 #ifdef CONFIG_BOOT_PRINTK_DELAY
@@ -1718,6 +1845,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	struct printk_info info;
 	bool clear = false;
 	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
+	static int saved_ignore_per_console_loglevel;
 	int error;
 
 	error = check_syslog_permissions(type, source);
@@ -1758,19 +1886,28 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	/* Disable logging to console */
 	case SYSLOG_ACTION_CONSOLE_OFF:
-		if (saved_console_loglevel == LOGLEVEL_DEFAULT)
+		if (saved_console_loglevel == LOGLEVEL_DEFAULT) {
 			saved_console_loglevel = console_loglevel;
+			saved_ignore_per_console_loglevel =
+				ignore_per_console_loglevel;
+		}
 		console_loglevel = minimum_console_loglevel;
+		ignore_per_console_loglevel = true;
 		break;
 	/* Enable logging to console */
 	case SYSLOG_ACTION_CONSOLE_ON:
 		if (saved_console_loglevel != LOGLEVEL_DEFAULT) {
 			console_loglevel = saved_console_loglevel;
+			ignore_per_console_loglevel =
+				saved_ignore_per_console_loglevel;
 			saved_console_loglevel = LOGLEVEL_DEFAULT;
 		}
 		break;
 	/* Set level of messages printed to console */
 	case SYSLOG_ACTION_CONSOLE_LEVEL:
+		if (!ignore_per_console_loglevel)
+			pr_warn_once(
+				"SYSLOG_ACTION_CONSOLE_LEVEL is ignored by consoles with an explicitly set per-console loglevel, see Documentation/admin-guide/per-console-loglevel\n");
 		if (len < 1 || len > 8)
 			return -EINVAL;
 		if (len < minimum_console_loglevel)
@@ -2060,11 +2197,8 @@ static u8 *__printk_recursion_counter(void)
 
 int printk_delay_msec __read_mostly;
 
-static inline void printk_delay(int level)
+static inline void printk_delay(void)
 {
-	if (suppress_message_printing(level))
-		return;
-
 	boot_delay_msec();
 
 	if (unlikely(printk_delay_msec)) {
@@ -2278,7 +2412,9 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const char *fmt, va_list args)
 {
 	int printed_len;
+	int cookie;
 	bool in_sched = false;
+	struct console *con;
 
 	/* Suppress unimportant messages after panic happens */
 	if (unlikely(suppress_printk))
@@ -2293,7 +2429,14 @@ asmlinkage int vprintk_emit(int facility, int level,
 		in_sched = true;
 	}
 
-	printk_delay(level);
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		if (!suppress_message_printing(level, con)) {
+			printk_delay();
+			break;
+		}
+	}
+	console_srcu_read_unlock(cookie);
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
@@ -2370,7 +2513,10 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 				  struct dev_printk_info *dev_info) { return 0; }
 static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(int cookie) { return 0; }
-static bool suppress_message_printing(int level) { return false; }
+static bool suppress_message_printing(int level, struct console *con)
+{
+	return false;
+}
 static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
 
@@ -2410,11 +2556,78 @@ static void set_user_specified(struct console_cmdline *c, bool user_specified)
 	console_set_on_cmdline = 1;
 }
 
+static bool find_and_remove_console_option(char *options, const char *key,
+					   char *val_buf, size_t val_buf_size)
+{
+	bool found = false, first = true;
+	char *option, *next = options;
+
+	while ((option = strsep(&next, ","))) {
+		char *value;
+
+		value = strchr(option, ':');
+		if (value)
+			*(value++) = '\0';
+
+		if (strcmp(option, key) == 0) {
+			found = true;
+			if (value) {
+				if (strlen(value) > val_buf_size - 1) {
+					pr_warn("Can't copy console option value for %s:%s: not enough space (%zu)\n",
+						option, value, val_buf_size);
+					found = false;
+				} else {
+					strscpy(val_buf, value, val_buf_size);
+				}
+			} else
+				*val_buf = '\0';
+		}
+
+		if (found)
+			break;
+
+		if (next)
+			*(next - 1) = ',';
+		if (value)
+			*(value - 1) = ':';
+
+		first = false;
+	}
+
+	if (found) {
+		if (next)
+			memmove(option, next, strlen(next) + 1);
+		else if (first)
+			*option = '\0';
+		else
+			*--option = '\0';
+	}
+
+	return found;
+}
+
+static int find_and_remove_loglevel_option(char *options)
+{
+	char val[3];
+	int loglevel;
+
+	if (!find_and_remove_console_option(options, "loglevel", val,
+					    sizeof(val)))
+		return -ENOENT;
+
+	if (kstrtoint(val, 10, &loglevel)) {
+		pr_warn("Invalid console loglevel, ignoring: %s\n", val);
+		return -EINVAL;
+	}
+
+	return clamp_loglevel(loglevel);
+}
+
 static int __add_preferred_console(char *name, int idx, char *options,
 				   char *brl_options, bool user_specified)
 {
 	struct console_cmdline *c;
-	int i;
+	int i, ret;
 
 	/*
 	 *	See if this tty is not yet registered, and
@@ -2435,6 +2648,11 @@ static int __add_preferred_console(char *name, int idx, char *options,
 	if (!brl_options)
 		preferred_console = i;
 	strscpy(c->name, name, sizeof(c->name));
+
+	ret = find_and_remove_loglevel_option(options);
+	if (ret >= 0)
+		c->level = ret;
+
 	c->options = options;
 	set_user_specified(c, user_specified);
 	braille_set_options(c, brl_options);
@@ -2764,7 +2982,8 @@ static void console_prepend_dropped(struct printk_message *pmsg, unsigned long d
  * of @pmsg are valid. (See the documentation of struct printk_message
  * for information about the @pmsg fields.)
  */
-static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
+static bool printk_get_next_message(struct printk_message *pmsg,
+				    struct console *con, u64 seq,
 				    bool is_extended, bool may_suppress)
 {
 	static int panic_console_dropped;
@@ -2808,7 +3027,7 @@ static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	}
 
 	/* Skip record that has level above the console loglevel. */
-	if (may_suppress && suppress_message_printing(r.info->level))
+	if (may_suppress && suppress_message_printing(r.info->level, con))
 		goto out;
 
 	if (is_extended) {
@@ -2851,7 +3070,7 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 
 	*handover = false;
 
-	if (!printk_get_next_message(&pmsg, con->seq, is_extended, true))
+	if (!printk_get_next_message(&pmsg, con, con->seq, is_extended, true))
 		return false;
 
 	con->dropped += pmsg.dropped;
@@ -3199,6 +3418,144 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+#ifdef CONFIG_PRINTK
+static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct console *con = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", con->level);
+}
+
+static ssize_t loglevel_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t size)
+{
+	struct console *con = dev_get_drvdata(dev);
+	ssize_t ret;
+	int level;
+
+	ret = kstrtoint(buf, 10, &level);
+	if (ret < 0)
+		return ret;
+
+	if (level == -1) {
+		con->level = level;
+		return size;
+	}
+
+	if (clamp_loglevel(level) != level)
+		return -ERANGE;
+
+	con->level = level;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(loglevel);
+
+static ssize_t effective_loglevel_source_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct console *con = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n",
+			  console_effective_loglevel_source_str(con));
+}
+
+static DEVICE_ATTR_RO(effective_loglevel_source);
+
+static ssize_t effective_loglevel_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct console *con = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", console_effective_loglevel(con));
+}
+
+static DEVICE_ATTR_RO(effective_loglevel);
+
+static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct console *con = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", !!(con->flags & CON_ENABLED));
+}
+
+static DEVICE_ATTR_RO(enabled);
+
+static struct attribute *console_sysfs_attrs[] = {
+	&dev_attr_loglevel.attr,
+	&dev_attr_effective_loglevel_source.attr,
+	&dev_attr_effective_loglevel.attr,
+	&dev_attr_enabled.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(console_sysfs);
+
+static void console_classdev_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+static void console_register_device(struct console *con)
+{
+	/*
+	 * We might be called from register_console() before the class is
+	 * registered. If that happens, we'll take care of it in
+	 * printk_late_init.
+	 */
+	if (IS_ERR_OR_NULL(console_class))
+		return;
+
+	if (WARN_ON(con->classdev))
+		return;
+
+	con->classdev = kzalloc(sizeof(struct device), GFP_KERNEL);
+	if (!con->classdev)
+		return;
+
+	device_initialize(con->classdev);
+	dev_set_name(con->classdev, "%s%d", con->name, con->index);
+	dev_set_drvdata(con->classdev, con);
+	con->classdev->release = console_classdev_release;
+	con->classdev->class = console_class;
+	if (device_add(con->classdev))
+		put_device(con->classdev);
+}
+
+static void console_setup_class(void)
+{
+	struct console *con;
+	int cookie;
+
+	/*
+	 * printk exists for the lifetime of the kernel, it cannot be unloaded,
+	 * so we should never end up back in here.
+	 */
+	if (WARN_ON(console_class))
+		return;
+
+	console_class = class_create(THIS_MODULE, "console");
+	if (!IS_ERR(console_class))
+		console_class->dev_groups = console_sysfs_groups;
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con)
+		console_register_device(con);
+	console_srcu_read_unlock(cookie);
+}
+#else /* CONFIG_PRINTK */
+static void console_register_device(struct console *new)
+{
+}
+static void console_setup_class(void)
+{
+}
+#endif
+
 /*
  * This is called by register_console() to try to match
  * the newly registered console with any of the ones selected
@@ -3231,6 +3588,14 @@ static int try_enable_preferred_console(struct console *newcon,
 			if (newcon->index < 0)
 				newcon->index = c->index;
 
+			if (c->level > 0)
+				newcon->level = c->level;
+			else
+				newcon->level = -1;
+
+			newcon->flags |= c->flags;
+			newcon->classdev = NULL;
+
 			if (_braille_register_console(newcon, c))
 				return 0;
 
@@ -3456,6 +3821,7 @@ void register_console(struct console *newcon)
 	 * register_console() completes.
 	 */
 
+	console_register_device(newcon);
 	console_sysfs_notify();
 
 	/*
@@ -3523,6 +3889,9 @@ static int unregister_console_locked(struct console *console)
 	 */
 	synchronize_srcu(&console_srcu);
 
+	if (console->classdev)
+		device_unregister(console->classdev);
+
 	console_sysfs_notify();
 
 	if (console->exit)
@@ -3627,6 +3996,10 @@ void __init console_init(void)
  * To mitigate this problem somewhat, only unregister consoles whose memory
  * intersects with the init section. Note that all other boot consoles will
  * get unregistered when the real preferred console is registered.
+ *
+ * Early consoles will also have been registered before we had the
+ * infrastructure to put them into /sys/class/console, so make sure they get
+ * set up now that we're ready.
  */
 static int __init printk_late_init(void)
 {
@@ -3664,6 +4037,9 @@ static int __init printk_late_init(void)
 					console_cpu_notify, NULL);
 	WARN_ON(ret < 0);
 	printk_sysctl_init();
+
+	console_setup_class();
+
 	return 0;
 }
 late_initcall(printk_late_init);
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index c228343eeb97..688e1ebb7066 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -7,10 +7,14 @@
 #include <linux/printk.h>
 #include <linux/capability.h>
 #include <linux/ratelimit.h>
+#include <linux/console.h>
 #include "internal.h"
 
 static const int ten_thousand = 10000;
 
+static int min_loglevel = LOGLEVEL_EMERG;
+static int max_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
+
 static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -20,13 +24,48 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
 	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 }
 
+static int printk_sysctl_deprecated(struct ctl_table *table, int write,
+				    void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int res = proc_dointvec(table, write, buffer, lenp, ppos);
+
+	if (write)
+		pr_warn_once(
+			"printk: The kernel.printk sysctl is deprecated. Consider using kernel.console_loglevel or kernel.default_message_loglevel instead.\n");
+
+	return res;
+}
+
+static int printk_console_loglevel(struct ctl_table *table, int write,
+				   void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table ltable = *table;
+	int ret, level;
+
+	if (!write)
+		return proc_dointvec(table, write, buffer, lenp, ppos);
+
+	ltable.data = &level;
+
+	ret = proc_dointvec(&ltable, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
+
+	if (level != -1 && level != clamp_loglevel(level))
+		return -ERANGE;
+
+	console_loglevel = level;
+
+	return 0;
+}
+
 static struct ctl_table printk_sysctls[] = {
 	{
 		.procname	= "printk",
 		.data		= &console_loglevel,
 		.maxlen		= 4*sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= printk_sysctl_deprecated,
 	},
 	{
 		.procname	= "printk_ratelimit",
@@ -76,6 +115,22 @@ static struct ctl_table printk_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "console_loglevel",
+		.data		= &console_loglevel,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= printk_console_loglevel,
+	},
+	{
+		.procname	= "default_message_loglevel",
+		.data		= &default_message_loglevel,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &min_loglevel,
+		.extra2		= &max_loglevel,
+	},
 	{}
 };
 
-- 
2.40.0

