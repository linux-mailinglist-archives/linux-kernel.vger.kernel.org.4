Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25655611CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiJ1V6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ1V6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:58:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5299B24CCA0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:58:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2EAB62A9A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 21:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D567CC433C1;
        Fri, 28 Oct 2022 21:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666994323;
        bh=qoD2Yq4J1KRgQuRQsI1oHZEyZ2p5PGAeR1n7zGQja70=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fl50cHEzQCOTlJOXfJEapMQiXQQnmXF0EP5jPdVsaNeWpxBLRGhPnGgQtRF/XovTW
         zrB0sW445qu2JQdY0BzQumCu9P0GHGzYoDaISRWMr5hDKYyeJ2EFmgU5hJSLU0Hj6H
         CJaw8VtdwFqWX89CQ4g9HiUUKUW8mfvCN8azV+dg=
Date:   Fri, 28 Oct 2022 14:58:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] maple_tree: Reorganize testing to restore module
 testing
Message-Id: <20221028145841.4b0eaa422cbc775c3c074962@linux-foundation.org>
In-Reply-To: <20221028180415.3074673-1-Liam.Howlett@oracle.com>
References: <20221028180415.3074673-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 18:04:30 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> Along the development cycle, the testing code support for
> module/in-kernel compiles was removed.  Restore this functionality by
> moving any internal API tests to the userspace side, as well as
> threading tests.  Fix the lockdep issues and add a way to reduce memory
> usage so the tests can complete with KASAN + memleak detection.  Make
> the tests work on 32 bit hosts where possible and detect 32 bit hosts in
> the radix test suite.

My x86_64 allmodconfig failed with

ERROR: modpost: "mas_find_rev" [lib/test_maple_tree.ko] undefined!

so I did this:

--- a/lib/maple_tree.c~maple_tree-reorganize-testing-to-restore-module-testing-fix
+++ a/lib/maple_tree.c
@@ -6059,7 +6059,7 @@ void *mas_find_rev(struct ma_state *mas,
 	/* Retries on dead nodes handled by mas_next_entry */
 	return mas_prev_entry(mas, min);
 }
-EXPORT_SYMBOL_GPL(mas_find);
+EXPORT_SYMBOL_GPL(mas_find_rev);
 
 /**
  * mas_erase() - Find the range in which index resides and erase the entire
_

