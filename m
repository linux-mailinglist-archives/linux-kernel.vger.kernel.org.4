Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F6B6B3FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCJM7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCJM7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:59:02 -0500
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40B719AA33
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vVoAd
        X3nmACP2Ulg1inXvuGW4GEDrpSpJWyYzxaspDI=; b=DN3m8xjuyl2txy76OvVL3
        TLVy2Z3iH8ME4aQMcLbJGw3gOGkkrX6xTRlyIQ+ciOLWrPAaBZ3kS7X0ZC/ajvAc
        8yIZdcTwE8jTM56z3XULXzo9ytMaYOpW2GPvLCS6YNpfqQmLX8bbq5lE3pY5kUS9
        X9RcKEh3jyzyQvYKB63oYI=
Received: from localhost.localdomain (unknown [113.91.40.179])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wCXkMpSKQtkhEUMAA--.19459S2;
        Fri, 10 Mar 2023 20:57:55 +0800 (CST)
From:   Xujun Leng <lengxujun2007@126.com>
To:     gregkh@linuxfoundation.org
Cc:     lengxujun2007@126.com, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH] driver core: platform: added arguments check for platform_device_add_resources()
Date:   Fri, 10 Mar 2023 20:57:51 +0800
Message-Id: <20230310125751.29529-1-lengxujun2007@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZArha1XDXWV1QVIz@kroah.com>
References: <ZArha1XDXWV1QVIz@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXkMpSKQtkhEUMAA--.19459S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF1ktF13ZF4ruw1xAFWkZwb_yoWfJr1fpF
        WagFW3KF48Wr17tw48Xw1UAF1vyFy2y3WYgry3Aw1a9a90q34qyF18trWUJr1DArW8Z3W3
        tw4jgr40yF1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piFks9UUUUU=
X-Originating-IP: [113.91.40.179]
X-CM-SenderInfo: pohqw5hxmx0jqqqxqiyswou0bp/1tbikhMud1pEJ0sC7AAAsE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Mar 10, 2023 at 02:55:46PM +0800, Xujun Leng wrote:
> > > On Tue, Mar 07, 2023 at 01:01:16PM +0800, Xujun Leng wrote:
> > > > In the follow two cases, platform_device_add_resources() can lead an
> > > > invalid address access:
> > > > 1) If (!res && num > 0), pdev->resource will be set to NULL but
> > > >    pdev->num_resources > 0, then a later platform_get_resource() will
> > > >    cause invalid address access.
> > > > 2) If (res && num == 0), because num == 0 cause kmalloc_slab() returns
> > > >    ZERO_SIZE_PTR, then kmemdup() will copy data to the invalid address
> > > >    ZERO_SIZE_PTR.

The 2) is wrong, the copy count is zero, so no data will copy to the source
address ZERO_SIZE_PTR.

