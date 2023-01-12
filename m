Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168F7667EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbjALTFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbjALTF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:05:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F0F13D1B;
        Thu, 12 Jan 2023 10:46:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9AD9B81FF6;
        Thu, 12 Jan 2023 18:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE49C433EF;
        Thu, 12 Jan 2023 18:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673549204;
        bh=GHrrw9qWTNs9t2tpYUa9+9mfy+wwMMMsbxkrugEewro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqzU1sWiKO8tXO1ihDuCoL1L8AQHSCRRqpSb+oW4k1a9ekg6D06NmQF3erceORHkV
         JzTGIgfa4O6Xzcs3qOB2FSDHOrb+gozwM+/IhExZ4qAb6cxoZHh3H5nY+42mZax8P9
         MedhJ6GtVLC1cX2B4TN0pOrAny1/v1A2+N0BgOLItFZLPBfHFFsQd+WTI21zp7TQI2
         rh3dq5iAc6ZYoWXMZfDNv5fYsZyjBrhJvvx1lb96E/WKmv6YnS1o3XkwcXzzgqOWvO
         rQ0gVutZXWwewlX2gy9gOgvYgtB7lBOMdEIs6HwH5hoxeefb4t9j+cxQuFJ1t5d4jU
         YN3KiXUu4tifA==
Date:   Thu, 12 Jan 2023 10:46:42 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Robert Elliott <elliott@hpe.com>, davem@davemloft.net,
        Jason@zx2c4.com, ardb@kernel.org, ap420073@gmail.com,
        David.Laight@aculab.com, tim.c.chen@linux.intel.com,
        peter@n8pjl.ca, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] crypto: x86/sha - yield FPU context during long
 loops
Message-ID: <Y8BVkjwPc6DLm7HT@sol.localdomain>
References: <20221219220223.3982176-1-elliott@hpe.com>
 <20221219220223.3982176-4-elliott@hpe.com>
 <Y7+/Yy7+mLEyqeiK@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7+/Yy7+mLEyqeiK@gondor.apana.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 04:05:55PM +0800, Herbert Xu wrote:
> On Mon, Dec 19, 2022 at 04:02:13PM -0600, Robert Elliott wrote:
> >
> > @@ -41,9 +41,7 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
> 
> I just realised a show-stopper with this patch-set.  We don't
> have a desc->flags field that tells us whether we can sleep or
> not.
> 
> I'm currently doing a patch-set for per-request keys and I will
> add a flags field to shash_desc so we could use that for your
> patch-set too.
> 

Right, this used to exist, but it didn't actually do anything, and it had
suffered heavily from bitrot.  For example, some callers specified MAY_SLEEP
when actually they couldn't sleep.  IIRC, some callers also didn't even bother
initializing the flags, so they were passing uninitialized memory.  So I removed
it in commit 877b5691f27a ("crypto: shash - remove shash_desc::flags").

Has there been any consideration of just adding the crypto_shash_update_large()
helper function that I had mentioned in the commit message of 877b5691f27a?

- Eric
