Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B422267106B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjARBtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjARBtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:49:14 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DCD4708C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:49:13 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso719676pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3t+VlNzoCY4kIKf+CqXn8JwnB74qYXseQle+f7bT5o=;
        b=E+wLgGKwKDGJzA3B5wG0TtlB64oNme0I2VNg82u7pDo3qzK3A0fakGfktoZgqg77SQ
         onJij8y5Jp4/D2iU4WxkZEgcFWDUhRwAdcu5B8X6/ev/V8Tup2mNMPhmHK+Pgk84l7/e
         f7CdlrX6vGvqUYLJzbxaZif78kkdSJZ+X/xsSk/LvaRdUvxNUYWk3cCh0tzKCLSx9zJb
         YIqqD1maDIu/tnahHy/TMP9VeR0zVS8EJX4Vhvc057LyXndLyXe5wmB0jLjhdMe4/+dx
         a5s1pQczkbo+7S07FHoZIHOh+LmDGeI+WwIT7WeK2dLGZ6RIBSSxava/hdjaP3ORmGEa
         SGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3t+VlNzoCY4kIKf+CqXn8JwnB74qYXseQle+f7bT5o=;
        b=sxrB/1r0x7Ddojqbhw5EgBP8aJ+zXuclnuyyX7xwz0q9rQ05V28x8YRBeiuzJdPhY3
         3hClTCExCOYWt9Ujw0JNK7GTyRR2Xvjh3Lum+jpJ1M9INy+VqYnO1n7h+CGwn6acux2c
         Dz2SCsYBZ5D52OENKWdC+v6dOgbgfSzwmjT3PvvRc/9YLEY6sxdTv9uHr/vvGBLsK5Wx
         YfMla+UZXi+AaGB+UshT9Tg/tGkG1886AIirkPXhZxhy7FWTD2P2wZDqEW0d/byTVc3J
         n3qn3GVyj9rme+pCE2pGfzSMU7h4eBdIi3VSCOKEnlhi6FbrJb15Ag2NDRLVQpRjO7X3
         OSwA==
X-Gm-Message-State: AFqh2kqWfgxqyev9bP+TDMYnCveEWSBYqmvsje1YZCIzVFWsIv0W355G
        Albj0eaNfdAOpEeM9y3FA4wkTGLi+Wc=
X-Google-Smtp-Source: AMrXdXsPixU25b0oYj2LqGEHBtO20HAZKav9KPAsB2nHmKEsoduTF56l2K2ARLcJoaVF1GvAKmSVKw==
X-Received: by 2002:a17:903:252:b0:194:a852:57b2 with SMTP id j18-20020a170903025200b00194a85257b2mr5398261plh.64.1674006552672;
        Tue, 17 Jan 2023 17:49:12 -0800 (PST)
Received: from google.com ([2620:15c:211:201:27ce:97b5:ee13:dbfe])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b0018685257c0dsm21853275plg.58.2023.01.17.17.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 17:49:12 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 17 Jan 2023 17:49:10 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 1/3] mm: return the number of pages successfully paged out
Message-ID: <Y8dQFvvU99brPFi9@google.com>
References: <20230117231632.2734737-1-minchan@kernel.org>
 <20230117155312.5464d01c2d639b1ac44f9330@linux-foundation.org>
 <Y8c+tFfwSTwlRFOk@google.com>
 <Y8dEITaIfETA/Z/+@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8dEITaIfETA/Z/+@casper.infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 12:58:09AM +0000, Matthew Wilcox wrote:
> On Tue, Jan 17, 2023 at 04:35:00PM -0800, Minchan Kim wrote:
> > Yes, both are correct in my view since pageout is initiated after
> > unmapping the page from page table and think that's better wording
> > to be in description. Let me use the explanation in the description
> > at next spin. Thanks.
> 
> For the next spin, you'll want to do it against mm-unstable as
> deactivate_page() is now folio_deactivate().

I was curious what branch I need to use baseline for creating a patch
since I saw multiple branches recent mm/

Thanks for the hint. Sure, will do.
