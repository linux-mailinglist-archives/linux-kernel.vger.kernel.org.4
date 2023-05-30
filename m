Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A887160A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjE3M4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjE3Mzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:55:50 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D572B137;
        Tue, 30 May 2023 05:55:26 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-568928af8f5so25319547b3.1;
        Tue, 30 May 2023 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685451309; x=1688043309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EExUiqYGPAGs+gsix048NKVSDGe99d7YwmeqIwl9rU=;
        b=JtxDIm0lWrfYqXp1uWdsfFKWSgbbZ22HNue1yFm4trGTkGFo6xIWrEoI8KhdELLQIq
         DmECGu2waVpow6RkIqk3AX5YTN81bUQ38ACduEbGqRhLkcS4+aytN0jtUfSloYRWKQ+q
         vJ0J2K3/U3iSTAnBLpcaJBTIDJ4PsFSVRybdG1dxrRnsgqT6D7gFv8MPH9l+nYqEATRm
         /oGzvXMzw4aKlZlJX/qsd02+8TlbqEw/84uUqvj61DTDFGSAJGYrjrf8E1nbueJLbm4u
         AlOHw1376rAI3yUYgvk4ZhWGkPLuPeKI/Fb1pBA5e3XSOjJHmY7DC3vI1uRZ8RBpw1hF
         J/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685451309; x=1688043309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EExUiqYGPAGs+gsix048NKVSDGe99d7YwmeqIwl9rU=;
        b=YLtpZ7/HqrBqca3NkitRzarQEJJKzo/8MyoleMJkzaQifngzmhswn9oAtMB5BP7C1O
         LX9GYwQquBWd8TkG4e1WWEY9zzi4yQb5emQHyyAoQJstvDgGttT1g2e8i/K1FMO8r/u1
         3tiGjynt61DGf7HZHSO5dHIXEHCpsfPIFFeit3vhIPQRqlpj3cr067kcwbo8Ra9+8r9C
         cxQgGn5l8tQpDCxVGvZVu3HDQpwlxYxDe0Dx/4eZq+aH7iOGCzulDk1oGMBuaE42kXxz
         /tRXUoS5dyuruYwIwqe54966yfhkL0LZcUg3DUxQ+FLT/L7KRrs8cmvZOKgCvG8fvoxq
         J5fw==
X-Gm-Message-State: AC+VfDzrp+Lu0A3UdUgNs+SEvzE7Uhq7DWXuxJAsUh4ifbmCHnCHxrAx
        vgab2Jb3c91kDPFMbhg/MFUGZlzKX+bytXMjNCs=
X-Google-Smtp-Source: ACHHUZ5KwWXhi07Kjh30oJSe+TRGajfeEVAA8IVgPaXfIBGRdDs8/GBEy83t2qFovXm8Rq72lkhdxxhAmnVRxlXnyNw=
X-Received: by 2002:a81:4fc2:0:b0:560:d022:53ac with SMTP id
 d185-20020a814fc2000000b00560d02253acmr12444958ywb.5.1685451309402; Tue, 30
 May 2023 05:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230529111404epcas5p2d540d726dcf3e21aae2a6a0958e2eea5@epcas5p2.samsung.com>
 <20230529111337.352990-1-maninder1.s@samsung.com> <20230529111337.352990-2-maninder1.s@samsung.com>
In-Reply-To: <20230529111337.352990-2-maninder1.s@samsung.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 30 May 2023 14:54:57 +0200
Message-ID: <CANiq72=QeTgtZL4k9=4CJP6C_Hv=rh3fsn3B9S3KFoPXkyWk3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/xmon: use KSYM_NAME_LEN in array size
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     bcain@quicinc.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, keescook@chromium.org,
        nathanl@linux.ibm.com, ustavoars@kernel.org, alex.gaynor@gmail.com,
        gary@garyguo.net, ojeda@kernel.org, pmladek@suse.com,
        wedsonaf@google.com, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Onkarnath <onkarnath.1@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 1:14=E2=80=AFPM Maninder Singh <maninder1.s@samsung=
.com> wrote:
>
> +static char tmpstr[KSYM_NAME_LEN];

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Side-note: in `get_function_bounds()`, I see `kallsyms_lookup()` being
used, but the name seems discarded? Can
`kallsyms_lookup_size_offset()` be used instead, thus avoiding the
usage of the buffer there to begin with?

Side-note 2: in `scanhex()`, I see a loop `i<63` using `tmpstr` which
then is used to do a `kallsyms_lookup_name()`, so I guess symbols
larger than 64 couldn't be found. I have no idea about what are the
external constraints here, but perhaps it is possible to increase the
`line` buffer etc. to then allow for bigger symbols to be found.

Cheers,
Miguel
