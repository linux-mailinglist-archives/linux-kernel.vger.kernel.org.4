Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C656B40AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCJNoE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 08:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCJNoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:44:01 -0500
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D9277E07;
        Fri, 10 Mar 2023 05:43:58 -0800 (PST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 079703A2B24;
        Fri, 10 Mar 2023 14:43:52 +0100 (CET)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id EEE1C3A2B1F;
        Fri, 10 Mar 2023 14:43:51 +0100 (CET)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Fri, 10 Mar 2023 14:43:51 +0100 (CET)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Thread-Topic: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Thread-Index: AQHZTRVhGw7IamWdbkW+N3YLAv3UBK70EaAw
Date:   Fri, 10 Mar 2023 13:43:50 +0000
Message-ID: <54cee7de4ab7479db74b21e64e5f53cf@hyperstone.com>
References: <20230302144330.274947-1-ulf.hansson@linaro.org>
In-Reply-To: <20230302144330.274947-1-ulf.hansson@linaro.org>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27494.007
X-TMASE-Result: 10--15.961800-10.000000
X-TMASE-MatchedRID: 0aps3uOmWi7UL3YCMmnG4rqQyAveNtg6OyEDKyNnz+8/gf7afIrQUxiQ
        n63S7zCUOelg+pLqPPFjHpk2g6Yfbmk5Fql3Faa7PMcAlOC0qrDhx1VJT84rPWjliw+xvItdXH3
        W+57nGflI/gFRC4jJyCcntLVR9yI1xONdUAdRajMR3SGennXG69FBNyU0Q3FE7zyq0taM3pg8Uy
        YxPpz6Nj+Ok6f9gUlFzhQxGE0nTV42KFyqcyHlTZ4CIKY/Hg3AY2fxc+IAshspZfPxcZsT/Cq2r
        l3dzGQ18DFFIBzQ4Q0i4mJ41W/O+n7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 6faa3291-c63b-4be6-97a1-769330bd3ce7-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have benchmarked the FUA/Cache behavior a bit.
I don't have an actual filesystem benchmark that does what I wanted and is easy to port to the target so I used:

# call with
# for loop in {1..3}; do sudo dd if=/dev/urandom bs=1M of=/dev/mmcblk2; done; for loop in {1..5}; do time ./filesystembenchmark.sh; umount /mnt; done
mkfs.ext4 -F /dev/mmcblk2
mount /dev/mmcblk2 /mnt
for i in {1..3}
do
cp -r linux-6.2.2 /mnt/$i
done
for i in {1..3}
do
rm -r /mnt/$i
done
for i in {1..3}
do
cp -r linux-6.2.2 /mnt/$i
done


I found a couple of DUTs that I can link, I also tested one industrial card.

DUT1: blue PCB Foresee eMMC
https://pine64.com/product/32gb-emmc-module/
DUT2: green PCB SiliconGo eMMC
Couldn't find that one online anymore unfortunately
DUT3: orange hardkernel PCB 8GB
https://www.hardkernel.com/shop/8gb-emmc-module-c2-android/
DUT4: orange hardkernel PCB white dot
https://rlx.sk/en/odroid/3198-16gb-emmc-50-module-xu3-android-for-odroid-xu3.html
DUT5: Industrial card


The test issued 461 DO_REL_WR during one of the iterations for DUT5

DUT1:
Cache, no FUA:
13:04.49
13:13.82
13:30.59
13:28:13
13:20:64
FUA:
13:30.32
13:36.26
13:10.86
13:32.52
13:48.59

DUT2:
FUA:
8:11.24
7:47.73
7:48.00
7:48.18
7:47.38
Cache, no FUA:
8:10.30
7:48.97
7:48.47
7:47.93
7:44.18

DUT3:
Cache, no FUA:
7:02.82
6:58.94
7:03.20
7:00.27
7:00.88
FUA:
7:05.43
7:03.44
7:04.82
7:03.26
7:04.74

DUT4:
FUA:
7:23.92
7:20.15
7:20.52
7:19.10
7:20.71
Cache, no FUA:
7:20.23
7:20.48
7:19.94
7:18.90
7:19.88

Cache, no FUA:
7:19.36
7:02.11
7:01.53
7:01.35
7:00.37
Cache, no FUA CQE:
7:17.55
7:00.73
6:59.25
6:58.44
6:58.60
FUA:
7:15.10
6:58.99
6:58.94
6:59.17
6:60.00
FUA CQE:
7:11.03
6:58.04
6:56.89
6:56.43
6:56:28

If anyone has any comments or disagrees with the benchmark, or has a specific eMMC to test, let me know.

Regards,
Christian

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

