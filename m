Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979426C8240
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCXQT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjCXQTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:19:53 -0400
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51535AD06
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:19:52 -0700 (PDT)
Received: from daria.iliad.local (unknown [IPv6:2a01:e0a:0:2290:ea94:f6ff:fe08:63f8])
        by smtp1-g21.free.fr (Postfix) with ESMTP id BDE84B00563;
        Fri, 24 Mar 2023 17:19:39 +0100 (CET)
From:   Nicolas Schichan <nschichan@freebox.fr>
To:     chengzhihao1@huawei.com
Cc:     george.kennedy@oracle.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        richard@nod.at, s.hauer@pengutronix.de, yi.zhang@huawei.com,
        Nicolas Schichan <nschichan@freebox.fr>
Subject: [PATCH -next v3] ubi: Fix failure attaching when vid_hdr offset equals to (sub)page size
Date:   Fri, 24 Mar 2023 17:19:24 +0100
Message-Id: <20230324161923.1456371-1-nschichan@freebox.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306013308.3884777-1-chengzhihao1@huawei.com>
References: <20230306013308.3884777-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Following process will make ubi attaching failed since commit
> 1b42b1a36fc946 ("ubi: ensure that VID header offset ... size"):
>
> ID="0xec,0xa1,0x00,0x15" # 128M 128KB 2KB
> modprobe nandsim id_bytes=$ID
> flash_eraseall /dev/mtd0
> modprobe ubi mtd="0,2048"  # set vid_hdr offset as 2048 (one page)
> (dmesg):
>   ubi0 error: ubi_attach_mtd_dev [ubi]: VID header offset 2048 too large.
>   UBI error: cannot attach mtd0
>   UBI error: cannot initialize UBI, error -22
>
> Rework original solution, the key point is making sure
> 'vid_hdr_shift + UBI_VID_HDR_SIZE < ubi->vid_hdr_alsize',
> so we should check vid_hdr_shift rather not vid_hdr_offset.
> Then, ubi still support (sub)page aligined VID header offset.
>
> Fixes: 1b42b1a36fc946 ("ubi: ensure that VID header offset ... size")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  v2->v3: Use printing format '%zu' for UBI_VID_HDR_SIZE.
>  drivers/mtd/ubi/build.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)

[...]

Hello,

Having had the problem, and found this patch as a fix, feel free to
add my:

Tested-by: Nicolas Schichan <nschichan@freebox.fr>

-- 
Nicolas Schichan

