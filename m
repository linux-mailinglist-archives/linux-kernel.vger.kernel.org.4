Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50147432C1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 04:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjF3CbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 22:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjF3CbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:31:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325D21BE9;
        Thu, 29 Jun 2023 19:31:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2F6A6167E;
        Fri, 30 Jun 2023 02:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4888C433C8;
        Fri, 30 Jun 2023 02:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688092269;
        bh=J6nxjWywyEiSc/t5QFa8u5nsfvS0YlDiw8/BL0IXBxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lNBjSCGWJDyJ8VTTSG6JJ9p05nFKXRvImX8g45EoM2SCrEoaYICiF3Wl3kwEpT50q
         tq2x+SLtMY4y3jK24n0lSWYuLMXt8b8zUbUm30ihQkoaa3WWLUa3Dsu0M453iWt2ic
         xLb/E20+JWD783RLwh4ZCsYEHE7l2z1F80jv7GJ3PmYiAFS7+ej5XskPijm4wU+V7h
         pDM1ZHUG+jjThxaoUJ9tAvFAzkqryjk/KxT3YI28x4lj6I/8nDG8cZVv7p580MXPLi
         Xb/817/cvBf6wpKU5YX5I2xjLRNiaT9sicyTCjEg4MlvbSuUE87hkXgST3XQMa8+Lu
         CcZtNLW7UDLWQ==
Date:   Thu, 29 Jun 2023 19:31:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Tyler Hicks <code@tyhicks.com>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fs/ecryptfs: Replace kmap{,_atomic}() with
 kmap_local_page()
Message-ID: <20230630023107.GA1088@sol.localdomain>
References: <20230426172223.8896-1-fmdefrancesco@gmail.com>
 <23780760.ouqheUzb2q@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23780760.ouqheUzb2q@suse>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 03:50:30PM +0200, Fabio M. De Francesco wrote:
> On mercoledì 26 aprile 2023 19:22:20 CEST Fabio M. De Francesco wrote:
> > kmap() and kmap_atomic() have been deprecated in favor of
> > kmap_local_page().
> > 
> > Therefore, replace kmap() and kmap_atomic() with kmap_local_page().
> 
> After two months from submission, I haven't received any comments on this 
> short series yet, except for a "Reviewed by" tag from Ira on patch 1/3 only.
> 
> I would appreciate any comments/reviews/acks and would especially like to know 
> if anything is preventing these patches from being applied.
> 

eCryptfs is in "Odd Fixes" status.  See the thread
https://lore.kernel.org/ecryptfs/ZB4nYykRg6UwZ0cj@sequoia/T/#u

I would suggest that if Tyler is not responding, that Christian or Al take these
patches through the VFS tree instead.

FWIW, I took a quick look at these three patches, and all look correct.  I'm not
sure I want to give a formal R-b, as I don't want people to start bothering me
about eCryptfs stuff because they saw my name on it :-)

- Eric
