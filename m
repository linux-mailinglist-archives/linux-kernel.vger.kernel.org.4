Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B651B6E553C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjDQXc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjDQXcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:32:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E7E4C11;
        Mon, 17 Apr 2023 16:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4jJLpINeP4OklWMhxOHBEJLZ8k/QyGxF4mmp0r0Gq3k=; b=1B7jUH2Wg0+5CDmYgHJwaljxiW
        YW/gqsuTGwLkGXElLq0YLmpdGyDT8jqdDbSy3Mk30YE9iJSya/YtNVv6BqnWKvENpVzBujk0BdHPq
        xrY7NBKVO0k+afXsE59k7GT6Y7ppFLjuhmptBwRIW80ADdmRq6mUvAkoBrSoDg9/I4rsPrt/SqcI1
        0JcnVQYIxZJoM5v/Wuhdsbcs2AxOUDqh9KmOrDqzqcDWi3YG6GuuSkqXGw5m3szQo7VT8oWhmPojO
        zAtVY5oB3Gqi4Wv+eVpXqtGH/mWxrufX98RFR2MVnvtKbml7TScHili+Y8JRTUwvsyvZLd9GLQnkk
        sxFBF4ag==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1poYKZ-000PLl-0l;
        Mon, 17 Apr 2023 23:32:19 +0000
Date:   Mon, 17 Apr 2023 16:32:19 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] module: remove use of uninitialized variable len
Message-ID: <ZD3XA/OBdHEhzX5q@bombadil.infradead.org>
References: <20230417230957.3221615-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417230957.3221615-1-trix@redhat.com>
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

On Mon, Apr 17, 2023 at 07:09:57PM -0400, Tom Rix wrote:
> clang build reports
> kernel/module/stats.c:307:34: error: variable
>   'len' is uninitialized when used here [-Werror,-Wuninitialized]
>         len = scnprintf(buf + 0, size - len,
>                                         ^~~
> At the start of this sequence, neither the '+ 0', nor the '- len' are needed.
> So remove them and fix using 'len' uninitalized.
> 
> Fixes: 0d4ab68ce983 ("module: add debug stats to help identify memory pressure")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
 
Thanks, applied and pushed!

  Luis
