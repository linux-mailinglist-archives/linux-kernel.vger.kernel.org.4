Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B07E70871C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjERRpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjERRp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:45:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1964810CE;
        Thu, 18 May 2023 10:45:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92DD5650D3;
        Thu, 18 May 2023 17:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E47C433D2;
        Thu, 18 May 2023 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684431925;
        bh=lrNR3Kj8pwFUL4gmGaZGPGna/6gQVw84egS4nJteM9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jsAPYUpOGrJjow4IZQA8Vn9fegedOfdXtFRGY1bmYYo19X1SUsnAOamSK1TdB/aIg
         em2keJtu12XgSiWFyoWI5s41Vvsq+e4tKQ1nmZlbjjevZYT+eRUMZZ4IWLKbFVq4o2
         B6N+W/CZKnGp9ACxHnWwjaEjeiXWMrIotVilRL1r8WayjPpbDd8EguOaV7aWYt99lG
         NcWuWTuaweS6Hn+2CLAYH4KOCTHD+iVXW4pt/RT02SImUgE3xfGYDypUaPyIKztjbD
         SNddghEDcllERzPdhV/BWqeX453R8n/1nUS5ukBAwnK0TE68QIbgD8m/XM5gbVThDZ
         Q63PWwsg6sUuQ==
Date:   Thu, 18 May 2023 13:45:23 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.3 5/7] riscv: Unconditionnally select
 KASAN_VMALLOC if KASAN
Message-ID: <ZGZkM98lOHUEF4mA@sashalap>
References: <20230509035455.59524-1-sashal@kernel.org>
 <20230509035455.59524-5-sashal@kernel.org>
 <bea1128b-903c-a7d0-9929-d9667999bb6d@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bea1128b-903c-a7d0-9929-d9667999bb6d@ghiti.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 11:51:03AM +0200, Alexandre Ghiti wrote:
>Hi Sasha,
>
>On 5/9/23 05:54, Sasha Levin wrote:
>>From: Alexandre Ghiti <alexghiti@rivosinc.com>
>>
>>[ Upstream commit 864046c512c2cd8418dc928b91981fb12a80396c ]
>>
>>If KASAN is enabled, VMAP_STACK depends on KASAN_VMALLOC so enable
>>KASAN_VMALLOC with KASAN so that we can enable VMAP_STACK by default.
>>
>>Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
>>Link: https://lore.kernel.org/r/20230203075232.274282-7-alexghiti@rivosinc.com
>>Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>>Signed-off-by: Sasha Levin <sashal@kernel.org>
>>---
>>  arch/riscv/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>>diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>index eb7f29a412f87..d6aad84efb95e 100644
>>--- a/arch/riscv/Kconfig
>>+++ b/arch/riscv/Kconfig
>>@@ -118,6 +118,7 @@ config RISCV
>>  	select HAVE_SYSCALL_TRACEPOINTS
>>  	select IRQ_DOMAIN
>>  	select IRQ_FORCED_THREADING
>>+	select KASAN_VMALLOC if KASAN
>>  	select MODULES_USE_ELF_RELA if MODULES
>>  	select MODULE_SECTIONS if MODULES
>>  	select OF
>
>
>KASAN_VMALLOC is broken for any kernel < 6.4, so this one should not 
>be backported to any kernel (5.15, 6.1, 6.2, 6.3).

Ack, dropped. Thanks!

-- 
Thanks,
Sasha
