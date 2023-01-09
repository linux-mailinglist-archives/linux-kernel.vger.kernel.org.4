Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671DC6621F7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbjAIJqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbjAIJpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:45:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D0C13FB4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:44:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB9E820377;
        Mon,  9 Jan 2023 09:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673257497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OJYJM5U3jL+mIFF8qQ6ruDQoewuVgc1v0J+GErVJ50c=;
        b=28Gyw3upxGL0gIG6vRvsttQN5cOb36679blEPyBodvFQGYjwIyNd0G9GCWh2Fksa5HLCwl
        3wNTEPaB472D3iPhZYLxUfO8oqYtPMT2+cqwq+Ol1d+mqmc1Hvt978r1+kwwBnhll2VIZ0
        mJpkwbkMxKP3S6kG+aI1Adzqzergl1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673257497;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OJYJM5U3jL+mIFF8qQ6ruDQoewuVgc1v0J+GErVJ50c=;
        b=wi4NNeZRopDA1w1vqfDfY9rFVRdNSWoMN7AkIYXiXweMsk+2iFhzL9e73qIpPbgBl1Cvfl
        lZNvnDRRiAS7atAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7F3413583;
        Mon,  9 Jan 2023 09:44:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uRXKMBniu2NvfwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 09 Jan 2023 09:44:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CD75FA074D; Mon,  9 Jan 2023 10:44:56 +0100 (CET)
Date:   Mon, 9 Jan 2023 10:44:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org,
        syzbot+8a5a459f324d510ea15a@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] udf: Fix null-ptr-deref in udf_write_fi()
Message-ID: <20230109094456.gdiyu7gwljkjeyhx@quack3>
References: <20230107195016.290627-1-pchelkin@ispras.ru>
 <20230107195016.290627-2-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107195016.290627-2-pchelkin@ispras.ru>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 07-01-23 22:50:16, Fedor Pchelkin wrote:
> udf_find_entry() can return NULL or an error pointer if it fails. So we
> should check its return value to avoid NULL pointer dereferencing in
> udf_write_fi() (which is called from udf_delete_entry()). Also, if
> udf_find_entry() returns an error pointer, it is possible that ofibh and
> ocfi structs hold invalid values which can cause additional problems in
> udf_write_fi().
> 
> If udf_find_entry() returns an error pointer, udf_rename() should return
> with an error code. If udf_find_entry() returns NULL, ofi has probably
> already been deleted.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: 231473f6ddce ("udf: Return error from udf_find_entry()")
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+8a5a459f324d510ea15a@syzkaller.appspotmail.com
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Thanks for the patch but I have already queued in my tree [1] rewrite of
UDF directory handling code that addresses multiple issues syzbot found in
directory handling and as far as I'm looking into the new code, this one
should be fixed as well.

[1] git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_next

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
