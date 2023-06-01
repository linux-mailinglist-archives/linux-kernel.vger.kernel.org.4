Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD07719F8E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjFAORH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjFAORC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:17:02 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C38A10C4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:16:32 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230601141618euoutp02b778bd637bd8c01b192256eb7ac1ca89~kjqAO7Fp22679626796euoutp02j
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:16:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230601141618euoutp02b778bd637bd8c01b192256eb7ac1ca89~kjqAO7Fp22679626796euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685628978;
        bh=aooKOcoG2Dz+6wPhDw6GXnx90ndkQz6rTx2S+M8S+9M=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=ObCCfeT4IsjTCibs8aiDjQspa8HrWLZ8NQP3pi/0FMTXNjracwyml/dmFpel7BT0w
         BrTn8on28ik7Jms+fZ/J0l8rxSWYF6vZap7MzM0tPC4wGcnykc/r8Mm7Qw3hISTwZV
         EimfzmZX1u27feqwhdGLUAkbP4bGnqHv8t3B8vcI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230601141618eucas1p189c11e679112fb3fcd998e92689066e0~kjp-9bSWB2119821198eucas1p1A;
        Thu,  1 Jun 2023 14:16:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EB.FF.11320.238A8746; Thu,  1
        Jun 2023 15:16:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230601141617eucas1p153a837c55b69a38e0375a169a248bb90~kjp-jFKmw1431214312eucas1p1S;
        Thu,  1 Jun 2023 14:16:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230601141617eusmtrp1bcea0700833c5d2e72a152d7dc16ab04~kjp-forWC1034710347eusmtrp1B;
        Thu,  1 Jun 2023 14:16:17 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-37-6478a832fd2d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 40.85.14344.138A8746; Thu,  1
        Jun 2023 15:16:17 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230601141616eusmtip10816804fc5fa2284f5569b447a83b0c4~kjp_rrN9n3227732277eusmtip1l;
        Thu,  1 Jun 2023 14:16:16 +0000 (GMT)
Message-ID: <ada0d2f8-cb62-1ce7-99c8-c39f071a476d@samsung.com>
Date:   Thu, 1 Jun 2023 16:16:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
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
In-Reply-To: <20230601132012.GB14287@atomide.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsWy7djPc7pGKypSDI7P5beYuWw5u0Vv03Qm
        i2kXJzFbtKz1sGhevJ7NonNHD4vFu7kyFk03elgttl2Zz2hxedccNovZS/pZLM4s7mW32H/F
        y+L/2Q/sDnwe375OYvFYvOclk8emVZ1sHu/OnWP3mHcy0GP/3DXsHsdvbGfy+LxJLoAjissm
        JTUnsyy1SN8ugSvj5oZ29oKFQhXPHs5hamBcx9/FyMkhIWAi8fj3dMYuRi4OIYEVjBJ7mz4y
        QzhfGCW6fi9jgnA+M0ocW3qUrYuRA6xlxgoniPhyRolHEx6xQzgfGSVWrj7ICjKXV8BO4tu1
        v0wgDSwCKhIPLvhDhAUlTs58wgJiiwqkSnybuwOsXFggWWLG/0fMIDazgLjErSfzwVpFgFrv
        vrQHGc8ssJhF4t6MVWwgNWwChhJdb7vAbE4g+9v07SwQvfISzVtnM0O8Np9T4vxfSwjbReL9
        ko9MELawxKvjW9ghbBmJ05N7WEAWSAi0M0os+H2fCcKZwCjR8PwWI0SVtcSdc7/AvmcW0JRY
        v0sfIuwosan1DTskUPgkbrwVhLiBT2LStunMEGFeiY42IYhqNYlZx9fBrT144RLzBEalWUih
        MgvJ97OQfDMLYe8CRpZVjOKppcW56anFRnmp5XrFibnFpXnpesn5uZsYgcnt9L/jX3YwLn/1
        Ue8QIxMH4yFGCQ5mJRFeobDyFCHelMTKqtSi/Pii0pzU4kOM0hwsSuK82rYnk4UE0hNLUrNT
        UwtSi2CyTBycUg1MMzaVlzJp7YuqjfRpjkz12DUt2fvGJ8f34hXMMx+Yztg3+exl04en3q3Y
        mnDEoZxBSrHaK3TLpdJ3h69N0zFJf92gdXB96de+4qDZ/Zu2qs3ilHizvG1qXds0bsmeLWn3
        s/8nfejbkGqUJiXysmmjbvnFmYVnli6I51Xa8fb/dYPPhZt2GD09d1ZJ47LIvhvlHQedt3x7
        7M5WOz/i9xWeTscftm6cZ/aWnj86ac7EKulp5cE396pPvib6aOdEy1/XJ/WGXb0dcV3hZMq8
        uFtMn2IOv9u18tb+aud8Y4NEudTbtrs2zp3MxOL191PEc4dmrRdH5FWn7a/5blb8f7Xkg5C2
        wP5LBk8mrPad4qD0ca8SS3FGoqEWc1FxIgAJigJC3QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xu7qGKypSDA58UreYuWw5u0Vv03Qm
        i2kXJzFbtKz1sGhevJ7NonNHD4vFu7kyFk03elgttl2Zz2hxedccNovZS/pZLM4s7mW32H/F
        y+L/2Q/sDnwe375OYvFYvOclk8emVZ1sHu/OnWP3mHcy0GP/3DXsHsdvbGfy+LxJLoAjSs+m
        KL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j5oZ29oKF
        QhXPHs5hamBcx9/FyMEhIWAiMWOFUxcjF4eQwFJGif2f57J0MXICxWUkTk5rYIWwhSX+XOti
        gyh6zyhx5uFfsCJeATuJb9f+MoEMYhFQkXhwwR8iLChxcuYTsBJRgVSJ3i8rGEFsYYFkiRn/
        HzGD2MwC4hK3nswHaxUBar370h5kPLPAYhaJ6dc6WSB2dTFJ/DjUBdbMJmAo0fUW5AhODk4g
        +9v07SwQg8wkurZC1DALyEs0b53NPIFRaBaSO2Yh2TcLScssJC0LGFlWMYqklhbnpucWG+kV
        J+YWl+al6yXn525iBMbztmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8QmHlKUK8KYmVValF+fFF
        pTmpxYcYTYFhMZFZSjQ5H5hQ8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg
        +pg4OKUamHhk7xm7P+oN6gnduuWT1uzy8lLzeOFNN9zD/Z5MUbAIfKO+vFjTfPGbjG8iWf+/
        yrutPSjqIj85/0t2ZLTF76WZJ7Y8Xex3ftPROdN8fv54XWwpvCXv4PFvGj6lQh7r1Re5B9RW
        /pDXqVue0HF0CoNCouQ1q8WBX/aLrZPPnsHzqfb7s4lin0xygqapzHG1lv5sfi1JgKG0tKtR
        Y91+p4krnnYL5v71LVCxuZlitKEkN04tj5l9W6x83ivpys1Z4aIPnugfPMnQODt+hlMuZ7Lk
        jYkXK7KeH1y47TufR5vL9sfid36FGx5sW8DF07Fui7cvj/iSwmsGsTV3uCYuurFpz9ef803a
        LmouFfK3VWIpzkg01GIuKk4EAFQfftJwAwAA
