Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A2973534B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjFSKn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjFSKnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:43:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DF410D4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:43:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E65F60670
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBACC433C0;
        Mon, 19 Jun 2023 10:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687171393;
        bh=rNx4yQtapdMWkWm5zVEcQQCg/oEtXvyrJkwZzYmhLMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hn+1/wvGz2kQ1r0hnhWdxirc86Sqru5w3MekuU6rUZ+4/Gcmt/r0tZ89hivcN9xaH
         TQv6AbHl70ydTw90wFcaClp5SY8gjVvshRn1ckkE2AITSLlWb62PLKx8tRA9ZG3BOM
         uWLdqmc0ecPxVEYqgFHJy6ZClpskfB9cm42eta3uMbWMFehAsN+zR8vUdAEmNLA7Kw
         vg/Mhe3TS0qD24tTgWylMHrB/swXlxbtwTgszTSfgR0RgAvTxiUF328YZ2CnekzEr4
         QM6Zk0z2DsdHryzESshDBzuAFEly9wz/wE+COiKMsmLKbHf0IlNMSQT3CCdFgdZ+gy
         i3NgQVKYQ/1Pg==
Date:   Mon, 19 Jun 2023 11:43:08 +0100
From:   Lee Jones <lee@kernel.org>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] x86/mm/KASLR: Store pud_page_tramp into entry
 rather than page
Message-ID: <20230619104308.GC1472962@google.com>
References: <20230614163859.924309-1-lee@kernel.org>
 <20230614163859.924309-2-lee@kernel.org>
 <20230616170027.GM3635807@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230616170027.GM3635807@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023, Lee Jones wrote:

> On Wed, 14 Jun 2023, Lee Jones wrote:
> 
> > set_pgd() expects to be passed whole pages to operate on, whereas
> > trampoline_pgd_entry is, as the name suggests, an entry.  The
> > ramifications for using set_pgd() here are that the following thread of
> > execution will not only place the suggested value into the
> > trampoline_pgd_entry (8-Byte globally stored [.bss]) variable, PTI will
> > also attempt to replicate that value into the non-existent neighboring
> > user page (located +4k away), leading to the corruption of other global
> > [.bss] stored variables.
> > 
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  arch/x86/mm/kaslr.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Is there any more you need from me at this point?
> 
> Would you like me to resubmit with the Fixes: tag applied, or is
> someone happy to apply it on merge?

Superstar, thanks Dave.

-- 
Lee Jones [李琼斯]
