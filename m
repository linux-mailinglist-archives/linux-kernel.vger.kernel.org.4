Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6B36EDA39
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 04:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjDYCY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 22:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDYCY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 22:24:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE8DA5CB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:24:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94f1d0d2e03so743139966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682389464; x=1684981464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOVclYKRWNV3JGuq2gLOY6hCBQpyxUe3mzcJx3TTPwU=;
        b=a0elG3YFwWJIvXEqchJXO39RR9pnx5UzsJ0iyHEreb4o2DoYKPIwJ1w/yPJ1TJDLFZ
         g42+s4At/tL+mWfVqjZzK39m4HeFwAi2GyenUZ+yBBAm9grOMYahxkIxkKTBJxKJV7/6
         pMxGxcI2mNtdEfEMIMM5jjTne/wmXnIhQboqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682389464; x=1684981464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOVclYKRWNV3JGuq2gLOY6hCBQpyxUe3mzcJx3TTPwU=;
        b=Sl0d5U0lxWpgfESx+YjdrwX8p+gybRqI2WW5/gpE/NTiOcPfaFxB1bC1tILdaSFz6h
         8sJ9ud7yCovHr1wkcebCRP0KZH6mrWZ5HAqv8hnYVTD3q2ldioina5N9Vget5EdbGJgk
         AtRJzlQQ0ZEEVlJ/ZAjZKGt6a3Lb7m+t0Xn3c3Ab6/xJvPW0JhBy0kM6KMKp6kV6w/Gb
         n8jTyxA35d0LikwyN3EcVLcJyP1zLl6OsBU65y1CbzThUCYAAg706Dq4/893NsXCCyQS
         lrq46rZieyyQEuWJuRW3qXzro+ShxfwYTYc1f1Rv+myIonbD9wuXFoH0AC6XhCECWLxx
         p9sQ==
X-Gm-Message-State: AAQBX9e5FXQvPXMy3mM8Qq9ZPN2lrP+wG2wAr4a8kMuwNU/9hhD2A8MJ
        c6ZEeITKz+nB6wtXNB+U/ZZVRkI1DoZ7YrA2LKHtSIoj
X-Google-Smtp-Source: AKy350bMGRwYlwB9cvHT9idM4JjAQf3PEbhlyLaeU4nlynqZaouSdgBv9ue1XYKMuHCk9sCK5asU5w==
X-Received: by 2002:a17:906:555:b0:94f:1ac0:850b with SMTP id k21-20020a170906055500b0094f1ac0850bmr10970940eja.71.1682389463978;
        Mon, 24 Apr 2023 19:24:23 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id op14-20020a170906bcee00b0094f07545d43sm6072428ejb.188.2023.04.24.19.24.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 19:24:23 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-50674656309so7952188a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:24:23 -0700 (PDT)
X-Received: by 2002:a50:ee86:0:b0:506:a446:b926 with SMTP id
 f6-20020a50ee86000000b00506a446b926mr14495282edr.19.1682389462745; Mon, 24
 Apr 2023 19:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230424042638.GJ3390869@ZenIV>
In-Reply-To: <20230424042638.GJ3390869@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 19:24:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibAWqh3JqWaWfi=JWNAz3v_qb7LZ+76qF+PKEJciHbGA@mail.gmail.com>
Message-ID: <CAHk-=wibAWqh3JqWaWfi=JWNAz3v_qb7LZ+76qF+PKEJciHbGA@mail.gmail.com>
Subject: Re: [git pull] the rest of write_one_page() series
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Sun, Apr 23, 2023 at 9:26=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> write_one_page series

Hmm. These pull requests really could have done with better descriptions.

Yes, I see what it's doing, but I'd really like to have better merge
messages from the pull request.

                 Linus
