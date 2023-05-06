Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93666F8DCB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjEFB5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjEFB52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:57:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63064C13
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:57:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-95369921f8eso400654666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 18:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683338244; x=1685930244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEWaeK4UyXB7rn8ZKDm/RsGKdWKXNNR3xA3d9AaLO1U=;
        b=hfkmoCh9+s9eKjC4ySe+4Oi67C/X5glrG1WMZThklykBNLtF6xkISkUYXQdjRy3kqk
         YMVi+1x+ugZ7n95TeLfloGPhgP4fjXsBUAHE8HfVZlY233wq2xiIZV4axu7COJa4bdfI
         xslVOq3uM1pBH3AyUAVnmTSDlY0O9O4qouG9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683338244; x=1685930244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEWaeK4UyXB7rn8ZKDm/RsGKdWKXNNR3xA3d9AaLO1U=;
        b=bnSlyGJj2/kmznDN1WfaKkY9bQj2rNdqIyK4cxBz9OpVkQaNdkZ/Y3TCrTjTgLAw+O
         kVk1I3wGKcCOHl4TpYzv6U1ErlXfggWiXB+9e5XpT8zC32W481NAKEntSyNljTV2zb1U
         VsIu7YFgccxt7eJ4XbvPKj/gHWnz1Kp++jwb0Knzf7JOQkwt/1kOQllHyyUAurMJN9qY
         Ig77IGSSiUICHYw0q1DqtFKzsLKjJpJ7p6KSPIoOhDASj/eIUdlgCm4buVfk84A6spQ2
         oRLrIo3HeUdluyXY/EgPgz83snVD6QBvWLmYnbH2hMM/F7Dpjbqt3k97ngb2dH9tig6t
         kHQg==
X-Gm-Message-State: AC+VfDyIVmRlpdjx9DamUXj3SPabGIxEtMSr1Z/Xzy5aoZ88FhaLFqUi
        k1J27tnDpY4ciebm7IX50Joj6ANu7ZVh/z+sv0dn6g==
X-Google-Smtp-Source: ACHHUZ5MBOe1I4q1Xu7rgmjOSBG4+SNC0o0vzs/jOLDo7GRXitzKpG1iwMw3tCMl9iLxDBIHHeJa4A==
X-Received: by 2002:a17:906:6a15:b0:94f:2840:14c9 with SMTP id qw21-20020a1709066a1500b0094f284014c9mr3006804ejc.62.1683338244129;
        Fri, 05 May 2023 18:57:24 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id g25-20020a170906349900b00965ac8f8a3dsm1641677ejb.173.2023.05.05.18.57.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 18:57:23 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso3702196a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 18:57:22 -0700 (PDT)
X-Received: by 2002:a17:907:6eaa:b0:94a:9ae2:1642 with SMTP id
 sh42-20020a1709076eaa00b0094a9ae21642mr3442159ejc.46.1683338242456; Fri, 05
 May 2023 18:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230505223909.29150-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230505223909.29150-1-lukas.bulwahn@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 May 2023 18:57:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiX6xj9ck9u7_iN6HRFbLtpXSGfHtidUZSHfddx87FLdg@mail.gmail.com>
Message-ID: <CAHk-=wiX6xj9ck9u7_iN6HRFbLtpXSGfHtidUZSHfddx87FLdg@mail.gmail.com>
Subject: Re: [PATCH] s390: remove the unneeded select GCC12_NO_ARRAY_BOUNDS
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 3:39=E2=80=AFPM Lukas Bulwahn <lukas.bulwahn@gmail.c=
om> wrote:
>
> Linus, as this is just a quick clean-up improvement to your commit
> "gcc: disable '-Warray-bounds' for gcc-13 too", this can probably just
> go directly to your tree.

Done.

               Linus
