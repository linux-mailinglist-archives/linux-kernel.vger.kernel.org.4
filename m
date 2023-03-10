Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2C46B4FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCJR5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCJR5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:57:24 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E2D134807;
        Fri, 10 Mar 2023 09:56:57 -0800 (PST)
Received: from fpc (unknown [10.10.165.6])
        by mail.ispras.ru (Postfix) with ESMTPSA id E180744C1012;
        Fri, 10 Mar 2023 17:56:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E180744C1012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678470992;
        bh=oG5fFn0kiKwI+o2dpqA6h07vjlrIN+7+r7CBFmMBjCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tnP9BB9cn5lj7m6We3HdShkdvND1EVGlI6M4v/wFc2xqSVWgj8jFFi7cFQdZEq0Yw
         DGq9/7qgovJCXKntijgEv0A1qRtgltJUqz02wVEcgoUV36LWistZgg1B5mDDBw3BH2
         gKNsL9o2dfb+W9/7LS8OuVKQpflgEU4daS2EFLaA=
Date:   Fri, 10 Mar 2023 20:56:27 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Ian Kent <raven@themaw.net>, Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrei Vagin <avagin@gmail.com>,
        Takeshi Misawa <jeliantsurux@gmail.com>,
        autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 0/1] autofs: fix memory leak of waitqueues in
 autofs_catatonic_mode
Message-ID: <20230310175627.dvmkyvgb7b3qehbx@fpc>
References: <20230211195950.452364-1-pchelkin@ispras.ru>
 <5b86f03b-020b-1584-be8f-b7dc7277fa0a@themaw.net>
 <2f87a31c-7879-dce8-9c4b-01d2e781e22c@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f87a31c-7879-dce8-9c4b-01d2e781e22c@themaw.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 12:37:16PM +0800, Ian Kent wrote:
> 
> I was going to Ack the patch but I wondering if we should wait a little
> 
> while and perhaps (probably) include the wake up call change as well.
>

Hmm, those would be separate patches?

An interesting thing is that the code itself supposes the wake up calls
from autofs_wait_release() and autofs_catatonic_mode() to be related in
some way (see autofs_wait fragment):

	/*
	 * wq->name.name is NULL iff the lock is already released
	 * or the mount has been made catatonic.
	 */
	wait_event_killable(wq->queue, wq->name.name == NULL);
	status = wq->status;

It seems 'the lock is already released' refers to autofs_wait_release()
as there is no alternative except the call to catatonic function where
wq->name.name is NULL. So apparently the wake up calls should be the same
(although I don't know if autofs_catatonic_mode has some different
behaviour in such case, but probably it doesn't differ here).

It's also strange that autofs_kill_sb() calls autofs_catatonic_mode() and
currently it just decrements the wait_ctr's and it is not clear to me
where the waitqueues are eventually freed in such case. Only if
autofs_wait_release() or autofs_wait() are called? I'm not sure whether
they are definitely called after that or not.

[1] https://www.spinics.net/lists/autofs/msg01878.html
> 
> In any case we need Al to accept it (cc'd).
> 
> Hopefully Al will offer his opinion on the changes too.
> 

It would be very nice if probably Al would make it more clear.

At the moment I think that the leak issue should be fixed with the
currenly discussed patch and the wake up call issue should be fixed like
in [1], but perhaps I'm missing something.
