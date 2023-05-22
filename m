Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FFB70CC3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjEVVVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjEVVVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:21:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F88C6;
        Mon, 22 May 2023 14:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o45skQCW05aoS9DI6od2cBGCBFOyyDBnDFRMJXiZwBM=; b=4N/sUcZ9BUoADLYog1KHCCG9qq
        1MmC0l7U7MMFm/pb/CMiCEGhHde5YvdPAClCnWx6m1AjjWqY1ZXKhjoINwzDcGKGDC0tsBFdRm9QK
        jTxHymltoxiw0ciU9pqQwK9wliQ9ZnW7lDDn4lY54MVMGvallddVj9/Hd7J73nf0RPH3b2vwME+GG
        BVhH02LYW+hYeukDo6BnRrtnvDEnfQBxHVg7Sy2fSS+FgOoHfqPl3vhHtPA4sPnL7z+WIutCS+6K2
        O43+3k6ZX/ZvGJpcoqlzWY1W2eiWEzKqIXnvhPwuT2UxM+8U+ylxCXGLrd/KKBmvGSc3pZ+7q+KwT
        8OJ7MaoQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1CyQ-0085ER-0X;
        Mon, 22 May 2023 21:21:46 +0000
Date:   Mon, 22 May 2023 14:21:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        error27@gmail.com, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] module: Fix use-after-free bug in read_file_mod_stats()
Message-ID: <ZGvc6tMIlvcp8zvt@bombadil.infradead.org>
References: <20230428055933.2699308-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428055933.2699308-1-harshit.m.mogalapalli@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 10:59:33PM -0700, Harshit Mogalapalli wrote:
> Smatch warns:
> 	kernel/module/stats.c:394 read_file_mod_stats()
> 	warn: passing freed memory 'buf'
> 
> We are passing 'buf' to simple_read_from_buffer() after freeing it.
> 
> Fix this by changing the order of 'simple_read_from_buffer' and 'kfree'.
> 
> Fixes: df3e764d8e5c ("module: add debug stats to help identify memory pressure")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---

Queued up, thanks!

  Luis
