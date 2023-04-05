Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23E86D7C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbjDEL5V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Apr 2023 07:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjDEL5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:57:20 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DB03C0E;
        Wed,  5 Apr 2023 04:57:18 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 77FCC3A2A47;
        Wed,  5 Apr 2023 13:57:16 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 6AFD13A2A3E;
        Wed,  5 Apr 2023 13:57:16 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Wed,  5 Apr 2023 13:57:16 +0200 (CEST)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Avri Altman <avri.altman@wdc.com>
Subject: [RFC][PATCH 0/3] mmc: block: ioctl: Enhance userspace err-checking
Thread-Topic: [RFC][PATCH 0/3] mmc: block: ioctl: Enhance userspace
 err-checking
Thread-Index: AdlntVwS+89diB7ATPqDW+FoRq4nTA==
Date:   Wed, 5 Apr 2023 11:57:15 +0000
Message-ID: <20620b972fe448f381c3d585a1ae4730@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27546.007
X-TMASE-Result: 10--13.709100-10.000000
X-TMASE-MatchedRID: 9M69yBZ2Ml5rFdvBEmTnvNFJ92mNllHuNZEftOVQtYaNJ2ckLRg2UQwb
        B6fWQkqsTqoWkhFw+fLQyMBx6JGg+jwdmyX2g5Xwyn0GCvk40qG3ClSK/bUMDS196sn93sBvSGk
        gWW9laDWkV52mAIXFpWWFV9BfSfALYY3ozW+EngeHZXNSWjgdU9UEOicf335W2gjng2FkAcSsto
        QvCgKRixAhHOhMv3S3hK7o2WR9HX/3LKKZvqYslN9JA2lmQRNUI64EUz6lBajmNEV/m/YJp2Jjg
        9GXn3itOelJXrqHws2o+6444pTvToYM3GbKHhDEtPYfgFJ3kY/UoMiU4Mi75bt/YafNBu9cBBYt
        pm0LkTaEkt/L8HtAJ29yZj3aufb5aDAi8sBNMoELbigRnpKlKSPzRlrdFGDwSxtfyX5OOjJxtiO
        pYBUzOaXBlbe9D52tjo/Zlyf+Px1t6nh0ne7HIQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 0a493fbb-c613-4b78-9116-e512e20b84da-0-0-200-0
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
RSP0: 0x00000800 # added by author, this is what the patch will add
RSP1: 0x00008f40 # added by author, this is what the patch will add
 Secure Erase Succeed!

even though no erase is issued.

Why is it RFC?
setting BIT(31) of write_flag is of course hacky, would like your
comments on that. The post-PROG errors are only relevant for
either writes or SWITCH and ERASE, so operations without data,
it can safely be abused.
Similarly saving the errors in response[1] is also a bit hacky,
I personally like it a bit better for the userspace caller to
be able to distinguish immediate errors and X errors.
Just putting everything in response[0] would of course work, too.

1/3 and 2/3 are fine from my end.

Christian Loehle (3):
  mmc: block: ioctl: define rpmb reliable flag
  mmc: block: ioctl: do write error check for spi
  mmc: block: ioctl: Add error aggregation flag

 drivers/mmc/core/block.c       | 48 ++++++++++++++++++++++++++++++----
 include/uapi/linux/mmc/ioctl.h |  3 +++
 2 files changed, 46 insertions(+), 5 deletions(-)

-- 
2.37.3


Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

