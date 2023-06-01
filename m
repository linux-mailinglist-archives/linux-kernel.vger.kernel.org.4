Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF702719A6F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjFALAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjFALAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:00:36 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08EA12C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 04:00:34 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230601110031euoutp028f67a4cb06285c0b83b0f1fbad213c4f~kg-EPu4e60277702777euoutp02W
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 11:00:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230601110031euoutp028f67a4cb06285c0b83b0f1fbad213c4f~kg-EPu4e60277702777euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685617231;
        bh=rpaMuZCPHPmqWYgD17bbXFAhzzVhr52QHcgZSwIiN4U=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=dzrR4pblbtDqZnSax2QSFxX9PWIQogdjnSh8wLhEv6uj5+E+47UJwA8XV36Ir/5Qx
         OLs1tBnDx6bvKN4o0yHe3wqUmydavb2kmk9tQnNGff8WLAIqv7dVElR7gfSPbDvqs4
         uOaCbQTDmqTUwfY5nD+w98ig4SNxj3QasCocPUcE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230601110031eucas1p221d36e00d0488d1d902369ad75710789~kg-DzZl2b1539915399eucas1p20;
        Thu,  1 Jun 2023 11:00:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AC.64.11320.F4A78746; Thu,  1
        Jun 2023 12:00:31 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230601110030eucas1p2eed547c326a51a6110100fb50799d136~kg-C8R1d42445024450eucas1p2G;
        Thu,  1 Jun 2023 11:00:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230601110030eusmtrp23f6209f6474c61b91efe846faadc612e~kg-C7jyTp1117411174eusmtrp2d;
        Thu,  1 Jun 2023 11:00:30 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-ab-64787a4f6706
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 51.D4.14344.E4A78746; Thu,  1
        Jun 2023 12:00:30 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230601110029eusmtip21dd25ce8bd00135494037f2ed594a7a8~kg-CP1GUn1801218012eusmtip2L;
        Thu,  1 Jun 2023 11:00:29 +0000 (GMT)
Message-ID: <88d9edfe-2f39-b15f-f513-463eac6bf473@samsung.com>
Date:   Thu, 1 Jun 2023 13:00:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230525113034.46880-1-tony@atomide.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djP87r+VRUpBqs6RC1mLlvObtHbNJ3J
        YtrFScwWLWs9LJoXr2ez6NzRw2Lxbq6MRdONHlaLbVfmM1pc3jWHzWL2kn4WizOLe9kt9l/x
        svh/9gO7A5/Ht6+TWDwW73nJ5LFpVSebx7tz59g95p0M9Ng/dw27x/Eb25k8Pm+SC+CI4rJJ
        Sc3JLEst0rdL4Mp42N7GXNAhVLG4u5+9gfEHXxcjJ4eEgInErgUrmLoYuTiEBFYwSnTdPsoK
        4XxhlLj07gMzSJWQwGdGia3b7LsYOcA6Lv+Wh6hZzijR934jM4TzkVHi7boWFpAiXgE7iQvH
        eUB6WQRUJB4dmsoOYvMKCEqcnPmEBcQWFUiV+DZ3ByuILSyQLDHj/yOwXcwC4hK3nsxnArFF
        BKok3u89ADafWeAss0Tzpv1gg9gEDCW63naxgdicAmYSuz6tZYNolpdo3jobrEFCYDmnxJbO
        40wQf7pIdNz4xQZhC0u8Or6FHcKWkfi/cz4TREM7o8SC3/ehnAmMEg3PbzFCVFlL3DkH0s0B
        tEJTYv0ufYiwo8Sm1jfskGDhk7jxVhDiCD6JSdumM0OEeSU62oQgqtUkZh1fB7f24IVLzBMY
        lWYhhcssJP/PQvLOLIS9CxhZVjGKp5YW56anFhvlpZbrFSfmFpfmpesl5+duYgSmt9P/jn/Z
        wbj81Ue9Q4xMHIyHGCU4mJVEeIXCylOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ82rbnkwWEkhP
        LEnNTk0tSC2CyTJxcEo1MGVqzYji3HdMy0fmw8UPEe9WHH80e8b83Fvqbdu0sngln4TmCLKL
        +R81XaiaeP5fYFj51qXCn6sYBTtT2TJWaH3u2Xgp8M4moYr/SspfFj3brHU8OEv50Gz1sxbb
        N/xTZGZNuSomwBW+JWmBlNCDp0I6CpsfTO+f3TZvyovzLzUE9rt0X6/oXfXuj5Nk5Lcdiifr
        syw1xNuzLM2cogsY7dsVHd+HT9vMJ6asl3F0o2PU8p+HpJ89Zlk/zZP31N3VprYc8orsxxud
        bI6wmUbrG4c67Z2x1dU+NHpd+U8OFaFlzWvv7iuqk4rbfuDo2z3z63irpm9dz7f2paeu1KMZ
        580ubBOePbH40c1mmYl6bkosxRmJhlrMRcWJAHV1mAPeAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xe7p+VRUpBgeuSlvMXLac3aK3aTqT
        xbSLk5gtWtZ6WDQvXs9m0bmjh8Xi3VwZi6YbPawW267MZ7S4vGsOm8XsJf0sFmcW97Jb7L/i
        ZfH/7Ad2Bz6Pb18nsXgs3vOSyWPTqk42j3fnzrF7zDsZ6LF/7hp2j+M3tjN5fN4kF8ARpWdT
        lF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfxsL2NuaBD
        qGJxdz97A+MPvi5GDg4JAROJy7/luxi5OIQEljJKzJn4jaWLkRMoLiNxcloDK4QtLPHnWhcb
        RNF7RomfRxcwgzTzCthJXDjOA1LDIqAi8ejQVHYQm1dAUOLkzCdgc0QFUiV6v6xgBLGFBZIl
        Zvx/xAxiMwuIS9x6Mp8JxBYRqJHYuHQqC8h8ZoGzzBJbTm0CGyQkYCpxZNN+sCI2AUOJrrcg
        R3BycAqYSez6tJYNYpCZRNfWLkYIW16ieets5gmMQrOQ3DELyb5ZSFpmIWlZwMiyilEktbQ4
        Nz232EivODG3uDQvXS85P3cTIzCetx37uWUH48pXH/UOMTJxMB5ilOBgVhLhFQorTxHiTUms
        rEotyo8vKs1JLT7EaAoMjInMUqLJ+cCEklcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKa
        nZpakFoE08fEwSnVwCR3/QaLgUl32vvSY+xG1yqOGl/VM1ALPa/tz5O9OPjsvcpNLWe/3r9R
        ujs7R7pLj2Fr8M3EvzvTL1wp8DjnFPw/5p+SRF1I/esEj5yfHtuevE7g0RK2tz9x7IeLp8fm
        z+slVD68f9ObfjXAJYD134ESbflfF6bO/3c4deVj9beOxcl/JMTiEoLfs1VJLGxI/1O2vPMM
        t/QeoZzHponL1tx7f+vzdpZNgpetjzZ6n3x8g4uhdPaC5pzF0Xs1LPx6mJUnlJY+yp4xKbbF
        sufwFtaXuc3zbzVHVWen3v+R80w0Y/b+6f67fi0syjp9IrxKe/URn/IpUepy0+77TAtyNa17
        +yEk4FqC9WfF1IodOUosxRmJhlrMRcWJAErIrgBwAwAA
