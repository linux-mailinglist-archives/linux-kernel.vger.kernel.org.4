Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DD670D365
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 07:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjEWFyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 01:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjEWFyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 01:54:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EADE10C;
        Mon, 22 May 2023 22:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=eOGZvrq3UBHLVwcyH2qrgqkXe/JNZU3LR0Uo24SPRYo=; b=HdUN3Ej40ryPCtevS9RP5MpOym
        PJ5fCk7iN+O2p0Gg7Vx9q561Q+pIGJqVDNlfsNLWq5dNpMQ+1f7yyOzkwdjGifbihW+jokibf/1Xi
        +KFCMCh33cf7eAUXnTQOg3y8WBzzawjuA8WFHOIV9WcXPWznOHOGrgdi8kUgQ3mSLrx5mKFo33QOX
        vTg2A6ghVGhhb6XpwdK55eob7dsB2BhHHVkyr5l5iGxIs01S2OUx/5B3+2rOIBwjk+stcxRDKXXAz
        bYNo/OF6wHY6YMnHgGLauBIYau11m5RBZfiRR2esXnJVpD7PFqErjKqKCKaFuUUiUuEYdeIKOEfXV
        ZdaFZxZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1KyF-0091Bs-2V;
        Tue, 23 May 2023 05:54:07 +0000
Date:   Mon, 22 May 2023 22:54:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] md/raid5: Convert stripe_head's "dev" to flexible array
 member
Message-ID: <ZGxU/zSGkqGhGWmF@infradead.org>
References: <20230517233313.never.130-kees@kernel.org>
 <ZGWpLClY7vz+xl5A@infradead.org>
 <229ac866-9710-5dbe-80c4-61498f807662@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <229ac866-9710-5dbe-80c4-61498f807662@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 07:49:38PM +0800, Yu Kuai wrote:
> Hi, Christoph
> 
> 在 2023/05/18 12:27, Christoph Hellwig 写道:
> 
> It's not related to this patch, just I think I found a problem while
> reviewing raid5 code, commit e82ed3a4fbb5 ("md/raid6: refactor
> raid5_read_one_chunk") changes the caculation of 'end_sector',
> 'end_sector' is compared to 'rdev->recovery_offset', so it should be
> offset to rdev, but this commit change it to offset to the array.
> 
> Perhaps following change will make sense:

Yes, I think it does.  Can you send a patch?
