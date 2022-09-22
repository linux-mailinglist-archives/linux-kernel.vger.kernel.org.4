Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240355E6152
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiIVLkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIVLkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:40:10 -0400
X-Greylist: delayed 442 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Sep 2022 04:40:07 PDT
Received: from smtp-out.xnet.cz (smtp-out.xnet.cz [178.217.244.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4313796A1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:40:07 -0700 (PDT)
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id 82EF818878;
        Thu, 22 Sep 2022 13:32:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=true.cz; s=xnet;
        t=1663846363; bh=dyFs+ziM8uDY0R3f2ueo4RCrj2lCmCsMBiBeN+xFTfs=;
        h=Date:From:To:Cc:Subject:Reply-To;
        b=H4V5lMN9ekH+80kn4j+ND311olRdGOftlcoK6ZIgfzmXmEoXUw9SVdGpuSw3AuE9H
         8q/w28VklfC2FPhL0sPmh4oFg8uxbfBFd1Z+FkHkuI7rcSznPOTyqW9ByFKdTXOXrY
         Eq4lbD6mwn3/4evg3xPRtC/zuxpe0w4+YvPmP1hM=
Received: from localhost (meh.true.cz [local])
        by meh.true.cz (OpenSMTPD) with ESMTPA id d44b4f97;
        Thu, 22 Sep 2022 13:32:17 +0200 (CEST)
Date:   Thu, 22 Sep 2022 13:32:17 +0200
From:   Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
To:     linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, yury.norov@gmail.com, rafael@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: aarch64 5.15.68 regression in topology/thread_siblings (huge file
 size and no content)
Message-ID: <20220922113217.GA90426@meh.true.cz>
Reply-To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEXHASH_WORD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we've got a recent bug report[1], that lscpu segfaults on aarch64 board running
5.15.y kernel. It is working fine on 5.10.y kernel. 

I've tracked it down[2] to the issue with `topology/thread_siblings` which
apart from very strange file size returns empty content. I assume, that it's
somehow related to the changes done in commit bb9ec13d156e ("topology: use
bin_attribute to break the size limitation of cpumap ABI"), but I didn't tried
to revert it yet to verify it.

Kernel 5.15.68:

  root@OpenWrt:/# uname -a
  Linux OpenWrt 5.15.68 #0 SMP Wed Sep 21 05:54:21 2022 aarch64 GNU/Linux

  root@OpenWrt:/# find /sys -name thread_siblings -exec ls -al {} \;
  -r--r--r--    1 root     root     18446744073709551615 Sep 22 08:37 /sys/devices/system/cpu/cpu1/topology/thread_siblings
  -r--r--r--    1 root     root     18446744073709551615 Sep 22 08:37 /sys/devices/system/cpu/cpu0/topology/thread_siblings

  root@OpenWrt:/# find /sys -name thread_siblings -exec cat {} \;
  root@OpenWrt:/# 

Kernel 5.10.138:

  root@OpenWrt:/# uname -a
  Linux OpenWrt 5.10.138 #0 SMP Sat Sep 3 02:55:34 2022 aarch64 GNU/Linux

  root@OpenWrt:/# find /sys -name thread_siblings -exec cat {} \;
  2
  1

  root@OpenWrt:/# find /sys -name thread_siblings -exec ls -al {} \;
  -r--r--r--    1 root     root          4096 Sep 22 11:12 /sys/devices/system/cpu/cpu1/topology/thread_siblings
  -r--r--r--    1 root     root          4096 Sep 22 11:12 /sys/devices/system/cpu/cpu0/topology/thread_siblings


1. https://github.com/openwrt/openwrt/issues/10737
2. https://github.com/util-linux/util-linux/pull/1821


Cheers,

Petr
