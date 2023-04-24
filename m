Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6D06D69B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjDDQ7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDDQ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:59:43 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0058BB8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:59:42 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id d3so11612387ybu.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680627582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+M9AvHAoqRC62i9d3G/DOubPisEKm8TEzbug9rmEdMY=;
        b=PWkaJuH8u5Q/hy9Fp7MvpFk8hSAodOXWzwkbw211lCE9HVJlRG0fhNGdfRkWWBSbrQ
         Ly41tFgckBhJTguoHbKG3jmdlEjEpuK6RS5Sw2uV5VUiOqhc27REHiyKTzpyiucNrWrw
         Dx+ZExsODNz1e9AMO+Dzc4H7oXjuVBgjJONLyJ/fVF6FJLs81Ww2Dezz+hz8f/F8MrOM
         oNMnX78N58o486HkPfgdLIM9CrV0PHUn/16hX1z0aFlqhF8PnT3eUm9VLcI6Y8kEE149
         4d5ylfFpnU+fZWmly4YwdBwdX8yOjT97bUXrSVz5wdSqAWxtC8xs37j1OqVaBur6+kd1
         Z0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680627582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+M9AvHAoqRC62i9d3G/DOubPisEKm8TEzbug9rmEdMY=;
        b=4mmITk8FAgDLAYSCb713CBtJEHDr4lmETpr5Dc84OWwNmCXuNRYr1/l7ZULGciru30
         tj9yNS/eL3LftCMmT01T6LZGGpEaWQPYGcZjn4tvhWlJmGDMGbnTegKd+qRw3Z2oGxzP
         9lydbD1GWyYcxjVWTun2/2XwGsGQgMdCOE3fcWnh6JqzQrz0O4tMoHc2NC67Md+0H+H6
         Bdl2Aq721Tru/faSzJCv0QvRtP+utTJBZvss/6CF0phVDghOM0xoL4Lswl66aSYZbP/6
         Tect18wqDT0tKrf3zOWUxr8IttDokenMr402qpgaZa4qGo2988qPmTxrRkDcbXkVLSRA
         IWuw==
X-Gm-Message-State: AAQBX9djNdVa2elJ+cBpk+k9O9wvWED5wtSPtxiAzpZ0asNRsp/a4U5M
        W6+IykzksEgclyZRLffaTrQrIWC2F9BfKjdKwLpDpw==
X-Google-Smtp-Source: AKy350YUNAPrmjw8i/CT5c1T5FyMcBkwEJ2ZrKH4otI8LZ6P+7/aZOmJ95PkvmyVQqCxRCExYlSDIVFVw2oBh5Klkfc=
X-Received: by 2002:a25:9:0:b0:b26:884:c35e with SMTP id 9-20020a250009000000b00b260884c35emr45420yba.4.1680627581890;
 Tue, 04 Apr 2023 09:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230404032311.146506-1-gehao@kylinos.cn>
In-Reply-To: <20230404032311.146506-1-gehao@kylinos.cn>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Tue, 4 Apr 2023 09:59:05 -0700
Message-ID: <CAHVum0fR0JZ0gA2oPXRufKok+YydcDnu+k3gF7cTUvvxn16GAQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] selftest/vmx_nested_tsc_scaling_test: fix fp leak
To:     Hao Ge <gehao@kylinos.cn>
Cc:     pbonzini@redhat.com, shuah@kernel.org, seanjc@google.com,
        dmatlack@google.com, coltonlewis@google.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        gehao618@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 8:24=E2=80=AFPM Hao Ge <gehao@kylinos.cn> wrote:
>
> Fix stable_tsc_check_supported fopen but not fclose
>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

I will recommend to expand the commit log to something more descriptive lik=
e:

KVM: selftests: Close opened file descriptor in stable_tsc_check_supported(=
)

Close the "current_clocksource" file descriptor before returning or
exiting from stable_tsc_check_supported() in
vmx_nested_tsc_scaling_test

> ---
>  .../selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c    | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_te=
st.c b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
> index d427eb146bc5..fa03c8d1ce4e 100644
> --- a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
> @@ -126,12 +126,16 @@ static void stable_tsc_check_supported(void)
>                 goto skip_test;
>
>         if (fgets(buf, sizeof(buf), fp) =3D=3D NULL)
> -               goto skip_test;
> +               goto close_fp;
>
>         if (strncmp(buf, "tsc", sizeof(buf)))
> -               goto skip_test;
> +               goto close_fp;
>
> +       fclose(fp);
>         return;
> +
> +close_fp:
> +       fclose(fp);
>  skip_test:
>         print_skip("Kernel does not use TSC clocksource - assuming that h=
ost TSC is not stable");
>         exit(KSFT_SKIP);
> --

Other than commit log, Reviewed-by: Vipin Sharma <vipinsh@google.com>
