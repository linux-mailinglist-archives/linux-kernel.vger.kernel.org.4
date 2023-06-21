Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54EA738628
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjFUOFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjFUOEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:04:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F80A199E;
        Wed, 21 Jun 2023 07:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D85861568;
        Wed, 21 Jun 2023 14:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5925C433C8;
        Wed, 21 Jun 2023 14:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687356273;
        bh=nehLGq2Yrz4oC9N7WIELeJJvJ7z/HrJybYcND5eNtcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ta7adwYOWjD2bzhVqygHpwge2S+DGSs4D5WR09kGhwZ1lq33v6OMQGi8mV1d4Yfop
         ZvXvgsyERih1/OKblxQdYdprSpu2VLd+gU2okHUgULUZ3ualls0IcCRBOK4fDkT6TW
         YxzfBIS0/tS70AK5iGBRCBCSPrQ7ZzPMLrgeR8h4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.185
Date:   Wed, 21 Jun 2023 16:04:22 +0200
Message-ID: <2023062122-graveyard-chemo-e6c3@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023062121-coeditor-negligee-e7a6@gregkh>
References: <2023062121-coeditor-negligee-e7a6@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index eb437d659f2c..1f4a0523dc1a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -866,10 +866,6 @@
 
 	debugpat	[X86] Enable PAT debugging
 
-	decnet.addr=	[HW,NET]
-			Format: <area>[,<node>]
-			See also Documentation/networking/decnet.rst.
-
 	default_hugepagesz=
 			[HW] The size of the default HugeTLB page. This is
 			the size represented by the legacy /proc/ hugepages
diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 7f553859dba8..4f1a686b4b64 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -34,13 +34,14 @@ Table : Subdirectories in /proc/sys/net
  ========= =================== = ========== ==================
  Directory Content               Directory  Content
  ========= =================== = ========== ==================
- core      General parameter     appletalk  Appletalk protocol
- unix      Unix domain sockets   netrom     NET/ROM
- 802       E802 protocol         ax25       AX25
- ethernet  Ethernet protocol     rose       X.25 PLP layer
- ipv4      IP version 4          x25        X.25 protocol
- bridge    Bridging              decnet     DEC net
- ipv6      IP version 6          tipc       TIPC
+ 802       E802 protocol         mptcp     Multipath TCP
+ appletalk Appletalk protocol    netfilter Network Filter
+ ax25      AX25                  netrom     NET/ROM
+ bridge    Bridging              rose      X.25 PLP layer
+ core      General parameter     tipc      TIPC
+ ethernet  Ethernet protocol     unix      Unix domain sockets
+ ipv4      IP version 4          x25       X.25 protocol
+ ipv6      IP version 6
  ========= =================== = ========== ==================
 
 1. /proc/sys/net/core - Network core options
diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 741aa37dc181..2a7444e3a4c2 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -24,11 +24,8 @@ String Conversions
 .. kernel-doc:: lib/vsprintf.c
    :export:
 
-.. kernel-doc:: include/linux/kernel.h
-   :functions: kstrtol
-
-.. kernel-doc:: include/linux/kernel.h
-   :functions: kstrtoul
+.. kernel-doc:: include/linux/kstrtox.h
+   :functions: kstrtol kstrtoul
 
 .. kernel-doc:: lib/kstrtox.c
    :export:
diff --git a/Documentation/networking/decnet.rst b/Documentation/networking/decnet.rst
deleted file mode 100644
index b8bc11ff8370..000000000000
--- a/Documentation/networking/decnet.rst
+++ /dev/null
@@ -1,243 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-=========================================
-Linux DECnet Networking Layer Information
-=========================================
-
-1. Other documentation....
-==========================
-
-   - Project Home Pages
-     - http://www.chygwyn.com/				   - Kernel info
-     - http://linux-decnet.sourceforge.net/                - Userland tools
-     - http://www.sourceforge.net/projects/linux-decnet/   - Status page
-
-2. Configuring the kernel
-=========================
-
-Be sure to turn on the following options:
-
-    - CONFIG_DECNET (obviously)
-    - CONFIG_PROC_FS (to see what's going on)
-    - CONFIG_SYSCTL (for easy configuration)
-
-if you want to try out router support (not properly debugged yet)
-you'll need the following options as well...
-
-    - CONFIG_DECNET_ROUTER (to be able to add/delete routes)
-    - CONFIG_NETFILTER (will be required for the DECnet routing daemon)
-
-Don't turn on SIOCGIFCONF support for DECnet unless you are really sure
-that you need it, in general you won't and it can cause ifconfig to
-malfunction.
-
-Run time configuration has changed slightly from the 2.4 system. If you
-want to configure an endnode, then the simplified procedure is as follows:
-
- - Set the MAC address on your ethernet card before starting _any_ other
-   network protocols.
-
-As soon as your network card is brought into the UP state, DECnet should
-start working. If you need something more complicated or are unsure how
-to set the MAC address, see the next section. Also all configurations which
-worked with 2.4 will work under 2.5 with no change.
-
-3. Command line options
-=======================
-
-You can set a DECnet address on the kernel command line for compatibility
-with the 2.4 configuration procedure, but in general it's not needed any more.
-If you do st a DECnet address on the command line, it has only one purpose
-which is that its added to the addresses on the loopback device.
-
-With 2.4 kernels, DECnet would only recognise addresses as local if they
-were added to the loopback device. In 2.5, any local interface address
-can be used to loop back to the local machine. Of course this does not
-prevent you adding further addresses to the loopback device if you
-want to.
-
-N.B. Since the address list of an interface determines the addresses for
-which "hello" messages are sent, if you don't set an address on the loopback
-interface then you won't see any entries in /proc/net/neigh for the local
-host until such time as you start a connection. This doesn't affect the
-operation of the local communications in any other way though.
-
-The kernel command line takes options looking like the following::
-
-    decnet.addr=1,2
-
-the two numbers are the node address 1,2 = 1.2 For 2.2.xx kernels
-and early 2.3.xx kernels, you must use a comma when specifying the
-DECnet address like this. For more recent 2.3.xx kernels, you may
-use almost any character except space, although a `.` would be the most
-obvious choice :-)
-
-There used to be a third number specifying the node type. This option
-has gone away in favour of a per interface node type. This is now set
-using /proc/sys/net/decnet/conf/<dev>/forwarding. This file can be
-set with a single digit, 0=EndNode, 1=L1 Router and  2=L2 Router.
-
-There are also equivalent options for modules. The node address can
-also be set through the /proc/sys/net/decnet/ files, as can other system
-parameters.
-
-Currently the only supported devices are ethernet and ip_gre. The
-ethernet address of your ethernet card has to be set according to the DECnet
-address of the node in order for it to be autoconfigured (and then appear in
-/proc/net/decnet_dev). There is a utility available at the above
-FTP sites called dn2ethaddr which can compute the correct ethernet
-address to use. The address can be set by ifconfig either before or
-at the time the device is brought up. If you are using RedHat you can
-add the line::
-
-    MACADDR=AA:00:04:00:03:04
-
-or something similar, to /etc/sysconfig/network-scripts/ifcfg-eth0 or
-wherever your network card's configuration lives. Setting the MAC address
-of your ethernet card to an address starting with "hi-ord" will cause a
-DECnet address which matches to be added to the interface (which you can
-verify with iproute2).
-
-The default device for routing can be set through the /proc filesystem
-by setting /proc/sys/net/decnet/default_device to the
-device you want DECnet to route packets out of when no specific route
-is available. Usually this will be eth0, for example::
-
-    echo -n "eth0" >/proc/sys/net/decnet/default_device
-
-If you don't set the default device, then it will default to the first
-ethernet card which has been autoconfigured as described above. You can
-confirm that by looking in the default_device file of course.
-
-There is a list of what the other files under /proc/sys/net/decnet/ do
-on the kernel patch web site (shown above).
-
-4. Run time kernel configuration
-================================
-
-
-This is either done through the sysctl/proc interface (see the kernel web
-pages for details on what the various options do) or through the iproute2
-package in the same way as IPv4/6 configuration is performed.
-
-Documentation for iproute2 is included with the package, although there is
-as yet no specific section on DECnet, most of the features apply to both
-IP and DECnet, albeit with DECnet addresses instead of IP addresses and
-a reduced functionality.
-
-If you want to configure a DECnet router you'll need the iproute2 package
-since its the _only_ way to add and delete routes currently. Eventually
-there will be a routing daemon to send and receive routing messages for
-each interface and update the kernel routing tables accordingly. The
-routing daemon will use netfilter to listen to routing packets, and
-rtnetlink to update the kernels routing tables.
-
-The DECnet raw socket layer has been removed since it was there purely
-for use by the routing daemon which will now use netfilter (a much cleaner
-and more generic solution) instead.
-
-5. How can I tell if its working?
-=================================
-
-Here is a quick guide of what to look for in order to know if your DECnet
-kernel subsystem is working.
-
-   - Is the node address set (see /proc/sys/net/decnet/node_address)
-   - Is the node of the correct type
-     (see /proc/sys/net/decnet/conf/<dev>/forwarding)
-   - Is the Ethernet MAC address of each Ethernet card set to match
-     the DECnet address. If in doubt use the dn2ethaddr utility available
-     at the ftp archive.
-   - If the previous two steps are satisfied, and the Ethernet card is up,
-     you should find that it is listed in /proc/net/decnet_dev and also
-     that it appears as a directory in /proc/sys/net/decnet/conf/. The
-     loopback device (lo) should also appear and is required to communicate
-     within a node.
-   - If you have any DECnet routers on your network, they should appear
-     in /proc/net/decnet_neigh, otherwise this file will only contain the
-     entry for the node itself (if it doesn't check to see if lo is up).
-   - If you want to send to any node which is not listed in the
-     /proc/net/decnet_neigh file, you'll need to set the default device
-     to point to an Ethernet card with connection to a router. This is
-     again done with the /proc/sys/net/decnet/default_device file.
-   - Try starting a simple server and client, like the dnping/dnmirror
-     over the loopback interface. With luck they should communicate.
-     For this step and those after, you'll need the DECnet library
-     which can be obtained from the above ftp sites as well as the
-     actual utilities themselves.
-   - If this seems to work, then try talking to a node on your local
-     network, and see if you can obtain the same results.
-   - At this point you are on your own... :-)
-
-6. How to send a bug report
-===========================
-
-If you've found a bug and want to report it, then there are several things
-you can do to help me work out exactly what it is that is wrong. Useful
-information (_most_ of which _is_ _essential_) includes:
-
- - What kernel version are you running ?
- - What version of the patch are you running ?
- - How far though the above set of tests can you get ?
- - What is in the /proc/decnet* files and /proc/sys/net/decnet/* files ?
- - Which services are you running ?
- - Which client caused the problem ?
- - How much data was being transferred ?
- - Was the network congested ?
- - How can the problem be reproduced ?
- - Can you use tcpdump to get a trace ? (N.B. Most (all?) versions of
-   tcpdump don't understand how to dump DECnet properly, so including
-   the hex listing of the packet contents is _essential_, usually the -x flag.
-   You may also need to increase the length grabbed with the -s flag. The
-   -e flag also provides very useful information (ethernet MAC addresses))
-
-7. MAC FAQ
-==========
-
-A quick FAQ on ethernet MAC addresses to explain how Linux and DECnet
-interact and how to get the best performance from your hardware.
-
-Ethernet cards are designed to normally only pass received network frames
-to a host computer when they are addressed to it, or to the broadcast address.
-
-Linux has an interface which allows the setting of extra addresses for
-an ethernet card to listen to. If the ethernet card supports it, the
-filtering operation will be done in hardware, if not the extra unwanted packets
-received will be discarded by the host computer. In the latter case,
-significant processor time and bus bandwidth can be used up on a busy
-network (see the NAPI documentation for a longer explanation of these
-effects).
-
-DECnet makes use of this interface to allow running DECnet on an ethernet
-card which has already been configured using TCP/IP (presumably using the
-built in MAC address of the card, as usual) and/or to allow multiple DECnet
-addresses on each physical interface. If you do this, be aware that if your
-ethernet card doesn't support perfect hashing in its MAC address filter
-then your computer will be doing more work than required. Some cards
-will simply set themselves into promiscuous mode in order to receive
-packets from the DECnet specified addresses. So if you have one of these
-cards its better to set the MAC address of the card as described above
-to gain the best efficiency. Better still is to use a card which supports
-NAPI as well.
-
-
-8. Mailing list
-===============
-
-If you are keen to get involved in development, or want to ask questions
-about configuration, or even just report bugs, then there is a mailing
-list that you can join, details are at:
-
-http://sourceforge.net/mail/?group_id=4993
-
-9. Legal Info
-=============
-
-The Linux DECnet project team have placed their code under the GPL. The
-software is provided "as is" and without warranty express or implied.
-DECnet is a trademark of Compaq. This software is not a product of
-Compaq. We acknowledge the help of people at Compaq in providing extra
-documentation above and beyond what was previously publicly available.
-
-Steve Whitehouse <SteveW@ACM.org>
-
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 63ef386afd0a..9fab919ed530 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -46,7 +46,6 @@ Contents:
    cdc_mbim
    dccp
    dctcp
-   decnet
    dns_resolver
    driver
    eql
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 55a2d9b2ce33..a7373d4e3984 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -303,7 +303,6 @@ Code  Seq#    Include File                                           Comments
 0x89  00-06  arch/x86/include/asm/sockios.h
 0x89  0B-DF  linux/sockios.h
 0x89  E0-EF  linux/sockios.h                                         SIOCPROTOPRIVATE range
-0x89  E0-EF  linux/dn.h                                              PROTOPRIVATE range
 0x89  F0-FF  linux/sockios.h                                         SIOCDEVPRIVATE range
 0x8B  all    linux/wireless.h
 0x8C  00-3F                                                          WiNRADiO driver
diff --git a/MAINTAINERS b/MAINTAINERS
index 6c5efc4013ab..cdb5f1f22f4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4905,13 +4905,6 @@ F:	include/linux/tfrc.h
 F:	include/uapi/linux/dccp.h
 F:	net/dccp/
 
-DECnet NETWORK LAYER
-L:	linux-decnet-user@lists.sourceforge.net
-S:	Orphan
-W:	http://linux-decnet.sourceforge.net
-F:	Documentation/networking/decnet.rst
-F:	net/decnet/
-
 DECSTATION PLATFORM SUPPORT
 M:	"Maciej W. Rozycki" <macro@linux-mips.org>
 L:	linux-mips@vger.kernel.org
diff --git a/Makefile b/Makefile
index 3450b061e8d6..73e6cc1992c2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 184
+SUBLEVEL = 185
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
index 7aa64ae25779..6fc48016fe8e 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -132,6 +132,7 @@ L2: cache-controller@2c0f0000 {
 		reg = <0x2c0f0000 0x1000>;
 		interrupts = <0 84 4>;
 		cache-level = <2>;
+		cache-unified;
 	};
 
 	pmu {
diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 4ca2c28878e0..e9ee9ab90a0c 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -30,6 +30,7 @@
  *
  */
 
+#include <linux/dma-map-ops.h> /* for dma_default_coherent */
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -623,17 +624,18 @@ u32 au1xxx_dbdma_put_source(u32 chanid, dma_addr_t buf, int nbytes, u32 flags)
 		dp->dscr_cmd0 &= ~DSCR_CMD0_IE;
 
 	/*
-	 * There is an errata on the Au1200/Au1550 parts that could result
-	 * in "stale" data being DMA'ed. It has to do with the snoop logic on
-	 * the cache eviction buffer.  DMA_NONCOHERENT is on by default for
-	 * these parts. If it is fixed in the future, these dma_cache_inv will
-	 * just be nothing more than empty macros. See io.h.
+	 * There is an erratum on certain Au1200/Au1550 revisions that could
+	 * result in "stale" data being DMA'ed. It has to do with the snoop
+	 * logic on the cache eviction buffer.  dma_default_coherent is set
+	 * to false on these parts.
 	 */
-	dma_cache_wback_inv((unsigned long)buf, nbytes);
+	if (!dma_default_coherent)
+		dma_cache_wback_inv(KSEG0ADDR(buf), nbytes);
 	dp->dscr_cmd0 |= DSCR_CMD0_V;	/* Let it rip */
 	wmb(); /* drain writebuffer */
 	dma_cache_wback_inv((unsigned long)dp, sizeof(*dp));
 	ctp->chan_ptr->ddma_dbell = 0;
+	wmb(); /* force doorbell write out to dma engine */
 
 	/* Get next descriptor pointer. */
 	ctp->put_ptr = phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
@@ -685,17 +687,18 @@ u32 au1xxx_dbdma_put_dest(u32 chanid, dma_addr_t buf, int nbytes, u32 flags)
 			  dp->dscr_source1, dp->dscr_dest0, dp->dscr_dest1);
 #endif
 	/*
-	 * There is an errata on the Au1200/Au1550 parts that could result in
-	 * "stale" data being DMA'ed. It has to do with the snoop logic on the
-	 * cache eviction buffer.  DMA_NONCOHERENT is on by default for these
-	 * parts. If it is fixed in the future, these dma_cache_inv will just
-	 * be nothing more than empty macros. See io.h.
+	 * There is an erratum on certain Au1200/Au1550 revisions that could
+	 * result in "stale" data being DMA'ed. It has to do with the snoop
+	 * logic on the cache eviction buffer.  dma_default_coherent is set
+	 * to false on these parts.
 	 */
-	dma_cache_inv((unsigned long)buf, nbytes);
+	if (!dma_default_coherent)
+		dma_cache_inv(KSEG0ADDR(buf), nbytes);
 	dp->dscr_cmd0 |= DSCR_CMD0_V;	/* Let it rip */
 	wmb(); /* drain writebuffer */
 	dma_cache_wback_inv((unsigned long)dp, sizeof(*dp));
 	ctp->chan_ptr->ddma_dbell = 0;
+	wmb(); /* force doorbell write out to dma engine */
 
 	/* Get next descriptor pointer. */
 	ctp->put_ptr = phys_to_virt(DSCR_GET_NXTPTR(dp->dscr_nxtptr));
diff --git a/arch/mips/configs/decstation_64_defconfig b/arch/mips/configs/decstation_64_defconfig
index 85f1955b4b00..4a81297e21a7 100644
--- a/arch/mips/configs/decstation_64_defconfig
+++ b/arch/mips/configs/decstation_64_defconfig
@@ -53,8 +53,6 @@ CONFIG_IPV6_SUBTREES=y
 CONFIG_NETWORK_SECMARK=y
 CONFIG_IP_SCTP=m
 CONFIG_VLAN_8021Q=m
-CONFIG_DECNET=m
-CONFIG_DECNET_ROUTER=y
 # CONFIG_WIRELESS is not set
 # CONFIG_UEVENT_HELPER is not set
 # CONFIG_FW_LOADER is not set
diff --git a/arch/mips/configs/decstation_defconfig b/arch/mips/configs/decstation_defconfig
index 30a6eafdb1d0..fd35454bae4c 100644
--- a/arch/mips/configs/decstation_defconfig
+++ b/arch/mips/configs/decstation_defconfig
@@ -49,8 +49,6 @@ CONFIG_IPV6_SUBTREES=y
 CONFIG_NETWORK_SECMARK=y
 CONFIG_IP_SCTP=m
 CONFIG_VLAN_8021Q=m
-CONFIG_DECNET=m
-CONFIG_DECNET_ROUTER=y
 # CONFIG_WIRELESS is not set
 # CONFIG_UEVENT_HELPER is not set
 # CONFIG_FW_LOADER is not set
diff --git a/arch/mips/configs/decstation_r4k_defconfig b/arch/mips/configs/decstation_r4k_defconfig
index e2b58dbf4aa9..7ed8f4c7cbdd 100644
--- a/arch/mips/configs/decstation_r4k_defconfig
+++ b/arch/mips/configs/decstation_r4k_defconfig
@@ -48,8 +48,6 @@ CONFIG_IPV6_SUBTREES=y
 CONFIG_NETWORK_SECMARK=y
 CONFIG_IP_SCTP=m
 CONFIG_VLAN_8021Q=m
-CONFIG_DECNET=m
-CONFIG_DECNET_ROUTER=y
 # CONFIG_WIRELESS is not set
 # CONFIG_UEVENT_HELPER is not set
 # CONFIG_FW_LOADER is not set
diff --git a/arch/mips/configs/gpr_defconfig b/arch/mips/configs/gpr_defconfig
index 9085f4d6c698..5b9b59a8fe68 100644
--- a/arch/mips/configs/gpr_defconfig
+++ b/arch/mips/configs/gpr_defconfig
@@ -69,7 +69,6 @@ CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_DECNET_NF_GRABULATOR=m
 CONFIG_BRIDGE_NF_EBTABLES=m
 CONFIG_BRIDGE_EBT_BROUTE=m
 CONFIG_BRIDGE_EBT_T_FILTER=m
@@ -99,7 +98,6 @@ CONFIG_ATM_MPOA=m
 CONFIG_ATM_BR2684=m
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
-CONFIG_DECNET=m
 CONFIG_LLC2=m
 CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index 914af125a7fa..d6578536d77c 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -117,7 +117,6 @@ CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP6_NF_MANGLE=m
 CONFIG_IP6_NF_RAW=m
-CONFIG_DECNET_NF_GRABULATOR=m
 CONFIG_BRIDGE_NF_EBTABLES=m
 CONFIG_BRIDGE_EBT_BROUTE=m
 CONFIG_BRIDGE_EBT_T_FILTER=m
@@ -147,7 +146,6 @@ CONFIG_ATM_MPOA=m
 CONFIG_ATM_BR2684=m
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
-CONFIG_DECNET=m
 CONFIG_LLC2=m
 CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
index 72a211d2d556..45421a05bb0e 100644
--- a/arch/mips/configs/nlm_xlp_defconfig
+++ b/arch/mips/configs/nlm_xlp_defconfig
@@ -200,7 +200,6 @@ CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP6_NF_MANGLE=m
 CONFIG_IP6_NF_RAW=m
 CONFIG_IP6_NF_SECURITY=m
-CONFIG_DECNET_NF_GRABULATOR=m
 CONFIG_BRIDGE_NF_EBTABLES=m
 CONFIG_BRIDGE_EBT_BROUTE=m
 CONFIG_BRIDGE_EBT_T_FILTER=m
@@ -234,7 +233,6 @@ CONFIG_ATM_BR2684=m
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
-CONFIG_DECNET=m
 CONFIG_LLC2=m
 CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index 4ecb157e56d4..1081972c81da 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -198,7 +198,6 @@ CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP6_NF_MANGLE=m
 CONFIG_IP6_NF_RAW=m
 CONFIG_IP6_NF_SECURITY=m
-CONFIG_DECNET_NF_GRABULATOR=m
 CONFIG_BRIDGE_NF_EBTABLES=m
 CONFIG_BRIDGE_EBT_BROUTE=m
 CONFIG_BRIDGE_EBT_T_FILTER=m
@@ -232,7 +231,6 @@ CONFIG_ATM_BR2684=m
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
-CONFIG_DECNET=m
 CONFIG_LLC2=m
 CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index 30d7c3db884e..2d0506159dfa 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -116,7 +116,6 @@ CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP6_NF_MANGLE=m
 CONFIG_IP6_NF_RAW=m
-CONFIG_DECNET_NF_GRABULATOR=m
 CONFIG_BRIDGE_NF_EBTABLES=m
 CONFIG_BRIDGE_EBT_BROUTE=m
 CONFIG_BRIDGE_EBT_T_FILTER=m
@@ -137,7 +136,6 @@ CONFIG_BRIDGE_EBT_REDIRECT=m
 CONFIG_BRIDGE_EBT_SNAT=m
 CONFIG_BRIDGE_EBT_LOG=m
 CONFIG_BRIDGE=m
-CONFIG_DECNET=m
 CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_CBQ=m
 CONFIG_NET_SCH_HTB=m
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 9d11f68a9e8b..b49ad569e469 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -154,10 +154,6 @@ static unsigned long __init init_initrd(void)
 		pr_err("initrd start must be page aligned\n");
 		goto disable;
 	}
-	if (initrd_start < PAGE_OFFSET) {
-		pr_err("initrd start < PAGE_OFFSET\n");
-		goto disable;
-	}
 
 	/*
 	 * Sanitize initrd addresses. For example firmware
@@ -170,6 +166,11 @@ static unsigned long __init init_initrd(void)
 	initrd_end = (unsigned long)__va(end);
 	initrd_start = (unsigned long)__va(__pa(initrd_start));
 
+	if (initrd_start < PAGE_OFFSET) {
+		pr_err("initrd start < PAGE_OFFSET\n");
+		goto disable;
+	}
+
 	ROOT_DEV = Root_RAM0;
 	return PFN_UP(end);
 disable:
diff --git a/arch/nios2/boot/dts/10m50_devboard.dts b/arch/nios2/boot/dts/10m50_devboard.dts
index 56339bef3247..0e7e5b0dd685 100644
--- a/arch/nios2/boot/dts/10m50_devboard.dts
+++ b/arch/nios2/boot/dts/10m50_devboard.dts
@@ -97,7 +97,7 @@ rgmii_0_eth_tse_0: ethernet@400 {
 			rx-fifo-depth = <8192>;
 			tx-fifo-depth = <8192>;
 			address-bits = <48>;
-			max-frame-size = <1518>;
+			max-frame-size = <1500>;
 			local-mac-address = [00 00 00 00 00 00];
 			altr,has-supplementary-unicast;
 			altr,enable-sup-addr = <1>;
diff --git a/arch/nios2/boot/dts/3c120_devboard.dts b/arch/nios2/boot/dts/3c120_devboard.dts
index d10fb81686c7..3ee316906379 100644
--- a/arch/nios2/boot/dts/3c120_devboard.dts
+++ b/arch/nios2/boot/dts/3c120_devboard.dts
@@ -106,7 +106,7 @@ tse_mac: ethernet@4000 {
 				interrupt-names = "rx_irq", "tx_irq";
 				rx-fifo-depth = <8192>;
 				tx-fifo-depth = <8192>;
-				max-frame-size = <1518>;
+				max-frame-size = <1500>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
 				phy-mode = "rgmii-id";
 				phy-handle = <&phy0>;
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index 36610a5c029f..fc90ccfee157 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -446,11 +446,27 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
+	/*
+	 * fdc: The data cache line is written back to memory, if and only if
+	 * it is dirty, and then invalidated from the data cache.
+	 */
 	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
 }
 
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
+	unsigned long addr = (unsigned long) phys_to_virt(paddr);
+
+	switch (dir) {
+	case DMA_TO_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		flush_kernel_dcache_range(addr, size);
+		return;
+	case DMA_FROM_DEVICE:
+		purge_kernel_dcache_range_asm(addr, addr + size);
+		return;
+	default:
+		BUG();
+	}
 }
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 66e9a0fd64ff..021da6736570 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -245,8 +245,6 @@ CONFIG_ATM_LANE=m
 CONFIG_ATM_BR2684=m
 CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
-CONFIG_DECNET=m
-CONFIG_DECNET_ROUTER=y
 CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
 CONFIG_IPDDP=m
diff --git a/arch/powerpc/purgatory/Makefile b/arch/powerpc/purgatory/Makefile
index 348f59581052..d08239ae2bcd 100644
--- a/arch/powerpc/purgatory/Makefile
+++ b/arch/powerpc/purgatory/Makefile
@@ -4,6 +4,11 @@ KASAN_SANITIZE := n
 
 targets += trampoline_$(BITS).o purgatory.ro kexec-purgatory.c
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined
 
 $(obj)/purgatory.ro: $(obj)/trampoline_$(BITS).o FORCE
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 00c6dce14bd2..55930ca498e9 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -387,12 +387,12 @@ void text_poke_sync(void)
 {
 }
 
-#ifdef CONFIG_PM_SLEEP
 void uml_pm_wake(void)
 {
 	pm_system_wakeup();
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int init_pm_wake_signal(void)
 {
 	/*
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index ebaf329a2368..dc0b91c1db04 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -14,6 +14,11 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -nostdlib -z nodefaultlib
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 6f33d62331b1..d68a8ca2161f 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -792,7 +792,8 @@ static int blkif_queue_rw_req(struct request *req, struct blkfront_ring_info *ri
 		ring_req->u.rw.handle = info->handle;
 		ring_req->operation = rq_data_dir(req) ?
 			BLKIF_OP_WRITE : BLKIF_OP_READ;
-		if (req_op(req) == REQ_OP_FLUSH || req->cmd_flags & REQ_FUA) {
+		if (req_op(req) == REQ_OP_FLUSH ||
+		    (req_op(req) == REQ_OP_WRITE && (req->cmd_flags & REQ_FUA))) {
 			/*
 			 * Ideally we can do an unordered flush-to-disk.
 			 * In case the backend onlysupports barriers, use that.
diff --git a/drivers/char/agp/parisc-agp.c b/drivers/char/agp/parisc-agp.c
index d68d05d5d383..514f9f287a78 100644
--- a/drivers/char/agp/parisc-agp.c
+++ b/drivers/char/agp/parisc-agp.c
@@ -90,6 +90,9 @@ parisc_agp_tlbflush(struct agp_memory *mem)
 {
 	struct _parisc_agp_info *info = &parisc_agp_info;
 
+	/* force fdc ops to be visible to IOMMU */
+	asm_io_sync();
+
 	writeq(info->gart_base | ilog2(info->gart_size), info->ioc_regs+IOC_PCOM);
 	readq(info->ioc_regs+IOC_PCOM);	/* flush */
 }
@@ -158,6 +161,7 @@ parisc_agp_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
 			info->gatt[j] =
 				parisc_agp_mask_memory(agp_bridge,
 					paddr, type);
+			asm_io_fdc(&info->gatt[j]);
 		}
 	}
 
@@ -191,7 +195,16 @@ static unsigned long
 parisc_agp_mask_memory(struct agp_bridge_data *bridge, dma_addr_t addr,
 		       int type)
 {
-	return SBA_PDIR_VALID_BIT | addr;
+	unsigned ci;			/* coherent index */
+	dma_addr_t pa;
+
+	pa = addr & IOVP_MASK;
+	asm("lci 0(%1), %0" : "=r" (ci) : "r" (phys_to_virt(pa)));
+
+	pa |= (ci >> PAGE_SHIFT) & 0xff;/* move CI (8 bits) into lowest byte */
+	pa |= SBA_PDIR_VALID_BIT;	/* set "valid" bit */
+
+	return cpu_to_le64(pa);
 }
 
 static void
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 0e3ff5c3766e..72410a2d4e6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6702,8 +6702,10 @@ static int gfx_v10_0_kiq_resume(struct amdgpu_device *adev)
 		return r;
 
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (unlikely(r != 0))
+	if (unlikely(r != 0)) {
+		amdgpu_bo_unreserve(ring->mqd_obj);
 		return r;
+	}
 
 	gfx_v10_0_kiq_init_queue(ring);
 	amdgpu_bo_kunmap(ring->mqd_obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 629671f66b31..acef2227d992 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3800,8 +3800,10 @@ static int gfx_v9_0_kiq_resume(struct amdgpu_device *adev)
 		return r;
 
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (unlikely(r != 0))
+	if (unlikely(r != 0)) {
+		amdgpu_bo_unreserve(ring->mqd_obj);
 		return r;
+	}
 
 	gfx_v9_0_kiq_init_queue(ring);
 	amdgpu_bo_kunmap(ring->mqd_obj);
diff --git a/drivers/gpu/drm/i915/display/intel_bw.c b/drivers/gpu/drm/i915/display/intel_bw.c
index bd060404d249..4b5a30ac84bc 100644
--- a/drivers/gpu/drm/i915/display/intel_bw.c
+++ b/drivers/gpu/drm/i915/display/intel_bw.c
@@ -20,76 +20,9 @@ struct intel_qgv_point {
 struct intel_qgv_info {
 	struct intel_qgv_point points[I915_NUM_QGV_POINTS];
 	u8 num_points;
-	u8 num_channels;
 	u8 t_bl;
-	enum intel_dram_type dram_type;
 };
 
-static int icl_pcode_read_mem_global_info(struct drm_i915_private *dev_priv,
-					  struct intel_qgv_info *qi)
-{
-	u32 val = 0;
-	int ret;
-
-	ret = sandybridge_pcode_read(dev_priv,
-				     ICL_PCODE_MEM_SUBSYSYSTEM_INFO |
-				     ICL_PCODE_MEM_SS_READ_GLOBAL_INFO,
-				     &val, NULL);
-	if (ret)
-		return ret;
-
-	if (IS_GEN(dev_priv, 12)) {
-		switch (val & 0xf) {
-		case 0:
-			qi->dram_type = INTEL_DRAM_DDR4;
-			break;
-		case 3:
-			qi->dram_type = INTEL_DRAM_LPDDR4;
-			break;
-		case 4:
-			qi->dram_type = INTEL_DRAM_DDR3;
-			break;
-		case 5:
-			qi->dram_type = INTEL_DRAM_LPDDR3;
-			break;
-		default:
-			MISSING_CASE(val & 0xf);
-			break;
-		}
-	} else if (IS_GEN(dev_priv, 11)) {
-		switch (val & 0xf) {
-		case 0:
-			qi->dram_type = INTEL_DRAM_DDR4;
-			break;
-		case 1:
-			qi->dram_type = INTEL_DRAM_DDR3;
-			break;
-		case 2:
-			qi->dram_type = INTEL_DRAM_LPDDR3;
-			break;
-		case 3:
-			qi->dram_type = INTEL_DRAM_LPDDR4;
-			break;
-		default:
-			MISSING_CASE(val & 0xf);
-			break;
-		}
-	} else {
-		MISSING_CASE(INTEL_GEN(dev_priv));
-		qi->dram_type = INTEL_DRAM_LPDDR3; /* Conservative default */
-	}
-
-	qi->num_channels = (val & 0xf0) >> 4;
-	qi->num_points = (val & 0xf00) >> 8;
-
-	if (IS_GEN(dev_priv, 12))
-		qi->t_bl = qi->dram_type == INTEL_DRAM_DDR4 ? 4 : 16;
-	else if (IS_GEN(dev_priv, 11))
-		qi->t_bl = qi->dram_type == INTEL_DRAM_DDR4 ? 4 : 8;
-
-	return 0;
-}
-
 static int icl_pcode_read_qgv_point_info(struct drm_i915_private *dev_priv,
 					 struct intel_qgv_point *sp,
 					 int point)
@@ -139,11 +72,15 @@ int icl_pcode_restrict_qgv_points(struct drm_i915_private *dev_priv,
 static int icl_get_qgv_points(struct drm_i915_private *dev_priv,
 			      struct intel_qgv_info *qi)
 {
+	const struct dram_info *dram_info = &dev_priv->dram_info;
 	int i, ret;
 
-	ret = icl_pcode_read_mem_global_info(dev_priv, qi);
-	if (ret)
-		return ret;
+	qi->num_points = dram_info->num_qgv_points;
+
+	if (IS_GEN(dev_priv, 12))
+		qi->t_bl = dev_priv->dram_info.type == INTEL_DRAM_DDR4 ? 4 : 16;
+	else if (IS_GEN(dev_priv, 11))
+		qi->t_bl = dev_priv->dram_info.type == INTEL_DRAM_DDR4 ? 4 : 8;
 
 	if (drm_WARN_ON(&dev_priv->drm,
 			qi->num_points > ARRAY_SIZE(qi->points)))
@@ -209,7 +146,7 @@ static int icl_get_bw_info(struct drm_i915_private *dev_priv, const struct intel
 {
 	struct intel_qgv_info qi = {};
 	bool is_y_tile = true; /* assume y tile may be used */
-	int num_channels;
+	int num_channels = dev_priv->dram_info.num_channels;
 	int deinterleave;
 	int ipqdepth, ipqdepthpch;
 	int dclk_max;
@@ -222,7 +159,6 @@ static int icl_get_bw_info(struct drm_i915_private *dev_priv, const struct intel
 			    "Failed to get memory subsystem information, ignoring bandwidth limits");
 		return ret;
 	}
-	num_channels = qi.num_channels;
 
 	deinterleave = DIV_ROUND_UP(num_channels, is_y_tile ? 4 : 2);
 	dclk_max = icl_sagv_max_dclk(&qi);
diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 382cf048eefe..c72a26af181c 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -84,6 +84,7 @@
 #include "intel_gvt.h"
 #include "intel_memory_region.h"
 #include "intel_pm.h"
+#include "intel_sideband.h"
 #include "vlv_suspend.h"
 
 static struct drm_driver driver;
@@ -608,6 +609,9 @@ static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 		goto err_msi;
 
 	intel_opregion_setup(dev_priv);
+
+	intel_pcode_init(dev_priv);
+
 	/*
 	 * Fill the dram structure to get the system raw bandwidth and
 	 * dram info. This will be used for memory latency calculation.
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 6909901b3551..a8b65bab82c8 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1148,6 +1148,7 @@ struct drm_i915_private {
 			INTEL_DRAM_LPDDR3,
 			INTEL_DRAM_LPDDR4
 		} type;
+		u8 num_qgv_points;
 	} dram_info;
 
 	struct intel_bw_info {
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 04157d8ced32..728a46489f9c 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -9235,6 +9235,9 @@ enum {
 #define     GEN9_SAGV_DISABLE			0x0
 #define     GEN9_SAGV_IS_DISABLED		0x1
 #define     GEN9_SAGV_ENABLE			0x3
+#define   DG1_PCODE_STATUS			0x7E
+#define     DG1_UNCORE_GET_INIT_STATUS		0x0
+#define     DG1_UNCORE_INIT_STATUS_COMPLETE	0x1
 #define GEN12_PCODE_READ_SAGV_BLOCK_TIME_US	0x23
 #define GEN6_PCODE_DATA				_MMIO(0x138128)
 #define   GEN6_PCODE_FREQ_IA_RATIO_SHIFT	8
diff --git a/drivers/gpu/drm/i915/intel_dram.c b/drivers/gpu/drm/i915/intel_dram.c
index 8aa12cad93ce..26e109c64984 100644
--- a/drivers/gpu/drm/i915/intel_dram.c
+++ b/drivers/gpu/drm/i915/intel_dram.c
@@ -5,6 +5,7 @@
 
 #include "i915_drv.h"
 #include "intel_dram.h"
+#include "intel_sideband.h"
 
 struct dram_dimm_info {
 	u8 size, width, ranks;
@@ -433,6 +434,81 @@ static int bxt_get_dram_info(struct drm_i915_private *i915)
 	return 0;
 }
 
+static int icl_pcode_read_mem_global_info(struct drm_i915_private *dev_priv)
+{
+	struct dram_info *dram_info = &dev_priv->dram_info;
+	u32 val = 0;
+	int ret;
+
+	ret = sandybridge_pcode_read(dev_priv,
+				     ICL_PCODE_MEM_SUBSYSYSTEM_INFO |
+				     ICL_PCODE_MEM_SS_READ_GLOBAL_INFO,
+				     &val, NULL);
+	if (ret)
+		return ret;
+
+	if (IS_GEN(dev_priv, 12)) {
+		switch (val & 0xf) {
+		case 0:
+			dram_info->type = INTEL_DRAM_DDR4;
+			break;
+		case 3:
+			dram_info->type = INTEL_DRAM_LPDDR4;
+			break;
+		case 4:
+			dram_info->type = INTEL_DRAM_DDR3;
+			break;
+		case 5:
+			dram_info->type = INTEL_DRAM_LPDDR3;
+			break;
+		default:
+			MISSING_CASE(val & 0xf);
+			return -1;
+		}
+	} else {
+		switch (val & 0xf) {
+		case 0:
+			dram_info->type = INTEL_DRAM_DDR4;
+			break;
+		case 1:
+			dram_info->type = INTEL_DRAM_DDR3;
+			break;
+		case 2:
+			dram_info->type = INTEL_DRAM_LPDDR3;
+			break;
+		case 3:
+			dram_info->type = INTEL_DRAM_LPDDR4;
+			break;
+		default:
+			MISSING_CASE(val & 0xf);
+			return -1;
+		}
+	}
+
+	dram_info->num_channels = (val & 0xf0) >> 4;
+	dram_info->num_qgv_points = (val & 0xf00) >> 8;
+
+	return 0;
+}
+
+static int gen11_get_dram_info(struct drm_i915_private *i915)
+{
+	int ret = skl_get_dram_info(i915);
+
+	if (ret)
+		return ret;
+
+	return icl_pcode_read_mem_global_info(i915);
+}
+
+static int gen12_get_dram_info(struct drm_i915_private *i915)
+{
+	/* Always needed for GEN12+ */
+	i915->dram_info.is_16gb_dimm = true;
+
+	return icl_pcode_read_mem_global_info(i915);
+}
+
 void intel_dram_detect(struct drm_i915_private *i915)
 {
 	struct dram_info *dram_info = &i915->dram_info;
@@ -448,7 +524,11 @@ void intel_dram_detect(struct drm_i915_private *i915)
 	if (INTEL_GEN(i915) < 9 || !HAS_DISPLAY(i915))
 		return;
 
-	if (IS_GEN9_LP(i915))
+	if (INTEL_GEN(i915) >= 12)
+		ret = gen12_get_dram_info(i915);
+	else if (INTEL_GEN(i915) >= 11)
+		ret = gen11_get_dram_info(i915);
+	else if (IS_GEN9_LP(i915))
 		ret = bxt_get_dram_info(i915);
 	else
 		ret = skl_get_dram_info(i915);
diff --git a/drivers/gpu/drm/i915/intel_sideband.c b/drivers/gpu/drm/i915/intel_sideband.c
index 5b3279262123..02ebf5a04a9b 100644
--- a/drivers/gpu/drm/i915/intel_sideband.c
+++ b/drivers/gpu/drm/i915/intel_sideband.c
@@ -555,3 +555,18 @@ int skl_pcode_request(struct drm_i915_private *i915, u32 mbox, u32 request,
 	return ret ? ret : status;
 #undef COND
 }
+
+void intel_pcode_init(struct drm_i915_private *i915)
+{
+	int ret;
+
+	if (!IS_DGFX(i915))
+		return;
+
+	ret = skl_pcode_request(i915, DG1_PCODE_STATUS,
+				DG1_UNCORE_GET_INIT_STATUS,
+				DG1_UNCORE_INIT_STATUS_COMPLETE,
+				DG1_UNCORE_INIT_STATUS_COMPLETE, 50);
+	if (ret)
+		drm_err(&i915->drm, "Pcode did not report uncore initialization completion!\n");
+}
diff --git a/drivers/gpu/drm/i915/intel_sideband.h b/drivers/gpu/drm/i915/intel_sideband.h
index 7fb95745a444..094c7b19c5d4 100644
--- a/drivers/gpu/drm/i915/intel_sideband.h
+++ b/drivers/gpu/drm/i915/intel_sideband.h
@@ -138,4 +138,6 @@ int sandybridge_pcode_write_timeout(struct drm_i915_private *i915, u32 mbox,
 int skl_pcode_request(struct drm_i915_private *i915, u32 mbox, u32 request,
 		      u32 reply_mask, u32 reply, int timeout_base_ms);
 
+void intel_pcode_init(struct drm_i915_private *i915);
+
 #endif /* _INTEL_SIDEBAND_H */
diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index 69a84d0197d0..7b946d44ab2c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -220,6 +220,9 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out
 	int optimus_funcs;
 	struct pci_dev *parent_pdev;
 
+	if (pdev->vendor != PCI_VENDOR_ID_NVIDIA)
+		return;
+
 	*has_pr3 = false;
 	parent_pdev = pci_upstream_bridge(pdev);
 	if (parent_pdev) {
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 9542fc63e796..b8884272d65e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -726,7 +726,8 @@ nouveau_connector_detect_lvds(struct drm_connector *connector, bool force)
 #endif
 
 	nouveau_connector_set_edid(nv_connector, edid);
-	nouveau_connector_set_encoder(connector, nv_encoder);
+	if (nv_encoder)
+		nouveau_connector_set_encoder(connector, nv_encoder);
 	return status;
 }
 
@@ -946,7 +947,7 @@ nouveau_connector_get_modes(struct drm_connector *connector)
 	/* Determine display colour depth for everything except LVDS now,
 	 * DP requires this before mode_valid() is called.
 	 */
-	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS)
+	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS && nv_connector->native_mode)
 		nouveau_connector_detect_depth(connector);
 
 	/* Find the native mode if this is a digital panel, if we didn't
@@ -967,7 +968,7 @@ nouveau_connector_get_modes(struct drm_connector *connector)
 	 * "native" mode as some VBIOS tables require us to use the
 	 * pixel clock as part of the lookup...
 	 */
-	if (connector->connector_type == DRM_MODE_CONNECTOR_LVDS)
+	if (connector->connector_type == DRM_MODE_CONNECTOR_LVDS && nv_connector->native_mode)
 		nouveau_connector_detect_depth(connector);
 
 	if (nv_encoder->dcb->type == DCB_OUTPUT_TV)
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index ac96b6ab44c0..8e15ff95b809 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -124,10 +124,16 @@ nouveau_name(struct drm_device *dev)
 static inline bool
 nouveau_cli_work_ready(struct dma_fence *fence)
 {
-	if (!dma_fence_is_signaled(fence))
-		return false;
-	dma_fence_put(fence);
-	return true;
+	bool ret = true;
+
+	spin_lock_irq(fence->lock);
+	if (!dma_fence_is_signaled_locked(fence))
+		ret = false;
+	spin_unlock_irq(fence->lock);
+
+	if (ret == true)
+		dma_fence_put(fence);
+	return ret;
 }
 
 static void
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index fdcad8d6a5a0..db24f7dfa00f 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3069,7 +3069,7 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 	route->path_rec->traffic_class = tos;
 	route->path_rec->mtu = iboe_get_mtu(ndev->mtu);
 	route->path_rec->rate_selector = IB_SA_EQ;
-	route->path_rec->rate = iboe_get_rate(ndev);
+	route->path_rec->rate = IB_RATE_PORT_CURRENT;
 	dev_put(ndev);
 	route->path_rec->packet_life_time_selector = IB_SA_EQ;
 	/* In case ACK timeout is set, use this value to calculate
@@ -4719,7 +4719,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 	if (!ndev)
 		return -ENODEV;
 
-	ib.rec.rate = iboe_get_rate(ndev);
+	ib.rec.rate = IB_RATE_PORT_CURRENT;
 	ib.rec.hop_limit = 1;
 	ib.rec.mtu = iboe_get_mtu(ndev->mtu);
 
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index d7c90da9ce7f..09cf470c08d6 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1842,8 +1842,13 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 		attr->path_mtu = cmd->base.path_mtu;
 	if (cmd->base.attr_mask & IB_QP_PATH_MIG_STATE)
 		attr->path_mig_state = cmd->base.path_mig_state;
-	if (cmd->base.attr_mask & IB_QP_QKEY)
+	if (cmd->base.attr_mask & IB_QP_QKEY) {
+		if (cmd->base.qkey & IB_QP_SET_QKEY && !capable(CAP_NET_RAW)) {
+			ret = -EPERM;
+			goto release_qp;
+		}
 		attr->qkey = cmd->base.qkey;
+	}
 	if (cmd->base.attr_mask & IB_QP_RQ_PSN)
 		attr->rq_psn = cmd->base.rq_psn;
 	if (cmd->base.attr_mask & IB_QP_SQ_PSN)
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 4bb7c642f80c..099f5acc749e 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -222,8 +222,12 @@ static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue *ev_queue,
 	spin_lock_irq(&ev_queue->lock);
 
 	while (list_empty(&ev_queue->event_list)) {
-		spin_unlock_irq(&ev_queue->lock);
+		if (ev_queue->is_closed) {
+			spin_unlock_irq(&ev_queue->lock);
+			return -EIO;
+		}
 
+		spin_unlock_irq(&ev_queue->lock);
 		if (filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
@@ -233,12 +237,6 @@ static ssize_t ib_uverbs_event_read(struct ib_uverbs_event_queue *ev_queue,
 			return -ERESTARTSYS;
 
 		spin_lock_irq(&ev_queue->lock);
-
-		/* If device was disassociated and no event exists set an error */
-		if (list_empty(&ev_queue->event_list) && ev_queue->is_closed) {
-			spin_unlock_irq(&ev_queue->lock);
-			return -EIO;
-		}
 	}
 
 	event = list_entry(ev_queue->event_list.next, struct ib_uverbs_event, list);
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 5ef37902e96b..39ba7005f2c4 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4746,6 +4746,9 @@ const struct mlx5_ib_profile raw_eth_profile = {
 	STAGE_CREATE(MLX5_IB_STAGE_POST_IB_REG_UMR,
 		     mlx5_ib_stage_post_ib_reg_umr_init,
 		     NULL),
+	STAGE_CREATE(MLX5_IB_STAGE_DELAY_DROP,
+		     mlx5_ib_stage_delay_drop_init,
+		     mlx5_ib_stage_delay_drop_cleanup),
 	STAGE_CREATE(MLX5_IB_STAGE_RESTRACK,
 		     mlx5_ib_restrack_init,
 		     NULL),
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 99c1b3553e6e..4c938d841f76 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -192,6 +192,9 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 	spin_lock_init(&qp->rq.producer_lock);
 	spin_lock_init(&qp->rq.consumer_lock);
 
+	skb_queue_head_init(&qp->req_pkts);
+	skb_queue_head_init(&qp->resp_pkts);
+
 	atomic_set(&qp->ssn, 0);
 	atomic_set(&qp->skb_out, 0);
 }
@@ -247,12 +250,8 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	qp->req.opcode		= -1;
 	qp->comp.opcode		= -1;
 
-	skb_queue_head_init(&qp->req_pkts);
-
-	rxe_init_task(rxe, &qp->req.task, qp,
-		      rxe_requester, "req");
-	rxe_init_task(rxe, &qp->comp.task, qp,
-		      rxe_completer, "comp");
+	rxe_init_task(&qp->req.task, qp, rxe_requester);
+	rxe_init_task(&qp->comp.task, qp, rxe_completer);
 
 	qp->qp_timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
 	if (init->qp_type == IB_QPT_RC) {
@@ -296,10 +295,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 		}
 	}
 
-	skb_queue_head_init(&qp->resp_pkts);
-
-	rxe_init_task(rxe, &qp->resp.task, qp,
-		      rxe_responder, "resp");
+	rxe_init_task(&qp->resp.task, qp, rxe_responder);
 
 	qp->resp.opcode		= OPCODE_NONE;
 	qp->resp.msn		= 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 568cf56c236b..5aa69947a979 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -95,13 +95,10 @@ void rxe_do_task(struct tasklet_struct *t)
 	task->ret = ret;
 }
 
-int rxe_init_task(void *obj, struct rxe_task *task,
-		  void *arg, int (*func)(void *), char *name)
+int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *))
 {
-	task->obj	= obj;
 	task->arg	= arg;
 	task->func	= func;
-	snprintf(task->name, sizeof(task->name), "%s", name);
 	task->destroyed	= false;
 
 	tasklet_setup(&task->tasklet, rxe_do_task);
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 11d183fd3338..b3dfd970d1dc 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -19,14 +19,12 @@ enum {
  * called again.
  */
 struct rxe_task {
-	void			*obj;
 	struct tasklet_struct	tasklet;
 	int			state;
 	spinlock_t		state_lock; /* spinlock for task state */
 	void			*arg;
 	int			(*func)(void *arg);
 	int			ret;
-	char			name[16];
 	bool			destroyed;
 };
 
@@ -35,8 +33,7 @@ struct rxe_task {
  *	arg  => parameter to pass to fcn
  *	func => function to call until it returns != 0
  */
-int rxe_init_task(void *obj, struct rxe_task *task,
-		  void *arg, int (*func)(void *), char *name);
+int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *));
 
 /* cleanup task */
 void rxe_cleanup_task(struct rxe_task *task);
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 2d0d966fba2c..7cd90604502e 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -656,9 +656,13 @@ static int
 isert_connect_error(struct rdma_cm_id *cma_id)
 {
 	struct isert_conn *isert_conn = cma_id->qp->qp_context;
+	struct isert_np *isert_np = cma_id->context;
 
 	ib_drain_qp(isert_conn->qp);
+
+	mutex_lock(&isert_np->mutex);
 	list_del_init(&isert_conn->node);
+	mutex_unlock(&isert_np->mutex);
 	isert_conn->cm_id = NULL;
 	isert_put_conn(isert_conn);
 
@@ -2421,6 +2425,7 @@ isert_free_np(struct iscsi_np *np)
 {
 	struct isert_np *isert_np = np->np_context;
 	struct isert_conn *isert_conn, *n;
+	LIST_HEAD(drop_conn_list);
 
 	if (isert_np->cm_id)
 		rdma_destroy_id(isert_np->cm_id);
@@ -2440,7 +2445,7 @@ isert_free_np(struct iscsi_np *np)
 					 node) {
 			isert_info("cleaning isert_conn %p state (%d)\n",
 				   isert_conn, isert_conn->state);
-			isert_connect_release(isert_conn);
+			list_move_tail(&isert_conn->node, &drop_conn_list);
 		}
 	}
 
@@ -2451,11 +2456,16 @@ isert_free_np(struct iscsi_np *np)
 					 node) {
 			isert_info("cleaning isert_conn %p state (%d)\n",
 				   isert_conn, isert_conn->state);
-			isert_connect_release(isert_conn);
+			list_move_tail(&isert_conn->node, &drop_conn_list);
 		}
 	}
 	mutex_unlock(&isert_np->mutex);
 
+	list_for_each_entry_safe(isert_conn, n, &drop_conn_list, node) {
+		list_del_init(&isert_conn->node);
+		isert_connect_release(isert_conn);
+	}
+
 	np->np_context = NULL;
 	kfree(isert_np);
 }
@@ -2550,8 +2560,6 @@ static void isert_wait_conn(struct iscsi_conn *conn)
 	isert_put_unsol_pending_cmds(conn);
 	isert_wait4cmds(conn);
 	isert_wait4logout(isert_conn);
-
-	queue_work(isert_release_wq, &isert_conn->release_work);
 }
 
 static void isert_free_conn(struct iscsi_conn *conn)
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 4629bb758126..76b993e8d672 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -37,8 +37,10 @@ struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t gfp_mask,
 			goto err;
 
 		iu->dma_addr = ib_dma_map_single(dma_dev, iu->buf, size, dir);
-		if (ib_dma_mapping_error(dma_dev, iu->dma_addr))
+		if (ib_dma_mapping_error(dma_dev, iu->dma_addr)) {
+			kfree(iu->buf);
 			goto err;
+		}
 
 		iu->cqe.done  = done;
 		iu->size      = size;
diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index f47b41dfd023..b8a10f2e72da 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -29,7 +29,13 @@ void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data)
 {
 	for (; quirks->desc; quirks++) {
-		if (!of_device_is_compatible(np, quirks->compatible))
+		if (!quirks->compatible && !quirks->property)
+			continue;
+		if (quirks->compatible &&
+		    !of_device_is_compatible(np, quirks->compatible))
+			continue;
+		if (quirks->property &&
+		    !of_property_read_bool(np, quirks->property))
 			continue;
 		if (quirks->init(data))
 			pr_info("GIC: enabling workaround for %s\n",
@@ -41,7 +47,7 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data)
 {
 	for (; quirks->desc; quirks++) {
-		if (quirks->compatible)
+		if (quirks->compatible || quirks->property)
 			continue;
 		if (quirks->iidr != (quirks->mask & iidr))
 			continue;
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index ccba8b0fe0f5..b42572d88f9f 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -13,6 +13,7 @@
 struct gic_quirk {
 	const char *desc;
 	const char *compatible;
+	const char *property;
 	bool (*init)(void *data);
 	u32 iidr;
 	u32 mask;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 2805969e4f15..c1f8c1be8485 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -35,6 +35,7 @@
 
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
+#define FLAGS_WORKAROUND_MTK_GICR_SAVE		(1ULL << 2)
 
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
 
@@ -1587,6 +1588,15 @@ static bool gic_enable_quirk_msm8996(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_mtk_gicr(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	d->flags |= FLAGS_WORKAROUND_MTK_GICR_SAVE;
+
+	return true;
+}
+
 static bool gic_enable_quirk_cavium_38539(void *data)
 {
 	struct gic_chip_data *d = data;
@@ -1622,6 +1632,11 @@ static const struct gic_quirk gic_quirks[] = {
 		.compatible = "qcom,msm8996-gic-v3",
 		.init	= gic_enable_quirk_msm8996,
 	},
+	{
+		.desc	= "GICv3: Mediatek Chromebook GICR save problem",
+		.property = "mediatek,broken-save-restore-fw",
+		.init	= gic_enable_quirk_mtk_gicr,
+	},
 	{
 		.desc	= "GICv3: HIP06 erratum 161010803",
 		.iidr	= 0x0204043b,
@@ -1658,6 +1673,11 @@ static void gic_enable_nmi_support(void)
 	if (!gic_prio_masking_enabled())
 		return;
 
+	if (gic_data.flags & FLAGS_WORKAROUND_MTK_GICR_SAVE) {
+		pr_warn("Skipping NMI enable due to firmware issues\n");
+		return;
+	}
+
 	ppi_nmi_refs = kcalloc(gic_data.ppi_nr, sizeof(*ppi_nmi_refs), GFP_KERNEL);
 	if (!ppi_nmi_refs)
 		return;
diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index fea2d82300b0..2ff8a1b776fb 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -37,6 +37,7 @@
 #include <media/tuner.h>
 
 static DEFINE_MUTEX(dvbdev_mutex);
+static LIST_HEAD(dvbdevfops_list);
 static int dvbdev_debug;
 
 module_param(dvbdev_debug, int, 0644);
@@ -462,14 +463,15 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 			enum dvb_device_type type, int demux_sink_pads)
 {
 	struct dvb_device *dvbdev;
-	struct file_operations *dvbdevfops;
+	struct file_operations *dvbdevfops = NULL;
+	struct dvbdevfops_node *node = NULL, *new_node = NULL;
 	struct device *clsdev;
 	int minor;
 	int id, ret;
 
 	mutex_lock(&dvbdev_register_lock);
 
-	if ((id = dvbdev_get_free_id (adap, type)) < 0){
+	if ((id = dvbdev_get_free_id (adap, type)) < 0) {
 		mutex_unlock(&dvbdev_register_lock);
 		*pdvbdev = NULL;
 		pr_err("%s: couldn't find free device id\n", __func__);
@@ -477,18 +479,45 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	}
 
 	*pdvbdev = dvbdev = kzalloc(sizeof(*dvbdev), GFP_KERNEL);
-
 	if (!dvbdev){
 		mutex_unlock(&dvbdev_register_lock);
 		return -ENOMEM;
 	}
 
-	dvbdevfops = kmemdup(template->fops, sizeof(*dvbdevfops), GFP_KERNEL);
+	/*
+	 * When a device of the same type is probe()d more than once,
+	 * the first allocated fops are used. This prevents memory leaks
+	 * that can occur when the same device is probe()d repeatedly.
+	 */
+	list_for_each_entry(node, &dvbdevfops_list, list_head) {
+		if (node->fops->owner == adap->module &&
+				node->type == type &&
+				node->template == template) {
+			dvbdevfops = node->fops;
+			break;
+		}
+	}
 
-	if (!dvbdevfops){
-		kfree (dvbdev);
-		mutex_unlock(&dvbdev_register_lock);
-		return -ENOMEM;
+	if (dvbdevfops == NULL) {
+		dvbdevfops = kmemdup(template->fops, sizeof(*dvbdevfops), GFP_KERNEL);
+		if (!dvbdevfops) {
+			kfree(dvbdev);
+			mutex_unlock(&dvbdev_register_lock);
+			return -ENOMEM;
+		}
+
+		new_node = kzalloc(sizeof(struct dvbdevfops_node), GFP_KERNEL);
+		if (!new_node) {
+			kfree(dvbdevfops);
+			kfree(dvbdev);
+			mutex_unlock(&dvbdev_register_lock);
+			return -ENOMEM;
+		}
+
+		new_node->fops = dvbdevfops;
+		new_node->type = type;
+		new_node->template = template;
+		list_add_tail (&new_node->list_head, &dvbdevfops_list);
 	}
 
 	memcpy(dvbdev, template, sizeof(struct dvb_device));
@@ -499,19 +528,20 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	dvbdev->priv = priv;
 	dvbdev->fops = dvbdevfops;
 	init_waitqueue_head (&dvbdev->wait_queue);
-
 	dvbdevfops->owner = adap->module;
-
 	list_add_tail (&dvbdev->list_head, &adap->device_list);
-
 	down_write(&minor_rwsem);
 #ifdef CONFIG_DVB_DYNAMIC_MINORS
 	for (minor = 0; minor < MAX_DVB_MINORS; minor++)
 		if (dvb_minors[minor] == NULL)
 			break;
-
 	if (minor == MAX_DVB_MINORS) {
-		kfree(dvbdevfops);
+		if (new_node) {
+			list_del (&new_node->list_head);
+			kfree(dvbdevfops);
+			kfree(new_node);
+		}
+		list_del (&dvbdev->list_head);
 		kfree(dvbdev);
 		up_write(&minor_rwsem);
 		mutex_unlock(&dvbdev_register_lock);
@@ -520,36 +550,47 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 #else
 	minor = nums2minor(adap->num, type, id);
 #endif
-
 	dvbdev->minor = minor;
 	dvb_minors[minor] = dvb_device_get(dvbdev);
 	up_write(&minor_rwsem);
-
 	ret = dvb_register_media_device(dvbdev, type, minor, demux_sink_pads);
 	if (ret) {
 		pr_err("%s: dvb_register_media_device failed to create the mediagraph\n",
 		      __func__);
-
+		if (new_node) {
+			list_del (&new_node->list_head);
+			kfree(dvbdevfops);
+			kfree(new_node);
+		}
 		dvb_media_device_free(dvbdev);
-		kfree(dvbdevfops);
+		list_del (&dvbdev->list_head);
 		kfree(dvbdev);
 		mutex_unlock(&dvbdev_register_lock);
 		return ret;
 	}
 
-	mutex_unlock(&dvbdev_register_lock);
-
 	clsdev = device_create(dvb_class, adap->device,
 			       MKDEV(DVB_MAJOR, minor),
 			       dvbdev, "dvb%d.%s%d", adap->num, dnames[type], id);
 	if (IS_ERR(clsdev)) {
 		pr_err("%s: failed to create device dvb%d.%s%d (%ld)\n",
 		       __func__, adap->num, dnames[type], id, PTR_ERR(clsdev));
+		if (new_node) {
+			list_del (&new_node->list_head);
+			kfree(dvbdevfops);
+			kfree(new_node);
+		}
+		dvb_media_device_free(dvbdev);
+		list_del (&dvbdev->list_head);
+		kfree(dvbdev);
+		mutex_unlock(&dvbdev_register_lock);
 		return PTR_ERR(clsdev);
 	}
+
 	dprintk("DVB: register adapter%d/%s%d @ minor: %i (0x%02x)\n",
 		adap->num, dnames[type], id, minor, minor);
 
+	mutex_unlock(&dvbdev_register_lock);
 	return 0;
 }
 EXPORT_SYMBOL(dvb_register_device);
@@ -578,7 +619,6 @@ static void dvb_free_device(struct kref *ref)
 {
 	struct dvb_device *dvbdev = container_of(ref, struct dvb_device, ref);
 
-	kfree (dvbdev->fops);
 	kfree (dvbdev);
 }
 
@@ -1084,9 +1124,17 @@ static int __init init_dvbdev(void)
 
 static void __exit exit_dvbdev(void)
 {
+	struct dvbdevfops_node *node, *next;
+
 	class_destroy(dvb_class);
 	cdev_del(&dvb_device_cdev);
 	unregister_chrdev_region(MKDEV(DVB_MAJOR, 0), MAX_DVB_MINORS);
+
+	list_for_each_entry_safe(node, next, &dvbdevfops_list, list_head) {
+		list_del (&node->list_head);
+		kfree(node->fops);
+		kfree(node);
+	}
 }
 
 subsys_initcall(init_dvbdev);
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 6622e3262187..599b7317b59a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -253,6 +253,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
 		goto out_put;
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_BOOT_WP;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	blk_execute_rq(mq->queue, NULL, req, 0);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	blk_put_request(req);
@@ -638,6 +639,7 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
 	idatas[0] = idata;
 	req_to_mmc_queue_req(req)->drv_op =
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = idatas;
 	req_to_mmc_queue_req(req)->ioc_count = 1;
 	blk_execute_rq(mq->queue, NULL, req, 0);
@@ -707,6 +709,7 @@ static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
 	}
 	req_to_mmc_queue_req(req)->drv_op =
 		rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = idata;
 	req_to_mmc_queue_req(req)->ioc_count = num_of_cmds;
 	blk_execute_rq(mq->queue, NULL, req, 0);
@@ -2749,6 +2752,7 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	blk_execute_rq(mq->queue, NULL, req, 0);
 	ret = req_to_mmc_queue_req(req)->drv_op_result;
 	if (ret >= 0) {
@@ -2787,6 +2791,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 		goto out_free;
 	}
 	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
+	req_to_mmc_queue_req(req)->drv_op_result = -EIO;
 	req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
 	blk_execute_rq(mq->queue, NULL, req, 0);
 	err = req_to_mmc_queue_req(req)->drv_op_result;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index 8d92dc6bc994..d7215bd772f3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -196,8 +196,8 @@ int enetc_setup_tc_cbs(struct net_device *ndev, void *type_data)
 	int bw_sum = 0;
 	u8 bw;
 
-	prio_top = netdev_get_prio_tc_map(ndev, tc_nums - 1);
-	prio_next = netdev_get_prio_tc_map(ndev, tc_nums - 2);
+	prio_top = tc_nums - 1;
+	prio_next = tc_nums - 2;
 
 	/* Support highest prio and second prio tc in cbs mode */
 	if (tc != prio_top && tc != prio_next)
diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index a994a2970ab2..6a6b5f6e8276 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -398,7 +398,7 @@ void iavf_set_ethtool_ops(struct net_device *netdev);
 void iavf_update_stats(struct iavf_adapter *adapter);
 void iavf_reset_interrupt_capability(struct iavf_adapter *adapter);
 int iavf_init_interrupt_scheme(struct iavf_adapter *adapter);
-void iavf_irq_enable_queues(struct iavf_adapter *adapter, u32 mask);
+void iavf_irq_enable_queues(struct iavf_adapter *adapter);
 void iavf_free_all_tx_resources(struct iavf_adapter *adapter);
 void iavf_free_all_rx_resources(struct iavf_adapter *adapter);
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index ae96b552a3bb..e45f3a1a11f3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -234,21 +234,18 @@ static void iavf_irq_disable(struct iavf_adapter *adapter)
 }
 
 /**
- * iavf_irq_enable_queues - Enable interrupt for specified queues
+ * iavf_irq_enable_queues - Enable interrupt for all queues
  * @adapter: board private structure
- * @mask: bitmap of queues to enable
  **/
-void iavf_irq_enable_queues(struct iavf_adapter *adapter, u32 mask)
+void iavf_irq_enable_queues(struct iavf_adapter *adapter)
 {
 	struct iavf_hw *hw = &adapter->hw;
 	int i;
 
 	for (i = 1; i < adapter->num_msix_vectors; i++) {
-		if (mask & BIT(i - 1)) {
-			wr32(hw, IAVF_VFINT_DYN_CTLN1(i - 1),
-			     IAVF_VFINT_DYN_CTLN1_INTENA_MASK |
-			     IAVF_VFINT_DYN_CTLN1_ITR_INDX_MASK);
-		}
+		wr32(hw, IAVF_VFINT_DYN_CTLN1(i - 1),
+		     IAVF_VFINT_DYN_CTLN1_INTENA_MASK |
+		     IAVF_VFINT_DYN_CTLN1_ITR_INDX_MASK);
 	}
 }
 
@@ -262,7 +259,7 @@ void iavf_irq_enable(struct iavf_adapter *adapter, bool flush)
 	struct iavf_hw *hw = &adapter->hw;
 
 	iavf_misc_irq_enable(adapter);
-	iavf_irq_enable_queues(adapter, ~0);
+	iavf_irq_enable_queues(adapter);
 
 	if (flush)
 		iavf_flush(hw);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_register.h b/drivers/net/ethernet/intel/iavf/iavf_register.h
index bf793332fc9d..a19e88898a0b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_register.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_register.h
@@ -40,7 +40,7 @@
 #define IAVF_VFINT_DYN_CTL01_INTENA_MASK IAVF_MASK(0x1, IAVF_VFINT_DYN_CTL01_INTENA_SHIFT)
 #define IAVF_VFINT_DYN_CTL01_ITR_INDX_SHIFT 3
 #define IAVF_VFINT_DYN_CTL01_ITR_INDX_MASK IAVF_MASK(0x3, IAVF_VFINT_DYN_CTL01_ITR_INDX_SHIFT)
-#define IAVF_VFINT_DYN_CTLN1(_INTVF) (0x00003800 + ((_INTVF) * 4)) /* _i=0...15 */ /* Reset: VFR */
+#define IAVF_VFINT_DYN_CTLN1(_INTVF) (0x00003800 + ((_INTVF) * 4)) /* _i=0...63 */ /* Reset: VFR */
 #define IAVF_VFINT_DYN_CTLN1_INTENA_SHIFT 0
 #define IAVF_VFINT_DYN_CTLN1_INTENA_MASK IAVF_MASK(0x1, IAVF_VFINT_DYN_CTLN1_INTENA_SHIFT)
 #define IAVF_VFINT_DYN_CTLN1_SWINT_TRIG_SHIFT 2
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 5e3b0a5843a8..d9de3b811543 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -822,6 +822,8 @@ static int igb_set_eeprom(struct net_device *netdev,
 		 */
 		ret_val = hw->nvm.ops.read(hw, last_word, 1,
 				   &eeprom_buff[last_word - first_word]);
+		if (ret_val)
+			goto out;
 	}
 
 	/* Device's eeprom is always little-endian, word addressable */
@@ -841,6 +843,7 @@ static int igb_set_eeprom(struct net_device *netdev,
 		hw->nvm.ops.update(hw);
 
 	igb_set_fw_version(adapter);
+out:
 	kfree(eeprom_buff);
 	return ret_val;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 9886a30e9723..449f5224d1ae 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1385,7 +1385,8 @@ static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
 		free_cnt = rvu_rsrc_free_count(&txsch->schq);
 	}
 
-	if (free_cnt < req_schq || req_schq > MAX_TXSCHQ_PER_FUNC)
+	if (free_cnt < req_schq || req->schq[lvl] > MAX_TXSCHQ_PER_FUNC ||
+	    req->schq_contig[lvl] > MAX_TXSCHQ_PER_FUNC)
 		return NIX_AF_ERR_TLX_ALLOC_FAIL;
 
 	/* If contiguous queues are needed, check for availability */
diff --git a/drivers/net/ipvlan/ipvlan_l3s.c b/drivers/net/ipvlan/ipvlan_l3s.c
index 71712ea25403..d5b05e803219 100644
--- a/drivers/net/ipvlan/ipvlan_l3s.c
+++ b/drivers/net/ipvlan/ipvlan_l3s.c
@@ -102,6 +102,10 @@ static unsigned int ipvlan_nf_input(void *priv, struct sk_buff *skb,
 
 	skb->dev = addr->master->dev;
 	skb->skb_iif = skb->dev->ifindex;
+#if IS_ENABLED(CONFIG_IPV6)
+	if (addr->atype == IPVL_IPV6)
+		IP6CB(skb)->iif = skb->dev->ifindex;
+#endif
 	len = skb->len + ETH_HLEN;
 	ipvlan_count_rx(addr->master, len, true, false);
 out:
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 53f1cd0bfaf4..de6c56153534 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1156,7 +1156,9 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x05c6, 0x9080, 8)},
 	{QMI_FIXED_INTF(0x05c6, 0x9083, 3)},
 	{QMI_FIXED_INTF(0x05c6, 0x9084, 4)},
+	{QMI_QUIRK_SET_DTR(0x05c6, 0x9091, 2)},	/* Compal RXM-G1 */
 	{QMI_FIXED_INTF(0x05c6, 0x90b2, 3)},    /* ublox R410M */
+	{QMI_QUIRK_SET_DTR(0x05c6, 0x90db, 2)},	/* Compal RXM-G1 */
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 0)},
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 5)},
 	{QMI_QUIRK_SET_DTR(0x05c6, 0x9625, 4)},	/* YUGA CLM920-NC5 */
diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index b965eb6a4bb1..24c53cc0c112 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -341,6 +341,9 @@ static int lapbeth_new_device(struct net_device *dev)
 
 	ASSERT_RTNL();
 
+	if (dev->type != ARPHRD_ETHER)
+		return -EINVAL;
+
 	ndev = alloc_netdev(sizeof(*lapbeth), "lapb%d", NET_NAME_UNKNOWN,
 			    lapbeth_setup);
 	if (!ndev)
diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 74637bd0433e..b4a5cbdae904 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -507,6 +507,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x71, { KEY_F13 } }, /* General-purpose button */
 	{ KE_IGNORE, 0x79, },  /* Charger type dectection notification */
 	{ KE_KEY, 0x7a, { KEY_ALS_TOGGLE } }, /* Ambient Light Sensor Toggle */
+	{ KE_IGNORE, 0x7B, }, /* Charger connect/disconnect notification */
 	{ KE_KEY, 0x7c, { KEY_MICMUTE } },
 	{ KE_KEY, 0x7D, { KEY_BLUETOOTH } }, /* Bluetooth Enable */
 	{ KE_KEY, 0x7E, { KEY_BLUETOOTH } }, /* Bluetooth Disable */
@@ -532,6 +533,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xA6, { KEY_SWITCHVIDEOMODE } }, /* SDSP CRT + TV + HDMI */
 	{ KE_KEY, 0xA7, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + CRT + TV + HDMI */
 	{ KE_KEY, 0xB5, { KEY_CALC } },
+	{ KE_IGNORE, 0xC0, }, /* External display connect/disconnect notification */
 	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
 	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 4417d64c31f9..5a1adceb6974 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -921,10 +921,8 @@ static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
  */
 static void ab8500_btemp_external_power_changed(struct power_supply *psy)
 {
-	struct ab8500_btemp *di = power_supply_get_drvdata(psy);
-
-	class_for_each_device(power_supply_class, NULL,
-		di->btemp_psy, ab8500_btemp_get_ext_psy_data);
+	class_for_each_device(power_supply_class, NULL, psy,
+			      ab8500_btemp_get_ext_psy_data);
 }
 
 /* ab8500 btemp driver interrupts and their respective isr */
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index a6b4a94c2766..a88590563647 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2380,10 +2380,8 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
  */
 static void ab8500_fg_external_power_changed(struct power_supply *psy)
 {
-	struct ab8500_fg *di = power_supply_get_drvdata(psy);
-
-	class_for_each_device(power_supply_class, NULL,
-		di->fg_psy, ab8500_fg_get_ext_psy_data);
+	class_for_each_device(power_supply_class, NULL, psy,
+			      ab8500_fg_get_ext_psy_data);
 }
 
 /**
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 235647b21af7..0673e0fe0ffb 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1018,10 +1018,8 @@ static int poll_interval_param_set(const char *val, const struct kernel_param *k
 		return ret;
 
 	mutex_lock(&bq27xxx_list_lock);
-	list_for_each_entry(di, &bq27xxx_battery_devices, list) {
-		cancel_delayed_work_sync(&di->work);
-		schedule_delayed_work(&di->work, 0);
-	}
+	list_for_each_entry(di, &bq27xxx_battery_devices, list)
+		mod_delayed_work(system_wq, &di->work, 0);
 	mutex_unlock(&bq27xxx_list_lock);
 
 	return ret;
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 53e5b3e04be1..5c8c117b396e 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -347,6 +347,10 @@ static int __power_supply_is_system_supplied(struct device *dev, void *data)
 	struct power_supply *psy = dev_get_drvdata(dev);
 	unsigned int *count = data;
 
+	if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_SCOPE, &ret))
+		if (ret.intval == POWER_SUPPLY_SCOPE_DEVICE)
+			return 0;
+
 	(*count)++;
 	if (psy->desc->type != POWER_SUPPLY_TYPE_BATTERY)
 		if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_ONLINE,
@@ -365,8 +369,8 @@ int power_supply_is_system_supplied(void)
 				      __power_supply_is_system_supplied);
 
 	/*
-	 * If no power class device was found at all, most probably we are
-	 * running on a desktop system, so assume we are on mains power.
+	 * If no system scope power class device was found at all, most probably we
+	 * are running on a desktop system, so assume we are on mains power.
 	 */
 	if (count == 0)
 		return 1;
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index a616b9d8f43c..2b1df9c33969 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -276,7 +276,8 @@ static ssize_t power_supply_show_property(struct device *dev,
 
 		if (ret < 0) {
 			if (ret == -ENODATA)
-				dev_dbg(dev, "driver has no data for `%s' property\n",
+				dev_dbg_ratelimited(dev,
+					"driver has no data for `%s' property\n",
 					attr->attr.name);
 			else if (ret != -ENODEV && ret != -EAGAIN)
 				dev_err_ratelimited(dev,
diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 1ae8374e1ceb..3bf4b263950d 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -733,13 +733,6 @@ static int sc27xx_fgu_set_property(struct power_supply *psy,
 	return ret;
 }
 
-static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
-{
-	struct sc27xx_fgu_data *data = power_supply_get_drvdata(psy);
-
-	power_supply_changed(data->battery);
-}
-
 static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
 					    enum power_supply_property psp)
 {
@@ -774,7 +767,7 @@ static const struct power_supply_desc sc27xx_fgu_desc = {
 	.num_properties		= ARRAY_SIZE(sc27xx_fgu_props),
 	.get_property		= sc27xx_fgu_get_property,
 	.set_property		= sc27xx_fgu_set_property,
-	.external_power_changed	= sc27xx_fgu_external_power_changed,
+	.external_power_changed	= power_supply_changed,
 	.property_is_writeable	= sc27xx_fgu_property_is_writeable,
 	.no_thermal		= true,
 };
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 47a04c5f7a9b..f5ab74683b58 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5032,7 +5032,7 @@ static void rdev_init_debugfs(struct regulator_dev *rdev)
 	}
 
 	rdev->debugfs = debugfs_create_dir(rname, debugfs_root);
-	if (!rdev->debugfs) {
+	if (IS_ERR(rdev->debugfs)) {
 		rdev_warn(rdev, "Failed to create debugfs directory\n");
 		return;
 	}
@@ -5937,7 +5937,7 @@ static int __init regulator_init(void)
 	ret = class_register(&regulator_class);
 
 	debugfs_root = debugfs_create_dir("regulator", NULL);
-	if (!debugfs_root)
+	if (IS_ERR(debugfs_root))
 		pr_warn("regulator: Failed to create debugfs directory\n");
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index fd004c9db9dc..0d9201a2999d 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -975,7 +975,9 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 static int dspi_setup(struct spi_device *spi)
 {
 	struct fsl_dspi *dspi = spi_controller_get_devdata(spi->controller);
+	u32 period_ns = DIV_ROUND_UP(NSEC_PER_SEC, spi->max_speed_hz);
 	unsigned char br = 0, pbr = 0, pcssck = 0, cssck = 0;
+	u32 quarter_period_ns = DIV_ROUND_UP(period_ns, 4);
 	u32 cs_sck_delay = 0, sck_cs_delay = 0;
 	struct fsl_dspi_platform_data *pdata;
 	unsigned char pasc = 0, asc = 0;
@@ -1003,6 +1005,19 @@ static int dspi_setup(struct spi_device *spi)
 		sck_cs_delay = pdata->sck_cs_delay;
 	}
 
+	/* Since tCSC and tASC apply to continuous transfers too, avoid SCK
+	 * glitches of half a cycle by never allowing tCSC + tASC to go below
+	 * half a SCK period.
+	 */
+	if (cs_sck_delay < quarter_period_ns)
+		cs_sck_delay = quarter_period_ns;
+	if (sck_cs_delay < quarter_period_ns)
+		sck_cs_delay = quarter_period_ns;
+
+	dev_dbg(&spi->dev,
+		"DSPI controller timing params: CS-to-SCK delay %u ns, SCK-to-CS delay %u ns\n",
+		cs_sck_delay, sck_cs_delay);
+
 	clkrate = clk_get_rate(dspi->clk);
 	hz_to_spi_baud(&pbr, &br, spi->max_speed_hz, clkrate);
 
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 62813e421f12..ee5fd4d845c8 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -274,6 +274,7 @@ lqasc_err_int(int irq, void *_port)
 	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
 
 	spin_lock_irqsave(&ltq_port->lock, flags);
+	__raw_writel(ASC_IRNCR_EIR, port->membase + LTQ_ASC_IRNCR);
 	/* clear any pending interrupts */
 	asc_update_bits(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
 		ASCWHBSTATE_CLRROE, port->membase + LTQ_ASC_WHBSTATE);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4e3b451ed749..164910237669 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -180,6 +180,7 @@ static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
 	list_del(&req->list);
 	req->remaining = 0;
 	req->needs_extra_trb = false;
+	req->num_trbs = 0;
 
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 5b474efeab6a..243f97a30779 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -248,6 +248,8 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_VENDOR_ID			0x2c7c
 /* These Quectel products use Quectel's vendor ID */
 #define QUECTEL_PRODUCT_EC21			0x0121
+#define QUECTEL_PRODUCT_EM061K_LTA		0x0123
+#define QUECTEL_PRODUCT_EM061K_LMS		0x0124
 #define QUECTEL_PRODUCT_EC25			0x0125
 #define QUECTEL_PRODUCT_EG91			0x0191
 #define QUECTEL_PRODUCT_EG95			0x0195
@@ -266,6 +268,8 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_RM520N			0x0801
 #define QUECTEL_PRODUCT_EC200U			0x0901
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
+#define QUECTEL_PRODUCT_EM061K_LWW		0x6008
+#define QUECTEL_PRODUCT_EM061K_LCN		0x6009
 #define QUECTEL_PRODUCT_EC200T			0x6026
 #define QUECTEL_PRODUCT_RM500K			0x7001
 
@@ -1189,6 +1193,18 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LCN, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LMS, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LMS, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LMS, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LTA, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LTA, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LTA, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LWW, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LWW, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM061K_LWW, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM12, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) | NUMEP2 },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM12, 0xff, 0, 0) },
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index d1c7068b4346..58452b86e672 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -115,8 +115,8 @@ void afs_vlserver_probe_result(struct afs_call *call)
 		}
 	}
 
-	if (rxrpc_kernel_get_srtt(call->net->socket, call->rxcall, &rtt_us) &&
-	    rtt_us < server->probe.rtt) {
+	rxrpc_kernel_get_srtt(call->net->socket, call->rxcall, &rtt_us);
+	if (rtt_us < server->probe.rtt) {
 		server->probe.rtt = rtt_us;
 		server->rtt = rtt_us;
 		alist->preferred = index;
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 889a598b17f6..d0fecbd28232 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2279,10 +2279,20 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	}
 
 	ret = inc_block_group_ro(cache, 0);
-	if (!do_chunk_alloc || ret == -ETXTBSY)
-		goto unlock_out;
 	if (!ret)
 		goto out;
+	if (ret == -ETXTBSY)
+		goto unlock_out;
+
+	/*
+	 * Skip chunk alloction if the bg is SYSTEM, this is to avoid system
+	 * chunk allocation storm to exhaust the system chunk array.  Otherwise
+	 * we still want to try our best to mark the block group read-only.
+	 */
+	if (!do_chunk_alloc && ret == -ENOSPC &&
+	    (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM))
+		goto unlock_out;
+
 	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 2de1d8247494..cbea4f572155 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -602,7 +602,9 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 				sums = kvzalloc(btrfs_ordered_sum_size(fs_info,
 						      bytes_left), GFP_KERNEL);
 				memalloc_nofs_restore(nofs_flag);
-				BUG_ON(!sums); /* -ENOMEM */
+				if (!sums)
+					return BLK_STS_RESOURCE;
+
 				sums->len = bytes_left;
 				ordered = btrfs_lookup_ordered_extent(inode,
 								offset);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 88b9a5394561..715a0329ba27 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3559,13 +3559,20 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		ret = btrfs_inc_block_group_ro(cache, sctx->is_dev_replace);
 		if (ret == 0) {
 			ro_set = 1;
-		} else if (ret == -ENOSPC && !sctx->is_dev_replace) {
+		} else if (ret == -ENOSPC && !sctx->is_dev_replace &&
+			   !(cache->flags & BTRFS_BLOCK_GROUP_RAID56_MASK)) {
 			/*
 			 * btrfs_inc_block_group_ro return -ENOSPC when it
 			 * failed in creating new chunk for metadata.
 			 * It is not a problem for scrub, because
 			 * metadata are always cowed, and our scrub paused
 			 * commit_transactions.
+			 *
+			 * For RAID56 chunks, we have to mark them read-only
+			 * for scrub, as later we would use our own cache
+			 * out of RAID56 realm.
+			 * Thus we want the RAID56 bg to be marked RO to
+			 * prevent RMW from screwing up out cache.
 			 */
 			ro_set = 0;
 		} else if (ret == -ETXTBSY) {
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 13d4c3d50412..5ce1ea1f452b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1817,7 +1817,11 @@ static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
 {
 	int ret = default_wake_function(wq_entry, mode, sync, key);
 
-	list_del_init(&wq_entry->entry);
+	/*
+	 * Pairs with list_empty_careful in ep_poll, and ensures future loop
+	 * iterations see the cause of this wakeup.
+	 */
+	list_del_init_careful(&wq_entry->entry);
 	return ret;
 }
 
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index a43167042b6b..4efe71efe127 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -322,17 +322,15 @@ static ext4_fsblk_t ext4_valid_block_bitmap_padding(struct super_block *sb,
 struct ext4_group_info *ext4_get_group_info(struct super_block *sb,
 					    ext4_group_t group)
 {
-	 struct ext4_group_info **grp_info;
-	 long indexv, indexh;
-
-	 if (unlikely(group >= EXT4_SB(sb)->s_groups_count)) {
-		 ext4_error(sb, "invalid group %u", group);
-		 return NULL;
-	 }
-	 indexv = group >> (EXT4_DESC_PER_BLOCK_BITS(sb));
-	 indexh = group & ((EXT4_DESC_PER_BLOCK(sb)) - 1);
-	 grp_info = sbi_array_rcu_deref(EXT4_SB(sb), s_group_info, indexv);
-	 return grp_info[indexh];
+	struct ext4_group_info **grp_info;
+	long indexv, indexh;
+
+	if (unlikely(group >= EXT4_SB(sb)->s_groups_count))
+		return NULL;
+	indexv = group >> (EXT4_DESC_PER_BLOCK_BITS(sb));
+	indexh = group & ((EXT4_DESC_PER_BLOCK(sb)) - 1);
+	grp_info = sbi_array_rcu_deref(EXT4_SB(sb), s_group_info, indexv);
+	return grp_info[indexh];
 }
 
 /*
diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index e00e184b1261..1776121677e2 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -285,6 +285,14 @@ void nilfs_btnode_abort_change_key(struct address_space *btnc,
 	if (nbh == NULL) {	/* blocksize == pagesize */
 		xa_erase_irq(&btnc->i_pages, newkey);
 		unlock_page(ctxt->bh->b_page);
-	} else
-		brelse(nbh);
+	} else {
+		/*
+		 * When canceling a buffer that a prepare operation has
+		 * allocated to copy a node block to another location, use
+		 * nilfs_btnode_delete() to initialize and release the buffer
+		 * so that the buffer flags will not be in an inconsistent
+		 * state when it is reallocated.
+		 */
+		nilfs_btnode_delete(nbh);
+	}
 }
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index 51f4cb060231..b3abe69382fd 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -779,6 +779,15 @@ int nilfs_sufile_resize(struct inode *sufile, __u64 newnsegs)
 			goto out_header;
 
 		sui->ncleansegs -= nsegs - newnsegs;
+
+		/*
+		 * If the sufile is successfully truncated, immediately adjust
+		 * the segment allocation space while locking the semaphore
+		 * "mi_sem" so that nilfs_sufile_alloc() never allocates
+		 * segments in the truncated space.
+		 */
+		sui->allocmax = newnsegs - 1;
+		sui->allocmin = 0;
 	}
 
 	kaddr = kmap_atomic(header_bh->b_page);
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index d8d08fa5c340..1566e86e8e55 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -405,6 +405,18 @@ unsigned long nilfs_nrsvsegs(struct the_nilfs *nilfs, unsigned long nsegs)
 				  100));
 }
 
+/**
+ * nilfs_max_segment_count - calculate the maximum number of segments
+ * @nilfs: nilfs object
+ */
+static u64 nilfs_max_segment_count(struct the_nilfs *nilfs)
+{
+	u64 max_count = U64_MAX;
+
+	do_div(max_count, nilfs->ns_blocks_per_segment);
+	return min_t(u64, max_count, ULONG_MAX);
+}
+
 void nilfs_set_nsegments(struct the_nilfs *nilfs, unsigned long nsegs)
 {
 	nilfs->ns_nsegments = nsegs;
@@ -414,6 +426,8 @@ void nilfs_set_nsegments(struct the_nilfs *nilfs, unsigned long nsegs)
 static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 				   struct nilfs_super_block *sbp)
 {
+	u64 nsegments, nblocks;
+
 	if (le32_to_cpu(sbp->s_rev_level) < NILFS_MIN_SUPP_REV) {
 		nilfs_err(nilfs->ns_sb,
 			  "unsupported revision (superblock rev.=%d.%d, current rev.=%d.%d). Please check the version of mkfs.nilfs(2).",
@@ -457,7 +471,35 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 		return -EINVAL;
 	}
 
-	nilfs_set_nsegments(nilfs, le64_to_cpu(sbp->s_nsegments));
+	nsegments = le64_to_cpu(sbp->s_nsegments);
+	if (nsegments > nilfs_max_segment_count(nilfs)) {
+		nilfs_err(nilfs->ns_sb,
+			  "segment count %llu exceeds upper limit (%llu segments)",
+			  (unsigned long long)nsegments,
+			  (unsigned long long)nilfs_max_segment_count(nilfs));
+		return -EINVAL;
+	}
+
+	nblocks = (u64)i_size_read(nilfs->ns_sb->s_bdev->bd_inode) >>
+		nilfs->ns_sb->s_blocksize_bits;
+	if (nblocks) {
+		u64 min_block_count = nsegments * nilfs->ns_blocks_per_segment;
+		/*
+		 * To avoid failing to mount early device images without a
+		 * second superblock, exclude that block count from the
+		 * "min_block_count" calculation.
+		 */
+
+		if (nblocks < min_block_count) {
+			nilfs_err(nilfs->ns_sb,
+				  "total number of segment blocks %llu exceeds device size (%llu blocks)",
+				  (unsigned long long)min_block_count,
+				  (unsigned long long)nblocks);
+			return -EINVAL;
+		}
+	}
+
+	nilfs_set_nsegments(nilfs, nsegments);
 	nilfs->ns_crc_seed = le32_to_cpu(sbp->s_crc_seed);
 	return 0;
 }
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index ca00cac5a12f..df36d84aedc4 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2103,14 +2103,20 @@ static long ocfs2_fallocate(struct file *file, int mode, loff_t offset,
 	struct ocfs2_space_resv sr;
 	int change_size = 1;
 	int cmd = OCFS2_IOC_RESVSP64;
+	int ret = 0;
 
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
 	if (!ocfs2_writes_unwritten_extents(osb))
 		return -EOPNOTSUPP;
 
-	if (mode & FALLOC_FL_KEEP_SIZE)
+	if (mode & FALLOC_FL_KEEP_SIZE) {
 		change_size = 0;
+	} else {
+		ret = inode_newsize_ok(inode, offset + len);
+		if (ret)
+			return ret;
+	}
 
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		cmd = OCFS2_IOC_UNRESVSP64;
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 04ce30ae4404..dc21d35527ab 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -955,8 +955,10 @@ static void ocfs2_disable_quotas(struct ocfs2_super *osb)
 	for (type = 0; type < OCFS2_MAXQUOTAS; type++) {
 		if (!sb_has_quota_loaded(sb, type))
 			continue;
-		oinfo = sb_dqinfo(sb, type)->dqi_priv;
-		cancel_delayed_work_sync(&oinfo->dqi_sync_work);
+		if (!sb_has_quota_suspended(sb, type)) {
+			oinfo = sb_dqinfo(sb, type)->dqi_priv;
+			cancel_delayed_work_sync(&oinfo->dqi_sync_work);
+		}
 		inode = igrab(sb->s_dquot.files[type]);
 		/* Turn off quotas. This will remove all dquot structures from
 		 * memory and so they will be automatically synced to global
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 66948e1bf4fa..cdd6ed5bbcf2 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/bitops.h>
+#include <linux/kstrtox.h>
 #include <linux/log2.h>
 #include <linux/minmax.h>
 #include <linux/typecheck.h>
@@ -329,148 +330,6 @@ extern bool oops_may_print(void);
 void do_exit(long error_code) __noreturn;
 void complete_and_exit(struct completion *, long) __noreturn;
 
-/* Internal, do not use. */
-int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
-int __must_check _kstrtol(const char *s, unsigned int base, long *res);
-
-int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
-int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
-
-/**
- * kstrtoul - convert a string to an unsigned long
- * @s: The start of the string. The string must be null-terminated, and may also
- *  include a single newline before its terminating null. The first character
- *  may also be a plus sign, but not a minus sign.
- * @base: The number base to use. The maximum supported base is 16. If base is
- *  given as 0, then the base of the string is automatically detected with the
- *  conventional semantics - If it begins with 0x the number will be parsed as a
- *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
- *  parsed as an octal number. Otherwise it will be parsed as a decimal.
- * @res: Where to write the result of the conversion on success.
- *
- * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Preferred over simple_strtoul(). Return code must be checked.
-*/
-static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
-{
-	/*
-	 * We want to shortcut function call, but
-	 * __builtin_types_compatible_p(unsigned long, unsigned long long) = 0.
-	 */
-	if (sizeof(unsigned long) == sizeof(unsigned long long) &&
-	    __alignof__(unsigned long) == __alignof__(unsigned long long))
-		return kstrtoull(s, base, (unsigned long long *)res);
-	else
-		return _kstrtoul(s, base, res);
-}
-
-/**
- * kstrtol - convert a string to a long
- * @s: The start of the string. The string must be null-terminated, and may also
- *  include a single newline before its terminating null. The first character
- *  may also be a plus sign or a minus sign.
- * @base: The number base to use. The maximum supported base is 16. If base is
- *  given as 0, then the base of the string is automatically detected with the
- *  conventional semantics - If it begins with 0x the number will be parsed as a
- *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
- *  parsed as an octal number. Otherwise it will be parsed as a decimal.
- * @res: Where to write the result of the conversion on success.
- *
- * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
- * Preferred over simple_strtol(). Return code must be checked.
- */
-static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
-{
-	/*
-	 * We want to shortcut function call, but
-	 * __builtin_types_compatible_p(long, long long) = 0.
-	 */
-	if (sizeof(long) == sizeof(long long) &&
-	    __alignof__(long) == __alignof__(long long))
-		return kstrtoll(s, base, (long long *)res);
-	else
-		return _kstrtol(s, base, res);
-}
-
-int __must_check kstrtouint(const char *s, unsigned int base, unsigned int *res);
-int __must_check kstrtoint(const char *s, unsigned int base, int *res);
-
-static inline int __must_check kstrtou64(const char *s, unsigned int base, u64 *res)
-{
-	return kstrtoull(s, base, res);
-}
-
-static inline int __must_check kstrtos64(const char *s, unsigned int base, s64 *res)
-{
-	return kstrtoll(s, base, res);
-}
-
-static inline int __must_check kstrtou32(const char *s, unsigned int base, u32 *res)
-{
-	return kstrtouint(s, base, res);
-}
-
-static inline int __must_check kstrtos32(const char *s, unsigned int base, s32 *res)
-{
-	return kstrtoint(s, base, res);
-}
-
-int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
-int __must_check kstrtos16(const char *s, unsigned int base, s16 *res);
-int __must_check kstrtou8(const char *s, unsigned int base, u8 *res);
-int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
-int __must_check kstrtobool(const char *s, bool *res);
-
-int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
-int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
-int __must_check kstrtoul_from_user(const char __user *s, size_t count, unsigned int base, unsigned long *res);
-int __must_check kstrtol_from_user(const char __user *s, size_t count, unsigned int base, long *res);
-int __must_check kstrtouint_from_user(const char __user *s, size_t count, unsigned int base, unsigned int *res);
-int __must_check kstrtoint_from_user(const char __user *s, size_t count, unsigned int base, int *res);
-int __must_check kstrtou16_from_user(const char __user *s, size_t count, unsigned int base, u16 *res);
-int __must_check kstrtos16_from_user(const char __user *s, size_t count, unsigned int base, s16 *res);
-int __must_check kstrtou8_from_user(const char __user *s, size_t count, unsigned int base, u8 *res);
-int __must_check kstrtos8_from_user(const char __user *s, size_t count, unsigned int base, s8 *res);
-int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *res);
-
-static inline int __must_check kstrtou64_from_user(const char __user *s, size_t count, unsigned int base, u64 *res)
-{
-	return kstrtoull_from_user(s, count, base, res);
-}
-
-static inline int __must_check kstrtos64_from_user(const char __user *s, size_t count, unsigned int base, s64 *res)
-{
-	return kstrtoll_from_user(s, count, base, res);
-}
-
-static inline int __must_check kstrtou32_from_user(const char __user *s, size_t count, unsigned int base, u32 *res)
-{
-	return kstrtouint_from_user(s, count, base, res);
-}
-
-static inline int __must_check kstrtos32_from_user(const char __user *s, size_t count, unsigned int base, s32 *res)
-{
-	return kstrtoint_from_user(s, count, base, res);
-}
-
-/*
- * Use kstrto<foo> instead.
- *
- * NOTE: simple_strto<foo> does not check for the range overflow and,
- *	 depending on the input, may give interesting results.
- *
- * Use these functions if and only if you cannot use kstrto<foo>, because
- * the conversion ends on the first non-digit character, which may be far
- * beyond the supported range. It might be useful to parse the strings like
- * 10x50 or 12:21 without altering original string or temporary buffer in use.
- * Keep in mind above caveat.
- */
-
-extern unsigned long simple_strtoul(const char *,char **,unsigned int);
-extern long simple_strtol(const char *,char **,unsigned int);
-extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
-extern long long simple_strtoll(const char *,char **,unsigned int);
-
 extern int num_to_str(char *buf, int size,
 		      unsigned long long num, unsigned int width);
 
diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
new file mode 100644
index 000000000000..529974e22ea7
--- /dev/null
+++ b/include/linux/kstrtox.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KSTRTOX_H
+#define _LINUX_KSTRTOX_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/* Internal, do not use. */
+int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
+int __must_check _kstrtol(const char *s, unsigned int base, long *res);
+
+int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
+int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
+
+/**
+ * kstrtoul - convert a string to an unsigned long
+ * @s: The start of the string. The string must be null-terminated, and may also
+ *  include a single newline before its terminating null. The first character
+ *  may also be a plus sign, but not a minus sign.
+ * @base: The number base to use. The maximum supported base is 16. If base is
+ *  given as 0, then the base of the string is automatically detected with the
+ *  conventional semantics - If it begins with 0x the number will be parsed as a
+ *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
+ *  parsed as an octal number. Otherwise it will be parsed as a decimal.
+ * @res: Where to write the result of the conversion on success.
+ *
+ * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
+ * Preferred over simple_strtoul(). Return code must be checked.
+*/
+static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
+{
+	/*
+	 * We want to shortcut function call, but
+	 * __builtin_types_compatible_p(unsigned long, unsigned long long) = 0.
+	 */
+	if (sizeof(unsigned long) == sizeof(unsigned long long) &&
+	    __alignof__(unsigned long) == __alignof__(unsigned long long))
+		return kstrtoull(s, base, (unsigned long long *)res);
+	else
+		return _kstrtoul(s, base, res);
+}
+
+/**
+ * kstrtol - convert a string to a long
+ * @s: The start of the string. The string must be null-terminated, and may also
+ *  include a single newline before its terminating null. The first character
+ *  may also be a plus sign or a minus sign.
+ * @base: The number base to use. The maximum supported base is 16. If base is
+ *  given as 0, then the base of the string is automatically detected with the
+ *  conventional semantics - If it begins with 0x the number will be parsed as a
+ *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
+ *  parsed as an octal number. Otherwise it will be parsed as a decimal.
+ * @res: Where to write the result of the conversion on success.
+ *
+ * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
+ * Preferred over simple_strtol(). Return code must be checked.
+ */
+static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
+{
+	/*
+	 * We want to shortcut function call, but
+	 * __builtin_types_compatible_p(long, long long) = 0.
+	 */
+	if (sizeof(long) == sizeof(long long) &&
+	    __alignof__(long) == __alignof__(long long))
+		return kstrtoll(s, base, (long long *)res);
+	else
+		return _kstrtol(s, base, res);
+}
+
+int __must_check kstrtouint(const char *s, unsigned int base, unsigned int *res);
+int __must_check kstrtoint(const char *s, unsigned int base, int *res);
+
+static inline int __must_check kstrtou64(const char *s, unsigned int base, u64 *res)
+{
+	return kstrtoull(s, base, res);
+}
+
+static inline int __must_check kstrtos64(const char *s, unsigned int base, s64 *res)
+{
+	return kstrtoll(s, base, res);
+}
+
+static inline int __must_check kstrtou32(const char *s, unsigned int base, u32 *res)
+{
+	return kstrtouint(s, base, res);
+}
+
+static inline int __must_check kstrtos32(const char *s, unsigned int base, s32 *res)
+{
+	return kstrtoint(s, base, res);
+}
+
+int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
+int __must_check kstrtos16(const char *s, unsigned int base, s16 *res);
+int __must_check kstrtou8(const char *s, unsigned int base, u8 *res);
+int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
+int __must_check kstrtobool(const char *s, bool *res);
+
+int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
+int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
+int __must_check kstrtoul_from_user(const char __user *s, size_t count, unsigned int base, unsigned long *res);
+int __must_check kstrtol_from_user(const char __user *s, size_t count, unsigned int base, long *res);
+int __must_check kstrtouint_from_user(const char __user *s, size_t count, unsigned int base, unsigned int *res);
+int __must_check kstrtoint_from_user(const char __user *s, size_t count, unsigned int base, int *res);
+int __must_check kstrtou16_from_user(const char __user *s, size_t count, unsigned int base, u16 *res);
+int __must_check kstrtos16_from_user(const char __user *s, size_t count, unsigned int base, s16 *res);
+int __must_check kstrtou8_from_user(const char __user *s, size_t count, unsigned int base, u8 *res);
+int __must_check kstrtos8_from_user(const char __user *s, size_t count, unsigned int base, s8 *res);
+int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *res);
+
+static inline int __must_check kstrtou64_from_user(const char __user *s, size_t count, unsigned int base, u64 *res)
+{
+	return kstrtoull_from_user(s, count, base, res);
+}
+
+static inline int __must_check kstrtos64_from_user(const char __user *s, size_t count, unsigned int base, s64 *res)
+{
+	return kstrtoll_from_user(s, count, base, res);
+}
+
+static inline int __must_check kstrtou32_from_user(const char __user *s, size_t count, unsigned int base, u32 *res)
+{
+	return kstrtouint_from_user(s, count, base, res);
+}
+
+static inline int __must_check kstrtos32_from_user(const char __user *s, size_t count, unsigned int base, s32 *res)
+{
+	return kstrtoint_from_user(s, count, base, res);
+}
+
+/*
+ * Use kstrto<foo> instead.
+ *
+ * NOTE: simple_strto<foo> does not check for the range overflow and,
+ *	 depending on the input, may give interesting results.
+ *
+ * Use these functions if and only if you cannot use kstrto<foo>, because
+ * the conversion ends on the first non-digit character, which may be far
+ * beyond the supported range. It might be useful to parse the strings like
+ * 10x50 or 12:21 without altering original string or temporary buffer in use.
+ * Keep in mind above caveat.
+ */
+
+extern unsigned long simple_strtoul(const char *,char **,unsigned int);
+extern long simple_strtol(const char *,char **,unsigned int);
+extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
+extern long long simple_strtoll(const char *,char **,unsigned int);
+
+static inline int strtobool(const char *s, bool *res)
+{
+	return kstrtobool(s, res);
+}
+
+#endif	/* _LINUX_KSTRTOX_H */
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 24fe2cd4b0e8..8f03cc42bd43 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1759,7 +1759,6 @@ enum netdev_ml_priv_type {
  *	@tipc_ptr:	TIPC specific data
  *	@atalk_ptr:	AppleTalk link
  *	@ip_ptr:	IPv4 specific data
- *	@dn_ptr:	DECnet specific data
  *	@ip6_ptr:	IPv6 specific data
  *	@ax25_ptr:	AX.25 specific data
  *	@ieee80211_ptr:	IEEE 802.11 specific data, assign before registering
@@ -2038,9 +2037,6 @@ struct net_device {
 	void 			*atalk_ptr;
 #endif
 	struct in_device __rcu	*ip_ptr;
-#if IS_ENABLED(CONFIG_DECNET)
-	struct dn_dev __rcu     *dn_ptr;
-#endif
 	struct inet6_dev __rcu	*ip6_ptr;
 #if IS_ENABLED(CONFIG_AX25)
 	void			*ax25_ptr;
diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 0101747de549..8b229abf1435 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -237,11 +237,6 @@ static inline int nf_hook(u_int8_t pf, unsigned int hook, struct net *net,
 		hook_head = rcu_dereference(net->nf.hooks_bridge[hook]);
 #endif
 		break;
-#if IS_ENABLED(CONFIG_DECNET)
-	case NFPROTO_DECNET:
-		hook_head = rcu_dereference(net->nf.hooks_decnet[hook]);
-		break;
-#endif
 	default:
 		WARN_ON_ONCE(1);
 		break;
diff --git a/include/linux/netfilter_defs.h b/include/linux/netfilter_defs.h
index 8dddfb151f00..a5f7bef1b3a4 100644
--- a/include/linux/netfilter_defs.h
+++ b/include/linux/netfilter_defs.h
@@ -7,14 +7,6 @@
 /* in/out/forward only */
 #define NF_ARP_NUMHOOKS 3
 
-/* max hook is NF_DN_ROUTE (6), also see uapi/linux/netfilter_decnet.h */
-#define NF_DN_NUMHOOKS 7
-
-#if IS_ENABLED(CONFIG_DECNET)
-/* Largest hook number + 1, see uapi/linux/netfilter_decnet.h */
-#define NF_MAX_HOOKS	NF_DN_NUMHOOKS
-#else
 #define NF_MAX_HOOKS	NF_INET_NUMHOOKS
-#endif
 
 #endif
diff --git a/include/linux/string.h b/include/linux/string.h
index b1f3894a0a3e..0cef345a6e87 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -2,7 +2,6 @@
 #ifndef _LINUX_STRING_H_
 #define _LINUX_STRING_H_
 
-
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
@@ -183,12 +182,6 @@ extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
 
 extern bool sysfs_streq(const char *s1, const char *s2);
-extern int kstrtobool(const char *s, bool *res);
-static inline int strtobool(const char *s, bool *res)
-{
-	return kstrtobool(s, res);
-}
-
 int match_string(const char * const *array, size_t n, const char *string);
 int __sysfs_match_string(const char * const *array, size_t n, const char *s);
 
diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index d0965e2997b0..b134b2b3371c 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -14,6 +14,7 @@
 #include <linux/kref.h>
 #include <linux/slab.h>
 #include <linux/atomic.h>
+#include <linux/kstrtox.h>
 #include <linux/proc_fs.h>
 
 /*
diff --git a/include/media/dvbdev.h b/include/media/dvbdev.h
index c493a3ffe45c..91ff2d5fcd08 100644
--- a/include/media/dvbdev.h
+++ b/include/media/dvbdev.h
@@ -189,6 +189,21 @@ struct dvb_device {
 	void *priv;
 };
 
+/**
+ * struct dvbdevfops_node - fops nodes registered in dvbdevfops_list
+ *
+ * @fops:		Dynamically allocated fops for ->owner registration
+ * @type:		type of dvb_device
+ * @template:		dvb_device used for registration
+ * @list_head:		list_head for dvbdevfops_list
+ */
+struct dvbdevfops_node {
+	struct file_operations *fops;
+	enum dvb_device_type type;
+	const struct dvb_device *template;
+	struct list_head list_head;
+};
+
 /**
  * dvb_device_get - Increase dvb_device reference
  *
diff --git a/include/net/dn.h b/include/net/dn.h
deleted file mode 100644
index 56ab0726c641..000000000000
--- a/include/net/dn.h
+++ /dev/null
@@ -1,231 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _NET_DN_H
-#define _NET_DN_H
-
-#include <linux/dn.h>
-#include <net/sock.h>
-#include <net/flow.h>
-#include <asm/byteorder.h>
-#include <asm/unaligned.h>
-
-struct dn_scp                                   /* Session Control Port */
-{
-        unsigned char           state;
-#define DN_O     1                      /* Open                 */
-#define DN_CR    2                      /* Connect Receive      */
-#define DN_DR    3                      /* Disconnect Reject    */
-#define DN_DRC   4                      /* Discon. Rej. Complete*/
-#define DN_CC    5                      /* Connect Confirm      */
-#define DN_CI    6                      /* Connect Initiate     */
-#define DN_NR    7                      /* No resources         */
-#define DN_NC    8                      /* No communication     */
-#define DN_CD    9                      /* Connect Delivery     */
-#define DN_RJ    10                     /* Rejected             */
-#define DN_RUN   11                     /* Running              */
-#define DN_DI    12                     /* Disconnect Initiate  */
-#define DN_DIC   13                     /* Disconnect Complete  */
-#define DN_DN    14                     /* Disconnect Notificat */
-#define DN_CL    15                     /* Closed               */
-#define DN_CN    16                     /* Closed Notification  */
-
-        __le16          addrloc;
-        __le16          addrrem;
-        __u16          numdat;
-        __u16          numoth;
-        __u16          numoth_rcv;
-        __u16          numdat_rcv;
-        __u16          ackxmt_dat;
-        __u16          ackxmt_oth;
-        __u16          ackrcv_dat;
-        __u16          ackrcv_oth;
-        __u8           flowrem_sw;
-	__u8           flowloc_sw;
-#define DN_SEND         2
-#define DN_DONTSEND     1
-#define DN_NOCHANGE     0
-	__u16		flowrem_dat;
-	__u16		flowrem_oth;
-	__u16		flowloc_dat;
-	__u16		flowloc_oth;
-	__u8		services_rem;
-	__u8		services_loc;
-	__u8		info_rem;
-	__u8		info_loc;
-
-	__u16		segsize_rem;
-	__u16		segsize_loc;
-
-	__u8		nonagle;
-	__u8		multi_ireq;
-	__u8		accept_mode;
-	unsigned long		seg_total; /* Running total of current segment */
-
-	struct optdata_dn     conndata_in;
-	struct optdata_dn     conndata_out;
-	struct optdata_dn     discdata_in;
-	struct optdata_dn     discdata_out;
-        struct accessdata_dn  accessdata;
-
-        struct sockaddr_dn addr; /* Local address  */
-	struct sockaddr_dn peer; /* Remote address */
-
-	/*
-	 * In this case the RTT estimation is not specified in the
-	 * docs, nor is any back off algorithm. Here we follow well
-	 * known tcp algorithms with a few small variations.
-	 *
-	 * snd_window: Max number of packets we send before we wait for
-	 *             an ack to come back. This will become part of a
-	 *             more complicated scheme when we support flow
-	 *             control.
-	 *
-	 * nsp_srtt:   Round-Trip-Time (x8) in jiffies. This is a rolling
-	 *             average.
-	 * nsp_rttvar: Round-Trip-Time-Varience (x4) in jiffies. This is the
-	 *             varience of the smoothed average (but calculated in
-	 *             a simpler way than for normal statistical varience
-	 *             calculations).
-	 *
-	 * nsp_rxtshift: Backoff counter. Value is zero normally, each time
-	 *               a packet is lost is increases by one until an ack
-	 *               is received. Its used to index an array of backoff
-	 *               multipliers.
-	 */
-#define NSP_MIN_WINDOW 1
-#define NSP_MAX_WINDOW (0x07fe)
-	unsigned long max_window;
-	unsigned long snd_window;
-#define NSP_INITIAL_SRTT (HZ)
-	unsigned long nsp_srtt;
-#define NSP_INITIAL_RTTVAR (HZ*3)
-	unsigned long nsp_rttvar;
-#define NSP_MAXRXTSHIFT 12
-	unsigned long nsp_rxtshift;
-
-	/*
-	 * Output queues, one for data, one for otherdata/linkservice
-	 */
-	struct sk_buff_head data_xmit_queue;
-	struct sk_buff_head other_xmit_queue;
-
-	/*
-	 * Input queue for other data
-	 */
-	struct sk_buff_head other_receive_queue;
-	int other_report;
-
-	/*
-	 * Stuff to do with the slow timer
-	 */
-	unsigned long stamp;          /* time of last transmit */
-	unsigned long persist;
-	int (*persist_fxn)(struct sock *sk);
-	unsigned long keepalive;
-	void (*keepalive_fxn)(struct sock *sk);
-
-};
-
-static inline struct dn_scp *DN_SK(struct sock *sk)
-{
-	return (struct dn_scp *)(sk + 1);
-}
-
-/*
- * src,dst : Source and Destination DECnet addresses
- * hops : Number of hops through the network
- * dst_port, src_port : NSP port numbers
- * services, info : Useful data extracted from conninit messages
- * rt_flags : Routing flags byte
- * nsp_flags : NSP layer flags byte
- * segsize : Size of segment
- * segnum : Number, for data, otherdata and linkservice
- * xmit_count : Number of times we've transmitted this skb
- * stamp : Time stamp of most recent transmission, used in RTT calculations
- * iif: Input interface number
- *
- * As a general policy, this structure keeps all addresses in network
- * byte order, and all else in host byte order. Thus dst, src, dst_port
- * and src_port are in network order. All else is in host order.
- * 
- */
-#define DN_SKB_CB(skb) ((struct dn_skb_cb *)(skb)->cb)
-struct dn_skb_cb {
-	__le16 dst;
-	__le16 src;
-	__u16 hops;
-	__le16 dst_port;
-	__le16 src_port;
-	__u8 services;
-	__u8 info;
-	__u8 rt_flags;
-	__u8 nsp_flags;
-	__u16 segsize;
-	__u16 segnum;
-	__u16 xmit_count;
-	unsigned long stamp;
-	int iif;
-};
-
-static inline __le16 dn_eth2dn(unsigned char *ethaddr)
-{
-	return get_unaligned((__le16 *)(ethaddr + 4));
-}
-
-static inline __le16 dn_saddr2dn(struct sockaddr_dn *saddr)
-{
-	return *(__le16 *)saddr->sdn_nodeaddr;
-}
-
-static inline void dn_dn2eth(unsigned char *ethaddr, __le16 addr)
-{
-	__u16 a = le16_to_cpu(addr);
-	ethaddr[0] = 0xAA;
-	ethaddr[1] = 0x00;
-	ethaddr[2] = 0x04;
-	ethaddr[3] = 0x00;
-	ethaddr[4] = (__u8)(a & 0xff);
-	ethaddr[5] = (__u8)(a >> 8);
-}
-
-static inline void dn_sk_ports_copy(struct flowidn *fld, struct dn_scp *scp)
-{
-	fld->fld_sport = scp->addrloc;
-	fld->fld_dport = scp->addrrem;
-}
-
-unsigned int dn_mss_from_pmtu(struct net_device *dev, int mtu);
-void dn_register_sysctl(void);
-void dn_unregister_sysctl(void);
-
-#define DN_MENUVER_ACC 0x01
-#define DN_MENUVER_USR 0x02
-#define DN_MENUVER_PRX 0x04
-#define DN_MENUVER_UIC 0x08
-
-struct sock *dn_sklist_find_listener(struct sockaddr_dn *addr);
-struct sock *dn_find_by_skb(struct sk_buff *skb);
-#define DN_ASCBUF_LEN 9
-char *dn_addr2asc(__u16, char *);
-int dn_destroy_timer(struct sock *sk);
-
-int dn_sockaddr2username(struct sockaddr_dn *addr, unsigned char *buf,
-			 unsigned char type);
-int dn_username2sockaddr(unsigned char *data, int len, struct sockaddr_dn *addr,
-			 unsigned char *type);
-
-void dn_start_slow_timer(struct sock *sk);
-void dn_stop_slow_timer(struct sock *sk);
-
-extern __le16 decnet_address;
-extern int decnet_debug_level;
-extern int decnet_time_wait;
-extern int decnet_dn_count;
-extern int decnet_di_count;
-extern int decnet_dr_count;
-extern int decnet_no_fc_max_cwnd;
-
-extern long sysctl_decnet_mem[3];
-extern int sysctl_decnet_wmem[3];
-extern int sysctl_decnet_rmem[3];
-
-#endif /* _NET_DN_H */
diff --git a/include/net/dn_dev.h b/include/net/dn_dev.h
deleted file mode 100644
index 595b4f6c1eb1..000000000000
--- a/include/net/dn_dev.h
+++ /dev/null
@@ -1,199 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _NET_DN_DEV_H
-#define _NET_DN_DEV_H
-
-
-struct dn_dev;
-
-struct dn_ifaddr {
-	struct dn_ifaddr __rcu *ifa_next;
-	struct dn_dev    *ifa_dev;
-	__le16            ifa_local;
-	__le16            ifa_address;
-	__u32             ifa_flags;
-	__u8              ifa_scope;
-	char              ifa_label[IFNAMSIZ];
-	struct rcu_head   rcu;
-};
-
-#define DN_DEV_S_RU  0 /* Run - working normally   */
-#define DN_DEV_S_CR  1 /* Circuit Rejected         */
-#define DN_DEV_S_DS  2 /* Data Link Start          */
-#define DN_DEV_S_RI  3 /* Routing Layer Initialize */
-#define DN_DEV_S_RV  4 /* Routing Layer Verify     */
-#define DN_DEV_S_RC  5 /* Routing Layer Complete   */
-#define DN_DEV_S_OF  6 /* Off                      */
-#define DN_DEV_S_HA  7 /* Halt                     */
-
-
-/*
- * The dn_dev_parms structure contains the set of parameters
- * for each device (hence inclusion in the dn_dev structure)
- * and an array is used to store the default types of supported
- * device (in dn_dev.c).
- *
- * The type field matches the ARPHRD_ constants and is used in
- * searching the list for supported devices when new devices
- * come up.
- *
- * The mode field is used to find out if a device is broadcast,
- * multipoint, or pointopoint. Please note that DECnet thinks
- * different ways about devices to the rest of the kernel
- * so the normal IFF_xxx flags are invalid here. For devices
- * which can be any combination of the previously mentioned
- * attributes, you can set this on a per device basis by
- * installing an up() routine.
- *
- * The device state field, defines the initial state in which the
- * device will come up. In the dn_dev structure, it is the actual
- * state.
- *
- * Things have changed here. I've killed timer1 since it's a user space
- * issue for a user space routing deamon to sort out. The kernel does
- * not need to be bothered with it.
- *
- * Timers:
- * t2 - Rate limit timer, min time between routing and hello messages
- * t3 - Hello timer, send hello messages when it expires
- *
- * Callbacks:
- * up() - Called to initialize device, return value can veto use of
- *        device with DECnet.
- * down() - Called to turn device off when it goes down
- * timer3() - Called once for each ifaddr when timer 3 goes off
- * 
- * sysctl - Hook for sysctl things
- *
- */
-struct dn_dev_parms {
-	int type;	          /* ARPHRD_xxx                         */
-	int mode;	          /* Broadcast, Unicast, Mulitpoint     */
-#define DN_DEV_BCAST  1
-#define DN_DEV_UCAST  2
-#define DN_DEV_MPOINT 4
-	int state;                /* Initial state                      */
-	int forwarding;	          /* 0=EndNode, 1=L1Router, 2=L2Router  */
-	unsigned long t2;         /* Default value of t2                */
-	unsigned long t3;         /* Default value of t3                */
-	int priority;             /* Priority to be a router            */
-	char *name;               /* Name for sysctl                    */
-	int  (*up)(struct net_device *);
-	void (*down)(struct net_device *);
-	void (*timer3)(struct net_device *, struct dn_ifaddr *ifa);
-	void *sysctl;
-};
-
-
-struct dn_dev {
-	struct dn_ifaddr __rcu *ifa_list;
-	struct net_device *dev;
-	struct dn_dev_parms parms;
-	char use_long;
-	struct timer_list timer;
-	unsigned long t3;
-	struct neigh_parms *neigh_parms;
-	__u8 addr[ETH_ALEN];
-	struct neighbour *router; /* Default router on circuit */
-	struct neighbour *peer;   /* Peer on pointopoint links */
-	unsigned long uptime;     /* Time device went up in jiffies */
-};
-
-struct dn_short_packet {
-	__u8    msgflg;
-	__le16 dstnode;
-	__le16 srcnode;
-	__u8   forward;
-} __packed;
-
-struct dn_long_packet {
-	__u8   msgflg;
-	__u8   d_area;
-	__u8   d_subarea;
-	__u8   d_id[6];
-	__u8   s_area;
-	__u8   s_subarea;
-	__u8   s_id[6];
-	__u8   nl2;
-	__u8   visit_ct;
-	__u8   s_class;
-	__u8   pt;
-} __packed;
-
-/*------------------------- DRP - Routing messages ---------------------*/
-
-struct endnode_hello_message {
-	__u8   msgflg;
-	__u8   tiver[3];
-	__u8   id[6];
-	__u8   iinfo;
-	__le16 blksize;
-	__u8   area;
-	__u8   seed[8];
-	__u8   neighbor[6];
-	__le16 timer;
-	__u8   mpd;
-	__u8   datalen;
-	__u8   data[2];
-} __packed;
-
-struct rtnode_hello_message {
-	__u8   msgflg;
-	__u8   tiver[3];
-	__u8   id[6];
-	__u8   iinfo;
-	__le16  blksize;
-	__u8   priority;
-	__u8   area;
-	__le16  timer;
-	__u8   mpd;
-} __packed;
-
-
-void dn_dev_init(void);
-void dn_dev_cleanup(void);
-
-int dn_dev_ioctl(unsigned int cmd, void __user *arg);
-
-void dn_dev_devices_off(void);
-void dn_dev_devices_on(void);
-
-void dn_dev_init_pkt(struct sk_buff *skb);
-void dn_dev_veri_pkt(struct sk_buff *skb);
-void dn_dev_hello(struct sk_buff *skb);
-
-void dn_dev_up(struct net_device *);
-void dn_dev_down(struct net_device *);
-
-int dn_dev_set_default(struct net_device *dev, int force);
-struct net_device *dn_dev_get_default(void);
-int dn_dev_bind_default(__le16 *addr);
-
-int register_dnaddr_notifier(struct notifier_block *nb);
-int unregister_dnaddr_notifier(struct notifier_block *nb);
-
-static inline int dn_dev_islocal(struct net_device *dev, __le16 addr)
-{
-	struct dn_dev *dn_db;
-	struct dn_ifaddr *ifa;
-	int res = 0;
-
-	rcu_read_lock();
-	dn_db = rcu_dereference(dev->dn_ptr);
-	if (dn_db == NULL) {
-		printk(KERN_DEBUG "dn_dev_islocal: Called for non DECnet device\n");
-		goto out;
-	}
-
-	for (ifa = rcu_dereference(dn_db->ifa_list);
-	     ifa != NULL;
-	     ifa = rcu_dereference(ifa->ifa_next))
-		if ((addr ^ ifa->ifa_local) == 0) {
-			res = 1;
-			break;
-		}
-out:
-	rcu_read_unlock();
-	return res;
-}
-
-#endif /* _NET_DN_DEV_H */
diff --git a/include/net/dn_fib.h b/include/net/dn_fib.h
deleted file mode 100644
index ccc6e9df178b..000000000000
--- a/include/net/dn_fib.h
+++ /dev/null
@@ -1,167 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _NET_DN_FIB_H
-#define _NET_DN_FIB_H
-
-#include <linux/netlink.h>
-#include <linux/refcount.h>
-
-extern const struct nla_policy rtm_dn_policy[];
-
-struct dn_fib_res {
-	struct fib_rule *r;
-	struct dn_fib_info *fi;
-	unsigned char prefixlen;
-	unsigned char nh_sel;
-	unsigned char type;
-	unsigned char scope;
-};
-
-struct dn_fib_nh {
-	struct net_device	*nh_dev;
-	unsigned int		nh_flags;
-	unsigned char		nh_scope;
-	int			nh_weight;
-	int			nh_power;
-	int			nh_oif;
-	__le16			nh_gw;
-};
-
-struct dn_fib_info {
-	struct dn_fib_info	*fib_next;
-	struct dn_fib_info	*fib_prev;
-	int 			fib_treeref;
-	refcount_t		fib_clntref;
-	int			fib_dead;
-	unsigned int		fib_flags;
-	int			fib_protocol;
-	__le16			fib_prefsrc;
-	__u32			fib_priority;
-	__u32			fib_metrics[RTAX_MAX];
-	int			fib_nhs;
-	int			fib_power;
-	struct dn_fib_nh	fib_nh[0];
-#define dn_fib_dev		fib_nh[0].nh_dev
-};
-
-
-#define DN_FIB_RES_RESET(res)	((res).nh_sel = 0)
-#define DN_FIB_RES_NH(res)	((res).fi->fib_nh[(res).nh_sel])
-
-#define DN_FIB_RES_PREFSRC(res)	((res).fi->fib_prefsrc ? : __dn_fib_res_prefsrc(&res))
-#define DN_FIB_RES_GW(res)	(DN_FIB_RES_NH(res).nh_gw)
-#define DN_FIB_RES_DEV(res)	(DN_FIB_RES_NH(res).nh_dev)
-#define DN_FIB_RES_OIF(res)	(DN_FIB_RES_NH(res).nh_oif)
-
-typedef struct {
-	__le16	datum;
-} dn_fib_key_t;
-
-typedef struct {
-	__le16	datum;
-} dn_fib_hash_t;
-
-typedef struct {
-	__u16	datum;
-} dn_fib_idx_t;
-
-struct dn_fib_node {
-	struct dn_fib_node *fn_next;
-	struct dn_fib_info *fn_info;
-#define DN_FIB_INFO(f) ((f)->fn_info)
-	dn_fib_key_t	fn_key;
-	u8		fn_type;
-	u8		fn_scope;
-	u8		fn_state;
-};
-
-
-struct dn_fib_table {
-	struct hlist_node hlist;
-	u32 n;
-
-	int (*insert)(struct dn_fib_table *t, struct rtmsg *r, 
-			struct nlattr *attrs[], struct nlmsghdr *n,
-			struct netlink_skb_parms *req);
-	int (*delete)(struct dn_fib_table *t, struct rtmsg *r,
-			struct nlattr *attrs[], struct nlmsghdr *n,
-			struct netlink_skb_parms *req);
-	int (*lookup)(struct dn_fib_table *t, const struct flowidn *fld,
-			struct dn_fib_res *res);
-	int (*flush)(struct dn_fib_table *t);
-	int (*dump)(struct dn_fib_table *t, struct sk_buff *skb, struct netlink_callback *cb);
-
-	unsigned char data[];
-};
-
-#ifdef CONFIG_DECNET_ROUTER
-/*
- * dn_fib.c
- */
-void dn_fib_init(void);
-void dn_fib_cleanup(void);
-
-int dn_fib_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
-struct dn_fib_info *dn_fib_create_info(const struct rtmsg *r,
-				       struct nlattr *attrs[],
-				       const struct nlmsghdr *nlh, int *errp);
-int dn_fib_semantic_match(int type, struct dn_fib_info *fi,
-			  const struct flowidn *fld, struct dn_fib_res *res);
-void dn_fib_release_info(struct dn_fib_info *fi);
-void dn_fib_flush(void);
-void dn_fib_select_multipath(const struct flowidn *fld, struct dn_fib_res *res);
-
-/*
- * dn_tables.c
- */
-struct dn_fib_table *dn_fib_get_table(u32 n, int creat);
-struct dn_fib_table *dn_fib_empty_table(void);
-void dn_fib_table_init(void);
-void dn_fib_table_cleanup(void);
-
-/*
- * dn_rules.c
- */
-void dn_fib_rules_init(void);
-void dn_fib_rules_cleanup(void);
-unsigned int dnet_addr_type(__le16 addr);
-int dn_fib_lookup(struct flowidn *fld, struct dn_fib_res *res);
-
-int dn_fib_dump(struct sk_buff *skb, struct netlink_callback *cb);
-
-void dn_fib_free_info(struct dn_fib_info *fi);
-
-static inline void dn_fib_info_put(struct dn_fib_info *fi)
-{
-	if (refcount_dec_and_test(&fi->fib_clntref))
-		dn_fib_free_info(fi);
-}
-
-static inline void dn_fib_res_put(struct dn_fib_res *res)
-{
-	if (res->fi)
-		dn_fib_info_put(res->fi);
-	if (res->r)
-		fib_rule_put(res->r);
-}
-
-#else /* Endnode */
-
-#define dn_fib_init()  do { } while(0)
-#define dn_fib_cleanup() do { } while(0)
-
-#define dn_fib_lookup(fl, res) (-ESRCH)
-#define dn_fib_info_put(fi) do { } while(0)
-#define dn_fib_select_multipath(fl, res) do { } while(0)
-#define dn_fib_rules_policy(saddr,res,flags) (0)
-#define dn_fib_res_put(res) do { } while(0)
-
-#endif /* CONFIG_DECNET_ROUTER */
-
-static inline __le16 dnet_make_mask(int n)
-{
-	if (n)
-		return cpu_to_le16(~((1 << (16 - n)) - 1));
-	return cpu_to_le16(0);
-}
-
-#endif /* _NET_DN_FIB_H */
diff --git a/include/net/dn_neigh.h b/include/net/dn_neigh.h
deleted file mode 100644
index 2e3e7793973a..000000000000
--- a/include/net/dn_neigh.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _NET_DN_NEIGH_H
-#define _NET_DN_NEIGH_H
-
-/*
- * The position of the first two fields of
- * this structure are critical - SJW
- */
-struct dn_neigh {
-        struct neighbour n;
-	__le16 addr;
-        unsigned long flags;
-#define DN_NDFLAG_R1    0x0001 /* Router L1      */
-#define DN_NDFLAG_R2    0x0002 /* Router L2      */
-#define DN_NDFLAG_P3    0x0004 /* Phase III Node */
-        unsigned long blksize;
-	__u8 priority;
-};
-
-void dn_neigh_init(void);
-void dn_neigh_cleanup(void);
-int dn_neigh_router_hello(struct net *net, struct sock *sk, struct sk_buff *skb);
-int dn_neigh_endnode_hello(struct net *net, struct sock *sk, struct sk_buff *skb);
-void dn_neigh_pointopoint_hello(struct sk_buff *skb);
-int dn_neigh_elist(struct net_device *dev, unsigned char *ptr, int n);
-int dn_to_neigh_output(struct net *net, struct sock *sk, struct sk_buff *skb);
-
-extern struct neigh_table dn_neigh_table;
-
-#endif /* _NET_DN_NEIGH_H */
diff --git a/include/net/dn_nsp.h b/include/net/dn_nsp.h
deleted file mode 100644
index f83932b864a9..000000000000
--- a/include/net/dn_nsp.h
+++ /dev/null
@@ -1,195 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _NET_DN_NSP_H
-#define _NET_DN_NSP_H
-/******************************************************************************
-    (c) 1995-1998 E.M. Serrat		emserrat@geocities.com
-    
-*******************************************************************************/
-/* dn_nsp.c functions prototyping */
-
-void dn_nsp_send_data_ack(struct sock *sk);
-void dn_nsp_send_oth_ack(struct sock *sk);
-void dn_send_conn_ack(struct sock *sk);
-void dn_send_conn_conf(struct sock *sk, gfp_t gfp);
-void dn_nsp_send_disc(struct sock *sk, unsigned char type,
-		      unsigned short reason, gfp_t gfp);
-void dn_nsp_return_disc(struct sk_buff *skb, unsigned char type,
-			unsigned short reason);
-void dn_nsp_send_link(struct sock *sk, unsigned char lsflags, char fcval);
-void dn_nsp_send_conninit(struct sock *sk, unsigned char flags);
-
-void dn_nsp_output(struct sock *sk);
-int dn_nsp_check_xmit_queue(struct sock *sk, struct sk_buff *skb,
-			    struct sk_buff_head *q, unsigned short acknum);
-void dn_nsp_queue_xmit(struct sock *sk, struct sk_buff *skb, gfp_t gfp,
-		       int oob);
-unsigned long dn_nsp_persist(struct sock *sk);
-int dn_nsp_xmit_timeout(struct sock *sk);
-
-int dn_nsp_rx(struct sk_buff *);
-int dn_nsp_backlog_rcv(struct sock *sk, struct sk_buff *skb);
-
-struct sk_buff *dn_alloc_skb(struct sock *sk, int size, gfp_t pri);
-struct sk_buff *dn_alloc_send_skb(struct sock *sk, size_t *size, int noblock,
-				  long timeo, int *err);
-
-#define NSP_REASON_OK 0		/* No error */
-#define NSP_REASON_NR 1		/* No resources */
-#define NSP_REASON_UN 2		/* Unrecognised node name */
-#define NSP_REASON_SD 3		/* Node shutting down */
-#define NSP_REASON_ID 4		/* Invalid destination end user */
-#define NSP_REASON_ER 5		/* End user lacks resources */
-#define NSP_REASON_OB 6		/* Object too busy */
-#define NSP_REASON_US 7		/* Unspecified error */
-#define NSP_REASON_TP 8		/* Third-Party abort */
-#define NSP_REASON_EA 9		/* End user has aborted the link */
-#define NSP_REASON_IF 10	/* Invalid node name format */
-#define NSP_REASON_LS 11	/* Local node shutdown */
-#define NSP_REASON_LL 32	/* Node lacks logical-link resources */
-#define NSP_REASON_LE 33	/* End user lacks logical-link resources */
-#define NSP_REASON_UR 34	/* Unacceptable RQSTRID or PASSWORD field */
-#define NSP_REASON_UA 36	/* Unacceptable ACCOUNT field */
-#define NSP_REASON_TM 38	/* End user timed out logical link */
-#define NSP_REASON_NU 39	/* Node unreachable */
-#define NSP_REASON_NL 41	/* No-link message */
-#define NSP_REASON_DC 42	/* Disconnect confirm */
-#define NSP_REASON_IO 43	/* Image data field overflow */
-
-#define NSP_DISCINIT 0x38
-#define NSP_DISCCONF 0x48
-
-/*------------------------- NSP - messages ------------------------------*/
-/* Data Messages */
-/*---------------*/
-
-/* Data Messages    (data segment/interrupt/link service)               */
-
-struct nsp_data_seg_msg {
-	__u8   msgflg;
-	__le16 dstaddr;
-	__le16 srcaddr;
-} __packed;
-
-struct nsp_data_opt_msg {
-	__le16 acknum;
-	__le16 segnum;
-	__le16 lsflgs;
-} __packed;
-
-struct nsp_data_opt_msg1 {
-	__le16 acknum;
-	__le16 segnum;
-} __packed;
-
-
-/* Acknowledgment Message (data/other data)                             */
-struct nsp_data_ack_msg {
-	__u8   msgflg;
-	__le16 dstaddr;
-	__le16 srcaddr;
-	__le16 acknum;
-} __packed;
-
-/* Connect Acknowledgment Message */
-struct  nsp_conn_ack_msg {
-	__u8 msgflg;
-	__le16 dstaddr;
-} __packed;
-
-
-/* Connect Initiate/Retransmit Initiate/Connect Confirm */
-struct  nsp_conn_init_msg {
-	__u8   msgflg;
-#define NSP_CI      0x18            /* Connect Initiate     */
-#define NSP_RCI     0x68            /* Retrans. Conn Init   */
-	__le16 dstaddr;
-	__le16 srcaddr;
-	__u8   services;
-#define NSP_FC_NONE   0x00            /* Flow Control None    */
-#define NSP_FC_SRC    0x04            /* Seg Req. Count       */
-#define NSP_FC_SCMC   0x08            /* Sess. Control Mess   */
-#define NSP_FC_MASK   0x0c            /* FC type mask         */
-	__u8   info;
-	__le16 segsize;
-} __packed;
-
-/* Disconnect Initiate/Disconnect Confirm */
-struct  nsp_disconn_init_msg {
-	__u8   msgflg;
-	__le16 dstaddr;
-	__le16 srcaddr;
-	__le16 reason;
-} __packed;
-
-
-
-struct  srcobj_fmt {
-	__u8   format;
-	__u8   task;
-	__le16 grpcode;
-	__le16 usrcode;
-	__u8   dlen;
-} __packed;
-
-/*
- * A collection of functions for manipulating the sequence
- * numbers used in NSP. Similar in operation to the functions
- * of the same name in TCP.
- */
-static __inline__ int dn_before(__u16 seq1, __u16 seq2)
-{
-        seq1 &= 0x0fff;
-        seq2 &= 0x0fff;
-
-        return (int)((seq1 - seq2) & 0x0fff) > 2048;
-}
-
-
-static __inline__ int dn_after(__u16 seq1, __u16 seq2)
-{
-        seq1 &= 0x0fff;
-        seq2 &= 0x0fff;
-
-        return (int)((seq2 - seq1) & 0x0fff) > 2048;
-}
-
-static __inline__ int dn_equal(__u16 seq1, __u16 seq2)
-{
-        return ((seq1 ^ seq2) & 0x0fff) == 0;
-}
-
-static __inline__ int dn_before_or_equal(__u16 seq1, __u16 seq2)
-{
-	return (dn_before(seq1, seq2) || dn_equal(seq1, seq2));
-}
-
-static __inline__ void seq_add(__u16 *seq, __u16 off)
-{
-        (*seq) += off;
-        (*seq) &= 0x0fff;
-}
-
-static __inline__ int seq_next(__u16 seq1, __u16 seq2)
-{
-	return dn_equal(seq1 + 1, seq2);
-}
-
-/*
- * Can we delay the ack ?
- */
-static __inline__ int sendack(__u16 seq)
-{
-        return (int)((seq & 0x1000) ? 0 : 1);
-}
-
-/*
- * Is socket congested ?
- */
-static __inline__ int dn_congested(struct sock *sk)
-{
-        return atomic_read(&sk->sk_rmem_alloc) > (sk->sk_rcvbuf >> 1);
-}
-
-#define DN_MAX_NSP_DATA_HEADER (11)
-
-#endif /* _NET_DN_NSP_H */
diff --git a/include/net/dn_route.h b/include/net/dn_route.h
deleted file mode 100644
index 6f1e94ac0bdf..000000000000
--- a/include/net/dn_route.h
+++ /dev/null
@@ -1,115 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _NET_DN_ROUTE_H
-#define _NET_DN_ROUTE_H
-
-/******************************************************************************
-    (c) 1995-1998 E.M. Serrat		emserrat@geocities.com
-    
-*******************************************************************************/
-
-struct sk_buff *dn_alloc_skb(struct sock *sk, int size, gfp_t pri);
-int dn_route_output_sock(struct dst_entry __rcu **pprt, struct flowidn *,
-			 struct sock *sk, int flags);
-int dn_cache_dump(struct sk_buff *skb, struct netlink_callback *cb);
-void dn_rt_cache_flush(int delay);
-int dn_route_rcv(struct sk_buff *skb, struct net_device *dev,
-		 struct packet_type *pt, struct net_device *orig_dev);
-
-/* Masks for flags field */
-#define DN_RT_F_PID 0x07 /* Mask for packet type                      */
-#define DN_RT_F_PF  0x80 /* Padding Follows                           */
-#define DN_RT_F_VER 0x40 /* Version =0 discard packet if ==1          */
-#define DN_RT_F_IE  0x20 /* Intra Ethernet, Reserved in short pkt     */
-#define DN_RT_F_RTS 0x10 /* Packet is being returned to sender        */
-#define DN_RT_F_RQR 0x08 /* Return packet to sender upon non-delivery */
-
-/* Mask for types of routing packets */
-#define DN_RT_PKT_MSK   0x06
-/* Types of routing packets */
-#define DN_RT_PKT_SHORT 0x02 /* Short routing packet */
-#define DN_RT_PKT_LONG  0x06 /* Long routing packet  */
-
-/* Mask for control/routing selection */
-#define DN_RT_PKT_CNTL  0x01 /* Set to 1 if a control packet  */
-/* Types of control packets */
-#define DN_RT_CNTL_MSK  0x0f /* Mask for control packets      */
-#define DN_RT_PKT_INIT  0x01 /* Initialisation packet         */
-#define DN_RT_PKT_VERI  0x03 /* Verification Message          */
-#define DN_RT_PKT_HELO  0x05 /* Hello and Test Message        */
-#define DN_RT_PKT_L1RT  0x07 /* Level 1 Routing Message       */
-#define DN_RT_PKT_L2RT  0x09 /* Level 2 Routing Message       */
-#define DN_RT_PKT_ERTH  0x0b /* Ethernet Router Hello         */
-#define DN_RT_PKT_EEDH  0x0d /* Ethernet EndNode Hello        */
-
-/* Values for info field in hello message */
-#define DN_RT_INFO_TYPE 0x03 /* Type mask                     */
-#define DN_RT_INFO_L1RT 0x02 /* L1 Router                     */
-#define DN_RT_INFO_L2RT 0x01 /* L2 Router                     */
-#define DN_RT_INFO_ENDN 0x03 /* EndNode                       */
-#define DN_RT_INFO_VERI 0x04 /* Verification Reqd.            */
-#define DN_RT_INFO_RJCT 0x08 /* Reject Flag, Reserved         */
-#define DN_RT_INFO_VFLD 0x10 /* Verification Failed, Reserved */
-#define DN_RT_INFO_NOML 0x20 /* No Multicast traffic accepted */
-#define DN_RT_INFO_BLKR 0x40 /* Blocking Requested            */
-
-/*
- * The fl structure is what we used to look up the route.
- * The rt_saddr & rt_daddr entries are the same as key.saddr & key.daddr
- * except for local input routes, where the rt_saddr = fl.fld_dst and
- * rt_daddr = fl.fld_src to allow the route to be used for returning
- * packets to the originating host.
- */
-struct dn_route {
-	struct dst_entry dst;
-	struct dn_route __rcu *dn_next;
-
-	struct neighbour *n;
-
-	struct flowidn fld;
-
-	__le16 rt_saddr;
-	__le16 rt_daddr;
-	__le16 rt_gateway;
-	__le16 rt_local_src;	/* Source used for forwarding packets */
-	__le16 rt_src_map;
-	__le16 rt_dst_map;
-
-	unsigned int rt_flags;
-	unsigned int rt_type;
-};
-
-static inline bool dn_is_input_route(struct dn_route *rt)
-{
-	return rt->fld.flowidn_iif != 0;
-}
-
-static inline bool dn_is_output_route(struct dn_route *rt)
-{
-	return rt->fld.flowidn_iif == 0;
-}
-
-void dn_route_init(void);
-void dn_route_cleanup(void);
-
-#include <net/sock.h>
-#include <linux/if_arp.h>
-
-static inline void dn_rt_send(struct sk_buff *skb)
-{
-	dev_queue_xmit(skb);
-}
-
-static inline void dn_rt_finish_output(struct sk_buff *skb, char *dst, char *src)
-{
-	struct net_device *dev = skb->dev;
-
-	if ((dev->type != ARPHRD_ETHER) && (dev->type != ARPHRD_LOOPBACK))
-		dst = NULL;
-
-	if (dev_hard_header(skb, dev, ETH_P_DNA_RT, dst, src, skb->len) >= 0)
-		dn_rt_send(skb);
-	else
-		kfree_skb(skb);
-}
-
-#endif /* _NET_DN_ROUTE_H */
diff --git a/include/net/dst.h b/include/net/dst.h
index ae2cf57d796b..48e613420b95 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -235,12 +235,6 @@ static inline void dst_use_noref(struct dst_entry *dst, unsigned long time)
 	}
 }
 
-static inline void dst_hold_and_use(struct dst_entry *dst, unsigned long time)
-{
-	dst_hold(dst);
-	dst_use_noref(dst, time);
-}
-
 static inline struct dst_entry *dst_clone(struct dst_entry *dst)
 {
 	if (dst)
diff --git a/include/net/flow.h b/include/net/flow.h
index 39d0cedcddee..236d0941c69f 100644
--- a/include/net/flow.h
+++ b/include/net/flow.h
@@ -54,11 +54,6 @@ union flowi_uli {
 		__u8	code;
 	} icmpt;
 
-	struct {
-		__le16	dport;
-		__le16	sport;
-	} dnports;
-
 	__be32		spi;
 	__be32		gre_key;
 
@@ -156,27 +151,11 @@ struct flowi6 {
 	__u32			mp_hash;
 } __attribute__((__aligned__(BITS_PER_LONG/8)));
 
-struct flowidn {
-	struct flowi_common	__fl_common;
-#define flowidn_oif		__fl_common.flowic_oif
-#define flowidn_iif		__fl_common.flowic_iif
-#define flowidn_mark		__fl_common.flowic_mark
-#define flowidn_scope		__fl_common.flowic_scope
-#define flowidn_proto		__fl_common.flowic_proto
-#define flowidn_flags		__fl_common.flowic_flags
-	__le16			daddr;
-	__le16			saddr;
-	union flowi_uli		uli;
-#define fld_sport		uli.ports.sport
-#define fld_dport		uli.ports.dport
-} __attribute__((__aligned__(BITS_PER_LONG/8)));
-
 struct flowi {
 	union {
 		struct flowi_common	__fl_common;
 		struct flowi4		ip4;
 		struct flowi6		ip6;
-		struct flowidn		dn;
 	} u;
 #define flowi_oif	u.__fl_common.flowic_oif
 #define flowi_iif	u.__fl_common.flowic_iif
@@ -210,11 +189,6 @@ static inline struct flowi_common *flowi6_to_flowi_common(struct flowi6 *fl6)
 	return &(flowi6_to_flowi(fl6)->u.__fl_common);
 }
 
-static inline struct flowi *flowidn_to_flowi(struct flowidn *fldn)
-{
-	return container_of(fldn, struct flowi, u.dn);
-}
-
 __u32 __get_hash_from_flowi6(const struct flowi6 *fl6, struct flow_keys *keys);
 
 #endif
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index abb22cfd4827..0e9d33e4439e 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -260,11 +260,6 @@ static inline void *neighbour_priv(const struct neighbour *n)
 
 extern const struct nla_policy nda_policy[];
 
-static inline bool neigh_key_eq16(const struct neighbour *n, const void *pkey)
-{
-	return *(const u16 *)n->primary_key == *(const u16 *)pkey;
-}
-
 static inline bool neigh_key_eq32(const struct neighbour *n, const void *pkey)
 {
 	return *(const u32 *)n->primary_key == *(const u32 *)pkey;
@@ -314,8 +309,6 @@ void neigh_table_init(int index, struct neigh_table *tbl);
 int neigh_table_clear(int index, struct neigh_table *tbl);
 struct neighbour *neigh_lookup(struct neigh_table *tbl, const void *pkey,
 			       struct net_device *dev);
-struct neighbour *neigh_lookup_nodev(struct neigh_table *tbl, struct net *net,
-				     const void *pkey);
 struct neighbour *__neigh_create(struct neigh_table *tbl, const void *pkey,
 				 struct net_device *dev, bool want_ref);
 static inline struct neighbour *neigh_create(struct neigh_table *tbl,
diff --git a/include/net/netns/netfilter.h b/include/net/netns/netfilter.h
index ca043342c0eb..2e57312ac589 100644
--- a/include/net/netns/netfilter.h
+++ b/include/net/netns/netfilter.h
@@ -25,9 +25,6 @@ struct netns_nf {
 #ifdef CONFIG_NETFILTER_FAMILY_BRIDGE
 	struct nf_hook_entries __rcu *hooks_bridge[NF_INET_NUMHOOKS];
 #endif
-#if IS_ENABLED(CONFIG_DECNET)
-	struct nf_hook_entries __rcu *hooks_decnet[NF_DN_NUMHOOKS];
-#endif
 #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
 	bool			defrag_ipv4;
 #endif
diff --git a/include/rdma/ib_addr.h b/include/rdma/ib_addr.h
index b0e636ac6690..8c5c9582c4fb 100644
--- a/include/rdma/ib_addr.h
+++ b/include/rdma/ib_addr.h
@@ -193,29 +193,6 @@ static inline enum ib_mtu iboe_get_mtu(int mtu)
 		return 0;
 }
 
-static inline int iboe_get_rate(struct net_device *dev)
-{
-	struct ethtool_link_ksettings cmd;
-	int err;
-
-	rtnl_lock();
-	err = __ethtool_get_link_ksettings(dev, &cmd);
-	rtnl_unlock();
-	if (err)
-		return IB_RATE_PORT_CURRENT;
-
-	if (cmd.base.speed >= 40000)
-		return IB_RATE_40_GBPS;
-	else if (cmd.base.speed >= 30000)
-		return IB_RATE_30_GBPS;
-	else if (cmd.base.speed >= 20000)
-		return IB_RATE_20_GBPS;
-	else if (cmd.base.speed >= 10000)
-		return IB_RATE_10_GBPS;
-	else
-		return IB_RATE_PORT_CURRENT;
-}
-
 static inline int rdma_link_local_addr(struct in6_addr *addr)
 {
 	if (addr->s6_addr32[0] == htonl(0xfe800000) &&
diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 0f6c50b17bba..bd8795198a7d 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -121,6 +121,10 @@ int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream);
 
+/* can this BE perform prepare */
+int snd_soc_dpcm_can_be_prepared(struct snd_soc_pcm_runtime *fe,
+				 struct snd_soc_pcm_runtime *be, int stream);
+
 /* is the current PCM operation for this FE ? */
 int snd_soc_dpcm_fe_can_update(struct snd_soc_pcm_runtime *fe, int stream);
 
diff --git a/include/uapi/linux/dn.h b/include/uapi/linux/dn.h
deleted file mode 100644
index 36ca71bd8bbe..000000000000
--- a/include/uapi/linux/dn.h
+++ /dev/null
@@ -1,149 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _LINUX_DN_H
-#define _LINUX_DN_H
-
-#include <linux/ioctl.h>
-#include <linux/types.h>
-#include <linux/if_ether.h>
-
-/*
-
-	DECnet Data Structures and Constants
-
-*/
-
-/* 
- * DNPROTO_NSP can't be the same as SOL_SOCKET, 
- * so increment each by one (compared to ULTRIX)
- */
-#define DNPROTO_NSP     2                       /* NSP protocol number       */
-#define DNPROTO_ROU     3                       /* Routing protocol number   */
-#define DNPROTO_NML     4                       /* Net mgt protocol number   */
-#define DNPROTO_EVL     5                       /* Evl protocol number (usr) */
-#define DNPROTO_EVR     6                       /* Evl protocol number (evl) */
-#define DNPROTO_NSPT    7                       /* NSP trace protocol number */
-
-
-#define DN_ADDL		2
-#define DN_MAXADDL	2 /* ULTRIX headers have 20 here, but pathworks has 2 */
-#define DN_MAXOPTL	16
-#define DN_MAXOBJL	16
-#define DN_MAXACCL	40
-#define DN_MAXALIASL	128
-#define DN_MAXNODEL	256
-#define DNBUFSIZE	65023
-
-/* 
- * SET/GET Socket options  - must match the DSO_ numbers below
- */
-#define SO_CONDATA      1
-#define SO_CONACCESS    2
-#define SO_PROXYUSR     3
-#define SO_LINKINFO     7
-
-#define DSO_CONDATA     1        /* Set/Get connect data                */
-#define DSO_DISDATA     10       /* Set/Get disconnect data             */
-#define DSO_CONACCESS   2        /* Set/Get connect access data         */
-#define DSO_ACCEPTMODE  4        /* Set/Get accept mode                 */
-#define DSO_CONACCEPT   5        /* Accept deferred connection          */
-#define DSO_CONREJECT   6        /* Reject deferred connection          */
-#define DSO_LINKINFO    7        /* Set/Get link information            */
-#define DSO_STREAM      8        /* Set socket type to stream           */
-#define DSO_SEQPACKET   9        /* Set socket type to sequenced packet */
-#define DSO_MAXWINDOW   11       /* Maximum window size allowed         */
-#define DSO_NODELAY	12       /* Turn off nagle                      */
-#define DSO_CORK        13       /* Wait for more data!                 */
-#define DSO_SERVICES	14       /* NSP Services field                  */
-#define DSO_INFO	15       /* NSP Info field                      */
-#define DSO_MAX         15       /* Maximum option number               */
-
-
-/* LINK States */
-#define LL_INACTIVE	0
-#define LL_CONNECTING	1
-#define LL_RUNNING	2
-#define LL_DISCONNECTING 3
-
-#define ACC_IMMED 0
-#define ACC_DEFER 1
-
-#define SDF_WILD        1                  /* Wild card object          */
-#define SDF_PROXY       2                  /* Addr eligible for proxy   */
-#define SDF_UICPROXY    4                  /* Use uic-based proxy       */
-
-/* Structures */
-
-
-struct dn_naddr {
-	__le16		a_len;
-	__u8 a_addr[DN_MAXADDL]; /* Two bytes little endian */
-};
-
-struct sockaddr_dn {
-	__u16		sdn_family;
-	__u8		sdn_flags;
-	__u8		sdn_objnum;
-	__le16		sdn_objnamel;
-	__u8		sdn_objname[DN_MAXOBJL];
-	struct   dn_naddr	sdn_add;
-};
-#define sdn_nodeaddrl   sdn_add.a_len   /* Node address length  */
-#define sdn_nodeaddr    sdn_add.a_addr  /* Node address         */
-
-
-
-/*
- * DECnet set/get DSO_CONDATA, DSO_DISDATA (optional data) structure
- */
-struct optdata_dn {
-        __le16  opt_status;     /* Extended status return */
-#define opt_sts opt_status
-        __le16  opt_optl;       /* Length of user data    */
-        __u8   opt_data[16];   /* User data              */
-};
-
-struct accessdata_dn {
-	__u8		acc_accl;
-	__u8		acc_acc[DN_MAXACCL];
-	__u8 		acc_passl;
-	__u8		acc_pass[DN_MAXACCL];
-	__u8 		acc_userl;
-	__u8		acc_user[DN_MAXACCL];
-};
-
-/*
- * DECnet logical link information structure
- */
-struct linkinfo_dn {
-        __u16  idn_segsize;    /* Segment size for link */
-        __u8   idn_linkstate;  /* Logical link state    */
-};
-
-/*
- * Ethernet address format (for DECnet)
- */
-union etheraddress {
-        __u8 dne_addr[ETH_ALEN];      /* Full ethernet address */
-  struct {
-                __u8 dne_hiord[4];    /* DECnet HIORD prefix   */
-                __u8 dne_nodeaddr[2]; /* DECnet node address   */
-  } dne_remote;
-};
-
-
-/*
- * DECnet physical socket address format
- */
-struct dn_addr {
-        __le16 dna_family;      /* AF_DECnet               */
-        union etheraddress dna_netaddr; /* DECnet ethernet address */
-};
-
-#define DECNET_IOCTL_BASE 0x89 /* PROTOPRIVATE range */
-
-#define SIOCSNETADDR  _IOW(DECNET_IOCTL_BASE, 0xe0, struct dn_naddr)
-#define SIOCGNETADDR  _IOR(DECNET_IOCTL_BASE, 0xe1, struct dn_naddr)
-#define OSIOCSNETADDR _IOW(DECNET_IOCTL_BASE, 0xe0, int)
-#define OSIOCGNETADDR _IOR(DECNET_IOCTL_BASE, 0xe1, int)
-
-#endif /* _LINUX_DN_H */
diff --git a/include/uapi/linux/netfilter_decnet.h b/include/uapi/linux/netfilter_decnet.h
deleted file mode 100644
index 3c77f54560f2..000000000000
--- a/include/uapi/linux/netfilter_decnet.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __LINUX_DECNET_NETFILTER_H
-#define __LINUX_DECNET_NETFILTER_H
-
-/* DECnet-specific defines for netfilter. 
- * This file (C) Steve Whitehouse 1999 derived from the
- * ipv4 netfilter header file which is
- * (C)1998 Rusty Russell -- This code is GPL.
- */
-
-#include <linux/netfilter.h>
-
-/* only for userspace compatibility */
-#ifndef __KERNEL__
-
-#include <limits.h> /* for INT_MIN, INT_MAX */
-
-/* kernel define is in netfilter_defs.h */
-#define NF_DN_NUMHOOKS		7
-#endif /* ! __KERNEL__ */
-
-/* DECnet Hooks */
-/* After promisc drops, checksum checks. */
-#define NF_DN_PRE_ROUTING	0
-/* If the packet is destined for this box. */
-#define NF_DN_LOCAL_IN		1
-/* If the packet is destined for another interface. */
-#define NF_DN_FORWARD		2
-/* Packets coming from a local process. */
-#define NF_DN_LOCAL_OUT		3
-/* Packets about to hit the wire. */
-#define NF_DN_POST_ROUTING	4
-/* Input Hello Packets */
-#define NF_DN_HELLO		5
-/* Input Routing Packets */
-#define NF_DN_ROUTE		6
-
-enum nf_dn_hook_priorities {
-	NF_DN_PRI_FIRST = INT_MIN,
-	NF_DN_PRI_CONNTRACK = -200,
-	NF_DN_PRI_MANGLE = -150,
-	NF_DN_PRI_NAT_DST = -100,
-	NF_DN_PRI_FILTER = 0,
-	NF_DN_PRI_NAT_SRC = 100,
-	NF_DN_PRI_DNRTMSG = 200,
-	NF_DN_PRI_LAST = INT_MAX,
-};
-
-struct nf_dn_rtmsg {
-	int nfdn_ifindex;
-};
-
-#define NFDN_RTMSG(r) ((unsigned char *)(r) + NLMSG_ALIGN(sizeof(struct nf_dn_rtmsg)))
-
-#ifndef __KERNEL__
-/* backwards compatibility for userspace */
-#define DNRMG_L1_GROUP 0x01
-#define DNRMG_L2_GROUP 0x02
-#endif
-
-enum {
-	DNRNG_NLGRP_NONE,
-#define DNRNG_NLGRP_NONE	DNRNG_NLGRP_NONE
-	DNRNG_NLGRP_L1,
-#define DNRNG_NLGRP_L1		DNRNG_NLGRP_L1
-	DNRNG_NLGRP_L2,
-#define DNRNG_NLGRP_L2		DNRNG_NLGRP_L2
-	__DNRNG_NLGRP_MAX
-};
-#define DNRNG_NLGRP_MAX	(__DNRNG_NLGRP_MAX - 1)
-
-#endif /*__LINUX_DECNET_NETFILTER_H*/
diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
index 3d94269bbfa8..49751d5fee88 100644
--- a/include/uapi/linux/netlink.h
+++ b/include/uapi/linux/netlink.h
@@ -20,7 +20,7 @@
 #define NETLINK_CONNECTOR	11
 #define NETLINK_NETFILTER	12	/* netfilter subsystem */
 #define NETLINK_IP6_FW		13
-#define NETLINK_DNRTMSG		14	/* DECnet routing messages */
+#define NETLINK_DNRTMSG		14	/* DECnet routing messages (obsolete) */
 #define NETLINK_KOBJECT_UEVENT	15	/* Kernel messages to userspace */
 #define NETLINK_GENERIC		16
 /* leave room for NETLINK_DM (DM Events) */
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index fd799567fc23..58e063114398 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -5966,6 +5966,8 @@ static int io_poll_update(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_kiocb *preq;
 	int ret2, ret = 0;
 
+	io_ring_submit_lock(ctx, !(issue_flags & IO_URING_F_NONBLOCK));
+
 	spin_lock(&ctx->completion_lock);
 	preq = io_poll_find(ctx, req->poll_update.old_user_data, true);
 	if (!preq || !io_poll_disarm(preq)) {
@@ -5997,6 +5999,7 @@ static int io_poll_update(struct io_kiocb *req, unsigned int issue_flags)
 		req_set_fail(req);
 	/* complete update request, we're done with it */
 	io_req_complete(req, ret);
+	io_ring_submit_unlock(ctx, !(issue_flags & IO_URING_F_NONBLOCK));
 	return 0;
 }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 684c16849eff..f123b7f64249 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6138,19 +6138,18 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 static void cgroup_css_set_put_fork(struct kernel_clone_args *kargs)
 	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
 {
+	struct cgroup *cgrp = kargs->cgrp;
+	struct css_set *cset = kargs->cset;
+
 	cgroup_threadgroup_change_end(current);
 
-	if (kargs->flags & CLONE_INTO_CGROUP) {
-		struct cgroup *cgrp = kargs->cgrp;
-		struct css_set *cset = kargs->cset;
+	if (cset) {
+		put_css_set(cset);
+		kargs->cset = NULL;
+	}
 
+	if (kargs->flags & CLONE_INTO_CGROUP) {
 		mutex_unlock(&cgroup_mutex);
-
-		if (cset) {
-			put_css_set(cset);
-			kargs->cset = NULL;
-		}
-
 		if (cgrp) {
 			cgroup_put(cgrp);
 			kargs->cgrp = NULL;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b9c857782ada..804dc508d926 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -910,10 +910,22 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 		}
 
 		offset = ALIGN(offset, align);
+
+		/*
+		 * Check if the segment contains the entry point, if so,
+		 * calculate the value of image->start based on it.
+		 * If the compiler has produced more than one .text section
+		 * (Eg: .text.hot), they are generally after the main .text
+		 * section, and they shall not be used to calculate
+		 * image->start. So do not re-calculate image->start if it
+		 * is not set to the initial value, and warn the user so they
+		 * have a chance to fix their purgatory's linker script.
+		 */
 		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
 		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
 		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
-					 + sechdrs[i].sh_size)) {
+					 + sechdrs[i].sh_size) &&
+		    !WARN_ON(kbuf->image->start != pi->ehdr->e_entry)) {
 			kbuf->image->start -= sechdrs[i].sh_addr;
 			kbuf->image->start += kbuf->mem + offset;
 		}
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 30e1d7fedb5f..eec8e2f7537e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3281,6 +3281,30 @@ static void kfree_rcu_work(struct work_struct *work)
 	}
 }
 
+static bool
+need_offload_krc(struct kfree_rcu_cpu *krcp)
+{
+	int i;
+
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		if (krcp->bkvhead[i])
+			return true;
+
+	return !!krcp->head;
+}
+
+static bool
+need_wait_for_krwp_work(struct kfree_rcu_cpu_work *krwp)
+{
+	int i;
+
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		if (krwp->bkvhead_free[i])
+			return true;
+
+	return !!krwp->head_free;
+}
+
 /*
  * Schedule the kfree batch RCU work to run in workqueue context after a GP.
  *
@@ -3298,16 +3322,13 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 	for (i = 0; i < KFREE_N_BATCHES; i++) {
 		krwp = &(krcp->krw_arr[i]);
 
-		/*
-		 * Try to detach bkvhead or head and attach it over any
-		 * available corresponding free channel. It can be that
-		 * a previous RCU batch is in progress, it means that
-		 * immediately to queue another one is not possible so
-		 * return false to tell caller to retry.
-		 */
-		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
-			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
-				(krcp->head && !krwp->head_free)) {
+		// Try to detach bulk_head or head and attach it, only when
+		// all channels are free.  Any channel is not free means at krwp
+		// there is on-going rcu work to handle krwp's free business.
+		if (need_wait_for_krwp_work(krwp))
+			continue;
+
+		if (need_offload_krc(krcp)) {
 			// Channel 1 corresponds to SLAB ptrs.
 			// Channel 2 corresponds to vmalloc ptrs.
 			for (j = 0; j < FREE_N_CHANNELS; j++) {
@@ -3334,12 +3355,12 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 			 */
 			queue_rcu_work(system_wq, &krwp->rcu_work);
 		}
-
-		// Repeat if any "free" corresponding channel is still busy.
-		if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head)
-			repeat = true;
 	}
 
+	// Repeat if any "free" corresponding channel is still busy.
+	if (need_offload_krc(krcp))
+		repeat = true;
+
 	return !repeat;
 }
 
diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 8504526541c1..53fa01fb7509 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -14,11 +14,12 @@
  */
 #include <linux/ctype.h>
 #include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/math64.h>
 #include <linux/export.h>
+#include <linux/kstrtox.h>
+#include <linux/math64.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+
 #include "kstrtox.h"
 
 const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
diff --git a/lib/parser.c b/lib/parser.c
index f5b3e5d7a7f9..5c37d6345cb0 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -6,6 +6,7 @@
 #include <linux/ctype.h>
 #include <linux/types.h>
 #include <linux/export.h>
+#include <linux/kstrtox.h>
 #include <linux/parser.h>
 #include <linux/slab.h>
 #include <linux/string.h>
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 581ee3fcdd5c..ed0455a9ded8 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/delay.h>
+#include <linux/kstrtox.h>
 #include <linux/kthread.h>
 #include <linux/vmalloc.h>
 #include <linux/efi_embedded_fw.h>
@@ -320,16 +321,26 @@ static ssize_t config_test_show_str(char *dst,
 	return len;
 }
 
-static int test_dev_config_update_bool(const char *buf, size_t size,
+static inline int __test_dev_config_update_bool(const char *buf, size_t size,
 				       bool *cfg)
 {
 	int ret;
 
-	mutex_lock(&test_fw_mutex);
-	if (strtobool(buf, cfg) < 0)
+	if (kstrtobool(buf, cfg) < 0)
 		ret = -EINVAL;
 	else
 		ret = size;
+
+	return ret;
+}
+
+static int test_dev_config_update_bool(const char *buf, size_t size,
+				       bool *cfg)
+{
+	int ret;
+
+	mutex_lock(&test_fw_mutex);
+	ret = __test_dev_config_update_bool(buf, size, cfg);
 	mutex_unlock(&test_fw_mutex);
 
 	return ret;
@@ -340,7 +351,8 @@ static ssize_t test_dev_config_show_bool(char *buf, bool val)
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static int test_dev_config_update_size_t(const char *buf,
+static int __test_dev_config_update_size_t(
+					 const char *buf,
 					 size_t size,
 					 size_t *cfg)
 {
@@ -351,9 +363,7 @@ static int test_dev_config_update_size_t(const char *buf,
 	if (ret)
 		return ret;
 
-	mutex_lock(&test_fw_mutex);
 	*(size_t *)cfg = new;
-	mutex_unlock(&test_fw_mutex);
 
 	/* Always return full write size even if we didn't consume all */
 	return size;
@@ -369,24 +379,30 @@ static ssize_t test_dev_config_show_int(char *buf, int val)
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+static int __test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 {
+	u8 val;
 	int ret;
-	long new;
 
-	ret = kstrtol(buf, 10, &new);
+	ret = kstrtou8(buf, 10, &val);
 	if (ret)
 		return ret;
 
-	if (new > U8_MAX)
-		return -EINVAL;
+	*(u8 *)cfg = val;
+
+	/* Always return full write size even if we didn't consume all */
+	return size;
+}
+
+static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+{
+	int ret;
 
 	mutex_lock(&test_fw_mutex);
-	*(u8 *)cfg = new;
+	ret = __test_dev_config_update_u8(buf, size, cfg);
 	mutex_unlock(&test_fw_mutex);
 
-	/* Always return full write size even if we didn't consume all */
-	return size;
+	return ret;
 }
 
 static ssize_t test_dev_config_show_u8(char *buf, u8 val)
@@ -415,10 +431,10 @@ static ssize_t config_num_requests_store(struct device *dev,
 		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
-	mutex_unlock(&test_fw_mutex);
 
-	rc = test_dev_config_update_u8(buf, count,
-				       &test_fw_config->num_requests);
+	rc = __test_dev_config_update_u8(buf, count,
+					 &test_fw_config->num_requests);
+	mutex_unlock(&test_fw_mutex);
 
 out:
 	return rc;
@@ -462,10 +478,10 @@ static ssize_t config_buf_size_store(struct device *dev,
 		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
-	mutex_unlock(&test_fw_mutex);
 
-	rc = test_dev_config_update_size_t(buf, count,
-					   &test_fw_config->buf_size);
+	rc = __test_dev_config_update_size_t(buf, count,
+					     &test_fw_config->buf_size);
+	mutex_unlock(&test_fw_mutex);
 
 out:
 	return rc;
@@ -492,10 +508,10 @@ static ssize_t config_file_offset_store(struct device *dev,
 		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
-	mutex_unlock(&test_fw_mutex);
 
-	rc = test_dev_config_update_size_t(buf, count,
-					   &test_fw_config->file_offset);
+	rc = __test_dev_config_update_size_t(buf, count,
+					     &test_fw_config->file_offset);
+	mutex_unlock(&test_fw_mutex);
 
 out:
 	return rc;
@@ -847,6 +863,11 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
@@ -946,6 +967,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index c637f6b5053a..c282728de3af 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -877,20 +877,17 @@ static int test_dev_config_update_uint_sync(struct kmod_test_device *test_dev,
 					    int (*test_sync)(struct kmod_test_device *test_dev))
 {
 	int ret;
-	unsigned long new;
+	unsigned int val;
 	unsigned int old_val;
 
-	ret = kstrtoul(buf, 10, &new);
+	ret = kstrtouint(buf, 10, &val);
 	if (ret)
 		return ret;
 
-	if (new > UINT_MAX)
-		return -EINVAL;
-
 	mutex_lock(&test_dev->config_mutex);
 
 	old_val = *config;
-	*(unsigned int *)config = new;
+	*(unsigned int *)config = val;
 
 	ret = test_sync(test_dev);
 	if (ret) {
@@ -914,18 +911,18 @@ static int test_dev_config_update_uint_range(struct kmod_test_device *test_dev,
 					     unsigned int min,
 					     unsigned int max)
 {
+	unsigned int val;
 	int ret;
-	unsigned long new;
 
-	ret = kstrtoul(buf, 10, &new);
+	ret = kstrtouint(buf, 10, &val);
 	if (ret)
 		return ret;
 
-	if (new < min || new > max)
+	if (val < min || val > max)
 		return -EINVAL;
 
 	mutex_lock(&test_dev->config_mutex);
-	*config = new;
+	*config = val;
 	mutex_unlock(&test_dev->config_mutex);
 
 	/* Always return full write size even if we didn't consume all */
@@ -936,18 +933,15 @@ static int test_dev_config_update_int(struct kmod_test_device *test_dev,
 				      const char *buf, size_t size,
 				      int *config)
 {
+	int val;
 	int ret;
-	long new;
 
-	ret = kstrtol(buf, 10, &new);
+	ret = kstrtoint(buf, 10, &val);
 	if (ret)
 		return ret;
 
-	if (new < INT_MIN || new > INT_MAX)
-		return -EINVAL;
-
 	mutex_lock(&test_dev->config_mutex);
-	*config = new;
+	*config = val;
 	mutex_unlock(&test_dev->config_mutex);
 	/* Always return full write size even if we didn't consume all */
 	return size;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f0633f9a9116..9ec9e1e67705 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1788,39 +1788,112 @@ int remove_memory(int nid, u64 start, u64 size)
 }
 EXPORT_SYMBOL_GPL(remove_memory);
 
+static int try_offline_memory_block(struct memory_block *mem, void *arg)
+{
+	uint8_t online_type = MMOP_ONLINE_KERNEL;
+	uint8_t **online_types = arg;
+	struct page *page;
+	int rc;
+
+	/*
+	 * Sense the online_type via the zone of the memory block. Offlining
+	 * with multiple zones within one memory block will be rejected
+	 * by offlining code ... so we don't care about that.
+	 */
+	page = pfn_to_online_page(section_nr_to_pfn(mem->start_section_nr));
+	if (page && zone_idx(page_zone(page)) == ZONE_MOVABLE)
+		online_type = MMOP_ONLINE_MOVABLE;
+
+	rc = device_offline(&mem->dev);
+	/*
+	 * Default is MMOP_OFFLINE - change it only if offlining succeeded,
+	 * so try_reonline_memory_block() can do the right thing.
+	 */
+	if (!rc)
+		**online_types = online_type;
+
+	(*online_types)++;
+	/* Ignore if already offline. */
+	return rc < 0 ? rc : 0;
+}
+
+static int try_reonline_memory_block(struct memory_block *mem, void *arg)
+{
+	uint8_t **online_types = arg;
+	int rc;
+
+	if (**online_types != MMOP_OFFLINE) {
+		mem->online_type = **online_types;
+		rc = device_online(&mem->dev);
+		if (rc < 0)
+			pr_warn("%s: Failed to re-online memory: %d",
+				__func__, rc);
+	}
+
+	/* Continue processing all remaining memory blocks. */
+	(*online_types)++;
+	return 0;
+}
+
 /*
- * Try to offline and remove a memory block. Might take a long time to
- * finish in case memory is still in use. Primarily useful for memory devices
- * that logically unplugged all memory (so it's no longer in use) and want to
- * offline + remove the memory block.
+ * Try to offline and remove memory. Might take a long time to finish in case
+ * memory is still in use. Primarily useful for memory devices that logically
+ * unplugged all memory (so it's no longer in use) and want to offline + remove
+ * that memory.
  */
 int offline_and_remove_memory(int nid, u64 start, u64 size)
 {
-	struct memory_block *mem;
-	int rc = -EINVAL;
+	const unsigned long mb_count = size / memory_block_size_bytes();
+	uint8_t *online_types, *tmp;
+	int rc;
 
 	if (!IS_ALIGNED(start, memory_block_size_bytes()) ||
-	    size != memory_block_size_bytes())
-		return rc;
+	    !IS_ALIGNED(size, memory_block_size_bytes()) || !size)
+		return -EINVAL;
+
+	/*
+	 * We'll remember the old online type of each memory block, so we can
+	 * try to revert whatever we did when offlining one memory block fails
+	 * after offlining some others succeeded.
+	 */
+	online_types = kmalloc_array(mb_count, sizeof(*online_types),
+				     GFP_KERNEL);
+	if (!online_types)
+		return -ENOMEM;
+	/*
+	 * Initialize all states to MMOP_OFFLINE, so when we abort processing in
+	 * try_offline_memory_block(), we'll skip all unprocessed blocks in
+	 * try_reonline_memory_block().
+	 */
+	memset(online_types, MMOP_OFFLINE, mb_count);
 
 	lock_device_hotplug();
-	mem = find_memory_block(__pfn_to_section(PFN_DOWN(start)));
-	if (mem)
-		rc = device_offline(&mem->dev);
-	/* Ignore if the device is already offline. */
-	if (rc > 0)
-		rc = 0;
+
+	tmp = online_types;
+	rc = walk_memory_blocks(start, size, &tmp, try_offline_memory_block);
 
 	/*
-	 * In case we succeeded to offline the memory block, remove it.
+	 * In case we succeeded to offline all memory, remove it.
 	 * This cannot fail as it cannot get onlined in the meantime.
 	 */
 	if (!rc) {
 		rc = try_remove_memory(nid, start, size);
-		WARN_ON_ONCE(rc);
+		if (rc)
+			pr_err("%s: Failed to remove memory: %d", __func__, rc);
+	}
+
+	/*
+	 * Rollback what we did. While memory onlining might theoretically fail
+	 * (nacked by a notifier), it barely ever happens.
+	 */
+	if (rc) {
+		tmp = online_types;
+		walk_memory_blocks(start, size, &tmp,
+				   try_reonline_memory_block);
 	}
 	unlock_device_hotplug();
 
+	kfree(online_types);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(offline_and_remove_memory);
diff --git a/net/Kconfig b/net/Kconfig
index d6567162c1cf..a22c3fb88564 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -204,7 +204,6 @@ config BRIDGE_NETFILTER
 source "net/netfilter/Kconfig"
 source "net/ipv4/netfilter/Kconfig"
 source "net/ipv6/netfilter/Kconfig"
-source "net/decnet/netfilter/Kconfig"
 source "net/bridge/netfilter/Kconfig"
 
 endif
@@ -221,7 +220,6 @@ source "net/802/Kconfig"
 source "net/bridge/Kconfig"
 source "net/dsa/Kconfig"
 source "net/8021q/Kconfig"
-source "net/decnet/Kconfig"
 source "net/llc/Kconfig"
 source "drivers/net/appletalk/Kconfig"
 source "net/x25/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index 5744bf1997fd..45c03aa92ace 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -39,7 +39,6 @@ obj-$(CONFIG_AF_KCM)		+= kcm/
 obj-$(CONFIG_STREAM_PARSER)	+= strparser/
 obj-$(CONFIG_ATM)		+= atm/
 obj-$(CONFIG_L2TP)		+= l2tp/
-obj-$(CONFIG_DECNET)		+= decnet/
 obj-$(CONFIG_PHONET)		+= phonet/
 ifneq ($(CONFIG_VLAN_8021Q),)
 obj-y				+= 8021q/
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 16cd9450ceb1..d65ff10076d6 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -10,7 +10,7 @@
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
 #include <linux/errno.h>
-#include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/limits.h>
 #include <linux/math64.h>
 #include <linux/netdevice.h>
diff --git a/net/core/dev.c b/net/core/dev.c
index f4aad9b00cc9..3fc27b52bf42 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10300,9 +10300,7 @@ void netdev_run_todo(void)
 		BUG_ON(!list_empty(&dev->ptype_specific));
 		WARN_ON(rcu_access_pointer(dev->ip_ptr));
 		WARN_ON(rcu_access_pointer(dev->ip6_ptr));
-#if IS_ENABLED(CONFIG_DECNET)
-		WARN_ON(dev->dn_ptr);
-#endif
+
 		if (dev->priv_destructor)
 			dev->priv_destructor(dev);
 		if (dev->needs_free_netdev)
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 82ccc3eebe71..3b642c412cf3 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -571,37 +571,6 @@ struct neighbour *neigh_lookup(struct neigh_table *tbl, const void *pkey,
 }
 EXPORT_SYMBOL(neigh_lookup);
 
-struct neighbour *neigh_lookup_nodev(struct neigh_table *tbl, struct net *net,
-				     const void *pkey)
-{
-	struct neighbour *n;
-	unsigned int key_len = tbl->key_len;
-	u32 hash_val;
-	struct neigh_hash_table *nht;
-
-	NEIGH_CACHE_STAT_INC(tbl, lookups);
-
-	rcu_read_lock_bh();
-	nht = rcu_dereference_bh(tbl->nht);
-	hash_val = tbl->hash(pkey, NULL, nht->hash_rnd) >> (32 - nht->hash_shift);
-
-	for (n = rcu_dereference_bh(nht->hash_buckets[hash_val]);
-	     n != NULL;
-	     n = rcu_dereference_bh(n->next)) {
-		if (!memcmp(n->primary_key, pkey, key_len) &&
-		    net_eq(dev_net(n->dev), net)) {
-			if (!refcount_inc_not_zero(&n->refcnt))
-				n = NULL;
-			NEIGH_CACHE_STAT_INC(tbl, hits);
-			break;
-		}
-	}
-
-	rcu_read_unlock_bh();
-	return n;
-}
-EXPORT_SYMBOL(neigh_lookup_nodev);
-
 static struct neighbour *
 ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		struct net_device *dev, u8 flags,
@@ -1802,9 +1771,6 @@ static struct neigh_table *neigh_find_table(int family)
 	case AF_INET6:
 		tbl = neigh_tables[NEIGH_ND_TABLE];
 		break;
-	case AF_DECnet:
-		tbl = neigh_tables[NEIGH_DN_TABLE];
-		break;
 	}
 
 	return tbl;
diff --git a/net/decnet/Kconfig b/net/decnet/Kconfig
deleted file mode 100644
index 24336bdb1054..000000000000
--- a/net/decnet/Kconfig
+++ /dev/null
@@ -1,43 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# DECnet configuration
-#
-config DECNET
-	tristate "DECnet Support"
-	help
-	  The DECnet networking protocol was used in many products made by
-	  Digital (now Compaq).  It provides reliable stream and sequenced
-	  packet communications over which run a variety of services similar
-	  to those which run over TCP/IP.
-
-	  To find some tools to use with the kernel layer support, please
-	  look at Patrick Caulfield's web site:
-	  <http://linux-decnet.sourceforge.net/>.
-
-	  More detailed documentation is available in
-	  <file:Documentation/networking/decnet.rst>.
-
-	  Be sure to say Y to "/proc file system support" and "Sysctl support"
-	  below when using DECnet, since you will need sysctl support to aid
-	  in configuration at run time.
-
-	  The DECnet code is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module is called decnet.
-
-config DECNET_ROUTER
-	bool "DECnet: router support"
-	depends on DECNET
-	select FIB_RULES
-	help
-	  Add support for turning your DECnet Endnode into a level 1 or 2
-	  router.  This is an experimental, but functional option.  If you
-	  do say Y here, then make sure that you also say Y to "Kernel/User
-	  network link driver", "Routing messages" and "Network packet
-	  filtering".  The first two are required to allow configuration via
-	  rtnetlink (you will need Alexey Kuznetsov's iproute2 package
-	  from <ftp://ftp.tux.org/pub/net/ip-routing/>). The "Network packet
-	  filtering" option will be required for the forthcoming routing daemon
-	  to work.
-
-	  See <file:Documentation/networking/decnet.rst> for more information.
diff --git a/net/decnet/Makefile b/net/decnet/Makefile
deleted file mode 100644
index 07b38e441b2d..000000000000
--- a/net/decnet/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-obj-$(CONFIG_DECNET) += decnet.o
-
-decnet-y := af_decnet.o dn_nsp_in.o dn_nsp_out.o \
-	    dn_route.o dn_dev.o dn_neigh.o dn_timer.o
-decnet-$(CONFIG_DECNET_ROUTER) += dn_fib.o dn_rules.o dn_table.o
-decnet-y += sysctl_net_decnet.o
-
-obj-$(CONFIG_NETFILTER) += netfilter/
diff --git a/net/decnet/README b/net/decnet/README
deleted file mode 100644
index 60e7ec88c81f..000000000000
--- a/net/decnet/README
+++ /dev/null
@@ -1,8 +0,0 @@
-                       Linux DECnet Project
-                      ======================
-
-The documentation for this kernel subsystem is available in the
-Documentation/networking subdirectory of this distribution and also
-on line at http://www.chygwyn.com/DECnet/
-
-Steve Whitehouse <SteveW@ACM.org>
diff --git a/net/decnet/af_decnet.c b/net/decnet/af_decnet.c
deleted file mode 100644
index 7d542eb46172..000000000000
--- a/net/decnet/af_decnet.c
+++ /dev/null
@@ -1,2400 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-/*
- * DECnet       An implementation of the DECnet protocol suite for the LINUX
- *              operating system.  DECnet is implemented using the  BSD Socket
- *              interface as the means of communication with the user level.
- *
- *              DECnet Socket Layer Interface
- *
- * Authors:     Eduardo Marcelo Serrat <emserrat@geocities.com>
- *              Patrick Caulfield <patrick@pandh.demon.co.uk>
- *
- * Changes:
- *        Steve Whitehouse: Copied from Eduardo Serrat and Patrick Caulfield's
- *                          version of the code. Original copyright preserved
- *                          below.
- *        Steve Whitehouse: Some bug fixes, cleaning up some code to make it
- *                          compatible with my routing layer.
- *        Steve Whitehouse: Merging changes from Eduardo Serrat and Patrick
- *                          Caulfield.
- *        Steve Whitehouse: Further bug fixes, checking module code still works
- *                          with new routing layer.
- *        Steve Whitehouse: Additional set/get_sockopt() calls.
- *        Steve Whitehouse: Fixed TIOCINQ ioctl to be same as Eduardo's new
- *                          code.
- *        Steve Whitehouse: recvmsg() changed to try and behave in a POSIX like
- *                          way. Didn't manage it entirely, but its better.
- *        Steve Whitehouse: ditto for sendmsg().
- *        Steve Whitehouse: A selection of bug fixes to various things.
- *        Steve Whitehouse: Added TIOCOUTQ ioctl.
- *        Steve Whitehouse: Fixes to username2sockaddr & sockaddr2username.
- *        Steve Whitehouse: Fixes to connect() error returns.
- *       Patrick Caulfield: Fixes to delayed acceptance logic.
- *         David S. Miller: New socket locking
- *        Steve Whitehouse: Socket list hashing/locking
- *         Arnaldo C. Melo: use capable, not suser
- *        Steve Whitehouse: Removed unused code. Fix to use sk->allocation
- *                          when required.
- *       Patrick Caulfield: /proc/net/decnet now has object name/number
- *        Steve Whitehouse: Fixed local port allocation, hashed sk list
- *          Matthew Wilcox: Fixes for dn_ioctl()
- *        Steve Whitehouse: New connect/accept logic to allow timeouts and
- *                          prepare for sendpage etc.
- */
-
-
-/******************************************************************************
-    (c) 1995-1998 E.M. Serrat		emserrat@geocities.com
-
-
-HISTORY:
-
-Version           Kernel     Date       Author/Comments
--------           ------     ----       ---------------
-Version 0.0.1     2.0.30    01-dic-97	Eduardo Marcelo Serrat
-					(emserrat@geocities.com)
-
-					First Development of DECnet Socket La-
-					yer for Linux. Only supports outgoing
-					connections.
-
-Version 0.0.2	  2.1.105   20-jun-98   Patrick J. Caulfield
-					(patrick@pandh.demon.co.uk)
-
-					Port to new kernel development version.
-
-Version 0.0.3     2.1.106   25-jun-98   Eduardo Marcelo Serrat
-					(emserrat@geocities.com)
-					_
-					Added support for incoming connections
-					so we can start developing server apps
-					on Linux.
-					-
-					Module Support
-Version 0.0.4     2.1.109   21-jul-98   Eduardo Marcelo Serrat
-				       (emserrat@geocities.com)
-				       _
-					Added support for X11R6.4. Now we can
-					use DECnet transport for X on Linux!!!
-				       -
-Version 0.0.5    2.1.110   01-aug-98   Eduardo Marcelo Serrat
-				       (emserrat@geocities.com)
-				       Removed bugs on flow control
-				       Removed bugs on incoming accessdata
-				       order
-				       -
-Version 0.0.6    2.1.110   07-aug-98   Eduardo Marcelo Serrat
-				       dn_recvmsg fixes
-
-					Patrick J. Caulfield
-				       dn_bind fixes
-*******************************************************************************/
-
-#include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/socket.h>
-#include <linux/in.h>
-#include <linux/kernel.h>
-#include <linux/sched/signal.h>
-#include <linux/timer.h>
-#include <linux/string.h>
-#include <linux/sockios.h>
-#include <linux/net.h>
-#include <linux/netdevice.h>
-#include <linux/inet.h>
-#include <linux/route.h>
-#include <linux/netfilter.h>
-#include <linux/seq_file.h>
-#include <net/sock.h>
-#include <net/tcp_states.h>
-#include <net/flow.h>
-#include <asm/ioctls.h>
-#include <linux/capability.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
-#include <linux/proc_fs.h>
-#include <linux/stat.h>
-#include <linux/init.h>
-#include <linux/poll.h>
-#include <linux/jiffies.h>
-#include <net/net_namespace.h>
-#include <net/neighbour.h>
-#include <net/dst.h>
-#include <net/fib_rules.h>
-#include <net/tcp.h>
-#include <net/dn.h>
-#include <net/dn_nsp.h>
-#include <net/dn_dev.h>
-#include <net/dn_route.h>
-#include <net/dn_fib.h>
-#include <net/dn_neigh.h>
-
-struct dn_sock {
-	struct sock sk;
-	struct dn_scp scp;
-};
-
-static void dn_keepalive(struct sock *sk);
-
-#define DN_SK_HASH_SHIFT 8
-#define DN_SK_HASH_SIZE (1 << DN_SK_HASH_SHIFT)
-#define DN_SK_HASH_MASK (DN_SK_HASH_SIZE - 1)
-
-
-static const struct proto_ops dn_proto_ops;
-static DEFINE_RWLOCK(dn_hash_lock);
-static struct hlist_head dn_sk_hash[DN_SK_HASH_SIZE];
-static struct hlist_head dn_wild_sk;
-static atomic_long_t decnet_memory_allocated;
-
-static int __dn_setsockopt(struct socket *sock, int level, int optname,
-		sockptr_t optval, unsigned int optlen, int flags);
-static int __dn_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen, int flags);
-
-static struct hlist_head *dn_find_list(struct sock *sk)
-{
-	struct dn_scp *scp = DN_SK(sk);
-
-	if (scp->addr.sdn_flags & SDF_WILD)
-		return hlist_empty(&dn_wild_sk) ? &dn_wild_sk : NULL;
-
-	return &dn_sk_hash[le16_to_cpu(scp->addrloc) & DN_SK_HASH_MASK];
-}
-
-/*
- * Valid ports are those greater than zero and not already in use.
- */
-static int check_port(__le16 port)
-{
-	struct sock *sk;
-
-	if (port == 0)
-		return -1;
-
-	sk_for_each(sk, &dn_sk_hash[le16_to_cpu(port) & DN_SK_HASH_MASK]) {
-		struct dn_scp *scp = DN_SK(sk);
-		if (scp->addrloc == port)
-			return -1;
-	}
-	return 0;
-}
-
-static unsigned short port_alloc(struct sock *sk)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	static unsigned short port = 0x2000;
-	unsigned short i_port = port;
-
-	while(check_port(cpu_to_le16(++port)) != 0) {
-		if (port == i_port)
-			return 0;
-	}
-
-	scp->addrloc = cpu_to_le16(port);
-
-	return 1;
-}
-
-/*
- * Since this is only ever called from user
- * level, we don't need a write_lock() version
- * of this.
- */
-static int dn_hash_sock(struct sock *sk)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	struct hlist_head *list;
-	int rv = -EUSERS;
-
-	BUG_ON(sk_hashed(sk));
-
-	write_lock_bh(&dn_hash_lock);
-
-	if (!scp->addrloc && !port_alloc(sk))
-		goto out;
-
-	rv = -EADDRINUSE;
-	if ((list = dn_find_list(sk)) == NULL)
-		goto out;
-
-	sk_add_node(sk, list);
-	rv = 0;
-out:
-	write_unlock_bh(&dn_hash_lock);
-	return rv;
-}
-
-static void dn_unhash_sock(struct sock *sk)
-{
-	write_lock(&dn_hash_lock);
-	sk_del_node_init(sk);
-	write_unlock(&dn_hash_lock);
-}
-
-static void dn_unhash_sock_bh(struct sock *sk)
-{
-	write_lock_bh(&dn_hash_lock);
-	sk_del_node_init(sk);
-	write_unlock_bh(&dn_hash_lock);
-}
-
-static struct hlist_head *listen_hash(struct sockaddr_dn *addr)
-{
-	int i;
-	unsigned int hash = addr->sdn_objnum;
-
-	if (hash == 0) {
-		hash = addr->sdn_objnamel;
-		for(i = 0; i < le16_to_cpu(addr->sdn_objnamel); i++) {
-			hash ^= addr->sdn_objname[i];
-			hash ^= (hash << 3);
-		}
-	}
-
-	return &dn_sk_hash[hash & DN_SK_HASH_MASK];
-}
-
-/*
- * Called to transform a socket from bound (i.e. with a local address)
- * into a listening socket (doesn't need a local port number) and rehashes
- * based upon the object name/number.
- */
-static void dn_rehash_sock(struct sock *sk)
-{
-	struct hlist_head *list;
-	struct dn_scp *scp = DN_SK(sk);
-
-	if (scp->addr.sdn_flags & SDF_WILD)
-		return;
-
-	write_lock_bh(&dn_hash_lock);
-	sk_del_node_init(sk);
-	DN_SK(sk)->addrloc = 0;
-	list = listen_hash(&DN_SK(sk)->addr);
-	sk_add_node(sk, list);
-	write_unlock_bh(&dn_hash_lock);
-}
-
-int dn_sockaddr2username(struct sockaddr_dn *sdn, unsigned char *buf, unsigned char type)
-{
-	int len = 2;
-
-	*buf++ = type;
-
-	switch (type) {
-	case 0:
-		*buf++ = sdn->sdn_objnum;
-		break;
-	case 1:
-		*buf++ = 0;
-		*buf++ = le16_to_cpu(sdn->sdn_objnamel);
-		memcpy(buf, sdn->sdn_objname, le16_to_cpu(sdn->sdn_objnamel));
-		len = 3 + le16_to_cpu(sdn->sdn_objnamel);
-		break;
-	case 2:
-		memset(buf, 0, 5);
-		buf += 5;
-		*buf++ = le16_to_cpu(sdn->sdn_objnamel);
-		memcpy(buf, sdn->sdn_objname, le16_to_cpu(sdn->sdn_objnamel));
-		len = 7 + le16_to_cpu(sdn->sdn_objnamel);
-		break;
-	}
-
-	return len;
-}
-
-/*
- * On reception of usernames, we handle types 1 and 0 for destination
- * addresses only. Types 2 and 4 are used for source addresses, but the
- * UIC, GIC are ignored and they are both treated the same way. Type 3
- * is never used as I've no idea what its purpose might be or what its
- * format is.
- */
-int dn_username2sockaddr(unsigned char *data, int len, struct sockaddr_dn *sdn, unsigned char *fmt)
-{
-	unsigned char type;
-	int size = len;
-	int namel = 12;
-
-	sdn->sdn_objnum = 0;
-	sdn->sdn_objnamel = cpu_to_le16(0);
-	memset(sdn->sdn_objname, 0, DN_MAXOBJL);
-
-	if (len < 2)
-		return -1;
-
-	len -= 2;
-	*fmt = *data++;
-	type = *data++;
-
-	switch (*fmt) {
-	case 0:
-		sdn->sdn_objnum = type;
-		return 2;
-	case 1:
-		namel = 16;
-		break;
-	case 2:
-		len  -= 4;
-		data += 4;
-		break;
-	case 4:
-		len  -= 8;
-		data += 8;
-		break;
-	default:
-		return -1;
-	}
-
-	len -= 1;
-
-	if (len < 0)
-		return -1;
-
-	sdn->sdn_objnamel = cpu_to_le16(*data++);
-	len -= le16_to_cpu(sdn->sdn_objnamel);
-
-	if ((len < 0) || (le16_to_cpu(sdn->sdn_objnamel) > namel))
-		return -1;
-
-	memcpy(sdn->sdn_objname, data, le16_to_cpu(sdn->sdn_objnamel));
-
-	return size - len;
-}
-
-struct sock *dn_sklist_find_listener(struct sockaddr_dn *addr)
-{
-	struct hlist_head *list = listen_hash(addr);
-	struct sock *sk;
-
-	read_lock(&dn_hash_lock);
-	sk_for_each(sk, list) {
-		struct dn_scp *scp = DN_SK(sk);
-		if (sk->sk_state != TCP_LISTEN)
-			continue;
-		if (scp->addr.sdn_objnum) {
-			if (scp->addr.sdn_objnum != addr->sdn_objnum)
-				continue;
-		} else {
-			if (addr->sdn_objnum)
-				continue;
-			if (scp->addr.sdn_objnamel != addr->sdn_objnamel)
-				continue;
-			if (memcmp(scp->addr.sdn_objname, addr->sdn_objname, le16_to_cpu(addr->sdn_objnamel)) != 0)
-				continue;
-		}
-		sock_hold(sk);
-		read_unlock(&dn_hash_lock);
-		return sk;
-	}
-
-	sk = sk_head(&dn_wild_sk);
-	if (sk) {
-		if (sk->sk_state == TCP_LISTEN)
-			sock_hold(sk);
-		else
-			sk = NULL;
-	}
-
-	read_unlock(&dn_hash_lock);
-	return sk;
-}
-
-struct sock *dn_find_by_skb(struct sk_buff *skb)
-{
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	struct sock *sk;
-	struct dn_scp *scp;
-
-	read_lock(&dn_hash_lock);
-	sk_for_each(sk, &dn_sk_hash[le16_to_cpu(cb->dst_port) & DN_SK_HASH_MASK]) {
-		scp = DN_SK(sk);
-		if (cb->src != dn_saddr2dn(&scp->peer))
-			continue;
-		if (cb->dst_port != scp->addrloc)
-			continue;
-		if (scp->addrrem && (cb->src_port != scp->addrrem))
-			continue;
-		sock_hold(sk);
-		goto found;
-	}
-	sk = NULL;
-found:
-	read_unlock(&dn_hash_lock);
-	return sk;
-}
-
-
-
-static void dn_destruct(struct sock *sk)
-{
-	struct dn_scp *scp = DN_SK(sk);
-
-	skb_queue_purge(&scp->data_xmit_queue);
-	skb_queue_purge(&scp->other_xmit_queue);
-	skb_queue_purge(&scp->other_receive_queue);
-
-	dst_release(rcu_dereference_protected(sk->sk_dst_cache, 1));
-}
-
-static unsigned long dn_memory_pressure;
-
-static void dn_enter_memory_pressure(struct sock *sk)
-{
-	if (!dn_memory_pressure) {
-		dn_memory_pressure = 1;
-	}
-}
-
-static struct proto dn_proto = {
-	.name			= "NSP",
-	.owner			= THIS_MODULE,
-	.enter_memory_pressure	= dn_enter_memory_pressure,
-	.memory_pressure	= &dn_memory_pressure,
-	.memory_allocated	= &decnet_memory_allocated,
-	.sysctl_mem		= sysctl_decnet_mem,
-	.sysctl_wmem		= sysctl_decnet_wmem,
-	.sysctl_rmem		= sysctl_decnet_rmem,
-	.max_header		= DN_MAX_NSP_DATA_HEADER + 64,
-	.obj_size		= sizeof(struct dn_sock),
-};
-
-static struct sock *dn_alloc_sock(struct net *net, struct socket *sock, gfp_t gfp, int kern)
-{
-	struct dn_scp *scp;
-	struct sock *sk = sk_alloc(net, PF_DECnet, gfp, &dn_proto, kern);
-
-	if  (!sk)
-		goto out;
-
-	if (sock)
-		sock->ops = &dn_proto_ops;
-	sock_init_data(sock, sk);
-
-	sk->sk_backlog_rcv = dn_nsp_backlog_rcv;
-	sk->sk_destruct    = dn_destruct;
-	sk->sk_no_check_tx = 1;
-	sk->sk_family      = PF_DECnet;
-	sk->sk_protocol    = 0;
-	sk->sk_allocation  = gfp;
-	sk->sk_sndbuf	   = READ_ONCE(sysctl_decnet_wmem[1]);
-	sk->sk_rcvbuf	   = READ_ONCE(sysctl_decnet_rmem[1]);
-
-	/* Initialization of DECnet Session Control Port		*/
-	scp = DN_SK(sk);
-	scp->state	= DN_O;		/* Open			*/
-	scp->numdat	= 1;		/* Next data seg to tx	*/
-	scp->numoth	= 1;		/* Next oth data to tx  */
-	scp->ackxmt_dat = 0;		/* Last data seg ack'ed */
-	scp->ackxmt_oth = 0;		/* Last oth data ack'ed */
-	scp->ackrcv_dat = 0;		/* Highest data ack recv*/
-	scp->ackrcv_oth = 0;		/* Last oth data ack rec*/
-	scp->flowrem_sw = DN_SEND;
-	scp->flowloc_sw = DN_SEND;
-	scp->flowrem_dat = 0;
-	scp->flowrem_oth = 1;
-	scp->flowloc_dat = 0;
-	scp->flowloc_oth = 1;
-	scp->services_rem = 0;
-	scp->services_loc = 1 | NSP_FC_NONE;
-	scp->info_rem = 0;
-	scp->info_loc = 0x03; /* NSP version 4.1 */
-	scp->segsize_rem = 230 - DN_MAX_NSP_DATA_HEADER; /* Default: Updated by remote segsize */
-	scp->nonagle = 0;
-	scp->multi_ireq = 1;
-	scp->accept_mode = ACC_IMMED;
-	scp->addr.sdn_family    = AF_DECnet;
-	scp->peer.sdn_family    = AF_DECnet;
-	scp->accessdata.acc_accl = 5;
-	memcpy(scp->accessdata.acc_acc, "LINUX", 5);
-
-	scp->max_window   = NSP_MAX_WINDOW;
-	scp->snd_window   = NSP_MIN_WINDOW;
-	scp->nsp_srtt     = NSP_INITIAL_SRTT;
-	scp->nsp_rttvar   = NSP_INITIAL_RTTVAR;
-	scp->nsp_rxtshift = 0;
-
-	skb_queue_head_init(&scp->data_xmit_queue);
-	skb_queue_head_init(&scp->other_xmit_queue);
-	skb_queue_head_init(&scp->other_receive_queue);
-
-	scp->persist = 0;
-	scp->persist_fxn = NULL;
-	scp->keepalive = 10 * HZ;
-	scp->keepalive_fxn = dn_keepalive;
-
-	dn_start_slow_timer(sk);
-out:
-	return sk;
-}
-
-/*
- * Keepalive timer.
- * FIXME: Should respond to SO_KEEPALIVE etc.
- */
-static void dn_keepalive(struct sock *sk)
-{
-	struct dn_scp *scp = DN_SK(sk);
-
-	/*
-	 * By checking the other_data transmit queue is empty
-	 * we are double checking that we are not sending too
-	 * many of these keepalive frames.
-	 */
-	if (skb_queue_empty(&scp->other_xmit_queue))
-		dn_nsp_send_link(sk, DN_NOCHANGE, 0);
-}
-
-
-/*
- * Timer for shutdown/destroyed sockets.
- * When socket is dead & no packets have been sent for a
- * certain amount of time, they are removed by this
- * routine. Also takes care of sending out DI & DC
- * frames at correct times.
- */
-int dn_destroy_timer(struct sock *sk)
-{
-	struct dn_scp *scp = DN_SK(sk);
-
-	scp->persist = dn_nsp_persist(sk);
-
-	switch (scp->state) {
-	case DN_DI:
-		dn_nsp_send_disc(sk, NSP_DISCINIT, 0, GFP_ATOMIC);
-		if (scp->nsp_rxtshift >= decnet_di_count)
-			scp->state = DN_CN;
-		return 0;
-
-	case DN_DR:
-		dn_nsp_send_disc(sk, NSP_DISCINIT, 0, GFP_ATOMIC);
-		if (scp->nsp_rxtshift >= decnet_dr_count)
-			scp->state = DN_DRC;
-		return 0;
-
-	case DN_DN:
-		if (scp->nsp_rxtshift < decnet_dn_count) {
-			/* printk(KERN_DEBUG "dn_destroy_timer: DN\n"); */
-			dn_nsp_send_disc(sk, NSP_DISCCONF, NSP_REASON_DC,
-					 GFP_ATOMIC);
-			return 0;
-		}
-	}
-
-	scp->persist = (HZ * decnet_time_wait);
-
-	if (sk->sk_socket)
-		return 0;
-
-	if (time_after_eq(jiffies, scp->stamp + HZ * decnet_time_wait)) {
-		dn_unhash_sock(sk);
-		sock_put(sk);
-		return 1;
-	}
-
-	return 0;
-}
-
-static void dn_destroy_sock(struct sock *sk)
-{
-	struct dn_scp *scp = DN_SK(sk);
-
-	scp->nsp_rxtshift = 0; /* reset back off */
-
-	if (sk->sk_socket) {
-		if (sk->sk_socket->state != SS_UNCONNECTED)
-			sk->sk_socket->state = SS_DISCONNECTING;
-	}
-
-	sk->sk_state = TCP_CLOSE;
-
-	switch (scp->state) {
-	case DN_DN:
-		dn_nsp_send_disc(sk, NSP_DISCCONF, NSP_REASON_DC,
-				 sk->sk_allocation);
-		scp->persist_fxn = dn_destroy_timer;
-		scp->persist = dn_nsp_persist(sk);
-		break;
-	case DN_CR:
-		scp->state = DN_DR;
-		goto disc_reject;
-	case DN_RUN:
-		scp->state = DN_DI;
-		fallthrough;
-	case DN_DI:
-	case DN_DR:
-disc_reject:
-		dn_nsp_send_disc(sk, NSP_DISCINIT, 0, sk->sk_allocation);
-		fallthrough;
-	case DN_NC:
-	case DN_NR:
-	case DN_RJ:
-	case DN_DIC:
-	case DN_CN:
-	case DN_DRC:
-	case DN_CI:
-	case DN_CD:
-		scp->persist_fxn = dn_destroy_timer;
-		scp->persist = dn_nsp_persist(sk);
-		break;
-	default:
-		printk(KERN_DEBUG "DECnet: dn_destroy_sock passed socket in invalid state\n");
-		fallthrough;
-	case DN_O:
-		dn_stop_slow_timer(sk);
-
-		dn_unhash_sock_bh(sk);
-		sock_put(sk);
-
-		break;
-	}
-}
-
-char *dn_addr2asc(__u16 addr, char *buf)
-{
-	unsigned short node, area;
-
-	node = addr & 0x03ff;
-	area = addr >> 10;
-	sprintf(buf, "%hd.%hd", area, node);
-
-	return buf;
-}
-
-
-
-static int dn_create(struct net *net, struct socket *sock, int protocol,
-		     int kern)
-{
-	struct sock *sk;
-
-	if (protocol < 0 || protocol > U8_MAX)
-		return -EINVAL;
-
-	if (!net_eq(net, &init_net))
-		return -EAFNOSUPPORT;
-
-	switch (sock->type) {
-	case SOCK_SEQPACKET:
-		if (protocol != DNPROTO_NSP)
-			return -EPROTONOSUPPORT;
-		break;
-	case SOCK_STREAM:
-		break;
-	default:
-		return -ESOCKTNOSUPPORT;
-	}
-
-
-	if ((sk = dn_alloc_sock(net, sock, GFP_KERNEL, kern)) == NULL)
-		return -ENOBUFS;
-
-	sk->sk_protocol = protocol;
-
-	return 0;
-}
-
-
-static int
-dn_release(struct socket *sock)
-{
-	struct sock *sk = sock->sk;
-
-	if (sk) {
-		sock_orphan(sk);
-		sock_hold(sk);
-		lock_sock(sk);
-		dn_destroy_sock(sk);
-		release_sock(sk);
-		sock_put(sk);
-	}
-
-	return 0;
-}
-
-static int dn_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
-{
-	struct sock *sk = sock->sk;
-	struct dn_scp *scp = DN_SK(sk);
-	struct sockaddr_dn *saddr = (struct sockaddr_dn *)uaddr;
-	struct net_device *dev, *ldev;
-	int rv;
-
-	if (addr_len != sizeof(struct sockaddr_dn))
-		return -EINVAL;
-
-	if (saddr->sdn_family != AF_DECnet)
-		return -EINVAL;
-
-	if (le16_to_cpu(saddr->sdn_nodeaddrl) && (le16_to_cpu(saddr->sdn_nodeaddrl) != 2))
-		return -EINVAL;
-
-	if (le16_to_cpu(saddr->sdn_objnamel) > DN_MAXOBJL)
-		return -EINVAL;
-
-	if (saddr->sdn_flags & ~SDF_WILD)
-		return -EINVAL;
-
-	if (!capable(CAP_NET_BIND_SERVICE) && (saddr->sdn_objnum ||
-	    (saddr->sdn_flags & SDF_WILD)))
-		return -EACCES;
-
-	if (!(saddr->sdn_flags & SDF_WILD)) {
-		if (le16_to_cpu(saddr->sdn_nodeaddrl)) {
-			rcu_read_lock();
-			ldev = NULL;
-			for_each_netdev_rcu(&init_net, dev) {
-				if (!dev->dn_ptr)
-					continue;
-				if (dn_dev_islocal(dev, dn_saddr2dn(saddr))) {
-					ldev = dev;
-					break;
-				}
-			}
-			rcu_read_unlock();
-			if (ldev == NULL)
-				return -EADDRNOTAVAIL;
-		}
-	}
-
-	rv = -EINVAL;
-	lock_sock(sk);
-	if (sock_flag(sk, SOCK_ZAPPED)) {
-		memcpy(&scp->addr, saddr, addr_len);
-		sock_reset_flag(sk, SOCK_ZAPPED);
-
-		rv = dn_hash_sock(sk);
-		if (rv)
-			sock_set_flag(sk, SOCK_ZAPPED);
-	}
-	release_sock(sk);
-
-	return rv;
-}
-
-
-static int dn_auto_bind(struct socket *sock)
-{
-	struct sock *sk = sock->sk;
-	struct dn_scp *scp = DN_SK(sk);
-	int rv;
-
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	scp->addr.sdn_flags  = 0;
-	scp->addr.sdn_objnum = 0;
-
-	/*
-	 * This stuff is to keep compatibility with Eduardo's
-	 * patch. I hope I can dispense with it shortly...
-	 */
-	if ((scp->accessdata.acc_accl != 0) &&
-		(scp->accessdata.acc_accl <= 12)) {
-
-		scp->addr.sdn_objnamel = cpu_to_le16(scp->accessdata.acc_accl);
-		memcpy(scp->addr.sdn_objname, scp->accessdata.acc_acc, le16_to_cpu(scp->addr.sdn_objnamel));
-
-		scp->accessdata.acc_accl = 0;
-		memset(scp->accessdata.acc_acc, 0, 40);
-	}
-	/* End of compatibility stuff */
-
-	scp->addr.sdn_add.a_len = cpu_to_le16(2);
-	rv = dn_dev_bind_default((__le16 *)scp->addr.sdn_add.a_addr);
-	if (rv == 0) {
-		rv = dn_hash_sock(sk);
-		if (rv)
-			sock_set_flag(sk, SOCK_ZAPPED);
-	}
-
-	return rv;
-}
-
-static int dn_confirm_accept(struct sock *sk, long *timeo, gfp_t allocation)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	DEFINE_WAIT_FUNC(wait, woken_wake_function);
-	int err;
-
-	if (scp->state != DN_CR)
-		return -EINVAL;
-
-	scp->state = DN_CC;
-	scp->segsize_loc = dst_metric_advmss(__sk_dst_get(sk));
-	dn_send_conn_conf(sk, allocation);
-
-	add_wait_queue(sk_sleep(sk), &wait);
-	for(;;) {
-		release_sock(sk);
-		if (scp->state == DN_CC)
-			*timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, *timeo);
-		lock_sock(sk);
-		err = 0;
-		if (scp->state == DN_RUN)
-			break;
-		err = sock_error(sk);
-		if (err)
-			break;
-		err = sock_intr_errno(*timeo);
-		if (signal_pending(current))
-			break;
-		err = -EAGAIN;
-		if (!*timeo)
-			break;
-	}
-	remove_wait_queue(sk_sleep(sk), &wait);
-	if (err == 0) {
-		sk->sk_socket->state = SS_CONNECTED;
-	} else if (scp->state != DN_CC) {
-		sk->sk_socket->state = SS_UNCONNECTED;
-	}
-	return err;
-}
-
-static int dn_wait_run(struct sock *sk, long *timeo)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	DEFINE_WAIT_FUNC(wait, woken_wake_function);
-	int err = 0;
-
-	if (scp->state == DN_RUN)
-		goto out;
-
-	if (!*timeo)
-		return -EALREADY;
-
-	add_wait_queue(sk_sleep(sk), &wait);
-	for(;;) {
-		release_sock(sk);
-		if (scp->state == DN_CI || scp->state == DN_CC)
-			*timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, *timeo);
-		lock_sock(sk);
-		err = 0;
-		if (scp->state == DN_RUN)
-			break;
-		err = sock_error(sk);
-		if (err)
-			break;
-		err = sock_intr_errno(*timeo);
-		if (signal_pending(current))
-			break;
-		err = -ETIMEDOUT;
-		if (!*timeo)
-			break;
-	}
-	remove_wait_queue(sk_sleep(sk), &wait);
-out:
-	if (err == 0) {
-		sk->sk_socket->state = SS_CONNECTED;
-	} else if (scp->state != DN_CI && scp->state != DN_CC) {
-		sk->sk_socket->state = SS_UNCONNECTED;
-	}
-	return err;
-}
-
-static int __dn_connect(struct sock *sk, struct sockaddr_dn *addr, int addrlen, long *timeo, int flags)
-{
-	struct socket *sock = sk->sk_socket;
-	struct dn_scp *scp = DN_SK(sk);
-	int err = -EISCONN;
-	struct flowidn fld;
-	struct dst_entry *dst;
-
-	if (sock->state == SS_CONNECTED)
-		goto out;
-
-	if (sock->state == SS_CONNECTING) {
-		err = 0;
-		if (scp->state == DN_RUN) {
-			sock->state = SS_CONNECTED;
-			goto out;
-		}
-		err = -ECONNREFUSED;
-		if (scp->state != DN_CI && scp->state != DN_CC) {
-			sock->state = SS_UNCONNECTED;
-			goto out;
-		}
-		return dn_wait_run(sk, timeo);
-	}
-
-	err = -EINVAL;
-	if (scp->state != DN_O)
-		goto out;
-
-	if (addr == NULL || addrlen != sizeof(struct sockaddr_dn))
-		goto out;
-	if (addr->sdn_family != AF_DECnet)
-		goto out;
-	if (addr->sdn_flags & SDF_WILD)
-		goto out;
-
-	if (sock_flag(sk, SOCK_ZAPPED)) {
-		err = dn_auto_bind(sk->sk_socket);
-		if (err)
-			goto out;
-	}
-
-	memcpy(&scp->peer, addr, sizeof(struct sockaddr_dn));
-
-	err = -EHOSTUNREACH;
-	memset(&fld, 0, sizeof(fld));
-	fld.flowidn_oif = sk->sk_bound_dev_if;
-	fld.daddr = dn_saddr2dn(&scp->peer);
-	fld.saddr = dn_saddr2dn(&scp->addr);
-	dn_sk_ports_copy(&fld, scp);
-	fld.flowidn_proto = DNPROTO_NSP;
-	if (dn_route_output_sock(&sk->sk_dst_cache, &fld, sk, flags) < 0)
-		goto out;
-	dst = __sk_dst_get(sk);
-	sk->sk_route_caps = dst->dev->features;
-	sock->state = SS_CONNECTING;
-	scp->state = DN_CI;
-	scp->segsize_loc = dst_metric_advmss(dst);
-
-	dn_nsp_send_conninit(sk, NSP_CI);
-	err = -EINPROGRESS;
-	if (*timeo) {
-		err = dn_wait_run(sk, timeo);
-	}
-out:
-	return err;
-}
-
-static int dn_connect(struct socket *sock, struct sockaddr *uaddr, int addrlen, int flags)
-{
-	struct sockaddr_dn *addr = (struct sockaddr_dn *)uaddr;
-	struct sock *sk = sock->sk;
-	int err;
-	long timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
-
-	lock_sock(sk);
-	err = __dn_connect(sk, addr, addrlen, &timeo, 0);
-	release_sock(sk);
-
-	return err;
-}
-
-static inline int dn_check_state(struct sock *sk, struct sockaddr_dn *addr, int addrlen, long *timeo, int flags)
-{
-	struct dn_scp *scp = DN_SK(sk);
-
-	switch (scp->state) {
-	case DN_RUN:
-		return 0;
-	case DN_CR:
-		return dn_confirm_accept(sk, timeo, sk->sk_allocation);
-	case DN_CI:
-	case DN_CC:
-		return dn_wait_run(sk, timeo);
-	case DN_O:
-		return __dn_connect(sk, addr, addrlen, timeo, flags);
-	}
-
-	return -EINVAL;
-}
-
-
-static void dn_access_copy(struct sk_buff *skb, struct accessdata_dn *acc)
-{
-	unsigned char *ptr = skb->data;
-
-	acc->acc_userl = *ptr++;
-	memcpy(&acc->acc_user, ptr, acc->acc_userl);
-	ptr += acc->acc_userl;
-
-	acc->acc_passl = *ptr++;
-	memcpy(&acc->acc_pass, ptr, acc->acc_passl);
-	ptr += acc->acc_passl;
-
-	acc->acc_accl = *ptr++;
-	memcpy(&acc->acc_acc, ptr, acc->acc_accl);
-
-	skb_pull(skb, acc->acc_accl + acc->acc_passl + acc->acc_userl + 3);
-
-}
-
-static void dn_user_copy(struct sk_buff *skb, struct optdata_dn *opt)
-{
-	unsigned char *ptr = skb->data;
-	u16 len = *ptr++; /* yes, it's 8bit on the wire */
-
-	BUG_ON(len > 16); /* we've checked the contents earlier */
-	opt->opt_optl   = cpu_to_le16(len);
-	opt->opt_status = 0;
-	memcpy(opt->opt_data, ptr, len);
-	skb_pull(skb, len + 1);
-}
-
-static struct sk_buff *dn_wait_for_connect(struct sock *sk, long *timeo)
-{
-	DEFINE_WAIT_FUNC(wait, woken_wake_function);
-	struct sk_buff *skb = NULL;
-	int err = 0;
-
-	add_wait_queue(sk_sleep(sk), &wait);
-	for(;;) {
-		release_sock(sk);
-		skb = skb_dequeue(&sk->sk_receive_queue);
-		if (skb == NULL) {
-			*timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, *timeo);
-			skb = skb_dequeue(&sk->sk_receive_queue);
-		}
-		lock_sock(sk);
-		if (skb != NULL)
-			break;
-		err = -EINVAL;
-		if (sk->sk_state != TCP_LISTEN)
-			break;
-		err = sock_intr_errno(*timeo);
-		if (signal_pending(current))
-			break;
-		err = -EAGAIN;
-		if (!*timeo)
-			break;
-	}
-	remove_wait_queue(sk_sleep(sk), &wait);
-
-	return skb == NULL ? ERR_PTR(err) : skb;
-}
-
-static int dn_accept(struct socket *sock, struct socket *newsock, int flags,
-		     bool kern)
-{
-	struct sock *sk = sock->sk, *newsk;
-	struct sk_buff *skb = NULL;
-	struct dn_skb_cb *cb;
-	unsigned char menuver;
-	int err = 0;
-	unsigned char type;
-	long timeo = sock_rcvtimeo(sk, flags & O_NONBLOCK);
-	struct dst_entry *dst;
-
-	lock_sock(sk);
-
-	if (sk->sk_state != TCP_LISTEN || DN_SK(sk)->state != DN_O) {
-		release_sock(sk);
-		return -EINVAL;
-	}
-
-	skb = skb_dequeue(&sk->sk_receive_queue);
-	if (skb == NULL) {
-		skb = dn_wait_for_connect(sk, &timeo);
-		if (IS_ERR(skb)) {
-			release_sock(sk);
-			return PTR_ERR(skb);
-		}
-	}
-
-	cb = DN_SKB_CB(skb);
-	sk_acceptq_removed(sk);
-	newsk = dn_alloc_sock(sock_net(sk), newsock, sk->sk_allocation, kern);
-	if (newsk == NULL) {
-		release_sock(sk);
-		kfree_skb(skb);
-		return -ENOBUFS;
-	}
-	release_sock(sk);
-
-	dst = skb_dst(skb);
-	sk_dst_set(newsk, dst);
-	skb_dst_set(skb, NULL);
-
-	DN_SK(newsk)->state        = DN_CR;
-	DN_SK(newsk)->addrrem      = cb->src_port;
-	DN_SK(newsk)->services_rem = cb->services;
-	DN_SK(newsk)->info_rem     = cb->info;
-	DN_SK(newsk)->segsize_rem  = cb->segsize;
-	DN_SK(newsk)->accept_mode  = DN_SK(sk)->accept_mode;
-
-	if (DN_SK(newsk)->segsize_rem < 230)
-		DN_SK(newsk)->segsize_rem = 230;
-
-	if ((DN_SK(newsk)->services_rem & NSP_FC_MASK) == NSP_FC_NONE)
-		DN_SK(newsk)->max_window = decnet_no_fc_max_cwnd;
-
-	newsk->sk_state  = TCP_LISTEN;
-	memcpy(&(DN_SK(newsk)->addr), &(DN_SK(sk)->addr), sizeof(struct sockaddr_dn));
-
-	/*
-	 * If we are listening on a wild socket, we don't want
-	 * the newly created socket on the wrong hash queue.
-	 */
-	DN_SK(newsk)->addr.sdn_flags &= ~SDF_WILD;
-
-	skb_pull(skb, dn_username2sockaddr(skb->data, skb->len, &(DN_SK(newsk)->addr), &type));
-	skb_pull(skb, dn_username2sockaddr(skb->data, skb->len, &(DN_SK(newsk)->peer), &type));
-	*(__le16 *)(DN_SK(newsk)->peer.sdn_add.a_addr) = cb->src;
-	*(__le16 *)(DN_SK(newsk)->addr.sdn_add.a_addr) = cb->dst;
-
-	menuver = *skb->data;
-	skb_pull(skb, 1);
-
-	if (menuver & DN_MENUVER_ACC)
-		dn_access_copy(skb, &(DN_SK(newsk)->accessdata));
-
-	if (menuver & DN_MENUVER_USR)
-		dn_user_copy(skb, &(DN_SK(newsk)->conndata_in));
-
-	if (menuver & DN_MENUVER_PRX)
-		DN_SK(newsk)->peer.sdn_flags |= SDF_PROXY;
-
-	if (menuver & DN_MENUVER_UIC)
-		DN_SK(newsk)->peer.sdn_flags |= SDF_UICPROXY;
-
-	kfree_skb(skb);
-
-	memcpy(&(DN_SK(newsk)->conndata_out), &(DN_SK(sk)->conndata_out),
-		sizeof(struct optdata_dn));
-	memcpy(&(DN_SK(newsk)->discdata_out), &(DN_SK(sk)->discdata_out),
-		sizeof(struct optdata_dn));
-
-	lock_sock(newsk);
-	err = dn_hash_sock(newsk);
-	if (err == 0) {
-		sock_reset_flag(newsk, SOCK_ZAPPED);
-		dn_send_conn_ack(newsk);
-
-		/*
-		 * Here we use sk->sk_allocation since although the conn conf is
-		 * for the newsk, the context is the old socket.
-		 */
-		if (DN_SK(newsk)->accept_mode == ACC_IMMED)
-			err = dn_confirm_accept(newsk, &timeo,
-						sk->sk_allocation);
-	}
-	release_sock(newsk);
-	return err;
-}
-
-
-static int dn_getname(struct socket *sock, struct sockaddr *uaddr,int peer)
-{
-	struct sockaddr_dn *sa = (struct sockaddr_dn *)uaddr;
-	struct sock *sk = sock->sk;
-	struct dn_scp *scp = DN_SK(sk);
-
-	lock_sock(sk);
-
-	if (peer) {
-		if ((sock->state != SS_CONNECTED &&
-		     sock->state != SS_CONNECTING) &&
-		    scp->accept_mode == ACC_IMMED) {
-			release_sock(sk);
-			return -ENOTCONN;
-		}
-
-		memcpy(sa, &scp->peer, sizeof(struct sockaddr_dn));
-	} else {
-		memcpy(sa, &scp->addr, sizeof(struct sockaddr_dn));
-	}
-
-	release_sock(sk);
-
-	return sizeof(struct sockaddr_dn);
-}
-
-
-static __poll_t dn_poll(struct file *file, struct socket *sock, poll_table  *wait)
-{
-	struct sock *sk = sock->sk;
-	struct dn_scp *scp = DN_SK(sk);
-	__poll_t mask = datagram_poll(file, sock, wait);
-
-	if (!skb_queue_empty_lockless(&scp->other_receive_queue))
-		mask |= EPOLLRDBAND;
-
-	return mask;
-}
-
-static int dn_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
-{
-	struct sock *sk = sock->sk;
-	struct dn_scp *scp = DN_SK(sk);
-	int err = -EOPNOTSUPP;
-	long amount = 0;
-	struct sk_buff *skb;
-	int val;
-
-	switch(cmd)
-	{
-	case SIOCGIFADDR:
-	case SIOCSIFADDR:
-		return dn_dev_ioctl(cmd, (void __user *)arg);
-
-	case SIOCATMARK:
-		lock_sock(sk);
-		val = !skb_queue_empty(&scp->other_receive_queue);
-		if (scp->state != DN_RUN)
-			val = -ENOTCONN;
-		release_sock(sk);
-		return val;
-
-	case TIOCOUTQ:
-		amount = sk->sk_sndbuf - sk_wmem_alloc_get(sk);
-		if (amount < 0)
-			amount = 0;
-		err = put_user(amount, (int __user *)arg);
-		break;
-
-	case TIOCINQ:
-		lock_sock(sk);
-		skb = skb_peek(&scp->other_receive_queue);
-		if (skb) {
-			amount = skb->len;
-		} else {
-			skb_queue_walk(&sk->sk_receive_queue, skb)
-				amount += skb->len;
-		}
-		release_sock(sk);
-		err = put_user(amount, (int __user *)arg);
-		break;
-
-	default:
-		err = -ENOIOCTLCMD;
-		break;
-	}
-
-	return err;
-}
-
-static int dn_listen(struct socket *sock, int backlog)
-{
-	struct sock *sk = sock->sk;
-	int err = -EINVAL;
-
-	lock_sock(sk);
-
-	if (sock_flag(sk, SOCK_ZAPPED))
-		goto out;
-
-	if ((DN_SK(sk)->state != DN_O) || (sk->sk_state == TCP_LISTEN))
-		goto out;
-
-	sk->sk_max_ack_backlog = backlog;
-	sk->sk_ack_backlog     = 0;
-	sk->sk_state           = TCP_LISTEN;
-	err                 = 0;
-	dn_rehash_sock(sk);
-
-out:
-	release_sock(sk);
-
-	return err;
-}
-
-
-static int dn_shutdown(struct socket *sock, int how)
-{
-	struct sock *sk = sock->sk;
-	struct dn_scp *scp = DN_SK(sk);
-	int err = -ENOTCONN;
-
-	lock_sock(sk);
-
-	if (sock->state == SS_UNCONNECTED)
-		goto out;
-
-	err = 0;
-	if (sock->state == SS_DISCONNECTING)
-		goto out;
-
-	err = -EINVAL;
-	if (scp->state == DN_O)
-		goto out;
-
-	if (how != SHUT_RDWR)
-		goto out;
-
-	sk->sk_shutdown = SHUTDOWN_MASK;
-	dn_destroy_sock(sk);
-	err = 0;
-
-out:
-	release_sock(sk);
-
-	return err;
-}
-
-static int dn_setsockopt(struct socket *sock, int level, int optname,
-		sockptr_t optval, unsigned int optlen)
-{
-	struct sock *sk = sock->sk;
-	int err;
-
-	lock_sock(sk);
-	err = __dn_setsockopt(sock, level, optname, optval, optlen, 0);
-	release_sock(sk);
-#ifdef CONFIG_NETFILTER
-	/* we need to exclude all possible ENOPROTOOPTs except default case */
-	if (err == -ENOPROTOOPT && optname != DSO_LINKINFO &&
-	    optname != DSO_STREAM && optname != DSO_SEQPACKET)
-		err = nf_setsockopt(sk, PF_DECnet, optname, optval, optlen);
-#endif
-
-	return err;
-}
-
-static int __dn_setsockopt(struct socket *sock, int level, int optname,
-		sockptr_t optval, unsigned int optlen, int flags)
-{
-	struct	sock *sk = sock->sk;
-	struct dn_scp *scp = DN_SK(sk);
-	long timeo;
-	union {
-		struct optdata_dn opt;
-		struct accessdata_dn acc;
-		int mode;
-		unsigned long win;
-		int val;
-		unsigned char services;
-		unsigned char info;
-	} u;
-	int err;
-
-	if (optlen && sockptr_is_null(optval))
-		return -EINVAL;
-
-	if (optlen > sizeof(u))
-		return -EINVAL;
-
-	if (copy_from_sockptr(&u, optval, optlen))
-		return -EFAULT;
-
-	switch (optname) {
-	case DSO_CONDATA:
-		if (sock->state == SS_CONNECTED)
-			return -EISCONN;
-		if ((scp->state != DN_O) && (scp->state != DN_CR))
-			return -EINVAL;
-
-		if (optlen != sizeof(struct optdata_dn))
-			return -EINVAL;
-
-		if (le16_to_cpu(u.opt.opt_optl) > 16)
-			return -EINVAL;
-
-		memcpy(&scp->conndata_out, &u.opt, optlen);
-		break;
-
-	case DSO_DISDATA:
-		if (sock->state != SS_CONNECTED &&
-		    scp->accept_mode == ACC_IMMED)
-			return -ENOTCONN;
-
-		if (optlen != sizeof(struct optdata_dn))
-			return -EINVAL;
-
-		if (le16_to_cpu(u.opt.opt_optl) > 16)
-			return -EINVAL;
-
-		memcpy(&scp->discdata_out, &u.opt, optlen);
-		break;
-
-	case DSO_CONACCESS:
-		if (sock->state == SS_CONNECTED)
-			return -EISCONN;
-		if (scp->state != DN_O)
-			return -EINVAL;
-
-		if (optlen != sizeof(struct accessdata_dn))
-			return -EINVAL;
-
-		if ((u.acc.acc_accl > DN_MAXACCL) ||
-		    (u.acc.acc_passl > DN_MAXACCL) ||
-		    (u.acc.acc_userl > DN_MAXACCL))
-			return -EINVAL;
-
-		memcpy(&scp->accessdata, &u.acc, optlen);
-		break;
-
-	case DSO_ACCEPTMODE:
-		if (sock->state == SS_CONNECTED)
-			return -EISCONN;
-		if (scp->state != DN_O)
-			return -EINVAL;
-
-		if (optlen != sizeof(int))
-			return -EINVAL;
-
-		if ((u.mode != ACC_IMMED) && (u.mode != ACC_DEFER))
-			return -EINVAL;
-
-		scp->accept_mode = (unsigned char)u.mode;
-		break;
-
-	case DSO_CONACCEPT:
-		if (scp->state != DN_CR)
-			return -EINVAL;
-		timeo = sock_rcvtimeo(sk, 0);
-		err = dn_confirm_accept(sk, &timeo, sk->sk_allocation);
-		return err;
-
-	case DSO_CONREJECT:
-		if (scp->state != DN_CR)
-			return -EINVAL;
-
-		scp->state = DN_DR;
-		sk->sk_shutdown = SHUTDOWN_MASK;
-		dn_nsp_send_disc(sk, 0x38, 0, sk->sk_allocation);
-		break;
-
-	case DSO_MAXWINDOW:
-		if (optlen != sizeof(unsigned long))
-			return -EINVAL;
-		if (u.win > NSP_MAX_WINDOW)
-			u.win = NSP_MAX_WINDOW;
-		if (u.win == 0)
-			return -EINVAL;
-		scp->max_window = u.win;
-		if (scp->snd_window > u.win)
-			scp->snd_window = u.win;
-		break;
-
-	case DSO_NODELAY:
-		if (optlen != sizeof(int))
-			return -EINVAL;
-		if (scp->nonagle == TCP_NAGLE_CORK)
-			return -EINVAL;
-		scp->nonagle = (u.val == 0) ? 0 : TCP_NAGLE_OFF;
-		/* if (scp->nonagle == 1) { Push pending frames } */
-		break;
-
-	case DSO_CORK:
-		if (optlen != sizeof(int))
-			return -EINVAL;
-		if (scp->nonagle == TCP_NAGLE_OFF)
-			return -EINVAL;
-		scp->nonagle = (u.val == 0) ? 0 : TCP_NAGLE_CORK;
-		/* if (scp->nonagle == 0) { Push pending frames } */
-		break;
-
-	case DSO_SERVICES:
-		if (optlen != sizeof(unsigned char))
-			return -EINVAL;
-		if ((u.services & ~NSP_FC_MASK) != 0x01)
-			return -EINVAL;
-		if ((u.services & NSP_FC_MASK) == NSP_FC_MASK)
-			return -EINVAL;
-		scp->services_loc = u.services;
-		break;
-
-	case DSO_INFO:
-		if (optlen != sizeof(unsigned char))
-			return -EINVAL;
-		if (u.info & 0xfc)
-			return -EINVAL;
-		scp->info_loc = u.info;
-		break;
-
-	case DSO_LINKINFO:
-	case DSO_STREAM:
-	case DSO_SEQPACKET:
-	default:
-		return -ENOPROTOOPT;
-	}
-
-	return 0;
-}
-
-static int dn_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
-{
-	struct sock *sk = sock->sk;
-	int err;
-
-	lock_sock(sk);
-	err = __dn_getsockopt(sock, level, optname, optval, optlen, 0);
-	release_sock(sk);
-#ifdef CONFIG_NETFILTER
-	if (err == -ENOPROTOOPT && optname != DSO_STREAM &&
-	    optname != DSO_SEQPACKET && optname != DSO_CONACCEPT &&
-	    optname != DSO_CONREJECT) {
-		int len;
-
-		if (get_user(len, optlen))
-			return -EFAULT;
-
-		err = nf_getsockopt(sk, PF_DECnet, optname, optval, &len);
-		if (err >= 0)
-			err = put_user(len, optlen);
-	}
-#endif
-
-	return err;
-}
-
-static int __dn_getsockopt(struct socket *sock, int level,int optname, char __user *optval,int __user *optlen, int flags)
-{
-	struct	sock *sk = sock->sk;
-	struct dn_scp *scp = DN_SK(sk);
-	struct linkinfo_dn link;
-	unsigned int r_len;
-	void *r_data = NULL;
-	unsigned int val;
-
-	if(get_user(r_len , optlen))
-		return -EFAULT;
-
-	switch (optname) {
-	case DSO_CONDATA:
-		if (r_len > sizeof(struct optdata_dn))
-			r_len = sizeof(struct optdata_dn);
-		r_data = &scp->conndata_in;
-		break;
-
-	case DSO_DISDATA:
-		if (r_len > sizeof(struct optdata_dn))
-			r_len = sizeof(struct optdata_dn);
-		r_data = &scp->discdata_in;
-		break;
-
-	case DSO_CONACCESS:
-		if (r_len > sizeof(struct accessdata_dn))
-			r_len = sizeof(struct accessdata_dn);
-		r_data = &scp->accessdata;
-		break;
-
-	case DSO_ACCEPTMODE:
-		if (r_len > sizeof(unsigned char))
-			r_len = sizeof(unsigned char);
-		r_data = &scp->accept_mode;
-		break;
-
-	case DSO_LINKINFO:
-		if (r_len > sizeof(struct linkinfo_dn))
-			r_len = sizeof(struct linkinfo_dn);
-
-		memset(&link, 0, sizeof(link));
-
-		switch (sock->state) {
-		case SS_CONNECTING:
-			link.idn_linkstate = LL_CONNECTING;
-			break;
-		case SS_DISCONNECTING:
-			link.idn_linkstate = LL_DISCONNECTING;
-			break;
-		case SS_CONNECTED:
-			link.idn_linkstate = LL_RUNNING;
-			break;
-		default:
-			link.idn_linkstate = LL_INACTIVE;
-		}
-
-		link.idn_segsize = scp->segsize_rem;
-		r_data = &link;
-		break;
-
-	case DSO_MAXWINDOW:
-		if (r_len > sizeof(unsigned long))
-			r_len = sizeof(unsigned long);
-		r_data = &scp->max_window;
-		break;
-
-	case DSO_NODELAY:
-		if (r_len > sizeof(int))
-			r_len = sizeof(int);
-		val = (scp->nonagle == TCP_NAGLE_OFF);
-		r_data = &val;
-		break;
-
-	case DSO_CORK:
-		if (r_len > sizeof(int))
-			r_len = sizeof(int);
-		val = (scp->nonagle == TCP_NAGLE_CORK);
-		r_data = &val;
-		break;
-
-	case DSO_SERVICES:
-		if (r_len > sizeof(unsigned char))
-			r_len = sizeof(unsigned char);
-		r_data = &scp->services_rem;
-		break;
-
-	case DSO_INFO:
-		if (r_len > sizeof(unsigned char))
-			r_len = sizeof(unsigned char);
-		r_data = &scp->info_rem;
-		break;
-
-	case DSO_STREAM:
-	case DSO_SEQPACKET:
-	case DSO_CONACCEPT:
-	case DSO_CONREJECT:
-	default:
-		return -ENOPROTOOPT;
-	}
-
-	if (r_data) {
-		if (copy_to_user(optval, r_data, r_len))
-			return -EFAULT;
-		if (put_user(r_len, optlen))
-			return -EFAULT;
-	}
-
-	return 0;
-}
-
-
-static int dn_data_ready(struct sock *sk, struct sk_buff_head *q, int flags, int target)
-{
-	struct sk_buff *skb;
-	int len = 0;
-
-	if (flags & MSG_OOB)
-		return !skb_queue_empty(q) ? 1 : 0;
-
-	skb_queue_walk(q, skb) {
-		struct dn_skb_cb *cb = DN_SKB_CB(skb);
-		len += skb->len;
-
-		if (cb->nsp_flags & 0x40) {
-			/* SOCK_SEQPACKET reads to EOM */
-			if (sk->sk_type == SOCK_SEQPACKET)
-				return 1;
-			/* so does SOCK_STREAM unless WAITALL is specified */
-			if (!(flags & MSG_WAITALL))
-				return 1;
-		}
-
-		/* minimum data length for read exceeded */
-		if (len >= target)
-			return 1;
-	}
-
-	return 0;
-}
-
-
-static int dn_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
-		      int flags)
-{
-	struct sock *sk = sock->sk;
-	struct dn_scp *scp = DN_SK(sk);
-	struct sk_buff_head *queue = &sk->sk_receive_queue;
-	size_t target = size > 1 ? 1 : 0;
-	size_t copied = 0;
-	int rv = 0;
-	struct sk_buff *skb, *n;
-	struct dn_skb_cb *cb = NULL;
-	unsigned char eor = 0;
-	long timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
-
-	lock_sock(sk);
-
-	if (sock_flag(sk, SOCK_ZAPPED)) {
-		rv = -EADDRNOTAVAIL;
-		goto out;
-	}
-
-	if (sk->sk_shutdown & RCV_SHUTDOWN) {
-		rv = 0;
-		goto out;
-	}
-
-	rv = dn_check_state(sk, NULL, 0, &timeo, flags);
-	if (rv)
-		goto out;
-
-	if (flags & ~(MSG_CMSG_COMPAT|MSG_PEEK|MSG_OOB|MSG_WAITALL|MSG_DONTWAIT|MSG_NOSIGNAL)) {
-		rv = -EOPNOTSUPP;
-		goto out;
-	}
-
-	if (flags & MSG_OOB)
-		queue = &scp->other_receive_queue;
-
-	if (flags & MSG_WAITALL)
-		target = size;
-
-
-	/*
-	 * See if there is data ready to read, sleep if there isn't
-	 */
-	for(;;) {
-		DEFINE_WAIT_FUNC(wait, woken_wake_function);
-
-		if (sk->sk_err)
-			goto out;
-
-		if (!skb_queue_empty(&scp->other_receive_queue)) {
-			if (!(flags & MSG_OOB)) {
-				msg->msg_flags |= MSG_OOB;
-				if (!scp->other_report) {
-					scp->other_report = 1;
-					goto out;
-				}
-			}
-		}
-
-		if (scp->state != DN_RUN)
-			goto out;
-
-		if (signal_pending(current)) {
-			rv = sock_intr_errno(timeo);
-			goto out;
-		}
-
-		if (dn_data_ready(sk, queue, flags, target))
-			break;
-
-		if (flags & MSG_DONTWAIT) {
-			rv = -EWOULDBLOCK;
-			goto out;
-		}
-
-		add_wait_queue(sk_sleep(sk), &wait);
-		sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
-		sk_wait_event(sk, &timeo, dn_data_ready(sk, queue, flags, target), &wait);
-		sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
-		remove_wait_queue(sk_sleep(sk), &wait);
-	}
-
-	skb_queue_walk_safe(queue, skb, n) {
-		unsigned int chunk = skb->len;
-		cb = DN_SKB_CB(skb);
-
-		if ((chunk + copied) > size)
-			chunk = size - copied;
-
-		if (memcpy_to_msg(msg, skb->data, chunk)) {
-			rv = -EFAULT;
-			break;
-		}
-		copied += chunk;
-
-		if (!(flags & MSG_PEEK))
-			skb_pull(skb, chunk);
-
-		eor = cb->nsp_flags & 0x40;
-
-		if (skb->len == 0) {
-			skb_unlink(skb, queue);
-			kfree_skb(skb);
-			/*
-			 * N.B. Don't refer to skb or cb after this point
-			 * in loop.
-			 */
-			if ((scp->flowloc_sw == DN_DONTSEND) && !dn_congested(sk)) {
-				scp->flowloc_sw = DN_SEND;
-				dn_nsp_send_link(sk, DN_SEND, 0);
-			}
-		}
-
-		if (eor) {
-			if (sk->sk_type == SOCK_SEQPACKET)
-				break;
-			if (!(flags & MSG_WAITALL))
-				break;
-		}
-
-		if (flags & MSG_OOB)
-			break;
-
-		if (copied >= target)
-			break;
-	}
-
-	rv = copied;
-
-
-	if (eor && (sk->sk_type == SOCK_SEQPACKET))
-		msg->msg_flags |= MSG_EOR;
-
-out:
-	if (rv == 0)
-		rv = (flags & MSG_PEEK) ? -sk->sk_err : sock_error(sk);
-
-	if ((rv >= 0) && msg->msg_name) {
-		__sockaddr_check_size(sizeof(struct sockaddr_dn));
-		memcpy(msg->msg_name, &scp->peer, sizeof(struct sockaddr_dn));
-		msg->msg_namelen = sizeof(struct sockaddr_dn);
-	}
-
-	release_sock(sk);
-
-	return rv;
-}
-
-
-static inline int dn_queue_too_long(struct dn_scp *scp, struct sk_buff_head *queue, int flags)
-{
-	unsigned char fctype = scp->services_rem & NSP_FC_MASK;
-	if (skb_queue_len(queue) >= scp->snd_window)
-		return 1;
-	if (fctype != NSP_FC_NONE) {
-		if (flags & MSG_OOB) {
-			if (scp->flowrem_oth == 0)
-				return 1;
-		} else {
-			if (scp->flowrem_dat == 0)
-				return 1;
-		}
-	}
-	return 0;
-}
-
-/*
- * The DECnet spec requires that the "routing layer" accepts packets which
- * are at least 230 bytes in size. This excludes any headers which the NSP
- * layer might add, so we always assume that we'll be using the maximal
- * length header on data packets. The variation in length is due to the
- * inclusion (or not) of the two 16 bit acknowledgement fields so it doesn't
- * make much practical difference.
- */
-unsigned int dn_mss_from_pmtu(struct net_device *dev, int mtu)
-{
-	unsigned int mss = 230 - DN_MAX_NSP_DATA_HEADER;
-	if (dev) {
-		struct dn_dev *dn_db = rcu_dereference_raw(dev->dn_ptr);
-		mtu -= LL_RESERVED_SPACE(dev);
-		if (dn_db->use_long)
-			mtu -= 21;
-		else
-			mtu -= 6;
-		mtu -= DN_MAX_NSP_DATA_HEADER;
-	} else {
-		/*
-		 * 21 = long header, 16 = guess at MAC header length
-		 */
-		mtu -= (21 + DN_MAX_NSP_DATA_HEADER + 16);
-	}
-	if (mtu > mss)
-		mss = mtu;
-	return mss;
-}
-
-static inline unsigned int dn_current_mss(struct sock *sk, int flags)
-{
-	struct dst_entry *dst = __sk_dst_get(sk);
-	struct dn_scp *scp = DN_SK(sk);
-	int mss_now = min_t(int, scp->segsize_loc, scp->segsize_rem);
-
-	/* Other data messages are limited to 16 bytes per packet */
-	if (flags & MSG_OOB)
-		return 16;
-
-	/* This works out the maximum size of segment we can send out */
-	if (dst) {
-		u32 mtu = dst_mtu(dst);
-		mss_now = min_t(int, dn_mss_from_pmtu(dst->dev, mtu), mss_now);
-	}
-
-	return mss_now;
-}
-
-/*
- * N.B. We get the timeout wrong here, but then we always did get it
- * wrong before and this is another step along the road to correcting
- * it. It ought to get updated each time we pass through the routine,
- * but in practise it probably doesn't matter too much for now.
- */
-static inline struct sk_buff *dn_alloc_send_pskb(struct sock *sk,
-			      unsigned long datalen, int noblock,
-			      int *errcode)
-{
-	struct sk_buff *skb = sock_alloc_send_skb(sk, datalen,
-						   noblock, errcode);
-	if (skb) {
-		skb->protocol = htons(ETH_P_DNA_RT);
-		skb->pkt_type = PACKET_OUTGOING;
-	}
-	return skb;
-}
-
-static int dn_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
-{
-	struct sock *sk = sock->sk;
-	struct dn_scp *scp = DN_SK(sk);
-	size_t mss;
-	struct sk_buff_head *queue = &scp->data_xmit_queue;
-	int flags = msg->msg_flags;
-	int err = 0;
-	size_t sent = 0;
-	int addr_len = msg->msg_namelen;
-	DECLARE_SOCKADDR(struct sockaddr_dn *, addr, msg->msg_name);
-	struct sk_buff *skb = NULL;
-	struct dn_skb_cb *cb;
-	size_t len;
-	unsigned char fctype;
-	long timeo;
-
-	if (flags & ~(MSG_TRYHARD|MSG_OOB|MSG_DONTWAIT|MSG_EOR|MSG_NOSIGNAL|MSG_MORE|MSG_CMSG_COMPAT))
-		return -EOPNOTSUPP;
-
-	if (addr_len && (addr_len != sizeof(struct sockaddr_dn)))
-		return -EINVAL;
-
-	lock_sock(sk);
-	timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
-	/*
-	 * The only difference between stream sockets and sequenced packet
-	 * sockets is that the stream sockets always behave as if MSG_EOR
-	 * has been set.
-	 */
-	if (sock->type == SOCK_STREAM) {
-		if (flags & MSG_EOR) {
-			err = -EINVAL;
-			goto out;
-		}
-		flags |= MSG_EOR;
-	}
-
-
-	err = dn_check_state(sk, addr, addr_len, &timeo, flags);
-	if (err)
-		goto out_err;
-
-	if (sk->sk_shutdown & SEND_SHUTDOWN) {
-		err = -EPIPE;
-		if (!(flags & MSG_NOSIGNAL))
-			send_sig(SIGPIPE, current, 0);
-		goto out_err;
-	}
-
-	if ((flags & MSG_TRYHARD) && sk->sk_dst_cache)
-		dst_negative_advice(sk);
-
-	mss = scp->segsize_rem;
-	fctype = scp->services_rem & NSP_FC_MASK;
-
-	mss = dn_current_mss(sk, flags);
-
-	if (flags & MSG_OOB) {
-		queue = &scp->other_xmit_queue;
-		if (size > mss) {
-			err = -EMSGSIZE;
-			goto out;
-		}
-	}
-
-	scp->persist_fxn = dn_nsp_xmit_timeout;
-
-	while(sent < size) {
-		err = sock_error(sk);
-		if (err)
-			goto out;
-
-		if (signal_pending(current)) {
-			err = sock_intr_errno(timeo);
-			goto out;
-		}
-
-		/*
-		 * Calculate size that we wish to send.
-		 */
-		len = size - sent;
-
-		if (len > mss)
-			len = mss;
-
-		/*
-		 * Wait for queue size to go down below the window
-		 * size.
-		 */
-		if (dn_queue_too_long(scp, queue, flags)) {
-			DEFINE_WAIT_FUNC(wait, woken_wake_function);
-
-			if (flags & MSG_DONTWAIT) {
-				err = -EWOULDBLOCK;
-				goto out;
-			}
-
-			add_wait_queue(sk_sleep(sk), &wait);
-			sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
-			sk_wait_event(sk, &timeo,
-				      !dn_queue_too_long(scp, queue, flags), &wait);
-			sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
-			remove_wait_queue(sk_sleep(sk), &wait);
-			continue;
-		}
-
-		/*
-		 * Get a suitably sized skb.
-		 * 64 is a bit of a hack really, but its larger than any
-		 * link-layer headers and has served us well as a good
-		 * guess as to their real length.
-		 */
-		skb = dn_alloc_send_pskb(sk, len + 64 + DN_MAX_NSP_DATA_HEADER,
-					 flags & MSG_DONTWAIT, &err);
-
-		if (err)
-			break;
-
-		if (!skb)
-			continue;
-
-		cb = DN_SKB_CB(skb);
-
-		skb_reserve(skb, 64 + DN_MAX_NSP_DATA_HEADER);
-
-		if (memcpy_from_msg(skb_put(skb, len), msg, len)) {
-			err = -EFAULT;
-			goto out;
-		}
-
-		if (flags & MSG_OOB) {
-			cb->nsp_flags = 0x30;
-			if (fctype != NSP_FC_NONE)
-				scp->flowrem_oth--;
-		} else {
-			cb->nsp_flags = 0x00;
-			if (scp->seg_total == 0)
-				cb->nsp_flags |= 0x20;
-
-			scp->seg_total += len;
-
-			if (((sent + len) == size) && (flags & MSG_EOR)) {
-				cb->nsp_flags |= 0x40;
-				scp->seg_total = 0;
-				if (fctype == NSP_FC_SCMC)
-					scp->flowrem_dat--;
-			}
-			if (fctype == NSP_FC_SRC)
-				scp->flowrem_dat--;
-		}
-
-		sent += len;
-		dn_nsp_queue_xmit(sk, skb, sk->sk_allocation, flags & MSG_OOB);
-		skb = NULL;
-
-		scp->persist = dn_nsp_persist(sk);
-
-	}
-out:
-
-	kfree_skb(skb);
-
-	release_sock(sk);
-
-	return sent ? sent : err;
-
-out_err:
-	err = sk_stream_error(sk, flags, err);
-	release_sock(sk);
-	return err;
-}
-
-static int dn_device_event(struct notifier_block *this, unsigned long event,
-			   void *ptr)
-{
-	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-
-	if (!net_eq(dev_net(dev), &init_net))
-		return NOTIFY_DONE;
-
-	switch (event) {
-	case NETDEV_UP:
-		dn_dev_up(dev);
-		break;
-	case NETDEV_DOWN:
-		dn_dev_down(dev);
-		break;
-	default:
-		break;
-	}
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block dn_dev_notifier = {
-	.notifier_call = dn_device_event,
-};
-
-static struct packet_type dn_dix_packet_type __read_mostly = {
-	.type =		cpu_to_be16(ETH_P_DNA_RT),
-	.func =		dn_route_rcv,
-};
-
-#ifdef CONFIG_PROC_FS
-struct dn_iter_state {
-	int bucket;
-};
-
-static struct sock *dn_socket_get_first(struct seq_file *seq)
-{
-	struct dn_iter_state *state = seq->private;
-	struct sock *n = NULL;
-
-	for(state->bucket = 0;
-	    state->bucket < DN_SK_HASH_SIZE;
-	    ++state->bucket) {
-		n = sk_head(&dn_sk_hash[state->bucket]);
-		if (n)
-			break;
-	}
-
-	return n;
-}
-
-static struct sock *dn_socket_get_next(struct seq_file *seq,
-				       struct sock *n)
-{
-	struct dn_iter_state *state = seq->private;
-
-	n = sk_next(n);
-	while (!n) {
-		if (++state->bucket >= DN_SK_HASH_SIZE)
-			break;
-		n = sk_head(&dn_sk_hash[state->bucket]);
-	}
-	return n;
-}
-
-static struct sock *socket_get_idx(struct seq_file *seq, loff_t *pos)
-{
-	struct sock *sk = dn_socket_get_first(seq);
-
-	if (sk) {
-		while(*pos && (sk = dn_socket_get_next(seq, sk)))
-			--*pos;
-	}
-	return *pos ? NULL : sk;
-}
-
-static void *dn_socket_get_idx(struct seq_file *seq, loff_t pos)
-{
-	void *rc;
-	read_lock_bh(&dn_hash_lock);
-	rc = socket_get_idx(seq, &pos);
-	if (!rc) {
-		read_unlock_bh(&dn_hash_lock);
-	}
-	return rc;
-}
-
-static void *dn_socket_seq_start(struct seq_file *seq, loff_t *pos)
-{
-	return *pos ? dn_socket_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
-}
-
-static void *dn_socket_seq_next(struct seq_file *seq, void *v, loff_t *pos)
-{
-	void *rc;
-
-	if (v == SEQ_START_TOKEN) {
-		rc = dn_socket_get_idx(seq, 0);
-		goto out;
-	}
-
-	rc = dn_socket_get_next(seq, v);
-	if (rc)
-		goto out;
-	read_unlock_bh(&dn_hash_lock);
-out:
-	++*pos;
-	return rc;
-}
-
-static void dn_socket_seq_stop(struct seq_file *seq, void *v)
-{
-	if (v && v != SEQ_START_TOKEN)
-		read_unlock_bh(&dn_hash_lock);
-}
-
-#define IS_NOT_PRINTABLE(x) ((x) < 32 || (x) > 126)
-
-static void dn_printable_object(struct sockaddr_dn *dn, unsigned char *buf)
-{
-	int i;
-
-	switch (le16_to_cpu(dn->sdn_objnamel)) {
-	case 0:
-		sprintf(buf, "%d", dn->sdn_objnum);
-		break;
-	default:
-		for (i = 0; i < le16_to_cpu(dn->sdn_objnamel); i++) {
-			buf[i] = dn->sdn_objname[i];
-			if (IS_NOT_PRINTABLE(buf[i]))
-				buf[i] = '.';
-		}
-		buf[i] = 0;
-	}
-}
-
-static char *dn_state2asc(unsigned char state)
-{
-	switch (state) {
-	case DN_O:
-		return "OPEN";
-	case DN_CR:
-		return "  CR";
-	case DN_DR:
-		return "  DR";
-	case DN_DRC:
-		return " DRC";
-	case DN_CC:
-		return "  CC";
-	case DN_CI:
-		return "  CI";
-	case DN_NR:
-		return "  NR";
-	case DN_NC:
-		return "  NC";
-	case DN_CD:
-		return "  CD";
-	case DN_RJ:
-		return "  RJ";
-	case DN_RUN:
-		return " RUN";
-	case DN_DI:
-		return "  DI";
-	case DN_DIC:
-		return " DIC";
-	case DN_DN:
-		return "  DN";
-	case DN_CL:
-		return "  CL";
-	case DN_CN:
-		return "  CN";
-	}
-
-	return "????";
-}
-
-static inline void dn_socket_format_entry(struct seq_file *seq, struct sock *sk)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	char buf1[DN_ASCBUF_LEN];
-	char buf2[DN_ASCBUF_LEN];
-	char local_object[DN_MAXOBJL+3];
-	char remote_object[DN_MAXOBJL+3];
-
-	dn_printable_object(&scp->addr, local_object);
-	dn_printable_object(&scp->peer, remote_object);
-
-	seq_printf(seq,
-		   "%6s/%04X %04d:%04d %04d:%04d %01d %-16s "
-		   "%6s/%04X %04d:%04d %04d:%04d %01d %-16s %4s %s\n",
-		   dn_addr2asc(le16_to_cpu(dn_saddr2dn(&scp->addr)), buf1),
-		   scp->addrloc,
-		   scp->numdat,
-		   scp->numoth,
-		   scp->ackxmt_dat,
-		   scp->ackxmt_oth,
-		   scp->flowloc_sw,
-		   local_object,
-		   dn_addr2asc(le16_to_cpu(dn_saddr2dn(&scp->peer)), buf2),
-		   scp->addrrem,
-		   scp->numdat_rcv,
-		   scp->numoth_rcv,
-		   scp->ackrcv_dat,
-		   scp->ackrcv_oth,
-		   scp->flowrem_sw,
-		   remote_object,
-		   dn_state2asc(scp->state),
-		   ((scp->accept_mode == ACC_IMMED) ? "IMMED" : "DEFER"));
-}
-
-static int dn_socket_seq_show(struct seq_file *seq, void *v)
-{
-	if (v == SEQ_START_TOKEN) {
-		seq_puts(seq, "Local                                              Remote\n");
-	} else {
-		dn_socket_format_entry(seq, v);
-	}
-	return 0;
-}
-
-static const struct seq_operations dn_socket_seq_ops = {
-	.start	= dn_socket_seq_start,
-	.next	= dn_socket_seq_next,
-	.stop	= dn_socket_seq_stop,
-	.show	= dn_socket_seq_show,
-};
-#endif
-
-static const struct net_proto_family	dn_family_ops = {
-	.family =	AF_DECnet,
-	.create =	dn_create,
-	.owner	=	THIS_MODULE,
-};
-
-static const struct proto_ops dn_proto_ops = {
-	.family =	AF_DECnet,
-	.owner =	THIS_MODULE,
-	.release =	dn_release,
-	.bind =		dn_bind,
-	.connect =	dn_connect,
-	.socketpair =	sock_no_socketpair,
-	.accept =	dn_accept,
-	.getname =	dn_getname,
-	.poll =		dn_poll,
-	.ioctl =	dn_ioctl,
-	.listen =	dn_listen,
-	.shutdown =	dn_shutdown,
-	.setsockopt =	dn_setsockopt,
-	.getsockopt =	dn_getsockopt,
-	.sendmsg =	dn_sendmsg,
-	.recvmsg =	dn_recvmsg,
-	.mmap =		sock_no_mmap,
-	.sendpage =	sock_no_sendpage,
-};
-
-MODULE_DESCRIPTION("The Linux DECnet Network Protocol");
-MODULE_AUTHOR("Linux DECnet Project Team");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_NETPROTO(PF_DECnet);
-
-static const char banner[] __initconst = KERN_INFO
-"NET4: DECnet for Linux: V.2.5.68s (C) 1995-2003 Linux DECnet Project Team\n";
-
-static int __init decnet_init(void)
-{
-	int rc;
-
-	printk(banner);
-
-	rc = proto_register(&dn_proto, 1);
-	if (rc != 0)
-		goto out;
-
-	dn_neigh_init();
-	dn_dev_init();
-	dn_route_init();
-	dn_fib_init();
-
-	sock_register(&dn_family_ops);
-	dev_add_pack(&dn_dix_packet_type);
-	register_netdevice_notifier(&dn_dev_notifier);
-
-	proc_create_seq_private("decnet", 0444, init_net.proc_net,
-			&dn_socket_seq_ops, sizeof(struct dn_iter_state),
-			NULL);
-	dn_register_sysctl();
-out:
-	return rc;
-
-}
-module_init(decnet_init);
-
-/*
- * Prevent DECnet module unloading until its fixed properly.
- * Requires an audit of the code to check for memory leaks and
- * initialisation problems etc.
- */
-#if 0
-static void __exit decnet_exit(void)
-{
-	sock_unregister(AF_DECnet);
-	rtnl_unregister_all(PF_DECnet);
-	dev_remove_pack(&dn_dix_packet_type);
-
-	dn_unregister_sysctl();
-
-	unregister_netdevice_notifier(&dn_dev_notifier);
-
-	dn_route_cleanup();
-	dn_dev_cleanup();
-	dn_neigh_cleanup();
-	dn_fib_cleanup();
-
-	remove_proc_entry("decnet", init_net.proc_net);
-
-	proto_unregister(&dn_proto);
-
-	rcu_barrier(); /* Wait for completion of call_rcu()'s */
-}
-module_exit(decnet_exit);
-#endif
diff --git a/net/decnet/dn_dev.c b/net/decnet/dn_dev.c
deleted file mode 100644
index 15d42353f1a3..000000000000
--- a/net/decnet/dn_dev.c
+++ /dev/null
@@ -1,1435 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * DECnet       An implementation of the DECnet protocol suite for the LINUX
- *              operating system.  DECnet is implemented using the  BSD Socket
- *              interface as the means of communication with the user level.
- *
- *              DECnet Device Layer
- *
- * Authors:     Steve Whitehouse <SteveW@ACM.org>
- *              Eduardo Marcelo Serrat <emserrat@geocities.com>
- *
- * Changes:
- *          Steve Whitehouse : Devices now see incoming frames so they
- *                             can mark on who it came from.
- *          Steve Whitehouse : Fixed bug in creating neighbours. Each neighbour
- *                             can now have a device specific setup func.
- *          Steve Whitehouse : Added /proc/sys/net/decnet/conf/<dev>/
- *          Steve Whitehouse : Fixed bug which sometimes killed timer
- *          Steve Whitehouse : Multiple ifaddr support
- *          Steve Whitehouse : SIOCGIFCONF is now a compile time option
- *          Steve Whitehouse : /proc/sys/net/decnet/conf/<sys>/forwarding
- *          Steve Whitehouse : Removed timer1 - it's a user space issue now
- *         Patrick Caulfield : Fixed router hello message format
- *          Steve Whitehouse : Got rid of constant sizes for blksize for
- *                             devices. All mtu based now.
- */
-
-#include <linux/capability.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/net.h>
-#include <linux/netdevice.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <linux/timer.h>
-#include <linux/string.h>
-#include <linux/if_addr.h>
-#include <linux/if_arp.h>
-#include <linux/if_ether.h>
-#include <linux/skbuff.h>
-#include <linux/sysctl.h>
-#include <linux/notifier.h>
-#include <linux/slab.h>
-#include <linux/jiffies.h>
-#include <linux/uaccess.h>
-#include <net/net_namespace.h>
-#include <net/neighbour.h>
-#include <net/dst.h>
-#include <net/flow.h>
-#include <net/fib_rules.h>
-#include <net/netlink.h>
-#include <net/dn.h>
-#include <net/dn_dev.h>
-#include <net/dn_route.h>
-#include <net/dn_neigh.h>
-#include <net/dn_fib.h>
-
-#define DN_IFREQ_SIZE (offsetof(struct ifreq, ifr_ifru) + sizeof(struct sockaddr_dn))
-
-static char dn_rt_all_end_mcast[ETH_ALEN] = {0xAB,0x00,0x00,0x04,0x00,0x00};
-static char dn_rt_all_rt_mcast[ETH_ALEN]  = {0xAB,0x00,0x00,0x03,0x00,0x00};
-static char dn_hiord[ETH_ALEN]            = {0xAA,0x00,0x04,0x00,0x00,0x00};
-static unsigned char dn_eco_version[3]    = {0x02,0x00,0x00};
-
-extern struct neigh_table dn_neigh_table;
-
-/*
- * decnet_address is kept in network order.
- */
-__le16 decnet_address = 0;
-
-static DEFINE_SPINLOCK(dndev_lock);
-static struct net_device *decnet_default_device;
-static BLOCKING_NOTIFIER_HEAD(dnaddr_chain);
-
-static struct dn_dev *dn_dev_create(struct net_device *dev, int *err);
-static void dn_dev_delete(struct net_device *dev);
-static void dn_ifaddr_notify(int event, struct dn_ifaddr *ifa);
-
-static int dn_eth_up(struct net_device *);
-static void dn_eth_down(struct net_device *);
-static void dn_send_brd_hello(struct net_device *dev, struct dn_ifaddr *ifa);
-static void dn_send_ptp_hello(struct net_device *dev, struct dn_ifaddr *ifa);
-
-static struct dn_dev_parms dn_dev_list[] =  {
-{
-	.type =		ARPHRD_ETHER, /* Ethernet */
-	.mode =		DN_DEV_BCAST,
-	.state =	DN_DEV_S_RU,
-	.t2 =		1,
-	.t3 =		10,
-	.name =		"ethernet",
-	.up =		dn_eth_up,
-	.down = 	dn_eth_down,
-	.timer3 =	dn_send_brd_hello,
-},
-{
-	.type =		ARPHRD_IPGRE, /* DECnet tunneled over GRE in IP */
-	.mode =		DN_DEV_BCAST,
-	.state =	DN_DEV_S_RU,
-	.t2 =		1,
-	.t3 =		10,
-	.name =		"ipgre",
-	.timer3 =	dn_send_brd_hello,
-},
-#if 0
-{
-	.type =		ARPHRD_X25, /* Bog standard X.25 */
-	.mode =		DN_DEV_UCAST,
-	.state =	DN_DEV_S_DS,
-	.t2 =		1,
-	.t3 =		120,
-	.name =		"x25",
-	.timer3 =	dn_send_ptp_hello,
-},
-#endif
-#if 0
-{
-	.type =		ARPHRD_PPP, /* DECnet over PPP */
-	.mode =		DN_DEV_BCAST,
-	.state =	DN_DEV_S_RU,
-	.t2 =		1,
-	.t3 =		10,
-	.name =		"ppp",
-	.timer3 =	dn_send_brd_hello,
-},
-#endif
-{
-	.type =		ARPHRD_DDCMP, /* DECnet over DDCMP */
-	.mode =		DN_DEV_UCAST,
-	.state =	DN_DEV_S_DS,
-	.t2 =		1,
-	.t3 =		120,
-	.name =		"ddcmp",
-	.timer3 =	dn_send_ptp_hello,
-},
-{
-	.type =		ARPHRD_LOOPBACK, /* Loopback interface - always last */
-	.mode =		DN_DEV_BCAST,
-	.state =	DN_DEV_S_RU,
-	.t2 =		1,
-	.t3 =		10,
-	.name =		"loopback",
-	.timer3 =	dn_send_brd_hello,
-}
-};
-
-#define DN_DEV_LIST_SIZE ARRAY_SIZE(dn_dev_list)
-
-#define DN_DEV_PARMS_OFFSET(x) offsetof(struct dn_dev_parms, x)
-
-#ifdef CONFIG_SYSCTL
-
-static int min_t2[] = { 1 };
-static int max_t2[] = { 60 }; /* No max specified, but this seems sensible */
-static int min_t3[] = { 1 };
-static int max_t3[] = { 8191 }; /* Must fit in 16 bits when multiplied by BCT3MULT or T3MULT */
-
-static int min_priority[1];
-static int max_priority[] = { 127 }; /* From DECnet spec */
-
-static int dn_forwarding_proc(struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-static struct dn_dev_sysctl_table {
-	struct ctl_table_header *sysctl_header;
-	struct ctl_table dn_dev_vars[5];
-} dn_dev_sysctl = {
-	NULL,
-	{
-	{
-		.procname = "forwarding",
-		.data = (void *)DN_DEV_PARMS_OFFSET(forwarding),
-		.maxlen = sizeof(int),
-		.mode = 0644,
-		.proc_handler = dn_forwarding_proc,
-	},
-	{
-		.procname = "priority",
-		.data = (void *)DN_DEV_PARMS_OFFSET(priority),
-		.maxlen = sizeof(int),
-		.mode = 0644,
-		.proc_handler = proc_dointvec_minmax,
-		.extra1 = &min_priority,
-		.extra2 = &max_priority
-	},
-	{
-		.procname = "t2",
-		.data = (void *)DN_DEV_PARMS_OFFSET(t2),
-		.maxlen = sizeof(int),
-		.mode = 0644,
-		.proc_handler = proc_dointvec_minmax,
-		.extra1 = &min_t2,
-		.extra2 = &max_t2
-	},
-	{
-		.procname = "t3",
-		.data = (void *)DN_DEV_PARMS_OFFSET(t3),
-		.maxlen = sizeof(int),
-		.mode = 0644,
-		.proc_handler = proc_dointvec_minmax,
-		.extra1 = &min_t3,
-		.extra2 = &max_t3
-	},
-	{ }
-	},
-};
-
-static void dn_dev_sysctl_register(struct net_device *dev, struct dn_dev_parms *parms)
-{
-	struct dn_dev_sysctl_table *t;
-	int i;
-
-	char path[sizeof("net/decnet/conf/") + IFNAMSIZ];
-
-	t = kmemdup(&dn_dev_sysctl, sizeof(*t), GFP_KERNEL);
-	if (t == NULL)
-		return;
-
-	for(i = 0; i < ARRAY_SIZE(t->dn_dev_vars) - 1; i++) {
-		long offset = (long)t->dn_dev_vars[i].data;
-		t->dn_dev_vars[i].data = ((char *)parms) + offset;
-	}
-
-	snprintf(path, sizeof(path), "net/decnet/conf/%s",
-		dev? dev->name : parms->name);
-
-	t->dn_dev_vars[0].extra1 = (void *)dev;
-
-	t->sysctl_header = register_net_sysctl(&init_net, path, t->dn_dev_vars);
-	if (t->sysctl_header == NULL)
-		kfree(t);
-	else
-		parms->sysctl = t;
-}
-
-static void dn_dev_sysctl_unregister(struct dn_dev_parms *parms)
-{
-	if (parms->sysctl) {
-		struct dn_dev_sysctl_table *t = parms->sysctl;
-		parms->sysctl = NULL;
-		unregister_net_sysctl_table(t->sysctl_header);
-		kfree(t);
-	}
-}
-
-static int dn_forwarding_proc(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
-{
-#ifdef CONFIG_DECNET_ROUTER
-	struct net_device *dev = table->extra1;
-	struct dn_dev *dn_db;
-	int err;
-	int tmp, old;
-
-	if (table->extra1 == NULL)
-		return -EINVAL;
-
-	dn_db = rcu_dereference_raw(dev->dn_ptr);
-	old = dn_db->parms.forwarding;
-
-	err = proc_dointvec(table, write, buffer, lenp, ppos);
-
-	if ((err >= 0) && write) {
-		if (dn_db->parms.forwarding < 0)
-			dn_db->parms.forwarding = 0;
-		if (dn_db->parms.forwarding > 2)
-			dn_db->parms.forwarding = 2;
-		/*
-		 * What an ugly hack this is... its works, just. It
-		 * would be nice if sysctl/proc were just that little
-		 * bit more flexible so I don't have to write a special
-		 * routine, or suffer hacks like this - SJW
-		 */
-		tmp = dn_db->parms.forwarding;
-		dn_db->parms.forwarding = old;
-		if (dn_db->parms.down)
-			dn_db->parms.down(dev);
-		dn_db->parms.forwarding = tmp;
-		if (dn_db->parms.up)
-			dn_db->parms.up(dev);
-	}
-
-	return err;
-#else
-	return -EINVAL;
-#endif
-}
-
-#else /* CONFIG_SYSCTL */
-static void dn_dev_sysctl_unregister(struct dn_dev_parms *parms)
-{
-}
-static void dn_dev_sysctl_register(struct net_device *dev, struct dn_dev_parms *parms)
-{
-}
-
-#endif /* CONFIG_SYSCTL */
-
-static inline __u16 mtu2blksize(struct net_device *dev)
-{
-	u32 blksize = dev->mtu;
-	if (blksize > 0xffff)
-		blksize = 0xffff;
-
-	if (dev->type == ARPHRD_ETHER ||
-	    dev->type == ARPHRD_PPP ||
-	    dev->type == ARPHRD_IPGRE ||
-	    dev->type == ARPHRD_LOOPBACK)
-		blksize -= 2;
-
-	return (__u16)blksize;
-}
-
-static struct dn_ifaddr *dn_dev_alloc_ifa(void)
-{
-	struct dn_ifaddr *ifa;
-
-	ifa = kzalloc(sizeof(*ifa), GFP_KERNEL);
-
-	return ifa;
-}
-
-static void dn_dev_free_ifa(struct dn_ifaddr *ifa)
-{
-	kfree_rcu(ifa, rcu);
-}
-
-static void dn_dev_del_ifa(struct dn_dev *dn_db, struct dn_ifaddr __rcu **ifap, int destroy)
-{
-	struct dn_ifaddr *ifa1 = rtnl_dereference(*ifap);
-	unsigned char mac_addr[6];
-	struct net_device *dev = dn_db->dev;
-
-	ASSERT_RTNL();
-
-	*ifap = ifa1->ifa_next;
-
-	if (dn_db->dev->type == ARPHRD_ETHER) {
-		if (ifa1->ifa_local != dn_eth2dn(dev->dev_addr)) {
-			dn_dn2eth(mac_addr, ifa1->ifa_local);
-			dev_mc_del(dev, mac_addr);
-		}
-	}
-
-	dn_ifaddr_notify(RTM_DELADDR, ifa1);
-	blocking_notifier_call_chain(&dnaddr_chain, NETDEV_DOWN, ifa1);
-	if (destroy) {
-		dn_dev_free_ifa(ifa1);
-
-		if (dn_db->ifa_list == NULL)
-			dn_dev_delete(dn_db->dev);
-	}
-}
-
-static int dn_dev_insert_ifa(struct dn_dev *dn_db, struct dn_ifaddr *ifa)
-{
-	struct net_device *dev = dn_db->dev;
-	struct dn_ifaddr *ifa1;
-	unsigned char mac_addr[6];
-
-	ASSERT_RTNL();
-
-	/* Check for duplicates */
-	for (ifa1 = rtnl_dereference(dn_db->ifa_list);
-	     ifa1 != NULL;
-	     ifa1 = rtnl_dereference(ifa1->ifa_next)) {
-		if (ifa1->ifa_local == ifa->ifa_local)
-			return -EEXIST;
-	}
-
-	if (dev->type == ARPHRD_ETHER) {
-		if (ifa->ifa_local != dn_eth2dn(dev->dev_addr)) {
-			dn_dn2eth(mac_addr, ifa->ifa_local);
-			dev_mc_add(dev, mac_addr);
-		}
-	}
-
-	ifa->ifa_next = dn_db->ifa_list;
-	rcu_assign_pointer(dn_db->ifa_list, ifa);
-
-	dn_ifaddr_notify(RTM_NEWADDR, ifa);
-	blocking_notifier_call_chain(&dnaddr_chain, NETDEV_UP, ifa);
-
-	return 0;
-}
-
-static int dn_dev_set_ifa(struct net_device *dev, struct dn_ifaddr *ifa)
-{
-	struct dn_dev *dn_db = rtnl_dereference(dev->dn_ptr);
-	int rv;
-
-	if (dn_db == NULL) {
-		int err;
-		dn_db = dn_dev_create(dev, &err);
-		if (dn_db == NULL)
-			return err;
-	}
-
-	ifa->ifa_dev = dn_db;
-
-	if (dev->flags & IFF_LOOPBACK)
-		ifa->ifa_scope = RT_SCOPE_HOST;
-
-	rv = dn_dev_insert_ifa(dn_db, ifa);
-	if (rv)
-		dn_dev_free_ifa(ifa);
-	return rv;
-}
-
-
-int dn_dev_ioctl(unsigned int cmd, void __user *arg)
-{
-	char buffer[DN_IFREQ_SIZE];
-	struct ifreq *ifr = (struct ifreq *)buffer;
-	struct sockaddr_dn *sdn = (struct sockaddr_dn *)&ifr->ifr_addr;
-	struct dn_dev *dn_db;
-	struct net_device *dev;
-	struct dn_ifaddr *ifa = NULL;
-	struct dn_ifaddr __rcu **ifap = NULL;
-	int ret = 0;
-
-	if (copy_from_user(ifr, arg, DN_IFREQ_SIZE))
-		return -EFAULT;
-	ifr->ifr_name[IFNAMSIZ-1] = 0;
-
-	dev_load(&init_net, ifr->ifr_name);
-
-	switch (cmd) {
-	case SIOCGIFADDR:
-		break;
-	case SIOCSIFADDR:
-		if (!capable(CAP_NET_ADMIN))
-			return -EACCES;
-		if (sdn->sdn_family != AF_DECnet)
-			return -EINVAL;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	rtnl_lock();
-
-	if ((dev = __dev_get_by_name(&init_net, ifr->ifr_name)) == NULL) {
-		ret = -ENODEV;
-		goto done;
-	}
-
-	if ((dn_db = rtnl_dereference(dev->dn_ptr)) != NULL) {
-		for (ifap = &dn_db->ifa_list;
-		     (ifa = rtnl_dereference(*ifap)) != NULL;
-		     ifap = &ifa->ifa_next)
-			if (strcmp(ifr->ifr_name, ifa->ifa_label) == 0)
-				break;
-	}
-
-	if (ifa == NULL && cmd != SIOCSIFADDR) {
-		ret = -EADDRNOTAVAIL;
-		goto done;
-	}
-
-	switch (cmd) {
-	case SIOCGIFADDR:
-		*((__le16 *)sdn->sdn_nodeaddr) = ifa->ifa_local;
-		if (copy_to_user(arg, ifr, DN_IFREQ_SIZE))
-			ret = -EFAULT;
-		break;
-
-	case SIOCSIFADDR:
-		if (!ifa) {
-			if ((ifa = dn_dev_alloc_ifa()) == NULL) {
-				ret = -ENOBUFS;
-				break;
-			}
-			memcpy(ifa->ifa_label, dev->name, IFNAMSIZ);
-		} else {
-			if (ifa->ifa_local == dn_saddr2dn(sdn))
-				break;
-			dn_dev_del_ifa(dn_db, ifap, 0);
-		}
-
-		ifa->ifa_local = ifa->ifa_address = dn_saddr2dn(sdn);
-
-		ret = dn_dev_set_ifa(dev, ifa);
-	}
-done:
-	rtnl_unlock();
-
-	return ret;
-}
-
-struct net_device *dn_dev_get_default(void)
-{
-	struct net_device *dev;
-
-	spin_lock(&dndev_lock);
-	dev = decnet_default_device;
-	if (dev) {
-		if (dev->dn_ptr)
-			dev_hold(dev);
-		else
-			dev = NULL;
-	}
-	spin_unlock(&dndev_lock);
-
-	return dev;
-}
-
-int dn_dev_set_default(struct net_device *dev, int force)
-{
-	struct net_device *old = NULL;
-	int rv = -EBUSY;
-	if (!dev->dn_ptr)
-		return -ENODEV;
-
-	spin_lock(&dndev_lock);
-	if (force || decnet_default_device == NULL) {
-		old = decnet_default_device;
-		decnet_default_device = dev;
-		rv = 0;
-	}
-	spin_unlock(&dndev_lock);
-
-	if (old)
-		dev_put(old);
-	return rv;
-}
-
-static void dn_dev_check_default(struct net_device *dev)
-{
-	spin_lock(&dndev_lock);
-	if (dev == decnet_default_device) {
-		decnet_default_device = NULL;
-	} else {
-		dev = NULL;
-	}
-	spin_unlock(&dndev_lock);
-
-	if (dev)
-		dev_put(dev);
-}
-
-/*
- * Called with RTNL
- */
-static struct dn_dev *dn_dev_by_index(int ifindex)
-{
-	struct net_device *dev;
-	struct dn_dev *dn_dev = NULL;
-
-	dev = __dev_get_by_index(&init_net, ifindex);
-	if (dev)
-		dn_dev = rtnl_dereference(dev->dn_ptr);
-
-	return dn_dev;
-}
-
-static const struct nla_policy dn_ifa_policy[IFA_MAX+1] = {
-	[IFA_ADDRESS]		= { .type = NLA_U16 },
-	[IFA_LOCAL]		= { .type = NLA_U16 },
-	[IFA_LABEL]		= { .type = NLA_STRING,
-				    .len = IFNAMSIZ - 1 },
-	[IFA_FLAGS]		= { .type = NLA_U32 },
-};
-
-static int dn_nl_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
-			 struct netlink_ext_ack *extack)
-{
-	struct net *net = sock_net(skb->sk);
-	struct nlattr *tb[IFA_MAX+1];
-	struct dn_dev *dn_db;
-	struct ifaddrmsg *ifm;
-	struct dn_ifaddr *ifa;
-	struct dn_ifaddr __rcu **ifap;
-	int err = -EINVAL;
-
-	if (!netlink_capable(skb, CAP_NET_ADMIN))
-		return -EPERM;
-
-	if (!net_eq(net, &init_net))
-		goto errout;
-
-	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFA_MAX,
-				     dn_ifa_policy, extack);
-	if (err < 0)
-		goto errout;
-
-	err = -ENODEV;
-	ifm = nlmsg_data(nlh);
-	if ((dn_db = dn_dev_by_index(ifm->ifa_index)) == NULL)
-		goto errout;
-
-	err = -EADDRNOTAVAIL;
-	for (ifap = &dn_db->ifa_list;
-	     (ifa = rtnl_dereference(*ifap)) != NULL;
-	     ifap = &ifa->ifa_next) {
-		if (tb[IFA_LOCAL] &&
-		    nla_memcmp(tb[IFA_LOCAL], &ifa->ifa_local, 2))
-			continue;
-
-		if (tb[IFA_LABEL] && nla_strcmp(tb[IFA_LABEL], ifa->ifa_label))
-			continue;
-
-		dn_dev_del_ifa(dn_db, ifap, 1);
-		return 0;
-	}
-
-errout:
-	return err;
-}
-
-static int dn_nl_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
-			 struct netlink_ext_ack *extack)
-{
-	struct net *net = sock_net(skb->sk);
-	struct nlattr *tb[IFA_MAX+1];
-	struct net_device *dev;
-	struct dn_dev *dn_db;
-	struct ifaddrmsg *ifm;
-	struct dn_ifaddr *ifa;
-	int err;
-
-	if (!netlink_capable(skb, CAP_NET_ADMIN))
-		return -EPERM;
-
-	if (!net_eq(net, &init_net))
-		return -EINVAL;
-
-	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFA_MAX,
-				     dn_ifa_policy, extack);
-	if (err < 0)
-		return err;
-
-	if (tb[IFA_LOCAL] == NULL)
-		return -EINVAL;
-
-	ifm = nlmsg_data(nlh);
-	if ((dev = __dev_get_by_index(&init_net, ifm->ifa_index)) == NULL)
-		return -ENODEV;
-
-	if ((dn_db = rtnl_dereference(dev->dn_ptr)) == NULL) {
-		dn_db = dn_dev_create(dev, &err);
-		if (!dn_db)
-			return err;
-	}
-
-	if ((ifa = dn_dev_alloc_ifa()) == NULL)
-		return -ENOBUFS;
-
-	if (tb[IFA_ADDRESS] == NULL)
-		tb[IFA_ADDRESS] = tb[IFA_LOCAL];
-
-	ifa->ifa_local = nla_get_le16(tb[IFA_LOCAL]);
-	ifa->ifa_address = nla_get_le16(tb[IFA_ADDRESS]);
-	ifa->ifa_flags = tb[IFA_FLAGS] ? nla_get_u32(tb[IFA_FLAGS]) :
-					 ifm->ifa_flags;
-	ifa->ifa_scope = ifm->ifa_scope;
-	ifa->ifa_dev = dn_db;
-
-	if (tb[IFA_LABEL])
-		nla_strlcpy(ifa->ifa_label, tb[IFA_LABEL], IFNAMSIZ);
-	else
-		memcpy(ifa->ifa_label, dev->name, IFNAMSIZ);
-
-	err = dn_dev_insert_ifa(dn_db, ifa);
-	if (err)
-		dn_dev_free_ifa(ifa);
-
-	return err;
-}
-
-static inline size_t dn_ifaddr_nlmsg_size(void)
-{
-	return NLMSG_ALIGN(sizeof(struct ifaddrmsg))
-	       + nla_total_size(IFNAMSIZ) /* IFA_LABEL */
-	       + nla_total_size(2) /* IFA_ADDRESS */
-	       + nla_total_size(2) /* IFA_LOCAL */
-	       + nla_total_size(4); /* IFA_FLAGS */
-}
-
-static int dn_nl_fill_ifaddr(struct sk_buff *skb, struct dn_ifaddr *ifa,
-			     u32 portid, u32 seq, int event, unsigned int flags)
-{
-	struct ifaddrmsg *ifm;
-	struct nlmsghdr *nlh;
-	u32 ifa_flags = ifa->ifa_flags | IFA_F_PERMANENT;
-
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*ifm), flags);
-	if (nlh == NULL)
-		return -EMSGSIZE;
-
-	ifm = nlmsg_data(nlh);
-	ifm->ifa_family = AF_DECnet;
-	ifm->ifa_prefixlen = 16;
-	ifm->ifa_flags = ifa_flags;
-	ifm->ifa_scope = ifa->ifa_scope;
-	ifm->ifa_index = ifa->ifa_dev->dev->ifindex;
-
-	if ((ifa->ifa_address &&
-	     nla_put_le16(skb, IFA_ADDRESS, ifa->ifa_address)) ||
-	    (ifa->ifa_local &&
-	     nla_put_le16(skb, IFA_LOCAL, ifa->ifa_local)) ||
-	    (ifa->ifa_label[0] &&
-	     nla_put_string(skb, IFA_LABEL, ifa->ifa_label)) ||
-	     nla_put_u32(skb, IFA_FLAGS, ifa_flags))
-		goto nla_put_failure;
-	nlmsg_end(skb, nlh);
-	return 0;
-
-nla_put_failure:
-	nlmsg_cancel(skb, nlh);
-	return -EMSGSIZE;
-}
-
-static void dn_ifaddr_notify(int event, struct dn_ifaddr *ifa)
-{
-	struct sk_buff *skb;
-	int err = -ENOBUFS;
-
-	skb = alloc_skb(dn_ifaddr_nlmsg_size(), GFP_KERNEL);
-	if (skb == NULL)
-		goto errout;
-
-	err = dn_nl_fill_ifaddr(skb, ifa, 0, 0, event, 0);
-	if (err < 0) {
-		/* -EMSGSIZE implies BUG in dn_ifaddr_nlmsg_size() */
-		WARN_ON(err == -EMSGSIZE);
-		kfree_skb(skb);
-		goto errout;
-	}
-	rtnl_notify(skb, &init_net, 0, RTNLGRP_DECnet_IFADDR, NULL, GFP_KERNEL);
-	return;
-errout:
-	if (err < 0)
-		rtnl_set_sk_err(&init_net, RTNLGRP_DECnet_IFADDR, err);
-}
-
-static int dn_nl_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
-{
-	struct net *net = sock_net(skb->sk);
-	int idx, dn_idx = 0, skip_ndevs, skip_naddr;
-	struct net_device *dev;
-	struct dn_dev *dn_db;
-	struct dn_ifaddr *ifa;
-
-	if (!net_eq(net, &init_net))
-		return 0;
-
-	skip_ndevs = cb->args[0];
-	skip_naddr = cb->args[1];
-
-	idx = 0;
-	rcu_read_lock();
-	for_each_netdev_rcu(&init_net, dev) {
-		if (idx < skip_ndevs)
-			goto cont;
-		else if (idx > skip_ndevs) {
-			/* Only skip over addresses for first dev dumped
-			 * in this iteration (idx == skip_ndevs) */
-			skip_naddr = 0;
-		}
-
-		if ((dn_db = rcu_dereference(dev->dn_ptr)) == NULL)
-			goto cont;
-
-		for (ifa = rcu_dereference(dn_db->ifa_list), dn_idx = 0; ifa;
-		     ifa = rcu_dereference(ifa->ifa_next), dn_idx++) {
-			if (dn_idx < skip_naddr)
-				continue;
-
-			if (dn_nl_fill_ifaddr(skb, ifa, NETLINK_CB(cb->skb).portid,
-					      cb->nlh->nlmsg_seq, RTM_NEWADDR,
-					      NLM_F_MULTI) < 0)
-				goto done;
-		}
-cont:
-		idx++;
-	}
-done:
-	rcu_read_unlock();
-	cb->args[0] = idx;
-	cb->args[1] = dn_idx;
-
-	return skb->len;
-}
-
-static int dn_dev_get_first(struct net_device *dev, __le16 *addr)
-{
-	struct dn_dev *dn_db;
-	struct dn_ifaddr *ifa;
-	int rv = -ENODEV;
-
-	rcu_read_lock();
-	dn_db = rcu_dereference(dev->dn_ptr);
-	if (dn_db == NULL)
-		goto out;
-
-	ifa = rcu_dereference(dn_db->ifa_list);
-	if (ifa != NULL) {
-		*addr = ifa->ifa_local;
-		rv = 0;
-	}
-out:
-	rcu_read_unlock();
-	return rv;
-}
-
-/*
- * Find a default address to bind to.
- *
- * This is one of those areas where the initial VMS concepts don't really
- * map onto the Linux concepts, and since we introduced multiple addresses
- * per interface we have to cope with slightly odd ways of finding out what
- * "our address" really is. Mostly it's not a problem; for this we just guess
- * a sensible default. Eventually the routing code will take care of all the
- * nasties for us I hope.
- */
-int dn_dev_bind_default(__le16 *addr)
-{
-	struct net_device *dev;
-	int rv;
-	dev = dn_dev_get_default();
-last_chance:
-	if (dev) {
-		rv = dn_dev_get_first(dev, addr);
-		dev_put(dev);
-		if (rv == 0 || dev == init_net.loopback_dev)
-			return rv;
-	}
-	dev = init_net.loopback_dev;
-	dev_hold(dev);
-	goto last_chance;
-}
-
-static void dn_send_endnode_hello(struct net_device *dev, struct dn_ifaddr *ifa)
-{
-	struct endnode_hello_message *msg;
-	struct sk_buff *skb = NULL;
-	__le16 *pktlen;
-	struct dn_dev *dn_db = rcu_dereference_raw(dev->dn_ptr);
-
-	if ((skb = dn_alloc_skb(NULL, sizeof(*msg), GFP_ATOMIC)) == NULL)
-		return;
-
-	skb->dev = dev;
-
-	msg = skb_put(skb, sizeof(*msg));
-
-	msg->msgflg  = 0x0D;
-	memcpy(msg->tiver, dn_eco_version, 3);
-	dn_dn2eth(msg->id, ifa->ifa_local);
-	msg->iinfo   = DN_RT_INFO_ENDN;
-	msg->blksize = cpu_to_le16(mtu2blksize(dev));
-	msg->area    = 0x00;
-	memset(msg->seed, 0, 8);
-	memcpy(msg->neighbor, dn_hiord, ETH_ALEN);
-
-	if (dn_db->router) {
-		struct dn_neigh *dn = (struct dn_neigh *)dn_db->router;
-		dn_dn2eth(msg->neighbor, dn->addr);
-	}
-
-	msg->timer   = cpu_to_le16((unsigned short)dn_db->parms.t3);
-	msg->mpd     = 0x00;
-	msg->datalen = 0x02;
-	memset(msg->data, 0xAA, 2);
-
-	pktlen = skb_push(skb, 2);
-	*pktlen = cpu_to_le16(skb->len - 2);
-
-	skb_reset_network_header(skb);
-
-	dn_rt_finish_output(skb, dn_rt_all_rt_mcast, msg->id);
-}
-
-
-#define DRDELAY (5 * HZ)
-
-static int dn_am_i_a_router(struct dn_neigh *dn, struct dn_dev *dn_db, struct dn_ifaddr *ifa)
-{
-	/* First check time since device went up */
-	if (time_before(jiffies, dn_db->uptime + DRDELAY))
-		return 0;
-
-	/* If there is no router, then yes... */
-	if (!dn_db->router)
-		return 1;
-
-	/* otherwise only if we have a higher priority or.. */
-	if (dn->priority < dn_db->parms.priority)
-		return 1;
-
-	/* if we have equal priority and a higher node number */
-	if (dn->priority != dn_db->parms.priority)
-		return 0;
-
-	if (le16_to_cpu(dn->addr) < le16_to_cpu(ifa->ifa_local))
-		return 1;
-
-	return 0;
-}
-
-static void dn_send_router_hello(struct net_device *dev, struct dn_ifaddr *ifa)
-{
-	int n;
-	struct dn_dev *dn_db = rcu_dereference_raw(dev->dn_ptr);
-	struct dn_neigh *dn = (struct dn_neigh *)dn_db->router;
-	struct sk_buff *skb;
-	size_t size;
-	unsigned char *ptr;
-	unsigned char *i1, *i2;
-	__le16 *pktlen;
-	char *src;
-
-	if (mtu2blksize(dev) < (26 + 7))
-		return;
-
-	n = mtu2blksize(dev) - 26;
-	n /= 7;
-
-	if (n > 32)
-		n = 32;
-
-	size = 2 + 26 + 7 * n;
-
-	if ((skb = dn_alloc_skb(NULL, size, GFP_ATOMIC)) == NULL)
-		return;
-
-	skb->dev = dev;
-	ptr = skb_put(skb, size);
-
-	*ptr++ = DN_RT_PKT_CNTL | DN_RT_PKT_ERTH;
-	*ptr++ = 2; /* ECO */
-	*ptr++ = 0;
-	*ptr++ = 0;
-	dn_dn2eth(ptr, ifa->ifa_local);
-	src = ptr;
-	ptr += ETH_ALEN;
-	*ptr++ = dn_db->parms.forwarding == 1 ?
-			DN_RT_INFO_L1RT : DN_RT_INFO_L2RT;
-	*((__le16 *)ptr) = cpu_to_le16(mtu2blksize(dev));
-	ptr += 2;
-	*ptr++ = dn_db->parms.priority; /* Priority */
-	*ptr++ = 0; /* Area: Reserved */
-	*((__le16 *)ptr) = cpu_to_le16((unsigned short)dn_db->parms.t3);
-	ptr += 2;
-	*ptr++ = 0; /* MPD: Reserved */
-	i1 = ptr++;
-	memset(ptr, 0, 7); /* Name: Reserved */
-	ptr += 7;
-	i2 = ptr++;
-
-	n = dn_neigh_elist(dev, ptr, n);
-
-	*i2 = 7 * n;
-	*i1 = 8 + *i2;
-
-	skb_trim(skb, (27 + *i2));
-
-	pktlen = skb_push(skb, 2);
-	*pktlen = cpu_to_le16(skb->len - 2);
-
-	skb_reset_network_header(skb);
-
-	if (dn_am_i_a_router(dn, dn_db, ifa)) {
-		struct sk_buff *skb2 = skb_copy(skb, GFP_ATOMIC);
-		if (skb2) {
-			dn_rt_finish_output(skb2, dn_rt_all_end_mcast, src);
-		}
-	}
-
-	dn_rt_finish_output(skb, dn_rt_all_rt_mcast, src);
-}
-
-static void dn_send_brd_hello(struct net_device *dev, struct dn_ifaddr *ifa)
-{
-	struct dn_dev *dn_db = rcu_dereference_raw(dev->dn_ptr);
-
-	if (dn_db->parms.forwarding == 0)
-		dn_send_endnode_hello(dev, ifa);
-	else
-		dn_send_router_hello(dev, ifa);
-}
-
-static void dn_send_ptp_hello(struct net_device *dev, struct dn_ifaddr *ifa)
-{
-	int tdlen = 16;
-	int size = dev->hard_header_len + 2 + 4 + tdlen;
-	struct sk_buff *skb = dn_alloc_skb(NULL, size, GFP_ATOMIC);
-	int i;
-	unsigned char *ptr;
-	char src[ETH_ALEN];
-
-	if (skb == NULL)
-		return ;
-
-	skb->dev = dev;
-	skb_push(skb, dev->hard_header_len);
-	ptr = skb_put(skb, 2 + 4 + tdlen);
-
-	*ptr++ = DN_RT_PKT_HELO;
-	*((__le16 *)ptr) = ifa->ifa_local;
-	ptr += 2;
-	*ptr++ = tdlen;
-
-	for(i = 0; i < tdlen; i++)
-		*ptr++ = 0252;
-
-	dn_dn2eth(src, ifa->ifa_local);
-	dn_rt_finish_output(skb, dn_rt_all_rt_mcast, src);
-}
-
-static int dn_eth_up(struct net_device *dev)
-{
-	struct dn_dev *dn_db = rcu_dereference_raw(dev->dn_ptr);
-
-	if (dn_db->parms.forwarding == 0)
-		dev_mc_add(dev, dn_rt_all_end_mcast);
-	else
-		dev_mc_add(dev, dn_rt_all_rt_mcast);
-
-	dn_db->use_long = 1;
-
-	return 0;
-}
-
-static void dn_eth_down(struct net_device *dev)
-{
-	struct dn_dev *dn_db = rcu_dereference_raw(dev->dn_ptr);
-
-	if (dn_db->parms.forwarding == 0)
-		dev_mc_del(dev, dn_rt_all_end_mcast);
-	else
-		dev_mc_del(dev, dn_rt_all_rt_mcast);
-}
-
-static void dn_dev_set_timer(struct net_device *dev);
-
-static void dn_dev_timer_func(struct timer_list *t)
-{
-	struct dn_dev *dn_db = from_timer(dn_db, t, timer);
-	struct net_device *dev;
-	struct dn_ifaddr *ifa;
-
-	rcu_read_lock();
-	dev = dn_db->dev;
-	if (dn_db->t3 <= dn_db->parms.t2) {
-		if (dn_db->parms.timer3) {
-			for (ifa = rcu_dereference(dn_db->ifa_list);
-			     ifa;
-			     ifa = rcu_dereference(ifa->ifa_next)) {
-				if (!(ifa->ifa_flags & IFA_F_SECONDARY))
-					dn_db->parms.timer3(dev, ifa);
-			}
-		}
-		dn_db->t3 = dn_db->parms.t3;
-	} else {
-		dn_db->t3 -= dn_db->parms.t2;
-	}
-	rcu_read_unlock();
-	dn_dev_set_timer(dev);
-}
-
-static void dn_dev_set_timer(struct net_device *dev)
-{
-	struct dn_dev *dn_db = rcu_dereference_raw(dev->dn_ptr);
-
-	if (dn_db->parms.t2 > dn_db->parms.t3)
-		dn_db->parms.t2 = dn_db->parms.t3;
-
-	dn_db->timer.expires = jiffies + (dn_db->parms.t2 * HZ);
-
-	add_timer(&dn_db->timer);
-}
-
-static struct dn_dev *dn_dev_create(struct net_device *dev, int *err)
-{
-	int i;
-	struct dn_dev_parms *p = dn_dev_list;
-	struct dn_dev *dn_db;
-
-	for(i = 0; i < DN_DEV_LIST_SIZE; i++, p++) {
-		if (p->type == dev->type)
-			break;
-	}
-
-	*err = -ENODEV;
-	if (i == DN_DEV_LIST_SIZE)
-		return NULL;
-
-	*err = -ENOBUFS;
-	if ((dn_db = kzalloc(sizeof(struct dn_dev), GFP_ATOMIC)) == NULL)
-		return NULL;
-
-	memcpy(&dn_db->parms, p, sizeof(struct dn_dev_parms));
-
-	rcu_assign_pointer(dev->dn_ptr, dn_db);
-	dn_db->dev = dev;
-	timer_setup(&dn_db->timer, dn_dev_timer_func, 0);
-
-	dn_db->uptime = jiffies;
-
-	dn_db->neigh_parms = neigh_parms_alloc(dev, &dn_neigh_table);
-	if (!dn_db->neigh_parms) {
-		RCU_INIT_POINTER(dev->dn_ptr, NULL);
-		kfree(dn_db);
-		return NULL;
-	}
-
-	if (dn_db->parms.up) {
-		if (dn_db->parms.up(dev) < 0) {
-			neigh_parms_release(&dn_neigh_table, dn_db->neigh_parms);
-			dev->dn_ptr = NULL;
-			kfree(dn_db);
-			return NULL;
-		}
-	}
-
-	dn_dev_sysctl_register(dev, &dn_db->parms);
-
-	dn_dev_set_timer(dev);
-
-	*err = 0;
-	return dn_db;
-}
-
-
-/*
- * This processes a device up event. We only start up
- * the loopback device & ethernet devices with correct
- * MAC addresses automatically. Others must be started
- * specifically.
- *
- * FIXME: How should we configure the loopback address ? If we could dispense
- * with using decnet_address here and for autobind, it will be one less thing
- * for users to worry about setting up.
- */
-
-void dn_dev_up(struct net_device *dev)
-{
-	struct dn_ifaddr *ifa;
-	__le16 addr = decnet_address;
-	int maybe_default = 0;
-	struct dn_dev *dn_db = rtnl_dereference(dev->dn_ptr);
-
-	if ((dev->type != ARPHRD_ETHER) && (dev->type != ARPHRD_LOOPBACK))
-		return;
-
-	/*
-	 * Need to ensure that loopback device has a dn_db attached to it
-	 * to allow creation of neighbours against it, even though it might
-	 * not have a local address of its own. Might as well do the same for
-	 * all autoconfigured interfaces.
-	 */
-	if (dn_db == NULL) {
-		int err;
-		dn_db = dn_dev_create(dev, &err);
-		if (dn_db == NULL)
-			return;
-	}
-
-	if (dev->type == ARPHRD_ETHER) {
-		if (memcmp(dev->dev_addr, dn_hiord, 4) != 0)
-			return;
-		addr = dn_eth2dn(dev->dev_addr);
-		maybe_default = 1;
-	}
-
-	if (addr == 0)
-		return;
-
-	if ((ifa = dn_dev_alloc_ifa()) == NULL)
-		return;
-
-	ifa->ifa_local = ifa->ifa_address = addr;
-	ifa->ifa_flags = 0;
-	ifa->ifa_scope = RT_SCOPE_UNIVERSE;
-	strcpy(ifa->ifa_label, dev->name);
-
-	dn_dev_set_ifa(dev, ifa);
-
-	/*
-	 * Automagically set the default device to the first automatically
-	 * configured ethernet card in the system.
-	 */
-	if (maybe_default) {
-		dev_hold(dev);
-		if (dn_dev_set_default(dev, 0))
-			dev_put(dev);
-	}
-}
-
-static void dn_dev_delete(struct net_device *dev)
-{
-	struct dn_dev *dn_db = rtnl_dereference(dev->dn_ptr);
-
-	if (dn_db == NULL)
-		return;
-
-	del_timer_sync(&dn_db->timer);
-	dn_dev_sysctl_unregister(&dn_db->parms);
-	dn_dev_check_default(dev);
-	neigh_ifdown(&dn_neigh_table, dev);
-
-	if (dn_db->parms.down)
-		dn_db->parms.down(dev);
-
-	dev->dn_ptr = NULL;
-
-	neigh_parms_release(&dn_neigh_table, dn_db->neigh_parms);
-	neigh_ifdown(&dn_neigh_table, dev);
-
-	if (dn_db->router)
-		neigh_release(dn_db->router);
-	if (dn_db->peer)
-		neigh_release(dn_db->peer);
-
-	kfree(dn_db);
-}
-
-void dn_dev_down(struct net_device *dev)
-{
-	struct dn_dev *dn_db = rtnl_dereference(dev->dn_ptr);
-	struct dn_ifaddr *ifa;
-
-	if (dn_db == NULL)
-		return;
-
-	while ((ifa = rtnl_dereference(dn_db->ifa_list)) != NULL) {
-		dn_dev_del_ifa(dn_db, &dn_db->ifa_list, 0);
-		dn_dev_free_ifa(ifa);
-	}
-
-	dn_dev_delete(dev);
-}
-
-void dn_dev_init_pkt(struct sk_buff *skb)
-{
-}
-
-void dn_dev_veri_pkt(struct sk_buff *skb)
-{
-}
-
-void dn_dev_hello(struct sk_buff *skb)
-{
-}
-
-void dn_dev_devices_off(void)
-{
-	struct net_device *dev;
-
-	rtnl_lock();
-	for_each_netdev(&init_net, dev)
-		dn_dev_down(dev);
-	rtnl_unlock();
-
-}
-
-void dn_dev_devices_on(void)
-{
-	struct net_device *dev;
-
-	rtnl_lock();
-	for_each_netdev(&init_net, dev) {
-		if (dev->flags & IFF_UP)
-			dn_dev_up(dev);
-	}
-	rtnl_unlock();
-}
-
-int register_dnaddr_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&dnaddr_chain, nb);
-}
-
-int unregister_dnaddr_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&dnaddr_chain, nb);
-}
-
-#ifdef CONFIG_PROC_FS
-static inline int is_dn_dev(struct net_device *dev)
-{
-	return dev->dn_ptr != NULL;
-}
-
-static void *dn_dev_seq_start(struct seq_file *seq, loff_t *pos)
-	__acquires(RCU)
-{
-	int i;
-	struct net_device *dev;
-
-	rcu_read_lock();
-
-	if (*pos == 0)
-		return SEQ_START_TOKEN;
-
-	i = 1;
-	for_each_netdev_rcu(&init_net, dev) {
-		if (!is_dn_dev(dev))
-			continue;
-
-		if (i++ == *pos)
-			return dev;
-	}
-
-	return NULL;
-}
-
-static void *dn_dev_seq_next(struct seq_file *seq, void *v, loff_t *pos)
-{
-	struct net_device *dev;
-
-	++*pos;
-
-	dev = v;
-	if (v == SEQ_START_TOKEN)
-		dev = net_device_entry(&init_net.dev_base_head);
-
-	for_each_netdev_continue_rcu(&init_net, dev) {
-		if (!is_dn_dev(dev))
-			continue;
-
-		return dev;
-	}
-
-	return NULL;
-}
-
-static void dn_dev_seq_stop(struct seq_file *seq, void *v)
-	__releases(RCU)
-{
-	rcu_read_unlock();
-}
-
-static char *dn_type2asc(char type)
-{
-	switch (type) {
-	case DN_DEV_BCAST:
-		return "B";
-	case DN_DEV_UCAST:
-		return "U";
-	case DN_DEV_MPOINT:
-		return "M";
-	}
-
-	return "?";
-}
-
-static int dn_dev_seq_show(struct seq_file *seq, void *v)
-{
-	if (v == SEQ_START_TOKEN)
-		seq_puts(seq, "Name     Flags T1   Timer1 T3   Timer3 BlkSize Pri State DevType    Router Peer\n");
-	else {
-		struct net_device *dev = v;
-		char peer_buf[DN_ASCBUF_LEN];
-		char router_buf[DN_ASCBUF_LEN];
-		struct dn_dev *dn_db = rcu_dereference(dev->dn_ptr);
-
-		seq_printf(seq, "%-8s %1s     %04u %04u   %04lu %04lu"
-				"   %04hu    %03d %02x    %-10s %-7s %-7s\n",
-				dev->name,
-				dn_type2asc(dn_db->parms.mode),
-				0, 0,
-				dn_db->t3, dn_db->parms.t3,
-				mtu2blksize(dev),
-				dn_db->parms.priority,
-				dn_db->parms.state, dn_db->parms.name,
-				dn_db->router ? dn_addr2asc(le16_to_cpu(*(__le16 *)dn_db->router->primary_key), router_buf) : "",
-				dn_db->peer ? dn_addr2asc(le16_to_cpu(*(__le16 *)dn_db->peer->primary_key), peer_buf) : "");
-	}
-	return 0;
-}
-
-static const struct seq_operations dn_dev_seq_ops = {
-	.start	= dn_dev_seq_start,
-	.next	= dn_dev_seq_next,
-	.stop	= dn_dev_seq_stop,
-	.show	= dn_dev_seq_show,
-};
-#endif /* CONFIG_PROC_FS */
-
-static int addr[2];
-module_param_array(addr, int, NULL, 0444);
-MODULE_PARM_DESC(addr, "The DECnet address of this machine: area,node");
-
-void __init dn_dev_init(void)
-{
-	if (addr[0] > 63 || addr[0] < 0) {
-		printk(KERN_ERR "DECnet: Area must be between 0 and 63");
-		return;
-	}
-
-	if (addr[1] > 1023 || addr[1] < 0) {
-		printk(KERN_ERR "DECnet: Node must be between 0 and 1023");
-		return;
-	}
-
-	decnet_address = cpu_to_le16((addr[0] << 10) | addr[1]);
-
-	dn_dev_devices_on();
-
-	rtnl_register_module(THIS_MODULE, PF_DECnet, RTM_NEWADDR,
-			     dn_nl_newaddr, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_DECnet, RTM_DELADDR,
-			     dn_nl_deladdr, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_DECnet, RTM_GETADDR,
-			     NULL, dn_nl_dump_ifaddr, 0);
-
-	proc_create_seq("decnet_dev", 0444, init_net.proc_net, &dn_dev_seq_ops);
-
-#ifdef CONFIG_SYSCTL
-	{
-		int i;
-		for(i = 0; i < DN_DEV_LIST_SIZE; i++)
-			dn_dev_sysctl_register(NULL, &dn_dev_list[i]);
-	}
-#endif /* CONFIG_SYSCTL */
-}
-
-void __exit dn_dev_cleanup(void)
-{
-#ifdef CONFIG_SYSCTL
-	{
-		int i;
-		for(i = 0; i < DN_DEV_LIST_SIZE; i++)
-			dn_dev_sysctl_unregister(&dn_dev_list[i]);
-	}
-#endif /* CONFIG_SYSCTL */
-
-	remove_proc_entry("decnet_dev", init_net.proc_net);
-
-	dn_dev_devices_off();
-}
diff --git a/net/decnet/dn_fib.c b/net/decnet/dn_fib.c
deleted file mode 100644
index 77fbf8e9df4b..000000000000
--- a/net/decnet/dn_fib.c
+++ /dev/null
@@ -1,799 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * DECnet       An implementation of the DECnet protocol suite for the LINUX
- *              operating system.  DECnet is implemented using the  BSD Socket
- *              interface as the means of communication with the user level.
- *
- *              DECnet Routing Forwarding Information Base (Glue/Info List)
- *
- * Author:      Steve Whitehouse <SteveW@ACM.org>
- *
- *
- * Changes:
- *              Alexey Kuznetsov : SMP locking changes
- *              Steve Whitehouse : Rewrote it... Well to be more correct, I
- *                                 copied most of it from the ipv4 fib code.
- *              Steve Whitehouse : Updated it in style and fixed a few bugs
- *                                 which were fixed in the ipv4 code since
- *                                 this code was copied from it.
- *
- */
-#include <linux/string.h>
-#include <linux/net.h>
-#include <linux/socket.h>
-#include <linux/slab.h>
-#include <linux/sockios.h>
-#include <linux/init.h>
-#include <linux/skbuff.h>
-#include <linux/netlink.h>
-#include <linux/rtnetlink.h>
-#include <linux/proc_fs.h>
-#include <linux/netdevice.h>
-#include <linux/timer.h>
-#include <linux/spinlock.h>
-#include <linux/atomic.h>
-#include <linux/uaccess.h>
-#include <net/neighbour.h>
-#include <net/dst.h>
-#include <net/flow.h>
-#include <net/fib_rules.h>
-#include <net/dn.h>
-#include <net/dn_route.h>
-#include <net/dn_fib.h>
-#include <net/dn_neigh.h>
-#include <net/dn_dev.h>
-#include <net/rtnh.h>
-
-#define RT_MIN_TABLE 1
-
-#define for_fib_info() { struct dn_fib_info *fi;\
-	for(fi = dn_fib_info_list; fi; fi = fi->fib_next)
-#define endfor_fib_info() }
-
-#define for_nexthops(fi) { int nhsel; const struct dn_fib_nh *nh;\
-	for(nhsel = 0, nh = (fi)->fib_nh; nhsel < (fi)->fib_nhs; nh++, nhsel++)
-
-#define change_nexthops(fi) { int nhsel; struct dn_fib_nh *nh;\
-	for(nhsel = 0, nh = (struct dn_fib_nh *)((fi)->fib_nh); nhsel < (fi)->fib_nhs; nh++, nhsel++)
-
-#define endfor_nexthops(fi) }
-
-static DEFINE_SPINLOCK(dn_fib_multipath_lock);
-static struct dn_fib_info *dn_fib_info_list;
-static DEFINE_SPINLOCK(dn_fib_info_lock);
-
-static struct
-{
-	int error;
-	u8 scope;
-} dn_fib_props[RTN_MAX+1] = {
-	[RTN_UNSPEC] =      { .error = 0,       .scope = RT_SCOPE_NOWHERE },
-	[RTN_UNICAST] =     { .error = 0,       .scope = RT_SCOPE_UNIVERSE },
-	[RTN_LOCAL] =       { .error = 0,       .scope = RT_SCOPE_HOST },
-	[RTN_BROADCAST] =   { .error = -EINVAL, .scope = RT_SCOPE_NOWHERE },
-	[RTN_ANYCAST] =     { .error = -EINVAL, .scope = RT_SCOPE_NOWHERE },
-	[RTN_MULTICAST] =   { .error = -EINVAL, .scope = RT_SCOPE_NOWHERE },
-	[RTN_BLACKHOLE] =   { .error = -EINVAL, .scope = RT_SCOPE_UNIVERSE },
-	[RTN_UNREACHABLE] = { .error = -EHOSTUNREACH, .scope = RT_SCOPE_UNIVERSE },
-	[RTN_PROHIBIT] =    { .error = -EACCES, .scope = RT_SCOPE_UNIVERSE },
-	[RTN_THROW] =       { .error = -EAGAIN, .scope = RT_SCOPE_UNIVERSE },
-	[RTN_NAT] =         { .error = 0,       .scope = RT_SCOPE_NOWHERE },
-	[RTN_XRESOLVE] =    { .error = -EINVAL, .scope = RT_SCOPE_NOWHERE },
-};
-
-static int dn_fib_sync_down(__le16 local, struct net_device *dev, int force);
-static int dn_fib_sync_up(struct net_device *dev);
-
-void dn_fib_free_info(struct dn_fib_info *fi)
-{
-	if (fi->fib_dead == 0) {
-		printk(KERN_DEBUG "DECnet: BUG! Attempt to free alive dn_fib_info\n");
-		return;
-	}
-
-	change_nexthops(fi) {
-		if (nh->nh_dev)
-			dev_put(nh->nh_dev);
-		nh->nh_dev = NULL;
-	} endfor_nexthops(fi);
-	kfree(fi);
-}
-
-void dn_fib_release_info(struct dn_fib_info *fi)
-{
-	spin_lock(&dn_fib_info_lock);
-	if (fi && --fi->fib_treeref == 0) {
-		if (fi->fib_next)
-			fi->fib_next->fib_prev = fi->fib_prev;
-		if (fi->fib_prev)
-			fi->fib_prev->fib_next = fi->fib_next;
-		if (fi == dn_fib_info_list)
-			dn_fib_info_list = fi->fib_next;
-		fi->fib_dead = 1;
-		dn_fib_info_put(fi);
-	}
-	spin_unlock(&dn_fib_info_lock);
-}
-
-static inline int dn_fib_nh_comp(const struct dn_fib_info *fi, const struct dn_fib_info *ofi)
-{
-	const struct dn_fib_nh *onh = ofi->fib_nh;
-
-	for_nexthops(fi) {
-		if (nh->nh_oif != onh->nh_oif ||
-			nh->nh_gw != onh->nh_gw ||
-			nh->nh_scope != onh->nh_scope ||
-			nh->nh_weight != onh->nh_weight ||
-			((nh->nh_flags^onh->nh_flags)&~RTNH_F_DEAD))
-				return -1;
-		onh++;
-	} endfor_nexthops(fi);
-	return 0;
-}
-
-static inline struct dn_fib_info *dn_fib_find_info(const struct dn_fib_info *nfi)
-{
-	for_fib_info() {
-		if (fi->fib_nhs != nfi->fib_nhs)
-			continue;
-		if (nfi->fib_protocol == fi->fib_protocol &&
-			nfi->fib_prefsrc == fi->fib_prefsrc &&
-			nfi->fib_priority == fi->fib_priority &&
-			memcmp(nfi->fib_metrics, fi->fib_metrics, sizeof(fi->fib_metrics)) == 0 &&
-			((nfi->fib_flags^fi->fib_flags)&~RTNH_F_DEAD) == 0 &&
-			(nfi->fib_nhs == 0 || dn_fib_nh_comp(fi, nfi) == 0))
-				return fi;
-	} endfor_fib_info();
-	return NULL;
-}
-
-static int dn_fib_count_nhs(const struct nlattr *attr)
-{
-	struct rtnexthop *nhp = nla_data(attr);
-	int nhs = 0, nhlen = nla_len(attr);
-
-	while (rtnh_ok(nhp, nhlen)) {
-		nhs++;
-		nhp = rtnh_next(nhp, &nhlen);
-	}
-
-	/* leftover implies invalid nexthop configuration, discard it */
-	return nhlen > 0 ? 0 : nhs;
-}
-
-static int dn_fib_get_nhs(struct dn_fib_info *fi, const struct nlattr *attr,
-			  const struct rtmsg *r)
-{
-	struct rtnexthop *nhp = nla_data(attr);
-	int nhlen = nla_len(attr);
-
-	change_nexthops(fi) {
-		int attrlen;
-
-		if (!rtnh_ok(nhp, nhlen))
-			return -EINVAL;
-
-		nh->nh_flags  = (r->rtm_flags&~0xFF) | nhp->rtnh_flags;
-		nh->nh_oif    = nhp->rtnh_ifindex;
-		nh->nh_weight = nhp->rtnh_hops + 1;
-
-		attrlen = rtnh_attrlen(nhp);
-		if (attrlen > 0) {
-			struct nlattr *gw_attr;
-
-			gw_attr = nla_find((struct nlattr *) (nhp + 1), attrlen, RTA_GATEWAY);
-			nh->nh_gw = gw_attr ? nla_get_le16(gw_attr) : 0;
-		}
-
-		nhp = rtnh_next(nhp, &nhlen);
-	} endfor_nexthops(fi);
-
-	return 0;
-}
-
-
-static int dn_fib_check_nh(const struct rtmsg *r, struct dn_fib_info *fi, struct dn_fib_nh *nh)
-{
-	int err;
-
-	if (nh->nh_gw) {
-		struct flowidn fld;
-		struct dn_fib_res res;
-
-		if (nh->nh_flags&RTNH_F_ONLINK) {
-			struct net_device *dev;
-
-			if (r->rtm_scope >= RT_SCOPE_LINK)
-				return -EINVAL;
-			if (dnet_addr_type(nh->nh_gw) != RTN_UNICAST)
-				return -EINVAL;
-			if ((dev = __dev_get_by_index(&init_net, nh->nh_oif)) == NULL)
-				return -ENODEV;
-			if (!(dev->flags&IFF_UP))
-				return -ENETDOWN;
-			nh->nh_dev = dev;
-			dev_hold(dev);
-			nh->nh_scope = RT_SCOPE_LINK;
-			return 0;
-		}
-
-		memset(&fld, 0, sizeof(fld));
-		fld.daddr = nh->nh_gw;
-		fld.flowidn_oif = nh->nh_oif;
-		fld.flowidn_scope = r->rtm_scope + 1;
-
-		if (fld.flowidn_scope < RT_SCOPE_LINK)
-			fld.flowidn_scope = RT_SCOPE_LINK;
-
-		if ((err = dn_fib_lookup(&fld, &res)) != 0)
-			return err;
-
-		err = -EINVAL;
-		if (res.type != RTN_UNICAST && res.type != RTN_LOCAL)
-			goto out;
-		nh->nh_scope = res.scope;
-		nh->nh_oif = DN_FIB_RES_OIF(res);
-		nh->nh_dev = DN_FIB_RES_DEV(res);
-		if (nh->nh_dev == NULL)
-			goto out;
-		dev_hold(nh->nh_dev);
-		err = -ENETDOWN;
-		if (!(nh->nh_dev->flags & IFF_UP))
-			goto out;
-		err = 0;
-out:
-		dn_fib_res_put(&res);
-		return err;
-	} else {
-		struct net_device *dev;
-
-		if (nh->nh_flags&(RTNH_F_PERVASIVE|RTNH_F_ONLINK))
-			return -EINVAL;
-
-		dev = __dev_get_by_index(&init_net, nh->nh_oif);
-		if (dev == NULL || dev->dn_ptr == NULL)
-			return -ENODEV;
-		if (!(dev->flags&IFF_UP))
-			return -ENETDOWN;
-		nh->nh_dev = dev;
-		dev_hold(nh->nh_dev);
-		nh->nh_scope = RT_SCOPE_HOST;
-	}
-
-	return 0;
-}
-
-
-struct dn_fib_info *dn_fib_create_info(const struct rtmsg *r, struct nlattr *attrs[],
-				       const struct nlmsghdr *nlh, int *errp)
-{
-	int err;
-	struct dn_fib_info *fi = NULL;
-	struct dn_fib_info *ofi;
-	int nhs = 1;
-
-	if (r->rtm_type > RTN_MAX)
-		goto err_inval;
-
-	if (dn_fib_props[r->rtm_type].scope > r->rtm_scope)
-		goto err_inval;
-
-	if (attrs[RTA_MULTIPATH] &&
-	    (nhs = dn_fib_count_nhs(attrs[RTA_MULTIPATH])) == 0)
-		goto err_inval;
-
-	fi = kzalloc(struct_size(fi, fib_nh, nhs), GFP_KERNEL);
-	err = -ENOBUFS;
-	if (fi == NULL)
-		goto failure;
-
-	fi->fib_protocol = r->rtm_protocol;
-	fi->fib_nhs = nhs;
-	fi->fib_flags = r->rtm_flags;
-
-	if (attrs[RTA_PRIORITY])
-		fi->fib_priority = nla_get_u32(attrs[RTA_PRIORITY]);
-
-	if (attrs[RTA_METRICS]) {
-		struct nlattr *attr;
-		int rem;
-
-		nla_for_each_nested(attr, attrs[RTA_METRICS], rem) {
-			int type = nla_type(attr);
-
-			if (type) {
-				if (type > RTAX_MAX || type == RTAX_CC_ALGO ||
-				    nla_len(attr) < 4)
-					goto err_inval;
-
-				fi->fib_metrics[type-1] = nla_get_u32(attr);
-			}
-		}
-	}
-
-	if (attrs[RTA_PREFSRC])
-		fi->fib_prefsrc = nla_get_le16(attrs[RTA_PREFSRC]);
-
-	if (attrs[RTA_MULTIPATH]) {
-		if ((err = dn_fib_get_nhs(fi, attrs[RTA_MULTIPATH], r)) != 0)
-			goto failure;
-
-		if (attrs[RTA_OIF] &&
-		    fi->fib_nh->nh_oif != nla_get_u32(attrs[RTA_OIF]))
-			goto err_inval;
-
-		if (attrs[RTA_GATEWAY] &&
-		    fi->fib_nh->nh_gw != nla_get_le16(attrs[RTA_GATEWAY]))
-			goto err_inval;
-	} else {
-		struct dn_fib_nh *nh = fi->fib_nh;
-
-		if (attrs[RTA_OIF])
-			nh->nh_oif = nla_get_u32(attrs[RTA_OIF]);
-
-		if (attrs[RTA_GATEWAY])
-			nh->nh_gw = nla_get_le16(attrs[RTA_GATEWAY]);
-
-		nh->nh_flags = r->rtm_flags;
-		nh->nh_weight = 1;
-	}
-
-	if (r->rtm_type == RTN_NAT) {
-		if (!attrs[RTA_GATEWAY] || nhs != 1 || attrs[RTA_OIF])
-			goto err_inval;
-
-		fi->fib_nh->nh_gw = nla_get_le16(attrs[RTA_GATEWAY]);
-		goto link_it;
-	}
-
-	if (dn_fib_props[r->rtm_type].error) {
-		if (attrs[RTA_GATEWAY] || attrs[RTA_OIF] || attrs[RTA_MULTIPATH])
-			goto err_inval;
-
-		goto link_it;
-	}
-
-	if (r->rtm_scope > RT_SCOPE_HOST)
-		goto err_inval;
-
-	if (r->rtm_scope == RT_SCOPE_HOST) {
-		struct dn_fib_nh *nh = fi->fib_nh;
-
-		/* Local address is added */
-		if (nhs != 1 || nh->nh_gw)
-			goto err_inval;
-		nh->nh_scope = RT_SCOPE_NOWHERE;
-		nh->nh_dev = dev_get_by_index(&init_net, fi->fib_nh->nh_oif);
-		err = -ENODEV;
-		if (nh->nh_dev == NULL)
-			goto failure;
-	} else {
-		change_nexthops(fi) {
-			if ((err = dn_fib_check_nh(r, fi, nh)) != 0)
-				goto failure;
-		} endfor_nexthops(fi)
-	}
-
-	if (fi->fib_prefsrc) {
-		if (r->rtm_type != RTN_LOCAL || !attrs[RTA_DST] ||
-		    fi->fib_prefsrc != nla_get_le16(attrs[RTA_DST]))
-			if (dnet_addr_type(fi->fib_prefsrc) != RTN_LOCAL)
-				goto err_inval;
-	}
-
-link_it:
-	if ((ofi = dn_fib_find_info(fi)) != NULL) {
-		fi->fib_dead = 1;
-		dn_fib_free_info(fi);
-		ofi->fib_treeref++;
-		return ofi;
-	}
-
-	fi->fib_treeref++;
-	refcount_set(&fi->fib_clntref, 1);
-	spin_lock(&dn_fib_info_lock);
-	fi->fib_next = dn_fib_info_list;
-	fi->fib_prev = NULL;
-	if (dn_fib_info_list)
-		dn_fib_info_list->fib_prev = fi;
-	dn_fib_info_list = fi;
-	spin_unlock(&dn_fib_info_lock);
-	return fi;
-
-err_inval:
-	err = -EINVAL;
-
-failure:
-	*errp = err;
-	if (fi) {
-		fi->fib_dead = 1;
-		dn_fib_free_info(fi);
-	}
-
-	return NULL;
-}
-
-int dn_fib_semantic_match(int type, struct dn_fib_info *fi, const struct flowidn *fld, struct dn_fib_res *res)
-{
-	int err = dn_fib_props[type].error;
-
-	if (err == 0) {
-		if (fi->fib_flags & RTNH_F_DEAD)
-			return 1;
-
-		res->fi = fi;
-
-		switch (type) {
-		case RTN_NAT:
-			DN_FIB_RES_RESET(*res);
-			refcount_inc(&fi->fib_clntref);
-			return 0;
-		case RTN_UNICAST:
-		case RTN_LOCAL:
-			for_nexthops(fi) {
-				if (nh->nh_flags & RTNH_F_DEAD)
-					continue;
-				if (!fld->flowidn_oif ||
-				    fld->flowidn_oif == nh->nh_oif)
-					break;
-			}
-			if (nhsel < fi->fib_nhs) {
-				res->nh_sel = nhsel;
-				refcount_inc(&fi->fib_clntref);
-				return 0;
-			}
-			endfor_nexthops(fi);
-			res->fi = NULL;
-			return 1;
-		default:
-			net_err_ratelimited("DECnet: impossible routing event : dn_fib_semantic_match type=%d\n",
-					    type);
-			res->fi = NULL;
-			return -EINVAL;
-		}
-	}
-	return err;
-}
-
-void dn_fib_select_multipath(const struct flowidn *fld, struct dn_fib_res *res)
-{
-	struct dn_fib_info *fi = res->fi;
-	int w;
-
-	spin_lock_bh(&dn_fib_multipath_lock);
-	if (fi->fib_power <= 0) {
-		int power = 0;
-		change_nexthops(fi) {
-			if (!(nh->nh_flags&RTNH_F_DEAD)) {
-				power += nh->nh_weight;
-				nh->nh_power = nh->nh_weight;
-			}
-		} endfor_nexthops(fi);
-		fi->fib_power = power;
-		if (power < 0) {
-			spin_unlock_bh(&dn_fib_multipath_lock);
-			res->nh_sel = 0;
-			return;
-		}
-	}
-
-	w = jiffies % fi->fib_power;
-
-	change_nexthops(fi) {
-		if (!(nh->nh_flags&RTNH_F_DEAD) && nh->nh_power) {
-			if ((w -= nh->nh_power) <= 0) {
-				nh->nh_power--;
-				fi->fib_power--;
-				res->nh_sel = nhsel;
-				spin_unlock_bh(&dn_fib_multipath_lock);
-				return;
-			}
-		}
-	} endfor_nexthops(fi);
-	res->nh_sel = 0;
-	spin_unlock_bh(&dn_fib_multipath_lock);
-}
-
-static inline u32 rtm_get_table(struct nlattr *attrs[], u8 table)
-{
-	if (attrs[RTA_TABLE])
-		table = nla_get_u32(attrs[RTA_TABLE]);
-
-	return table;
-}
-
-static int dn_fib_rtm_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
-			       struct netlink_ext_ack *extack)
-{
-	struct net *net = sock_net(skb->sk);
-	struct dn_fib_table *tb;
-	struct rtmsg *r = nlmsg_data(nlh);
-	struct nlattr *attrs[RTA_MAX+1];
-	int err;
-
-	if (!netlink_capable(skb, CAP_NET_ADMIN))
-		return -EPERM;
-
-	if (!net_eq(net, &init_net))
-		return -EINVAL;
-
-	err = nlmsg_parse_deprecated(nlh, sizeof(*r), attrs, RTA_MAX,
-				     rtm_dn_policy, extack);
-	if (err < 0)
-		return err;
-
-	tb = dn_fib_get_table(rtm_get_table(attrs, r->rtm_table), 0);
-	if (!tb)
-		return -ESRCH;
-
-	return tb->delete(tb, r, attrs, nlh, &NETLINK_CB(skb));
-}
-
-static int dn_fib_rtm_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
-			       struct netlink_ext_ack *extack)
-{
-	struct net *net = sock_net(skb->sk);
-	struct dn_fib_table *tb;
-	struct rtmsg *r = nlmsg_data(nlh);
-	struct nlattr *attrs[RTA_MAX+1];
-	int err;
-
-	if (!netlink_capable(skb, CAP_NET_ADMIN))
-		return -EPERM;
-
-	if (!net_eq(net, &init_net))
-		return -EINVAL;
-
-	err = nlmsg_parse_deprecated(nlh, sizeof(*r), attrs, RTA_MAX,
-				     rtm_dn_policy, extack);
-	if (err < 0)
-		return err;
-
-	tb = dn_fib_get_table(rtm_get_table(attrs, r->rtm_table), 1);
-	if (!tb)
-		return -ENOBUFS;
-
-	return tb->insert(tb, r, attrs, nlh, &NETLINK_CB(skb));
-}
-
-static void fib_magic(int cmd, int type, __le16 dst, int dst_len, struct dn_ifaddr *ifa)
-{
-	struct dn_fib_table *tb;
-	struct {
-		struct nlmsghdr nlh;
-		struct rtmsg rtm;
-	} req;
-	struct {
-		struct nlattr hdr;
-		__le16 dst;
-	} dst_attr = {
-		.dst = dst,
-	};
-	struct {
-		struct nlattr hdr;
-		__le16 prefsrc;
-	} prefsrc_attr = {
-		.prefsrc = ifa->ifa_local,
-	};
-	struct {
-		struct nlattr hdr;
-		u32 oif;
-	} oif_attr = {
-		.oif = ifa->ifa_dev->dev->ifindex,
-	};
-	struct nlattr *attrs[RTA_MAX+1] = {
-		[RTA_DST] = (struct nlattr *) &dst_attr,
-		[RTA_PREFSRC] = (struct nlattr * ) &prefsrc_attr,
-		[RTA_OIF] = (struct nlattr *) &oif_attr,
-	};
-
-	memset(&req.rtm, 0, sizeof(req.rtm));
-
-	if (type == RTN_UNICAST)
-		tb = dn_fib_get_table(RT_MIN_TABLE, 1);
-	else
-		tb = dn_fib_get_table(RT_TABLE_LOCAL, 1);
-
-	if (tb == NULL)
-		return;
-
-	req.nlh.nlmsg_len = sizeof(req);
-	req.nlh.nlmsg_type = cmd;
-	req.nlh.nlmsg_flags = NLM_F_REQUEST|NLM_F_CREATE|NLM_F_APPEND;
-	req.nlh.nlmsg_pid = 0;
-	req.nlh.nlmsg_seq = 0;
-
-	req.rtm.rtm_dst_len = dst_len;
-	req.rtm.rtm_table = tb->n;
-	req.rtm.rtm_protocol = RTPROT_KERNEL;
-	req.rtm.rtm_scope = (type != RTN_LOCAL ? RT_SCOPE_LINK : RT_SCOPE_HOST);
-	req.rtm.rtm_type = type;
-
-	if (cmd == RTM_NEWROUTE)
-		tb->insert(tb, &req.rtm, attrs, &req.nlh, NULL);
-	else
-		tb->delete(tb, &req.rtm, attrs, &req.nlh, NULL);
-}
-
-static void dn_fib_add_ifaddr(struct dn_ifaddr *ifa)
-{
-
-	fib_magic(RTM_NEWROUTE, RTN_LOCAL, ifa->ifa_local, 16, ifa);
-
-#if 0
-	if (!(dev->flags&IFF_UP))
-		return;
-	/* In the future, we will want to add default routes here */
-
-#endif
-}
-
-static void dn_fib_del_ifaddr(struct dn_ifaddr *ifa)
-{
-	int found_it = 0;
-	struct net_device *dev;
-	struct dn_dev *dn_db;
-	struct dn_ifaddr *ifa2;
-
-	ASSERT_RTNL();
-
-	/* Scan device list */
-	rcu_read_lock();
-	for_each_netdev_rcu(&init_net, dev) {
-		dn_db = rcu_dereference(dev->dn_ptr);
-		if (dn_db == NULL)
-			continue;
-		for (ifa2 = rcu_dereference(dn_db->ifa_list);
-		     ifa2 != NULL;
-		     ifa2 = rcu_dereference(ifa2->ifa_next)) {
-			if (ifa2->ifa_local == ifa->ifa_local) {
-				found_it = 1;
-				break;
-			}
-		}
-	}
-	rcu_read_unlock();
-
-	if (found_it == 0) {
-		fib_magic(RTM_DELROUTE, RTN_LOCAL, ifa->ifa_local, 16, ifa);
-
-		if (dnet_addr_type(ifa->ifa_local) != RTN_LOCAL) {
-			if (dn_fib_sync_down(ifa->ifa_local, NULL, 0))
-				dn_fib_flush();
-		}
-	}
-}
-
-static void dn_fib_disable_addr(struct net_device *dev, int force)
-{
-	if (dn_fib_sync_down(0, dev, force))
-		dn_fib_flush();
-	dn_rt_cache_flush(0);
-	neigh_ifdown(&dn_neigh_table, dev);
-}
-
-static int dn_fib_dnaddr_event(struct notifier_block *this, unsigned long event, void *ptr)
-{
-	struct dn_ifaddr *ifa = (struct dn_ifaddr *)ptr;
-
-	switch (event) {
-	case NETDEV_UP:
-		dn_fib_add_ifaddr(ifa);
-		dn_fib_sync_up(ifa->ifa_dev->dev);
-		dn_rt_cache_flush(-1);
-		break;
-	case NETDEV_DOWN:
-		dn_fib_del_ifaddr(ifa);
-		if (ifa->ifa_dev && ifa->ifa_dev->ifa_list == NULL) {
-			dn_fib_disable_addr(ifa->ifa_dev->dev, 1);
-		} else {
-			dn_rt_cache_flush(-1);
-		}
-		break;
-	}
-	return NOTIFY_DONE;
-}
-
-static int dn_fib_sync_down(__le16 local, struct net_device *dev, int force)
-{
-	int ret = 0;
-	int scope = RT_SCOPE_NOWHERE;
-
-	if (force)
-		scope = -1;
-
-	for_fib_info() {
-		/*
-		 * This makes no sense for DECnet.... we will almost
-		 * certainly have more than one local address the same
-		 * over all our interfaces. It needs thinking about
-		 * some more.
-		 */
-		if (local && fi->fib_prefsrc == local) {
-			fi->fib_flags |= RTNH_F_DEAD;
-			ret++;
-		} else if (dev && fi->fib_nhs) {
-			int dead = 0;
-
-			change_nexthops(fi) {
-				if (nh->nh_flags&RTNH_F_DEAD)
-					dead++;
-				else if (nh->nh_dev == dev &&
-						nh->nh_scope != scope) {
-					spin_lock_bh(&dn_fib_multipath_lock);
-					nh->nh_flags |= RTNH_F_DEAD;
-					fi->fib_power -= nh->nh_power;
-					nh->nh_power = 0;
-					spin_unlock_bh(&dn_fib_multipath_lock);
-					dead++;
-				}
-			} endfor_nexthops(fi)
-			if (dead == fi->fib_nhs) {
-				fi->fib_flags |= RTNH_F_DEAD;
-				ret++;
-			}
-		}
-	} endfor_fib_info();
-	return ret;
-}
-
-
-static int dn_fib_sync_up(struct net_device *dev)
-{
-	int ret = 0;
-
-	if (!(dev->flags&IFF_UP))
-		return 0;
-
-	for_fib_info() {
-		int alive = 0;
-
-		change_nexthops(fi) {
-			if (!(nh->nh_flags&RTNH_F_DEAD)) {
-				alive++;
-				continue;
-			}
-			if (nh->nh_dev == NULL || !(nh->nh_dev->flags&IFF_UP))
-				continue;
-			if (nh->nh_dev != dev || dev->dn_ptr == NULL)
-				continue;
-			alive++;
-			spin_lock_bh(&dn_fib_multipath_lock);
-			nh->nh_power = 0;
-			nh->nh_flags &= ~RTNH_F_DEAD;
-			spin_unlock_bh(&dn_fib_multipath_lock);
-		} endfor_nexthops(fi);
-
-		if (alive > 0) {
-			fi->fib_flags &= ~RTNH_F_DEAD;
-			ret++;
-		}
-	} endfor_fib_info();
-	return ret;
-}
-
-static struct notifier_block dn_fib_dnaddr_notifier = {
-	.notifier_call = dn_fib_dnaddr_event,
-};
-
-void __exit dn_fib_cleanup(void)
-{
-	dn_fib_table_cleanup();
-	dn_fib_rules_cleanup();
-
-	unregister_dnaddr_notifier(&dn_fib_dnaddr_notifier);
-}
-
-
-void __init dn_fib_init(void)
-{
-	dn_fib_table_init();
-	dn_fib_rules_init();
-
-	register_dnaddr_notifier(&dn_fib_dnaddr_notifier);
-
-	rtnl_register_module(THIS_MODULE, PF_DECnet, RTM_NEWROUTE,
-			     dn_fib_rtm_newroute, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_DECnet, RTM_DELROUTE,
-			     dn_fib_rtm_delroute, NULL, 0);
-}
diff --git a/net/decnet/dn_neigh.c b/net/decnet/dn_neigh.c
deleted file mode 100644
index 94b306f6d551..000000000000
--- a/net/decnet/dn_neigh.c
+++ /dev/null
@@ -1,605 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * DECnet       An implementation of the DECnet protocol suite for the LINUX
- *              operating system.  DECnet is implemented using the  BSD Socket
- *              interface as the means of communication with the user level.
- *
- *              DECnet Neighbour Functions (Adjacency Database and
- *                                                        On-Ethernet Cache)
- *
- * Author:      Steve Whitehouse <SteveW@ACM.org>
- *
- *
- * Changes:
- *     Steve Whitehouse     : Fixed router listing routine
- *     Steve Whitehouse     : Added error_report functions
- *     Steve Whitehouse     : Added default router detection
- *     Steve Whitehouse     : Hop counts in outgoing messages
- *     Steve Whitehouse     : Fixed src/dst in outgoing messages so
- *                            forwarding now stands a good chance of
- *                            working.
- *     Steve Whitehouse     : Fixed neighbour states (for now anyway).
- *     Steve Whitehouse     : Made error_report functions dummies. This
- *                            is not the right place to return skbs.
- *     Steve Whitehouse     : Convert to seq_file
- *
- */
-
-#include <linux/net.h>
-#include <linux/module.h>
-#include <linux/socket.h>
-#include <linux/if_arp.h>
-#include <linux/slab.h>
-#include <linux/if_ether.h>
-#include <linux/init.h>
-#include <linux/proc_fs.h>
-#include <linux/string.h>
-#include <linux/netfilter_decnet.h>
-#include <linux/spinlock.h>
-#include <linux/seq_file.h>
-#include <linux/rcupdate.h>
-#include <linux/jhash.h>
-#include <linux/atomic.h>
-#include <net/net_namespace.h>
-#include <net/neighbour.h>
-#include <net/dst.h>
-#include <net/flow.h>
-#include <net/dn.h>
-#include <net/dn_dev.h>
-#include <net/dn_neigh.h>
-#include <net/dn_route.h>
-
-static int dn_neigh_construct(struct neighbour *);
-static void dn_neigh_error_report(struct neighbour *, struct sk_buff *);
-static int dn_neigh_output(struct neighbour *neigh, struct sk_buff *skb);
-
-/*
- * Operations for adding the link layer header.
- */
-static const struct neigh_ops dn_neigh_ops = {
-	.family =		AF_DECnet,
-	.error_report =		dn_neigh_error_report,
-	.output =		dn_neigh_output,
-	.connected_output =	dn_neigh_output,
-};
-
-static u32 dn_neigh_hash(const void *pkey,
-			 const struct net_device *dev,
-			 __u32 *hash_rnd)
-{
-	return jhash_2words(*(__u16 *)pkey, 0, hash_rnd[0]);
-}
-
-static bool dn_key_eq(const struct neighbour *neigh, const void *pkey)
-{
-	return neigh_key_eq16(neigh, pkey);
-}
-
-struct neigh_table dn_neigh_table = {
-	.family =			PF_DECnet,
-	.entry_size =			NEIGH_ENTRY_SIZE(sizeof(struct dn_neigh)),
-	.key_len =			sizeof(__le16),
-	.protocol =			cpu_to_be16(ETH_P_DNA_RT),
-	.hash =				dn_neigh_hash,
-	.key_eq =			dn_key_eq,
-	.constructor =			dn_neigh_construct,
-	.id =				"dn_neigh_cache",
-	.parms ={
-		.tbl =			&dn_neigh_table,
-		.reachable_time =	30 * HZ,
-		.data = {
-			[NEIGH_VAR_MCAST_PROBES] = 0,
-			[NEIGH_VAR_UCAST_PROBES] = 0,
-			[NEIGH_VAR_APP_PROBES] = 0,
-			[NEIGH_VAR_RETRANS_TIME] = 1 * HZ,
-			[NEIGH_VAR_BASE_REACHABLE_TIME] = 30 * HZ,
-			[NEIGH_VAR_DELAY_PROBE_TIME] = 5 * HZ,
-			[NEIGH_VAR_GC_STALETIME] = 60 * HZ,
-			[NEIGH_VAR_QUEUE_LEN_BYTES] = SK_WMEM_MAX,
-			[NEIGH_VAR_PROXY_QLEN] = 0,
-			[NEIGH_VAR_ANYCAST_DELAY] = 0,
-			[NEIGH_VAR_PROXY_DELAY] = 0,
-			[NEIGH_VAR_LOCKTIME] = 1 * HZ,
-		},
-	},
-	.gc_interval =			30 * HZ,
-	.gc_thresh1 =			128,
-	.gc_thresh2 =			512,
-	.gc_thresh3 =			1024,
-};
-
-static int dn_neigh_construct(struct neighbour *neigh)
-{
-	struct net_device *dev = neigh->dev;
-	struct dn_neigh *dn = container_of(neigh, struct dn_neigh, n);
-	struct dn_dev *dn_db;
-	struct neigh_parms *parms;
-
-	rcu_read_lock();
-	dn_db = rcu_dereference(dev->dn_ptr);
-	if (dn_db == NULL) {
-		rcu_read_unlock();
-		return -EINVAL;
-	}
-
-	parms = dn_db->neigh_parms;
-	if (!parms) {
-		rcu_read_unlock();
-		return -EINVAL;
-	}
-
-	__neigh_parms_put(neigh->parms);
-	neigh->parms = neigh_parms_clone(parms);
-	rcu_read_unlock();
-
-	neigh->ops = &dn_neigh_ops;
-	neigh->nud_state = NUD_NOARP;
-	neigh->output = neigh->ops->connected_output;
-
-	if ((dev->type == ARPHRD_IPGRE) || (dev->flags & IFF_POINTOPOINT))
-		memcpy(neigh->ha, dev->broadcast, dev->addr_len);
-	else if ((dev->type == ARPHRD_ETHER) || (dev->type == ARPHRD_LOOPBACK))
-		dn_dn2eth(neigh->ha, dn->addr);
-	else {
-		net_dbg_ratelimited("Trying to create neigh for hw %d\n",
-				    dev->type);
-		return -EINVAL;
-	}
-
-	/*
-	 * Make an estimate of the remote block size by assuming that its
-	 * two less then the device mtu, which it true for ethernet (and
-	 * other things which support long format headers) since there is
-	 * an extra length field (of 16 bits) which isn't part of the
-	 * ethernet headers and which the DECnet specs won't admit is part
-	 * of the DECnet routing headers either.
-	 *
-	 * If we over estimate here its no big deal, the NSP negotiations
-	 * will prevent us from sending packets which are too large for the
-	 * remote node to handle. In any case this figure is normally updated
-	 * by a hello message in most cases.
-	 */
-	dn->blksize = dev->mtu - 2;
-
-	return 0;
-}
-
-static void dn_neigh_error_report(struct neighbour *neigh, struct sk_buff *skb)
-{
-	printk(KERN_DEBUG "dn_neigh_error_report: called\n");
-	kfree_skb(skb);
-}
-
-static int dn_neigh_output(struct neighbour *neigh, struct sk_buff *skb)
-{
-	struct dst_entry *dst = skb_dst(skb);
-	struct dn_route *rt = (struct dn_route *)dst;
-	struct net_device *dev = neigh->dev;
-	char mac_addr[ETH_ALEN];
-	unsigned int seq;
-	int err;
-
-	dn_dn2eth(mac_addr, rt->rt_local_src);
-	do {
-		seq = read_seqbegin(&neigh->ha_lock);
-		err = dev_hard_header(skb, dev, ntohs(skb->protocol),
-				      neigh->ha, mac_addr, skb->len);
-	} while (read_seqretry(&neigh->ha_lock, seq));
-
-	if (err >= 0)
-		err = dev_queue_xmit(skb);
-	else {
-		kfree_skb(skb);
-		err = -EINVAL;
-	}
-	return err;
-}
-
-static int dn_neigh_output_packet(struct net *net, struct sock *sk, struct sk_buff *skb)
-{
-	struct dst_entry *dst = skb_dst(skb);
-	struct dn_route *rt = (struct dn_route *)dst;
-	struct neighbour *neigh = rt->n;
-
-	return neigh->output(neigh, skb);
-}
-
-/*
- * For talking to broadcast devices: Ethernet & PPP
- */
-static int dn_long_output(struct neighbour *neigh, struct sock *sk,
-			  struct sk_buff *skb)
-{
-	struct net_device *dev = neigh->dev;
-	int headroom = dev->hard_header_len + sizeof(struct dn_long_packet) + 3;
-	unsigned char *data;
-	struct dn_long_packet *lp;
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-
-
-	if (skb_headroom(skb) < headroom) {
-		struct sk_buff *skb2 = skb_realloc_headroom(skb, headroom);
-		if (skb2 == NULL) {
-			net_crit_ratelimited("dn_long_output: no memory\n");
-			kfree_skb(skb);
-			return -ENOBUFS;
-		}
-		consume_skb(skb);
-		skb = skb2;
-		net_info_ratelimited("dn_long_output: Increasing headroom\n");
-	}
-
-	data = skb_push(skb, sizeof(struct dn_long_packet) + 3);
-	lp = (struct dn_long_packet *)(data+3);
-
-	*((__le16 *)data) = cpu_to_le16(skb->len - 2);
-	*(data + 2) = 1 | DN_RT_F_PF; /* Padding */
-
-	lp->msgflg   = DN_RT_PKT_LONG|(cb->rt_flags&(DN_RT_F_IE|DN_RT_F_RQR|DN_RT_F_RTS));
-	lp->d_area   = lp->d_subarea = 0;
-	dn_dn2eth(lp->d_id, cb->dst);
-	lp->s_area   = lp->s_subarea = 0;
-	dn_dn2eth(lp->s_id, cb->src);
-	lp->nl2      = 0;
-	lp->visit_ct = cb->hops & 0x3f;
-	lp->s_class  = 0;
-	lp->pt       = 0;
-
-	skb_reset_network_header(skb);
-
-	return NF_HOOK(NFPROTO_DECNET, NF_DN_POST_ROUTING,
-		       &init_net, sk, skb, NULL, neigh->dev,
-		       dn_neigh_output_packet);
-}
-
-/*
- * For talking to pointopoint and multidrop devices: DDCMP and X.25
- */
-static int dn_short_output(struct neighbour *neigh, struct sock *sk,
-			   struct sk_buff *skb)
-{
-	struct net_device *dev = neigh->dev;
-	int headroom = dev->hard_header_len + sizeof(struct dn_short_packet) + 2;
-	struct dn_short_packet *sp;
-	unsigned char *data;
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-
-
-	if (skb_headroom(skb) < headroom) {
-		struct sk_buff *skb2 = skb_realloc_headroom(skb, headroom);
-		if (skb2 == NULL) {
-			net_crit_ratelimited("dn_short_output: no memory\n");
-			kfree_skb(skb);
-			return -ENOBUFS;
-		}
-		consume_skb(skb);
-		skb = skb2;
-		net_info_ratelimited("dn_short_output: Increasing headroom\n");
-	}
-
-	data = skb_push(skb, sizeof(struct dn_short_packet) + 2);
-	*((__le16 *)data) = cpu_to_le16(skb->len - 2);
-	sp = (struct dn_short_packet *)(data+2);
-
-	sp->msgflg     = DN_RT_PKT_SHORT|(cb->rt_flags&(DN_RT_F_RQR|DN_RT_F_RTS));
-	sp->dstnode    = cb->dst;
-	sp->srcnode    = cb->src;
-	sp->forward    = cb->hops & 0x3f;
-
-	skb_reset_network_header(skb);
-
-	return NF_HOOK(NFPROTO_DECNET, NF_DN_POST_ROUTING,
-		       &init_net, sk, skb, NULL, neigh->dev,
-		       dn_neigh_output_packet);
-}
-
-/*
- * For talking to DECnet phase III nodes
- * Phase 3 output is the same as short output, execpt that
- * it clears the area bits before transmission.
- */
-static int dn_phase3_output(struct neighbour *neigh, struct sock *sk,
-			    struct sk_buff *skb)
-{
-	struct net_device *dev = neigh->dev;
-	int headroom = dev->hard_header_len + sizeof(struct dn_short_packet) + 2;
-	struct dn_short_packet *sp;
-	unsigned char *data;
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-
-	if (skb_headroom(skb) < headroom) {
-		struct sk_buff *skb2 = skb_realloc_headroom(skb, headroom);
-		if (skb2 == NULL) {
-			net_crit_ratelimited("dn_phase3_output: no memory\n");
-			kfree_skb(skb);
-			return -ENOBUFS;
-		}
-		consume_skb(skb);
-		skb = skb2;
-		net_info_ratelimited("dn_phase3_output: Increasing headroom\n");
-	}
-
-	data = skb_push(skb, sizeof(struct dn_short_packet) + 2);
-	*((__le16 *)data) = cpu_to_le16(skb->len - 2);
-	sp = (struct dn_short_packet *)(data + 2);
-
-	sp->msgflg   = DN_RT_PKT_SHORT|(cb->rt_flags&(DN_RT_F_RQR|DN_RT_F_RTS));
-	sp->dstnode  = cb->dst & cpu_to_le16(0x03ff);
-	sp->srcnode  = cb->src & cpu_to_le16(0x03ff);
-	sp->forward  = cb->hops & 0x3f;
-
-	skb_reset_network_header(skb);
-
-	return NF_HOOK(NFPROTO_DECNET, NF_DN_POST_ROUTING,
-		       &init_net, sk, skb, NULL, neigh->dev,
-		       dn_neigh_output_packet);
-}
-
-int dn_to_neigh_output(struct net *net, struct sock *sk, struct sk_buff *skb)
-{
-	struct dst_entry *dst = skb_dst(skb);
-	struct dn_route *rt = (struct dn_route *) dst;
-	struct neighbour *neigh = rt->n;
-	struct dn_neigh *dn = container_of(neigh, struct dn_neigh, n);
-	struct dn_dev *dn_db;
-	bool use_long;
-
-	rcu_read_lock();
-	dn_db = rcu_dereference(neigh->dev->dn_ptr);
-	if (dn_db == NULL) {
-		rcu_read_unlock();
-		return -EINVAL;
-	}
-	use_long = dn_db->use_long;
-	rcu_read_unlock();
-
-	if (dn->flags & DN_NDFLAG_P3)
-		return dn_phase3_output(neigh, sk, skb);
-	if (use_long)
-		return dn_long_output(neigh, sk, skb);
-	else
-		return dn_short_output(neigh, sk, skb);
-}
-
-/*
- * Unfortunately, the neighbour code uses the device in its hash
- * function, so we don't get any advantage from it. This function
- * basically does a neigh_lookup(), but without comparing the device
- * field. This is required for the On-Ethernet cache
- */
-
-/*
- * Pointopoint link receives a hello message
- */
-void dn_neigh_pointopoint_hello(struct sk_buff *skb)
-{
-	kfree_skb(skb);
-}
-
-/*
- * Ethernet router hello message received
- */
-int dn_neigh_router_hello(struct net *net, struct sock *sk, struct sk_buff *skb)
-{
-	struct rtnode_hello_message *msg = (struct rtnode_hello_message *)skb->data;
-
-	struct neighbour *neigh;
-	struct dn_neigh *dn;
-	struct dn_dev *dn_db;
-	__le16 src;
-
-	src = dn_eth2dn(msg->id);
-
-	neigh = __neigh_lookup(&dn_neigh_table, &src, skb->dev, 1);
-
-	dn = container_of(neigh, struct dn_neigh, n);
-
-	if (neigh) {
-		write_lock(&neigh->lock);
-
-		neigh->used = jiffies;
-		dn_db = rcu_dereference(neigh->dev->dn_ptr);
-
-		if (!(neigh->nud_state & NUD_PERMANENT)) {
-			neigh->updated = jiffies;
-
-			if (neigh->dev->type == ARPHRD_ETHER)
-				memcpy(neigh->ha, &eth_hdr(skb)->h_source, ETH_ALEN);
-
-			dn->blksize  = le16_to_cpu(msg->blksize);
-			dn->priority = msg->priority;
-
-			dn->flags &= ~DN_NDFLAG_P3;
-
-			switch (msg->iinfo & DN_RT_INFO_TYPE) {
-			case DN_RT_INFO_L1RT:
-				dn->flags &=~DN_NDFLAG_R2;
-				dn->flags |= DN_NDFLAG_R1;
-				break;
-			case DN_RT_INFO_L2RT:
-				dn->flags |= DN_NDFLAG_R2;
-			}
-		}
-
-		/* Only use routers in our area */
-		if ((le16_to_cpu(src)>>10) == (le16_to_cpu((decnet_address))>>10)) {
-			if (!dn_db->router) {
-				dn_db->router = neigh_clone(neigh);
-			} else {
-				if (msg->priority > ((struct dn_neigh *)dn_db->router)->priority)
-					neigh_release(xchg(&dn_db->router, neigh_clone(neigh)));
-			}
-		}
-		write_unlock(&neigh->lock);
-		neigh_release(neigh);
-	}
-
-	kfree_skb(skb);
-	return 0;
-}
-
-/*
- * Endnode hello message received
- */
-int dn_neigh_endnode_hello(struct net *net, struct sock *sk, struct sk_buff *skb)
-{
-	struct endnode_hello_message *msg = (struct endnode_hello_message *)skb->data;
-	struct neighbour *neigh;
-	struct dn_neigh *dn;
-	__le16 src;
-
-	src = dn_eth2dn(msg->id);
-
-	neigh = __neigh_lookup(&dn_neigh_table, &src, skb->dev, 1);
-
-	dn = container_of(neigh, struct dn_neigh, n);
-
-	if (neigh) {
-		write_lock(&neigh->lock);
-
-		neigh->used = jiffies;
-
-		if (!(neigh->nud_state & NUD_PERMANENT)) {
-			neigh->updated = jiffies;
-
-			if (neigh->dev->type == ARPHRD_ETHER)
-				memcpy(neigh->ha, &eth_hdr(skb)->h_source, ETH_ALEN);
-			dn->flags   &= ~(DN_NDFLAG_R1 | DN_NDFLAG_R2);
-			dn->blksize  = le16_to_cpu(msg->blksize);
-			dn->priority = 0;
-		}
-
-		write_unlock(&neigh->lock);
-		neigh_release(neigh);
-	}
-
-	kfree_skb(skb);
-	return 0;
-}
-
-static char *dn_find_slot(char *base, int max, int priority)
-{
-	int i;
-	unsigned char *min = NULL;
-
-	base += 6; /* skip first id */
-
-	for(i = 0; i < max; i++) {
-		if (!min || (*base < *min))
-			min = base;
-		base += 7; /* find next priority */
-	}
-
-	if (!min)
-		return NULL;
-
-	return (*min < priority) ? (min - 6) : NULL;
-}
-
-struct elist_cb_state {
-	struct net_device *dev;
-	unsigned char *ptr;
-	unsigned char *rs;
-	int t, n;
-};
-
-static void neigh_elist_cb(struct neighbour *neigh, void *_info)
-{
-	struct elist_cb_state *s = _info;
-	struct dn_neigh *dn;
-
-	if (neigh->dev != s->dev)
-		return;
-
-	dn = container_of(neigh, struct dn_neigh, n);
-	if (!(dn->flags & (DN_NDFLAG_R1|DN_NDFLAG_R2)))
-		return;
-
-	if (s->t == s->n)
-		s->rs = dn_find_slot(s->ptr, s->n, dn->priority);
-	else
-		s->t++;
-	if (s->rs == NULL)
-		return;
-
-	dn_dn2eth(s->rs, dn->addr);
-	s->rs += 6;
-	*(s->rs) = neigh->nud_state & NUD_CONNECTED ? 0x80 : 0x0;
-	*(s->rs) |= dn->priority;
-	s->rs++;
-}
-
-int dn_neigh_elist(struct net_device *dev, unsigned char *ptr, int n)
-{
-	struct elist_cb_state state;
-
-	state.dev = dev;
-	state.t = 0;
-	state.n = n;
-	state.ptr = ptr;
-	state.rs = ptr;
-
-	neigh_for_each(&dn_neigh_table, neigh_elist_cb, &state);
-
-	return state.t;
-}
-
-
-#ifdef CONFIG_PROC_FS
-
-static inline void dn_neigh_format_entry(struct seq_file *seq,
-					 struct neighbour *n)
-{
-	struct dn_neigh *dn = container_of(n, struct dn_neigh, n);
-	char buf[DN_ASCBUF_LEN];
-
-	read_lock(&n->lock);
-	seq_printf(seq, "%-7s %s%s%s   %02x    %02d  %07ld %-8s\n",
-		   dn_addr2asc(le16_to_cpu(dn->addr), buf),
-		   (dn->flags&DN_NDFLAG_R1) ? "1" : "-",
-		   (dn->flags&DN_NDFLAG_R2) ? "2" : "-",
-		   (dn->flags&DN_NDFLAG_P3) ? "3" : "-",
-		   dn->n.nud_state,
-		   refcount_read(&dn->n.refcnt),
-		   dn->blksize,
-		   (dn->n.dev) ? dn->n.dev->name : "?");
-	read_unlock(&n->lock);
-}
-
-static int dn_neigh_seq_show(struct seq_file *seq, void *v)
-{
-	if (v == SEQ_START_TOKEN) {
-		seq_puts(seq, "Addr    Flags State Use Blksize Dev\n");
-	} else {
-		dn_neigh_format_entry(seq, v);
-	}
-
-	return 0;
-}
-
-static void *dn_neigh_seq_start(struct seq_file *seq, loff_t *pos)
-{
-	return neigh_seq_start(seq, pos, &dn_neigh_table,
-			       NEIGH_SEQ_NEIGH_ONLY);
-}
-
-static const struct seq_operations dn_neigh_seq_ops = {
-	.start = dn_neigh_seq_start,
-	.next  = neigh_seq_next,
-	.stop  = neigh_seq_stop,
-	.show  = dn_neigh_seq_show,
-};
-#endif
-
-void __init dn_neigh_init(void)
-{
-	neigh_table_init(NEIGH_DN_TABLE, &dn_neigh_table);
-	proc_create_net("decnet_neigh", 0444, init_net.proc_net,
-			&dn_neigh_seq_ops, sizeof(struct neigh_seq_state));
-}
-
-void __exit dn_neigh_cleanup(void)
-{
-	remove_proc_entry("decnet_neigh", init_net.proc_net);
-	neigh_table_clear(NEIGH_DN_TABLE, &dn_neigh_table);
-}
diff --git a/net/decnet/dn_nsp_in.c b/net/decnet/dn_nsp_in.c
deleted file mode 100644
index c97bdca5ec30..000000000000
--- a/net/decnet/dn_nsp_in.c
+++ /dev/null
@@ -1,906 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * DECnet       An implementation of the DECnet protocol suite for the LINUX
- *              operating system.  DECnet is implemented using the  BSD Socket
- *              interface as the means of communication with the user level.
- *
- *              DECnet Network Services Protocol (Input)
- *
- * Author:      Eduardo Marcelo Serrat <emserrat@geocities.com>
- *
- * Changes:
- *
- *    Steve Whitehouse:  Split into dn_nsp_in.c and dn_nsp_out.c from
- *                       original dn_nsp.c.
- *    Steve Whitehouse:  Updated to work with my new routing architecture.
- *    Steve Whitehouse:  Add changes from Eduardo Serrat's patches.
- *    Steve Whitehouse:  Put all ack handling code in a common routine.
- *    Steve Whitehouse:  Put other common bits into dn_nsp_rx()
- *    Steve Whitehouse:  More checks on skb->len to catch bogus packets
- *                       Fixed various race conditions and possible nasties.
- *    Steve Whitehouse:  Now handles returned conninit frames.
- *     David S. Miller:  New socket locking
- *    Steve Whitehouse:  Fixed lockup when socket filtering was enabled.
- *         Paul Koning:  Fix to push CC sockets into RUN when acks are
- *                       received.
- *    Steve Whitehouse:
- *   Patrick Caulfield:  Checking conninits for correctness & sending of error
- *                       responses.
- *    Steve Whitehouse:  Added backlog congestion level return codes.
- *   Patrick Caulfield:
- *    Steve Whitehouse:  Added flow control support (outbound)
- *    Steve Whitehouse:  Prepare for nonlinear skbs
- */
-
-/******************************************************************************
-    (c) 1995-1998 E.M. Serrat		emserrat@geocities.com
-
-*******************************************************************************/
-
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/socket.h>
-#include <linux/in.h>
-#include <linux/kernel.h>
-#include <linux/timer.h>
-#include <linux/string.h>
-#include <linux/sockios.h>
-#include <linux/net.h>
-#include <linux/netdevice.h>
-#include <linux/inet.h>
-#include <linux/route.h>
-#include <linux/slab.h>
-#include <net/sock.h>
-#include <net/tcp_states.h>
-#include <linux/fcntl.h>
-#include <linux/mm.h>
-#include <linux/termios.h>
-#include <linux/interrupt.h>
-#include <linux/proc_fs.h>
-#include <linux/stat.h>
-#include <linux/init.h>
-#include <linux/poll.h>
-#include <linux/netfilter_decnet.h>
-#include <net/neighbour.h>
-#include <net/dst.h>
-#include <net/dn.h>
-#include <net/dn_nsp.h>
-#include <net/dn_dev.h>
-#include <net/dn_route.h>
-
-extern int decnet_log_martians;
-
-static void dn_log_martian(struct sk_buff *skb, const char *msg)
-{
-	if (decnet_log_martians) {
-		char *devname = skb->dev ? skb->dev->name : "???";
-		struct dn_skb_cb *cb = DN_SKB_CB(skb);
-		net_info_ratelimited("DECnet: Martian packet (%s) dev=%s src=0x%04hx dst=0x%04hx srcport=0x%04hx dstport=0x%04hx\n",
-				     msg, devname,
-				     le16_to_cpu(cb->src),
-				     le16_to_cpu(cb->dst),
-				     le16_to_cpu(cb->src_port),
-				     le16_to_cpu(cb->dst_port));
-	}
-}
-
-/*
- * For this function we've flipped the cross-subchannel bit
- * if the message is an otherdata or linkservice message. Thus
- * we can use it to work out what to update.
- */
-static void dn_ack(struct sock *sk, struct sk_buff *skb, unsigned short ack)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	unsigned short type = ((ack >> 12) & 0x0003);
-	int wakeup = 0;
-
-	switch (type) {
-	case 0: /* ACK - Data */
-		if (dn_after(ack, scp->ackrcv_dat)) {
-			scp->ackrcv_dat = ack & 0x0fff;
-			wakeup |= dn_nsp_check_xmit_queue(sk, skb,
-							  &scp->data_xmit_queue,
-							  ack);
-		}
-		break;
-	case 1: /* NAK - Data */
-		break;
-	case 2: /* ACK - OtherData */
-		if (dn_after(ack, scp->ackrcv_oth)) {
-			scp->ackrcv_oth = ack & 0x0fff;
-			wakeup |= dn_nsp_check_xmit_queue(sk, skb,
-							  &scp->other_xmit_queue,
-							  ack);
-		}
-		break;
-	case 3: /* NAK - OtherData */
-		break;
-	}
-
-	if (wakeup && !sock_flag(sk, SOCK_DEAD))
-		sk->sk_state_change(sk);
-}
-
-/*
- * This function is a universal ack processor.
- */
-static int dn_process_ack(struct sock *sk, struct sk_buff *skb, int oth)
-{
-	__le16 *ptr = (__le16 *)skb->data;
-	int len = 0;
-	unsigned short ack;
-
-	if (skb->len < 2)
-		return len;
-
-	if ((ack = le16_to_cpu(*ptr)) & 0x8000) {
-		skb_pull(skb, 2);
-		ptr++;
-		len += 2;
-		if ((ack & 0x4000) == 0) {
-			if (oth)
-				ack ^= 0x2000;
-			dn_ack(sk, skb, ack);
-		}
-	}
-
-	if (skb->len < 2)
-		return len;
-
-	if ((ack = le16_to_cpu(*ptr)) & 0x8000) {
-		skb_pull(skb, 2);
-		len += 2;
-		if ((ack & 0x4000) == 0) {
-			if (oth)
-				ack ^= 0x2000;
-			dn_ack(sk, skb, ack);
-		}
-	}
-
-	return len;
-}
-
-
-/**
- * dn_check_idf - Check an image data field format is correct.
- * @pptr: Pointer to pointer to image data
- * @len: Pointer to length of image data
- * @max: The maximum allowed length of the data in the image data field
- * @follow_on: Check that this many bytes exist beyond the end of the image data
- *
- * Returns: 0 if ok, -1 on error
- */
-static inline int dn_check_idf(unsigned char **pptr, int *len, unsigned char max, unsigned char follow_on)
-{
-	unsigned char *ptr = *pptr;
-	unsigned char flen = *ptr++;
-
-	(*len)--;
-	if (flen > max)
-		return -1;
-	if ((flen + follow_on) > *len)
-		return -1;
-
-	*len -= flen;
-	*pptr = ptr + flen;
-	return 0;
-}
-
-/*
- * Table of reason codes to pass back to node which sent us a badly
- * formed message, plus text messages for the log. A zero entry in
- * the reason field means "don't reply" otherwise a disc init is sent with
- * the specified reason code.
- */
-static struct {
-	unsigned short reason;
-	const char *text;
-} ci_err_table[] = {
- { 0,             "CI: Truncated message" },
- { NSP_REASON_ID, "CI: Destination username error" },
- { NSP_REASON_ID, "CI: Destination username type" },
- { NSP_REASON_US, "CI: Source username error" },
- { 0,             "CI: Truncated at menuver" },
- { 0,             "CI: Truncated before access or user data" },
- { NSP_REASON_IO, "CI: Access data format error" },
- { NSP_REASON_IO, "CI: User data format error" }
-};
-
-/*
- * This function uses a slightly different lookup method
- * to find its sockets, since it searches on object name/number
- * rather than port numbers. Various tests are done to ensure that
- * the incoming data is in the correct format before it is queued to
- * a socket.
- */
-static struct sock *dn_find_listener(struct sk_buff *skb, unsigned short *reason)
-{
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	struct nsp_conn_init_msg *msg = (struct nsp_conn_init_msg *)skb->data;
-	struct sockaddr_dn dstaddr;
-	struct sockaddr_dn srcaddr;
-	unsigned char type = 0;
-	int dstlen;
-	int srclen;
-	unsigned char *ptr;
-	int len;
-	int err = 0;
-	unsigned char menuver;
-
-	memset(&dstaddr, 0, sizeof(struct sockaddr_dn));
-	memset(&srcaddr, 0, sizeof(struct sockaddr_dn));
-
-	/*
-	 * 1. Decode & remove message header
-	 */
-	cb->src_port = msg->srcaddr;
-	cb->dst_port = msg->dstaddr;
-	cb->services = msg->services;
-	cb->info     = msg->info;
-	cb->segsize  = le16_to_cpu(msg->segsize);
-
-	if (!pskb_may_pull(skb, sizeof(*msg)))
-		goto err_out;
-
-	skb_pull(skb, sizeof(*msg));
-
-	len = skb->len;
-	ptr = skb->data;
-
-	/*
-	 * 2. Check destination end username format
-	 */
-	dstlen = dn_username2sockaddr(ptr, len, &dstaddr, &type);
-	err++;
-	if (dstlen < 0)
-		goto err_out;
-
-	err++;
-	if (type > 1)
-		goto err_out;
-
-	len -= dstlen;
-	ptr += dstlen;
-
-	/*
-	 * 3. Check source end username format
-	 */
-	srclen = dn_username2sockaddr(ptr, len, &srcaddr, &type);
-	err++;
-	if (srclen < 0)
-		goto err_out;
-
-	len -= srclen;
-	ptr += srclen;
-	err++;
-	if (len < 1)
-		goto err_out;
-
-	menuver = *ptr;
-	ptr++;
-	len--;
-
-	/*
-	 * 4. Check that optional data actually exists if menuver says it does
-	 */
-	err++;
-	if ((menuver & (DN_MENUVER_ACC | DN_MENUVER_USR)) && (len < 1))
-		goto err_out;
-
-	/*
-	 * 5. Check optional access data format
-	 */
-	err++;
-	if (menuver & DN_MENUVER_ACC) {
-		if (dn_check_idf(&ptr, &len, 39, 1))
-			goto err_out;
-		if (dn_check_idf(&ptr, &len, 39, 1))
-			goto err_out;
-		if (dn_check_idf(&ptr, &len, 39, (menuver & DN_MENUVER_USR) ? 1 : 0))
-			goto err_out;
-	}
-
-	/*
-	 * 6. Check optional user data format
-	 */
-	err++;
-	if (menuver & DN_MENUVER_USR) {
-		if (dn_check_idf(&ptr, &len, 16, 0))
-			goto err_out;
-	}
-
-	/*
-	 * 7. Look up socket based on destination end username
-	 */
-	return dn_sklist_find_listener(&dstaddr);
-err_out:
-	dn_log_martian(skb, ci_err_table[err].text);
-	*reason = ci_err_table[err].reason;
-	return NULL;
-}
-
-
-static void dn_nsp_conn_init(struct sock *sk, struct sk_buff *skb)
-{
-	if (sk_acceptq_is_full(sk)) {
-		kfree_skb(skb);
-		return;
-	}
-
-	sk_acceptq_added(sk);
-	skb_queue_tail(&sk->sk_receive_queue, skb);
-	sk->sk_state_change(sk);
-}
-
-static void dn_nsp_conn_conf(struct sock *sk, struct sk_buff *skb)
-{
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	struct dn_scp *scp = DN_SK(sk);
-	unsigned char *ptr;
-
-	if (skb->len < 4)
-		goto out;
-
-	ptr = skb->data;
-	cb->services = *ptr++;
-	cb->info = *ptr++;
-	cb->segsize = le16_to_cpu(*(__le16 *)ptr);
-
-	if ((scp->state == DN_CI) || (scp->state == DN_CD)) {
-		scp->persist = 0;
-		scp->addrrem = cb->src_port;
-		sk->sk_state = TCP_ESTABLISHED;
-		scp->state = DN_RUN;
-		scp->services_rem = cb->services;
-		scp->info_rem = cb->info;
-		scp->segsize_rem = cb->segsize;
-
-		if ((scp->services_rem & NSP_FC_MASK) == NSP_FC_NONE)
-			scp->max_window = decnet_no_fc_max_cwnd;
-
-		if (skb->len > 0) {
-			u16 dlen = *skb->data;
-			if ((dlen <= 16) && (dlen <= skb->len)) {
-				scp->conndata_in.opt_optl = cpu_to_le16(dlen);
-				skb_copy_from_linear_data_offset(skb, 1,
-					      scp->conndata_in.opt_data, dlen);
-			}
-		}
-		dn_nsp_send_link(sk, DN_NOCHANGE, 0);
-		if (!sock_flag(sk, SOCK_DEAD))
-			sk->sk_state_change(sk);
-	}
-
-out:
-	kfree_skb(skb);
-}
-
-static void dn_nsp_conn_ack(struct sock *sk, struct sk_buff *skb)
-{
-	struct dn_scp *scp = DN_SK(sk);
-
-	if (scp->state == DN_CI) {
-		scp->state = DN_CD;
-		scp->persist = 0;
-	}
-
-	kfree_skb(skb);
-}
-
-static void dn_nsp_disc_init(struct sock *sk, struct sk_buff *skb)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	unsigned short reason;
-
-	if (skb->len < 2)
-		goto out;
-
-	reason = le16_to_cpu(*(__le16 *)skb->data);
-	skb_pull(skb, 2);
-
-	scp->discdata_in.opt_status = cpu_to_le16(reason);
-	scp->discdata_in.opt_optl   = 0;
-	memset(scp->discdata_in.opt_data, 0, 16);
-
-	if (skb->len > 0) {
-		u16 dlen = *skb->data;
-		if ((dlen <= 16) && (dlen <= skb->len)) {
-			scp->discdata_in.opt_optl = cpu_to_le16(dlen);
-			skb_copy_from_linear_data_offset(skb, 1, scp->discdata_in.opt_data, dlen);
-		}
-	}
-
-	scp->addrrem = cb->src_port;
-	sk->sk_state = TCP_CLOSE;
-
-	switch (scp->state) {
-	case DN_CI:
-	case DN_CD:
-		scp->state = DN_RJ;
-		sk->sk_err = ECONNREFUSED;
-		break;
-	case DN_RUN:
-		sk->sk_shutdown |= SHUTDOWN_MASK;
-		scp->state = DN_DN;
-		break;
-	case DN_DI:
-		scp->state = DN_DIC;
-		break;
-	}
-
-	if (!sock_flag(sk, SOCK_DEAD)) {
-		if (sk->sk_socket->state != SS_UNCONNECTED)
-			sk->sk_socket->state = SS_DISCONNECTING;
-		sk->sk_state_change(sk);
-	}
-
-	/*
-	 * It appears that its possible for remote machines to send disc
-	 * init messages with no port identifier if we are in the CI and
-	 * possibly also the CD state. Obviously we shouldn't reply with
-	 * a message if we don't know what the end point is.
-	 */
-	if (scp->addrrem) {
-		dn_nsp_send_disc(sk, NSP_DISCCONF, NSP_REASON_DC, GFP_ATOMIC);
-	}
-	scp->persist_fxn = dn_destroy_timer;
-	scp->persist = dn_nsp_persist(sk);
-
-out:
-	kfree_skb(skb);
-}
-
-/*
- * disc_conf messages are also called no_resources or no_link
- * messages depending upon the "reason" field.
- */
-static void dn_nsp_disc_conf(struct sock *sk, struct sk_buff *skb)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	unsigned short reason;
-
-	if (skb->len != 2)
-		goto out;
-
-	reason = le16_to_cpu(*(__le16 *)skb->data);
-
-	sk->sk_state = TCP_CLOSE;
-
-	switch (scp->state) {
-	case DN_CI:
-		scp->state = DN_NR;
-		break;
-	case DN_DR:
-		if (reason == NSP_REASON_DC)
-			scp->state = DN_DRC;
-		if (reason == NSP_REASON_NL)
-			scp->state = DN_CN;
-		break;
-	case DN_DI:
-		scp->state = DN_DIC;
-		break;
-	case DN_RUN:
-		sk->sk_shutdown |= SHUTDOWN_MASK;
-		fallthrough;
-	case DN_CC:
-		scp->state = DN_CN;
-	}
-
-	if (!sock_flag(sk, SOCK_DEAD)) {
-		if (sk->sk_socket->state != SS_UNCONNECTED)
-			sk->sk_socket->state = SS_DISCONNECTING;
-		sk->sk_state_change(sk);
-	}
-
-	scp->persist_fxn = dn_destroy_timer;
-	scp->persist = dn_nsp_persist(sk);
-
-out:
-	kfree_skb(skb);
-}
-
-static void dn_nsp_linkservice(struct sock *sk, struct sk_buff *skb)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	unsigned short segnum;
-	unsigned char lsflags;
-	signed char fcval;
-	int wake_up = 0;
-	char *ptr = skb->data;
-	unsigned char fctype = scp->services_rem & NSP_FC_MASK;
-
-	if (skb->len != 4)
-		goto out;
-
-	segnum = le16_to_cpu(*(__le16 *)ptr);
-	ptr += 2;
-	lsflags = *(unsigned char *)ptr++;
-	fcval = *ptr;
-
-	/*
-	 * Here we ignore erronous packets which should really
-	 * should cause a connection abort. It is not critical
-	 * for now though.
-	 */
-	if (lsflags & 0xf8)
-		goto out;
-
-	if (seq_next(scp->numoth_rcv, segnum)) {
-		seq_add(&scp->numoth_rcv, 1);
-		switch(lsflags & 0x04) { /* FCVAL INT */
-		case 0x00: /* Normal Request */
-			switch(lsflags & 0x03) { /* FCVAL MOD */
-			case 0x00: /* Request count */
-				if (fcval < 0) {
-					unsigned char p_fcval = -fcval;
-					if ((scp->flowrem_dat > p_fcval) &&
-					    (fctype == NSP_FC_SCMC)) {
-						scp->flowrem_dat -= p_fcval;
-					}
-				} else if (fcval > 0) {
-					scp->flowrem_dat += fcval;
-					wake_up = 1;
-				}
-				break;
-			case 0x01: /* Stop outgoing data */
-				scp->flowrem_sw = DN_DONTSEND;
-				break;
-			case 0x02: /* Ok to start again */
-				scp->flowrem_sw = DN_SEND;
-				dn_nsp_output(sk);
-				wake_up = 1;
-			}
-			break;
-		case 0x04: /* Interrupt Request */
-			if (fcval > 0) {
-				scp->flowrem_oth += fcval;
-				wake_up = 1;
-			}
-			break;
-		}
-		if (wake_up && !sock_flag(sk, SOCK_DEAD))
-			sk->sk_state_change(sk);
-	}
-
-	dn_nsp_send_oth_ack(sk);
-
-out:
-	kfree_skb(skb);
-}
-
-/*
- * Copy of sock_queue_rcv_skb (from sock.h) without
- * bh_lock_sock() (its already held when this is called) which
- * also allows data and other data to be queued to a socket.
- */
-static __inline__ int dn_queue_skb(struct sock *sk, struct sk_buff *skb, int sig, struct sk_buff_head *queue)
-{
-	int err;
-
-	/* Cast skb->rcvbuf to unsigned... It's pointless, but reduces
-	   number of warnings when compiling with -W --ANK
-	 */
-	if (atomic_read(&sk->sk_rmem_alloc) + skb->truesize >=
-	    (unsigned int)sk->sk_rcvbuf) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	err = sk_filter(sk, skb);
-	if (err)
-		goto out;
-
-	skb_set_owner_r(skb, sk);
-	skb_queue_tail(queue, skb);
-
-	if (!sock_flag(sk, SOCK_DEAD))
-		sk->sk_data_ready(sk);
-out:
-	return err;
-}
-
-static void dn_nsp_otherdata(struct sock *sk, struct sk_buff *skb)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	unsigned short segnum;
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	int queued = 0;
-
-	if (skb->len < 2)
-		goto out;
-
-	cb->segnum = segnum = le16_to_cpu(*(__le16 *)skb->data);
-	skb_pull(skb, 2);
-
-	if (seq_next(scp->numoth_rcv, segnum)) {
-
-		if (dn_queue_skb(sk, skb, SIGURG, &scp->other_receive_queue) == 0) {
-			seq_add(&scp->numoth_rcv, 1);
-			scp->other_report = 0;
-			queued = 1;
-		}
-	}
-
-	dn_nsp_send_oth_ack(sk);
-out:
-	if (!queued)
-		kfree_skb(skb);
-}
-
-static void dn_nsp_data(struct sock *sk, struct sk_buff *skb)
-{
-	int queued = 0;
-	unsigned short segnum;
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	struct dn_scp *scp = DN_SK(sk);
-
-	if (skb->len < 2)
-		goto out;
-
-	cb->segnum = segnum = le16_to_cpu(*(__le16 *)skb->data);
-	skb_pull(skb, 2);
-
-	if (seq_next(scp->numdat_rcv, segnum)) {
-		if (dn_queue_skb(sk, skb, SIGIO, &sk->sk_receive_queue) == 0) {
-			seq_add(&scp->numdat_rcv, 1);
-			queued = 1;
-		}
-
-		if ((scp->flowloc_sw == DN_SEND) && dn_congested(sk)) {
-			scp->flowloc_sw = DN_DONTSEND;
-			dn_nsp_send_link(sk, DN_DONTSEND, 0);
-		}
-	}
-
-	dn_nsp_send_data_ack(sk);
-out:
-	if (!queued)
-		kfree_skb(skb);
-}
-
-/*
- * If one of our conninit messages is returned, this function
- * deals with it. It puts the socket into the NO_COMMUNICATION
- * state.
- */
-static void dn_returned_conn_init(struct sock *sk, struct sk_buff *skb)
-{
-	struct dn_scp *scp = DN_SK(sk);
-
-	if (scp->state == DN_CI) {
-		scp->state = DN_NC;
-		sk->sk_state = TCP_CLOSE;
-		if (!sock_flag(sk, SOCK_DEAD))
-			sk->sk_state_change(sk);
-	}
-
-	kfree_skb(skb);
-}
-
-static int dn_nsp_no_socket(struct sk_buff *skb, unsigned short reason)
-{
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	int ret = NET_RX_DROP;
-
-	/* Must not reply to returned packets */
-	if (cb->rt_flags & DN_RT_F_RTS)
-		goto out;
-
-	if ((reason != NSP_REASON_OK) && ((cb->nsp_flags & 0x0c) == 0x08)) {
-		switch (cb->nsp_flags & 0x70) {
-		case 0x10:
-		case 0x60: /* (Retransmitted) Connect Init */
-			dn_nsp_return_disc(skb, NSP_DISCINIT, reason);
-			ret = NET_RX_SUCCESS;
-			break;
-		case 0x20: /* Connect Confirm */
-			dn_nsp_return_disc(skb, NSP_DISCCONF, reason);
-			ret = NET_RX_SUCCESS;
-			break;
-		}
-	}
-
-out:
-	kfree_skb(skb);
-	return ret;
-}
-
-static int dn_nsp_rx_packet(struct net *net, struct sock *sk2,
-			    struct sk_buff *skb)
-{
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	struct sock *sk = NULL;
-	unsigned char *ptr = (unsigned char *)skb->data;
-	unsigned short reason = NSP_REASON_NL;
-
-	if (!pskb_may_pull(skb, 2))
-		goto free_out;
-
-	skb_reset_transport_header(skb);
-	cb->nsp_flags = *ptr++;
-
-	if (decnet_debug_level & 2)
-		printk(KERN_DEBUG "dn_nsp_rx: Message type 0x%02x\n", (int)cb->nsp_flags);
-
-	if (cb->nsp_flags & 0x83)
-		goto free_out;
-
-	/*
-	 * Filter out conninits and useless packet types
-	 */
-	if ((cb->nsp_flags & 0x0c) == 0x08) {
-		switch (cb->nsp_flags & 0x70) {
-		case 0x00: /* NOP */
-		case 0x70: /* Reserved */
-		case 0x50: /* Reserved, Phase II node init */
-			goto free_out;
-		case 0x10:
-		case 0x60:
-			if (unlikely(cb->rt_flags & DN_RT_F_RTS))
-				goto free_out;
-			sk = dn_find_listener(skb, &reason);
-			goto got_it;
-		}
-	}
-
-	if (!pskb_may_pull(skb, 3))
-		goto free_out;
-
-	/*
-	 * Grab the destination address.
-	 */
-	cb->dst_port = *(__le16 *)ptr;
-	cb->src_port = 0;
-	ptr += 2;
-
-	/*
-	 * If not a connack, grab the source address too.
-	 */
-	if (pskb_may_pull(skb, 5)) {
-		cb->src_port = *(__le16 *)ptr;
-		ptr += 2;
-		skb_pull(skb, 5);
-	}
-
-	/*
-	 * Returned packets...
-	 * Swap src & dst and look up in the normal way.
-	 */
-	if (unlikely(cb->rt_flags & DN_RT_F_RTS)) {
-		swap(cb->dst_port, cb->src_port);
-		swap(cb->dst, cb->src);
-	}
-
-	/*
-	 * Find the socket to which this skb is destined.
-	 */
-	sk = dn_find_by_skb(skb);
-got_it:
-	if (sk != NULL) {
-		struct dn_scp *scp = DN_SK(sk);
-
-		/* Reset backoff */
-		scp->nsp_rxtshift = 0;
-
-		/*
-		 * We linearize everything except data segments here.
-		 */
-		if (cb->nsp_flags & ~0x60) {
-			if (unlikely(skb_linearize(skb)))
-				goto free_out;
-		}
-
-		return sk_receive_skb(sk, skb, 0);
-	}
-
-	return dn_nsp_no_socket(skb, reason);
-
-free_out:
-	kfree_skb(skb);
-	return NET_RX_DROP;
-}
-
-int dn_nsp_rx(struct sk_buff *skb)
-{
-	return NF_HOOK(NFPROTO_DECNET, NF_DN_LOCAL_IN,
-		       &init_net, NULL, skb, skb->dev, NULL,
-		       dn_nsp_rx_packet);
-}
-
-/*
- * This is the main receive routine for sockets. It is called
- * from the above when the socket is not busy, and also from
- * sock_release() when there is a backlog queued up.
- */
-int dn_nsp_backlog_rcv(struct sock *sk, struct sk_buff *skb)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-
-	if (cb->rt_flags & DN_RT_F_RTS) {
-		if (cb->nsp_flags == 0x18 || cb->nsp_flags == 0x68)
-			dn_returned_conn_init(sk, skb);
-		else
-			kfree_skb(skb);
-		return NET_RX_SUCCESS;
-	}
-
-	/*
-	 * Control packet.
-	 */
-	if ((cb->nsp_flags & 0x0c) == 0x08) {
-		switch (cb->nsp_flags & 0x70) {
-		case 0x10:
-		case 0x60:
-			dn_nsp_conn_init(sk, skb);
-			break;
-		case 0x20:
-			dn_nsp_conn_conf(sk, skb);
-			break;
-		case 0x30:
-			dn_nsp_disc_init(sk, skb);
-			break;
-		case 0x40:
-			dn_nsp_disc_conf(sk, skb);
-			break;
-		}
-
-	} else if (cb->nsp_flags == 0x24) {
-		/*
-		 * Special for connacks, 'cos they don't have
-		 * ack data or ack otherdata info.
-		 */
-		dn_nsp_conn_ack(sk, skb);
-	} else {
-		int other = 1;
-
-		/* both data and ack frames can kick a CC socket into RUN */
-		if ((scp->state == DN_CC) && !sock_flag(sk, SOCK_DEAD)) {
-			scp->state = DN_RUN;
-			sk->sk_state = TCP_ESTABLISHED;
-			sk->sk_state_change(sk);
-		}
-
-		if ((cb->nsp_flags & 0x1c) == 0)
-			other = 0;
-		if (cb->nsp_flags == 0x04)
-			other = 0;
-
-		/*
-		 * Read out ack data here, this applies equally
-		 * to data, other data, link serivce and both
-		 * ack data and ack otherdata.
-		 */
-		dn_process_ack(sk, skb, other);
-
-		/*
-		 * If we've some sort of data here then call a
-		 * suitable routine for dealing with it, otherwise
-		 * the packet is an ack and can be discarded.
-		 */
-		if ((cb->nsp_flags & 0x0c) == 0) {
-
-			if (scp->state != DN_RUN)
-				goto free_out;
-
-			switch (cb->nsp_flags) {
-			case 0x10: /* LS */
-				dn_nsp_linkservice(sk, skb);
-				break;
-			case 0x30: /* OD */
-				dn_nsp_otherdata(sk, skb);
-				break;
-			default:
-				dn_nsp_data(sk, skb);
-			}
-
-		} else { /* Ack, chuck it out here */
-free_out:
-			kfree_skb(skb);
-		}
-	}
-
-	return NET_RX_SUCCESS;
-}
diff --git a/net/decnet/dn_nsp_out.c b/net/decnet/dn_nsp_out.c
deleted file mode 100644
index 00f2ed721ec1..000000000000
--- a/net/decnet/dn_nsp_out.c
+++ /dev/null
@@ -1,695 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * DECnet       An implementation of the DECnet protocol suite for the LINUX
- *              operating system.  DECnet is implemented using the  BSD Socket
- *              interface as the means of communication with the user level.
- *
- *              DECnet Network Services Protocol (Output)
- *
- * Author:      Eduardo Marcelo Serrat <emserrat@geocities.com>
- *
- * Changes:
- *
- *    Steve Whitehouse:  Split into dn_nsp_in.c and dn_nsp_out.c from
- *                       original dn_nsp.c.
- *    Steve Whitehouse:  Updated to work with my new routing architecture.
- *    Steve Whitehouse:  Added changes from Eduardo Serrat's patches.
- *    Steve Whitehouse:  Now conninits have the "return" bit set.
- *    Steve Whitehouse:  Fixes to check alloc'd skbs are non NULL!
- *                       Moved output state machine into one function
- *    Steve Whitehouse:  New output state machine
- *         Paul Koning:  Connect Confirm message fix.
- *      Eduardo Serrat:  Fix to stop dn_nsp_do_disc() sending malformed packets.
- *    Steve Whitehouse:  dn_nsp_output() and friends needed a spring clean
- *    Steve Whitehouse:  Moved dn_nsp_send() in here from route.h
- */
-
-/******************************************************************************
-    (c) 1995-1998 E.M. Serrat		emserrat@geocities.com
-
-*******************************************************************************/
-
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/socket.h>
-#include <linux/in.h>
-#include <linux/kernel.h>
-#include <linux/timer.h>
-#include <linux/string.h>
-#include <linux/sockios.h>
-#include <linux/net.h>
-#include <linux/netdevice.h>
-#include <linux/inet.h>
-#include <linux/route.h>
-#include <linux/slab.h>
-#include <net/sock.h>
-#include <linux/fcntl.h>
-#include <linux/mm.h>
-#include <linux/termios.h>
-#include <linux/interrupt.h>
-#include <linux/proc_fs.h>
-#include <linux/stat.h>
-#include <linux/init.h>
-#include <linux/poll.h>
-#include <linux/if_packet.h>
-#include <net/neighbour.h>
-#include <net/dst.h>
-#include <net/flow.h>
-#include <net/dn.h>
-#include <net/dn_nsp.h>
-#include <net/dn_dev.h>
-#include <net/dn_route.h>
-
-
-static int nsp_backoff[NSP_MAXRXTSHIFT + 1] = { 1, 2, 4, 8, 16, 32, 64, 64, 64, 64, 64, 64, 64 };
-
-static void dn_nsp_send(struct sk_buff *skb)
-{
-	struct sock *sk = skb->sk;
-	struct dn_scp *scp = DN_SK(sk);
-	struct dst_entry *dst;
-	struct flowidn fld;
-
-	skb_reset_transport_header(skb);
-	scp->stamp = jiffies;
-
-	dst = sk_dst_check(sk, 0);
-	if (dst) {
-try_again:
-		skb_dst_set(skb, dst);
-		dst_output(&init_net, skb->sk, skb);
-		return;
-	}
-
-	memset(&fld, 0, sizeof(fld));
-	fld.flowidn_oif = sk->sk_bound_dev_if;
-	fld.saddr = dn_saddr2dn(&scp->addr);
-	fld.daddr = dn_saddr2dn(&scp->peer);
-	dn_sk_ports_copy(&fld, scp);
-	fld.flowidn_proto = DNPROTO_NSP;
-	if (dn_route_output_sock(&sk->sk_dst_cache, &fld, sk, 0) == 0) {
-		dst = sk_dst_get(sk);
-		sk->sk_route_caps = dst->dev->features;
-		goto try_again;
-	}
-
-	sk->sk_err = EHOSTUNREACH;
-	if (!sock_flag(sk, SOCK_DEAD))
-		sk->sk_state_change(sk);
-}
-
-
-/*
- * If sk == NULL, then we assume that we are supposed to be making
- * a routing layer skb. If sk != NULL, then we are supposed to be
- * creating an skb for the NSP layer.
- *
- * The eventual aim is for each socket to have a cached header size
- * for its outgoing packets, and to set hdr from this when sk != NULL.
- */
-struct sk_buff *dn_alloc_skb(struct sock *sk, int size, gfp_t pri)
-{
-	struct sk_buff *skb;
-	int hdr = 64;
-
-	if ((skb = alloc_skb(size + hdr, pri)) == NULL)
-		return NULL;
-
-	skb->protocol = htons(ETH_P_DNA_RT);
-	skb->pkt_type = PACKET_OUTGOING;
-
-	if (sk)
-		skb_set_owner_w(skb, sk);
-
-	skb_reserve(skb, hdr);
-
-	return skb;
-}
-
-/*
- * Calculate persist timer based upon the smoothed round
- * trip time and the variance. Backoff according to the
- * nsp_backoff[] array.
- */
-unsigned long dn_nsp_persist(struct sock *sk)
-{
-	struct dn_scp *scp = DN_SK(sk);
-
-	unsigned long t = ((scp->nsp_srtt >> 2) + scp->nsp_rttvar) >> 1;
-
-	t *= nsp_backoff[scp->nsp_rxtshift];
-
-	if (t < HZ) t = HZ;
-	if (t > (600*HZ)) t = (600*HZ);
-
-	if (scp->nsp_rxtshift < NSP_MAXRXTSHIFT)
-		scp->nsp_rxtshift++;
-
-	/* printk(KERN_DEBUG "rxtshift %lu, t=%lu\n", scp->nsp_rxtshift, t); */
-
-	return t;
-}
-
-/*
- * This is called each time we get an estimate for the rtt
- * on the link.
- */
-static void dn_nsp_rtt(struct sock *sk, long rtt)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	long srtt = (long)scp->nsp_srtt;
-	long rttvar = (long)scp->nsp_rttvar;
-	long delta;
-
-	/*
-	 * If the jiffies clock flips over in the middle of timestamp
-	 * gathering this value might turn out negative, so we make sure
-	 * that is it always positive here.
-	 */
-	if (rtt < 0)
-		rtt = -rtt;
-	/*
-	 * Add new rtt to smoothed average
-	 */
-	delta = ((rtt << 3) - srtt);
-	srtt += (delta >> 3);
-	if (srtt >= 1)
-		scp->nsp_srtt = (unsigned long)srtt;
-	else
-		scp->nsp_srtt = 1;
-
-	/*
-	 * Add new rtt varience to smoothed varience
-	 */
-	delta >>= 1;
-	rttvar += ((((delta>0)?(delta):(-delta)) - rttvar) >> 2);
-	if (rttvar >= 1)
-		scp->nsp_rttvar = (unsigned long)rttvar;
-	else
-		scp->nsp_rttvar = 1;
-
-	/* printk(KERN_DEBUG "srtt=%lu rttvar=%lu\n", scp->nsp_srtt, scp->nsp_rttvar); */
-}
-
-/**
- * dn_nsp_clone_and_send - Send a data packet by cloning it
- * @skb: The packet to clone and transmit
- * @gfp: memory allocation flag
- *
- * Clone a queued data or other data packet and transmit it.
- *
- * Returns: The number of times the packet has been sent previously
- */
-static inline unsigned int dn_nsp_clone_and_send(struct sk_buff *skb,
-					     gfp_t gfp)
-{
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	struct sk_buff *skb2;
-	int ret = 0;
-
-	if ((skb2 = skb_clone(skb, gfp)) != NULL) {
-		ret = cb->xmit_count;
-		cb->xmit_count++;
-		cb->stamp = jiffies;
-		skb2->sk = skb->sk;
-		dn_nsp_send(skb2);
-	}
-
-	return ret;
-}
-
-/**
- * dn_nsp_output - Try and send something from socket queues
- * @sk: The socket whose queues are to be investigated
- *
- * Try and send the packet on the end of the data and other data queues.
- * Other data gets priority over data, and if we retransmit a packet we
- * reduce the window by dividing it in two.
- *
- */
-void dn_nsp_output(struct sock *sk)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	struct sk_buff *skb;
-	unsigned int reduce_win = 0;
-
-	/*
-	 * First we check for otherdata/linkservice messages
-	 */
-	if ((skb = skb_peek(&scp->other_xmit_queue)) != NULL)
-		reduce_win = dn_nsp_clone_and_send(skb, GFP_ATOMIC);
-
-	/*
-	 * If we may not send any data, we don't.
-	 * If we are still trying to get some other data down the
-	 * channel, we don't try and send any data.
-	 */
-	if (reduce_win || (scp->flowrem_sw != DN_SEND))
-		goto recalc_window;
-
-	if ((skb = skb_peek(&scp->data_xmit_queue)) != NULL)
-		reduce_win = dn_nsp_clone_and_send(skb, GFP_ATOMIC);
-
-	/*
-	 * If we've sent any frame more than once, we cut the
-	 * send window size in half. There is always a minimum
-	 * window size of one available.
-	 */
-recalc_window:
-	if (reduce_win) {
-		scp->snd_window >>= 1;
-		if (scp->snd_window < NSP_MIN_WINDOW)
-			scp->snd_window = NSP_MIN_WINDOW;
-	}
-}
-
-int dn_nsp_xmit_timeout(struct sock *sk)
-{
-	struct dn_scp *scp = DN_SK(sk);
-
-	dn_nsp_output(sk);
-
-	if (!skb_queue_empty(&scp->data_xmit_queue) ||
-	    !skb_queue_empty(&scp->other_xmit_queue))
-		scp->persist = dn_nsp_persist(sk);
-
-	return 0;
-}
-
-static inline __le16 *dn_mk_common_header(struct dn_scp *scp, struct sk_buff *skb, unsigned char msgflag, int len)
-{
-	unsigned char *ptr = skb_push(skb, len);
-
-	BUG_ON(len < 5);
-
-	*ptr++ = msgflag;
-	*((__le16 *)ptr) = scp->addrrem;
-	ptr += 2;
-	*((__le16 *)ptr) = scp->addrloc;
-	ptr += 2;
-	return (__le16 __force *)ptr;
-}
-
-static __le16 *dn_mk_ack_header(struct sock *sk, struct sk_buff *skb, unsigned char msgflag, int hlen, int other)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	unsigned short acknum = scp->numdat_rcv & 0x0FFF;
-	unsigned short ackcrs = scp->numoth_rcv & 0x0FFF;
-	__le16 *ptr;
-
-	BUG_ON(hlen < 9);
-
-	scp->ackxmt_dat = acknum;
-	scp->ackxmt_oth = ackcrs;
-	acknum |= 0x8000;
-	ackcrs |= 0x8000;
-
-	/* If this is an "other data/ack" message, swap acknum and ackcrs */
-	if (other)
-		swap(acknum, ackcrs);
-
-	/* Set "cross subchannel" bit in ackcrs */
-	ackcrs |= 0x2000;
-
-	ptr = dn_mk_common_header(scp, skb, msgflag, hlen);
-
-	*ptr++ = cpu_to_le16(acknum);
-	*ptr++ = cpu_to_le16(ackcrs);
-
-	return ptr;
-}
-
-static __le16 *dn_nsp_mk_data_header(struct sock *sk, struct sk_buff *skb, int oth)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	__le16 *ptr = dn_mk_ack_header(sk, skb, cb->nsp_flags, 11, oth);
-
-	if (unlikely(oth)) {
-		cb->segnum = scp->numoth;
-		seq_add(&scp->numoth, 1);
-	} else {
-		cb->segnum = scp->numdat;
-		seq_add(&scp->numdat, 1);
-	}
-	*(ptr++) = cpu_to_le16(cb->segnum);
-
-	return ptr;
-}
-
-void dn_nsp_queue_xmit(struct sock *sk, struct sk_buff *skb,
-			gfp_t gfp, int oth)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	unsigned long t = ((scp->nsp_srtt >> 2) + scp->nsp_rttvar) >> 1;
-
-	cb->xmit_count = 0;
-	dn_nsp_mk_data_header(sk, skb, oth);
-
-	/*
-	 * Slow start: If we have been idle for more than
-	 * one RTT, then reset window to min size.
-	 */
-	if ((jiffies - scp->stamp) > t)
-		scp->snd_window = NSP_MIN_WINDOW;
-
-	if (oth)
-		skb_queue_tail(&scp->other_xmit_queue, skb);
-	else
-		skb_queue_tail(&scp->data_xmit_queue, skb);
-
-	if (scp->flowrem_sw != DN_SEND)
-		return;
-
-	dn_nsp_clone_and_send(skb, gfp);
-}
-
-
-int dn_nsp_check_xmit_queue(struct sock *sk, struct sk_buff *skb, struct sk_buff_head *q, unsigned short acknum)
-{
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	struct dn_scp *scp = DN_SK(sk);
-	struct sk_buff *skb2, *n, *ack = NULL;
-	int wakeup = 0;
-	int try_retrans = 0;
-	unsigned long reftime = cb->stamp;
-	unsigned long pkttime;
-	unsigned short xmit_count;
-	unsigned short segnum;
-
-	skb_queue_walk_safe(q, skb2, n) {
-		struct dn_skb_cb *cb2 = DN_SKB_CB(skb2);
-
-		if (dn_before_or_equal(cb2->segnum, acknum))
-			ack = skb2;
-
-		/* printk(KERN_DEBUG "ack: %s %04x %04x\n", ack ? "ACK" : "SKIP", (int)cb2->segnum, (int)acknum); */
-
-		if (ack == NULL)
-			continue;
-
-		/* printk(KERN_DEBUG "check_xmit_queue: %04x, %d\n", acknum, cb2->xmit_count); */
-
-		/* Does _last_ packet acked have xmit_count > 1 */
-		try_retrans = 0;
-		/* Remember to wake up the sending process */
-		wakeup = 1;
-		/* Keep various statistics */
-		pkttime = cb2->stamp;
-		xmit_count = cb2->xmit_count;
-		segnum = cb2->segnum;
-		/* Remove and drop ack'ed packet */
-		skb_unlink(ack, q);
-		kfree_skb(ack);
-		ack = NULL;
-
-		/*
-		 * We don't expect to see acknowledgements for packets we
-		 * haven't sent yet.
-		 */
-		WARN_ON(xmit_count == 0);
-
-		/*
-		 * If the packet has only been sent once, we can use it
-		 * to calculate the RTT and also open the window a little
-		 * further.
-		 */
-		if (xmit_count == 1) {
-			if (dn_equal(segnum, acknum))
-				dn_nsp_rtt(sk, (long)(pkttime - reftime));
-
-			if (scp->snd_window < scp->max_window)
-				scp->snd_window++;
-		}
-
-		/*
-		 * Packet has been sent more than once. If this is the last
-		 * packet to be acknowledged then we want to send the next
-		 * packet in the send queue again (assumes the remote host does
-		 * go-back-N error control).
-		 */
-		if (xmit_count > 1)
-			try_retrans = 1;
-	}
-
-	if (try_retrans)
-		dn_nsp_output(sk);
-
-	return wakeup;
-}
-
-void dn_nsp_send_data_ack(struct sock *sk)
-{
-	struct sk_buff *skb = NULL;
-
-	if ((skb = dn_alloc_skb(sk, 9, GFP_ATOMIC)) == NULL)
-		return;
-
-	skb_reserve(skb, 9);
-	dn_mk_ack_header(sk, skb, 0x04, 9, 0);
-	dn_nsp_send(skb);
-}
-
-void dn_nsp_send_oth_ack(struct sock *sk)
-{
-	struct sk_buff *skb = NULL;
-
-	if ((skb = dn_alloc_skb(sk, 9, GFP_ATOMIC)) == NULL)
-		return;
-
-	skb_reserve(skb, 9);
-	dn_mk_ack_header(sk, skb, 0x14, 9, 1);
-	dn_nsp_send(skb);
-}
-
-
-void dn_send_conn_ack (struct sock *sk)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	struct sk_buff *skb = NULL;
-	struct nsp_conn_ack_msg *msg;
-
-	if ((skb = dn_alloc_skb(sk, 3, sk->sk_allocation)) == NULL)
-		return;
-
-	msg = skb_put(skb, 3);
-	msg->msgflg = 0x24;
-	msg->dstaddr = scp->addrrem;
-
-	dn_nsp_send(skb);
-}
-
-static int dn_nsp_retrans_conn_conf(struct sock *sk)
-{
-	struct dn_scp *scp = DN_SK(sk);
-
-	if (scp->state == DN_CC)
-		dn_send_conn_conf(sk, GFP_ATOMIC);
-
-	return 0;
-}
-
-void dn_send_conn_conf(struct sock *sk, gfp_t gfp)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	struct sk_buff *skb = NULL;
-	struct nsp_conn_init_msg *msg;
-	__u8 len = (__u8)le16_to_cpu(scp->conndata_out.opt_optl);
-
-	if ((skb = dn_alloc_skb(sk, 50 + len, gfp)) == NULL)
-		return;
-
-	msg = skb_put(skb, sizeof(*msg));
-	msg->msgflg = 0x28;
-	msg->dstaddr = scp->addrrem;
-	msg->srcaddr = scp->addrloc;
-	msg->services = scp->services_loc;
-	msg->info = scp->info_loc;
-	msg->segsize = cpu_to_le16(scp->segsize_loc);
-
-	skb_put_u8(skb, len);
-
-	if (len > 0)
-		skb_put_data(skb, scp->conndata_out.opt_data, len);
-
-
-	dn_nsp_send(skb);
-
-	scp->persist = dn_nsp_persist(sk);
-	scp->persist_fxn = dn_nsp_retrans_conn_conf;
-}
-
-
-static __inline__ void dn_nsp_do_disc(struct sock *sk, unsigned char msgflg,
-			unsigned short reason, gfp_t gfp,
-			struct dst_entry *dst,
-			int ddl, unsigned char *dd, __le16 rem, __le16 loc)
-{
-	struct sk_buff *skb = NULL;
-	int size = 7 + ddl + ((msgflg == NSP_DISCINIT) ? 1 : 0);
-	unsigned char *msg;
-
-	if ((dst == NULL) || (rem == 0)) {
-		net_dbg_ratelimited("DECnet: dn_nsp_do_disc: BUG! Please report this to SteveW@ACM.org rem=%u dst=%p\n",
-				    le16_to_cpu(rem), dst);
-		return;
-	}
-
-	if ((skb = dn_alloc_skb(sk, size, gfp)) == NULL)
-		return;
-
-	msg = skb_put(skb, size);
-	*msg++ = msgflg;
-	*(__le16 *)msg = rem;
-	msg += 2;
-	*(__le16 *)msg = loc;
-	msg += 2;
-	*(__le16 *)msg = cpu_to_le16(reason);
-	msg += 2;
-	if (msgflg == NSP_DISCINIT)
-		*msg++ = ddl;
-
-	if (ddl) {
-		memcpy(msg, dd, ddl);
-	}
-
-	/*
-	 * This doesn't go via the dn_nsp_send() function since we need
-	 * to be able to send disc packets out which have no socket
-	 * associations.
-	 */
-	skb_dst_set(skb, dst_clone(dst));
-	dst_output(&init_net, skb->sk, skb);
-}
-
-
-void dn_nsp_send_disc(struct sock *sk, unsigned char msgflg,
-			unsigned short reason, gfp_t gfp)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	int ddl = 0;
-
-	if (msgflg == NSP_DISCINIT)
-		ddl = le16_to_cpu(scp->discdata_out.opt_optl);
-
-	if (reason == 0)
-		reason = le16_to_cpu(scp->discdata_out.opt_status);
-
-	dn_nsp_do_disc(sk, msgflg, reason, gfp, __sk_dst_get(sk), ddl,
-		scp->discdata_out.opt_data, scp->addrrem, scp->addrloc);
-}
-
-
-void dn_nsp_return_disc(struct sk_buff *skb, unsigned char msgflg,
-			unsigned short reason)
-{
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	int ddl = 0;
-	gfp_t gfp = GFP_ATOMIC;
-
-	dn_nsp_do_disc(NULL, msgflg, reason, gfp, skb_dst(skb), ddl,
-			NULL, cb->src_port, cb->dst_port);
-}
-
-
-void dn_nsp_send_link(struct sock *sk, unsigned char lsflags, char fcval)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	struct sk_buff *skb;
-	unsigned char *ptr;
-	gfp_t gfp = GFP_ATOMIC;
-
-	if ((skb = dn_alloc_skb(sk, DN_MAX_NSP_DATA_HEADER + 2, gfp)) == NULL)
-		return;
-
-	skb_reserve(skb, DN_MAX_NSP_DATA_HEADER);
-	ptr = skb_put(skb, 2);
-	DN_SKB_CB(skb)->nsp_flags = 0x10;
-	*ptr++ = lsflags;
-	*ptr = fcval;
-
-	dn_nsp_queue_xmit(sk, skb, gfp, 1);
-
-	scp->persist = dn_nsp_persist(sk);
-	scp->persist_fxn = dn_nsp_xmit_timeout;
-}
-
-static int dn_nsp_retrans_conninit(struct sock *sk)
-{
-	struct dn_scp *scp = DN_SK(sk);
-
-	if (scp->state == DN_CI)
-		dn_nsp_send_conninit(sk, NSP_RCI);
-
-	return 0;
-}
-
-void dn_nsp_send_conninit(struct sock *sk, unsigned char msgflg)
-{
-	struct dn_scp *scp = DN_SK(sk);
-	struct nsp_conn_init_msg *msg;
-	unsigned char aux;
-	unsigned char menuver;
-	struct dn_skb_cb *cb;
-	unsigned char type = 1;
-	gfp_t allocation = (msgflg == NSP_CI) ? sk->sk_allocation : GFP_ATOMIC;
-	struct sk_buff *skb = dn_alloc_skb(sk, 200, allocation);
-
-	if (!skb)
-		return;
-
-	cb  = DN_SKB_CB(skb);
-	msg = skb_put(skb, sizeof(*msg));
-
-	msg->msgflg	= msgflg;
-	msg->dstaddr	= 0x0000;		/* Remote Node will assign it*/
-
-	msg->srcaddr	= scp->addrloc;
-	msg->services	= scp->services_loc;	/* Requested flow control    */
-	msg->info	= scp->info_loc;	/* Version Number            */
-	msg->segsize	= cpu_to_le16(scp->segsize_loc);	/* Max segment size  */
-
-	if (scp->peer.sdn_objnum)
-		type = 0;
-
-	skb_put(skb, dn_sockaddr2username(&scp->peer,
-					  skb_tail_pointer(skb), type));
-	skb_put(skb, dn_sockaddr2username(&scp->addr,
-					  skb_tail_pointer(skb), 2));
-
-	menuver = DN_MENUVER_ACC | DN_MENUVER_USR;
-	if (scp->peer.sdn_flags & SDF_PROXY)
-		menuver |= DN_MENUVER_PRX;
-	if (scp->peer.sdn_flags & SDF_UICPROXY)
-		menuver |= DN_MENUVER_UIC;
-
-	skb_put_u8(skb, menuver);	/* Menu Version		*/
-
-	aux = scp->accessdata.acc_userl;
-	skb_put_u8(skb, aux);
-	if (aux > 0)
-		skb_put_data(skb, scp->accessdata.acc_user, aux);
-
-	aux = scp->accessdata.acc_passl;
-	skb_put_u8(skb, aux);
-	if (aux > 0)
-		skb_put_data(skb, scp->accessdata.acc_pass, aux);
-
-	aux = scp->accessdata.acc_accl;
-	skb_put_u8(skb, aux);
-	if (aux > 0)
-		skb_put_data(skb, scp->accessdata.acc_acc, aux);
-
-	aux = (__u8)le16_to_cpu(scp->conndata_out.opt_optl);
-	skb_put_u8(skb, aux);
-	if (aux > 0)
-		skb_put_data(skb, scp->conndata_out.opt_data, aux);
-
-	scp->persist = dn_nsp_persist(sk);
-	scp->persist_fxn = dn_nsp_retrans_conninit;
-
-	cb->rt_flags = DN_RT_F_RQR;
-
-	dn_nsp_send(skb);
-}
diff --git a/net/decnet/dn_route.c b/net/decnet/dn_route.c
deleted file mode 100644
index 4cac31d22a50..000000000000
--- a/net/decnet/dn_route.c
+++ /dev/null
@@ -1,1923 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * DECnet       An implementation of the DECnet protocol suite for the LINUX
- *              operating system.  DECnet is implemented using the  BSD Socket
- *              interface as the means of communication with the user level.
- *
- *              DECnet Routing Functions (Endnode and Router)
- *
- * Authors:     Steve Whitehouse <SteveW@ACM.org>
- *              Eduardo Marcelo Serrat <emserrat@geocities.com>
- *
- * Changes:
- *              Steve Whitehouse : Fixes to allow "intra-ethernet" and
- *                                 "return-to-sender" bits on outgoing
- *                                 packets.
- *		Steve Whitehouse : Timeouts for cached routes.
- *              Steve Whitehouse : Use dst cache for input routes too.
- *              Steve Whitehouse : Fixed error values in dn_send_skb.
- *              Steve Whitehouse : Rework routing functions to better fit
- *                                 DECnet routing design
- *              Alexey Kuznetsov : New SMP locking
- *              Steve Whitehouse : More SMP locking changes & dn_cache_dump()
- *              Steve Whitehouse : Prerouting NF hook, now really is prerouting.
- *				   Fixed possible skb leak in rtnetlink funcs.
- *              Steve Whitehouse : Dave Miller's dynamic hash table sizing and
- *                                 Alexey Kuznetsov's finer grained locking
- *                                 from ipv4/route.c.
- *              Steve Whitehouse : Routing is now starting to look like a
- *                                 sensible set of code now, mainly due to
- *                                 my copying the IPv4 routing code. The
- *                                 hooks here are modified and will continue
- *                                 to evolve for a while.
- *              Steve Whitehouse : Real SMP at last :-) Also new netfilter
- *                                 stuff. Look out raw sockets your days
- *                                 are numbered!
- *              Steve Whitehouse : Added return-to-sender functions. Added
- *                                 backlog congestion level return codes.
- *		Steve Whitehouse : Fixed bug where routes were set up with
- *                                 no ref count on net devices.
- *              Steve Whitehouse : RCU for the route cache
- *              Steve Whitehouse : Preparations for the flow cache
- *              Steve Whitehouse : Prepare for nonlinear skbs
- */
-
-/******************************************************************************
-    (c) 1995-1998 E.M. Serrat		emserrat@geocities.com
-
-*******************************************************************************/
-
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/socket.h>
-#include <linux/in.h>
-#include <linux/kernel.h>
-#include <linux/sockios.h>
-#include <linux/net.h>
-#include <linux/netdevice.h>
-#include <linux/inet.h>
-#include <linux/route.h>
-#include <linux/in_route.h>
-#include <linux/slab.h>
-#include <net/sock.h>
-#include <linux/mm.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <linux/init.h>
-#include <linux/rtnetlink.h>
-#include <linux/string.h>
-#include <linux/netfilter_decnet.h>
-#include <linux/rcupdate.h>
-#include <linux/times.h>
-#include <linux/export.h>
-#include <asm/errno.h>
-#include <net/net_namespace.h>
-#include <net/netlink.h>
-#include <net/neighbour.h>
-#include <net/dst.h>
-#include <net/flow.h>
-#include <net/fib_rules.h>
-#include <net/dn.h>
-#include <net/dn_dev.h>
-#include <net/dn_nsp.h>
-#include <net/dn_route.h>
-#include <net/dn_neigh.h>
-#include <net/dn_fib.h>
-
-struct dn_rt_hash_bucket
-{
-	struct dn_route __rcu *chain;
-	spinlock_t lock;
-};
-
-extern struct neigh_table dn_neigh_table;
-
-
-static unsigned char dn_hiord_addr[6] = {0xAA,0x00,0x04,0x00,0x00,0x00};
-
-static const int dn_rt_min_delay = 2 * HZ;
-static const int dn_rt_max_delay = 10 * HZ;
-static const int dn_rt_mtu_expires = 10 * 60 * HZ;
-
-static unsigned long dn_rt_deadline;
-
-static int dn_dst_gc(struct dst_ops *ops);
-static struct dst_entry *dn_dst_check(struct dst_entry *, __u32);
-static unsigned int dn_dst_default_advmss(const struct dst_entry *dst);
-static unsigned int dn_dst_mtu(const struct dst_entry *dst);
-static void dn_dst_destroy(struct dst_entry *);
-static void dn_dst_ifdown(struct dst_entry *, struct net_device *dev, int how);
-static struct dst_entry *dn_dst_negative_advice(struct dst_entry *);
-static void dn_dst_link_failure(struct sk_buff *);
-static void dn_dst_update_pmtu(struct dst_entry *dst, struct sock *sk,
-			       struct sk_buff *skb , u32 mtu,
-			       bool confirm_neigh);
-static void dn_dst_redirect(struct dst_entry *dst, struct sock *sk,
-			    struct sk_buff *skb);
-static struct neighbour *dn_dst_neigh_lookup(const struct dst_entry *dst,
-					     struct sk_buff *skb,
-					     const void *daddr);
-static int dn_route_input(struct sk_buff *);
-static void dn_run_flush(struct timer_list *unused);
-
-static struct dn_rt_hash_bucket *dn_rt_hash_table;
-static unsigned int dn_rt_hash_mask;
-
-static struct timer_list dn_route_timer;
-static DEFINE_TIMER(dn_rt_flush_timer, dn_run_flush);
-int decnet_dst_gc_interval = 2;
-
-static struct dst_ops dn_dst_ops = {
-	.family =		PF_DECnet,
-	.gc_thresh =		128,
-	.gc =			dn_dst_gc,
-	.check =		dn_dst_check,
-	.default_advmss =	dn_dst_default_advmss,
-	.mtu =			dn_dst_mtu,
-	.cow_metrics =		dst_cow_metrics_generic,
-	.destroy =		dn_dst_destroy,
-	.ifdown =		dn_dst_ifdown,
-	.negative_advice =	dn_dst_negative_advice,
-	.link_failure =		dn_dst_link_failure,
-	.update_pmtu =		dn_dst_update_pmtu,
-	.redirect =		dn_dst_redirect,
-	.neigh_lookup =		dn_dst_neigh_lookup,
-};
-
-static void dn_dst_destroy(struct dst_entry *dst)
-{
-	struct dn_route *rt = (struct dn_route *) dst;
-
-	if (rt->n)
-		neigh_release(rt->n);
-	dst_destroy_metrics_generic(dst);
-}
-
-static void dn_dst_ifdown(struct dst_entry *dst, struct net_device *dev, int how)
-{
-	if (how) {
-		struct dn_route *rt = (struct dn_route *) dst;
-		struct neighbour *n = rt->n;
-
-		if (n && n->dev == dev) {
-			n->dev = dev_net(dev)->loopback_dev;
-			dev_hold(n->dev);
-			dev_put(dev);
-		}
-	}
-}
-
-static __inline__ unsigned int dn_hash(__le16 src, __le16 dst)
-{
-	__u16 tmp = (__u16 __force)(src ^ dst);
-	tmp ^= (tmp >> 3);
-	tmp ^= (tmp >> 5);
-	tmp ^= (tmp >> 10);
-	return dn_rt_hash_mask & (unsigned int)tmp;
-}
-
-static void dn_dst_check_expire(struct timer_list *unused)
-{
-	int i;
-	struct dn_route *rt;
-	struct dn_route __rcu **rtp;
-	unsigned long now = jiffies;
-	unsigned long expire = 120 * HZ;
-
-	for (i = 0; i <= dn_rt_hash_mask; i++) {
-		rtp = &dn_rt_hash_table[i].chain;
-
-		spin_lock(&dn_rt_hash_table[i].lock);
-		while ((rt = rcu_dereference_protected(*rtp,
-						lockdep_is_held(&dn_rt_hash_table[i].lock))) != NULL) {
-			if (atomic_read(&rt->dst.__refcnt) > 1 ||
-			    (now - rt->dst.lastuse) < expire) {
-				rtp = &rt->dn_next;
-				continue;
-			}
-			*rtp = rt->dn_next;
-			rt->dn_next = NULL;
-			dst_dev_put(&rt->dst);
-			dst_release(&rt->dst);
-		}
-		spin_unlock(&dn_rt_hash_table[i].lock);
-
-		if ((jiffies - now) > 0)
-			break;
-	}
-
-	mod_timer(&dn_route_timer, now + decnet_dst_gc_interval * HZ);
-}
-
-static int dn_dst_gc(struct dst_ops *ops)
-{
-	struct dn_route *rt;
-	struct dn_route __rcu **rtp;
-	int i;
-	unsigned long now = jiffies;
-	unsigned long expire = 10 * HZ;
-
-	for (i = 0; i <= dn_rt_hash_mask; i++) {
-
-		spin_lock_bh(&dn_rt_hash_table[i].lock);
-		rtp = &dn_rt_hash_table[i].chain;
-
-		while ((rt = rcu_dereference_protected(*rtp,
-						lockdep_is_held(&dn_rt_hash_table[i].lock))) != NULL) {
-			if (atomic_read(&rt->dst.__refcnt) > 1 ||
-			    (now - rt->dst.lastuse) < expire) {
-				rtp = &rt->dn_next;
-				continue;
-			}
-			*rtp = rt->dn_next;
-			rt->dn_next = NULL;
-			dst_dev_put(&rt->dst);
-			dst_release(&rt->dst);
-			break;
-		}
-		spin_unlock_bh(&dn_rt_hash_table[i].lock);
-	}
-
-	return 0;
-}
-
-/*
- * The decnet standards don't impose a particular minimum mtu, what they
- * do insist on is that the routing layer accepts a datagram of at least
- * 230 bytes long. Here we have to subtract the routing header length from
- * 230 to get the minimum acceptable mtu. If there is no neighbour, then we
- * assume the worst and use a long header size.
- *
- * We update both the mtu and the advertised mss (i.e. the segment size we
- * advertise to the other end).
- */
-static void dn_dst_update_pmtu(struct dst_entry *dst, struct sock *sk,
-			       struct sk_buff *skb, u32 mtu,
-			       bool confirm_neigh)
-{
-	struct dn_route *rt = (struct dn_route *) dst;
-	struct neighbour *n = rt->n;
-	u32 min_mtu = 230;
-	struct dn_dev *dn;
-
-	dn = n ? rcu_dereference_raw(n->dev->dn_ptr) : NULL;
-
-	if (dn && dn->use_long == 0)
-		min_mtu -= 6;
-	else
-		min_mtu -= 21;
-
-	if (dst_metric(dst, RTAX_MTU) > mtu && mtu >= min_mtu) {
-		if (!(dst_metric_locked(dst, RTAX_MTU))) {
-			dst_metric_set(dst, RTAX_MTU, mtu);
-			dst_set_expires(dst, dn_rt_mtu_expires);
-		}
-		if (!(dst_metric_locked(dst, RTAX_ADVMSS))) {
-			u32 mss = mtu - DN_MAX_NSP_DATA_HEADER;
-			u32 existing_mss = dst_metric_raw(dst, RTAX_ADVMSS);
-			if (!existing_mss || existing_mss > mss)
-				dst_metric_set(dst, RTAX_ADVMSS, mss);
-		}
-	}
-}
-
-static void dn_dst_redirect(struct dst_entry *dst, struct sock *sk,
-			    struct sk_buff *skb)
-{
-}
-
-/*
- * When a route has been marked obsolete. (e.g. routing cache flush)
- */
-static struct dst_entry *dn_dst_check(struct dst_entry *dst, __u32 cookie)
-{
-	return NULL;
-}
-
-static struct dst_entry *dn_dst_negative_advice(struct dst_entry *dst)
-{
-	dst_release(dst);
-	return NULL;
-}
-
-static void dn_dst_link_failure(struct sk_buff *skb)
-{
-}
-
-static inline int compare_keys(struct flowidn *fl1, struct flowidn *fl2)
-{
-	return ((fl1->daddr ^ fl2->daddr) |
-		(fl1->saddr ^ fl2->saddr) |
-		(fl1->flowidn_mark ^ fl2->flowidn_mark) |
-		(fl1->flowidn_scope ^ fl2->flowidn_scope) |
-		(fl1->flowidn_oif ^ fl2->flowidn_oif) |
-		(fl1->flowidn_iif ^ fl2->flowidn_iif)) == 0;
-}
-
-static int dn_insert_route(struct dn_route *rt, unsigned int hash, struct dn_route **rp)
-{
-	struct dn_route *rth;
-	struct dn_route __rcu **rthp;
-	unsigned long now = jiffies;
-
-	rthp = &dn_rt_hash_table[hash].chain;
-
-	spin_lock_bh(&dn_rt_hash_table[hash].lock);
-	while ((rth = rcu_dereference_protected(*rthp,
-						lockdep_is_held(&dn_rt_hash_table[hash].lock))) != NULL) {
-		if (compare_keys(&rth->fld, &rt->fld)) {
-			/* Put it first */
-			*rthp = rth->dn_next;
-			rcu_assign_pointer(rth->dn_next,
-					   dn_rt_hash_table[hash].chain);
-			rcu_assign_pointer(dn_rt_hash_table[hash].chain, rth);
-
-			dst_hold_and_use(&rth->dst, now);
-			spin_unlock_bh(&dn_rt_hash_table[hash].lock);
-
-			dst_release_immediate(&rt->dst);
-			*rp = rth;
-			return 0;
-		}
-		rthp = &rth->dn_next;
-	}
-
-	rcu_assign_pointer(rt->dn_next, dn_rt_hash_table[hash].chain);
-	rcu_assign_pointer(dn_rt_hash_table[hash].chain, rt);
-
-	dst_hold_and_use(&rt->dst, now);
-	spin_unlock_bh(&dn_rt_hash_table[hash].lock);
-	*rp = rt;
-	return 0;
-}
-
-static void dn_run_flush(struct timer_list *unused)
-{
-	int i;
-	struct dn_route *rt, *next;
-
-	for (i = 0; i < dn_rt_hash_mask; i++) {
-		spin_lock_bh(&dn_rt_hash_table[i].lock);
-
-		if ((rt = xchg((struct dn_route **)&dn_rt_hash_table[i].chain, NULL)) == NULL)
-			goto nothing_to_declare;
-
-		for(; rt; rt = next) {
-			next = rcu_dereference_raw(rt->dn_next);
-			RCU_INIT_POINTER(rt->dn_next, NULL);
-			dst_dev_put(&rt->dst);
-			dst_release(&rt->dst);
-		}
-
-nothing_to_declare:
-		spin_unlock_bh(&dn_rt_hash_table[i].lock);
-	}
-}
-
-static DEFINE_SPINLOCK(dn_rt_flush_lock);
-
-void dn_rt_cache_flush(int delay)
-{
-	unsigned long now = jiffies;
-	int user_mode = !in_interrupt();
-
-	if (delay < 0)
-		delay = dn_rt_min_delay;
-
-	spin_lock_bh(&dn_rt_flush_lock);
-
-	if (del_timer(&dn_rt_flush_timer) && delay > 0 && dn_rt_deadline) {
-		long tmo = (long)(dn_rt_deadline - now);
-
-		if (user_mode && tmo < dn_rt_max_delay - dn_rt_min_delay)
-			tmo = 0;
-
-		if (delay > tmo)
-			delay = tmo;
-	}
-
-	if (delay <= 0) {
-		spin_unlock_bh(&dn_rt_flush_lock);
-		dn_run_flush(NULL);
-		return;
-	}
-
-	if (dn_rt_deadline == 0)
-		dn_rt_deadline = now + dn_rt_max_delay;
-
-	dn_rt_flush_timer.expires = now + delay;
-	add_timer(&dn_rt_flush_timer);
-	spin_unlock_bh(&dn_rt_flush_lock);
-}
-
-/**
- * dn_return_short - Return a short packet to its sender
- * @skb: The packet to return
- *
- */
-static int dn_return_short(struct sk_buff *skb)
-{
-	struct dn_skb_cb *cb;
-	unsigned char *ptr;
-	__le16 *src;
-	__le16 *dst;
-
-	/* Add back headers */
-	skb_push(skb, skb->data - skb_network_header(skb));
-
-	if ((skb = skb_unshare(skb, GFP_ATOMIC)) == NULL)
-		return NET_RX_DROP;
-
-	cb = DN_SKB_CB(skb);
-	/* Skip packet length and point to flags */
-	ptr = skb->data + 2;
-	*ptr++ = (cb->rt_flags & ~DN_RT_F_RQR) | DN_RT_F_RTS;
-
-	dst = (__le16 *)ptr;
-	ptr += 2;
-	src = (__le16 *)ptr;
-	ptr += 2;
-	*ptr = 0; /* Zero hop count */
-
-	swap(*src, *dst);
-
-	skb->pkt_type = PACKET_OUTGOING;
-	dn_rt_finish_output(skb, NULL, NULL);
-	return NET_RX_SUCCESS;
-}
-
-/**
- * dn_return_long - Return a long packet to its sender
- * @skb: The long format packet to return
- *
- */
-static int dn_return_long(struct sk_buff *skb)
-{
-	struct dn_skb_cb *cb;
-	unsigned char *ptr;
-	unsigned char *src_addr, *dst_addr;
-	unsigned char tmp[ETH_ALEN];
-
-	/* Add back all headers */
-	skb_push(skb, skb->data - skb_network_header(skb));
-
-	if ((skb = skb_unshare(skb, GFP_ATOMIC)) == NULL)
-		return NET_RX_DROP;
-
-	cb = DN_SKB_CB(skb);
-	/* Ignore packet length and point to flags */
-	ptr = skb->data + 2;
-
-	/* Skip padding */
-	if (*ptr & DN_RT_F_PF) {
-		char padlen = (*ptr & ~DN_RT_F_PF);
-		ptr += padlen;
-	}
-
-	*ptr++ = (cb->rt_flags & ~DN_RT_F_RQR) | DN_RT_F_RTS;
-	ptr += 2;
-	dst_addr = ptr;
-	ptr += 8;
-	src_addr = ptr;
-	ptr += 6;
-	*ptr = 0; /* Zero hop count */
-
-	/* Swap source and destination */
-	memcpy(tmp, src_addr, ETH_ALEN);
-	memcpy(src_addr, dst_addr, ETH_ALEN);
-	memcpy(dst_addr, tmp, ETH_ALEN);
-
-	skb->pkt_type = PACKET_OUTGOING;
-	dn_rt_finish_output(skb, dst_addr, src_addr);
-	return NET_RX_SUCCESS;
-}
-
-/**
- * dn_route_rx_packet - Try and find a route for an incoming packet
- * @net: The applicable net namespace
- * @sk: Socket packet transmitted on
- * @skb: The packet to find a route for
- *
- * Returns: result of input function if route is found, error code otherwise
- */
-static int dn_route_rx_packet(struct net *net, struct sock *sk, struct sk_buff *skb)
-{
-	struct dn_skb_cb *cb;
-	int err;
-
-	if ((err = dn_route_input(skb)) == 0)
-		return dst_input(skb);
-
-	cb = DN_SKB_CB(skb);
-	if (decnet_debug_level & 4) {
-		char *devname = skb->dev ? skb->dev->name : "???";
-
-		printk(KERN_DEBUG
-			"DECnet: dn_route_rx_packet: rt_flags=0x%02x dev=%s len=%d src=0x%04hx dst=0x%04hx err=%d type=%d\n",
-			(int)cb->rt_flags, devname, skb->len,
-			le16_to_cpu(cb->src), le16_to_cpu(cb->dst),
-			err, skb->pkt_type);
-	}
-
-	if ((skb->pkt_type == PACKET_HOST) && (cb->rt_flags & DN_RT_F_RQR)) {
-		switch (cb->rt_flags & DN_RT_PKT_MSK) {
-		case DN_RT_PKT_SHORT:
-			return dn_return_short(skb);
-		case DN_RT_PKT_LONG:
-			return dn_return_long(skb);
-		}
-	}
-
-	kfree_skb(skb);
-	return NET_RX_DROP;
-}
-
-static int dn_route_rx_long(struct sk_buff *skb)
-{
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	unsigned char *ptr = skb->data;
-
-	if (!pskb_may_pull(skb, 21)) /* 20 for long header, 1 for shortest nsp */
-		goto drop_it;
-
-	skb_pull(skb, 20);
-	skb_reset_transport_header(skb);
-
-	/* Destination info */
-	ptr += 2;
-	cb->dst = dn_eth2dn(ptr);
-	if (memcmp(ptr, dn_hiord_addr, 4) != 0)
-		goto drop_it;
-	ptr += 6;
-
-
-	/* Source info */
-	ptr += 2;
-	cb->src = dn_eth2dn(ptr);
-	if (memcmp(ptr, dn_hiord_addr, 4) != 0)
-		goto drop_it;
-	ptr += 6;
-	/* Other junk */
-	ptr++;
-	cb->hops = *ptr++; /* Visit Count */
-
-	return NF_HOOK(NFPROTO_DECNET, NF_DN_PRE_ROUTING,
-		       &init_net, NULL, skb, skb->dev, NULL,
-		       dn_route_rx_packet);
-
-drop_it:
-	kfree_skb(skb);
-	return NET_RX_DROP;
-}
-
-
-
-static int dn_route_rx_short(struct sk_buff *skb)
-{
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	unsigned char *ptr = skb->data;
-
-	if (!pskb_may_pull(skb, 6)) /* 5 for short header + 1 for shortest nsp */
-		goto drop_it;
-
-	skb_pull(skb, 5);
-	skb_reset_transport_header(skb);
-
-	cb->dst = *(__le16 *)ptr;
-	ptr += 2;
-	cb->src = *(__le16 *)ptr;
-	ptr += 2;
-	cb->hops = *ptr & 0x3f;
-
-	return NF_HOOK(NFPROTO_DECNET, NF_DN_PRE_ROUTING,
-		       &init_net, NULL, skb, skb->dev, NULL,
-		       dn_route_rx_packet);
-
-drop_it:
-	kfree_skb(skb);
-	return NET_RX_DROP;
-}
-
-static int dn_route_discard(struct net *net, struct sock *sk, struct sk_buff *skb)
-{
-	/*
-	 * I know we drop the packet here, but thats considered success in
-	 * this case
-	 */
-	kfree_skb(skb);
-	return NET_RX_SUCCESS;
-}
-
-static int dn_route_ptp_hello(struct net *net, struct sock *sk, struct sk_buff *skb)
-{
-	dn_dev_hello(skb);
-	dn_neigh_pointopoint_hello(skb);
-	return NET_RX_SUCCESS;
-}
-
-int dn_route_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt, struct net_device *orig_dev)
-{
-	struct dn_skb_cb *cb;
-	unsigned char flags = 0;
-	__u16 len = le16_to_cpu(*(__le16 *)skb->data);
-	struct dn_dev *dn = rcu_dereference(dev->dn_ptr);
-	unsigned char padlen = 0;
-
-	if (!net_eq(dev_net(dev), &init_net))
-		goto dump_it;
-
-	if (dn == NULL)
-		goto dump_it;
-
-	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL)
-		goto out;
-
-	if (!pskb_may_pull(skb, 3))
-		goto dump_it;
-
-	skb_pull(skb, 2);
-
-	if (len > skb->len)
-		goto dump_it;
-
-	skb_trim(skb, len);
-
-	flags = *skb->data;
-
-	cb = DN_SKB_CB(skb);
-	cb->stamp = jiffies;
-	cb->iif = dev->ifindex;
-
-	/*
-	 * If we have padding, remove it.
-	 */
-	if (flags & DN_RT_F_PF) {
-		padlen = flags & ~DN_RT_F_PF;
-		if (!pskb_may_pull(skb, padlen + 1))
-			goto dump_it;
-		skb_pull(skb, padlen);
-		flags = *skb->data;
-	}
-
-	skb_reset_network_header(skb);
-
-	/*
-	 * Weed out future version DECnet
-	 */
-	if (flags & DN_RT_F_VER)
-		goto dump_it;
-
-	cb->rt_flags = flags;
-
-	if (decnet_debug_level & 1)
-		printk(KERN_DEBUG
-			"dn_route_rcv: got 0x%02x from %s [%d %d %d]\n",
-			(int)flags, dev->name, len, skb->len,
-			padlen);
-
-	if (flags & DN_RT_PKT_CNTL) {
-		if (unlikely(skb_linearize(skb)))
-			goto dump_it;
-
-		switch (flags & DN_RT_CNTL_MSK) {
-		case DN_RT_PKT_INIT:
-			dn_dev_init_pkt(skb);
-			break;
-		case DN_RT_PKT_VERI:
-			dn_dev_veri_pkt(skb);
-			break;
-		}
-
-		if (dn->parms.state != DN_DEV_S_RU)
-			goto dump_it;
-
-		switch (flags & DN_RT_CNTL_MSK) {
-		case DN_RT_PKT_HELO:
-			return NF_HOOK(NFPROTO_DECNET, NF_DN_HELLO,
-				       &init_net, NULL, skb, skb->dev, NULL,
-				       dn_route_ptp_hello);
-
-		case DN_RT_PKT_L1RT:
-		case DN_RT_PKT_L2RT:
-			return NF_HOOK(NFPROTO_DECNET, NF_DN_ROUTE,
-				       &init_net, NULL, skb, skb->dev, NULL,
-				       dn_route_discard);
-		case DN_RT_PKT_ERTH:
-			return NF_HOOK(NFPROTO_DECNET, NF_DN_HELLO,
-				       &init_net, NULL, skb, skb->dev, NULL,
-				       dn_neigh_router_hello);
-
-		case DN_RT_PKT_EEDH:
-			return NF_HOOK(NFPROTO_DECNET, NF_DN_HELLO,
-				       &init_net, NULL, skb, skb->dev, NULL,
-				       dn_neigh_endnode_hello);
-		}
-	} else {
-		if (dn->parms.state != DN_DEV_S_RU)
-			goto dump_it;
-
-		skb_pull(skb, 1); /* Pull flags */
-
-		switch (flags & DN_RT_PKT_MSK) {
-		case DN_RT_PKT_LONG:
-			return dn_route_rx_long(skb);
-		case DN_RT_PKT_SHORT:
-			return dn_route_rx_short(skb);
-		}
-	}
-
-dump_it:
-	kfree_skb(skb);
-out:
-	return NET_RX_DROP;
-}
-
-static int dn_output(struct net *net, struct sock *sk, struct sk_buff *skb)
-{
-	struct dst_entry *dst = skb_dst(skb);
-	struct dn_route *rt = (struct dn_route *)dst;
-	struct net_device *dev = dst->dev;
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-
-	int err = -EINVAL;
-
-	if (rt->n == NULL)
-		goto error;
-
-	skb->dev = dev;
-
-	cb->src = rt->rt_saddr;
-	cb->dst = rt->rt_daddr;
-
-	/*
-	 * Always set the Intra-Ethernet bit on all outgoing packets
-	 * originated on this node. Only valid flag from upper layers
-	 * is return-to-sender-requested. Set hop count to 0 too.
-	 */
-	cb->rt_flags &= ~DN_RT_F_RQR;
-	cb->rt_flags |= DN_RT_F_IE;
-	cb->hops = 0;
-
-	return NF_HOOK(NFPROTO_DECNET, NF_DN_LOCAL_OUT,
-		       &init_net, sk, skb, NULL, dev,
-		       dn_to_neigh_output);
-
-error:
-	net_dbg_ratelimited("dn_output: This should not happen\n");
-
-	kfree_skb(skb);
-
-	return err;
-}
-
-static int dn_forward(struct sk_buff *skb)
-{
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	struct dst_entry *dst = skb_dst(skb);
-	struct dn_dev *dn_db = rcu_dereference(dst->dev->dn_ptr);
-	struct dn_route *rt;
-	int header_len;
-	struct net_device *dev = skb->dev;
-
-	if (skb->pkt_type != PACKET_HOST)
-		goto drop;
-
-	/* Ensure that we have enough space for headers */
-	rt = (struct dn_route *)skb_dst(skb);
-	header_len = dn_db->use_long ? 21 : 6;
-	if (skb_cow(skb, LL_RESERVED_SPACE(rt->dst.dev)+header_len))
-		goto drop;
-
-	/*
-	 * Hop count exceeded.
-	 */
-	if (++cb->hops > 30)
-		goto drop;
-
-	skb->dev = rt->dst.dev;
-
-	/*
-	 * If packet goes out same interface it came in on, then set
-	 * the Intra-Ethernet bit. This has no effect for short
-	 * packets, so we don't need to test for them here.
-	 */
-	cb->rt_flags &= ~DN_RT_F_IE;
-	if (rt->rt_flags & RTCF_DOREDIRECT)
-		cb->rt_flags |= DN_RT_F_IE;
-
-	return NF_HOOK(NFPROTO_DECNET, NF_DN_FORWARD,
-		       &init_net, NULL, skb, dev, skb->dev,
-		       dn_to_neigh_output);
-
-drop:
-	kfree_skb(skb);
-	return NET_RX_DROP;
-}
-
-/*
- * Used to catch bugs. This should never normally get
- * called.
- */
-static int dn_rt_bug_out(struct net *net, struct sock *sk, struct sk_buff *skb)
-{
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-
-	net_dbg_ratelimited("dn_rt_bug: skb from:%04x to:%04x\n",
-			    le16_to_cpu(cb->src), le16_to_cpu(cb->dst));
-
-	kfree_skb(skb);
-
-	return NET_RX_DROP;
-}
-
-static int dn_rt_bug(struct sk_buff *skb)
-{
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-
-	net_dbg_ratelimited("dn_rt_bug: skb from:%04x to:%04x\n",
-			    le16_to_cpu(cb->src), le16_to_cpu(cb->dst));
-
-	kfree_skb(skb);
-
-	return NET_RX_DROP;
-}
-
-static unsigned int dn_dst_default_advmss(const struct dst_entry *dst)
-{
-	return dn_mss_from_pmtu(dst->dev, dst_mtu(dst));
-}
-
-static unsigned int dn_dst_mtu(const struct dst_entry *dst)
-{
-	unsigned int mtu = dst_metric_raw(dst, RTAX_MTU);
-
-	return mtu ? : dst->dev->mtu;
-}
-
-static struct neighbour *dn_dst_neigh_lookup(const struct dst_entry *dst,
-					     struct sk_buff *skb,
-					     const void *daddr)
-{
-	return __neigh_lookup_errno(&dn_neigh_table, daddr, dst->dev);
-}
-
-static int dn_rt_set_next_hop(struct dn_route *rt, struct dn_fib_res *res)
-{
-	struct dn_fib_info *fi = res->fi;
-	struct net_device *dev = rt->dst.dev;
-	unsigned int mss_metric;
-	struct neighbour *n;
-
-	if (fi) {
-		if (DN_FIB_RES_GW(*res) &&
-		    DN_FIB_RES_NH(*res).nh_scope == RT_SCOPE_LINK)
-			rt->rt_gateway = DN_FIB_RES_GW(*res);
-		dst_init_metrics(&rt->dst, fi->fib_metrics, true);
-	}
-	rt->rt_type = res->type;
-
-	if (dev != NULL && rt->n == NULL) {
-		n = __neigh_lookup_errno(&dn_neigh_table, &rt->rt_gateway, dev);
-		if (IS_ERR(n))
-			return PTR_ERR(n);
-		rt->n = n;
-	}
-
-	if (dst_metric(&rt->dst, RTAX_MTU) > rt->dst.dev->mtu)
-		dst_metric_set(&rt->dst, RTAX_MTU, rt->dst.dev->mtu);
-	mss_metric = dst_metric_raw(&rt->dst, RTAX_ADVMSS);
-	if (mss_metric) {
-		unsigned int mss = dn_mss_from_pmtu(dev, dst_mtu(&rt->dst));
-		if (mss_metric > mss)
-			dst_metric_set(&rt->dst, RTAX_ADVMSS, mss);
-	}
-	return 0;
-}
-
-static inline int dn_match_addr(__le16 addr1, __le16 addr2)
-{
-	__u16 tmp = le16_to_cpu(addr1) ^ le16_to_cpu(addr2);
-	int match = 16;
-	while(tmp) {
-		tmp >>= 1;
-		match--;
-	}
-	return match;
-}
-
-static __le16 dnet_select_source(const struct net_device *dev, __le16 daddr, int scope)
-{
-	__le16 saddr = 0;
-	struct dn_dev *dn_db;
-	struct dn_ifaddr *ifa;
-	int best_match = 0;
-	int ret;
-
-	rcu_read_lock();
-	dn_db = rcu_dereference(dev->dn_ptr);
-	for (ifa = rcu_dereference(dn_db->ifa_list);
-	     ifa != NULL;
-	     ifa = rcu_dereference(ifa->ifa_next)) {
-		if (ifa->ifa_scope > scope)
-			continue;
-		if (!daddr) {
-			saddr = ifa->ifa_local;
-			break;
-		}
-		ret = dn_match_addr(daddr, ifa->ifa_local);
-		if (ret > best_match)
-			saddr = ifa->ifa_local;
-		if (best_match == 0)
-			saddr = ifa->ifa_local;
-	}
-	rcu_read_unlock();
-
-	return saddr;
-}
-
-static inline __le16 __dn_fib_res_prefsrc(struct dn_fib_res *res)
-{
-	return dnet_select_source(DN_FIB_RES_DEV(*res), DN_FIB_RES_GW(*res), res->scope);
-}
-
-static inline __le16 dn_fib_rules_map_destination(__le16 daddr, struct dn_fib_res *res)
-{
-	__le16 mask = dnet_make_mask(res->prefixlen);
-	return (daddr&~mask)|res->fi->fib_nh->nh_gw;
-}
-
-static int dn_route_output_slow(struct dst_entry **pprt, const struct flowidn *oldflp, int try_hard)
-{
-	struct flowidn fld = {
-		.daddr = oldflp->daddr,
-		.saddr = oldflp->saddr,
-		.flowidn_scope = RT_SCOPE_UNIVERSE,
-		.flowidn_mark = oldflp->flowidn_mark,
-		.flowidn_iif = LOOPBACK_IFINDEX,
-		.flowidn_oif = oldflp->flowidn_oif,
-	};
-	struct dn_route *rt = NULL;
-	struct net_device *dev_out = NULL, *dev;
-	struct neighbour *neigh = NULL;
-	unsigned int hash;
-	unsigned int flags = 0;
-	struct dn_fib_res res = { .fi = NULL, .type = RTN_UNICAST };
-	int err;
-	int free_res = 0;
-	__le16 gateway = 0;
-
-	if (decnet_debug_level & 16)
-		printk(KERN_DEBUG
-		       "dn_route_output_slow: dst=%04x src=%04x mark=%d"
-		       " iif=%d oif=%d\n", le16_to_cpu(oldflp->daddr),
-		       le16_to_cpu(oldflp->saddr),
-		       oldflp->flowidn_mark, LOOPBACK_IFINDEX,
-		       oldflp->flowidn_oif);
-
-	/* If we have an output interface, verify its a DECnet device */
-	if (oldflp->flowidn_oif) {
-		dev_out = dev_get_by_index(&init_net, oldflp->flowidn_oif);
-		err = -ENODEV;
-		if (dev_out && dev_out->dn_ptr == NULL) {
-			dev_put(dev_out);
-			dev_out = NULL;
-		}
-		if (dev_out == NULL)
-			goto out;
-	}
-
-	/* If we have a source address, verify that its a local address */
-	if (oldflp->saddr) {
-		err = -EADDRNOTAVAIL;
-
-		if (dev_out) {
-			if (dn_dev_islocal(dev_out, oldflp->saddr))
-				goto source_ok;
-			dev_put(dev_out);
-			goto out;
-		}
-		rcu_read_lock();
-		for_each_netdev_rcu(&init_net, dev) {
-			if (!dev->dn_ptr)
-				continue;
-			if (!dn_dev_islocal(dev, oldflp->saddr))
-				continue;
-			if ((dev->flags & IFF_LOOPBACK) &&
-			    oldflp->daddr &&
-			    !dn_dev_islocal(dev, oldflp->daddr))
-				continue;
-
-			dev_out = dev;
-			break;
-		}
-		rcu_read_unlock();
-		if (dev_out == NULL)
-			goto out;
-		dev_hold(dev_out);
-source_ok:
-		;
-	}
-
-	/* No destination? Assume its local */
-	if (!fld.daddr) {
-		fld.daddr = fld.saddr;
-
-		if (dev_out)
-			dev_put(dev_out);
-		err = -EINVAL;
-		dev_out = init_net.loopback_dev;
-		if (!dev_out->dn_ptr)
-			goto out;
-		err = -EADDRNOTAVAIL;
-		dev_hold(dev_out);
-		if (!fld.daddr) {
-			fld.daddr =
-			fld.saddr = dnet_select_source(dev_out, 0,
-						       RT_SCOPE_HOST);
-			if (!fld.daddr)
-				goto out;
-		}
-		fld.flowidn_oif = LOOPBACK_IFINDEX;
-		res.type = RTN_LOCAL;
-		goto make_route;
-	}
-
-	if (decnet_debug_level & 16)
-		printk(KERN_DEBUG
-		       "dn_route_output_slow: initial checks complete."
-		       " dst=%04x src=%04x oif=%d try_hard=%d\n",
-		       le16_to_cpu(fld.daddr), le16_to_cpu(fld.saddr),
-		       fld.flowidn_oif, try_hard);
-
-	/*
-	 * N.B. If the kernel is compiled without router support then
-	 * dn_fib_lookup() will evaluate to non-zero so this if () block
-	 * will always be executed.
-	 */
-	err = -ESRCH;
-	if (try_hard || (err = dn_fib_lookup(&fld, &res)) != 0) {
-		struct dn_dev *dn_db;
-		if (err != -ESRCH)
-			goto out;
-		/*
-		 * Here the fallback is basically the standard algorithm for
-		 * routing in endnodes which is described in the DECnet routing
-		 * docs
-		 *
-		 * If we are not trying hard, look in neighbour cache.
-		 * The result is tested to ensure that if a specific output
-		 * device/source address was requested, then we honour that
-		 * here
-		 */
-		if (!try_hard) {
-			neigh = neigh_lookup_nodev(&dn_neigh_table, &init_net, &fld.daddr);
-			if (neigh) {
-				if ((oldflp->flowidn_oif &&
-				    (neigh->dev->ifindex != oldflp->flowidn_oif)) ||
-				    (oldflp->saddr &&
-				    (!dn_dev_islocal(neigh->dev,
-						     oldflp->saddr)))) {
-					neigh_release(neigh);
-					neigh = NULL;
-				} else {
-					if (dev_out)
-						dev_put(dev_out);
-					if (dn_dev_islocal(neigh->dev, fld.daddr)) {
-						dev_out = init_net.loopback_dev;
-						res.type = RTN_LOCAL;
-					} else {
-						dev_out = neigh->dev;
-					}
-					dev_hold(dev_out);
-					goto select_source;
-				}
-			}
-		}
-
-		/* Not there? Perhaps its a local address */
-		if (dev_out == NULL)
-			dev_out = dn_dev_get_default();
-		err = -ENODEV;
-		if (dev_out == NULL)
-			goto out;
-		dn_db = rcu_dereference_raw(dev_out->dn_ptr);
-		if (!dn_db)
-			goto e_inval;
-		/* Possible improvement - check all devices for local addr */
-		if (dn_dev_islocal(dev_out, fld.daddr)) {
-			dev_put(dev_out);
-			dev_out = init_net.loopback_dev;
-			dev_hold(dev_out);
-			res.type = RTN_LOCAL;
-			goto select_source;
-		}
-		/* Not local either.... try sending it to the default router */
-		neigh = neigh_clone(dn_db->router);
-		BUG_ON(neigh && neigh->dev != dev_out);
-
-		/* Ok then, we assume its directly connected and move on */
-select_source:
-		if (neigh)
-			gateway = ((struct dn_neigh *)neigh)->addr;
-		if (gateway == 0)
-			gateway = fld.daddr;
-		if (fld.saddr == 0) {
-			fld.saddr = dnet_select_source(dev_out, gateway,
-						       res.type == RTN_LOCAL ?
-						       RT_SCOPE_HOST :
-						       RT_SCOPE_LINK);
-			if (fld.saddr == 0 && res.type != RTN_LOCAL)
-				goto e_addr;
-		}
-		fld.flowidn_oif = dev_out->ifindex;
-		goto make_route;
-	}
-	free_res = 1;
-
-	if (res.type == RTN_NAT)
-		goto e_inval;
-
-	if (res.type == RTN_LOCAL) {
-		if (!fld.saddr)
-			fld.saddr = fld.daddr;
-		if (dev_out)
-			dev_put(dev_out);
-		dev_out = init_net.loopback_dev;
-		dev_hold(dev_out);
-		if (!dev_out->dn_ptr)
-			goto e_inval;
-		fld.flowidn_oif = dev_out->ifindex;
-		if (res.fi)
-			dn_fib_info_put(res.fi);
-		res.fi = NULL;
-		goto make_route;
-	}
-
-	if (res.fi->fib_nhs > 1 && fld.flowidn_oif == 0)
-		dn_fib_select_multipath(&fld, &res);
-
-	/*
-	 * We could add some logic to deal with default routes here and
-	 * get rid of some of the special casing above.
-	 */
-
-	if (!fld.saddr)
-		fld.saddr = DN_FIB_RES_PREFSRC(res);
-
-	if (dev_out)
-		dev_put(dev_out);
-	dev_out = DN_FIB_RES_DEV(res);
-	dev_hold(dev_out);
-	fld.flowidn_oif = dev_out->ifindex;
-	gateway = DN_FIB_RES_GW(res);
-
-make_route:
-	if (dev_out->flags & IFF_LOOPBACK)
-		flags |= RTCF_LOCAL;
-
-	rt = dst_alloc(&dn_dst_ops, dev_out, 0, DST_OBSOLETE_NONE, 0);
-	if (rt == NULL)
-		goto e_nobufs;
-
-	rt->dn_next = NULL;
-	memset(&rt->fld, 0, sizeof(rt->fld));
-	rt->fld.saddr        = oldflp->saddr;
-	rt->fld.daddr        = oldflp->daddr;
-	rt->fld.flowidn_oif  = oldflp->flowidn_oif;
-	rt->fld.flowidn_iif  = 0;
-	rt->fld.flowidn_mark = oldflp->flowidn_mark;
-
-	rt->rt_saddr      = fld.saddr;
-	rt->rt_daddr      = fld.daddr;
-	rt->rt_gateway    = gateway ? gateway : fld.daddr;
-	rt->rt_local_src  = fld.saddr;
-
-	rt->rt_dst_map    = fld.daddr;
-	rt->rt_src_map    = fld.saddr;
-
-	rt->n = neigh;
-	neigh = NULL;
-
-	rt->dst.lastuse = jiffies;
-	rt->dst.output  = dn_output;
-	rt->dst.input   = dn_rt_bug;
-	rt->rt_flags      = flags;
-	if (flags & RTCF_LOCAL)
-		rt->dst.input = dn_nsp_rx;
-
-	err = dn_rt_set_next_hop(rt, &res);
-	if (err)
-		goto e_neighbour;
-
-	hash = dn_hash(rt->fld.saddr, rt->fld.daddr);
-	/* dn_insert_route() increments dst->__refcnt */
-	dn_insert_route(rt, hash, (struct dn_route **)pprt);
-
-done:
-	if (neigh)
-		neigh_release(neigh);
-	if (free_res)
-		dn_fib_res_put(&res);
-	if (dev_out)
-		dev_put(dev_out);
-out:
-	return err;
-
-e_addr:
-	err = -EADDRNOTAVAIL;
-	goto done;
-e_inval:
-	err = -EINVAL;
-	goto done;
-e_nobufs:
-	err = -ENOBUFS;
-	goto done;
-e_neighbour:
-	dst_release_immediate(&rt->dst);
-	goto e_nobufs;
-}
-
-
-/*
- * N.B. The flags may be moved into the flowi at some future stage.
- */
-static int __dn_route_output_key(struct dst_entry **pprt, const struct flowidn *flp, int flags)
-{
-	unsigned int hash = dn_hash(flp->saddr, flp->daddr);
-	struct dn_route *rt = NULL;
-
-	if (!(flags & MSG_TRYHARD)) {
-		rcu_read_lock_bh();
-		for (rt = rcu_dereference_bh(dn_rt_hash_table[hash].chain); rt;
-			rt = rcu_dereference_bh(rt->dn_next)) {
-			if ((flp->daddr == rt->fld.daddr) &&
-			    (flp->saddr == rt->fld.saddr) &&
-			    (flp->flowidn_mark == rt->fld.flowidn_mark) &&
-			    dn_is_output_route(rt) &&
-			    (rt->fld.flowidn_oif == flp->flowidn_oif)) {
-				dst_hold_and_use(&rt->dst, jiffies);
-				rcu_read_unlock_bh();
-				*pprt = &rt->dst;
-				return 0;
-			}
-		}
-		rcu_read_unlock_bh();
-	}
-
-	return dn_route_output_slow(pprt, flp, flags);
-}
-
-static int dn_route_output_key(struct dst_entry **pprt, struct flowidn *flp, int flags)
-{
-	int err;
-
-	err = __dn_route_output_key(pprt, flp, flags);
-	if (err == 0 && flp->flowidn_proto) {
-		*pprt = xfrm_lookup(&init_net, *pprt,
-				    flowidn_to_flowi(flp), NULL, 0);
-		if (IS_ERR(*pprt)) {
-			err = PTR_ERR(*pprt);
-			*pprt = NULL;
-		}
-	}
-	return err;
-}
-
-int dn_route_output_sock(struct dst_entry __rcu **pprt, struct flowidn *fl, struct sock *sk, int flags)
-{
-	int err;
-
-	err = __dn_route_output_key(pprt, fl, flags & MSG_TRYHARD);
-	if (err == 0 && fl->flowidn_proto) {
-		*pprt = xfrm_lookup(&init_net, *pprt,
-				    flowidn_to_flowi(fl), sk, 0);
-		if (IS_ERR(*pprt)) {
-			err = PTR_ERR(*pprt);
-			*pprt = NULL;
-		}
-	}
-	return err;
-}
-
-static int dn_route_input_slow(struct sk_buff *skb)
-{
-	struct dn_route *rt = NULL;
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	struct net_device *in_dev = skb->dev;
-	struct net_device *out_dev = NULL;
-	struct dn_dev *dn_db;
-	struct neighbour *neigh = NULL;
-	unsigned int hash;
-	int flags = 0;
-	__le16 gateway = 0;
-	__le16 local_src = 0;
-	struct flowidn fld = {
-		.daddr = cb->dst,
-		.saddr = cb->src,
-		.flowidn_scope = RT_SCOPE_UNIVERSE,
-		.flowidn_mark = skb->mark,
-		.flowidn_iif = skb->dev->ifindex,
-	};
-	struct dn_fib_res res = { .fi = NULL, .type = RTN_UNREACHABLE };
-	int err = -EINVAL;
-	int free_res = 0;
-
-	dev_hold(in_dev);
-
-	if ((dn_db = rcu_dereference(in_dev->dn_ptr)) == NULL)
-		goto out;
-
-	/* Zero source addresses are not allowed */
-	if (fld.saddr == 0)
-		goto out;
-
-	/*
-	 * In this case we've just received a packet from a source
-	 * outside ourselves pretending to come from us. We don't
-	 * allow it any further to prevent routing loops, spoofing and
-	 * other nasties. Loopback packets already have the dst attached
-	 * so this only affects packets which have originated elsewhere.
-	 */
-	err  = -ENOTUNIQ;
-	if (dn_dev_islocal(in_dev, cb->src))
-		goto out;
-
-	err = dn_fib_lookup(&fld, &res);
-	if (err) {
-		if (err != -ESRCH)
-			goto out;
-		/*
-		 * Is the destination us ?
-		 */
-		if (!dn_dev_islocal(in_dev, cb->dst))
-			goto e_inval;
-
-		res.type = RTN_LOCAL;
-	} else {
-		__le16 src_map = fld.saddr;
-		free_res = 1;
-
-		out_dev = DN_FIB_RES_DEV(res);
-		if (out_dev == NULL) {
-			net_crit_ratelimited("Bug in dn_route_input_slow() No output device\n");
-			goto e_inval;
-		}
-		dev_hold(out_dev);
-
-		if (res.r)
-			src_map = fld.saddr; /* no NAT support for now */
-
-		gateway = DN_FIB_RES_GW(res);
-		if (res.type == RTN_NAT) {
-			fld.daddr = dn_fib_rules_map_destination(fld.daddr, &res);
-			dn_fib_res_put(&res);
-			free_res = 0;
-			if (dn_fib_lookup(&fld, &res))
-				goto e_inval;
-			free_res = 1;
-			if (res.type != RTN_UNICAST)
-				goto e_inval;
-			flags |= RTCF_DNAT;
-			gateway = fld.daddr;
-		}
-		fld.saddr = src_map;
-	}
-
-	switch(res.type) {
-	case RTN_UNICAST:
-		/*
-		 * Forwarding check here, we only check for forwarding
-		 * being turned off, if you want to only forward intra
-		 * area, its up to you to set the routing tables up
-		 * correctly.
-		 */
-		if (dn_db->parms.forwarding == 0)
-			goto e_inval;
-
-		if (res.fi->fib_nhs > 1 && fld.flowidn_oif == 0)
-			dn_fib_select_multipath(&fld, &res);
-
-		/*
-		 * Check for out_dev == in_dev. We use the RTCF_DOREDIRECT
-		 * flag as a hint to set the intra-ethernet bit when
-		 * forwarding. If we've got NAT in operation, we don't do
-		 * this optimisation.
-		 */
-		if (out_dev == in_dev && !(flags & RTCF_NAT))
-			flags |= RTCF_DOREDIRECT;
-
-		local_src = DN_FIB_RES_PREFSRC(res);
-
-	case RTN_BLACKHOLE:
-	case RTN_UNREACHABLE:
-		break;
-	case RTN_LOCAL:
-		flags |= RTCF_LOCAL;
-		fld.saddr = cb->dst;
-		fld.daddr = cb->src;
-
-		/* Routing tables gave us a gateway */
-		if (gateway)
-			goto make_route;
-
-		/* Packet was intra-ethernet, so we know its on-link */
-		if (cb->rt_flags & DN_RT_F_IE) {
-			gateway = cb->src;
-			goto make_route;
-		}
-
-		/* Use the default router if there is one */
-		neigh = neigh_clone(dn_db->router);
-		if (neigh) {
-			gateway = ((struct dn_neigh *)neigh)->addr;
-			goto make_route;
-		}
-
-		/* Close eyes and pray */
-		gateway = cb->src;
-		goto make_route;
-	default:
-		goto e_inval;
-	}
-
-make_route:
-	rt = dst_alloc(&dn_dst_ops, out_dev, 1, DST_OBSOLETE_NONE, 0);
-	if (rt == NULL)
-		goto e_nobufs;
-
-	rt->dn_next = NULL;
-	memset(&rt->fld, 0, sizeof(rt->fld));
-	rt->rt_saddr      = fld.saddr;
-	rt->rt_daddr      = fld.daddr;
-	rt->rt_gateway    = fld.daddr;
-	if (gateway)
-		rt->rt_gateway = gateway;
-	rt->rt_local_src  = local_src ? local_src : rt->rt_saddr;
-
-	rt->rt_dst_map    = fld.daddr;
-	rt->rt_src_map    = fld.saddr;
-
-	rt->fld.saddr        = cb->src;
-	rt->fld.daddr        = cb->dst;
-	rt->fld.flowidn_oif  = 0;
-	rt->fld.flowidn_iif  = in_dev->ifindex;
-	rt->fld.flowidn_mark = fld.flowidn_mark;
-
-	rt->n = neigh;
-	rt->dst.lastuse = jiffies;
-	rt->dst.output = dn_rt_bug_out;
-	switch (res.type) {
-	case RTN_UNICAST:
-		rt->dst.input = dn_forward;
-		break;
-	case RTN_LOCAL:
-		rt->dst.output = dn_output;
-		rt->dst.input = dn_nsp_rx;
-		rt->dst.dev = in_dev;
-		flags |= RTCF_LOCAL;
-		break;
-	default:
-	case RTN_UNREACHABLE:
-	case RTN_BLACKHOLE:
-		rt->dst.input = dst_discard;
-	}
-	rt->rt_flags = flags;
-
-	err = dn_rt_set_next_hop(rt, &res);
-	if (err)
-		goto e_neighbour;
-
-	hash = dn_hash(rt->fld.saddr, rt->fld.daddr);
-	/* dn_insert_route() increments dst->__refcnt */
-	dn_insert_route(rt, hash, &rt);
-	skb_dst_set(skb, &rt->dst);
-
-done:
-	if (neigh)
-		neigh_release(neigh);
-	if (free_res)
-		dn_fib_res_put(&res);
-	dev_put(in_dev);
-	if (out_dev)
-		dev_put(out_dev);
-out:
-	return err;
-
-e_inval:
-	err = -EINVAL;
-	goto done;
-
-e_nobufs:
-	err = -ENOBUFS;
-	goto done;
-
-e_neighbour:
-	dst_release_immediate(&rt->dst);
-	goto done;
-}
-
-static int dn_route_input(struct sk_buff *skb)
-{
-	struct dn_route *rt;
-	struct dn_skb_cb *cb = DN_SKB_CB(skb);
-	unsigned int hash = dn_hash(cb->src, cb->dst);
-
-	if (skb_dst(skb))
-		return 0;
-
-	rcu_read_lock();
-	for(rt = rcu_dereference(dn_rt_hash_table[hash].chain); rt != NULL;
-	    rt = rcu_dereference(rt->dn_next)) {
-		if ((rt->fld.saddr == cb->src) &&
-		    (rt->fld.daddr == cb->dst) &&
-		    (rt->fld.flowidn_oif == 0) &&
-		    (rt->fld.flowidn_mark == skb->mark) &&
-		    (rt->fld.flowidn_iif == cb->iif)) {
-			dst_hold_and_use(&rt->dst, jiffies);
-			rcu_read_unlock();
-			skb_dst_set(skb, (struct dst_entry *)rt);
-			return 0;
-		}
-	}
-	rcu_read_unlock();
-
-	return dn_route_input_slow(skb);
-}
-
-static int dn_rt_fill_info(struct sk_buff *skb, u32 portid, u32 seq,
-			   int event, int nowait, unsigned int flags)
-{
-	struct dn_route *rt = (struct dn_route *)skb_dst(skb);
-	struct rtmsg *r;
-	struct nlmsghdr *nlh;
-	long expires;
-
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*r), flags);
-	if (!nlh)
-		return -EMSGSIZE;
-
-	r = nlmsg_data(nlh);
-	r->rtm_family = AF_DECnet;
-	r->rtm_dst_len = 16;
-	r->rtm_src_len = 0;
-	r->rtm_tos = 0;
-	r->rtm_table = RT_TABLE_MAIN;
-	r->rtm_type = rt->rt_type;
-	r->rtm_flags = (rt->rt_flags & ~0xFFFF) | RTM_F_CLONED;
-	r->rtm_scope = RT_SCOPE_UNIVERSE;
-	r->rtm_protocol = RTPROT_UNSPEC;
-
-	if (rt->rt_flags & RTCF_NOTIFY)
-		r->rtm_flags |= RTM_F_NOTIFY;
-
-	if (nla_put_u32(skb, RTA_TABLE, RT_TABLE_MAIN) < 0 ||
-	    nla_put_le16(skb, RTA_DST, rt->rt_daddr) < 0)
-		goto errout;
-
-	if (rt->fld.saddr) {
-		r->rtm_src_len = 16;
-		if (nla_put_le16(skb, RTA_SRC, rt->fld.saddr) < 0)
-			goto errout;
-	}
-	if (rt->dst.dev &&
-	    nla_put_u32(skb, RTA_OIF, rt->dst.dev->ifindex) < 0)
-		goto errout;
-
-	/*
-	 * Note to self - change this if input routes reverse direction when
-	 * they deal only with inputs and not with replies like they do
-	 * currently.
-	 */
-	if (nla_put_le16(skb, RTA_PREFSRC, rt->rt_local_src) < 0)
-		goto errout;
-
-	if (rt->rt_daddr != rt->rt_gateway &&
-	    nla_put_le16(skb, RTA_GATEWAY, rt->rt_gateway) < 0)
-		goto errout;
-
-	if (rtnetlink_put_metrics(skb, dst_metrics_ptr(&rt->dst)) < 0)
-		goto errout;
-
-	expires = rt->dst.expires ? rt->dst.expires - jiffies : 0;
-	if (rtnl_put_cacheinfo(skb, &rt->dst, 0, expires,
-			       rt->dst.error) < 0)
-		goto errout;
-
-	if (dn_is_input_route(rt) &&
-	    nla_put_u32(skb, RTA_IIF, rt->fld.flowidn_iif) < 0)
-		goto errout;
-
-	nlmsg_end(skb, nlh);
-	return 0;
-
-errout:
-	nlmsg_cancel(skb, nlh);
-	return -EMSGSIZE;
-}
-
-const struct nla_policy rtm_dn_policy[RTA_MAX + 1] = {
-	[RTA_DST]		= { .type = NLA_U16 },
-	[RTA_SRC]		= { .type = NLA_U16 },
-	[RTA_IIF]		= { .type = NLA_U32 },
-	[RTA_OIF]		= { .type = NLA_U32 },
-	[RTA_GATEWAY]		= { .type = NLA_U16 },
-	[RTA_PRIORITY]		= { .type = NLA_U32 },
-	[RTA_PREFSRC]		= { .type = NLA_U16 },
-	[RTA_METRICS]		= { .type = NLA_NESTED },
-	[RTA_MULTIPATH]		= { .type = NLA_NESTED },
-	[RTA_TABLE]		= { .type = NLA_U32 },
-	[RTA_MARK]		= { .type = NLA_U32 },
-};
-
-/*
- * This is called by both endnodes and routers now.
- */
-static int dn_cache_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
-			     struct netlink_ext_ack *extack)
-{
-	struct net *net = sock_net(in_skb->sk);
-	struct rtmsg *rtm = nlmsg_data(nlh);
-	struct dn_route *rt = NULL;
-	struct dn_skb_cb *cb;
-	int err;
-	struct sk_buff *skb;
-	struct flowidn fld;
-	struct nlattr *tb[RTA_MAX+1];
-
-	if (!net_eq(net, &init_net))
-		return -EINVAL;
-
-	err = nlmsg_parse_deprecated(nlh, sizeof(*rtm), tb, RTA_MAX,
-				     rtm_dn_policy, extack);
-	if (err < 0)
-		return err;
-
-	memset(&fld, 0, sizeof(fld));
-	fld.flowidn_proto = DNPROTO_NSP;
-
-	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (skb == NULL)
-		return -ENOBUFS;
-	skb_reset_mac_header(skb);
-	cb = DN_SKB_CB(skb);
-
-	if (tb[RTA_SRC])
-		fld.saddr = nla_get_le16(tb[RTA_SRC]);
-
-	if (tb[RTA_DST])
-		fld.daddr = nla_get_le16(tb[RTA_DST]);
-
-	if (tb[RTA_IIF])
-		fld.flowidn_iif = nla_get_u32(tb[RTA_IIF]);
-
-	if (fld.flowidn_iif) {
-		struct net_device *dev;
-		dev = __dev_get_by_index(&init_net, fld.flowidn_iif);
-		if (!dev || !dev->dn_ptr) {
-			kfree_skb(skb);
-			return -ENODEV;
-		}
-		skb->protocol = htons(ETH_P_DNA_RT);
-		skb->dev = dev;
-		cb->src = fld.saddr;
-		cb->dst = fld.daddr;
-		local_bh_disable();
-		err = dn_route_input(skb);
-		local_bh_enable();
-		memset(cb, 0, sizeof(struct dn_skb_cb));
-		rt = (struct dn_route *)skb_dst(skb);
-		if (!err && -rt->dst.error)
-			err = rt->dst.error;
-	} else {
-		if (tb[RTA_OIF])
-			fld.flowidn_oif = nla_get_u32(tb[RTA_OIF]);
-
-		err = dn_route_output_key((struct dst_entry **)&rt, &fld, 0);
-	}
-
-	skb->dev = NULL;
-	if (err)
-		goto out_free;
-	skb_dst_set(skb, &rt->dst);
-	if (rtm->rtm_flags & RTM_F_NOTIFY)
-		rt->rt_flags |= RTCF_NOTIFY;
-
-	err = dn_rt_fill_info(skb, NETLINK_CB(in_skb).portid, nlh->nlmsg_seq, RTM_NEWROUTE, 0, 0);
-	if (err < 0) {
-		err = -EMSGSIZE;
-		goto out_free;
-	}
-
-	return rtnl_unicast(skb, &init_net, NETLINK_CB(in_skb).portid);
-
-out_free:
-	kfree_skb(skb);
-	return err;
-}
-
-/*
- * For routers, this is called from dn_fib_dump, but for endnodes its
- * called directly from the rtnetlink dispatch table.
- */
-int dn_cache_dump(struct sk_buff *skb, struct netlink_callback *cb)
-{
-	struct net *net = sock_net(skb->sk);
-	struct dn_route *rt;
-	int h, s_h;
-	int idx, s_idx;
-	struct rtmsg *rtm;
-
-	if (!net_eq(net, &init_net))
-		return 0;
-
-	if (nlmsg_len(cb->nlh) < sizeof(struct rtmsg))
-		return -EINVAL;
-
-	rtm = nlmsg_data(cb->nlh);
-	if (!(rtm->rtm_flags & RTM_F_CLONED))
-		return 0;
-
-	s_h = cb->args[0];
-	s_idx = idx = cb->args[1];
-	for(h = 0; h <= dn_rt_hash_mask; h++) {
-		if (h < s_h)
-			continue;
-		if (h > s_h)
-			s_idx = 0;
-		rcu_read_lock_bh();
-		for(rt = rcu_dereference_bh(dn_rt_hash_table[h].chain), idx = 0;
-			rt;
-			rt = rcu_dereference_bh(rt->dn_next), idx++) {
-			if (idx < s_idx)
-				continue;
-			skb_dst_set(skb, dst_clone(&rt->dst));
-			if (dn_rt_fill_info(skb, NETLINK_CB(cb->skb).portid,
-					cb->nlh->nlmsg_seq, RTM_NEWROUTE,
-					1, NLM_F_MULTI) < 0) {
-				skb_dst_drop(skb);
-				rcu_read_unlock_bh();
-				goto done;
-			}
-			skb_dst_drop(skb);
-		}
-		rcu_read_unlock_bh();
-	}
-
-done:
-	cb->args[0] = h;
-	cb->args[1] = idx;
-	return skb->len;
-}
-
-#ifdef CONFIG_PROC_FS
-struct dn_rt_cache_iter_state {
-	int bucket;
-};
-
-static struct dn_route *dn_rt_cache_get_first(struct seq_file *seq)
-{
-	struct dn_route *rt = NULL;
-	struct dn_rt_cache_iter_state *s = seq->private;
-
-	for(s->bucket = dn_rt_hash_mask; s->bucket >= 0; --s->bucket) {
-		rcu_read_lock_bh();
-		rt = rcu_dereference_bh(dn_rt_hash_table[s->bucket].chain);
-		if (rt)
-			break;
-		rcu_read_unlock_bh();
-	}
-	return rt;
-}
-
-static struct dn_route *dn_rt_cache_get_next(struct seq_file *seq, struct dn_route *rt)
-{
-	struct dn_rt_cache_iter_state *s = seq->private;
-
-	rt = rcu_dereference_bh(rt->dn_next);
-	while (!rt) {
-		rcu_read_unlock_bh();
-		if (--s->bucket < 0)
-			break;
-		rcu_read_lock_bh();
-		rt = rcu_dereference_bh(dn_rt_hash_table[s->bucket].chain);
-	}
-	return rt;
-}
-
-static void *dn_rt_cache_seq_start(struct seq_file *seq, loff_t *pos)
-{
-	struct dn_route *rt = dn_rt_cache_get_first(seq);
-
-	if (rt) {
-		while(*pos && (rt = dn_rt_cache_get_next(seq, rt)))
-			--*pos;
-	}
-	return *pos ? NULL : rt;
-}
-
-static void *dn_rt_cache_seq_next(struct seq_file *seq, void *v, loff_t *pos)
-{
-	struct dn_route *rt = dn_rt_cache_get_next(seq, v);
-	++*pos;
-	return rt;
-}
-
-static void dn_rt_cache_seq_stop(struct seq_file *seq, void *v)
-{
-	if (v)
-		rcu_read_unlock_bh();
-}
-
-static int dn_rt_cache_seq_show(struct seq_file *seq, void *v)
-{
-	struct dn_route *rt = v;
-	char buf1[DN_ASCBUF_LEN], buf2[DN_ASCBUF_LEN];
-
-	seq_printf(seq, "%-8s %-7s %-7s %04d %04d %04d\n",
-		   rt->dst.dev ? rt->dst.dev->name : "*",
-		   dn_addr2asc(le16_to_cpu(rt->rt_daddr), buf1),
-		   dn_addr2asc(le16_to_cpu(rt->rt_saddr), buf2),
-		   atomic_read(&rt->dst.__refcnt),
-		   rt->dst.__use, 0);
-	return 0;
-}
-
-static const struct seq_operations dn_rt_cache_seq_ops = {
-	.start	= dn_rt_cache_seq_start,
-	.next	= dn_rt_cache_seq_next,
-	.stop	= dn_rt_cache_seq_stop,
-	.show	= dn_rt_cache_seq_show,
-};
-#endif /* CONFIG_PROC_FS */
-
-void __init dn_route_init(void)
-{
-	int i, goal, order;
-
-	dn_dst_ops.kmem_cachep =
-		kmem_cache_create("dn_dst_cache", sizeof(struct dn_route), 0,
-				  SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
-	dst_entries_init(&dn_dst_ops);
-	timer_setup(&dn_route_timer, dn_dst_check_expire, 0);
-	dn_route_timer.expires = jiffies + decnet_dst_gc_interval * HZ;
-	add_timer(&dn_route_timer);
-
-	goal = totalram_pages() >> (26 - PAGE_SHIFT);
-
-	for(order = 0; (1UL << order) < goal; order++)
-		/* NOTHING */;
-
-	/*
-	 * Only want 1024 entries max, since the table is very, very unlikely
-	 * to be larger than that.
-	 */
-	while(order && ((((1UL << order) * PAGE_SIZE) /
-				sizeof(struct dn_rt_hash_bucket)) >= 2048))
-		order--;
-
-	do {
-		dn_rt_hash_mask = (1UL << order) * PAGE_SIZE /
-			sizeof(struct dn_rt_hash_bucket);
-		while(dn_rt_hash_mask & (dn_rt_hash_mask - 1))
-			dn_rt_hash_mask--;
-		dn_rt_hash_table = (struct dn_rt_hash_bucket *)
-			__get_free_pages(GFP_ATOMIC, order);
-	} while (dn_rt_hash_table == NULL && --order > 0);
-
-	if (!dn_rt_hash_table)
-		panic("Failed to allocate DECnet route cache hash table\n");
-
-	printk(KERN_INFO
-		"DECnet: Routing cache hash table of %u buckets, %ldKbytes\n",
-		dn_rt_hash_mask,
-		(long)(dn_rt_hash_mask*sizeof(struct dn_rt_hash_bucket))/1024);
-
-	dn_rt_hash_mask--;
-	for(i = 0; i <= dn_rt_hash_mask; i++) {
-		spin_lock_init(&dn_rt_hash_table[i].lock);
-		dn_rt_hash_table[i].chain = NULL;
-	}
-
-	dn_dst_ops.gc_thresh = (dn_rt_hash_mask + 1);
-
-	proc_create_seq_private("decnet_cache", 0444, init_net.proc_net,
-			&dn_rt_cache_seq_ops,
-			sizeof(struct dn_rt_cache_iter_state), NULL);
-
-#ifdef CONFIG_DECNET_ROUTER
-	rtnl_register_module(THIS_MODULE, PF_DECnet, RTM_GETROUTE,
-			     dn_cache_getroute, dn_fib_dump, 0);
-#else
-	rtnl_register_module(THIS_MODULE, PF_DECnet, RTM_GETROUTE,
-			     dn_cache_getroute, dn_cache_dump, 0);
-#endif
-}
-
-void __exit dn_route_cleanup(void)
-{
-	del_timer(&dn_route_timer);
-	dn_run_flush(NULL);
-
-	remove_proc_entry("decnet_cache", init_net.proc_net);
-	dst_entries_destroy(&dn_dst_ops);
-}
diff --git a/net/decnet/dn_rules.c b/net/decnet/dn_rules.c
deleted file mode 100644
index 4a4e3c17740c..000000000000
--- a/net/decnet/dn_rules.c
+++ /dev/null
@@ -1,258 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-/*
- * DECnet       An implementation of the DECnet protocol suite for the LINUX
- *              operating system.  DECnet is implemented using the  BSD Socket
- *              interface as the means of communication with the user level.
- *
- *              DECnet Routing Forwarding Information Base (Rules)
- *
- * Author:      Steve Whitehouse <SteveW@ACM.org>
- *              Mostly copied from Alexey Kuznetsov's ipv4/fib_rules.c
- *
- *
- * Changes:
- *              Steve Whitehouse <steve@chygwyn.com>
- *              Updated for Thomas Graf's generic rules
- *
- */
-#include <linux/net.h>
-#include <linux/init.h>
-#include <linux/netlink.h>
-#include <linux/rtnetlink.h>
-#include <linux/netdevice.h>
-#include <linux/spinlock.h>
-#include <linux/list.h>
-#include <linux/rcupdate.h>
-#include <linux/export.h>
-#include <net/neighbour.h>
-#include <net/dst.h>
-#include <net/flow.h>
-#include <net/fib_rules.h>
-#include <net/dn.h>
-#include <net/dn_fib.h>
-#include <net/dn_neigh.h>
-#include <net/dn_dev.h>
-#include <net/dn_route.h>
-
-static struct fib_rules_ops *dn_fib_rules_ops;
-
-struct dn_fib_rule
-{
-	struct fib_rule		common;
-	unsigned char		dst_len;
-	unsigned char		src_len;
-	__le16			src;
-	__le16			srcmask;
-	__le16			dst;
-	__le16			dstmask;
-	__le16			srcmap;
-	u8			flags;
-};
-
-
-int dn_fib_lookup(struct flowidn *flp, struct dn_fib_res *res)
-{
-	struct fib_lookup_arg arg = {
-		.result = res,
-	};
-	int err;
-
-	err = fib_rules_lookup(dn_fib_rules_ops,
-			       flowidn_to_flowi(flp), 0, &arg);
-	res->r = arg.rule;
-
-	return err;
-}
-
-static int dn_fib_rule_action(struct fib_rule *rule, struct flowi *flp,
-			      int flags, struct fib_lookup_arg *arg)
-{
-	struct flowidn *fld = &flp->u.dn;
-	int err = -EAGAIN;
-	struct dn_fib_table *tbl;
-
-	switch(rule->action) {
-	case FR_ACT_TO_TBL:
-		break;
-
-	case FR_ACT_UNREACHABLE:
-		err = -ENETUNREACH;
-		goto errout;
-
-	case FR_ACT_PROHIBIT:
-		err = -EACCES;
-		goto errout;
-
-	case FR_ACT_BLACKHOLE:
-	default:
-		err = -EINVAL;
-		goto errout;
-	}
-
-	tbl = dn_fib_get_table(rule->table, 0);
-	if (tbl == NULL)
-		goto errout;
-
-	err = tbl->lookup(tbl, fld, (struct dn_fib_res *)arg->result);
-	if (err > 0)
-		err = -EAGAIN;
-errout:
-	return err;
-}
-
-static const struct nla_policy dn_fib_rule_policy[FRA_MAX+1] = {
-	FRA_GENERIC_POLICY,
-};
-
-static int dn_fib_rule_match(struct fib_rule *rule, struct flowi *fl, int flags)
-{
-	struct dn_fib_rule *r = (struct dn_fib_rule *)rule;
-	struct flowidn *fld = &fl->u.dn;
-	__le16 daddr = fld->daddr;
-	__le16 saddr = fld->saddr;
-
-	if (((saddr ^ r->src) & r->srcmask) ||
-	    ((daddr ^ r->dst) & r->dstmask))
-		return 0;
-
-	return 1;
-}
-
-static int dn_fib_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
-				 struct fib_rule_hdr *frh,
-				 struct nlattr **tb,
-				 struct netlink_ext_ack *extack)
-{
-	int err = -EINVAL;
-	struct dn_fib_rule *r = (struct dn_fib_rule *)rule;
-
-	if (frh->tos) {
-		NL_SET_ERR_MSG(extack, "Invalid tos value");
-		goto  errout;
-	}
-
-	if (rule->table == RT_TABLE_UNSPEC) {
-		if (rule->action == FR_ACT_TO_TBL) {
-			struct dn_fib_table *table;
-
-			table = dn_fib_empty_table();
-			if (table == NULL) {
-				err = -ENOBUFS;
-				goto errout;
-			}
-
-			rule->table = table->n;
-		}
-	}
-
-	if (frh->src_len)
-		r->src = nla_get_le16(tb[FRA_SRC]);
-
-	if (frh->dst_len)
-		r->dst = nla_get_le16(tb[FRA_DST]);
-
-	r->src_len = frh->src_len;
-	r->srcmask = dnet_make_mask(r->src_len);
-	r->dst_len = frh->dst_len;
-	r->dstmask = dnet_make_mask(r->dst_len);
-	err = 0;
-errout:
-	return err;
-}
-
-static int dn_fib_rule_compare(struct fib_rule *rule, struct fib_rule_hdr *frh,
-			       struct nlattr **tb)
-{
-	struct dn_fib_rule *r = (struct dn_fib_rule *)rule;
-
-	if (frh->src_len && (r->src_len != frh->src_len))
-		return 0;
-
-	if (frh->dst_len && (r->dst_len != frh->dst_len))
-		return 0;
-
-	if (frh->src_len && (r->src != nla_get_le16(tb[FRA_SRC])))
-		return 0;
-
-	if (frh->dst_len && (r->dst != nla_get_le16(tb[FRA_DST])))
-		return 0;
-
-	return 1;
-}
-
-unsigned int dnet_addr_type(__le16 addr)
-{
-	struct flowidn fld = { .daddr = addr };
-	struct dn_fib_res res;
-	unsigned int ret = RTN_UNICAST;
-	struct dn_fib_table *tb = dn_fib_get_table(RT_TABLE_LOCAL, 0);
-
-	res.r = NULL;
-
-	if (tb) {
-		if (!tb->lookup(tb, &fld, &res)) {
-			ret = res.type;
-			dn_fib_res_put(&res);
-		}
-	}
-	return ret;
-}
-
-static int dn_fib_rule_fill(struct fib_rule *rule, struct sk_buff *skb,
-			    struct fib_rule_hdr *frh)
-{
-	struct dn_fib_rule *r = (struct dn_fib_rule *)rule;
-
-	frh->dst_len = r->dst_len;
-	frh->src_len = r->src_len;
-	frh->tos = 0;
-
-	if ((r->dst_len &&
-	     nla_put_le16(skb, FRA_DST, r->dst)) ||
-	    (r->src_len &&
-	     nla_put_le16(skb, FRA_SRC, r->src)))
-		goto nla_put_failure;
-	return 0;
-
-nla_put_failure:
-	return -ENOBUFS;
-}
-
-static void dn_fib_rule_flush_cache(struct fib_rules_ops *ops)
-{
-	dn_rt_cache_flush(-1);
-}
-
-static const struct fib_rules_ops __net_initconst dn_fib_rules_ops_template = {
-	.family		= AF_DECnet,
-	.rule_size	= sizeof(struct dn_fib_rule),
-	.addr_size	= sizeof(u16),
-	.action		= dn_fib_rule_action,
-	.match		= dn_fib_rule_match,
-	.configure	= dn_fib_rule_configure,
-	.compare	= dn_fib_rule_compare,
-	.fill		= dn_fib_rule_fill,
-	.flush_cache	= dn_fib_rule_flush_cache,
-	.nlgroup	= RTNLGRP_DECnet_RULE,
-	.policy		= dn_fib_rule_policy,
-	.owner		= THIS_MODULE,
-	.fro_net	= &init_net,
-};
-
-void __init dn_fib_rules_init(void)
-{
-	dn_fib_rules_ops =
-		fib_rules_register(&dn_fib_rules_ops_template, &init_net);
-	BUG_ON(IS_ERR(dn_fib_rules_ops));
-	BUG_ON(fib_default_rule_add(dn_fib_rules_ops, 0x7fff,
-			            RT_TABLE_MAIN, 0));
-}
-
-void __exit dn_fib_rules_cleanup(void)
-{
-	rtnl_lock();
-	fib_rules_unregister(dn_fib_rules_ops);
-	rtnl_unlock();
-	rcu_barrier();
-}
diff --git a/net/decnet/dn_table.c b/net/decnet/dn_table.c
deleted file mode 100644
index 4086f9c746af..000000000000
--- a/net/decnet/dn_table.c
+++ /dev/null
@@ -1,929 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * DECnet       An implementation of the DECnet protocol suite for the LINUX
- *              operating system.  DECnet is implemented using the  BSD Socket
- *              interface as the means of communication with the user level.
- *
- *              DECnet Routing Forwarding Information Base (Routing Tables)
- *
- * Author:      Steve Whitehouse <SteveW@ACM.org>
- *              Mostly copied from the IPv4 routing code
- *
- *
- * Changes:
- *
- */
-#include <linux/string.h>
-#include <linux/net.h>
-#include <linux/socket.h>
-#include <linux/slab.h>
-#include <linux/sockios.h>
-#include <linux/init.h>
-#include <linux/skbuff.h>
-#include <linux/rtnetlink.h>
-#include <linux/proc_fs.h>
-#include <linux/netdevice.h>
-#include <linux/timer.h>
-#include <linux/spinlock.h>
-#include <linux/atomic.h>
-#include <linux/uaccess.h>
-#include <linux/route.h> /* RTF_xxx */
-#include <net/neighbour.h>
-#include <net/netlink.h>
-#include <net/tcp.h>
-#include <net/dst.h>
-#include <net/flow.h>
-#include <net/fib_rules.h>
-#include <net/dn.h>
-#include <net/dn_route.h>
-#include <net/dn_fib.h>
-#include <net/dn_neigh.h>
-#include <net/dn_dev.h>
-
-struct dn_zone
-{
-	struct dn_zone		*dz_next;
-	struct dn_fib_node 	**dz_hash;
-	int			dz_nent;
-	int			dz_divisor;
-	u32			dz_hashmask;
-#define DZ_HASHMASK(dz)	((dz)->dz_hashmask)
-	int			dz_order;
-	__le16			dz_mask;
-#define DZ_MASK(dz)	((dz)->dz_mask)
-};
-
-struct dn_hash
-{
-	struct dn_zone	*dh_zones[17];
-	struct dn_zone	*dh_zone_list;
-};
-
-#define dz_key_0(key)		((key).datum = 0)
-
-#define for_nexthops(fi) { int nhsel; const struct dn_fib_nh *nh;\
-	for(nhsel = 0, nh = (fi)->fib_nh; nhsel < (fi)->fib_nhs; nh++, nhsel++)
-
-#define endfor_nexthops(fi) }
-
-#define DN_MAX_DIVISOR 1024
-#define DN_S_ZOMBIE 1
-#define DN_S_ACCESSED 2
-
-#define DN_FIB_SCAN(f, fp) \
-for( ; ((f) = *(fp)) != NULL; (fp) = &(f)->fn_next)
-
-#define DN_FIB_SCAN_KEY(f, fp, key) \
-for( ; ((f) = *(fp)) != NULL && dn_key_eq((f)->fn_key, (key)); (fp) = &(f)->fn_next)
-
-#define RT_TABLE_MIN 1
-#define DN_FIB_TABLE_HASHSZ 256
-static struct hlist_head dn_fib_table_hash[DN_FIB_TABLE_HASHSZ];
-static DEFINE_RWLOCK(dn_fib_tables_lock);
-
-static struct kmem_cache *dn_hash_kmem __read_mostly;
-static int dn_fib_hash_zombies;
-
-static inline dn_fib_idx_t dn_hash(dn_fib_key_t key, struct dn_zone *dz)
-{
-	u16 h = le16_to_cpu(key.datum)>>(16 - dz->dz_order);
-	h ^= (h >> 10);
-	h ^= (h >> 6);
-	h &= DZ_HASHMASK(dz);
-	return *(dn_fib_idx_t *)&h;
-}
-
-static inline dn_fib_key_t dz_key(__le16 dst, struct dn_zone *dz)
-{
-	dn_fib_key_t k;
-	k.datum = dst & DZ_MASK(dz);
-	return k;
-}
-
-static inline struct dn_fib_node **dn_chain_p(dn_fib_key_t key, struct dn_zone *dz)
-{
-	return &dz->dz_hash[dn_hash(key, dz).datum];
-}
-
-static inline struct dn_fib_node *dz_chain(dn_fib_key_t key, struct dn_zone *dz)
-{
-	return dz->dz_hash[dn_hash(key, dz).datum];
-}
-
-static inline int dn_key_eq(dn_fib_key_t a, dn_fib_key_t b)
-{
-	return a.datum == b.datum;
-}
-
-static inline int dn_key_leq(dn_fib_key_t a, dn_fib_key_t b)
-{
-	return a.datum <= b.datum;
-}
-
-static inline void dn_rebuild_zone(struct dn_zone *dz,
-				   struct dn_fib_node **old_ht,
-				   int old_divisor)
-{
-	struct dn_fib_node *f, **fp, *next;
-	int i;
-
-	for(i = 0; i < old_divisor; i++) {
-		for(f = old_ht[i]; f; f = next) {
-			next = f->fn_next;
-			for(fp = dn_chain_p(f->fn_key, dz);
-				*fp && dn_key_leq((*fp)->fn_key, f->fn_key);
-				fp = &(*fp)->fn_next)
-				/* NOTHING */;
-			f->fn_next = *fp;
-			*fp = f;
-		}
-	}
-}
-
-static void dn_rehash_zone(struct dn_zone *dz)
-{
-	struct dn_fib_node **ht, **old_ht;
-	int old_divisor, new_divisor;
-	u32 new_hashmask;
-
-	old_divisor = dz->dz_divisor;
-
-	switch (old_divisor) {
-	case 16:
-		new_divisor = 256;
-		new_hashmask = 0xFF;
-		break;
-	default:
-		printk(KERN_DEBUG "DECnet: dn_rehash_zone: BUG! %d\n",
-		       old_divisor);
-		fallthrough;
-	case 256:
-		new_divisor = 1024;
-		new_hashmask = 0x3FF;
-		break;
-	}
-
-	ht = kcalloc(new_divisor, sizeof(struct dn_fib_node*), GFP_KERNEL);
-	if (ht == NULL)
-		return;
-
-	write_lock_bh(&dn_fib_tables_lock);
-	old_ht = dz->dz_hash;
-	dz->dz_hash = ht;
-	dz->dz_hashmask = new_hashmask;
-	dz->dz_divisor = new_divisor;
-	dn_rebuild_zone(dz, old_ht, old_divisor);
-	write_unlock_bh(&dn_fib_tables_lock);
-	kfree(old_ht);
-}
-
-static void dn_free_node(struct dn_fib_node *f)
-{
-	dn_fib_release_info(DN_FIB_INFO(f));
-	kmem_cache_free(dn_hash_kmem, f);
-}
-
-
-static struct dn_zone *dn_new_zone(struct dn_hash *table, int z)
-{
-	int i;
-	struct dn_zone *dz = kzalloc(sizeof(struct dn_zone), GFP_KERNEL);
-	if (!dz)
-		return NULL;
-
-	if (z) {
-		dz->dz_divisor = 16;
-		dz->dz_hashmask = 0x0F;
-	} else {
-		dz->dz_divisor = 1;
-		dz->dz_hashmask = 0;
-	}
-
-	dz->dz_hash = kcalloc(dz->dz_divisor, sizeof(struct dn_fib_node *), GFP_KERNEL);
-	if (!dz->dz_hash) {
-		kfree(dz);
-		return NULL;
-	}
-
-	dz->dz_order = z;
-	dz->dz_mask = dnet_make_mask(z);
-
-	for(i = z + 1; i <= 16; i++)
-		if (table->dh_zones[i])
-			break;
-
-	write_lock_bh(&dn_fib_tables_lock);
-	if (i>16) {
-		dz->dz_next = table->dh_zone_list;
-		table->dh_zone_list = dz;
-	} else {
-		dz->dz_next = table->dh_zones[i]->dz_next;
-		table->dh_zones[i]->dz_next = dz;
-	}
-	table->dh_zones[z] = dz;
-	write_unlock_bh(&dn_fib_tables_lock);
-	return dz;
-}
-
-
-static int dn_fib_nh_match(struct rtmsg *r, struct nlmsghdr *nlh, struct nlattr *attrs[], struct dn_fib_info *fi)
-{
-	struct rtnexthop *nhp;
-	int nhlen;
-
-	if (attrs[RTA_PRIORITY] &&
-	    nla_get_u32(attrs[RTA_PRIORITY]) != fi->fib_priority)
-		return 1;
-
-	if (attrs[RTA_OIF] || attrs[RTA_GATEWAY]) {
-		if ((!attrs[RTA_OIF] || nla_get_u32(attrs[RTA_OIF]) == fi->fib_nh->nh_oif) &&
-		    (!attrs[RTA_GATEWAY]  || nla_get_le16(attrs[RTA_GATEWAY]) != fi->fib_nh->nh_gw))
-			return 0;
-		return 1;
-	}
-
-	if (!attrs[RTA_MULTIPATH])
-		return 0;
-
-	nhp = nla_data(attrs[RTA_MULTIPATH]);
-	nhlen = nla_len(attrs[RTA_MULTIPATH]);
-
-	for_nexthops(fi) {
-		int attrlen = nhlen - sizeof(struct rtnexthop);
-		__le16 gw;
-
-		if (attrlen < 0 || (nhlen -= nhp->rtnh_len) < 0)
-			return -EINVAL;
-		if (nhp->rtnh_ifindex && nhp->rtnh_ifindex != nh->nh_oif)
-			return 1;
-		if (attrlen) {
-			struct nlattr *gw_attr;
-
-			gw_attr = nla_find((struct nlattr *) (nhp + 1), attrlen, RTA_GATEWAY);
-			gw = gw_attr ? nla_get_le16(gw_attr) : 0;
-
-			if (gw && gw != nh->nh_gw)
-				return 1;
-		}
-		nhp = RTNH_NEXT(nhp);
-	} endfor_nexthops(fi);
-
-	return 0;
-}
-
-static inline size_t dn_fib_nlmsg_size(struct dn_fib_info *fi)
-{
-	size_t payload = NLMSG_ALIGN(sizeof(struct rtmsg))
-			 + nla_total_size(4) /* RTA_TABLE */
-			 + nla_total_size(2) /* RTA_DST */
-			 + nla_total_size(4) /* RTA_PRIORITY */
-			 + nla_total_size(TCP_CA_NAME_MAX); /* RTAX_CC_ALGO */
-
-	/* space for nested metrics */
-	payload += nla_total_size((RTAX_MAX * nla_total_size(4)));
-
-	if (fi->fib_nhs) {
-		/* Also handles the special case fib_nhs == 1 */
-
-		/* each nexthop is packed in an attribute */
-		size_t nhsize = nla_total_size(sizeof(struct rtnexthop));
-
-		/* may contain a gateway attribute */
-		nhsize += nla_total_size(4);
-
-		/* all nexthops are packed in a nested attribute */
-		payload += nla_total_size(fi->fib_nhs * nhsize);
-	}
-
-	return payload;
-}
-
-static int dn_fib_dump_info(struct sk_buff *skb, u32 portid, u32 seq, int event,
-			u32 tb_id, u8 type, u8 scope, void *dst, int dst_len,
-			struct dn_fib_info *fi, unsigned int flags)
-{
-	struct rtmsg *rtm;
-	struct nlmsghdr *nlh;
-
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*rtm), flags);
-	if (!nlh)
-		return -EMSGSIZE;
-
-	rtm = nlmsg_data(nlh);
-	rtm->rtm_family = AF_DECnet;
-	rtm->rtm_dst_len = dst_len;
-	rtm->rtm_src_len = 0;
-	rtm->rtm_tos = 0;
-	rtm->rtm_table = tb_id;
-	rtm->rtm_flags = fi->fib_flags;
-	rtm->rtm_scope = scope;
-	rtm->rtm_type  = type;
-	rtm->rtm_protocol = fi->fib_protocol;
-
-	if (nla_put_u32(skb, RTA_TABLE, tb_id) < 0)
-		goto errout;
-
-	if (rtm->rtm_dst_len &&
-	    nla_put(skb, RTA_DST, 2, dst) < 0)
-		goto errout;
-
-	if (fi->fib_priority &&
-	    nla_put_u32(skb, RTA_PRIORITY, fi->fib_priority) < 0)
-		goto errout;
-
-	if (rtnetlink_put_metrics(skb, fi->fib_metrics) < 0)
-		goto errout;
-
-	if (fi->fib_nhs == 1) {
-		if (fi->fib_nh->nh_gw &&
-		    nla_put_le16(skb, RTA_GATEWAY, fi->fib_nh->nh_gw) < 0)
-			goto errout;
-
-		if (fi->fib_nh->nh_oif &&
-		    nla_put_u32(skb, RTA_OIF, fi->fib_nh->nh_oif) < 0)
-			goto errout;
-	}
-
-	if (fi->fib_nhs > 1) {
-		struct rtnexthop *nhp;
-		struct nlattr *mp_head;
-
-		mp_head = nla_nest_start_noflag(skb, RTA_MULTIPATH);
-		if (!mp_head)
-			goto errout;
-
-		for_nexthops(fi) {
-			if (!(nhp = nla_reserve_nohdr(skb, sizeof(*nhp))))
-				goto errout;
-
-			nhp->rtnh_flags = nh->nh_flags & 0xFF;
-			nhp->rtnh_hops = nh->nh_weight - 1;
-			nhp->rtnh_ifindex = nh->nh_oif;
-
-			if (nh->nh_gw &&
-			    nla_put_le16(skb, RTA_GATEWAY, nh->nh_gw) < 0)
-				goto errout;
-
-			nhp->rtnh_len = skb_tail_pointer(skb) - (unsigned char *)nhp;
-		} endfor_nexthops(fi);
-
-		nla_nest_end(skb, mp_head);
-	}
-
-	nlmsg_end(skb, nlh);
-	return 0;
-
-errout:
-	nlmsg_cancel(skb, nlh);
-	return -EMSGSIZE;
-}
-
-
-static void dn_rtmsg_fib(int event, struct dn_fib_node *f, int z, u32 tb_id,
-			struct nlmsghdr *nlh, struct netlink_skb_parms *req)
-{
-	struct sk_buff *skb;
-	u32 portid = req ? req->portid : 0;
-	int err = -ENOBUFS;
-
-	skb = nlmsg_new(dn_fib_nlmsg_size(DN_FIB_INFO(f)), GFP_KERNEL);
-	if (skb == NULL)
-		goto errout;
-
-	err = dn_fib_dump_info(skb, portid, nlh->nlmsg_seq, event, tb_id,
-			       f->fn_type, f->fn_scope, &f->fn_key, z,
-			       DN_FIB_INFO(f), 0);
-	if (err < 0) {
-		/* -EMSGSIZE implies BUG in dn_fib_nlmsg_size() */
-		WARN_ON(err == -EMSGSIZE);
-		kfree_skb(skb);
-		goto errout;
-	}
-	rtnl_notify(skb, &init_net, portid, RTNLGRP_DECnet_ROUTE, nlh, GFP_KERNEL);
-	return;
-errout:
-	if (err < 0)
-		rtnl_set_sk_err(&init_net, RTNLGRP_DECnet_ROUTE, err);
-}
-
-static __inline__ int dn_hash_dump_bucket(struct sk_buff *skb,
-				struct netlink_callback *cb,
-				struct dn_fib_table *tb,
-				struct dn_zone *dz,
-				struct dn_fib_node *f)
-{
-	int i, s_i;
-
-	s_i = cb->args[4];
-	for(i = 0; f; i++, f = f->fn_next) {
-		if (i < s_i)
-			continue;
-		if (f->fn_state & DN_S_ZOMBIE)
-			continue;
-		if (dn_fib_dump_info(skb, NETLINK_CB(cb->skb).portid,
-				cb->nlh->nlmsg_seq,
-				RTM_NEWROUTE,
-				tb->n,
-				(f->fn_state & DN_S_ZOMBIE) ? 0 : f->fn_type,
-				f->fn_scope, &f->fn_key, dz->dz_order,
-				f->fn_info, NLM_F_MULTI) < 0) {
-			cb->args[4] = i;
-			return -1;
-		}
-	}
-	cb->args[4] = i;
-	return skb->len;
-}
-
-static __inline__ int dn_hash_dump_zone(struct sk_buff *skb,
-				struct netlink_callback *cb,
-				struct dn_fib_table *tb,
-				struct dn_zone *dz)
-{
-	int h, s_h;
-
-	s_h = cb->args[3];
-	for(h = 0; h < dz->dz_divisor; h++) {
-		if (h < s_h)
-			continue;
-		if (h > s_h)
-			memset(&cb->args[4], 0, sizeof(cb->args) - 4*sizeof(cb->args[0]));
-		if (dz->dz_hash == NULL || dz->dz_hash[h] == NULL)
-			continue;
-		if (dn_hash_dump_bucket(skb, cb, tb, dz, dz->dz_hash[h]) < 0) {
-			cb->args[3] = h;
-			return -1;
-		}
-	}
-	cb->args[3] = h;
-	return skb->len;
-}
-
-static int dn_fib_table_dump(struct dn_fib_table *tb, struct sk_buff *skb,
-				struct netlink_callback *cb)
-{
-	int m, s_m;
-	struct dn_zone *dz;
-	struct dn_hash *table = (struct dn_hash *)tb->data;
-
-	s_m = cb->args[2];
-	read_lock(&dn_fib_tables_lock);
-	for(dz = table->dh_zone_list, m = 0; dz; dz = dz->dz_next, m++) {
-		if (m < s_m)
-			continue;
-		if (m > s_m)
-			memset(&cb->args[3], 0, sizeof(cb->args) - 3*sizeof(cb->args[0]));
-
-		if (dn_hash_dump_zone(skb, cb, tb, dz) < 0) {
-			cb->args[2] = m;
-			read_unlock(&dn_fib_tables_lock);
-			return -1;
-		}
-	}
-	read_unlock(&dn_fib_tables_lock);
-	cb->args[2] = m;
-
-	return skb->len;
-}
-
-int dn_fib_dump(struct sk_buff *skb, struct netlink_callback *cb)
-{
-	struct net *net = sock_net(skb->sk);
-	unsigned int h, s_h;
-	unsigned int e = 0, s_e;
-	struct dn_fib_table *tb;
-	int dumped = 0;
-
-	if (!net_eq(net, &init_net))
-		return 0;
-
-	if (nlmsg_len(cb->nlh) >= sizeof(struct rtmsg) &&
-		((struct rtmsg *)nlmsg_data(cb->nlh))->rtm_flags&RTM_F_CLONED)
-			return dn_cache_dump(skb, cb);
-
-	s_h = cb->args[0];
-	s_e = cb->args[1];
-
-	for (h = s_h; h < DN_FIB_TABLE_HASHSZ; h++, s_h = 0) {
-		e = 0;
-		hlist_for_each_entry(tb, &dn_fib_table_hash[h], hlist) {
-			if (e < s_e)
-				goto next;
-			if (dumped)
-				memset(&cb->args[2], 0, sizeof(cb->args) -
-						 2 * sizeof(cb->args[0]));
-			if (tb->dump(tb, skb, cb) < 0)
-				goto out;
-			dumped = 1;
-next:
-			e++;
-		}
-	}
-out:
-	cb->args[1] = e;
-	cb->args[0] = h;
-
-	return skb->len;
-}
-
-static int dn_fib_table_insert(struct dn_fib_table *tb, struct rtmsg *r, struct nlattr *attrs[],
-			       struct nlmsghdr *n, struct netlink_skb_parms *req)
-{
-	struct dn_hash *table = (struct dn_hash *)tb->data;
-	struct dn_fib_node *new_f, *f, **fp, **del_fp;
-	struct dn_zone *dz;
-	struct dn_fib_info *fi;
-	int z = r->rtm_dst_len;
-	int type = r->rtm_type;
-	dn_fib_key_t key;
-	int err;
-
-	if (z > 16)
-		return -EINVAL;
-
-	dz = table->dh_zones[z];
-	if (!dz && !(dz = dn_new_zone(table, z)))
-		return -ENOBUFS;
-
-	dz_key_0(key);
-	if (attrs[RTA_DST]) {
-		__le16 dst = nla_get_le16(attrs[RTA_DST]);
-		if (dst & ~DZ_MASK(dz))
-			return -EINVAL;
-		key = dz_key(dst, dz);
-	}
-
-	if ((fi = dn_fib_create_info(r, attrs, n, &err)) == NULL)
-		return err;
-
-	if (dz->dz_nent > (dz->dz_divisor << 2) &&
-			dz->dz_divisor > DN_MAX_DIVISOR &&
-			(z==16 || (1<<z) > dz->dz_divisor))
-		dn_rehash_zone(dz);
-
-	fp = dn_chain_p(key, dz);
-
-	DN_FIB_SCAN(f, fp) {
-		if (dn_key_leq(key, f->fn_key))
-			break;
-	}
-
-	del_fp = NULL;
-
-	if (f && (f->fn_state & DN_S_ZOMBIE) &&
-			dn_key_eq(f->fn_key, key)) {
-		del_fp = fp;
-		fp = &f->fn_next;
-		f = *fp;
-		goto create;
-	}
-
-	DN_FIB_SCAN_KEY(f, fp, key) {
-		if (fi->fib_priority <= DN_FIB_INFO(f)->fib_priority)
-			break;
-	}
-
-	if (f && dn_key_eq(f->fn_key, key) &&
-			fi->fib_priority == DN_FIB_INFO(f)->fib_priority) {
-		struct dn_fib_node **ins_fp;
-
-		err = -EEXIST;
-		if (n->nlmsg_flags & NLM_F_EXCL)
-			goto out;
-
-		if (n->nlmsg_flags & NLM_F_REPLACE) {
-			del_fp = fp;
-			fp = &f->fn_next;
-			f = *fp;
-			goto replace;
-		}
-
-		ins_fp = fp;
-		err = -EEXIST;
-
-		DN_FIB_SCAN_KEY(f, fp, key) {
-			if (fi->fib_priority != DN_FIB_INFO(f)->fib_priority)
-				break;
-			if (f->fn_type == type &&
-			    f->fn_scope == r->rtm_scope &&
-			    DN_FIB_INFO(f) == fi)
-				goto out;
-		}
-
-		if (!(n->nlmsg_flags & NLM_F_APPEND)) {
-			fp = ins_fp;
-			f = *fp;
-		}
-	}
-
-create:
-	err = -ENOENT;
-	if (!(n->nlmsg_flags & NLM_F_CREATE))
-		goto out;
-
-replace:
-	err = -ENOBUFS;
-	new_f = kmem_cache_zalloc(dn_hash_kmem, GFP_KERNEL);
-	if (new_f == NULL)
-		goto out;
-
-	new_f->fn_key = key;
-	new_f->fn_type = type;
-	new_f->fn_scope = r->rtm_scope;
-	DN_FIB_INFO(new_f) = fi;
-
-	new_f->fn_next = f;
-	write_lock_bh(&dn_fib_tables_lock);
-	*fp = new_f;
-	write_unlock_bh(&dn_fib_tables_lock);
-	dz->dz_nent++;
-
-	if (del_fp) {
-		f = *del_fp;
-		write_lock_bh(&dn_fib_tables_lock);
-		*del_fp = f->fn_next;
-		write_unlock_bh(&dn_fib_tables_lock);
-
-		if (!(f->fn_state & DN_S_ZOMBIE))
-			dn_rtmsg_fib(RTM_DELROUTE, f, z, tb->n, n, req);
-		if (f->fn_state & DN_S_ACCESSED)
-			dn_rt_cache_flush(-1);
-		dn_free_node(f);
-		dz->dz_nent--;
-	} else {
-		dn_rt_cache_flush(-1);
-	}
-
-	dn_rtmsg_fib(RTM_NEWROUTE, new_f, z, tb->n, n, req);
-
-	return 0;
-out:
-	dn_fib_release_info(fi);
-	return err;
-}
-
-
-static int dn_fib_table_delete(struct dn_fib_table *tb, struct rtmsg *r, struct nlattr *attrs[],
-			       struct nlmsghdr *n, struct netlink_skb_parms *req)
-{
-	struct dn_hash *table = (struct dn_hash*)tb->data;
-	struct dn_fib_node **fp, **del_fp, *f;
-	int z = r->rtm_dst_len;
-	struct dn_zone *dz;
-	dn_fib_key_t key;
-	int matched;
-
-
-	if (z > 16)
-		return -EINVAL;
-
-	if ((dz = table->dh_zones[z]) == NULL)
-		return -ESRCH;
-
-	dz_key_0(key);
-	if (attrs[RTA_DST]) {
-		__le16 dst = nla_get_le16(attrs[RTA_DST]);
-		if (dst & ~DZ_MASK(dz))
-			return -EINVAL;
-		key = dz_key(dst, dz);
-	}
-
-	fp = dn_chain_p(key, dz);
-
-	DN_FIB_SCAN(f, fp) {
-		if (dn_key_eq(f->fn_key, key))
-			break;
-		if (dn_key_leq(key, f->fn_key))
-			return -ESRCH;
-	}
-
-	matched = 0;
-	del_fp = NULL;
-	DN_FIB_SCAN_KEY(f, fp, key) {
-		struct dn_fib_info *fi = DN_FIB_INFO(f);
-
-		if (f->fn_state & DN_S_ZOMBIE)
-			return -ESRCH;
-
-		matched++;
-
-		if (del_fp == NULL &&
-				(!r->rtm_type || f->fn_type == r->rtm_type) &&
-				(r->rtm_scope == RT_SCOPE_NOWHERE || f->fn_scope == r->rtm_scope) &&
-				(!r->rtm_protocol ||
-					fi->fib_protocol == r->rtm_protocol) &&
-				dn_fib_nh_match(r, n, attrs, fi) == 0)
-			del_fp = fp;
-	}
-
-	if (del_fp) {
-		f = *del_fp;
-		dn_rtmsg_fib(RTM_DELROUTE, f, z, tb->n, n, req);
-
-		if (matched != 1) {
-			write_lock_bh(&dn_fib_tables_lock);
-			*del_fp = f->fn_next;
-			write_unlock_bh(&dn_fib_tables_lock);
-
-			if (f->fn_state & DN_S_ACCESSED)
-				dn_rt_cache_flush(-1);
-			dn_free_node(f);
-			dz->dz_nent--;
-		} else {
-			f->fn_state |= DN_S_ZOMBIE;
-			if (f->fn_state & DN_S_ACCESSED) {
-				f->fn_state &= ~DN_S_ACCESSED;
-				dn_rt_cache_flush(-1);
-			}
-			if (++dn_fib_hash_zombies > 128)
-				dn_fib_flush();
-		}
-
-		return 0;
-	}
-
-	return -ESRCH;
-}
-
-static inline int dn_flush_list(struct dn_fib_node **fp, int z, struct dn_hash *table)
-{
-	int found = 0;
-	struct dn_fib_node *f;
-
-	while((f = *fp) != NULL) {
-		struct dn_fib_info *fi = DN_FIB_INFO(f);
-
-		if (fi && ((f->fn_state & DN_S_ZOMBIE) || (fi->fib_flags & RTNH_F_DEAD))) {
-			write_lock_bh(&dn_fib_tables_lock);
-			*fp = f->fn_next;
-			write_unlock_bh(&dn_fib_tables_lock);
-
-			dn_free_node(f);
-			found++;
-			continue;
-		}
-		fp = &f->fn_next;
-	}
-
-	return found;
-}
-
-static int dn_fib_table_flush(struct dn_fib_table *tb)
-{
-	struct dn_hash *table = (struct dn_hash *)tb->data;
-	struct dn_zone *dz;
-	int found = 0;
-
-	dn_fib_hash_zombies = 0;
-	for(dz = table->dh_zone_list; dz; dz = dz->dz_next) {
-		int i;
-		int tmp = 0;
-		for(i = dz->dz_divisor-1; i >= 0; i--)
-			tmp += dn_flush_list(&dz->dz_hash[i], dz->dz_order, table);
-		dz->dz_nent -= tmp;
-		found += tmp;
-	}
-
-	return found;
-}
-
-static int dn_fib_table_lookup(struct dn_fib_table *tb, const struct flowidn *flp, struct dn_fib_res *res)
-{
-	int err;
-	struct dn_zone *dz;
-	struct dn_hash *t = (struct dn_hash *)tb->data;
-
-	read_lock(&dn_fib_tables_lock);
-	for(dz = t->dh_zone_list; dz; dz = dz->dz_next) {
-		struct dn_fib_node *f;
-		dn_fib_key_t k = dz_key(flp->daddr, dz);
-
-		for(f = dz_chain(k, dz); f; f = f->fn_next) {
-			if (!dn_key_eq(k, f->fn_key)) {
-				if (dn_key_leq(k, f->fn_key))
-					break;
-				else
-					continue;
-			}
-
-			f->fn_state |= DN_S_ACCESSED;
-
-			if (f->fn_state&DN_S_ZOMBIE)
-				continue;
-
-			if (f->fn_scope < flp->flowidn_scope)
-				continue;
-
-			err = dn_fib_semantic_match(f->fn_type, DN_FIB_INFO(f), flp, res);
-
-			if (err == 0) {
-				res->type = f->fn_type;
-				res->scope = f->fn_scope;
-				res->prefixlen = dz->dz_order;
-				goto out;
-			}
-			if (err < 0)
-				goto out;
-		}
-	}
-	err = 1;
-out:
-	read_unlock(&dn_fib_tables_lock);
-	return err;
-}
-
-
-struct dn_fib_table *dn_fib_get_table(u32 n, int create)
-{
-	struct dn_fib_table *t;
-	unsigned int h;
-
-	if (n < RT_TABLE_MIN)
-		return NULL;
-
-	if (n > RT_TABLE_MAX)
-		return NULL;
-
-	h = n & (DN_FIB_TABLE_HASHSZ - 1);
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(t, &dn_fib_table_hash[h], hlist) {
-		if (t->n == n) {
-			rcu_read_unlock();
-			return t;
-		}
-	}
-	rcu_read_unlock();
-
-	if (!create)
-		return NULL;
-
-	if (in_interrupt()) {
-		net_dbg_ratelimited("DECnet: BUG! Attempt to create routing table from interrupt\n");
-		return NULL;
-	}
-
-	t = kzalloc(sizeof(struct dn_fib_table) + sizeof(struct dn_hash),
-		    GFP_KERNEL);
-	if (t == NULL)
-		return NULL;
-
-	t->n = n;
-	t->insert = dn_fib_table_insert;
-	t->delete = dn_fib_table_delete;
-	t->lookup = dn_fib_table_lookup;
-	t->flush  = dn_fib_table_flush;
-	t->dump = dn_fib_table_dump;
-	hlist_add_head_rcu(&t->hlist, &dn_fib_table_hash[h]);
-
-	return t;
-}
-
-struct dn_fib_table *dn_fib_empty_table(void)
-{
-	u32 id;
-
-	for(id = RT_TABLE_MIN; id <= RT_TABLE_MAX; id++)
-		if (dn_fib_get_table(id, 0) == NULL)
-			return dn_fib_get_table(id, 1);
-	return NULL;
-}
-
-void dn_fib_flush(void)
-{
-	int flushed = 0;
-	struct dn_fib_table *tb;
-	unsigned int h;
-
-	for (h = 0; h < DN_FIB_TABLE_HASHSZ; h++) {
-		hlist_for_each_entry(tb, &dn_fib_table_hash[h], hlist)
-			flushed += tb->flush(tb);
-	}
-
-	if (flushed)
-		dn_rt_cache_flush(-1);
-}
-
-void __init dn_fib_table_init(void)
-{
-	dn_hash_kmem = kmem_cache_create("dn_fib_info_cache",
-					sizeof(struct dn_fib_info),
-					0, SLAB_HWCACHE_ALIGN,
-					NULL);
-}
-
-void __exit dn_fib_table_cleanup(void)
-{
-	struct dn_fib_table *t;
-	struct hlist_node *next;
-	unsigned int h;
-
-	write_lock(&dn_fib_tables_lock);
-	for (h = 0; h < DN_FIB_TABLE_HASHSZ; h++) {
-		hlist_for_each_entry_safe(t, next, &dn_fib_table_hash[h],
-					  hlist) {
-			hlist_del(&t->hlist);
-			kfree(t);
-		}
-	}
-	write_unlock(&dn_fib_tables_lock);
-}
diff --git a/net/decnet/dn_timer.c b/net/decnet/dn_timer.c
deleted file mode 100644
index aa4155875ca8..000000000000
--- a/net/decnet/dn_timer.c
+++ /dev/null
@@ -1,104 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * DECnet       An implementation of the DECnet protocol suite for the LINUX
- *              operating system.  DECnet is implemented using the  BSD Socket
- *              interface as the means of communication with the user level.
- *
- *              DECnet Socket Timer Functions
- *
- * Author:      Steve Whitehouse <SteveW@ACM.org>
- *
- *
- * Changes:
- *       Steve Whitehouse      : Made keepalive timer part of the same
- *                               timer idea.
- *       Steve Whitehouse      : Added checks for sk->sock_readers
- *       David S. Miller       : New socket locking
- *       Steve Whitehouse      : Timer grabs socket ref.
- */
-#include <linux/net.h>
-#include <linux/socket.h>
-#include <linux/skbuff.h>
-#include <linux/netdevice.h>
-#include <linux/timer.h>
-#include <linux/spinlock.h>
-#include <net/sock.h>
-#include <linux/atomic.h>
-#include <linux/jiffies.h>
-#include <net/flow.h>
-#include <net/dn.h>
-
-/*
- * Slow timer is for everything else (n * 500mS)
- */
-
-#define SLOW_INTERVAL (HZ/2)
-
-static void dn_slow_timer(struct timer_list *t);
-
-void dn_start_slow_timer(struct sock *sk)
-{
-	timer_setup(&sk->sk_timer, dn_slow_timer, 0);
-	sk_reset_timer(sk, &sk->sk_timer, jiffies + SLOW_INTERVAL);
-}
-
-void dn_stop_slow_timer(struct sock *sk)
-{
-	sk_stop_timer(sk, &sk->sk_timer);
-}
-
-static void dn_slow_timer(struct timer_list *t)
-{
-	struct sock *sk = from_timer(sk, t, sk_timer);
-	struct dn_scp *scp = DN_SK(sk);
-
-	bh_lock_sock(sk);
-
-	if (sock_owned_by_user(sk)) {
-		sk_reset_timer(sk, &sk->sk_timer, jiffies + HZ / 10);
-		goto out;
-	}
-
-	/*
-	 * The persist timer is the standard slow timer used for retransmits
-	 * in both connection establishment and disconnection as well as
-	 * in the RUN state. The different states are catered for by changing
-	 * the function pointer in the socket. Setting the timer to a value
-	 * of zero turns it off. We allow the persist_fxn to turn the
-	 * timer off in a permant way by returning non-zero, so that
-	 * timer based routines may remove sockets. This is why we have a
-	 * sock_hold()/sock_put() around the timer to prevent the socket
-	 * going away in the middle.
-	 */
-	if (scp->persist && scp->persist_fxn) {
-		if (scp->persist <= SLOW_INTERVAL) {
-			scp->persist = 0;
-
-			if (scp->persist_fxn(sk))
-				goto out;
-		} else {
-			scp->persist -= SLOW_INTERVAL;
-		}
-	}
-
-	/*
-	 * Check for keepalive timeout. After the other timer 'cos if
-	 * the previous timer caused a retransmit, we don't need to
-	 * do this. scp->stamp is the last time that we sent a packet.
-	 * The keepalive function sends a link service packet to the
-	 * other end. If it remains unacknowledged, the standard
-	 * socket timers will eventually shut the socket down. Each
-	 * time we do this, scp->stamp will be updated, thus
-	 * we won't try and send another until scp->keepalive has passed
-	 * since the last successful transmission.
-	 */
-	if (scp->keepalive && scp->keepalive_fxn && (scp->state == DN_RUN)) {
-		if (time_after_eq(jiffies, scp->stamp + scp->keepalive))
-			scp->keepalive_fxn(sk);
-	}
-
-	sk_reset_timer(sk, &sk->sk_timer, jiffies + SLOW_INTERVAL);
-out:
-	bh_unlock_sock(sk);
-	sock_put(sk);
-}
diff --git a/net/decnet/netfilter/Kconfig b/net/decnet/netfilter/Kconfig
deleted file mode 100644
index 14ec4ef95fab..000000000000
--- a/net/decnet/netfilter/Kconfig
+++ /dev/null
@@ -1,17 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# DECnet netfilter configuration
-#
-
-menu "DECnet: Netfilter Configuration"
-	depends on DECNET && NETFILTER
-	depends on NETFILTER_ADVANCED
-
-config DECNET_NF_GRABULATOR
-	tristate "Routing message grabulator (for userland routing daemon)"
-	help
-	  Enable this module if you want to use the userland DECnet routing
-	  daemon. You will also need to enable routing support for DECnet
-	  unless you just want to monitor routing messages from other nodes.
-
-endmenu
diff --git a/net/decnet/netfilter/Makefile b/net/decnet/netfilter/Makefile
deleted file mode 100644
index 429c84289d0f..000000000000
--- a/net/decnet/netfilter/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for DECnet netfilter modules
-#
-
-obj-$(CONFIG_DECNET_NF_GRABULATOR) += dn_rtmsg.o
diff --git a/net/decnet/netfilter/dn_rtmsg.c b/net/decnet/netfilter/dn_rtmsg.c
deleted file mode 100644
index 26a9193df783..000000000000
--- a/net/decnet/netfilter/dn_rtmsg.c
+++ /dev/null
@@ -1,158 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * DECnet       An implementation of the DECnet protocol suite for the LINUX
- *              operating system.  DECnet is implemented using the  BSD Socket
- *              interface as the means of communication with the user level.
- *
- *              DECnet Routing Message Grabulator
- *
- *              (C) 2000 ChyGwyn Limited  -  https://www.chygwyn.com/
- *
- * Author:      Steven Whitehouse <steve@chygwyn.com>
- */
-#include <linux/module.h>
-#include <linux/skbuff.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/netdevice.h>
-#include <linux/netfilter.h>
-#include <linux/spinlock.h>
-#include <net/netlink.h>
-#include <linux/netfilter_decnet.h>
-
-#include <net/sock.h>
-#include <net/flow.h>
-#include <net/dn.h>
-#include <net/dn_route.h>
-
-static struct sock *dnrmg = NULL;
-
-
-static struct sk_buff *dnrmg_build_message(struct sk_buff *rt_skb, int *errp)
-{
-	struct sk_buff *skb = NULL;
-	size_t size;
-	sk_buff_data_t old_tail;
-	struct nlmsghdr *nlh;
-	unsigned char *ptr;
-	struct nf_dn_rtmsg *rtm;
-
-	size = NLMSG_ALIGN(rt_skb->len) +
-	       NLMSG_ALIGN(sizeof(struct nf_dn_rtmsg));
-	skb = nlmsg_new(size, GFP_ATOMIC);
-	if (!skb) {
-		*errp = -ENOMEM;
-		return NULL;
-	}
-	old_tail = skb->tail;
-	nlh = nlmsg_put(skb, 0, 0, 0, size, 0);
-	if (!nlh) {
-		kfree_skb(skb);
-		*errp = -ENOMEM;
-		return NULL;
-	}
-	rtm = (struct nf_dn_rtmsg *)nlmsg_data(nlh);
-	rtm->nfdn_ifindex = rt_skb->dev->ifindex;
-	ptr = NFDN_RTMSG(rtm);
-	skb_copy_from_linear_data(rt_skb, ptr, rt_skb->len);
-	nlh->nlmsg_len = skb->tail - old_tail;
-	return skb;
-}
-
-static void dnrmg_send_peer(struct sk_buff *skb)
-{
-	struct sk_buff *skb2;
-	int status = 0;
-	int group = 0;
-	unsigned char flags = *skb->data;
-
-	switch (flags & DN_RT_CNTL_MSK) {
-	case DN_RT_PKT_L1RT:
-		group = DNRNG_NLGRP_L1;
-		break;
-	case DN_RT_PKT_L2RT:
-		group = DNRNG_NLGRP_L2;
-		break;
-	default:
-		return;
-	}
-
-	skb2 = dnrmg_build_message(skb, &status);
-	if (skb2 == NULL)
-		return;
-	NETLINK_CB(skb2).dst_group = group;
-	netlink_broadcast(dnrmg, skb2, 0, group, GFP_ATOMIC);
-}
-
-
-static unsigned int dnrmg_hook(void *priv,
-			struct sk_buff *skb,
-			const struct nf_hook_state *state)
-{
-	dnrmg_send_peer(skb);
-	return NF_ACCEPT;
-}
-
-
-#define RCV_SKB_FAIL(err) do { netlink_ack(skb, nlh, (err), NULL); return; } while (0)
-
-static inline void dnrmg_receive_user_skb(struct sk_buff *skb)
-{
-	struct nlmsghdr *nlh = nlmsg_hdr(skb);
-
-	if (skb->len < sizeof(*nlh) ||
-	    nlh->nlmsg_len < sizeof(*nlh) ||
-	    skb->len < nlh->nlmsg_len)
-		return;
-
-	if (!netlink_capable(skb, CAP_NET_ADMIN))
-		RCV_SKB_FAIL(-EPERM);
-
-	/* Eventually we might send routing messages too */
-
-	RCV_SKB_FAIL(-EINVAL);
-}
-
-static const struct nf_hook_ops dnrmg_ops = {
-	.hook		= dnrmg_hook,
-	.pf		= NFPROTO_DECNET,
-	.hooknum	= NF_DN_ROUTE,
-	.priority	= NF_DN_PRI_DNRTMSG,
-};
-
-static int __init dn_rtmsg_init(void)
-{
-	int rv = 0;
-	struct netlink_kernel_cfg cfg = {
-		.groups	= DNRNG_NLGRP_MAX,
-		.input	= dnrmg_receive_user_skb,
-	};
-
-	dnrmg = netlink_kernel_create(&init_net, NETLINK_DNRTMSG, &cfg);
-	if (dnrmg == NULL) {
-		printk(KERN_ERR "dn_rtmsg: Cannot create netlink socket");
-		return -ENOMEM;
-	}
-
-	rv = nf_register_net_hook(&init_net, &dnrmg_ops);
-	if (rv) {
-		netlink_kernel_release(dnrmg);
-	}
-
-	return rv;
-}
-
-static void __exit dn_rtmsg_fini(void)
-{
-	nf_unregister_net_hook(&init_net, &dnrmg_ops);
-	netlink_kernel_release(dnrmg);
-}
-
-
-MODULE_DESCRIPTION("DECnet Routing Message Grabulator");
-MODULE_AUTHOR("Steven Whitehouse <steve@chygwyn.com>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_NET_PF_PROTO(PF_NETLINK, NETLINK_DNRTMSG);
-
-module_init(dn_rtmsg_init);
-module_exit(dn_rtmsg_fini);
diff --git a/net/decnet/sysctl_net_decnet.c b/net/decnet/sysctl_net_decnet.c
deleted file mode 100644
index 67b5ab2657b7..000000000000
--- a/net/decnet/sysctl_net_decnet.c
+++ /dev/null
@@ -1,362 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * DECnet       An implementation of the DECnet protocol suite for the LINUX
- *              operating system.  DECnet is implemented using the  BSD Socket
- *              interface as the means of communication with the user level.
- *
- *              DECnet sysctl support functions
- *
- * Author:      Steve Whitehouse <SteveW@ACM.org>
- *
- *
- * Changes:
- * Steve Whitehouse - C99 changes and default device handling
- * Steve Whitehouse - Memory buffer settings, like the tcp ones
- *
- */
-#include <linux/mm.h>
-#include <linux/sysctl.h>
-#include <linux/fs.h>
-#include <linux/netdevice.h>
-#include <linux/string.h>
-#include <net/neighbour.h>
-#include <net/dst.h>
-#include <net/flow.h>
-
-#include <linux/uaccess.h>
-
-#include <net/dn.h>
-#include <net/dn_dev.h>
-#include <net/dn_route.h>
-
-
-int decnet_debug_level;
-int decnet_time_wait = 30;
-int decnet_dn_count = 1;
-int decnet_di_count = 3;
-int decnet_dr_count = 3;
-int decnet_log_martians = 1;
-int decnet_no_fc_max_cwnd = NSP_MIN_WINDOW;
-
-/* Reasonable defaults, I hope, based on tcp's defaults */
-long sysctl_decnet_mem[3] = { 768 << 3, 1024 << 3, 1536 << 3 };
-int sysctl_decnet_wmem[3] = { 4 * 1024, 16 * 1024, 128 * 1024 };
-int sysctl_decnet_rmem[3] = { 4 * 1024, 87380, 87380 * 2 };
-
-#ifdef CONFIG_SYSCTL
-extern int decnet_dst_gc_interval;
-static int min_decnet_time_wait[] = { 5 };
-static int max_decnet_time_wait[] = { 600 };
-static int min_state_count[] = { 1 };
-static int max_state_count[] = { NSP_MAXRXTSHIFT };
-static int min_decnet_dst_gc_interval[] = { 1 };
-static int max_decnet_dst_gc_interval[] = { 60 };
-static int min_decnet_no_fc_max_cwnd[] = { NSP_MIN_WINDOW };
-static int max_decnet_no_fc_max_cwnd[] = { NSP_MAX_WINDOW };
-static char node_name[7] = "???";
-
-static struct ctl_table_header *dn_table_header = NULL;
-
-/*
- * ctype.h :-)
- */
-#define ISNUM(x) (((x) >= '0') && ((x) <= '9'))
-#define ISLOWER(x) (((x) >= 'a') && ((x) <= 'z'))
-#define ISUPPER(x) (((x) >= 'A') && ((x) <= 'Z'))
-#define ISALPHA(x) (ISLOWER(x) || ISUPPER(x))
-#define INVALID_END_CHAR(x) (ISNUM(x) || ISALPHA(x))
-
-static void strip_it(char *str)
-{
-	for(;;) {
-		switch (*str) {
-		case ' ':
-		case '\n':
-		case '\r':
-		case ':':
-			*str = 0;
-			fallthrough;
-		case 0:
-			return;
-		}
-		str++;
-	}
-}
-
-/*
- * Simple routine to parse an ascii DECnet address
- * into a network order address.
- */
-static int parse_addr(__le16 *addr, char *str)
-{
-	__u16 area, node;
-
-	while(*str && !ISNUM(*str)) str++;
-
-	if (*str == 0)
-		return -1;
-
-	area = (*str++ - '0');
-	if (ISNUM(*str)) {
-		area *= 10;
-		area += (*str++ - '0');
-	}
-
-	if (*str++ != '.')
-		return -1;
-
-	if (!ISNUM(*str))
-		return -1;
-
-	node = *str++ - '0';
-	if (ISNUM(*str)) {
-		node *= 10;
-		node += (*str++ - '0');
-	}
-	if (ISNUM(*str)) {
-		node *= 10;
-		node += (*str++ - '0');
-	}
-	if (ISNUM(*str)) {
-		node *= 10;
-		node += (*str++ - '0');
-	}
-
-	if ((node > 1023) || (area > 63))
-		return -1;
-
-	if (INVALID_END_CHAR(*str))
-		return -1;
-
-	*addr = cpu_to_le16((area << 10) | node);
-
-	return 0;
-}
-
-static int dn_node_address_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
-{
-	char addr[DN_ASCBUF_LEN];
-	size_t len;
-	__le16 dnaddr;
-
-	if (!*lenp || (*ppos && !write)) {
-		*lenp = 0;
-		return 0;
-	}
-
-	if (write) {
-		len = (*lenp < DN_ASCBUF_LEN) ? *lenp : (DN_ASCBUF_LEN-1);
-		memcpy(addr, buffer, len);
-		addr[len] = 0;
-		strip_it(addr);
-
-		if (parse_addr(&dnaddr, addr))
-			return -EINVAL;
-
-		dn_dev_devices_off();
-
-		decnet_address = dnaddr;
-
-		dn_dev_devices_on();
-
-		*ppos += len;
-
-		return 0;
-	}
-
-	dn_addr2asc(le16_to_cpu(decnet_address), addr);
-	len = strlen(addr);
-	addr[len++] = '\n';
-
-	if (len > *lenp)
-		len = *lenp;
-	memcpy(buffer, addr, len);
-	*lenp = len;
-	*ppos += len;
-
-	return 0;
-}
-
-static int dn_def_dev_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
-{
-	size_t len;
-	struct net_device *dev;
-	char devname[17];
-
-	if (!*lenp || (*ppos && !write)) {
-		*lenp = 0;
-		return 0;
-	}
-
-	if (write) {
-		if (*lenp > 16)
-			return -E2BIG;
-
-		memcpy(devname, buffer, *lenp);
-		devname[*lenp] = 0;
-		strip_it(devname);
-
-		dev = dev_get_by_name(&init_net, devname);
-		if (dev == NULL)
-			return -ENODEV;
-
-		if (dev->dn_ptr == NULL) {
-			dev_put(dev);
-			return -ENODEV;
-		}
-
-		if (dn_dev_set_default(dev, 1)) {
-			dev_put(dev);
-			return -ENODEV;
-		}
-		*ppos += *lenp;
-
-		return 0;
-	}
-
-	dev = dn_dev_get_default();
-	if (dev == NULL) {
-		*lenp = 0;
-		return 0;
-	}
-
-	strcpy(devname, dev->name);
-	dev_put(dev);
-	len = strlen(devname);
-	devname[len++] = '\n';
-
-	if (len > *lenp) len = *lenp;
-
-	memcpy(buffer, devname, len);
-	*lenp = len;
-	*ppos += len;
-
-	return 0;
-}
-
-static struct ctl_table dn_table[] = {
-	{
-		.procname = "node_address",
-		.maxlen = 7,
-		.mode = 0644,
-		.proc_handler = dn_node_address_handler,
-	},
-	{
-		.procname = "node_name",
-		.data = node_name,
-		.maxlen = 7,
-		.mode = 0644,
-		.proc_handler = proc_dostring,
-	},
-	{
-		.procname = "default_device",
-		.maxlen = 16,
-		.mode = 0644,
-		.proc_handler = dn_def_dev_handler,
-	},
-	{
-		.procname = "time_wait",
-		.data = &decnet_time_wait,
-		.maxlen = sizeof(int),
-		.mode = 0644,
-		.proc_handler = proc_dointvec_minmax,
-		.extra1 = &min_decnet_time_wait,
-		.extra2 = &max_decnet_time_wait
-	},
-	{
-		.procname = "dn_count",
-		.data = &decnet_dn_count,
-		.maxlen = sizeof(int),
-		.mode = 0644,
-		.proc_handler = proc_dointvec_minmax,
-		.extra1 = &min_state_count,
-		.extra2 = &max_state_count
-	},
-	{
-		.procname = "di_count",
-		.data = &decnet_di_count,
-		.maxlen = sizeof(int),
-		.mode = 0644,
-		.proc_handler = proc_dointvec_minmax,
-		.extra1 = &min_state_count,
-		.extra2 = &max_state_count
-	},
-	{
-		.procname = "dr_count",
-		.data = &decnet_dr_count,
-		.maxlen = sizeof(int),
-		.mode = 0644,
-		.proc_handler = proc_dointvec_minmax,
-		.extra1 = &min_state_count,
-		.extra2 = &max_state_count
-	},
-	{
-		.procname = "dst_gc_interval",
-		.data = &decnet_dst_gc_interval,
-		.maxlen = sizeof(int),
-		.mode = 0644,
-		.proc_handler = proc_dointvec_minmax,
-		.extra1 = &min_decnet_dst_gc_interval,
-		.extra2 = &max_decnet_dst_gc_interval
-	},
-	{
-		.procname = "no_fc_max_cwnd",
-		.data = &decnet_no_fc_max_cwnd,
-		.maxlen = sizeof(int),
-		.mode = 0644,
-		.proc_handler = proc_dointvec_minmax,
-		.extra1 = &min_decnet_no_fc_max_cwnd,
-		.extra2 = &max_decnet_no_fc_max_cwnd
-	},
-       {
-		.procname = "decnet_mem",
-		.data = &sysctl_decnet_mem,
-		.maxlen = sizeof(sysctl_decnet_mem),
-		.mode = 0644,
-		.proc_handler = proc_doulongvec_minmax
-	},
-	{
-		.procname = "decnet_rmem",
-		.data = &sysctl_decnet_rmem,
-		.maxlen = sizeof(sysctl_decnet_rmem),
-		.mode = 0644,
-		.proc_handler = proc_dointvec,
-	},
-	{
-		.procname = "decnet_wmem",
-		.data = &sysctl_decnet_wmem,
-		.maxlen = sizeof(sysctl_decnet_wmem),
-		.mode = 0644,
-		.proc_handler = proc_dointvec,
-	},
-	{
-		.procname = "debug",
-		.data = &decnet_debug_level,
-		.maxlen = sizeof(int),
-		.mode = 0644,
-		.proc_handler = proc_dointvec,
-	},
-	{ }
-};
-
-void dn_register_sysctl(void)
-{
-	dn_table_header = register_net_sysctl(&init_net, "net/decnet", dn_table);
-}
-
-void dn_unregister_sysctl(void)
-{
-	unregister_net_sysctl_table(dn_table_header);
-}
-
-#else  /* CONFIG_SYSCTL */
-void dn_unregister_sysctl(void)
-{
-}
-void dn_register_sysctl(void)
-{
-}
-
-#endif
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 6ac88fe24a8e..7fab29f3ce6e 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -96,7 +96,8 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	addr_type = ipv6_addr_type(daddr);
 	if ((__ipv6_addr_needs_scope_id(addr_type) && !oif) ||
 	    (addr_type & IPV6_ADDR_MAPPED) ||
-	    (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if))
+	    (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if &&
+	     l3mdev_master_ifindex_by_index(sock_net(sk), oif) != sk->sk_bound_dev_if))
 		return -EINVAL;
 
 	/* TODO: use ip6_datagram_send_ctl to get options from cmsg */
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 5b7578adbf0f..d0c7c396ba71 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -300,12 +300,6 @@ nf_hook_entry_head(struct net *net, int pf, unsigned int hooknum,
 		if (WARN_ON_ONCE(ARRAY_SIZE(net->nf.hooks_ipv6) <= hooknum))
 			return NULL;
 		return net->nf.hooks_ipv6 + hooknum;
-#if IS_ENABLED(CONFIG_DECNET)
-	case NFPROTO_DECNET:
-		if (WARN_ON_ONCE(ARRAY_SIZE(net->nf.hooks_decnet) <= hooknum))
-			return NULL;
-		return net->nf.hooks_decnet + hooknum;
-#endif
 	default:
 		WARN_ON_ONCE(1);
 		return NULL;
@@ -724,10 +718,6 @@ static int __net_init netfilter_net_init(struct net *net)
 #ifdef CONFIG_NETFILTER_FAMILY_BRIDGE
 	__netfilter_net_init(net->nf.hooks_bridge, ARRAY_SIZE(net->nf.hooks_bridge));
 #endif
-#if IS_ENABLED(CONFIG_DECNET)
-	__netfilter_net_init(net->nf.hooks_decnet, ARRAY_SIZE(net->nf.hooks_decnet));
-#endif
-
 #ifdef CONFIG_PROC_FS
 	net->nf.proc_netfilter = proc_net_mkdir(net, "netfilter",
 						net->proc_net);
diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index edf386a020b9..bec9ac8b8fbe 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -473,7 +473,8 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
 			 * processed, this avoids that the same error is
 			 * reported several times when replaying the batch.
 			 */
-			if (nfnl_err_add(&err_list, nlh, err, &extack) < 0) {
+			if (err == -ENOMEM ||
+			    nfnl_err_add(&err_list, nlh, err, &extack) < 0) {
 				/* We failed to enqueue an error, reset the
 				 * list of errors and send OOM to userspace
 				 * pointing to the batch header.
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index befe42aad04b..beedd0d2b509 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -533,8 +533,8 @@ static void __tcf_chain_put(struct tcf_chain *chain, bool by_act,
 {
 	struct tcf_block *block = chain->block;
 	const struct tcf_proto_ops *tmplt_ops;
+	unsigned int refcnt, non_act_refcnt;
 	bool free_block = false;
-	unsigned int refcnt;
 	void *tmplt_priv;
 
 	mutex_lock(&block->lock);
@@ -554,13 +554,15 @@ static void __tcf_chain_put(struct tcf_chain *chain, bool by_act,
 	 * save these to temporary variables.
 	 */
 	refcnt = --chain->refcnt;
+	non_act_refcnt = refcnt - chain->action_refcnt;
 	tmplt_ops = chain->tmplt_ops;
 	tmplt_priv = chain->tmplt_priv;
 
-	/* The last dropped non-action reference will trigger notification. */
-	if (refcnt - chain->action_refcnt == 0 && !by_act) {
-		tc_chain_notify_delete(tmplt_ops, tmplt_priv, chain->index,
-				       block, NULL, 0, 0, false);
+	if (non_act_refcnt == chain->explicitly_created && !by_act) {
+		if (non_act_refcnt == 0)
+			tc_chain_notify_delete(tmplt_ops, tmplt_priv,
+					       chain->index, block, NULL, 0, 0,
+					       false);
 		/* Last reference to chain, no need to lock. */
 		chain->flushing = false;
 	}
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index da042bc8b239..1ac8ff445a6d 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -716,12 +716,18 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 			 struct nlattr *est, bool ovr,
 			 struct netlink_ext_ack *extack)
 {
-	int err;
+	int err, ifindex = -1;
 
 	err = tcf_exts_validate(net, tp, tb, est, &n->exts, ovr, true, extack);
 	if (err < 0)
 		return err;
 
+	if (tb[TCA_U32_INDEV]) {
+		ifindex = tcf_change_indev(net, tb[TCA_U32_INDEV], extack);
+		if (ifindex < 0)
+			return -EINVAL;
+	}
+
 	if (tb[TCA_U32_LINK]) {
 		u32 handle = nla_get_u32(tb[TCA_U32_LINK]);
 		struct tc_u_hnode *ht_down = NULL, *ht_old;
@@ -756,13 +762,9 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 		tcf_bind_filter(tp, &n->res, base);
 	}
 
-	if (tb[TCA_U32_INDEV]) {
-		int ret;
-		ret = tcf_change_indev(net, tb[TCA_U32_INDEV], extack);
-		if (ret < 0)
-			return -EINVAL;
-		n->ifindex = ret;
-	}
+	if (ifindex >= 0)
+		n->ifindex = ifindex;
+
 	return 0;
 }
 
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index ee0b2b03657c..1e82c51657a7 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -4379,7 +4379,7 @@ enum sctp_disposition sctp_sf_eat_auth(struct net *net,
 				    SCTP_AUTH_NEW_KEY, GFP_ATOMIC);
 
 		if (!ev)
-			return -ENOMEM;
+			return SCTP_DISPOSITION_NOMEM;
 
 		sctp_add_cmd_sf(commands, SCTP_CMD_EVENT_ULP,
 				SCTP_ULPEVENT(ev));
diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 91e678fa3feb..df6aba2246fa 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -1242,7 +1242,7 @@ int tipc_nl_media_get(struct sk_buff *skb, struct genl_info *info)
 	struct tipc_nl_msg msg;
 	struct tipc_media *media;
 	struct sk_buff *rep;
-	struct nlattr *attrs[TIPC_NLA_BEARER_MAX + 1];
+	struct nlattr *attrs[TIPC_NLA_MEDIA_MAX + 1];
 
 	if (!info->attrs[TIPC_NLA_MEDIA])
 		return -EINVAL;
@@ -1291,7 +1291,7 @@ int __tipc_nl_media_set(struct sk_buff *skb, struct genl_info *info)
 	int err;
 	char *name;
 	struct tipc_media *m;
-	struct nlattr *attrs[TIPC_NLA_BEARER_MAX + 1];
+	struct nlattr *attrs[TIPC_NLA_MEDIA_MAX + 1];
 
 	if (!info->attrs[TIPC_NLA_MEDIA])
 		return -EINVAL;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8a42262dd7fa..7d6a36b647a7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11199,6 +11199,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1b0a, 0x01b8, "ACER Veriton", ALC662_FIXUP_ACER_VERITON),
 	SND_PCI_QUIRK(0x1b35, 0x1234, "CZC ET26", ALC662_FIXUP_CZC_ET26),
 	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
+	SND_PCI_QUIRK(0x1c6c, 0x1239, "Compaq N14JP6-V2", ALC897_FIXUP_HP_HSMIC_VERB),
 
 #if 0
 	/* Below is a quirk table taken from the old code.
diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 5469399abcb4..8e58347dabe8 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -183,30 +183,6 @@ static void i2s_stop(struct dw_i2s_dev *dev,
 	}
 }
 
-static int dw_i2s_startup(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *cpu_dai)
-{
-	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
-	union dw_i2s_snd_dma_data *dma_data = NULL;
-
-	if (!(dev->capability & DWC_I2S_RECORD) &&
-			(substream->stream == SNDRV_PCM_STREAM_CAPTURE))
-		return -EINVAL;
-
-	if (!(dev->capability & DWC_I2S_PLAY) &&
-			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK))
-		return -EINVAL;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_data = &dev->play_dma_data;
-	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		dma_data = &dev->capture_dma_data;
-
-	snd_soc_dai_set_dma_data(cpu_dai, substream, (void *)dma_data);
-
-	return 0;
-}
-
 static void dw_i2s_config(struct dw_i2s_dev *dev, int stream)
 {
 	u32 ch_reg;
@@ -305,12 +281,6 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static void dw_i2s_shutdown(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *dai)
-{
-	snd_soc_dai_set_dma_data(dai, substream, NULL);
-}
-
 static int dw_i2s_prepare(struct snd_pcm_substream *substream,
 			  struct snd_soc_dai *dai)
 {
@@ -382,8 +352,6 @@ static int dw_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 }
 
 static const struct snd_soc_dai_ops dw_i2s_dai_ops = {
-	.startup	= dw_i2s_startup,
-	.shutdown	= dw_i2s_shutdown,
 	.hw_params	= dw_i2s_hw_params,
 	.prepare	= dw_i2s_prepare,
 	.trigger	= dw_i2s_trigger,
@@ -624,6 +592,14 @@ static int dw_configure_dai_by_dt(struct dw_i2s_dev *dev,
 
 }
 
+static int dw_i2s_dai_probe(struct snd_soc_dai *dai)
+{
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_init_dma_data(dai, &dev->play_dma_data, &dev->capture_dma_data);
+	return 0;
+}
+
 static int dw_i2s_probe(struct platform_device *pdev)
 {
 	const struct i2s_platform_data *pdata = pdev->dev.platform_data;
@@ -642,6 +618,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dw_i2s_dai->ops = &dw_i2s_dai_ops;
+	dw_i2s_dai->probe = dw_i2s_dai_probe;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dev->i2s_base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index fb874f924bbe..e52c030bd17a 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2332,6 +2332,9 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
 			continue;
 
+		if (!snd_soc_dpcm_can_be_prepared(fe, be, stream))
+			continue;
+
 		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND) &&
@@ -2972,3 +2975,20 @@ int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 	return snd_soc_dpcm_check_state(fe, be, stream, state, ARRAY_SIZE(state));
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_params);
+
+/*
+ * We can only prepare a BE DAI if any of it's FE are not prepared,
+ * running or paused for the specified stream direction.
+ */
+int snd_soc_dpcm_can_be_prepared(struct snd_soc_pcm_runtime *fe,
+				 struct snd_soc_pcm_runtime *be, int stream)
+{
+	const enum snd_soc_dpcm_state state[] = {
+		SND_SOC_DPCM_STATE_START,
+		SND_SOC_DPCM_STATE_PAUSED,
+		SND_SOC_DPCM_STATE_PREPARE,
+	};
+
+	return snd_soc_dpcm_check_state(fe, be, stream, state, ARRAY_SIZE(state));
+}
+EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_prepared);
diff --git a/tools/gpio/lsgpio.c b/tools/gpio/lsgpio.c
index 5a05a454d0c9..85a2aa292f5d 100644
--- a/tools/gpio/lsgpio.c
+++ b/tools/gpio/lsgpio.c
@@ -90,7 +90,7 @@ static void print_attributes(struct gpio_v2_line_info *info)
 	for (i = 0; i < info->num_attrs; i++) {
 		if (info->attrs[i].id == GPIO_V2_LINE_ATTR_ID_DEBOUNCE)
 			fprintf(stdout, ", debounce_period=%dusec",
-				info->attrs[0].debounce_period_us);
+				info->attrs[i].debounce_period_us);
 	}
 }
 
diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index f7911aaeb007..aa474febb471 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -492,11 +492,11 @@ int main(int argc, char *argv[])
 			interval = t2 - t1;
 			offset = (t2 + t1) / 2 - tp;
 
-			printf("system time: %lld.%u\n",
+			printf("system time: %lld.%09u\n",
 				(pct+2*i)->sec, (pct+2*i)->nsec);
-			printf("phc    time: %lld.%u\n",
+			printf("phc    time: %lld.%09u\n",
 				(pct+2*i+1)->sec, (pct+2*i+1)->nsec);
-			printf("system time: %lld.%u\n",
+			printf("system time: %lld.%09u\n",
 				(pct+2*i+2)->sec, (pct+2*i+2)->nsec);
 			printf("system/phc clock time offset is %" PRId64 " ns\n"
 			       "system     clock time delay  is %" PRId64 " ns\n",
