Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7962884B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbiKNS3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbiKNS3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:29:00 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8781FCF6;
        Mon, 14 Nov 2022 10:28:59 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id z192so14546521yba.0;
        Mon, 14 Nov 2022 10:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J7Cbl6yOGS5glTesfz4JpnFGgPjdFsy/hI/Fu3TtNcA=;
        b=drX29G1u9fMT9l6Hp7fcV2qNgmfPxuB59iVHntbMgsAzh0smdUEpBxZICkvBwf1FFf
         UNqfH5/yeOia6fW3ZDVfWdjj5T9hDST/nbTIZiSD2IRZzeYr0arXTPy+uXvzG8ZbLBVW
         92wEpC//TcGJ6N+awQyc4zXJfMAeukg14QxIeluoluAbRVHQToCXLpVshkgTVv+G/ShF
         bpOGkvBpTzkExgO3abE2mr4NGZ9CNzospH7d52qv2z3YJ4PLWdV4i1dwsOTyLTA8EuQH
         K6aqECR+8Dw14+5Lm7NGwepqtapNT5qEuoVajz6zr8d2WFuh6KMK/nQDrH7OALhdCKGH
         OFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7Cbl6yOGS5glTesfz4JpnFGgPjdFsy/hI/Fu3TtNcA=;
        b=c+yhOpsxRCAlynX1UzsfdDdGLQ4h6/A2oh8gTVdUuAns+RUnqaP4fJhNBB8n34Wvd2
         v6FAEE6cxSzr1UTTL1PbZMdk7HJl9bDe0dSGaPxo4gMRTM0W+/crMBGkEqU27IyQdINL
         WWTt9K4eOfJKT1Gkc2GYoebIYQdj7FuZaS5H6PNTv6xO2zcnIZrHOGFcFl7jlF3d2OUE
         Wpfc1Rt1E2Ct26jCxzJOZa0UHOqWprB9LO7FKjgr8MFowbmvTOhU9AiFzpg/TpkkXqha
         FY6cmjd5cB49nMNxHrSg9RtRLE2EavmRAUVkvJILn1mK+BMBT7SjvP0xkZOfC6IgyCnj
         39rA==
X-Gm-Message-State: ANoB5pmRr+sqpU+orrzLPJ56+x9/WF6QU3S+hMY+qje5tTVKcuTrZaKe
        PITTMuHHKmwF3egzEe4f9x/yYfZkMPS05t7tFTz2ZpxjN3w=
X-Google-Smtp-Source: AA0mqf5aQ0w73PMOl6ZBZBmojg1Wqgc36djy6RijD/3PnIFpiT6VewzgiT0qKGSOqwdNYTYxj7W5Ew+U+YKkEO9guNM=
X-Received: by 2002:a25:41d7:0:b0:6cb:8949:fdbb with SMTP id
 o206-20020a2541d7000000b006cb8949fdbbmr13428033yba.328.1668450538671; Mon, 14
 Nov 2022 10:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20221110164152.26136-1-ojeda@kernel.org> <20221110164152.26136-20-ojeda@kernel.org>
 <20221114143928.4dde6589@GaryWorkstation>
In-Reply-To: <20221114143928.4dde6589@GaryWorkstation>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 14 Nov 2022 19:28:47 +0100
Message-ID: <CANiq72=1q8KDtjYqb286Chs7KFi3BXVAyCyHO=bpj+yY25EfBg@mail.gmail.com>
Subject: Re: [PATCH v1 19/28] rust: str: add `c_str!` macro
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 3:39 PM Gary Guo <gary@garyguo.net> wrote:
>
> I wrote this code when `const_panic` was not yet stable. Now we have
> stable const panic this function could be removed.

Indeed, we also took advantage of it in `static_assert!` when it got
stabilized but not here. I will update it.

Cheers,
Miguel
