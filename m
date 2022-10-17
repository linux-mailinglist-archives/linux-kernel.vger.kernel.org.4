Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A891C601CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiJQW7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiJQW6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:58:54 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243CC80BC0;
        Mon, 17 Oct 2022 15:58:44 -0700 (PDT)
Message-ID: <8fc1f232-9330-859f-4480-dd9a27b8bd15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666047522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A+2vfJ5v01L1EAzUizAeP+/6SKNvz5vZIp2b7n6zRls=;
        b=opTCC1h6c620PMTc33+vv76O9g3EBwiFCt7u6ceewCCocoCJUqFl8cr7LZuAiua/52Q3bt
        VJ0ODsjXJvttWTtxNvlRNe1d+afalmEbrZjUnI2DMAn04XtuVWKP7a8NdaQpWappuePQ/F
        ZIulJ7Fps5wc+0S5UypGHQ6QbmSSYtI=
Date:   Mon, 17 Oct 2022 16:58:39 -0600
MIME-Version: 1.0
Subject: Re: [md/bitmap] 935dbb156b: mdadm-selftests.05r1-bitmapfile.fail
Content-Language: en-US
To:     kernel test robot <yujie.liu@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        jonathan.derrick@solidigm.com, jonathanx.sk.derrick@intel.com
References: <202210101104.c8df42d2-yujie.liu@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <202210101104.c8df42d2-yujie.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think some of these are invalid, see below

On 10/9/2022 10:32 PM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 935dbb156b7a46615c0c4819ded5f5ef14bf9b99 ("[PATCH 1/2] md/bitmap: Move unplug to daemon thread")
> url: https://github.com/intel-lab-lkp/linux/commits/Jonathan-Derrick/Bitmap-percentage-flushing/20221007-061054
> base: git://git.kernel.org/cgit/linux/kernel/git/song/md.git md-next
> patch link: https://lore.kernel.org/linux-raid/20221006220840.275-3-jonathan.derrick@linux.dev
> 
> in testcase: mdadm-selftests
> version: mdadm-selftests-x86_64-5f41845-1_20220826
> with following parameters:
> 
> 	disk: 1HDD
> 	test_prefix: 05
> 
> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GHz (Haswell) with 16G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 2022-10-10 02:47:33 mkdir -p /var/tmp
> 2022-10-10 02:47:33 mke2fs -t ext3 -b 4096 -J size=4 -q /dev/sda1
> 2022-10-10 02:48:06 mount -t ext3 /dev/sda1 /var/tmp
> sed -e 's/{DEFAULT_METADATA}/1.2/g' \
> -e 's,{MAP_PATH},/run/mdadm/map,g'  mdadm.8.in > mdadm.8
> /usr/bin/install -D -m 644 mdadm.8 /usr/share/man/man8/mdadm.8
> /usr/bin/install -D -m 644 mdmon.8 /usr/share/man/man8/mdmon.8
> /usr/bin/install -D -m 644 md.4 /usr/share/man/man4/md.4
> /usr/bin/install -D -m 644 mdadm.conf.5 /usr/share/man/man5/mdadm.conf.5
> /usr/bin/install -D -m 644 udev-md-raid-creating.rules /lib/udev/rules.d/01-md-raid-creating.rules
> /usr/bin/install -D -m 644 udev-md-raid-arrays.rules /lib/udev/rules.d/63-md-raid-arrays.rules
> /usr/bin/install -D -m 644 udev-md-raid-assembly.rules /lib/udev/rules.d/64-md-raid-assembly.rules
> /usr/bin/install -D -m 644 udev-md-clustered-confirm-device.rules /lib/udev/rules.d/69-md-clustered-confirm-device.rules
> /usr/bin/install -D  -m 755 mdadm /sbin/mdadm
> /usr/bin/install -D  -m 755 mdmon /sbin/mdmon
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-add-internalbitmap... succeeded
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-add-internalbitmap-v1a... succeeded
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-add-internalbitmap-v1b... succeeded
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-add-internalbitmap-v1c... succeeded
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-bitmapfile... FAILED - see /var/tmp/05r1-bitmapfile.log and /var/tmp/fail05r1-bitmapfile.log for details

