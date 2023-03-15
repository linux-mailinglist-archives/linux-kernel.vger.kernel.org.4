Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6D56BAC33
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjCOJbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjCOJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:30:57 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA5E7D0AE;
        Wed, 15 Mar 2023 02:30:52 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8688920004;
        Wed, 15 Mar 2023 09:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678872651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZozf4Q4AGLD4ormvTVzyOVy0WVpjJnBsg4P2LTdMtc=;
        b=iTpu4NMSMLGRab9Zlk6CQHqSaR1wfr1Hg3vVEJW56Yd6lgLysaFJMDMnnG77LD5g0YjW+M
        +kOkAFTDzrr6TP5Otp+7yK0Iud3vJeqyqTn3+OY9AznXJQcY8oRARuyl//t8g3oe7p2VaH
        9TOQNw0lb9j1DkgDeAGCMXg9mcq+B2vpe97mqe/KhTv6/jwmBO1R8FYopbevL8q9gDhHrt
        EgYZsVCb5rI88vYkp4KVdPDL3Esik3VQ/aV8uV1bzSKmUjNoTVd2GgiJdFa/OUxbnDX8z2
        ay0LcIn/UvPJS0/ayXBJjk/NHlHR3gqCkhoc9nc+2Pfe2qKu4atjKMOXKPZeIg==
Date:   Wed, 15 Mar 2023 10:30:48 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the nvmem tree
Message-ID: <20230315103048.2af51629@xps-13>
In-Reply-To: <20230315124612.6cb48c72@canb.auug.org.au>
References: <20230315124612.6cb48c72@canb.auug.org.au>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

sfr@canb.auug.org.au wrote on Wed, 15 Mar 2023 12:46:12 +1100:

> Hi all,
>=20
> After merging the nvmem tree, today's linux-next build (htmldocs)
> produced these warnings:
>=20
> drivers/of/base.c:1228: warning: Function parameter or member 'alias' not=
 described in 'of_alias_from_compatible'
> drivers/of/base.c:1228: warning: Excess function parameter 'modalias' des=
cription in 'of_alias_from_compatible'
>=20
> Introduced by commit
>=20
>   c077ed868e50 ("of: Rename of_modalias_node()")

I failed to update all occurrences of "modalias" in this function. Here
is a diff that you can squash directly with the above mentioned commit.
I can submit it through the mailing list as well, but I believe it's
best to squash that based on the previous conversations (and it does
not matter since you re-send the patches to Greg in the end).

Thanks,
Miqu=C3=A8l

---

=46rom f1378f89b9964fea759eabf5a54beee2782890c7 Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 15 Mar 2023 10:25:28 +0100
Subject: [PATCH] fixup! of: Rename of_modalias_node()

---
 drivers/of/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 3c1badab287f..161fe3192c46 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1211,7 +1211,7 @@ EXPORT_SYMBOL(of_find_matching_node_and_match);
  * of_alias_from_compatible - Lookup appropriate alias for a device node
  *			      depending on compatible
  * @node:	pointer to a device tree node
- * @modalias:	Pointer to buffer that alias value will be copied into
+ * @alias:	Pointer to buffer that alias value will be copied into
  * @len:	Length of alias value
  *
  * Based on the value of the compatible property, this routine will attempt
--=20
2.34.1

