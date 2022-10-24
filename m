Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9FE60B3DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiJXRSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiJXRSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:18:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BF524F38;
        Mon, 24 Oct 2022 08:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666626796; x=1698162796;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version;
  bh=Rls8J96H7XPdBkD3rN2hn7TWvGSMihVkayjTqyB85l8=;
  b=Vk9+sZJuuWT/r4iqTa3YJvUJHyKeIhhjrGdQcWCE6hs5EI54GkZ9oTa7
   9RBazbzvCb6BKn7OkMWS7vmlavJRQHkldFNK+QwJCSyD3Qim8x69YF4GO
   /yp575RQp8RnkfewllMbStYVYihwF5tjJEjtBy+GOFdLUGqdrjj4lzVUB
   voUF0Hgyv/y/KxlsA6vm0Mn/yHp7NriKRqOhzh+miU+2c9RUMxFAxprCH
   g/T+knBtyFFQcPE5FeZg6Vk9zpNVDSkT2nt+alxPAKA94uDO9LSmP9j7s
   OrefTpG9YYFnVBy4G4xtDwwujW2R8Over2bWAM6anyIa6hBln0pin6sij
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="393771000"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="diff'?scan'208";a="393771000"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:51:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="694600516"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="diff'?scan'208";a="694600516"
Received: from reillyco-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.251.8.109])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:51:39 -0700
Message-ID: <9ef3674afd370050b86a68e44c97e4f0257f1adf.camel@linux.intel.com>
Subject: Re: BUG: bisected: thermald regression (MEMLEAK) in commit
 c7ff29763989bd09c433f73fae3c1e1c15d9cda4
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net
Cc:     regressions@lists.linux.dev, regressions@leemhuis.info,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>, devel@acpica.org
Date:   Mon, 24 Oct 2022 08:51:38 -0700
In-Reply-To: <e0f06714-5a49-a4e6-24e6-c4103c820819@alu.unizg.hr>
References: <e0f06714-5a49-a4e6-24e6-c4103c820819@alu.unizg.hr>
Content-Type: multipart/mixed; boundary="=-gQpjfCtEWz61D1kobzBy"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gQpjfCtEWz61D1kobzBy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Mirsad,

Thanks for the bisect.

On Mon, 2022-10-24 at 15:13 +0200, Mirsad Goran Todorovac wrote:
> Dear all,
> 
> Around Sep 27th 2022 I've noticed in a mainline kernel built with 
> CONFIG_DEBUG_KMEMLEAK=y
> that there actually is a leak:
> 
> > sudo cat /sys/kernel/debug/kmemleak unreferenced object 
> 0xffff8881095f3ee0 (size 80): comm "thermald", pid 837, jiffies 
> 4294896698 (age 9867.428s) hex dump (first 32 bytes): 00 00 00 00 00
> 00 
> 00 00 0d 01 2d 00 00 00 00 00 ..........-..... af 07 01 00 00 c9 ff
> ff 
> 00 00 00 00 00 00 00 00 ................ backtrace:
> [<00000000b50b9dd6>] 
> kmem_cache_alloc+0x184/0x380 [<00000000fa8428c0>] 
> acpi_os_acquire_object+0x2c/0x32 [<000000002cc0099f>] 
> acpi_ps_alloc_op+0x65/0xe6 [<00000000335faf1b>] 
> acpi_ps_get_next_arg+0x842/0x9ed [<000000007afa2dee>] 
> acpi_ps_parse_loop+0x718/0xee1 [<0000000010ce490e>] 
> acpi_ps_parse_aml+0x261/0x7b2 [<00000000278d4c5f>] 
> acpi_ps_execute_method+0x360/0x459 [<00000000ff7ad4ba>] 
> acpi_ns_evaluate+0x595/0x810 [<0000000037ce3488>] 
> acpi_evaluate_object+0x28b/0x5b2 [<000000001a800bbf>] 
> acpi_run_osc+0x209/0x3d0 [<00000000776fbd43>] 
> int3400_thermal_run_osc+0xed/0x180 [int3400_thermal] 
> [<00000000d6ec2302>] current_uuid_store+0x17c/0x1d0 [int3400_thermal]
> [<00000000486cf3e6>] dev_attr_store+0x3e/0x60 [<00000000bf193027>] 
> sysfs_kf_write+0x88/0xa0 [<00000000820b5cce>] 
> kernfs_fop_write_iter+0x1c9/0x270 [<0000000062f8d35e>] 
> vfs_write+0x5a5/0x750 Mr. Pandruvada required a bug bisect from me,
> so I 
> have eventually made one. # first bad commit: 
> [c7ff29763989bd09c433f73fae3c1e1c15d9cda4] thermal: int340x: Update
> OS 

