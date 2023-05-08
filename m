Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464B76FBBB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 01:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjEHX6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 19:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjEHX6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 19:58:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E1D10FE;
        Mon,  8 May 2023 16:58:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24e14a24c9dso3735481a91.0;
        Mon, 08 May 2023 16:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683590310; x=1686182310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqf2UPCkq3bdzq70sgHBfwCZ95HHXXFStmO/UZJolGg=;
        b=F+1MgjQXr2rbiTvNZ9qjmhwjfyGqSKeeER9I++waBPsFx2ykyD3B17n7G+iWfBf+89
         7KIQU2y1V6zASNbpBin8ORpA6AhmqVe7DDyPjBynWKwUGBiKK4VLH1xm+aDLofexZ6Sd
         P8yUD1H71cG8plBXGC6bgKnBaQAzPyKnp3fooWW74XVHoklvlwR84MhuhGlE5x0l+fs2
         rrqXV6b3avcuU5G5ipjOA9UX5w0lbNRw8uKJ0nO7Das90bKPOf941+QJAojAgbUo721s
         X8XXBwdEE8gYTbXwPXNzLwj7TLEOFnBKozT+iYRFoBqOnzZRyL37Uxg9QhemiIciez8W
         Ir2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590310; x=1686182310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqf2UPCkq3bdzq70sgHBfwCZ95HHXXFStmO/UZJolGg=;
        b=gpb6TCYmQ9Hd6H8N0ElIC3zd2jaK5UZcOetDDDUYa2r0wL/T56RGIzp8aPV6IeOq0r
         PYs0za/xKr0XHNLte7TPYowGLDtd5JCnJWTOhzKwS090bPuBQHE7laagNgIdUZnaSj8G
         KXk52+bS0gKlZxSM8YftZkBQIT2uSEr5VoBENwHKgHF0mOsa3GyPE45JiokC0CXXaGbi
         DXjT+npsM+9pS3jIOFvBz2Z6RMIs0Wppx62UgDKUdlgXY5VZ8xM0KihYw3O3oHrt4fc1
         4FeZhTdwc3/lk9KnoG9JSe3BUo1jGSrqxCrMMjRFKIxes3gukUz+udjYc3JpRlIAjf4T
         GPWQ==
X-Gm-Message-State: AC+VfDxxiZWG0lkjMiA3GvnFherpoo+t7sQoyy3L+ICr9R8J4Mn6yb6l
        1mB7B4M/+VGwu6WBaZXO+PQ=
X-Google-Smtp-Source: ACHHUZ4REx44jHq+7fJ+S6qy2cozq8bxxclGEoUW2cJAof+bTY9GXNP3az23abe5Nw6l6pi0540gkw==
X-Received: by 2002:a17:90a:5409:b0:24b:2fc1:8a9c with SMTP id z9-20020a17090a540900b0024b2fc18a9cmr12026926pjh.11.1683590309893;
        Mon, 08 May 2023 16:58:29 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090a4a1100b00247150f2091sm10572223pjh.8.2023.05.08.16.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 16:58:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 8 May 2023 13:58:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Paulo Alcantara <pc@manguebit.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: Re: [PATCH 17/22] cifs: Use alloc_ordered_workqueue() to create
 ordered workqueues
Message-ID: <ZFmMpGuvgJdFI6nc@slm.duckdns.org>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-18-tj@kernel.org>
 <b6dfbc63d89715a1298117bc0afeb436.pc@manguebit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6dfbc63d89715a1298117bc0afeb436.pc@manguebit.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 03:38:57PM -0300, Paulo Alcantara wrote:
...
> >  fs/cifs/dfs_cache.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Paulo Alcantara (SUSE) <pc@manguebit.com>

6be2ea33a409 ("cifs: avoid potential races when handling multiple dfs
tcons") made this patch unnecessary. Dropped.

Thanks.

-- 
tejun
