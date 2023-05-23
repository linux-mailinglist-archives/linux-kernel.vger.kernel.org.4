Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CF870E171
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbjEWQGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbjEWQG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:06:28 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81C3ADD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:06:26 -0700 (PDT)
Received: from 8bytes.org (p4ff2bfbf.dip0.t-ipconnect.de [79.242.191.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 1D123248213;
        Tue, 23 May 2023 18:06:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1684857985;
        bh=Cc7Z575w9OHnuRMKyEykBUybs3nqdvfXSYDzqPP4KQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j3fxFTnLQG/Wt2JKYs78Sx+KYCeldo1rqdimm9+CdnUhkEB/3Jmv15umo9Q+3WsBP
         MnVvnITW8NdYZTuMbGex6zTZrtKSMS+XtX6jgCGs/BdjhBWpp7nZBZ6OoWKGZwXrz2
         PeRBW+XpQwcufWekPPlHW+NnHmorN3XLxCQbzt7n8aJx4VnY1OWLtpkugpl+luQmf2
         cbm3/vNNvfC+oic42KdlMw1cesK0LCgRK3Ou/sJ9Bq75uNyho1W7eMKcsghV1MC2OP
         wB6QEfsHk+LSVZh5GdYuCZ/n5tfRaHV/XFu/aASp7Vi/Ad1XiJn5CayQQ3w6bOFP5o
         qWl8jA3PEEssA==
Date:   Tue, 23 May 2023 18:06:23 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
Message-ID: <ZGzkf68s_0H-jFS7@8bytes.org>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
 <ZDk83vpIarQ9jWa7@8bytes.org>
 <cef7bb32-a302-2220-68a6-726b45f91769@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cef7bb32-a302-2220-68a6-726b45f91769@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 06:45:57PM +0100, Robin Murphy wrote:
> Sounds good - I'm considerably more confident in this approach, but although
> it should not be able to break any scenario which wasn't already broken, it
> could potentially still make such a breakage more noticeable. Thus in all
> honesty I'd feel happiest giving it a full cycle of -next coverage as well.

I had some second thoughts on this, wouldn't it be better to change the
allocator to allocate from lowest addresses first? Then we can just
remove the SAC trick and rely on dma-masks only.

Thoughts?

Regards,

	Joerg
