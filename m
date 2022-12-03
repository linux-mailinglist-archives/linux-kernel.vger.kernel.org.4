Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE686412E8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiLCBDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiLCBDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:03:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D37BDF621;
        Fri,  2 Dec 2022 17:03:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7B6E62454;
        Sat,  3 Dec 2022 01:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CD1C433C1;
        Sat,  3 Dec 2022 01:03:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="o0jkKGOh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670029422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j6bZwrTUHq7dBuwU+bEsBeXOQjWTTzwBJH6CCe+MexE=;
        b=o0jkKGOhHEPlso7/XPa+9klWAw4KZC1iMj9yOcAdjahvoo81K1TSO6QStoVtjlvam4J+Ug
        Qy4h6qX0sngbO14SB2wuhLg2mg+UFfUbACYVE7S/CgE0Tu5lfGj6F1Ol/vRjGHLbheLzs0
        0vREd3ty69xzlF4M2HzcpuKRnLxq588=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b651a5ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 3 Dec 2022 01:03:41 +0000 (UTC)
Date:   Sat, 3 Dec 2022 02:03:33 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     kuba@kernel.org, tytso@mit.edu, elver@google.com,
        yury.norov@gmail.com, linux@dominikbrodowski.net,
        gregkh@linuxfoundation.org, pmladek@suse.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] random: Include <linux/once.h> in the right header
Message-ID: <Y4qgZUfcnQvL3hYm@zx2c4.com>
References: <212adb212cb0234a7d395daf31b2578b9409d492.1670015476.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <212adb212cb0234a7d395daf31b2578b9409d492.1670015476.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Fri, Dec 02, 2022 at 10:13:36PM +0100, Christophe JAILLET wrote:
> <linux/prandom.h> uses DO_ONCE(). So it should include <linux/once.h>
> directly.
> 
> On the contrary, <linux/random.h> doesn't use functionalities from
> <linux/once.h>, so it should be removed.
> 
> All this is true since commit c0842fbc1b18 ("random32: move the
> pseudo-random 32-bit definitions to prandom.h")
> 
> Move the #include <linux/once.h> in the right file.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks, applied for now as:
https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=1ea746beac98ad11132b0a9a11978d5cf0a055ef

> ---
> Let see if build-bots agree with me!

Indeed. I've got a few builds of my own going, and so far so good, but
we'll learn soon enough if something goes wrong.

Jason
