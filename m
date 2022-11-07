Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2851761ED4B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiKGIra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiKGIr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:47:27 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C40C62;
        Mon,  7 Nov 2022 00:47:25 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1orxmH-00AyMB-Ht; Mon, 07 Nov 2022 16:47:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 07 Nov 2022 16:47:22 +0800
Date:   Mon, 7 Nov 2022 16:47:22 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "yekai (A)" <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 1/4] crypto: hisilicon/qm - modify the process of regs
 dfx
Message-ID: <Y2jGGuewePunGPtl@gondor.apana.org.au>
References: <20221105095357.21199-1-yekai13@huawei.com>
 <20221105095357.21199-2-yekai13@huawei.com>
 <Y2Y4hWc+cUJ4VZgy@gondor.apana.org.au>
 <45cf9fba-fae6-8279-bfac-f70110df42dc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45cf9fba-fae6-8279-bfac-f70110df42dc@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 02:53:28PM +0800, yekai (A) wrote:
> 
> 
> On 2022/11/5 18:18, Herbert Xu wrote:
> > On Sat, Nov 05, 2022 at 09:53:54AM +0000, Kai Ye wrote:
> >> +static void dfx_regs_uninit(struct hisi_qm *qm,
> >> +		struct dfx_diff_registers *dregs, int reg_len)
> >> +{
> >> +	int i;
> >> +
> >> +	/* Setting the pointer is NULL to prevent double free */
> >> +	for (i = 0; i < reg_len; i++) {
> >> +		kfree(dregs[i].regs);
> >> +		dregs[i].regs = NULL;
> >> +	}
> >> +	kfree(dregs);
> >> +	dregs = NULL;
> >> +}
> > The line that I complained about is still here.
> >
> > Cheers,
> 
> ok

Just to be clear, it's the last line "dregs = NULL" that I was
referring to.  It makes no sense to zero a variable that is on
the stack.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
