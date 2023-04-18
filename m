Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDB66E577F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 04:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjDRCaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 22:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjDRCaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 22:30:08 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98BC3C3E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 19:30:06 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-54fbee98814so192356157b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 19:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fasheh-com.20221208.gappssmtp.com; s=20221208; t=1681785006; x=1684377006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDxggslLkUgEL2+ia1HCW7STSsqbXoPlZsIfI7N9xmA=;
        b=xa85+Vj2JsBDsYcpf9HcVto042Lzsl6wYDyKCwA7ceCf0RHJN/thMvVIbuf73ZQaoO
         qjGM3DOMOgRV/XSgWd97nupWFK5kcVKQW1SOlrR4VWQmrI2UkzZKcKY3QaNZoCShmO3Q
         izScWvY20VzXjJK/LS7t/MPQZNb5hCtY6uwbaR4KOGdWveQIZB+BzI6IrIRi4mMPaESV
         47uiN76TTBGvYBySgtfDregPYN0pS57TsjG9Bu0V8R1AOX0yHe7QNK/bQAv0fYfmONwq
         NexDaBQFLE1IWFHpIZUawV75XHzVU9ucSPVlSbijCFuc7HOL3G5rRbzeT/OQXFCxx+ig
         BmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681785006; x=1684377006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDxggslLkUgEL2+ia1HCW7STSsqbXoPlZsIfI7N9xmA=;
        b=ApLKSu3876yVPkBvFjKg6XKykcFcVptqeoYuIkknrvmZA1DBKP4zr7V4zWS2OJ6tmr
         0m2b7x4s4Z57I15fpLzRwekJLTPUtUJ1JjbwyB9Mz7gN6hP3CgkFkbokTi4zuK6q65/k
         pfk7UKqZzPJBkjdqhO0DvtYJE7ovqDAPntXGEvgI5XXa/eNgiYIYhLbhm2K+HnxQegGt
         gYnDdym9VwUHiW6qUDYbrWelZ1jXVoc/Y/mqVLLALCr7J60MokWUQaDoeFoG1lSp+qYZ
         sSXMEmJEwVzRosLaOPEvAph+I7NZGVzcl48h9weRGtQot4V/2UFpA8t167FBb4M1XxZ+
         tBIw==
X-Gm-Message-State: AAQBX9e0A6bQY2mEjAPS4xEPbmi0pp2NkBaAudQv0euEI7z/IvI5CUK4
        7/E0Bgh+iDSO9oiZxPPyvLQhAvcEw2hhHVvGgn1K7Q==
X-Google-Smtp-Source: AKy350bKvrXu9w5GkD4lbrkV8di9EMGrf1pWcKqHnAs24Nn8t8I6pbkm8kneRJMSkr6k/zfpXVg4hEe2duVvIPfKQi4=
X-Received: by 2002:a81:af0c:0:b0:54c:2889:7105 with SMTP id
 n12-20020a81af0c000000b0054c28897105mr10993949ywh.0.1681785005975; Mon, 17
 Apr 2023 19:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230417205631.1956027-1-arnd@kernel.org>
In-Reply-To: <20230417205631.1956027-1-arnd@kernel.org>
From:   Mark Fasheh <mark@fasheh.com>
Date:   Mon, 17 Apr 2023 19:29:55 -0700
Message-ID: <CAGe7X7ntw_iZUsKbcg7PwJAeAqtFBia20rKs=Q__mtYaCMdc2w@mail.gmail.com>
Subject: Re: [PATCH] ocfs2: reduce ioctl stack usage
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        =?UTF-8?B?SmFuIEjDtnBwbmVy?= <hoeppner@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 1:56=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
> On 32-bit architectures with KASAN_STACK enabled, the total stack usage
> of the ocfs2_ioctl function grows beyond the warning limit:
>
> fs/ocfs2/ioctl.c: In function 'ocfs2_ioctl':
> fs/ocfs2/ioctl.c:934:1: error: the frame size of 1448 bytes is larger tha=
n 1400 bytes [-Werror=3Dframe-larger-than=3D]
>
> Move each of the variables into a basic block, and mark ocfs2_info_handle=
()
> as noinline_for_stack, in order to have the variable share stack slots.

Thanks for this,

Reviewed-by: Mark Fasheh <mark@fasheh.com>
  --Mark
