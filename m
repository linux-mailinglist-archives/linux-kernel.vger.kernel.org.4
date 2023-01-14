Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7340466A88F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 03:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjANCOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 21:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjANCOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 21:14:12 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D8F2AD1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 18:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=74KRn/WgSdvJmqYfjiwNGGkvvAj0uPAMBNYbHuPHbjs=; b=huNOkAyxhYJo4GwXzpW8tPmPC5
        6GX7BL2QzeT0nl++2ulk/dLs8DRdkaQ77WbJcnnsZ5KnlrNsBVsQr1vwyro+wd50qEUl+gwwjtkCB
        E9OoXImHRD2gOS6dbnX3rao6/6qAzqVu9H79Zjvl8U8T46dmOm8jl9AM+V3IKldKKvQgdIhoVQR1g
        oquR1PI4gfLxAuAe1jGiurFoMdzceRJzDyw3YqAOg2QG2uEhmZdQq6H3v9cUl923P7W9SFJUGUosm
        WVy3+vvMvvlncxot/Tx9hhW3AwOlxAQDTF9mXixUI2DOnBbFsTpmWicBi6frNAobkh25HTAll3v7T
        y9NR0dCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pGW3Q-001lrE-22;
        Sat, 14 Jan 2023 02:13:56 +0000
Date:   Sat, 14 Jan 2023 02:13:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     almaz.alexandrovich@paragon-software.com, edward.lo@ambergroup.io,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH resend] fs: ntfs3: Add check for mft_ni in mi_read()
Message-ID: <Y8IP5JJW/wPy/Wb4@ZenIV>
References: <20230114015441.777119-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114015441.777119-1-baijiaju1990@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 09:54:41AM +0800, Jia-Ju Bai wrote:
> In a previous commit 2681631c2973, the parameter ni of
> attr_load_runs_vcn() can be NULL, and thus a NULL check is added.
> 
> However, in the same call stack, this variable is also dereferenced in
> mi_read():
> 
> mi_read()
>   ni_lock(mft_ni);
>     attr_load_runs_vcn(mft_ni)
>       if (ni) -> Add a check by previous commit (ni is mft_ni)
>   ni_unlock(mft_ni);
> 
> Thus, to avoid possible null-pointer dereferences, mft_ni should be
> also checked in mi_read().
> 
> These results are reported by a static tool designed by myself

No, it should not.  ni_lock(mft_ni) is called only if rw_lock
is not NULL.  The only assignment of non-NULL to that variable is
here:

        if (is_mounted(sbi)) {
                if (!is_mft) {
                        rw_lock = &mft_ni->file.run_lock;
                        down_read(rw_lock);
                }
        }

Note that it would have already oopsed had mft_ni been NULL.

The logics might or might not be wrong there, but could we please
stop obfuscating it by checks piled higher and deeper just in case?

Incidentally, I hope the pattern that triggered here is not

	f() checks for its argument being NULL, one of the callers of f() passes it a pointer
	therefore that pointer might be NULL

for obvious reasons...
