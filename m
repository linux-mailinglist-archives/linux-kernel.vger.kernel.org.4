Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C63F730343
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343667AbjFNPPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343660AbjFNPPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:15:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616061FC4;
        Wed, 14 Jun 2023 08:15:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E73FB638D3;
        Wed, 14 Jun 2023 15:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37623C433C9;
        Wed, 14 Jun 2023 15:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686755735;
        bh=IYlo4kFJO2TVbRcxmRqgX52nQUD+JoUM4Xtdb77hYmo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=L8/y2njeA9dvpmBLDS9b9VOFgU7bn/6Axd3gCwGdy5yLR9y2TYpTtK5sQOQ8kSSRS
         3H+GT2aah72MhN7h0rby9iSLNoJa+QoW5WquxOJBh3bDbqieaEQFyVWttfVypNXAoD
         E4yHAzZnziz/TpDvEUQdU22jT6S3EBYJ1Dhj5qhI1kq+I0pwIsf39kOnOrMygtN9Jv
         pwSdfpNe43i8pavv/T5Ol0odDnE6xBW0s6vX/mMy6sbAOkrA9iocie8/zty1E5JlfF
         XYEHdBWtm3z4qKiolcKU/fEMYGs9F/mi74EM079kBrQJtYIYfR+dTBMr2KQ559SGXu
         rRGOJuArVX5yw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: cfg80211: replace strlcpy() with strscpy()
References: <20230614134956.2109252-1-azeemshaikh38@gmail.com>
        <874jnaf7fv.fsf@kernel.org>
        <CADmuW3WEUgnpGXg=ajpRvwON6mFLQD9cPKnhsg35CcNqwcywxA@mail.gmail.com>
Date:   Wed, 14 Jun 2023 18:15:31 +0300
In-Reply-To: <CADmuW3WEUgnpGXg=ajpRvwON6mFLQD9cPKnhsg35CcNqwcywxA@mail.gmail.com>
        (Azeem Shaikh's message of "Wed, 14 Jun 2023 10:55:13 -0400")
Message-ID: <875y7qcbxo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Azeem Shaikh <azeemshaikh38@gmail.com> writes:

> On Wed, Jun 14, 2023 at 10:24=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wr=
ote:
>
>>
>> Azeem Shaikh <azeemshaikh38@gmail.com> writes:
>>
>> > strlcpy() reads the entire source buffer first.
>> > This read may exceed the destination size limit.
>> > This is both inefficient and can lead to linear read
>> > overflows if a source string is not NUL-terminated [1].
>> > In an effort to remove strlcpy() completely [2], replace
>> > strlcpy() here with strscpy().
>> >
>> > Direct replacement is safe here since WIPHY_ASSIGN is only used by
>> > TRACE macros and the return values are ignored.
>> >
>> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#str=
lcpy
>> > [2] https://github.com/KSPP/linux/issues/89
>> >
>> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
>> > ---
>> > v1: https://lore.kernel.org/all/20230612232301.2572316-1-azeemshaikh38=
@gmail.com/
>> > v2: https://lore.kernel.org/all/20230614134552.2108471-1-azeemshaikh38=
@gmail.com/
>>
>> In the change log (after the "---" line) you should also describe what
>> changes you made, more info in the wiki below. In this case it's clear
>> as the patch is simple but please keep this in mind for future patches.
>>
>> No need to resend because of this.
>>
>
> Thanks Kalle. I did have the below line in my changelog. For future
> patches, do you mean that changelog descriptions need to be more
> specific than this? For example - updated title from "x" -> "y"?
>
>> Changes from v1 and v2 - updated patch title.

Ah, I missed that because the format was not what we usually use. I
recommend something like this:

v3:

* add bar

v2:

* https://
* fix foo

v1:

* https://

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
