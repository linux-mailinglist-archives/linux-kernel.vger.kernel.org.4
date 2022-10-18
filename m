Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49573603689
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 01:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJRXNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 19:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJRXM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 19:12:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D910D9975;
        Tue, 18 Oct 2022 16:12:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3079E6172B;
        Tue, 18 Oct 2022 23:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2FAC433D7;
        Tue, 18 Oct 2022 23:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666134777;
        bh=zAnnqu7LhBmRWLrdfLAcvE/gCuxlY2MD9KNTKUyVGZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKjN9D7rQtnFYJ9p+HSVeLOQ+kUtgUSqwkTyjxqDSZEtE4Lp+/zwxO3jzeiRw2ecp
         qMiS67h/UT5FLBkcsW80OTK/lqHjqEx7s5zGY0j7e+LpMvvBVqtIbbGfYRAGGCOAaE
         amhhyolBLZNwFTH/U9IKXGneycP1lw/hrNy147Hl6UgXFYuXS7tZi+84Ejy3L24mYu
         60jntxn8d61rBXv4r8w+p0kMQu8F2LMDn/3nXyvg5demuKjg9jSpF2/FvvwWgwp43z
         9ElW5ZRKaKkaaR2npXjbXcx8m+WG0rNa8/gT+kPD67L8bTrzrlcYu4Zk0Nu+5/+mLA
         8D1I5lUx08F6Q==
Date:   Tue, 18 Oct 2022 16:12:55 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     ardb@kernel.org, bgoncalv@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, hpa@zytor.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v3] crypto: x86/polyval - Fix crashes when keys are not
 16-byte aligned
Message-ID: <Y08y9yXAimRj3Dih@sol.localdomain>
References: <Y08rHF09/qxCVK+K@sol.localdomain>
 <20221018230412.886349-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018230412.886349-1-nhuck@google.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 04:04:12PM -0700, Nathan Huckleberry wrote:
> crypto_tfm::__crt_ctx is not guaranteed to be 16-byte aligned on x86-64.
> This causes crashes due to movaps instructions in clmul_polyval_update.
> 
> Add logic to align polyval_tfm_ctx to 16 bytes.
> 
> Fixes: 34f7f6c30112 ("crypto: x86/polyval - Add PCLMULQDQ accelerated implementation of POLYVAL")
> Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

Reviewed-by: Eric Biggers <ebiggers@google.com>

Please add 'Cc: stable@vger.kernel.org' as well.  (Herbert can do it when
applying this patch, if you don't happen to send another version.)

- Eric
