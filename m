Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219AE6ABD04
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjCFKft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjCFKfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:35:41 -0500
X-Greylist: delayed 429 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 02:35:32 PST
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32B3E7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 02:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1678098498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u4rIRxinr1EJC64oGURBJXPpjgsfhmHhuJGOQcUl8tE=;
        b=rAaAT61zalUbEGC0cLwVXUhioa+LItZAlbQ3YmF0F4I1r4jYt5u8Im+5gN4rJfHpffPApz
        0tsp14AMog/mS0eFrWXNpQq8uRDoEw1vfN4fLHxb4gatzK2qOcQGppyMTRsBy8iCEsQd5X
        X0wvVVEpTzDujuCxYEvWN5W8Dhdgd8M=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Bauer <mail@david-bauer.net>
Subject: Re: [PATCH 1/2] MIPS: Add barriers between dcache & icache flushes
Date:   Mon, 06 Mar 2023 11:28:15 +0100
Message-ID: <4818332.31r3eYUQgx@ripper>
In-Reply-To: <1456164585-26910-1-git-send-email-paul.burton@imgtec.com>
References: <1456164585-26910-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4473054.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4473054.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 06 Mar 2023 11:28:15 +0100
Message-ID: <4818332.31r3eYUQgx@ripper>
References: <1456164585-26910-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0

On Monday, 22 February 2016 19:09:44 CET Paul Burton wrote:
> Index-based cache operations may be arbitrarily reordered by out of
> order CPUs. Thus code which writes back the dcache & then invalidates
> the icache using indexed cache ops must include a barrier between
> operating on the 2 caches in order to prevent the scenario in which:
> 
>   - icache invalidation occurs.
> 
>   - icache fetch occurs, due to speculation.
> 
>   - dcache writeback occurs.
> 
> If the above were allowed to happen then the icache would contain stale
> data. Forcing the dcache writeback to complete before the icache
> invalidation avoids this.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> ---

What happened to this patch? Because it seems like it is required for some 
74kc devices to get them booting (instead of being stuck in an endless
tlbmiss_handler_setup_pgd loop):

* https://github.com/freifunk-gluon/gluon/issues/2784
* https://github.com/openwrt/openwrt/commit/ea6fb9c16dfb9763ea681803db65644b68bae873
* https://github.com/freifunk-gluon/gluon/pull/2810

Kind regards,
	Sven
--nextPart4473054.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmQFwD8ACgkQXYcKB8Em
e0bR3Q//Riq/B7nemvF/RQ63b4IjVgBkq81+RlQ6xLBdaDEnFr8phcT8RnSJ74tb
ljc8OkXvqL56Ddt9svcyBRHma4gu3UbowdxJCMw4xgv6SV0Fa8yd0Yk5NSlvOsv2
dlg21L+515rYEz9Ow/FcvC1x60CIOTZLMIw87qu2lOgQY7SdG0QB4z/GZWg6xubR
J3iHMB1b0JGdZRLA+u5GK0235oZXU0zbMk8ZOovu111E7AMULcnwCmbUvPEbr21k
Gw1BPAuYYpb8h3dk3lkY3GxkwGyeZrblFiOav8pd2y73hDdWgo4da8t+BCAUV4oM
Ks7DabVTGZyAFlXcrQZ0RczK3C6MZF6Z1KXSuJxI2NiTNvl78OUbfek9DDVYgA8g
nLcjXNZtoOVoF5/1I8+7bCcNnXwfhaEHidO0IkY9RkezYoQWeFeIeLfaV2BFFwG7
RllYLH/NJGVAWJJrmcZEWF6v9Q6w/G/QySO+OjJ007Ph9HyjWLmiHGrizOkkTj0z
KozMR8iRY6bpT6B+t2Zm0xmN9JRDpHRgCVkqZcE4BF2fptwcB/7GsfiogJ7heiIL
OyDLNNoUmE7I6eJDCR/bHL4yLHp/8SctrD/wB7nk9NEouhXeCtqw/xg5e2elOBGw
7K3T3F5lICq0FXFZg5dM863XK7sCeIVzObj2O9CBuS3BGZhwDL4=
=WpWD
-----END PGP SIGNATURE-----

--nextPart4473054.LvFx2qVVIh--



