Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C152688717
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjBBSuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBBSur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:50:47 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F1B2D48
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:50:46 -0800 (PST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 069C041AE5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 18:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675363300;
        bh=5/sqWycvEAPjqsnTBo2U8a25upaJIykotUumaHLpuvI=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=Jp0SLAwAjgWlgrMPH+V08scSUlhMWZhTGvHYNSIbXaetUh7lvWIc1MhmGvELSkuEB
         QaSYL7Msya+q+q5GOjqSu11oStJJg598XFy4/e8idIXt0+GSsBSvuw8PV9HRfY+0Hr
         IUsqPQnDK3p6jgmMY7lwfFJRYsuPwYPd8r9zpjfEPHEGTsKvNOu5F+dR98bWbI8adf
         nFCG6+vzKNQzOVxybiwEa7DQyhLhT8CbcfNl8wHbuH6LX9CgpEmbxebjSjaoHr9SqK
         G4IfBuJ3JF6URMLHPTUoaSe0p8sSANtyAeiobQx5/TxOVTs7jVAFHiJNGI1LxgRWYH
         Nn8I2sxlUDhjw==
Received: by mail-pg1-f197.google.com with SMTP id 127-20020a630685000000b004ec5996dcc0so1379926pgg.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:41:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/sqWycvEAPjqsnTBo2U8a25upaJIykotUumaHLpuvI=;
        b=5i/FmGmpoQOxb8nFmpuMymyhz/mKP/VfezGQXT/S21LRsZk60GmEGxWg/epRk4SZVW
         l1HmW+UykdHFSg5DqdWytxfY7BWye8ua0IVtIVQg/zy+e/ACfKtyJkt7paOhhuS2QT24
         jiofEojJ6uOIUl5rr+SuGDlthKyjztSc0wI9I2dWg8XwTL9Wb3G6QP/HEeraJrqeG3XU
         i9fAmHU3N8zH9IKgVE+vj859YSFJ2raLtFoDtqa+M0coeiOfsWiNeO9p8VJGrvOkBSxy
         OV4zwOdK/4ytZFSI2cqX9vzntBZE27JGApTxLEooW3+Veap0gMzS6RmuufMlu9CrRtR7
         L+qg==
X-Gm-Message-State: AO0yUKUqWoYexh2yJ8BwlqTxFBoBLiQ0vpQVeceqA81hzZ+d/lqjI1DK
        DdvHdMxbtqpZThPWlALpAQW+RcIWG0UpNePsuR5+9hMhnaRhajJim1YEceDm7fmMR211NfoZolb
        IoWhJELSfjrPs0x2YkOueurhu3ulxl1a3smBMvXAVNQ==
X-Received: by 2002:a17:90b:1d82:b0:22c:169b:ec44 with SMTP id pf2-20020a17090b1d8200b0022c169bec44mr7704078pjb.31.1675363298639;
        Thu, 02 Feb 2023 10:41:38 -0800 (PST)
X-Google-Smtp-Source: AK7set/iID5T6tsp9eWmtXNZbOFdFo2GTi9PEDvqAxvwzPCco64WaniWJlyIzIuuMqZESDriKrnLfQ==
X-Received: by 2002:a17:90b:1d82:b0:22c:169b:ec44 with SMTP id pf2-20020a17090b1d8200b0022c169bec44mr7704065pjb.31.1675363298369;
        Thu, 02 Feb 2023 10:41:38 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090aa58100b00229d7f2abd4sm163842pjq.54.2023.02.02.10.41.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2023 10:41:37 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
        id 6FD985FEAC; Thu,  2 Feb 2023 10:41:37 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id 680F29FB5C;
        Thu,  2 Feb 2023 10:41:37 -0800 (PST)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
cc:     gregkh@linuxfoundation.org, rafael@kernel.org, vfalico@gmail.com,
        andy@greyhouse.net, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] bonding: fix error checking in bond_debug_reregister()
In-reply-to: <20230202093256.32458-3-zhengqi.arch@bytedance.com>
References: <20230202093256.32458-1-zhengqi.arch@bytedance.com> <20230202093256.32458-3-zhengqi.arch@bytedance.com>
Comments: In-reply-to Qi Zheng <zhengqi.arch@bytedance.com>
   message dated "Thu, 02 Feb 2023 17:32:55 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20120.1675363297.1@famine>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 02 Feb 2023 10:41:37 -0800
Message-ID: <20121.1675363297@famine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qi Zheng <zhengqi.arch@bytedance.com> wrote:

>Since commit ff9fb72bc077 ("debugfs: return error values,
>not NULL") changed return value of debugfs_rename() in
>error cases from %NULL to %ERR_PTR(-ERROR), we should
>also check error values instead of NULL.
>
>Fixes: ff9fb72bc077 ("debugfs: return error values, not NULL")
>Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>

>---
> drivers/net/bonding/bond_debugfs.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bon=
d_debugfs.c
>index 4f9b4a18c74c..594094526648 100644
>--- a/drivers/net/bonding/bond_debugfs.c
>+++ b/drivers/net/bonding/bond_debugfs.c
>@@ -76,7 +76,7 @@ void bond_debug_reregister(struct bonding *bond)
> =

> 	d =3D debugfs_rename(bonding_debug_root, bond->debug_dir,
> 			   bonding_debug_root, bond->dev->name);
>-	if (d) {
>+	if (!IS_ERR(d)) {
> 		bond->debug_dir =3D d;
> 	} else {
> 		netdev_warn(bond->dev, "failed to reregister, so just unregister old o=
ne\n");
>-- =

>2.20.1
>