X-CMS-MailID: 20230601110030eucas1p2eed547c326a51a6110100fb50799d136
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230601110030eucas1p2eed547c326a51a6110100fb50799d136
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230601110030eucas1p2eed547c326a51a6110100fb50799d136
References: <20230525113034.46880-1-tony@atomide.com>
        <CGME20230601110030eucas1p2eed547c326a51a6110100fb50799d136@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 25.05.2023 13:30, Tony Lindgren wrote:
> We want to enable runtime PM for serial port device drivers in a generic
> way. To do this, we want to have the serial core layer manage the
> registered physical serial controller devices.
>
> To manage serial controllers, let's set up a struct bus and struct device
> for the serial core controller as suggested by Greg and Jiri. The serial
> core controller devices are children of the physical serial port device.
> The serial core controller device is needed to support multiple different
> kind of ports connected to single physical serial port device.
>
> Let's also set up a struct device for the serial core port. The serial
> core port instances are children of the serial core controller device.
>
> With the serial core port device we can now flush pending TX on the
> runtime PM resume as suggested by Johan.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Suggested-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

This patch landed in today's linux next-20230601 as commit 84a9582fd203 
("serial: core: Start managing serial controllers to enable runtime 
PM"). Unfortunately it breaks booting some of my test boards. This can 
be easily reproduced with QEMU and ARM64 virt machine. The last message 
I see in the log is:

[    3.084743] Run /sbin/init as init process

I've tried a hack posted here by Steven Price, but unfortunately it 
doesn't fix my issue. Reverting $subject on top of next-20230601 fixes 
the boot.

Here is my qemu test command (nothing really special...):

qemu-system-aarch64 -kernel Image -append "console=ttyAMA0 
no_console_suspend root=/dev/vda rootwait ip=::::target::off" -M virt 
-cpu cortex-a57 -smp 2 -m 1024 -device 
virtio-blk-device,drive=virtio-blk0 -device 
virtio-blk-device,drive=virtio-blk1 -drive 
file=qemu-virt-rootfs.raw,id=virtio-blk1,if=none,format=raw -drive 
file=initrd,id=virtio-blk0,if=none,format=raw -netdev user,id=user 
-device virtio-net-device,netdev=user -display none


 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

