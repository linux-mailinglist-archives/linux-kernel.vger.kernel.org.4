Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB876A1D85
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjBXOeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBXOeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:34:36 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2C42C67D;
        Fri, 24 Feb 2023 06:34:35 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id bi17so16132004oib.3;
        Fri, 24 Feb 2023 06:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7f5POC95tWdgN8iOavzbfp8kNM32j24hhcNafGkcLU=;
        b=OEIHtp3hjddjSuARK4ULbWTX4MT7gugGdNIgP+ixZSFAmqNxBjhfLGg6lN8V0yrkE+
         Ecp2AJ1W5kQAScuEqnTDwlTPHkXct0ESXMIa/YbakdRFq137JSsarzhdj01PH5Tj88Fr
         edMufsLQ7DH4z2/tQM++n6TZ3JpJv0wcI825zlf7yruBKv+ToXuFk+UgD35+8N0KVx0B
         0XQzWdW+RMHfQ2+IGaI2xIOIm48FoyYMwU6czsFJfWQu0ACpQsMs+vF1VWJSe1vZEgWL
         PvC4C/2DqEnFsdjTAJyU8OaSTUPg1fD6/Ktb39c8CVwDnaZM/hMqemYhJgtBxMfCl4Kj
         nIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7f5POC95tWdgN8iOavzbfp8kNM32j24hhcNafGkcLU=;
        b=QdHPe6h/pPUvEEYBK59rzjEl9Myez72/yFZ39WwkRYtgOILawSzvW19Ej9QfmR0mK/
         5RJc/5dE5+K8FeVWdyTa9Bn3NrMHupsuwcrnBwyVlr2vbjG8im2SzFpIDmtSMK/HrjyF
         1oHVs6TkWr5P3MQ9DCOZiEJH7m/gkIQPqjq3P8nbHAG4hFJcLWgkdf8wghw10xI28SqZ
         hKWOekGD7EK6V5+kPxfFwLmo+5tc82aSKo4ZTlwjCprhaV843DNHFCAdejv0mETo+szO
         PYn5JD1GfrdAWOXD/boqNaHt5OflzqWtMAPUPDys4IaRwFVweLm41dgXkzvNOpjHYUMH
         eorQ==
X-Gm-Message-State: AO0yUKX4sVm2H91BPsTss4dlHGe1fmQNiOr6Kv741MF3EN1QRCx4E0ZX
        aXvjOvPz4O+IBohd+44xRUc=
X-Google-Smtp-Source: AK7set/LXiCHgH1qPHKSkOLgeyFj3sle61LItHwrs68Wk7g+vCtZIo8xVFWpymalNMwyXni2esdGfg==
X-Received: by 2002:a54:408d:0:b0:384:833:2a79 with SMTP id i13-20020a54408d000000b0038408332a79mr306634oii.48.1677249274683;
        Fri, 24 Feb 2023 06:34:34 -0800 (PST)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id p129-20020acaf187000000b0037d59e90a07sm657005oih.55.2023.02.24.06.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 06:34:34 -0800 (PST)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     lina@asahilina.net
Cc:     alex.gaynor@gmail.com, asahi@lists.linux.dev,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH 1/2] rust: sync: arc: implement Arc<dyn Any + Send + Sync>::downcast()
Date:   Fri, 24 Feb 2023 11:34:29 -0300
Message-Id: <20230224143429.754374-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224-rust-arc-v1-1-568eea613a41@asahilina.net>
References: <20230224-rust-arc-v1-1-568eea613a41@asahilina.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 05:09:47PM +0900, Asahi Lina wrote:=0D
> This mirrors the standard library's alloc::sync::Arc::downcast().=0D
> =0D
> Based on the Rust standard library implementation, ver 1.62.0,=0D
> licensed under "Apache-2.0 OR MIT", from:=0D
> =0D
>     https://github.com/rust-lang/rust/tree/1.62.0/library/alloc/src=0D
> =0D
> For copyright details, please see:=0D
> =0D
>     https://github.com/rust-lang/rust/blob/1.62.0/COPYRIGHT=0D
> =0D
> Signed-off-by: Asahi Lina <lina@asahilina.net>=0D
> ---=0D
>  rust/kernel/sync/arc.rs | 22 ++++++++++++++++++++++=0D
>  1 file changed, 22 insertions(+)=0D
> =0D
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs=0D
> index a94e303217c6..752bd7c4699e 100644=0D
> --- a/rust/kernel/sync/arc.rs=0D
> +++ b/rust/kernel/sync/arc.rs=0D
> @@ -22,6 +22,7 @@ use crate::{=0D
>  };=0D
>  use alloc::boxed::Box;=0D
>  use core::{=0D
> +    any::Any,=0D
>      fmt,=0D
>      marker::{PhantomData, Unsize},=0D
>      mem::{ManuallyDrop, MaybeUninit},=0D
> @@ -220,6 +221,27 @@ impl<T: 'static> ForeignOwnable for Arc<T> {=0D
>      }=0D
>  }=0D
>  =0D
> +impl Arc<dyn Any + Send + Sync> {=0D
> +    /// Attempt to downcast the `Arc<dyn Any + Send + Sync>` to a concre=
te type.=0D
> +    // Based on the Rust standard library implementation, ver 1.62.0, wh=
ich is=0D
> +    // Apache-2.0 OR MIT.=0D
> +    pub fn downcast<T>(self) -> core::result::Result<Arc<T>, Self>=0D
> +    where=0D
> +        T: Any + Send + Sync,=0D
> +    {=0D
> +        if (*self).is::<T>() {=0D
> +            // SAFETY: We have just checked that the type is correct, so=
 we can cast the pointer.=0D
> +            unsafe {=0D
> +                let ptr =3D self.ptr.cast::<ArcInner<T>>();=0D
> +                core::mem::forget(self);=0D
=0D
I see, we cast the inner pointer of the `Arc` to the target type which=0D
is wrapped in an `ArcInner` that is then used for another `Arc`. This is=0D
important as this new value now owns the pointer and, by consequence,=0D
it is safe to forget the passed `Arc` as it won't leak the pointer.=0D
Thus, this method is safe.=0D
=0D
> +                Ok(Arc::from_inner(ptr))=0D
> +            }=0D
> +        } else {=0D
> +            Err(self)=0D
> +        }=0D
> +    }=0D
> +}=0D
> +=0D
>  impl<T: ?Sized> Deref for Arc<T> {=0D
>      type Target =3D T;=0D
=0D
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>=0D
