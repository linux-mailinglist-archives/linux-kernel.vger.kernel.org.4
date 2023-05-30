Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A82A7160E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjE3NAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjE3M7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:59:55 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667D9EA;
        Tue, 30 May 2023 05:59:32 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-568ba7abc11so15485737b3.3;
        Tue, 30 May 2023 05:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685451566; x=1688043566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUns/AgpqXLAWkbT9nsAikv8VufNiDnQgvXLGdGlTyQ=;
        b=OmrsvIF7hVLwpUuwLixBRJ6u4vsZnI03aBYhM18P6OCXa/SkjvHSiOjWX6yU2Q+gVi
         hZSYPF3eITVKkYItFYr40i+B779YjeABUR1SkuuWHeOyReu71Ytc8ggaIRkhc0xEM/if
         4VJTLo1GjdIk59fADOfd1uFtp0DXUobZ2kIb1rsy+zJyeHL48aoL2Dy+fG3jFt9R0ldN
         gGySuiRHmb2P+Bx+5K/TX2xeZ4KYSiIdtYy3pIyxAJoOuZwR1vFnfswavB3CyexFxUMO
         CyvNnOx/Od3r2WXffSaYZum9hThqDE6T/s2Pvq0DSbvGqtj9N+4juL1VKBfGT3Tq++hv
         89oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685451566; x=1688043566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUns/AgpqXLAWkbT9nsAikv8VufNiDnQgvXLGdGlTyQ=;
        b=APS3hnJ8xndDfz0PyMd5HmsniPcg6eyzZs5rkpWYZB+qsQtWf35w2NYiE+6jrS9B6R
         TxPYgZNCZo3EMBWzaMctHuo3IxmqSozpba9E97VB3s8nTUNhhVxLvcgMzuhuRMibjG0/
         PBjADiZeouBdAYBF3gGyw00D6Aj0Xo24fbiuxcu+2GpNTbDDphfphNaEtz2MZxyyFq4b
         60xDWQ6I3sNnfwUVfNOVgaQuH8i307eBmHZL1e7L6KkY0vVJ4+D8p+ruidK3qU0JDyIB
         9LUy1YLXwtbC2jNBnZi6/skJRqAAG+gfmaCl09BtGGaGFWsyqeh/0tbZ0CyCmeGYw7/D
         XpXQ==
X-Gm-Message-State: AC+VfDyqJTxgysAfQYgzukcw+R1/B957NPvsiUY1V0hh/v9lfzLWcMmL
        vMTT9daNi1gRIdH2UVGrOO4OQdSDim2+g5Opf2I=
X-Google-Smtp-Source: ACHHUZ6l4t9i22MSzrt5nsSF4hfAMZMoK5+1PsXBAafqc9KsjE9oyqW1VOx7h4r+3WcISyPpe5m4/tw+5ClF2mWU1os=
X-Received: by 2002:a0d:d413:0:b0:565:97ee:dd78 with SMTP id
 w19-20020a0dd413000000b0056597eedd78mr2289332ywd.28.1685451566435; Tue, 30
 May 2023 05:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230529111350epcas5p46a1fa16ffb2a39008c26d03c5c63f109@epcas5p4.samsung.com>
 <20230529111337.352990-1-maninder1.s@samsung.com>
In-Reply-To: <20230529111337.352990-1-maninder1.s@samsung.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 30 May 2023 14:59:15 +0200
Message-ID: <CANiq72nTqbof=SThq-PRhz=ks2WRvdUXBzJoesyXUmB2KB5pmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hexagon/traps.c: use KSYM_NAME_LEN in array size
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
> kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
> writes on index "KSYM_NAME_LEN - 1".
>
> Thus array size should be KSYM_NAME_LEN.
>
> for hexagon it was defined as "128" directly.
> and commit '61968dbc2d5d' changed define value to 512,
> So both were missed to update with new size.
>
> Fixes: 61968dbc2d5d ("kallsyms: increase maximum kernel symbol length to =
512")
>
> Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

With the updated commit hash:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
