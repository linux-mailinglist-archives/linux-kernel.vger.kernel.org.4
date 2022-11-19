Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0BB63111A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 22:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiKSVZz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Nov 2022 16:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiKSVZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 16:25:53 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626D0102
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 13:25:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 28C7763E516F;
        Sat, 19 Nov 2022 22:25:51 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NjSMm1e3K7LC; Sat, 19 Nov 2022 22:25:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A5E1B63E5157;
        Sat, 19 Nov 2022 22:25:50 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UJoQ5eQwxLyi; Sat, 19 Nov 2022 22:25:50 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8726363E5146;
        Sat, 19 Nov 2022 22:25:50 +0100 (CET)
Date:   Sat, 19 Nov 2022 22:25:50 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     "Lihua (lihua, ran)" <hucool.lihua@huawei.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>, yusongping@huawei.com
Message-ID: <433070166.256175.1668893150374.JavaMail.zimbra@nod.at>
In-Reply-To: <23feff35-6f2d-5cd7-57f9-ff2591a3c74e@huawei.com>
References: <20221115083335.21211-1-hucool.lihua@huawei.com> <23feff35-6f2d-5cd7-57f9-ff2591a3c74e@huawei.com>
Subject: Re: [PATCH] ubifs: Fix build errors as symbol undefined
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Fix build errors as symbol undefined
Thread-Index: xvKUd6iNeIA9uYaj0+JoIBNTDdG+WA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Lihua (lihua, ran)" <hucool.lihua@huawei.com>
>> diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
>> index 45d3d207fb99..93bda1057fdc 100644
>> --- a/fs/ubifs/Kconfig
>> +++ b/fs/ubifs/Kconfig
>> @@ -13,6 +13,7 @@ config UBIFS_FS
>>   	select CRYPTO_HASH_INFO
>>   	select UBIFS_FS_XATTR if FS_ENCRYPTION
>>   	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
>> +	select UBIFS_FS_AUTHENTICATION

I fear this is not a proper fix.
This changes does not longer allow building UBIFS without the authentication feature.
With what configuration do you see this error?

I just tried with:
CONFIG_UBIFS_FS=m
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_FS_ZSTD=y
CONFIG_UBIFS_ATIME_SUPPORT=y
CONFIG_UBIFS_FS_XATTR=y
CONFIG_UBIFS_FS_SECURITY=y
# CONFIG_UBIFS_FS_AUTHENTICATION is not set

But don't get the error and, as expected, fs/ubifs/ubifs.o has no
reference to ubifs_bad_hash.

Thanks,
//richard
