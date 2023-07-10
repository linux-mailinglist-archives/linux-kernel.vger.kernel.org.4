Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8E74DCC4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjGJRv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjGJRv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:51:57 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F543AD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1689011514; bh=WV6iTHNAjUAk0vrAhPrfPwRXuH5RztHU4ZrjaCHu7cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NBUV/JAfZ0D6p37Vd/VeBxPU22HScKokphUudTTze53QL+8HUrp20Dw2m0dT1s2En
         +qyT8K2eOUrZlaigDMSXcN5xVzCQgZuU1rG2y90W00w/iW+/jPDnTqHglGN5ZtXjq1
         Kjr7tJE8Np6VGb5JhrB+tQ87sijtGqDFo/DfDZ84=
Date:   Mon, 10 Jul 2023 19:51:53 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH] tools/nolibc: completely remove optional environ support
Message-ID: <804671ba-3884-4700-b367-2f84dace89f4@t-8ch.de>
References: <20230710-nolibc-environ-v1-1-173831573af6@weissschuh.net>
 <ZKxDP3YrIdKxWaIN@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZKxDP3YrIdKxWaIN@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-10 19:43:27+0200, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Mon, Jul 10, 2023 at 07:22:53PM +0200, Thomas Weißschuh wrote:
> > In commit 52e423f5b93e ("tools/nolibc: export environ as a weak symbol on i386")
> > and friends the asm startup logic was extended to directly populate the
> > "environ" array.
> > 
> > This makes it impossible for "environ" to be dropped by the linker.
> > Therefore also drop the other logic to handle non-present "environ".
> 
> Hmmm OK but at least I'd like that we continue to reference it from
> nolibc-test to make sure it's still visible. Maybe we could just check
> that it's always equal to envp ? If we drop its reference from there,
> sooner or later someone will find it interesting to rename it and some
> programs referencing it will break.

Easy enough to test for. I'll send a v2.

> > Note:
> > 
> > Given that nowadays both _auxv and environ are mandatory symbols imposed
> > by nolibc of pointer size does it make sense to keep the code to make
> > int-sized errno optional?
> 
> While it indeed used to be related to having a data segment or not
> initially, it still has an impact on our ability to completely drop
> the errno setting code from all syscalls. Given the SET_ERRNO() macro
> now I guess it's very cheap to keep it, don't you think ?

SET_ERRNO irks me a tiny bit :-)

But it's easy enough to keep, let's do so.
Just wanted to have brought it up.

Thomas
