Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94A2654126
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbiLVMi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiLVMi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:38:26 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A045D5E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:38:25 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so3996193wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2rBBnAXnD5Etqe6g9RvZN5ObDKOiH+aoC4TYIyFkoLc=;
        b=To9J7CD2h2YZnIQZIMtowMgTc19f93NgPwCPHbdrYKed4fUtyOdeuuE3JJqVUUfExG
         UB8IfwKKqM4t/1ZddkQMshKjTLnuNgpNGqFAOrP76DX1GOB1gznF35SDGgISH35NGxLz
         wtDzEXTta0EK+kLma8jTKRliMQlTqk3VA7hsXDM4aWn9NJt6aueTTZeSok4NubAF1vE4
         qq5KhVOQen49MwJRebLi4niFZ0dSSCmgiw2a0x3enEhlaVkkDhrAyLXgTX5lIOhpm01b
         7IoyoTUAN+TQ64A9GjtdoweC8xvDRkmz+KKbKXMdxz/syV4S38l9jEWbPWkf8g6sm4FX
         RCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rBBnAXnD5Etqe6g9RvZN5ObDKOiH+aoC4TYIyFkoLc=;
        b=qryU5rLdI+WUbztayTu7wK2D6M9DhG/zx/fW3ALO+ZiFGC/kCVFGQpNhcRTUGovBQK
         vMgDCxSwCN/GbeggQRbG2QR+nBSYvmugwR4d/NR/avdl2fyJq8qLVr4f50+9eobh1wwL
         Zv1PFxO9F9YaPLfEZiTiRMiz7GTg4kdv56Uc+hp5407ELNhiHSzUbbJZj1IHf7De3JiW
         eHf/omGVQqYUgAawUCJcuCk3f1vmD18D3140ZzNfQd2xC/YRdQa5V4h7flHNbsau77td
         3R3xFnbgAN3/fQQfgfHC6/8TgKr0C6s1tPG0fOTc09LcxTCD+w9lSBgn6DwCTuqPdGzC
         PqMA==
X-Gm-Message-State: AFqh2kobus/XvX5feOTfD2Byh/loXsupmgayD9h7K0vS/ywHzBrbmiGR
        m4v7OyQldL+t1qLpEG3iXac=
X-Google-Smtp-Source: AMrXdXsSs07k0r7LHjouMpn8zOyWkbiInBY4SbjDO1AxmEmpfiJYqoYGx7JISuYU8uRZJk1i5AHxNg==
X-Received: by 2002:a7b:c447:0:b0:3c6:e63d:adaf with SMTP id l7-20020a7bc447000000b003c6e63dadafmr4253840wmi.31.1671712703557;
        Thu, 22 Dec 2022 04:38:23 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:fdcf:52c5:7af:c812])
        by smtp.gmail.com with ESMTPSA id c10-20020a05600c0a4a00b003c6b70a4d69sm860981wmq.42.2022.12.22.04.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 04:38:22 -0800 (PST)
Date:   Thu, 22 Dec 2022 12:38:22 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: remove unused alloc_pages_bulk_list()
Message-ID: <Y6RPvqhtvVJ5WQW0@murray>
References: <20221217001554.554913-1-lstoakes@gmail.com>
 <Y51L496TjNuiSxsG@casper.infradead.org>
 <Y6Qrgu94tLAZsAN/@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6Qrgu94tLAZsAN/@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 02:03:46AM -0800, Christoph Hellwig wrote:
> Is that being snarky? :)  We generally don't add dead code at all, and
> certaintly don't leave it around for a year and a half.
>
> If anyone really needs this we can add it back.
>

Mel has replied elsewhere on this thread and we have a potential user so I think
the lowest-impact approach is to go with what he suggested - wait until May and
see if we have any takers.

I have put a reminder in my calendar for then, I'll check to see if it's being
used anywhere, if not I'll respin this patch. So problem solved for everyone :)

> > Also, if we do get rid of this, then __alloc_pages_bulk() can lose
> > the "list" argument.
>
> Yepp.

Yeah the respin will take this into account, if the function remains unused in
May.
