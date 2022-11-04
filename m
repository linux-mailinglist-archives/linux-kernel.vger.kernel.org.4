Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F013E61931D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiKDJFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiKDJFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:05:48 -0400
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B0C29C94;
        Fri,  4 Nov 2022 02:05:47 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oqsdQ-00A1bz-GQ; Fri, 04 Nov 2022 17:05:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Nov 2022 17:05:44 +0800
Date:   Fri, 4 Nov 2022 17:05:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] crypto: hisilicon/qm - modify the process of regs dfx
Message-ID: <Y2TV6Cz7XPYj4SZO@gondor.apana.org.au>
References: <20221029094801.43843-1-yekai13@huawei.com>
 <20221029094801.43843-2-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029094801.43843-2-yekai13@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 09:47:59AM +0000, Kai Ye wrote:
>
> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
> index 363a02810a16..832cfd9a7728 100644
> --- a/drivers/crypto/hisilicon/qm.c
> +++ b/drivers/crypto/hisilicon/qm.c
> @@ -1722,8 +1722,22 @@ static int qm_regs_show(struct seq_file *s, void *unused)
>  
>  DEFINE_SHOW_ATTRIBUTE(qm_regs);
>  
> +static void dfx_regs_uninit(struct hisi_qm *qm,
> +		struct dfx_diff_registers *dregs, int reg_len)
> +{
> +	int i;
> +
> +	/* Setting the pointer is NULL to prevent double free */
> +	for (i = 0; i < reg_len; i++) {
> +		kfree(dregs[i].regs);
> +		dregs[i].regs = NULL;
> +	}
> +	kfree(dregs);
> +	dregs = NULL;

What's the point of this last NULL assignment?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