This will say this patch as this patch is calling acpi_run_osc in
response to thermald calls for the first time.

But looking at code, this is freeing the memory allocated by
acpi_run_osc() call chain as any other caller.

	status = acpi_run_osc(handle, &context);
	if (ACPI_SUCCESS(status)) {
		ret = *((u32 *)(context.ret.pointer + 4));
		if (ret != *enable)
			result = -EPERM;

		kfree(context.ret.pointer);
	} else
		result = -EPERM;

There is no kfree when call failed as at other places.
I think you are failing, you can search for "_OSC" in dmesg.
On some Dell systems this OSC setting fails because of some BIOS issue.
May be you are hitting that case.
Just for the sake of test, please apply the diff and see if the issue
is gone.

Thanks,
Srinivas

> policy capability handshake Here is the git bisect log: 
> mtodorov@domac:~/linux/kernel/linux_stable$ git bisect log git bisect
> start # good: [b6abb62daa5511c4a3eaa30cbdb02544d1f10fa2] Linux 5.15.1
> git bisect good b6abb62daa5511c4a3eaa30cbdb02544d1f10fa2 # bad: 
> [e6f4ff3f91251f67b130c29f38673eb5702f88b9] Linux 6.0.3 git bisect bad
> e6f4ff3f91251f67b130c29f38673eb5702f88b9 # good: 
> [8bb7eca972ad531c9b149c0a51ab43a417385813] Linux 5.15 git bisect good
> 8bb7eca972ad531c9b149c0a51ab43a417385813 # bad: 
> [1464677662943738741500a6f16b85d36bbde2be] Merge tag 
> 'platform-drivers-x86-v5.18-1' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-
> x86 
> git bisect bad 1464677662943738741500a6f16b85d36bbde2be # good: 
> [8efd0d9c316af470377894a6a0f9ff63ce18c177] Merge tag '5.17-net-next'
> of 
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next git
> bisect 
> good 8efd0d9c316af470377894a6a0f9ff63ce18c177 # good: 
> [aaa25a2fa7964d94690f6de5edd7164ca7d76555] Merge 
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net git bisect
> good 
> aaa25a2fa7964d94690f6de5edd7164ca7d76555 # bad: 
> [b4bc93bd76d4da32600795cd323c971f00a2e788] Merge tag 'arm-drivers-
> 5.18' 
> of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc git bisect
> bad 
> b4bc93bd76d4da32600795cd323c971f00a2e788 # bad: 
> [ef510682af3dbe2f9cdae7126a1461c94e010967] Merge tag 'f2fs-for-5.18'
> of 
> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs git bisect
> bad ef510682af3dbe2f9cdae7126a1461c94e010967 # good: 
> [a04b1bf574e1f4875ea91f5c62ca051666443200] Merge tag 'for-
> 5.18/parisc-1' 
> of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
> git 
> bisect good a04b1bf574e1f4875ea91f5c62ca051666443200 # bad: 
> [b080cee72ef355669cbc52ff55dc513d37433600] Merge tag 
> 'for-5.18/io_uring-statx-2022-03-18' of git://git.kernel.dk/linux-
> block 
> git bisect bad b080cee72ef355669cbc52ff55dc513d37433600 # good: 
> [02b82b02c34321dde10d003aafcd831a769b2a8a] Merge tag 'pm-5.18-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm git
> bisect 
> good 02b82b02c34321dde10d003aafcd831a769b2a8a # good: 
> [0e03b8fd29363f2df44e2a7a176d486de550757a] crypto: xilinx - Turn SHA 
> into a tristate and allow COMPILE_TEST git bisect good 
> 0e03b8fd29363f2df44e2a7a176d486de550757a # good: 
> [3e504d2026eb6c8762cd6040ae57db166516824a] random: check for signal
> and 
> try earlier when generating entropy git bisect good 
> 3e504d2026eb6c8762cd6040ae57db166516824a # good: 
> [5e929367468c8f97cd1ffb0417316cecfebef94b] io_uring: terminate manual
> loop iterator loop correctly for non-vecs git bisect good 
> 5e929367468c8f97cd1ffb0417316cecfebef94b # bad: 
> [2d6fc1455f3f383499e013ebc4b19ff49c53c15e] Merge branches 
> 'thermal-powerclamp', 'thermal-int340x' and 'thermal-docs' git bisect
> bad 2d6fc1455f3f383499e013ebc4b19ff49c53c15e # good: 
> [1d6aab36a26ba44b114d7f8a857c430c9e0c32c9] 
> thermal/drivers/ti-soc-thermal: Remove unused function 
> ti_thermal_get_temp() git bisect good 
> 1d6aab36a26ba44b114d7f8a857c430c9e0c32c9 # bad: 
> [c7ff29763989bd09c433f73fae3c1e1c15d9cda4] thermal: int340x: Update
> OS 
> policy capability handshake git bisect bad 
> c7ff29763989bd09c433f73fae3c1e1c15d9cda4 # good: 
> [098c874e20be2a4cee3021aa9b3485ed5e1f4d5b] thermal: Replace 
> acpi_bus_get_device() git bisect good 
> 098c874e20be2a4cee3021aa9b3485ed5e1f4d5b # good: 
> [668f69a5f863b877bc3ae129efe9a80b6f055141] thermal: int340x: Increase
> bitmap size git bisect good 668f69a5f863b877bc3ae129efe9a80b6f055141
> # 
> first bad commit: [c7ff29763989bd09c433f73fae3c1e1c15d9cda4] thermal:
> int340x: Update OS policy capability handshake You have new mail in 
> /var/mail/mtodorov mtodorov@domac:~/linux/kernel/linux_stable$ I was 
> unable to locate the culprit in the patch myself. Thank you very much
> for your attention. I am available for all further questions. Have a 
> nice day :) Regards, |
> 


