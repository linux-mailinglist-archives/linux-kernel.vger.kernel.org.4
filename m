Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D3764E300
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiLOVVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiLOVUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:20:30 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0DB59142
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:20:29 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id s9so907630qtx.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WXDb+EX2ESKhrLmNgSh5O2/NUh9lzJ+wI1bqpoxRmT0=;
        b=YMDPnqtxIuxI1neTIAkMie4TAPfpOyhgO1ssJYOURo7uBlTUQR92WuobhFc/uthRdy
         45pE4mHMxHqBiXQzVmrHddcoOG8L2BzwD/hQUxgy4PgIMWsZTDFSbiZSDydig7xY6yOL
         azBFjJ9fV0w25rmhw3v2L9GT2ieCPa5C09LGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXDb+EX2ESKhrLmNgSh5O2/NUh9lzJ+wI1bqpoxRmT0=;
        b=5ZIbAAKPAOvShkWnB4+6DBX8eWwtvQoD6ZyNaBg50AWMSsJNGn0WT5O9fshGT6+qvz
         d0sNnadaiMXiJCZ8OiTyIHKiAWtEVfL8ctpbkRbllOIjRJ0vIOyvx+86kOevr/J9l0rb
         nFaW/qa7fMOU35iu352wg4zl/hQaYQYdmlKU0gpHNElhbOlrgoOwMYopdZO39cXgaMu+
         3xne4CD0OD/2bigUkAa7UxEdhujuQzv50nYtA2lOxZX/LdxoA4cwhWl9sNQzTcxUAlmG
         8Uq1q78U1yeqZ9WhMORGk6Qru4WxbnsTQJ0vHWOmn7PNrMfQFvYgJgvS2ZrmdK2MDV5N
         Ufhw==
X-Gm-Message-State: ANoB5pmyWdBntm/kasglUg/khb2YpJbj5nR2WE0FwRLVYe2jauC9AASG
        9crwf5blUhynTUcHkUxLnGs+f6LBRDt0x593
X-Google-Smtp-Source: AA0mqf7PWEf6oR5P1urYc+UKt038/Y+GQmHvkydm3mouXMpgg13ANWrP8jGg63uWadDlio8lLosWIQ==
X-Received: by 2002:ac8:6ed0:0:b0:3a8:27b9:5e18 with SMTP id f16-20020ac86ed0000000b003a827b95e18mr14730220qtv.67.1671139228585;
        Thu, 15 Dec 2022 13:20:28 -0800 (PST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id x30-20020a05620a0b5e00b006fc94f65417sm23834qkg.40.2022.12.15.13.20.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 13:20:27 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id k2so117132qkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:20:27 -0800 (PST)
X-Received: by 2002:ae9:ef48:0:b0:6fe:d4a6:dcef with SMTP id
 d69-20020ae9ef48000000b006fed4a6dcefmr11108076qkg.594.1671139226956; Thu, 15
 Dec 2022 13:20:26 -0800 (PST)
MIME-Version: 1.0
References: <20221215132415.07f82cda.alex.williamson@redhat.com>
In-Reply-To: <20221215132415.07f82cda.alex.williamson@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Dec 2022 13:20:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=whQ48-RsU85vM+Kwi=pRNU9fX8JXmooqx4=c1QYOjv2uw@mail.gmail.com>
Message-ID: <CAHk-=whQ48-RsU85vM+Kwi=pRNU9fX8JXmooqx4=c1QYOjv2uw@mail.gmail.com>
Subject: Re: [GIT PULL] VFIO updates for v6.2-rc1
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 12:24 PM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> I've provided resolution of the conflict chunks here below
> the diffstat.

Ok, mine is slightly different, but the differences seem to be either
irrelevant ordering differences (in the Makefile), and due to Jason
apparently renaming the goto targets which I didn't do.

But hey,. maybe I messed up, so please do check out it and test. I
verified that it all builds cleanly for me, but that's all the testing
it has gotten.

            Linus
