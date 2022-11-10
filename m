Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6D7623E07
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiKJIxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiKJIxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:53:25 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BCA2EF17;
        Thu, 10 Nov 2022 00:53:20 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ot3J3-00CUP3-Vh; Thu, 10 Nov 2022 16:53:07 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 10 Nov 2022 16:53:05 +0800
Date:   Thu, 10 Nov 2022 16:53:05 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     liulongfang <liulongfang@huawei.com>
Cc:     wangzhou1@hisilicon.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto/hisilicon: Add null judgment to the callback
 interface
Message-ID: <Y2y78USk4bXRrRun@gondor.apana.org.au>
References: <Y1tTLAEi7ukUCCmB@gondor.apana.org.au>
 <a1229856-fbe4-9ae7-5789-332ed0af87eb@huawei.com>
 <Y2TWpyynYMyStKRX@gondor.apana.org.au>
 <d914a099-06ef-acfe-f394-f4790a821598@huawei.com>
 <Y2oodE+5us++mbSl@gondor.apana.org.au>
 <df561fbe-12eb-25b0-2173-a7ffb3bfd53a@huawei.com>
 <Y2twbHyQkTMoTz+O@gondor.apana.org.au>
 <32686c5b-04b2-7103-bf2e-113db2315ef4@huawei.com>
 <Y2xt7/6WGN+uthpL@gondor.apana.org.au>
 <40a0e7aa-362a-0de7-76c0-77381c07f254@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40a0e7aa-362a-0de7-76c0-77381c07f254@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 12:11:15PM +0800, liulongfang wrote:
>
> When using crypto's skcipher series interfaces for encryption and decryption
> services, User can use synchronous mode(by adjusting some skcipher interfaces,
> here is to remove skcipher_request_set_callback()) or asynchronous mode,
> but when using synchronous mode and the current asynchronous mode is loaded
> it will cause a calltrace.
> 
> The current problem is that the interface of skcipher does not restrict users
> to call functions in this way for encryption services.
> 
> If the current driver doesn't handle this, there is a possibility that some users
> deliberately create this kind of problem to cause the kernel to crash.

It sounds like your code is misusing the skcipher API.  By default
skcipher is always async.  You must always set a callback.

The only way to legally use skcipher without setting a callback
is by allocating it with crypto_alloc_sync_skcipher.  In which case
unless your driver incorrectly declares itself as sync instead of
async, then it will never be used by such a user.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
