Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4355769EDC5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBVEEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBVEEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:04:10 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEBAB777
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 20:04:08 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id f18so8407949lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 20:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Yt/rtAUjC8oE//IhVQKInejbXflDY4md7Xx+ezyrLY=;
        b=PlCZNxI6YaoiNHUimwzbfONmZvR3sfewbs0X07QALDVOrrxpCUFYZsoOhBAOI6wa74
         qGIZyVqEkF9Loyx7H3H9ZH8O/m08FrEGlDX6iP31P2VKJIixcgaVqjWx5PkDEaHo2GOd
         QWdqEo6qaObAubvJSssFXGDcKGgi/kFMrI/4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Yt/rtAUjC8oE//IhVQKInejbXflDY4md7Xx+ezyrLY=;
        b=j80NhjPoDTTCcFJU9FDcWRixF63rvBnDHbGA52ayzHQivvB6vDhImOA/fnwaH95A3P
         KgAu7TvLeXQBROOySURXWCMKhscIDY/umRNzH/aFALhQ6WiHOLRPlgehhzjqyCbtU2PR
         ykNOBUwdYDEkw62P2SiRQvwQmJP6Hk5sBezVoX5xQ6X0B/QFnLpEeZsoI3jq5ZD2DKgD
         +egqTjWquf3E8bngDnXcmZ+cVjafcZ7La/tXPw0U85554JkaH+Ln4z30g+GCljU1lZbF
         CI0u/QB3mUUDkPxcdYYOTZPocMzgUZK8z1ib6uAXFAIiu7YG9b4M6xGhID4I+Lg7fDLf
         Wrtw==
X-Gm-Message-State: AO0yUKUgw/2xPnVR5ny2tBJuL3yQc88AjWXhK5iwTDPSusZWpdjBqgTJ
        grZhqKjzGfzdIoZ5aQAygQmNXNzLCUeBd1U+IUqqZmJlj5k+AD5M
X-Google-Smtp-Source: AK7set8y2i/Pyooxg/uGB4gmq0f1CWgV03knLK+LIWN1PjLs9XMWKgkHNXYCRaI11gv0/HSn9Wh9/Q0yJf7QGtRUCQ0=
X-Received: by 2002:ac2:46db:0:b0:4d5:ca32:6aec with SMTP id
 p27-20020ac246db000000b004d5ca326aecmr2399509lfo.12.1677038646988; Tue, 21
 Feb 2023 20:04:06 -0800 (PST)
MIME-Version: 1.0
References: <20230221214344.609226-1-peterx@redhat.com>
In-Reply-To: <20230221214344.609226-1-peterx@redhat.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Wed, 22 Feb 2023 13:03:55 +0900
Message-ID: <CAD=HUj7FkbyJ6WKVwNhsFv9RMgbXz5KSisnWcTNF5jZe4YdiaQ@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: alloc_charge_hpage() take care of mem
 charge errors
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <shy828301@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 6:43 AM Peter Xu <peterx@redhat.com> wrote:
>
> If memory charge failed, the caller shouldn't call mem_cgroup_uncharge().
> Let alloc_charge_hpage() handle the error itself and clear hpage properly
> if mem charge fails.
>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: David Stevens <stevensd@chromium.org>
> Cc: stable@vger.kernel.org
> Fixes: 9d82c69438d0 ("mm: memcontrol: convert anon and file-thp to new mem_cgroup_charge() API")
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Stevens <stevensd@chromium.org>
