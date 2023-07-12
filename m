Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959E474FEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjGLFs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjGLFsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ED71734
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14FB4616B1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DF6C433C8;
        Wed, 12 Jul 2023 05:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689140903;
        bh=Ph89/PDCTb67KoGJxfj2/yR3pVcD15l3oyUTGy2LX7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B8AHyhd+uwAoolnd7MOHn1G1WfzKPRB4vE7T1IivHKtVsIFbFBF1RMtt44rOYsXd0
         yCmc+3TpTPBfhV/kQzB4L0yip0EuEkMfuLZHvmg68fzkZWLjkkWA4mpk+ZMyNPHeud
         4gYdaKiIq3sMFJy60e6UALdlvDIXsZEdnjPCxro+FuYOm47N9XpKlwRgdcxVflTbww
         LK7ACKVhApjTx9qxsn1OekfdnX+y1pXdzc9OZlL0cCKbF7cLM/tl+pJE76vDI4jIvt
         dTUXPssODeEoqwCkxEw9Qud+u7UWPWEwWYidofBe+vKcwgx2dVWmZg/nWXWnB5va0l
         eVOsR2zwQPxyg==
Date:   Wed, 12 Jul 2023 08:48:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     menglong8.dong@gmail.com, michael.chan@broadcom.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v2] bnxt_en: use dev_consume_skb_any() in
 bnxt_tx_int
Message-ID: <20230712054819.GV41919@unreal>
References: <20230711110743.39067-1-imagedong@tencent.com>
 <20230711200955.2d3a4494@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711200955.2d3a4494@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 08:09:55PM -0700, Jakub Kicinski wrote:
> On Tue, 11 Jul 2023 19:07:43 +0800 menglong8.dong@gmail.com wrote:
> > In bnxt_tx_int(), the skb in the tx ring buffer will be freed after the
> > transmission completes with dev_kfree_skb_any(), which will produce
> > the noise on the tracepoint "skb:kfree_skb":
> > 
> > $ perf script record -e skb:kfree_skb -a
> > $ perf script
> >   swapper     0 [014] 12814.337522: skb:kfree_skb: skbaddr=0xffff88818f145ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
> >   swapper     0 [003] 12814.338318: skb:kfree_skb: skbaddr=0xffff888108380600 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
> >   swapper     0 [014] 12814.375258: skb:kfree_skb: skbaddr=0xffff88818f147ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
> >   swapper     0 [014] 12814.451960: skb:kfree_skb: skbaddr=0xffff88818f145ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
> >   swapper     0 [008] 12814.562166: skb:kfree_skb: skbaddr=0xffff888112664600 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
> >   swapper     0 [014] 12814.732517: skb:kfree_skb: skbaddr=0xffff88818f145ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
> >   swapper     0 [014] 12814.800608: skb:kfree_skb: skbaddr=0xffff88810025d100 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
> >   swapper     0 [014] 12814.861501: skb:kfree_skb: skbaddr=0xffff888108295a00 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
> >   swapper     0 [014] 12815.377038: skb:kfree_skb: skbaddr=0xffff88818f147ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
> >   swapper     0 [014] 12815.395530: skb:kfree_skb: skbaddr=0xffff88818f145ee0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
> 
> I think this is way too verbose, people looking at networking code 
> are expected to understand kfree_skb vs consume_skb. 

There are many people who look in git log and don't understand networking
code at all. Verbose commit messages are intended for them.

Thanks