X-CMS-MailID: 20230601141617eucas1p153a837c55b69a38e0375a169a248bb90
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230601110030eucas1p2eed547c326a51a6110100fb50799d136
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230601110030eucas1p2eed547c326a51a6110100fb50799d136
References: <20230525113034.46880-1-tony@atomide.com>
        <CGME20230601110030eucas1p2eed547c326a51a6110100fb50799d136@eucas1p2.samsung.com>
        <88d9edfe-2f39-b15f-f513-463eac6bf473@samsung.com>
        <20230601111147.GA14287@atomide.com> <20230601132012.GB14287@atomide.com>
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

On 01.06.2023 15:20, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [230601 11:12]:
>> * Marek Szyprowski <m.szyprowski@samsung.com> [230601 11:00]:
>>> This patch landed in today's linux next-20230601 as commit 84a9582fd203
>>> ("serial: core: Start managing serial controllers to enable runtime
>>> PM"). Unfortunately it breaks booting some of my test boards. This can
>>> be easily reproduced with QEMU and ARM64 virt machine. The last message
>>> I see in the log is:
>>>
>>> [    3.084743] Run /sbin/init as init process
>> OK thanks for the report. I wonder if this issue is specific to ttyAM
>> serial port devices somehow?
> Looks like the problem happens with serial port drivers that use
> arch_initcall():
>
> $ git grep arch_initcall drivers/tty/serial/
> drivers/tty/serial/amba-pl011.c:arch_initcall(pl011_init);
> drivers/tty/serial/mps2-uart.c:arch_initcall(mps2_uart_init);
> drivers/tty/serial/mvebu-uart.c:arch_initcall(mvebu_uart_init);
> drivers/tty/serial/pic32_uart.c:arch_initcall(pic32_uart_init);
> drivers/tty/serial/serial_base_bus.c:arch_initcall(serial_base_init);
> drivers/tty/serial/xilinx_uartps.c:arch_initcall(cdns_uart_init);
>
> We have serial_base_bus use module_init() so the serial core controller
> and port device associated with the physical serial port are not probed.
>
> The patch below should fix the problem you're seeing, care to test and
> if it works I'll post a proper fix?

Right, this fixes my issue. Feel free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> Note that if we ever have cases where uart_add_one_port() gets called
> even earlier, we should just call serial_base_init() directly when
> adding the first port.
>
> Regards,
>
> Tony
>
> 8< ------------------
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -186,7 +186,7 @@ static int serial_base_init(void)
>   
>   	return ret;
>   }
> -module_init(serial_base_init);
> +arch_initcall(serial_base_init);
>   
>   static void serial_base_exit(void)
>   {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

