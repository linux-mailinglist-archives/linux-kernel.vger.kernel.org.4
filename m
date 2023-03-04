Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC72F6AAB79
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 18:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjCDRLP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 4 Mar 2023 12:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjCDRLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 12:11:14 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C6F166E9
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 09:11:13 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DA78C6382F12;
        Sat,  4 Mar 2023 18:11:11 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tujOCQGJaEPJ; Sat,  4 Mar 2023 18:11:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4FC5C608110B;
        Sat,  4 Mar 2023 18:11:11 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id srbd_RK3TTEX; Sat,  4 Mar 2023 18:11:11 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2F24F6382F12;
        Sat,  4 Mar 2023 18:11:11 +0100 (CET)
Date:   Sat, 4 Mar 2023 18:11:10 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        George Kennedy <george.kennedy@oracle.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yi zhang <yi.zhang@huawei.com>
Message-ID: <272361861.203885.1677949870976.JavaMail.zimbra@nod.at>
In-Reply-To: <20230304074243.1348767-1-chengzhihao1@huawei.com>
References: <20230304074243.1348767-1-chengzhihao1@huawei.com>
Subject: Re: [PATCH v2] ubi: Fix failure attaching when vid_hdr offset
 equals to (sub)page size
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix failure attaching when vid_hdr offset equals to (sub)page size
Thread-Index: JFEAvkKUA6ZhyQ6KCrIkdwi5G/GiZw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> +	/*
> +	 * Memory allocation for VID header is ubi->vid_hdr_alsize
> +	 * which is described in comments in io.c.
> +	 * Make sure VID header shift + UBI_VID_HDR_SIZE not exceeds
> +	 * ubi->vid_hdr_alsize, so that all vid header operations
> +	 * won't access memory out of bounds.
> +	 */
> +	if ((ubi->vid_hdr_shift + UBI_VID_HDR_SIZE) > ubi->vid_hdr_alsize) {
> +		ubi_err(ubi, "Invalid VID header offset %d, VID header shift(%d)"
> +			" + VID header size(%d) > VID header aligned size(%d).",
> +			ubi->vid_hdr_offset, ubi->vid_hdr_shift,
> +			(int)UBI_VID_HDR_SIZE, ubi->vid_hdr_alsize);

Hmm, why are you casting to int instead of using %zu as format string?

Thanks,
//richard
