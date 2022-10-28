Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7584B61173F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiJ1QPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiJ1QOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:14:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D72C22D5B9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D40B7B82AF6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21C2C433C1;
        Fri, 28 Oct 2022 16:12:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="odZXnhFJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666973554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F/z1yxXZOQ+LSS3+ThRvHQzCQzesuCefwixcqvqnFBg=;
        b=odZXnhFJgcdnrsQcgnQ9r+QAN7h5LNfXtMY0Bd3sStOF6pj4Mdz5aphWmFaJZw5ozFfPHY
        9yr3J2pqEME/9IH2dVjwN+WehEb0pAJQ8v3YzYgRC7csSNfzWGjx+0BdJ+8QglE8+S14Ht
        b+W8aEcYtz9uaZKYyr58WOJM42b+4EQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 647a0259 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 28 Oct 2022 16:12:34 +0000 (UTC)
Date:   Fri, 28 Oct 2022 18:12:22 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     tytso@mit.edu, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        andre.przywara@arm.com
Subject: Re: [PATCH] random: Use arch_get_random*_early() in random_init()
Message-ID: <Y1v/ZkT4nOrKI2Y9@zx2c4.com>
References: <20221028160041.753052-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221028160041.753052-1-jean-philippe@linaro.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 05:00:42PM +0100, Jean-Philippe Brucker wrote:
> While reworking the archrandom handling, commit d349ab99eec7 ("random:
> handle archrandom with multiple longs") switched to the non-early
> archrandom helpers in random_init(), which broke initialization of the
> entropy pool from the arm64 random generator.
> 
> Indeed at that point the arm64 CPU features, which verify that all CPUs
> have compatible capabilities, are not finalized so arch_get_random_seed_longs()
> is unsuccessful. Instead random_init() should use the _early functions,
> which check only the boot CPU on arm64. On other architectures the
> _early functions directly call the normal ones.
> 
> Fixes: d349ab99eec7 ("random: handle archrandom with multiple longs")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Thank you for catching this. I'll get this queued up for the next rc.

Jason
