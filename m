Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9EC632CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiKUTNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiKUTMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:12:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BAD13DDB;
        Mon, 21 Nov 2022 11:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I1dMuXGh4BFD544YIqWPLeTZToGUlatxS6Fvgv6hOhU=; b=t3hiiBlcGvC17357KM2w12Bbf/
        9iECHeonh7YR0gRFCiLyoZXiDD25ybfBhVytfVFPI3/B/GrQxjTbD3asPVG7jYSEy9PnTs13IY1Xi
        pYx+qhsZ3p+41mtRz7pBVkS3OyJ7NzHW/BZLsS2aEL4a/Cp+UrqoKLroKTBV3d0TtxW4S8GpGXTRA
        gb2Bkfuc3RwICsGcbNvufg+8WbZGUEM+Q7GawVYNFzLVjHlrZ4fMypdmhcjg4kNRbEZCcpfrjI75i
        0wHv8hY1IVS4yhjhW/dTy5WeYWiXLO9JtoNq0BQ6yuHgZfpNMZLHvvXP356O2Z9+W/2ZTQQXvNVuf
        NVIP+7sg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxCDs-00HCoQ-0H; Mon, 21 Nov 2022 19:12:52 +0000
Date:   Mon, 21 Nov 2022 11:12:51 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v9 2/8] kbuild: add modules_thick.builtin
Message-ID: <Y3vNs41m9I51Eu7x@bombadil.infradead.org>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
 <20221109134132.9052-3-nick.alcock@oracle.com>
 <Y2x22mKtaZvC7ZSk@bombadil.infradead.org>
 <87h6z5wqlk.fsf@esperi.org.uk>
 <Y25mXAGty35I5lQx@bombadil.infradead.org>
 <87iljhv321.fsf@esperi.org.uk>
 <Y3QC0OIbZgSmvAxT@bombadil.infradead.org>
 <87sfics595.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfics595.fsf@esperi.org.uk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 03:21:10PM +0000, Nick Alcock wrote:
> One question: do you think it's worthwhile me submitting patches to
> de-MODULE_* things that need it?

100% yes.

Yes please remove all that module declration helpers for things that are
not modules, and after you add your helper which will nag at build time
when it finds new ones.

For justification just mention in the commit log that after commit
8b41fc4454e ("kbuild: create modules.builtin without Makefile.modbuiltin or
tristate.conf") we rely on the module license tag to generate the
modules.builtin file and so built-in code which uses module helpers
just need to be removed.

  Luis
