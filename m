Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED38707354
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjEQUt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjEQUtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:49:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7550A5EF
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:49:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B03260DD7
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78240C433D2;
        Wed, 17 May 2023 20:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684356557;
        bh=ESwHDFeH9sFs7LqoayE2LYshu3gFC0OnzfRGKxNaVuM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wh1XKXEWZpvLmsUnr/6T6ZYtnllDQ4ytqasvLJwOG4J2KTVMQ+QrmP0j8gs1Iw/oG
         H/8oA56+KSt0n0frYaPHICgsQYuNkwtiriDnXYFeSB5ZOJkSqaUkN8AY+oYKhrkICU
         aWinx5bNyUeSEyuTjSFhHs9SY2k8RFAXI0zhEV3w=
Date:   Wed, 17 May 2023 13:49:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nick Terrell <terrelln@fb.com>, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] decompressor: provide missing prototypes
Message-Id: <20230517134916.717bdcc4ba26e10462157ee9@linux-foundation.org>
In-Reply-To: <20230517131936.936840-1-arnd@kernel.org>
References: <20230517131936.936840-1-arnd@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 15:19:31 +0200 Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The entry points for the decompressor don't always have a prototype
> included in the .c file:
> 
> lib/decompress_inflate.c:42:17: error: no previous prototype for '__gunzip' [-Werror=missing-prototypes]
> lib/decompress_unxz.c:251:17: error: no previous prototype for 'unxz' [-Werror=missing-prototypes]
> lib/decompress_unzstd.c:331:17: error: no previous prototype for 'unzstd' [-Werror=missing-prototypes]
> 
> include the correct headers for unxz and unzstd, and mark the
> inflate function above as unconditionally 'static' to avoid
> these warnings.

These are errors, not warnings?

Under what circumstances do they occur?

Shouldn't we cc:stable?  If so, do we have a suitable Fixes: target?


