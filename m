Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22F571094D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbjEYJz4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 May 2023 05:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbjEYJzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:55:53 -0400
Received: from mail6.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E6EE7;
        Thu, 25 May 2023 02:55:51 -0700 (PDT)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 1E4782229AC;
        Thu, 25 May 2023 11:55:50 +0200 (CEST)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 13087220D9B;
        Thu, 25 May 2023 11:55:50 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx.dmz.swissbit.com [10.181.10.103])
        by mail6.swissbit.com (Postfix) with ESMTPS;
        Thu, 25 May 2023 11:55:50 +0200 (CEST)
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCHv2 0/2] mmc: block: ioctl: Enhance userspace err-checking
Thread-Topic: [PATCHv2 0/2] mmc: block: ioctl: Enhance userspace err-checking
Thread-Index: AdmO7mibZ40MpwCrTAyP3SbyU0LCTQ==
Date:   Thu, 25 May 2023 09:55:47 +0000
Message-ID: <92013b1430374efd84828f467cd64017@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27648.006
X-TMASE-Result: 10--5.681900-10.000000
X-TMASE-MatchedRID: 8xV9Hp+2OHIx0Ef1LOCr0ENF5tKVli5K0NnUUVMlTKYli8Y5a0svLwoO
        Pjrr9EUjy5mHbqk+bZO46fDNSVBzTaGDMgFJdihf+LfLuKfgdOBPnKxAOPp4WTd4L/plQfz0j3d
        ZSyALReJzNhvK4/9wOg0wwSAB0/Gt7c0is1Jg1Fc6N/cDgNNi4Xdtc9b/HMCuzf+duMCJLEyE3Q
        pvaMjVSYspy5fJnP2k+YJ8C27gzimmg8dBfLCnVyBpp+DpTrQjDjwwT0r6EXRShcWO/83xoj88n
        yn5HOwB3xN6jyfnVfp+ZLbS08T2S4cWjt28Nz4w9k0tWBWiOf+ZmLDnd2pI3xSgk4EVhbwmfr0m
        qpu8k1/i8zVgXoAltjrm2CwlZwVRIAcCikR3vq+K4yGkVExDUCp/hk68F/GCxbbdqRLCU9qvWgg
        wXn7XqpxaTGG+kiW4
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 2a153936-2aae-43ca-8f11-0cef0494ce0d-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enhances the ioctl path so that userspace callers are
able to reliably check all error bits for their operation.

The current implementation poses the problem of error bits which
the caller cannot check, this is potentially a security issue.

If the phrase security issue has woken you up, but you haven't been using:
mmc-utils sanitize
mmc-utils erase secure-trim{1|2}
mmc-utils secure-erase
mmc-utils rpmb write-block
you can go back to sleep, sorry to bother you.
If you have, you are probably still fine, if there was no active
attacker sabotaging your eMMC, the secure operation probably
succeeded.
There is just no way to confirm that it actually has.

Examples include e.g. a flash-fail of the eMMC.
Card behavior differs here, R1 bit 19 could be set,
many cards will just shut off on flash-fail, so if you want to play
with this patch I would suggest aiming for WP_ERASE_SKIP,
although that technically doesn't need the patch, as WP groups could
be queried before and after erase.

sudo ./mmc writeprotect user set temp 0x0 $(($(blockdev --getsz /dev/mmcblk2))) /dev/mmcblk2
sudo ./mmc erase secure-erase 0 $(($(blockdev --getsz /dev/mmcblk2)-1)) /dev/mmcblk2

will yield

Executing Secure Erase from 0x00000000 to 0x0773ffff
High Capacity Erase Unit Size=524288 bytes
High Capacity Erase Timeout=600 ms
High Capacity Write Protect Group Size=2097152 bytes
RSP0: 0x00008900 # added by author, this is what the patch will add to RSP0
 Secure Erase Succeed!

even though no erase is issued.

v2:
- removed extra flag and made it default behavior for write or R1B
- aggregate error flag in resp[0] instead of abusing resp[1]
- avoid open loop busy polling and reuse __mmc_poll_for_busy

Christian Loehle (2):
  mmc: block: ioctl: do write error check for spi
  mmc: block: ioctl: Add PROG-error aggregation

 drivers/mmc/core/block.c   | 23 ++++++++++++-----------
 drivers/mmc/core/mmc_ops.c | 25 ++++++++++++++++++++++++-
 drivers/mmc/core/mmc_ops.h |  3 +++
 3 files changed, 39 insertions(+), 12 deletions(-)

-- 
2.37.3


Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

