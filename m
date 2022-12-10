Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708B5649190
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 00:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLJXvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 18:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJXvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 18:51:38 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F170A11C28
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 15:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ko2Bdie58wq+qfL0iVpDiNVXLRQwo/jVbmX5noXhSs0=; b=AElgV/H0LOWNFHgrJZHIWZjYrx
        7Ugtk16NVV+kKntFkQ0zS3BwRRjEGFz8WdYPlrVzhkSUbkoIhoTzOTyNU+5zYlMNLdkphZ/BPrBFO
        4ZQqvzPAf8CP00IitZRYnn9uGR9Gmc3NU4zzT11+WU5kZKGRnge9xhT5vD3cZcSE6tpdd1UvyJsiP
        Nmo6mzzxBQqdOsY3VQTrLFOLfulbq5N5NfabZ3MnojOMFi4Qf0tkJRT34uMYdgYi5sQrOONhMsX2z
        8Fa17RQNez5SNU22Ht4FD1n0NDngpko2trWQh/aNgFcuP5DTjepFFPaXxP7RtDo1wmVYykCOB3Cef
        tmhIoX+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p49cy-00Auet-2n;
        Sat, 10 Dec 2022 23:51:32 +0000
Date:   Sat, 10 Dec 2022 23:51:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH v2 3/4] cachestat: implement cachestat syscall
Message-ID: <Y5UbhBTB2nSMN4UD@ZenIV>
References: <20221205175140.1543229-1-nphamcs@gmail.com>
 <20221205175140.1543229-4-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205175140.1543229-4-nphamcs@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 09:51:39AM -0800, Nhat Pham wrote:

> +	if (!access_ok(cstat, sizeof(struct cachestat)))
> +		return -EFAULT;

What for?  You are using copy_to_user() later, right?

> +	f = fdget(fd);
> +	if (f.file) {

It would be easier to read if you inverted the condition here.
