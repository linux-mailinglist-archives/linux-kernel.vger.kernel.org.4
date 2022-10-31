Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A99E6138A0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiJaOCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiJaOCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:02:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E67410565;
        Mon, 31 Oct 2022 07:02:49 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b29so10726216pfp.13;
        Mon, 31 Oct 2022 07:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqGCXhnHjIeBeODuGDUG/31qoicURkdlFqgbUPm7phc=;
        b=kUJlruVeuLHmagJg6lHo+RtE0at2dvQYVh9zY5O+z9QdSD1eS0UJXC+8yxGJqdJEFM
         Vo/2Rb9mVohZ0WHO/LmpJyRLGBYGdn0dMSc2fN9qghC8yS8hwcALOqRUkb/XDQTEs9yO
         1hFqEkqe9d2Hd6fXsKiqsgUsEV04UhK+vxsBjhwbhHLhSir0nGgxQ6uYWXJv7MAy4RKA
         JIYOGfjDLJwO/mqKN+eVpqD7obD7CH+0RlSdiaP7pLTXEvuXdSrvBYickaC05WHCi5Gp
         aPVLRoard7eR6q+ZpSWjq5ZFNXAVrDTfiXpwFZNRkVcNJ8P7Tzlg97MHW4cOMLkZaBme
         AR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqGCXhnHjIeBeODuGDUG/31qoicURkdlFqgbUPm7phc=;
        b=7tNqkf7vq1ux0wVOPna3og3KkdvVl361ozpXvvHvGLAWI5q/yBDl5osYW5kUvp9OqL
         wopU8hBlNKotkCyp3h1ewVJuQnSJVMTzR2VEe5nnlUK2isrGpzN51yXIYgpekpwazg7C
         JtDqBsY0JUg86W/iy6JstpzZMxgx0kvZzhTvuvFHUj5QdEp7v6UhocZrohhxxHb0PrkR
         8UzEowdPaUHbBFsu9jXZ4Tc2gk/fSyh3GjzJzOzKq21cpSPvLlS+0K0R296TgLXzeY+A
         nhGWiBb5NqDUPBIIStEWEDWe+j6uKeBFzsgDpFOCLgPQO5xtawX/MxknwqWKj8SRCGC7
         kXMQ==
X-Gm-Message-State: ACrzQf1X22pmver30QK/XLBzRQCdXLXgayx+rlz91UAGLW7XX9aL/wMC
        YqQjBGUq6NCdf2nyTEGZZl5GzTcmN9fUMhjxEVT1JL+8WfY=
X-Google-Smtp-Source: AMsMyM68rpWT035a3YOxPw13zlJ0a7C13U1cYSp1w/ZnczuRZyHbQ/DS1AaJXm+XCrYCZ8QSQBEDiSEQ0E8caJTNY8A=
X-Received: by 2002:a63:5511:0:b0:439:12f6:fb9a with SMTP id
 j17-20020a635511000000b0043912f6fb9amr13190325pgb.197.1667224967855; Mon, 31
 Oct 2022 07:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220415050003.3257645-1-mattst88@gmail.com> <20221019232952.2212729-1-mattst88@gmail.com>
In-Reply-To: <20221019232952.2212729-1-mattst88@gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 31 Oct 2022 10:02:35 -0400
Message-ID: <CAEdQ38FO0SH80SLQKpLxadOBKn7cuRmZLd=xU8jJguq+MuD+Lw@mail.gmail.com>
Subject: Re: [PATCH v2] tools: port perf ui from GTK 2 to GTK 3
To:     linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jelle van der Waa <jvanderwaa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 7:30 PM Matt Turner <mattst88@gmail.com> wrote:
>
> From: Jelle van der Waa <jvanderwaa@redhat.com>
>
> GTK 2 is a legacy API and the newer version is GTK 3 which changes a few
> API functions. gtk_tree_view_set_rules_hint is no longer required since
> theme's are now responsible to handle this, gtk_vbox_new is deprecated
> and replaced by passing the orientation to gtk_box_new. Apart from these
> changes the accessing of the screen changed in GTK which requires using
> new functions for getting geometry. Lastly the GTK_STOCK_OK define is
> deprecated in GTK 3.
>
> Signed-off-by: Jelle van der Waa <jvanderwaa@redhat.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
> Originally sent in 2019. I've rebased it and given it a test.
>
> One problem I've noticed is that C++ symbol names are often broken.
> E.g.:
>
> (perf:3254940): Gtk-WARNING **: 21:47:46.663: Failed to set text from
> markup due to error parsing markup: Error on line 1 char 95:
> =E2=80=9Cstd::char_traits<char=E2=80=9D is not a valid name: =E2=80=9C<=
=E2=80=9D
>
> Presumably we need to call g_markup_escape_text() somewhere, but I
> struggled to find the right place.
>
> Without the patch, the GTK-2 version repeatedly segfaults, so this is an
> improvement regardless.
>
> v2: Dropped changes to test-all.c. I don't know how to build that
>     apparently.


Arnaldo, does this work better for you?
