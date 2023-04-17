Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6775C6E5538
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjDQXcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDQXbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:31:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7800D49C0;
        Mon, 17 Apr 2023 16:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GbFnE3K+L8f59WZAvJ/hj9ehaAasU8pWrkZQfFTFgRI=; b=Y7tOIewPMqx6euiabUxhotEK60
        L/aX5IQn9m+UMFqqVMSl1j/iK3OqSxrYRpwRJT3ocLPf4St/hFKixPy/LbZFhwP4buzmF4ey1r3ZW
        1u4NG2qVkZCNcaiKE78QfEi+DPrieGmmaq7QJ9nX3G5Z8h0/AMw3f/ySJ3apDuQD8W+k/zder0h6j
        dXvq80+1eJmhtm/o5FrTC1p/yH8DeW2e5rOtjfbZL+hKMdqXo1kOAr0TFD4yyxlToEyadngewUGFh
        aEOZzFEnyy15ISeK5S7yfQXUdNHFFEtw2xC+Oc3mndSi4fk+shDbGLicR9yVZs4iCrWgfu6C0qukb
        4DHdOBnQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1poYK6-000PHa-21;
        Mon, 17 Apr 2023 23:31:50 +0000
Date:   Mon, 17 Apr 2023 16:31:50 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] module: fix building stats for 32-bit targets
Message-ID: <ZD3W5iSmzsOu51uB@bombadil.infradead.org>
References: <20230417224810.2922059-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417224810.2922059-1-arnd@kernel.org>
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

On Tue, Apr 18, 2023 at 12:48:04AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new module statistics code mixes 64-bit types and wordsized 'long'
> variables, which leads to build failures on 32-bit architectures:
> 
> kernel/module/stats.c: In function 'read_file_mod_stats':
> kernel/module/stats.c:291:29: error: passing argument 1 of 'atomic64_read' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   291 |  total_size = atomic64_read(&total_mod_size);
> x86_64-linux-ld: kernel/module/stats.o: in function `read_file_mod_stats':
> stats.c:(.text+0x2b2): undefined reference to `__udivdi3'
> 
> To fix this, the code has to use one of the two types consistently.
> 
> Change them all to word-size types here.
> 
> Fixes: 0d4ab68ce983 ("module: add debug stats to help identify memory pressure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use long instead of u64 everywheren

Thanks, applied and pushed!

  Luis
