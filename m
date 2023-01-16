Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ADF66BC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjAPKoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjAPKnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:43:01 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E01D1DBBD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:41:16 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-4d59d518505so205878807b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4soP/Smn6p/Qzgy2m1Az79ZJJH6mPvlZu2xOB/yiHY0=;
        b=HnfFdKima0dYSPTrF1v82kAbukMyFOVonb7ctdBnlYd59TpwCawMSILhAVTRZ/XLnk
         UaxG4M7ao8T6V+3Pg6Pt3464FZ2JXZaWCEzCqPuM/egVf1tZmR/L9OvRNLl26ctWiKB0
         1yrtlrYffH8KgdarR8fXWyZjX3mVAaAYJBixnLK+olSMhIl0+8ANNpa3T3Y+oU2DtGs5
         VOU4qx5srgzkM+UsX+kwwAYDFBKstMX4reVl0lwu+xSlss5pThSRGTThchhXNAHQUMQ8
         5Q2vHI4ehhiP+gYyEX2egtR0fJ8P+/2lriooo2PMeGthxmtTKUPDTkS/I5LTgAArA0g8
         R5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4soP/Smn6p/Qzgy2m1Az79ZJJH6mPvlZu2xOB/yiHY0=;
        b=ak0U7X9j0p6aRoRBJmKJLfla3NgHYdWTZz476bJjkOCqzk08HRVPsfQFROc9F7yHUX
         0Lcy8FMQhRz61pBTlzGYInnqoj7FphTaIrnUKvlOH+wtud+2k6pkZGpM24N2Jbfn7GuB
         u6URK7WYULhfx1r4lGUlHkvV7c2bmhxETsZH5r+xbFpLTEyXDZUQMIM5WFUWLXp/aW+K
         +8c2Byk9iKttJpnSChHF3qoqNqvqjAVYpA0+o4T+JvFjDAD9/mPa2ySbI/zWaV0fc+Ty
         cd/b3q/Ns1/KICqkHsjfg7Bcf1vP1h5MyTnX4GG6dvIj96ddJit2+er3yacHgJkkAcgm
         Laow==
X-Gm-Message-State: AFqh2kqamakb/KzV5wHWIQJPFwGYtFJ15q4cbClP8cbD6OuTTB7hKEHU
        3wIiEwMvslK1M6+tZu8vK1YGVeMlWfVjjfcLtj2diQ==
X-Google-Smtp-Source: AMrXdXspgmx249O8TVxAcNuny03DGAUB+V2Yc99sZfMQJoh/65YzhpRklbp6PkiG8js8X67AYdeJP6fFYLwfm58XbuE=
X-Received: by 2002:a05:690c:b05:b0:467:2f6:4de5 with SMTP id
 cj5-20020a05690c0b0500b0046702f64de5mr5170933ywb.278.1673865675672; Mon, 16
 Jan 2023 02:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20230116103341.70956-1-kerneljasonxing@gmail.com>
In-Reply-To: <20230116103341.70956-1-kerneljasonxing@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 16 Jan 2023 11:41:04 +0100
Message-ID: <CANn89iK+cx+NdBCMG_zH48ZbSpMNnBqm4bNXEEke=ebnLvkvbw@mail.gmail.com>
Subject: Re: [PATCH v5 net] tcp: avoid the lookup process failing to get sk in
 ehash table
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 11:33 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
...

> Fixes: 5e0724d027f0 ("tcp/dccp: fix hashdance race for passive sessions")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Link: https://lore.kernel.org/lkml/20230112065336.41034-1-kerneljasonxing@gmail.com/
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !
