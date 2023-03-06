Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9006AB5A9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCFEly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCFElv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:41:51 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D85CB47B;
        Sun,  5 Mar 2023 20:41:50 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pZ2fF-000dzu-KO; Mon, 06 Mar 2023 12:41:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 06 Mar 2023 12:41:33 +0800
Date:   Mon, 6 Mar 2023 12:41:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Subject: [v6 PATCH 0/7] crypto: stm32 - Save and restore between each request
Message-ID: <ZAVu/XHbL9IR5D3h@gondor.apana.org.au>
References: <Y/yIbPBVCPx9K/0s@gondor.apana.org.au>
 <CACRpkdZC4z2Xng4=k94rmM=AFzNzTdXkvtkArMnK7afouz=7VA@mail.gmail.com>
 <Y/3FYZJeLE7DVPBf@gondor.apana.org.au>
 <Y/3IA4OjmUmjMgh1@gondor.apana.org.au>
 <Y/3N6zFOZeehJQ/p@gondor.apana.org.au>
 <CACRpkdZ3rCsOWqooNkPL6m7vZ2Z2Frh2sdxruKhrS0t3QHcSKw@mail.gmail.com>
 <Y/6sCC2nH0FcD6kJ@gondor.apana.org.au>
 <CACRpkdYN-SDfxXKLt3HWGVkWb3V1rABwvWuytwDrzfTqm81fNA@mail.gmail.com>
 <ZAA8doNUjYmTRScB@gondor.apana.org.au>
 <ZAMQjOdi8GfqDUQI@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAMQjOdi8GfqDUQI@gondor.apana.org.au>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2023 at 05:34:04PM +0800, Herbert Xu wrote:
> 
> I've split the patch up into smaller chunks for easier testing.

v6 fixes a bug in the finup patch that caused the new data to
be discarded instead of hashed.

This patch series fixes the import/export functions in the stm32
driver.  As usual, a failure in import/export indicates a general
bug in the hash driver that may break as soon as two concurrent
users show up and hash at the same time using any method other
than digest or init+finup.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
