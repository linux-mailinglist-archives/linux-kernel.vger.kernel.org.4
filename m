Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE46724E82
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239678AbjFFVIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbjFFVIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:08:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF6E19A2;
        Tue,  6 Jun 2023 14:08:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30c2bd52f82so6693613f8f.3;
        Tue, 06 Jun 2023 14:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686085719; x=1688677719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ+tI/3uLBG3Hm6G+QtfUFEyGE7CCKdik+X8IMe59lQ=;
        b=q+BgJN8G10a0ZuOuN0UDx5Ro+/Sh5n3Z0AV4viAqhr6Es2Jx8P6aWMqFo1i2Tyb4jB
         eUZya8GS6kaJfF30rSFT/CtGWc8jazWug8LN24Yp7JWYmsjMDsZYyrwesFZP7TPaBvHn
         fHKP+9FGUPXlUziO0G6Dpcx1DlAH0mjGGq8ppUlMV4sN+PM1cx3SjokfuL7m7uXpibWh
         pZoVDrnrklHh/fO842OC6731MdoQBNLNy2r6wFpsnsKmoCO+YyrQcEAG8pYVHTZ0yKEF
         zZHOyiAS3zuhP6I16UGDb5YcEtyZQL1/Hd2GsFhnVR0me3SUrY5W3cO+pnD0ncaUfC/A
         LqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686085719; x=1688677719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJ+tI/3uLBG3Hm6G+QtfUFEyGE7CCKdik+X8IMe59lQ=;
        b=X4I6kfO5xw4D6wKwIk7FPzzaocQQvb2d2ZC+ILKr2kUbLLoZTuD3ZB1xNHNzhZQT8p
         ve2ItZXP4U1lAcL5GJdveE1RvYhmHGjS7yTRGi6X8mJ7NH9lPUpWPgjBj9cTQ93qcKT1
         PfMn6ihO5/aSTMK0dJV9/78ecL6fnGJVOv/Tp81YdjIxpZrOg/KJcKvIUH992jJ/PqEQ
         JCCEkWx6732kkiq1WILJEfuO8/5FhvGxylVvLsOSlBeceNbXkfB6YXAarGQzANiPbBhJ
         aA1EU3UqEo+ibO1yOO/dTnzLuCR8UJJRqr2AylefNxw3Uwa/GU+tGNIO9wdf7UknlkXe
         nikA==
X-Gm-Message-State: AC+VfDyjJktjPK/+7KWtHFvXIXxA2uTQHoBlPpb411cNyeGctqxd0bu2
        xOvQfLACzSSSVZg81AeaImC3An95gaG7mSjFi2k=
X-Google-Smtp-Source: ACHHUZ4xNaei4fJzTIQY4dmaevGm8MrT4Rb+z6/77A7OQ1Z4Wj5ccHIIgM9iRtQPNnRd1aFz5BXBANFG8PfPzmhAYVQ=
X-Received: by 2002:a05:6000:1952:b0:309:49e6:d1af with SMTP id
 e18-20020a056000195200b0030949e6d1afmr2609981wry.2.1686085719138; Tue, 06 Jun
 2023 14:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com> <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
In-Reply-To: <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Tue, 6 Jun 2023 17:08:27 -0400
Message-ID: <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com>
Subject: Re: [PATCH v2] uml: Replace strlcpy with strscpy
To:     Richard Weinberger <richard@nod.at>
Cc:     Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening <linux-hardening@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 4:51=E2=80=AFPM Richard Weinberger <richard@nod.at> =
wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Azeem Shaikh" <azeemshaikh38@gmail.com>
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> > No return values were used, so direct replacement is safe.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
> > [2] https://github.com/KSPP/linux/issues/89
> >
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202305311135.zGMT1gYR-lkp@intel.c=
om/
>
> Are you sure Reported-by and Closes make sense?
> AFAIK the report was only on your first patch and nothing against upstrea=
m.
> So stating this in the updated patch is in vain.

I left the metadata in only for the sake of posterity. If it's not
helpful, I'm ok with removing it.

> Other than that,
> Acked-by: Richard Weinberger <richard@nod.at>

Thanks!
