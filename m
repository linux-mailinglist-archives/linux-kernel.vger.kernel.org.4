Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F371E6E53CB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjDQVVH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 17:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjDQVVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:21:05 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47D53AB3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:21:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 165506382F0C;
        Mon, 17 Apr 2023 23:21:00 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zP6gpvDkZfuZ; Mon, 17 Apr 2023 23:20:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9F0B563CC166;
        Mon, 17 Apr 2023 23:20:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id brjCZ1XPEVNV; Mon, 17 Apr 2023 23:20:59 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7C2806382F0C;
        Mon, 17 Apr 2023 23:20:59 +0200 (CEST)
Date:   Mon, 17 Apr 2023 23:20:59 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <645805930.114012.1681766459273.JavaMail.zimbra@nod.at>
In-Reply-To: <20230417205654.1982368-1-arnd@kernel.org>
References: <20230417205654.1982368-1-arnd@kernel.org>
Subject: Re: [PATCH] mtdchar: mark bits of ioctl handler noinline
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: mtdchar: mark bits of ioctl handler noinline
Thread-Index: nwC/Hc1rDi+z5tkPO5cWLU+7DfHq+w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Arnd Bergmann" <arnd@kernel.org>
> The addition of the mtdchar_read_ioctl() function caused the stack usage
> of mtdchar_ioctl() to grow beyond the warning limit on 32-bit architectures
> with gcc-13:
> 
> drivers/mtd/mtdchar.c: In function 'mtdchar_ioctl':
> drivers/mtd/mtdchar.c:1229:1: error: the frame size of 1488 bytes is larger than
> 1024 bytes [-Werror=frame-larger-than=]
> 
> Mark both the read and write portions as noinline_for_stack to ensure
> they don't get inlined and use separate stack slots to reduce the
> maximum usage, both in the mtdchar_ioctl() and combined with any
> of its callees.
> 
> Fixes: 095bb6e44eb1 ("mtdchar: add MEMREAD ioctl")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
