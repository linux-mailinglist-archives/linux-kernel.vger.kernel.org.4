Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E4661414F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJaXGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaXF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:05:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB0113D36
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 16:05:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DCCDB81AD6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6783C433D6;
        Mon, 31 Oct 2022 23:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667257554;
        bh=h4RA8SJO/1JTmJqF/Aszy+U1QwyKo2oNB8AQeYPq7a0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VTpXqtF5p9o0aGBKgejOkSqHBFKPKVPRsNUbpLeAOyLCh7Lw+Jly67VdOEQIkCWtV
         qvNEBcxObsiBomwrvOA0OPgrnQwthP4vNbA14bRBJqhOPXr/TrVxNh37G6/W8k+wSy
         R1E1muPwCnYq7a7nQ2rQJvhFxLhzBstJxnN9B6T4=
Date:   Mon, 31 Oct 2022 16:05:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+a7f196a1dbf5e2c70568@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Mike Rapoport <rppt@kernel.org>
Subject: Re: [syzbot] general protection fault in mpol_parse_str
Message-Id: <20221031160553.5afd9c461ebf34cfdcf70881@linux-foundation.org>
In-Reply-To: <00000000000078a84b05ec45e73b@google.com>
References: <00000000000078a84b05ec45e73b@google.com>
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

On Sun, 30 Oct 2022 12:57:43 -0700 syzbot <syzbot+a7f196a1dbf5e2c70568@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4d48f589d294 Add linux-next specific files for 20221021

Thanks.

> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=165e12da880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4b7d600a5739a6
> dashboard link: https://syzkaller.appspot.com/bug?extid=a7f196a1dbf5e2c70568
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f10ff6880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145f1ff2880000

does

	memcpy((void*)0x20000100, "mpol=", 5);
	syscall(__NR_mount, 0ul, 0x20000040ul, 0x20000080ul, 0ul, 0x20000100ul);

so I assume we've fallen afoul of the patch "vfs: parse: deal with zero
length string value"
(https://lkml.kernel.org/r/166365878918.39016.12757946948158123324.stgit@donald.themaw.net).

I have dropped that patch today so hopefully we're all good now.

>
> ...
>
