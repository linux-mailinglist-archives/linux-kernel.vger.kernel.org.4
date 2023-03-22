Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F766C519F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCVRDE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Mar 2023 13:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjCVRCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:02:55 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119B065056
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:02:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D421F6431C2E;
        Wed, 22 Mar 2023 18:02:11 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5O8DagyRu-Wg; Wed, 22 Mar 2023 18:02:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3A19E61989EA;
        Wed, 22 Mar 2023 18:02:11 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YVeIiaZh7mZI; Wed, 22 Mar 2023 18:02:11 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1710761989E6;
        Wed, 22 Mar 2023 18:02:11 +0100 (CET)
Date:   Wed, 22 Mar 2023 18:02:10 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <462173384.277322.1679504530972.JavaMail.zimbra@nod.at>
In-Reply-To: <20230322165905.55389-4-frank.li@vivo.com>
References: <20230322165905.55389-1-frank.li@vivo.com> <20230322165905.55389-4-frank.li@vivo.com>
Subject: Re: [PATCH v3 05/10] ubifs: convert to kobject_del_and_put()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: convert to kobject_del_and_put()
Thread-Index: gpQy2dclbZOSlO48/BHuEnRTh4PO1A==
X-Spam-Status: No, score=0.0 required=5.0 tests=PDS_BAD_THREAD_QP_64,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Yangtao Li" <frank.li@vivo.com>
> An: "richard" <richard@nod.at>
> CC: "Yangtao Li" <frank.li@vivo.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
> <rafael@kernel.org>, "Damien Le Moal" <damien.lemoal@opensource.wdc.com>, "linux-mtd" <linux-mtd@lists.infradead.org>,
> "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Mittwoch, 22. März 2023 17:59:00
> Betreff: [PATCH v3 05/10] ubifs: convert to kobject_del_and_put()

> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> fs/ubifs/sysfs.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
> index 1c958148bb87..9571718e61a9 100644
> --- a/fs/ubifs/sysfs.c
> +++ b/fs/ubifs/sysfs.c
> @@ -130,8 +130,7 @@ int ubifs_sysfs_register(struct ubifs_info *c)
> 
> void ubifs_sysfs_unregister(struct ubifs_info *c)
> {
> -	kobject_del(&c->kobj);
> -	kobject_put(&c->kobj);
> +	kobject_del_and_put(&c->kobj);
> 	wait_for_completion(&c->kobj_unregister);

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
