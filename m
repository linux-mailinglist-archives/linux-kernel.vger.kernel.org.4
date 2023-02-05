Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDD468AFA4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 13:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjBEMEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 07:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBEMEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 07:04:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3B4E049;
        Sun,  5 Feb 2023 04:04:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBAD060AE7;
        Sun,  5 Feb 2023 12:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC36C433D2;
        Sun,  5 Feb 2023 12:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675598644;
        bh=XQJvAzQ/nAfDY0Qqmh+9LMXMgQLsHVE0aawbd/vXnwE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UqsvCDbMRwAZgpJWjbhYFvZS6ZwIr3mFwmVGl2NaAmfs2GYDJ0ewXwjrRKmy4R0Ev
         xEMVWzghKfVQTpQXtyYswSfMm8Z06aSJ2RDAJ2ftXhXfsldF1SJDvg5RdlCk+v9d4S
         X6KxxU3GxcD0Lqfxp8BdMReqkQD//FwA/a8uLxip/goZj+9nQnPDpo1bU4zCMZkZh+
         QwmV+Tm2kCaTkTTbiAmLV3tiW7ZzA4PDX5fy2iVbmW7/nGaXQ/wyndUanB6Uj99Nod
         s7Rmmsvn8P/9KFuFd/CwqCVB4arvgcH6GukXd+6ba4JnW5JZbOa8saQvc5MwJcoWpp
         wyJEhKB/qtPSw==
Received: by mail-ot1-f43.google.com with SMTP id j6-20020a9d7686000000b0068d4ba9d141so2569050otl.6;
        Sun, 05 Feb 2023 04:04:04 -0800 (PST)
X-Gm-Message-State: AO0yUKW9bCdhpZyzpsCZfPlgT0bSg/E6FCdjpmIbnZbqdX/tqS85F1R5
        zo1cxLBl0STLHDc2bahgvVP37/YIl8pepBAwNJE=
X-Google-Smtp-Source: AK7set9trqSfS9WKHvZ62BAtOaKwFnIajvEc0+cIzzGTQxMaPHq3391FjuTxTevpc19J9eKUb4pXT358SLiTN79Gcc8=
X-Received: by 2002:a05:6830:2444:b0:686:6392:ed38 with SMTP id
 x4-20020a056830244400b006866392ed38mr732280otr.22.1675598643581; Sun, 05 Feb
 2023 04:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20230131133253.1460560-1-masahiroy@kernel.org>
In-Reply-To: <20230131133253.1460560-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 5 Feb 2023 21:03:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNARQFy7OkFK6JH=1c5dTfyCxeU5G-kq4X3xwA08_ek3WhQ@mail.gmail.com>
Message-ID: <CAK7LNARQFy7OkFK6JH=1c5dTfyCxeU5G-kq4X3xwA08_ek3WhQ@mail.gmail.com>
Subject: Re: [PATCH] setlocalversion: do not append git commit hash if
 localversion* exists
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 10:33 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Since commit dcfbcb1033bb ("setlocalversion: use only the correct
> release tag for git-describe"), KERNELRELEASE of linux-next is
> annoyingly long:
>
>   $ make kernelrelease
>   6.2.0-rc6-next-20230131-09515-g80bd9028feca
>
> The string '-09515-g80bd9028feca' is appended because git-describe now
> uses the v6.2.0 tag instead of the next-20230113 tag.
>
> In linux-next, the 'localversion-next' file well specifies the local
> version, so the extra info from git is unneeded.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---


I will drop this patch,
and send an alternative one.



-- 
Best Regards
Masahiro Yamada
