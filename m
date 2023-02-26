Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B24D6A3284
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 16:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBZPwr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 26 Feb 2023 10:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBZPwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 10:52:45 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D285FF09
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 07:52:42 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 982326382EE0;
        Sun, 26 Feb 2023 16:52:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OdHtngKj_CEo; Sun, 26 Feb 2023 16:52:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B53636382EF9;
        Sun, 26 Feb 2023 16:52:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EXKMKkxKdK87; Sun, 26 Feb 2023 16:52:38 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 90D616382EE0;
        Sun, 26 Feb 2023 16:52:38 +0100 (CET)
Date:   Sun, 26 Feb 2023 16:52:38 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Wang YanQing <udknight@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <949898059.176653.1677426758468.JavaMail.zimbra@nod.at>
In-Reply-To: <20230226141406.GA32048@udknight>
References: <20230217165442.GA28288@udknight> <20230226141406.GA32048@udknight>
Subject: Re: [PATCH] mtd: ubi: eba.c: fix return value overwrite issue in
 try_write_vid_and_data()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: eba.c: fix return value overwrite issue in try_write_vid_and_data()
Thread-Index: iX6BMGP8zHgA8cIv1+NVBi+UxLxKBQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Wang YanQing" <udknight@gmail.com>
> An: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Boris Brezillon" <bbrezillon@kernel.org>, "richard" <richard@nod.at>,
> "Vignesh Raghavendra" <vigneshr@ti.com>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> Gesendet: Sonntag, 26. Februar 2023 15:14:06
> Betreff: Re: [PATCH] mtd: ubi: eba.c: fix return value overwrite issue in try_write_vid_and_data()

> On Sat, Feb 18, 2023 at 12:58:08AM +0800, Wang YanQing wrote:
>> The commit 2d78aee426d8 ("UBI: simplify LEB write and atomic LEB change code")
>> adds helper function, try_write_vid_and_data(), to simplify the code, but this
>> helper function has bug, it will return 0 (success) when ubi_io_write_vid_hdr()
>> or the ubi_io_write_data() return error number (-EIO, etc), because the return
>> value of ubi_wl_put_peb() will overwrite the original return value.
>> 
>> This issue will cause unexpected data loss issue, because the caller of this
>> function and UBIFS willn't know the data is lost.
>> 
>> Fixes: 2d78aee426d8 ("UBI: simplify LEB write and atomic LEB change code")
>> 
>> Signed-off-by: Wang YanQing <udknight@gmail.com>
> 
> Hi! Miquel Raynal
> 
> What is the status about this patch?

We're in the middle of the merge window. It will be applied to the fixes
branch after rc1.

Thanks,
//richard
