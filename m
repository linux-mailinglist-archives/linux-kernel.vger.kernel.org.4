Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19AF6142DE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 02:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiKABrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 21:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiKABrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 21:47:09 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0929417059;
        Mon, 31 Oct 2022 18:47:07 -0700 (PDT)
Received: from letrec.thunk.org (guestnat-104-133-8-97.corp.google.com [104.133.8.97] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2A11ks0o027540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 21:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1667267217; bh=K7F7eAuVL6eJwWHS+KAn77FNAn3sfayK8RIGACJmqzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HhE/pQEUvwvAlquMRH039fGiNRskX+pEammhnhkH56kYXDEX4Zhwg1QPnpA5ZpQrN
         G2f4nrsBFPD+gXITYMO4YRhrrPTzV1mTzpTgIl/EC+bGmEL6haAeS/Htc1fLjy2sF3
         zgJ4mdld+opJURk+t0hri19lf/ZwFUw8p2k8Av7cJ+DDwgRepY8j0FSgosRi/ePh23
         E4762KLk9Uj+2DaN6C5CnTMYaTrPYm+ksJwn3dJaXTzntC2hG9PQHa5OMKhGTG0RIb
         rpr7bENmcrC5AsLs91y60MlV4s6IAjs7imXZwAU1w7YqQ3VXnqwkmJq5BhIFGuZA0+
         3LsUrlLQWSi1A==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 064888C2A08; Mon, 31 Oct 2022 21:46:54 -0400 (EDT)
Date:   Mon, 31 Oct 2022 21:46:53 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: linux interprets an fcntl int arg as long
Message-ID: <Y2B6jcLUJ1F2y2yL@mit.edu>
References: <Y1/DS6uoWP7OSkmd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1/DS6uoWP7OSkmd@arm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 12:44:59PM +0000, Szabolcs Nagy wrote:
> and such fcntl call can happen with c code that just passes
> F_SEAL_WRITE since it is an int and e.g. with aarch64 pcs rules
> it is passed in a register where top bits can be non-zero
> (unlikely in practice but valid).

In Linux's aarch64 ABI, an int is a 4-byte value.  It is *not* an
8-byte value.  So passing in "F_SEAL_WRITE | 0xF00000000" as an int
(as in your example) is simply not valid thing for the userspace
program to do.

Now, if there is a C program which has "int c = F_SEAL_WRITE", if the
PCS allows the compiler to pass a function paramter c --- for example
f(a, b, c) --- where the 4-byte paramter 'c' is placed in a 64-bit
register where the high bits of the 64-bit register contains non-zero
garbage values, I would argue that this is a bug in the PCS and/or the
compiler.

						- Ted
