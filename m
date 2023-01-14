Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A4766AAA2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 10:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjANJpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 04:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjANJpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 04:45:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FB976BB;
        Sat, 14 Jan 2023 01:45:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07A36B8085C;
        Sat, 14 Jan 2023 09:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842F0C433D2;
        Sat, 14 Jan 2023 09:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673689497;
        bh=knaQCVQIx4MAoNmZaFQqow8ZxXL28A+vauPiTP3jWnA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OQP3bwfmSkFF4ODMiewcy49cIutoKPypMTTN2t8SrySg9l2E0cfA3nEwGoUaRO6Fe
         YFkVg/1++UuDcLE3qY1gk9ZXGYgwQusCmpNdM7uH7rVfIxL06Cq7yhGvWxNyJp5rrr
         z7UFImQtXQ7/SiJVZkf0+jXO9eFXDxOiZaMK8EGmM7Wx7bgw16dPQoWnFHfQqcxNZd
         G6SOWIOAsXmNM7cBpFmgzmV5gKn+URUCRZWVD/w2ozhaMegGWw7in2CZA7NHIMo5DT
         HVXbz+QZANZKi1dmrl5UzbxlW+F1ThHMdP6LQWmd88rif+HdpIgWnRxJR7Wl0/84Oo
         BBnBa1JHrJjKA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-15027746720so24732298fac.13;
        Sat, 14 Jan 2023 01:44:57 -0800 (PST)
X-Gm-Message-State: AFqh2kqmJRsBnS02hNUPTxVYDx7hSw2XPSQoWH5EQDL/GjWVKOAXKB8Z
        rDPSbRI3M40AB386xaNy5Hlu+camdZMF4LwJc60=
X-Google-Smtp-Source: AMrXdXsVBAG6cRyjaVXq5OApNwcRn/+arTkdQYuTrAw+J2x024Ebyl2b21DGaJA/rBwC1SNCsp0Gi3IuW26QtwceSSo=
X-Received: by 2002:a05:6870:514c:b0:150:7e4a:2f00 with SMTP id
 z12-20020a056870514c00b001507e4a2f00mr3166709oak.194.1673689496760; Sat, 14
 Jan 2023 01:44:56 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-3-ojeda@kernel.org>
 <CAK7LNATVJ5e=DnbJ++03iEMk0bN3-UvODBLkEKcYdSnJZa_tmA@mail.gmail.com>
 <CAK7LNASDu+i4G88TYYa6feg-bha-_cLv1si_ujuSMbWuyUve0Q@mail.gmail.com> <CANiq72k6jCf_LP5vmBHKEpZ5njmH+u1HpJUjs_GyFi1a4B94ew@mail.gmail.com>
In-Reply-To: <CANiq72k6jCf_LP5vmBHKEpZ5njmH+u1HpJUjs_GyFi1a4B94ew@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 14 Jan 2023 18:44:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS-5UaBX4CYrt_VFZrfHxLy=M=CpT8Hb-LpH4EAntRRSw@mail.gmail.com>
Message-ID: <CAK7LNAS-5UaBX4CYrt_VFZrfHxLy=M=CpT8Hb-LpH4EAntRRSw@mail.gmail.com>
Subject: Re: [PATCH 3/6] kbuild: rust_is_available: add check for `bindgen` invocation
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alexandru Radovici <msg4alex@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 8:10 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jan 12, 2023 at 5:35 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > I meant this:
> >
> > if ! bindgen_libclang_output=$(LC_ALL=C "$BINDGEN" $(dirname
> > $0)/rust_is_available_bindgen_libclang.h 2>&1 >/dev/null); then
> >        [snip]
> > fi
> >
> > (">/dev/null" was lost in the previous email)
>
> I used the error code in the message below. I am happy either way.
>
> Cheers,
> Miguel


Ah, I see.



How about this?




bindgen_libclang_output=$(LC_ALL=C "$BINDGEN" $(dirname
$0)/rust_is_available_bindgen_libclang.h 2>&1 >/dev/null) \
         || bindgen_libclang_code=$?

if [ -n "$bindgen_libclang_code" ]; then
       echo >&2 "***"
       echo >&2 "*** Running '$BINDGEN' to check the libclang version
(used by the Rust"
       echo >&2 "*** bindings generator) failed with code
$bindgen_libclang_code. This may be caused by"
       echo >&2 "*** a failure to locate libclang. See output and docs
below for details:"
       echo >&2 "***"
       echo >&2 "$bindgen_libclang_output"
       echo >&2 "***"
       exit 1
fi





You can get the error code of bindgen without toggling -e.





-- 
Best Regards
Masahiro Yamada