> > > > 
> > > > Signed-off-by: Xujun Leng <lengxujun2007@126.com>
> > > > ---
> > > >  drivers/base/platform.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > > > index 77510e4f47de..a060941c3076 100644
> > > > --- a/drivers/base/platform.c
> > > > +++ b/drivers/base/platform.c
> > > > @@ -606,6 +606,9 @@ int platform_device_add_resources(struct platform_device *pdev,
> > > >  {
> > > >  	struct resource *r = NULL;
> > > >  
> > > > +	if ((!res && num > 0) || (res && num == 0))
> > > > +		return -EINVAL;
> > > 
> > > What driver is causing this check to fail today?  Shouldn't that be
> > > fixed instead?
> > 
> > Ok, I got it. It's the caller's responsibility to take care about that.
> 
> Maybe, I don't know, which is why I am asking what driver is triggering
> this kind of failure.  Can you point me at one that causes this so we
> can see if this is something that a driver should be catching before it
> calls this, or if it is something that this core function should catch
> instead?

I didn't find actual driver triggered this kind of failure. I triggered the
problem in scenario "1) If (!res && num > 0) ..." with the following code:

	#include <linux/module.h>
	#include <linux/platform_device.h>
	#include <linux/mod_devicetable.h> /* why ??? */
	#include <linux/printk.h>

	static int test_case;

	module_param(test_case, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);

	static int pdev_test_probe(struct platform_device *pdev)
	{
		struct resource *res;
		
		printk(KERN_INFO "%s enter...\n", __func__);
		
		/*
		 * It's doesn't matter what the type argument passed to 
		 * the function is, pointer dereference fault always occur.
		 */
		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
		if (res) {
			printk(KERN_ERR "get device resoure failed\n");
			return -EFAULT;
		}

		printk(KERN_INFO "%s exited.\n", __func__);
		
		return 0;
	}

	static const struct platform_device_id pdev_ids[] = {
		{ .name = "pdev_test", }, 
		{ }
	};
	MODULE_DEVICE_TABLE(platform, pdev_ids);

	static struct platform_device pdev_test = {
		.name = "pdev_test", 
	};

	static struct platform_driver pdev_test_drv = {
		.probe = pdev_test_probe,
		.id_table = pdev_ids, 
		.driver = {
			.name = "pdev_test", 
		},
	};

	static int __init pdev_res_api_test_init(void)
	{
		int ret;
		
		printk(KERN_ERR "test case: %d\n", test_case);
		
		ret = platform_device_register(&pdev_test);
		if (ret) {
			printk(KERN_ERR "platform_device_add failed, ret = %d\n", ret);
			put_device(&pdev_test.dev);
			goto error_out;
		}
		get_device(&pdev_test.dev);
		
		/*
		 * Calls platform_device_add_resources() with incorrect input parameter, 
		 * but platform_device_add_resources() still returns a value 0 indicating 
		 * that no error occurred. 
		 */
		if (test_case == 0) {
			ret = platform_device_add_resources(&pdev_test, NULL, 3);
		} else if (test_case == 1) {
			struct resource res = {0,}; /* nothing is important */
			ret = platform_device_add_resources(&pdev_test, &res, 0);
		} else {
			printk(KERN_ERR "invalid test case %d\n", test_case);
			ret = -EINVAL;
			goto pdev_unreg;
		}
		if (ret) {
			printk(KERN_ERR "platform_device_add_resources failed, ret = %d\n", ret);
			goto pdev_unreg;
		}
		
		printk(KERN_INFO "pdev->num_resources = %u, pdev->resource = %ld\b", 
			pdev_test.num_resources, (unsigned long)(pdev_test.resource));
		
		ret = platform_driver_register(&pdev_test_drv);
		if (ret) {
			printk(KERN_ERR "platform_driver_register failed, ret = %d\n", ret);
			goto pdev_unreg;
		}
		
		printk(KERN_INFO "pdev_res_api_test_init module loaded.\n");
		
		return 0;

	pdev_unreg:
		platform_device_unregister(&pdev_test);
	error_out:
		return ret;	
	}

	static void __exit pdev_res_api_test_exit(void)
	{
		platform_device_unregister(&pdev_test);
		platform_driver_unregister(&pdev_test_drv);	
		
		printk(KERN_INFO "pdev_res_api_test_init module exited.\n");
	}

	module_init(pdev_res_api_test_init);
	module_exit(pdev_res_api_test_exit);

	MODULE_LICENSE("GPL");

Save the above code to a file named pdevres_test.c, and build it into 
pdevres_test.ko, then start kernel with (QEMU + ARM64), after the system
log in, do pdevres_test.ko test:

	root@qemu-ubuntu:~# modprobe pdevres_test test_case=0
	[   74.712276] test case: 0
	[   74.735276] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
	[   74.736556] Mem abort info:
	[   74.737163]   ESR = 0x0000000096000004
	[   74.737858]   EC = 0x25: DABT (current EL), IL = 32 bits
	[   74.738773]   SET = 0, FnV = 0
	[   74.739932]   EA = 0, S1PTW = 0
	[   74.740172]   FSC = 0x04: level 0 translation fault
	[   74.741055] Data abort info:
	[   74.741715]   ISV = 0, ISS = 0x00000004
	[   74.741962]   CM = 0, WnR = 0
	[   74.742845] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000045dc2000
	[   74.743486] [0000000000000018] pgd=0000000000000000, p4d=0000000000000000
	[   74.746098] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
	[   74.752032] Modules linked in: pdevres_test(+) drm ip_tables x_tables ipv6
	[   74.753632] CPU: 0 PID: 129 Comm: modprobe Not tainted 6.3.0-rc1-next-20230307-dirty #3
	[   74.754311] Hardware name: linux,dummy-virt (DT)
	[   74.755196] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	[   74.755830] pc : platform_get_resource+0x2c/0x60
	[   74.757375] lr : pdev_test_probe+0x3c/0x80 [pdevres_test]
	[   74.760657] sp : ffff80000aa9b8c0
	[   74.761258] x29: ffff80000aa9b8c0 x28: ffff800001031778 x27: ffff800001031458
	[   74.762122] x26: ffff80000a216fd8 x25: ffff80000aa9bd00 x24: ffff000003b36868
	[   74.763049] x23: 0000000000000004 x22: 0000000000000000 x21: ffff800001031378
	[   74.764099] x20: ffff800001031000 x19: ffff8000010331a8 x18: 0000000000000001
	[   74.765565] x17: 0000000000000000 x16: 0000000000000000 x15: ffff000004202b80
	[   74.768109] x14: 000000000000014a x13: ffff000004202ff8 x12: 00000000ffffffea
	[   74.769418] x11: 00000000ffffefff x10: 00000000ffffefff x9 : ffff80000a1fb518
	[   74.770240] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000040
	[   74.771550] x5 : 0000000000000200 x4 : 00000000000000c0 x3 : 0000000000000000
	[   74.773185] x2 : 0000000000000000 x1 : 0000000000000200 x0 : 0000000000000040
	[   74.774205] Call trace:
	[   74.774983]  platform_get_resource+0x2c/0x60
	[   74.775951]  platform_probe+0x68/0xd8
	[   74.777340]  really_probe+0x110/0x27c
	[   74.779422]  __driver_probe_device+0x78/0xe0
	[   74.780300]  driver_probe_device+0x3c/0x11c
	[   74.780612]  __driver_attach+0x74/0x124
	[   74.781014]  bus_for_each_dev+0x78/0xe0
	[   74.781672]  driver_attach+0x24/0x30
	[   74.781891]  bus_add_driver+0xe4/0x1e8
	[   74.782127]  driver_register+0x60/0x128
	[   74.782394]  __platform_driver_register+0x28/0x34
	[   74.782997]  pdev_res_api_test_init+0xb0/0x1000 [pdevres_test]
	[   74.785108]  do_one_initcall+0x70/0x1b4
	[   74.785664]  do_init_module+0x58/0x1e8
	[   74.786323]  load_module+0x181c/0x1920
	[   74.787119]  __do_sys_finit_module+0xb8/0x10c
	[   74.788077]  __arm64_sys_finit_module+0x20/0x2c
	[   74.789237]  invoke_syscall+0x44/0x104
	[   74.789946]  el0_svc_common.constprop.0+0x44/0xec
	[   74.791281]  do_el0_svc+0x38/0x98
	[   74.791836]  el0_svc+0x2c/0x84
	[   74.792087]  el0t_64_sync_handler+0xb8/0xbc
	[   74.793010]  el0t_64_sync+0x190/0x194
	[   74.793903] Code: 9ba60084 14000003 eb04007f 54000180 (f9400c61) 
	[   74.795378] ---[ end trace 0000000000000000 ]---
	Segmentation fault
	
	root@qemu-ubuntu:~# modprobe pdevres_test test_case=1

	root@qemu-ubuntu:~# dmesg | tail -n 5
	[   41.830927] test case: 1
	[   41.856717] pdev->num_resources = 0, pdev->resource = 16
	[   41.862550] pdev_test_probe enter...
	[   41.862749] pdev_test_probe exited.
	[   41.866011] pdev_res_api_test_init module loaded.

--
Thanks,

Xujun Leng

