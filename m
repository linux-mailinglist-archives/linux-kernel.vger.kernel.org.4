Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9115074DCA8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjGJRni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGJRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:43:36 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABDB6DD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:43:34 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36AHhRKI025103;
        Mon, 10 Jul 2023 19:43:27 +0200
Date:   Mon, 10 Jul 2023 19:43:27 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH] tools/nolibc: completely remove optional environ support
Message-ID: <ZKxDP3YrIdKxWaIN@1wt.eu>
References: <20230710-nolibc-environ-v1-1-173831573af6@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230710-nolibc-environ-v1-1-173831573af6@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Jul 10, 2023 at 07:22:53PM +0200, Thomas Weißschuh wrote:
> In commit 52e423f5b93e ("tools/nolibc: export environ as a weak symbol on i386")
> and friends the asm startup logic was extended to directly populate the
> "environ" array.
> 
> This makes it impossible for "environ" to be dropped by the linker.
> Therefore also drop the other logic to handle non-present "environ".

Hmmm OK but at least I'd like that we continue to reference it from
nolibc-test to make sure it's still visible. Maybe we could just check
that it's always equal to envp ? If we drop its reference from there,
sooner or later someone will find it interesting to rename it and some
programs referencing it will break.

> Note:
> 
> Given that nowadays both _auxv and environ are mandatory symbols imposed
> by nolibc of pointer size does it make sense to keep the code to make
> int-sized errno optional?

While it indeed used to be related to having a data segment or not
initially, it still has an impact on our ability to completely drop
the errno setting code from all syscalls. Given the SET_ERRNO() macro
now I guess it's very cheap to keep it, don't you think ?

Thanks,
Willy
