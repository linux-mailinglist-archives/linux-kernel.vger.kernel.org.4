Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF24C71A213
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjFAPKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbjFAPKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:10:40 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02514E6D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:10:13 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230601150956euoutp0117d9073c9d94a5a24df5c67d82f5a3af~kkY0tKBj02612426124euoutp01D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 15:09:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230601150956euoutp0117d9073c9d94a5a24df5c67d82f5a3af~kkY0tKBj02612426124euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685632196;
        bh=jW0BYwK/PWHaJ+9E6cMC6OWSxC/6FffxsOCLeoAtGn0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=sYMxAEVU1/rSLR8LsD7BbdENQKtrrjJ0cZxPH3Pvn8ie45PRrTVTotJ1I3jBUbNrf
         3tjuWqlbjb1QnXy/W4w+revQtQKdcQHOiuHZ4rZFmUXhsrmvJ7kYjicGpXpVfuzts3
         IgTXiv/pIaXLfqA26HtoOWkrdSkVxN6elof4TE8E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230601150955eucas1p2b25a9d08b2c86d6220ee94615ccc0ea4~kkYz4dE-T2872328723eucas1p2c;
        Thu,  1 Jun 2023 15:09:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FB.2E.42423.3C4B8746; Thu,  1
        Jun 2023 16:09:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230601150954eucas1p15f17e7aa2e4ca6b6ff8482b2ffb47f44~kkYzbyZKh2918729187eucas1p1_;
        Thu,  1 Jun 2023 15:09:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230601150954eusmtrp21ea8a8474cb9077d074f1a93501b351c~kkYza4heN2922729227eusmtrp2e;
        Thu,  1 Jun 2023 15:09:54 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-fc-6478b4c3fd5b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E1.FA.10549.2C4B8746; Thu,  1
        Jun 2023 16:09:54 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230601150953eusmtip1cdfa682c8d4f441f4dd7981fb9cc73c9~kkYyNrdZh0140701407eusmtip1V;
        Thu,  1 Jun 2023 15:09:53 +0000 (GMT)
