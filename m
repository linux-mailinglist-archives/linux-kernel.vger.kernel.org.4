Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC686A613D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjB1VaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjB1V35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:29:57 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E47F2E0CB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:29:54 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o15so43319183edr.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677619792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8cphB32FCA+JDrayMTXIg9hnTVIdgiqn6d+31xf70g=;
        b=RnvoGAxGwdikhKT4SupAxcADFamYOt+/v6RSL1oTb/zDbv1TM2he0JfutFX0uxibsD
         aXfgAAPUlUpjgysAiDQd4529DHvHf+CRHuCzA3rdEZt3Lo9uF070u8Vc6hdwtGGCfB+P
         QOl8M4FHCDbGl0EnClfCc8ZznvdwK40yN+tsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677619792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8cphB32FCA+JDrayMTXIg9hnTVIdgiqn6d+31xf70g=;
        b=amfr3UGwcsWgQVcX5C3e9Cuoz7PT5dAry5MkiFEzBTw/KJpVP4F0zytHumTicxQ/ct
         XLy6A9NJ9Ud5Z82SspPeiwkx1fOPhcgmacxvhItayFSlFm95pgC67GLuEXbxYfuoVB1A
         a0RYxvWptrJBHnaUFtDCgxYdxZ58q5GKkwkfiKaSQQZYyZST5Ov0qHQoSALo4zPOXdtF
         ry4p39pKHNQ6c4HHl/UudTlFPWMJIh+LUQLjlHNNanpMN9mRPzqKZ7ahJ60sxHGWu0Xz
         /uyT6oDAw2XgrHhlSVhe3i5qssUoITBaBnTzeW6irlvN275sn0N6jZzc56waGrju61OT
         jmww==
X-Gm-Message-State: AO0yUKWWnwEWQf40Qy2cwOqxyls54eqwldSaR+tPRzFTGUqyiNMHA5Bj
        GRsIinSVY1Fkc6YkjxHruDbs6Rb2kxFy2Z0y6iw=
X-Google-Smtp-Source: AK7set/v185P91w1L2hk0IAyCZvjzZLSk/hJrHa5tDHfkSSYV2hu17YarbOgKcAAtVpEPHlwtFOH8g==
X-Received: by 2002:a17:906:a20a:b0:8af:514f:1078 with SMTP id r10-20020a170906a20a00b008af514f1078mr4346305ejy.31.1677619792622;
        Tue, 28 Feb 2023 13:29:52 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id gv28-20020a1709072bdc00b008b8ae79a72bsm4976459ejc.135.2023.02.28.13.29.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 13:29:51 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id ee7so45935673edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:29:51 -0800 (PST)
X-Received: by 2002:a50:c34a:0:b0:4ae:f144:2c8e with SMTP id
 q10-20020a50c34a000000b004aef1442c8emr2699107edb.5.1677619791223; Tue, 28 Feb
 2023 13:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
 <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com> <CAGudoHEV_aNymUq6v9Trn_ZRU45TL12AVXqQeV2kA90FuawxiQ@mail.gmail.com>
 <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
 <CAHk-=whwBb5Ws8x6aDV9u6CzMBQmsAtzF+UjWRnoe9xZxuW=qQ@mail.gmail.com> <CAGudoHH-u3KkwSsrSQPGKmhL9uke4HEL8U1Z+aU9etk9-PmdQQ@mail.gmail.com>
In-Reply-To: <CAGudoHH-u3KkwSsrSQPGKmhL9uke4HEL8U1Z+aU9etk9-PmdQQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Feb 2023 13:29:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgsVFvGrmbedVgpUjUJaRTMVxvGkr-dcR7s30S_MyDZfA@mail.gmail.com>
Message-ID: <CAHk-=wgsVFvGrmbedVgpUjUJaRTMVxvGkr-dcR7s30S_MyDZfA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 1:21=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> This is part of the crap which made me unwilling to do the clean up.

Yeah, it's not pretty.

That said, the old code was worse. The only redeeming feature of the
old code was that "nobody has touched it in ages", so it was at least
stable.

              Linus
