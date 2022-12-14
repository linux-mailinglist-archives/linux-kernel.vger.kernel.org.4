Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EE164C1E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 02:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbiLNBdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 20:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbiLNBdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 20:33:52 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1198CE0ED
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 17:33:50 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p36so8012876lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 17:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gh19k+3D0iyWw5+2LHF1TTPwIx7bHWW/g8vFNpbEwZU=;
        b=Uj/Ddmhhjx2tsaz+uPMxNNAM0Xda+GisrgHFW3qdOHw3v0Gc+UoIi27Wrs6gqmQsk2
         swVV71rfcw/uS9l9OOAyeyWEjUlraDkwlurudEIpdzHVWsKz43wGItV+ktVB/G905UG8
         DoCESPs72Z7I4xbqPW/aB+VKVmaSnQ3VFKLtZ01Ndq/wnXCKz2r1atG5w4GxDCfp+a7L
         RTeF+fNQ4183pwfgSSFVAOXr0LPr3W3/RGgRbwZJNlhb0tB7tlBvMUXLFkkf09Xlu9lp
         cdcRFEeNK+elvfAgq83Cv+5k6UaM1SGhyGdQ/kUiVFZnlea/VkzK/iv3xh4yx3zq3Ptw
         aivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gh19k+3D0iyWw5+2LHF1TTPwIx7bHWW/g8vFNpbEwZU=;
        b=NbwsdSWX44rS1WzxS2QtMNjTGK2E5txT2MLRL/WuJuKZo0/YxAR9PMCeisMVd+avqk
         U7Lzd6l2Woi+uEXwTB+3F2zah3dya2tRrWeRjnJTpzdviLPHLqNiVw5VJJ8TEoTNndGx
         sMyUPX7QbcKTqxN6EdTcjIK6l7ql8FskvA8/Rk2enKEiJwBjXntpB/joGCK9nEB/Ft2M
         Zb1jJ2TgE9VAZ+RA2lRzV9oHiXhSKeGrS6cnPjgaeC8pDkh/u6m8NdOkRPSKwCBWnViD
         Mp8ZSwC+XOuuNqHgu42LPFQYMkrJrv6/rPbSB++jzxfXFl/yqY1u43gxjUQtLUzYQFe+
         R2sg==
X-Gm-Message-State: ANoB5pkxbAzSbW7C7rExYtCSiqbjYqL3SCVITR3K/bgIwjYvx49Kvyes
        Nov8JPMbj0GLou2Ch70KNpbuXlizksj1GxgnvEBIHA==
X-Google-Smtp-Source: AA0mqf7+Jp17vrMF2kFO1S4fGbZzejFoCO/2ti2leZM1vfO9+Of5CPHvLhny2c8pCRvJr+Gb6sPZ1pWVdsBq049FSzg=
X-Received: by 2002:a05:6512:344e:b0:4b7:207:6dcf with SMTP id
 j14-20020a056512344e00b004b702076dcfmr316405lfr.632.1670981628283; Tue, 13
 Dec 2022 17:33:48 -0800 (PST)
MIME-Version: 1.0
References: <20221213081103.2182231-1-jun.nie@linaro.org> <Y5jKfdDrJkdKtEbC@sol.localdomain>
In-Reply-To: <Y5jKfdDrJkdKtEbC@sol.localdomain>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Wed, 14 Dec 2022 09:33:41 +0800
Message-ID: <CABymUCMtTmSiZQNV9tXTYp90Jk3M37QiF4z5UbrukB43wSx-mw@mail.gmail.com>
Subject: Re: [PATCH] fscrypt: Fix null pointer when defer i_crypt_info
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, jaegeuk@kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> =E4=BA=8E2022=E5=B9=B412=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=B8=89 02:54=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Dec 13, 2022 at 04:11:03PM +0800, Jun Nie wrote:
> > syzbot report below bug[1]. Fix it with checking null pointer before
> > deferring i_crypt_info.
> >
>
> Thanks, but this has already been fixed upstream by commit 105c78e12468
> ("ext4: don't allow journal inode to have encrypt flag").
>
> Also, I don't think adding a NULL check to __fscrypt_inode_uses_inline_cr=
ypto()
> is a good idea because it is only meant to be called when the inode's enc=
ryption
> key has already been set up.  Instead of making the function return a
> potentially-incorrect result, it was better to address the root cause of =
why it
> was being called at an inappropriate time in the first place.
>
> - Eric

Thanks for the information! Do you know what's the plan/schedule of
back porting,
such as linux-5.15.y branch?

- Jun
