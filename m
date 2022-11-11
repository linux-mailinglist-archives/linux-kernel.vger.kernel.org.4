Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBF462525E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiKKEXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiKKEXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:23:17 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A883345A3E;
        Thu, 10 Nov 2022 20:23:16 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1otLZH-00CqDB-D2; Fri, 11 Nov 2022 12:23:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Nov 2022 12:23:03 +0800
Date:   Fri, 11 Nov 2022 12:23:03 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nicolai Stange <nstange@suse.de>
Cc:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vladis Dronov <vdronov@redhat.com>,
        Stephan Mueller <smueller@chronox.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] crypto: xts - restrict key lengths to approved
 values in FIPS mode
Message-ID: <Y23OJ79fZrbC/i1D@gondor.apana.org.au>
References: <20221108142025.13461-1-nstange@suse.de>
 <20221108142025.13461-2-nstange@suse.de>
 <MW5PR84MB1842EEC44A8CB6594D4D0CD0AB3F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <8735asfnmu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735asfnmu.fsf@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:06:17AM +0100, Nicolai Stange wrote:
>
> >From a quick glance, all of the above drivers merely convert some
> crypto_skcipher to a crypto_tfm before passing it to xts_check_key().
> 
> So I think these should all be made to call xts_verify_key() directly
> instead, the former xts_check_key() could then get dropped. But that's
> more of a cleanup IMO and would probably deserve a separate patch series
> on its own.

We should make sure both do the same thing though.  So either
change all the drivers or just change xts_check_key in your patch
in addition to xts_verify_key.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
