Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404BF631AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiKUIAN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Nov 2022 03:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKUIAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:00:08 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3511DA41
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:00:05 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B4C0E63E516C;
        Mon, 21 Nov 2022 09:00:03 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wqfkx6HDd9gD; Mon, 21 Nov 2022 09:00:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A4A9263E514E;
        Mon, 21 Nov 2022 09:00:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OwGoWtZDMXHC; Mon, 21 Nov 2022 09:00:02 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 64E6463E5146;
        Mon, 21 Nov 2022 09:00:02 +0100 (CET)
Date:   Mon, 21 Nov 2022 09:00:02 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Lihua <hucool.lihua@huawei.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        yusongping <yusongping@huawei.com>
Message-ID: <540631712.260900.1669017601995.JavaMail.zimbra@nod.at>
In-Reply-To: <ed4618a5-67b4-7ee5-f172-a2709ee738fa@huawei.com>
References: <20221115083335.21211-1-hucool.lihua@huawei.com> <23feff35-6f2d-5cd7-57f9-ff2591a3c74e@huawei.com> <433070166.256175.1668893150374.JavaMail.zimbra@nod.at> <ed4618a5-67b4-7ee5-f172-a2709ee738fa@huawei.com>
Subject: Re: [PATCH] ubifs: Fix build errors as symbol undefined
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Fix build errors as symbol undefined
Thread-Index: 6puvwghxBPcdUYfcEut9ULq3gVbn3A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Lihua" <hucool.lihua@huawei.com>
> An: "richard" <richard@nod.at>
> CC: "Sascha Hauer" <s.hauer@pengutronix.de>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "Wei Yongjun" <weiyongjun1@huawei.com>, "yusongping" <yusongping@huawei.com>
> Gesendet: Montag, 21. November 2022 02:54:53
> Betreff: Re: [PATCH] ubifs: Fix build errors as symbol undefined

> You can verify it with the config in the attachment. TKS :D

Thanks for your .config, I was able to identify the problem.
When CONFIG_CC_OPTIMIZE_FOR_SIZE is set the compiler does not optimize this construct:

        err = ubifs_node_check_hash(c, buf, zbr->hash);
        if (err) {
                ubifs_bad_hash(c, buf, zbr->hash, lnum, offs);
                return 0;
        }

With CONFIG_UBIFS_FS_AUTHENTICATION not set, the compiler can assume that
ubifs_node_check_hash() is never true and drops the call to ubifs_bad_hash().
Is CONFIG_CC_OPTIMIZE_FOR_SIZE enabled this optimization does not happen anymore.

So we need a no-op ubifs_bad_hash() for the CONFIG_UBIFS_FS_AUTHENTICATION=n case.

Thanks,
//richard