--=-gQpjfCtEWz61D1kobzBy
Content-Disposition: attachment; filename="free_on_fail.diff"
Content-Type: text/x-patch; name="free_on_fail.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvaW50MzQw
MF90aGVybWFsLmMgYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL2ludDM0
MDBfdGhlcm1hbC5jCmluZGV4IGRiOGE2ZjYzNjU3ZC4uNjNkODMxM2I1Y2RkIDEwMDY0NAotLS0g
YS9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL2ludDM0MDBfdGhlcm1hbC5j
CisrKyBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvaW50MzQwMF90aGVy
bWFsLmMKQEAgLTE3OCw2ICsxNzgsNyBAQCBzdGF0aWMgaW50IGludDM0MDBfdGhlcm1hbF9ydW5f
b3NjKGFjcGlfaGFuZGxlIGhhbmRsZSwgY2hhciAqdXVpZF9zdHIsIGludCAqZW5hYgogCWJ1ZltP
U0NfUVVFUllfRFdPUkRdID0gMDsKIAlidWZbT1NDX1NVUFBPUlRfRFdPUkRdID0gKmVuYWJsZTsK
IAorCWNvbnRleHQucmV0LnBvaW50ZXIgPSBOVUxMOwogCXN0YXR1cyA9IGFjcGlfcnVuX29zYyho
YW5kbGUsICZjb250ZXh0KTsKIAlpZiAoQUNQSV9TVUNDRVNTKHN0YXR1cykpIHsKIAkJcmV0ID0g
KigodTMyICopKGNvbnRleHQucmV0LnBvaW50ZXIgKyA0KSk7CkBAIC0xODUsOCArMTg2LDExIEBA
IHN0YXRpYyBpbnQgaW50MzQwMF90aGVybWFsX3J1bl9vc2MoYWNwaV9oYW5kbGUgaGFuZGxlLCBj
aGFyICp1dWlkX3N0ciwgaW50ICplbmFiCiAJCQlyZXN1bHQgPSAtRVBFUk07CiAKIAkJa2ZyZWUo
Y29udGV4dC5yZXQucG9pbnRlcik7Ci0JfSBlbHNlCisJfSBlbHNlIHsKKwkJaWYgKGNvbnRleHQu
cmV0LnBvaW50ZXIpCisJCQlrZnJlZShjb250ZXh0LnJldC5wb2ludGVyKTsKIAkJcmVzdWx0ID0g
LUVQRVJNOworCX0KIAogCXJldHVybiByZXN1bHQ7CiB9Cg==


--=-gQpjfCtEWz61D1kobzBy--