Message-ID: <d7c857b8-4aa1-cd5d-4c45-392f7ed6857b@samsung.com>
Date:   Thu, 1 Jun 2023 17:09:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] serial: core: Fix probing serial_base_bus devices
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <2023060112-onion-disparate-8ce8@gregkh>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djP87qHt1SkGNzcxmYxc9lydovepulM
        FtMuTmK2aFnrYdG8eD2bReeOHhaLd3NlLJpu9LBabLsyn9Hi8q45bBazl/SzWJxZ3Mtusf+K
        l8X/sx/YHfg8vn2dxOKxeM9LJo9NqzrZPN6dO8fuMe9koMf+uWvYPY7f2M7k8XmTXABHFJdN
        SmpOZllqkb5dAlfG8Sv72QvOsFbcvxrVwHiQpYuRk0NCwERiYtcRxi5GLg4hgRWMEq8n7mKH
        cL4wSkx/M4EJwvnMKDFh33ugMg6wluWrMiHiyxkl7t/YyQQySkjgI6PExw3FIDavgJ3Erl+r
        mUDqWQRUJF5vsIcIC0qcnPkEbLOoQKrEt7k7WEFsYQE3ifuvXjGD2MwC4hK3nswHGykiEC7x
        5NUhdoj4B2aJ+T0uIDabgKFE19suNhCbU8BUYufdX1A18hLb385hBrlNQmA5p8TEIxBFEgIu
        Eldmn4CyhSVeHd/CDmHLSPzfOZ8JoqGdUWLB7/tQzgRGiYbntxghqqwl7pz7xQbyDbOApsT6
        XfoQYUeJ65P+MEMChU/ixltBiCP4JCZtmw4V5pXoaBOCqFaTmHV8HdzagxcuMU9gVJqFFCyz
        kLw/C8k7sxD2LmBkWcUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGY2k7/O/5pB+PcVx/1
        DjEycTAeYpTgYFYS4RUKK08R4k1JrKxKLcqPLyrNSS0+xCjNwaIkzqttezJZSCA9sSQ1OzW1
        ILUIJsvEwSnVwGTbrdF/4oxu8tIwtUfPHtw2mrdZ5tc61isnFeIiTfb92vfB5cd05du9X+w+
        /l1xSPRubvU8K/4tO++VShSl+t/t3LfmNdNBnYPbXFcbPH9tyF5ZnPVt8/V0kx5nvx22/+8d
        roh5N2m/52TRIH7FPQ/0Wp/vsP5xaHbaV6l4EWlhxrvN6bdzCxIOxPKkze/uD7i/6bx785LQ
        mYtuTRTTOH73zK8N11bdSLOfyaA5e4M9q1uElZJLl8MS/xkHBGoe79iw9UW4zkUxA7U5pvsj
        y+5Hx0TJn7/K0hSnuWznRsHK1Tt8OQKZ/a/9Cz0t5ylaJne98sC87Zta6lZk5DD3q13Wnbzu
        5TeRvb3qfB4r7SYqsRRnJBpqMRcVJwIA55oe0dwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xu7qHtlSkGKxfrGYxc9lydovepulM
        FtMuTmK2aFnrYdG8eD2bReeOHhaLd3NlLJpu9LBabLsyn9Hi8q45bBazl/SzWJxZ3Mtusf+K
        l8X/sx/YHfg8vn2dxOKxeM9LJo9NqzrZPN6dO8fuMe9koMf+uWvYPY7f2M7k8XmTXABHlJ5N
        UX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G8Sv72QvO
        sFbcvxrVwHiQpYuRg0NCwERi+arMLkYuDiGBpYwSkxrXMncxcgLFZSROTmtghbCFJf5c62ID
        sYUE3jNKNC6vBbF5Bewkdv1azQQyh0VAReL1BnuIsKDEyZlPWEBsUYFUid4vKxhBbGEBN4n7
        r16BjWcWEJe49WQ+E4gtIhAuce/6OiaQG5gFPjBL7Jt5nAXioC2MEr1nv4NNYhMwlOh6C3EE
        p4CpxM67v9ghJplJdG3tYoSw5SW2v53DPIFRaBaSQ2YhWTgLScssJC0LGFlWMYqklhbnpucW
        G+oVJ+YWl+al6yXn525iBEbztmM/N+9gnPfqo94hRiYOxkOMEhzMSiK8QmHlKUK8KYmVValF
        +fFFpTmpxYcYTYGBMZFZSjQ5H5hO8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1ML
        Uotg+pg4OKUamBoP7z5/dFuFQd/TSHam1FPfe6I3zpueeKJww4fifezM/WuX/1jwKW8Sk5Vd
        8cyQieYHAqVdD6qw1E72Pni+619xZ6ByTGt8ptDa8nxj3tt2Ky+ve2RWfSTq1q5OlS3HG192
        KvUInVoxMeRhAPf+a6vze3pMTOpjziddZU8Tmf344wobF3OZOYVvG3xa08T4L+/qdlBn0IhJ
        7hV7tnPtqogXE6YcM34uyrhwa/bKL6u/s/1ReSeodDVvb37g2S6vyVe4fj0JjBP8IiccvC17
        lUnC/q6UVs/pU72Tuzye+jw81O93f96MI1pLvfZMm/FQ7uHLStPzdg0KHU0nHjluvMjn/dpu
        8sTtvsslXZunSSixFGckGmoxFxUnAgDmNVqFbwMAAA==
X-CMS-MailID: 20230601150954eucas1p15f17e7aa2e4ca6b6ff8482b2ffb47f44
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230601142147eucas1p1ae331f80a07ad6280f8f759b2d03ade7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230601142147eucas1p1ae331f80a07ad6280f8f759b2d03ade7
References: <20230601141445.11321-1-tony@atomide.com>
        <CGME20230601142147eucas1p1ae331f80a07ad6280f8f759b2d03ade7@eucas1p1.samsung.com>
        <2023060112-onion-disparate-8ce8@gregkh>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.2023 16:21, Greg Kroah-Hartman wrote:
> On Thu, Jun 01, 2023 at 05:14:44PM +0300, Tony Lindgren wrote:
>> If a physical serial port device driver uses arch_initcall() we fail to
>> probe the serial_base_bus devices and the serial port tx fails. This is
>> because as serial_base_bus uses module_initcall().
>>
>> Let's fix the issue by changing serial_base_bus to use arch_initcall().
> This will only work if the linking order is such that this will always
> come before the drivers.  Is that the case here?

Yes, serial_base_bus is linked as a second object, just after the 
serial_core. Device drivers come later.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

