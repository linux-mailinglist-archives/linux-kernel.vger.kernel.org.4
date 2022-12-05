Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345C86428EF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiLENHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiLENG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:06:58 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1041D1ADA7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:06:57 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id y135so9785314yby.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 05:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d5fYKRyZintOwoAGXMb6vGdAfTkwnfN4FsoS+VpmLyU=;
        b=BAdYHPPP5OlG6xmYe6hrYXJ5TJiLHef2nFE1sZvmtNSWq0ktjNzHwTjwBS99idioB6
         9QIMJl/9n2ykISx3iZuIHapsxavHVSDHT8P9scTqlevnTMrnpn3+ShMmg4OJtoYUSTqb
         Akd3L3YyjHzBUcE+zLOZsCTTtFffiNK5nIr0GbhXwyDRf/Jh/CaRkGOiydFl4W+vGf+m
         80K45FQ5T5wmEy6xu3h/ahz4g6Hv0+2bh0qfzbWL5WKCXtn15YItvTo9qIEzwpeQlyhh
         RL/Gio2mgeOs3F+LtLsBzB9iVK8foBdsktAW1c4ylQiib/DPerkdmU3z/0ZuGmZNCtUp
         I1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5fYKRyZintOwoAGXMb6vGdAfTkwnfN4FsoS+VpmLyU=;
        b=RsAlKaI5i8p9YfLzVG0OS1TAYEfDpw1LUyDdDsYeNGys8i5zl79aM1vka6cWd70fnX
         6EhTYjH7gQVX6n5vUl4sNoAAxf+EN0EDNRpweJTB17ufyTch1tjzoqqYj/xgobQajIa3
         j4yZmGZg1Ko3jQG7zawF5pFyJ/pgh3CtoDnVrw2JJhs4Qx3AX7He7/dXsuVcFrz/J230
         QMCb+FxwClmaQVX+pT3RcKkEqVWdQUkipCdzmsXkx07ls38Tkqjy0Ez2Znis2/1ZnDOJ
         y1rLzwH57cSFY5YKQIq4gzDYivkgfrHa8YFUmb2kzhEWq1zJ2JTjnoSXqALTg5fMR+bO
         GWDw==
X-Gm-Message-State: ANoB5pkBa6BkHn6PepAHTeOWhwknMOqAKdrsSc1mJDEGerK/1nbvQWVx
        w4rIP6L6NTn43xfLF/W4XrOJzFbxPNRRSFGLyrfEew==
X-Google-Smtp-Source: AA0mqf7zu+Ix/fLrJS9443B/niuWcGFRgKoqLnW3h5dAxUc0KDmHjt0UE05e3vf46HWpBGzmwxNyXbr2+GeDuVzqeeg=
X-Received: by 2002:a25:1e89:0:b0:6f6:b3d1:edcc with SMTP id
 e131-20020a251e89000000b006f6b3d1edccmr34524757ybe.125.1670245616011; Mon, 05
 Dec 2022 05:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20221205124756.426350-1-asmadeus@codewreck.org>
In-Reply-To: <20221205124756.426350-1-asmadeus@codewreck.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 5 Dec 2022 14:06:18 +0100
Message-ID: <CANpmjNNjSat=TkXUmv351yPGn=6SV27NaXe80dU69Ggy5SHxsg@mail.gmail.com>
Subject: Re: [PATCH] 9p/client: fix data race on req->status
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 at 13:50, Dominique Martinet <asmadeus@codewreck.org> wrote:
>
> KCSAN reported a race between writing req->status in p9_client_cb and
> accessing it in p9_client_rpc's wait_event.
>
> Accesses to req itself is protected by the data barrier (writing req
> fields, write barrier, writing status // reading status, read barrier,
> reading other req fields), but status accesses themselves apparently
> also must be annotated properly with WRITE_ONCE/READ_ONCE when we
> access it without locks.
>
> Follows:
>  - error paths writing status in various threads all can notify
> p9_client_rpc, so these all also need WRITE_ONCE
>  - there's a similar read loop in trans_virtio for zc case that also
> needs READ_ONCE
>  - other reads in trans_fd should be protected by the trans_fd lock and
> lists state machine, as corresponding writers all are within trans_fd
> and should be under the same lock. If KCSAN complains on them we likely
> will have something else to fix as well, so it's better to leave them
> unmarked and look again if required.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

Acked-by: Marco Elver <elver@google.com>

In case you're interested, KCSAN has a strict mode that is more
aggressive about which data races it reports (by default we're hiding
several classes of data races). One such class is data races due to
missing memory barriers, where e.g. an unmarked operation can be
reordered in such a way (by compiler or CPU) that a concurrent racy
access occurs. This mode can be enabled with CONFIG_KCSAN_STRICT=y.
It's most effective with some good stress tests for the subsystem of
interest. See https://docs.kernel.org/dev-tools/kcsan.html#modeling-weak-memory

Thanks,
-- Marco
