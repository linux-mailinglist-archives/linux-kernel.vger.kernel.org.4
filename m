Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E626EFE1C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 01:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242101AbjDZXuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 19:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242091AbjDZXuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 19:50:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222B63A90
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 16:50:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB93E63976
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 23:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC6CC433D2;
        Wed, 26 Apr 2023 23:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682553050;
        bh=qwtwgpzkFvrIYrBcZ/yNJTnGlNi1I4SqQACLbiJ92u0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=MemFYfXTCxowmOqxo6GZjTtwTFj1U8v6Tg/BKuQ7YdmE9JUkocZhg0crfK+A0QCxo
         ojh0F1wJm47v0Zo68CqY1XVgkmFfzb8xpkeDp9iRRm2lWpAVjGbvhU84ONDSpFjFR6
         Co16aSet+FXQJtqRqg3LDugdqXBl/TKKL5LAPWaOTGNztakHeJsAOzYhtSDkKdUM3C
         GZjVdNVJjrTZpVVxJAgynxTy5Njnc0ZLlJ2u5pkhrK/Hb5odJyuh1LBoEh0CTOYqPy
         AR1PN9ymvd1TXwJ4DjTsFm2vmiLorh+IkVDvi7eFhXh7M6NPDzBI6I4c+bJHlWDJQT
         0oC4McgaBUm5g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 93F5415405A6; Wed, 26 Apr 2023 16:50:49 -0700 (PDT)
Date:   Wed, 26 Apr 2023 16:50:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     jpoimboe@kernel.org, peterz@infradead.org, bp@alien8.de
Cc:     linux-kernel@vger.kernel.org
Subject: An objtool warning from mainline
Message-ID: <02bd36cf-b2b8-4634-a70b-1476420188c8@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I am seeing a couple of objtool warnings in allmodconfig builds in
current mainline.  One of them is fixed by Borislav's patch [1], but I
do not see a fix for the other one:

vmlinux.o: warning: objtool: exc_nmi+0x2b3: call to __const_udelay() leaves .noinstr.text section

Borislav's older fix [2] is in tree.

I see this with gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04) and also with
gcc version 8.5.0 20210514 (Red Hat 8.5.0-18) (GCC).

Thoughts?

							Thanx, Paul

[1] https://www.spinics.net/lists/kernel/msg4697317.html
[2] https://lore.kernel.org/lkml/20211104144035.20107-13-bp@alien8.de/
