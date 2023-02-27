Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7226A3FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjB0KqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjB0KqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:46:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28A9BDDE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677494764; x=1709030764;
  h=to:from:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=JNCJdXmUt5QrVsAJ2cAWfkAWV3SnbvwBp1uegGqt178=;
  b=C/1CaE/mSzMNqQtDJkpMwK7V9V9XTuByvAAlz+CZkGrCyGMW6tjeNe74
   GR1Ul+B/JB2l75FfQ+c83ykiEvIHyA8asm9bPo1VfVCpFfCQ9LwjiF/nI
   UsbdfvsTTDfZeCnxh6VbvZaJTsKPJH98KZHY4u2Ty/V2RohHHvXo/FVvI
   +1Hs1D8idMgd+EhgAOj+wlK343t+gi5be2RXJgqUXXmfYD3O9axdiTctu
   u/bUWu3EvsU3VM4WXhYW5OBNRb7Q9dvmTsVoj8xWbd65C1gXkxwlgC2yE
   SZ4NxFrajz0fyUFAbWuLUDQ4P59g30INBDWiv0om2gy6Y9kjb7ajxPd23
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="314255709"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="314255709"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 02:46:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="762655709"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="762655709"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.139]) ([10.238.232.139])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Feb 2023 02:46:02 -0800
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        johan+linaro@kernel.org, hsinyi@chromium.org, maz@kernel.org
From:   Bingbu Cao <bingbu.cao@linux.intel.com>
Subject: System boot failure related to commit 'irqdomain: Switch to
 per-domain locking'
Message-ID: <d2290916-f78c-4b0a-d706-0955ae0aa4ff@linux.intel.com>
Date:   Mon, 27 Feb 2023 18:46:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Johan and Zyngier, 

I am using a Dell XPS laptop(Intel Processor) just update my
Linux kernel to latest tag 6.2.0, and then I see that the kernel
cannot boot successfully, it reported:
--------------------------------------------
Gave up waiting for root file system device. Common problems:
 - Boot args (cat /proc/cmdline)
   - Check rootdelay= (did the system wait long enough?)
 - Missing modules (cat /proc/modules; ls /dev)

ALERT! UUID=xxxxxxx does not exist. Dropping to shell!
--------------------------------------------

And then it drop into initramfs shell, I try to use 'blkid' to
get block devices information, but it showed nothing.

I also tried add 'rootdelay' and 'rootwait' in bootargs, but it did
not work.

I am sure that my previous kernel 6.2.0-rc4 work normally, so I
did some bisect and found the commit below cause the failure on
my system:

9dbb8e3452ab irqdomain: Switch to per-domain locking

I really have no idea why it cause my problem, but I see just
reverting this commit really help me.

Do you have any idea?



-- 
Best regards,
Bingbu Cao
