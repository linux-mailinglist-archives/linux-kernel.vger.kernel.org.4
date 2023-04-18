Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FCB6E686A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjDRPkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjDRPkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:40:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B492E8A5B;
        Tue, 18 Apr 2023 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EaV6BCKY1eHprx658JRQYuaDaXxztmLKpGEqHHbfQes=; b=j/uxjMv+w5mKyDnpSN7EqIg0RH
        fLFpt2aQ4PUPPtGMGRkkgrtFTuVF014Y/WG1g/b7O05IZOY6DYiZasAwCOrLvTdmM6SPFdyL98WU8
        qRDfQh9y77R7cZtb7Y6EaQll606VG/ONrnhK0zZa6H5nfuQmnbtFHnilwNHw551148cfBj83tjyos
        aj4ni3a2jExlg8VB6EsXxd9oYmZkeufBwPHLhQcvYVhZSWjyoz5GWriZbTZ/J0Hzj3b4SxyaL/JGN
        j6Ah7mz5w420WdCjWXGQbGujigK7hbXI1dVasr5mTj1GXuwF2+qxlAaTUAHICOeFh6mf83TNmWTSj
        TWQfGhTw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ponRc-002erH-2B;
        Tue, 18 Apr 2023 15:40:36 +0000
Date:   Tue, 18 Apr 2023 08:40:36 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: stats: fix invalid_mod_bytes typo
Message-ID: <ZD659BcowP46i6Sr@bombadil.infradead.org>
References: <20230418071758.3163529-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418071758.3163529-1-arnd@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 09:17:51AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This was caught by randconfig builds but does not show up in
> build testing without CONFIG_MODULE_DECOMPRESS:
> 
> kernel/module/stats.c: In function 'mod_stat_bump_invalid':
> kernel/module/stats.c:229:42: error: 'invalid_mod_byte' undeclared (first use in this function); did you mean 'invalid_mod_bytes'?
>   229 |   atomic_long_add(info->compressed_len, &invalid_mod_byte);
>       |                                          ^~~~~~~~~~~~~~~~
>       |                                          invalid_mod_bytes
> 
> Fixes: 0d4ab68ce983 ("module: add debug stats to help identify memory pressure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This was probably already reported, sending the fix just in case everyone
> else else missed it so far.

Oh it was a decompression ifdef, that's why I didn't catch it! But also
I guess 0-day isn't running tests with it enabled either!

Thanks! Applied and pushed!

  Luis
