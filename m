Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3C266244D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbjAILhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbjAILhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:37:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804002184;
        Mon,  9 Jan 2023 03:36:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6C8261027;
        Mon,  9 Jan 2023 11:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531F4C433F2;
        Mon,  9 Jan 2023 11:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673264189;
        bh=i0v+anZ7vkVotqToqOgCFMGxxvNaXgxm7b7hKcojS10=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ik88N9tqrBnQvboY0xzrY3vKIOPg+e7xsQ67ug2niCd/iruTS8EJ3GXThaPAkujz+
         dVImrU4kvlgdVwYDabVVHhpBWrqx9ikXElKjGYsn7zM8n9nB9sxdGd3fzHfV04+KV6
         lQz2xGqchNKQRteItjkDijBBc6VGgWi8z5ku+M4Z6Y2K1nPyynGExZRaSIRgtjRYYy
         7IPVXh14mNBA++rvIc6bYfmH9NZ+M9ELAOIYe+vLPWsj46d9RE3141HjJVPN4rGjb8
         uTJuWbS+udwWNR+fdhjKDvK577Qyxxmgqh10IhdzKS7O0vMqcnvKgaZF53qnJhYg5/
         17Xd1vk9oV4oA==
Received: by mail-ot1-f48.google.com with SMTP id j16-20020a056830271000b0067202045ee9so4985396otu.7;
        Mon, 09 Jan 2023 03:36:29 -0800 (PST)
X-Gm-Message-State: AFqh2krifOEtBx0LTuwqccPJX9KDkUVL8evqgEDk+ZfpMFKdFMFzuuuT
        brAvvoIn3avSq87mGQerACiD5R0pFUEfA/sDNjY=
X-Google-Smtp-Source: AMrXdXs8G4uDs+qNKxX45n9Gvr0ytXxTJTvXRzMaOEbNjXsg2ROzjnw4CJz8dqqvDVyNMjDu0UEIRuxLZH3/ko1r6pQ=
X-Received: by 2002:a9d:7e99:0:b0:670:64b2:ae66 with SMTP id
 m25-20020a9d7e99000000b0067064b2ae66mr4052819otp.225.1673264188539; Mon, 09
 Jan 2023 03:36:28 -0800 (PST)
MIME-Version: 1.0
References: <20230109091919.3160916-1-masahiroy@kernel.org> <d1542ad3-9c9d-90e7-f18c-531cb1547b78@I-love.SAKURA.ne.jp>
In-Reply-To: <d1542ad3-9c9d-90e7-f18c-531cb1547b78@I-love.SAKURA.ne.jp>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 9 Jan 2023 20:35:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS-NQL_Fgqh+oi0sRiUKJ5hm6v7fRe-S4xgd6SJbxUFmw@mail.gmail.com>
Message-ID: <CAK7LNAS-NQL_Fgqh+oi0sRiUKJ5hm6v7fRe-S4xgd6SJbxUFmw@mail.gmail.com>
Subject: Re: [PATCH] tomoyo: remove a temporary output file
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 7:01 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/01/09 18:19, Masahiro Yamada wrote:
> > Since this is a general problem, you can leave it to Kbuild instead
> > of introducing unneeded complexity.
>
> > If it is not too late, please squash this.
>
> It is not too late to apply. But how do you handle a case where
> the process who is responsible for deleting incomplete file was
> killed by e.g. OOM-killer?
>


Good point.
That is a rare case that Kbuild cannot handle.

One idea is to make if_changed to write the command to *.cmd.tmp
and rename it to *.cmd after everything succeeds.
So, it is a similar approach, but the difference is that
it is done in the Kbuild core scripts instead of every command.
I will consider it.


--
Best Regards

Masahiro Yamada
