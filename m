Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6066E3B43
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 20:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjDPSdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 14:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDPSdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 14:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97083106
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3207F60F5D
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 18:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE45C433D2;
        Sun, 16 Apr 2023 18:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681670016;
        bh=YlCs2n5EALDS5s68UQrGs8UJMvIrgeYJRA21TLlnrN0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZnRJwT8sgCw/ejrXUHDjYB/eP7lijyMB+3ylaEZ6+MWZuEiQu/DaC8FWk/mCvyeJL
         yO/JKjgmW0yLzhWN7of/mNXBxC5GE0wmsbOC8SYGrSf0tGHR6GE/KaAr3OfknHmazI
         6odrOytFLnI5HVyI/cEFOPCy5bnBp+xm/9yY+hRk=
Date:   Sun, 16 Apr 2023 11:33:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        himadrispandya@gmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, linux-mm@kvack.org,
        skhan@linuxfoundation.org,
        syzbot+9578faa5475acb35fa50@syzkaller.appspotmail.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm: khugepaged: Fix kernel BUG in
 hpage_collapse_scan_file
Message-Id: <20230416113335.caeafda1328fdd4bfe2406e8@linux-foundation.org>
In-Reply-To: <CAAa6QmTLXSvygQQNk=8C4pB3D2Twy1guzo=+-aXhCqNAE3Q3MA@mail.gmail.com>
References: <20230330155305.423051-1-ivan.orlov0322@gmail.com>
        <20230331013301.ecgkjymaf3ws6rfb@google.com>
        <CAHbLzkoJ2zvKZpqd6NqikpCc8rGR02C87f0fPq8qwb1BF3K+9Q@mail.gmail.com>
        <CAAa6QmTLXSvygQQNk=8C4pB3D2Twy1guzo=+-aXhCqNAE3Q3MA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Circling back to this fix...

The BUG() is obviously real.  We're unsure that Ivan's fix is the best
one.  We haven't identified a Fixes:, and as this report is against the 6.2
kernel, a cc:stable will be needed.

According to the sysbot bisection
(https://syzkaller.appspot.com/bug?id=7d6bb3760e026ece7524500fe44fb024a0e959fc),
this is present in linux-5.19, so it might predate Zach's
58ac9a8993a13ebc changes.  But that bisection claim might be
misleading.

And Zach is offline for a few months.  So can people please take a look
and see if we can get this wrapped up?

Matthew, the assertion failure is in the

	VM_BUG_ON(index != xas.xa_index);

which was added in 77da9389b9d5f, so perhaps you could take a look?

Thanks.