This one in particular is designed to set failure if 0 bits are dirty after a resync, followed by testdev.
Running this on a vanilla kernel results in below failure:
+++ mdadm -X /var/tmp/bitmap
+++ rm -f /var/tmp/stderr
+++ sed -n -e 's/.*Bitmap.* \([0-9]*\) dirty.*/\1/p'
+++ case $* in
+++ case $* in
+++ /home/nodlab/mdadm/mdadm --quiet -X /var/tmp/bitmap
+++ rv=0
+++ case $* in
+++ cat /var/tmp/stderr
+++ return 0
++ dirty2=0
++ '[' 0 -lt 400 -o 0 -ne 0 ']'
++ echo 'ERROR bad '\''dirty'\'' counts: 0 and 0'
ERROR bad 'dirty' counts: 0 and 0


Where the exit check is:
mdadm --assemble $md0 --bitmap=$bmf $dev1 $dev2
testdev $md0 1 $mdsize1a 64
dirty1=`mdadm -X $bmf | sed -n -e 's/.*Bitmap.* \([0-9]*\) dirty.*/\1/p'`
sleep 4
dirty2=`mdadm -X $bmf | sed -n -e 's/.*Bitmap.* \([0-9]*\) dirty.*/\1/p'`

if [ $dirty1 -lt 400 -o $dirty2 -ne 0 ]
then  echo >&2 "ERROR bad 'dirty' counts: $dirty1 and $dirty2"
  exit 1


Seems like if 'testdev()' is quick enough, $dirty1 could be < 400


> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-failfast... succeeded
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-grow-external... FAILED - see /var/tmp/05r1-grow-external.log and /var/tmp/fail05r1-grow-external.log for details
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-grow-internal... FAILED - see /var/tmp/05r1-grow-internal.log and /var/tmp/fail05r1-grow-internal.log for details
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-grow-internal-1... FAILED - see /var/tmp/05r1-grow-internal-1.log and /var/tmp/fail05r1-grow-internal-1.log for details
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-internalbitmap... FAILED - see /var/tmp/05r1-internalbitmap.log and /var/tmp/fail05r1-internalbitmap.log for details
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-internalbitmap-v1a... FAILED - see /var/tmp/05r1-internalbitmap-v1a.log and /var/tmp/fail05r1-internalbitmap-v1a.log for details
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-internalbitmap-v1b... FAILED - see /var/tmp/05r1-internalbitmap-v1b.log and /var/tmp/fail05r1-internalbitmap-v1b.log for details
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-internalbitmap-v1c... FAILED - see /var/tmp/05r1-internalbitmap-v1c.log and /var/tmp/fail05r1-internalbitmap-v1c.log for details
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-n3-bitmapfile... FAILED - see /var/tmp/05r1-n3-bitmapfile.log and /var/tmp/fail05r1-n3-bitmapfile.log for details
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-re-add... succeeded
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-re-add-nosuper... succeeded
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-remove-internalbitmap... succeeded
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-remove-internalbitmap-v1a... succeeded
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-remove-internalbitmap-v1b... succeeded
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r1-remove-internalbitmap-v1c... succeeded
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r5-bitmapfile... succeeded
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r5-internalbitmap... succeeded
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r6-bitmapfile... succeeded
> Testing on linux-6.0.0-rc2-00101-g935dbb156b7a kernel
> /lkp/benchmarks/mdadm-selftests/tests/05r6tor0... 
> 	ERROR: dmesg prints errors when testing 05r6tor0! 
> 
> FAILED - see /var/tmp/05r6tor0.log and /var/tmp/fail05r6tor0.log for details
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/r/202210101104.c8df42d2-yujie.liu@intel.com
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
