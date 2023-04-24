Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FC16ED3D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjDXRoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjDXRoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:44:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6097729A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:44:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4eed6ddcae1so20474163e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682358245; x=1684950245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixBLe3NtbULr+G7HNCZvSVu77/ESFEdi1SlI0hk10s0=;
        b=Y1+9bBv82H0qkiY6XJAiUtJw+pIgsRyClNLxp3g0ajg8G1vhS+pFCY3I6Qld9VkXbQ
         AIU/4leBCbiFNEBorL3H9dB7Kzy3H4wuApAVhVw511tEORNQYxw0cBKucpDxKKk2qgN0
         nLMlZqOm7FVkWswP/YPnvr9PaosefSEpQEyn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682358245; x=1684950245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixBLe3NtbULr+G7HNCZvSVu77/ESFEdi1SlI0hk10s0=;
        b=E7oKnDQYpxJtHhtaFKlynLdFwKCPP1n6qqr4RxOqJJKghjYmy2R4gdR3fX7E+44izY
         NXPRGCliImmT9NLl+71jPE14lVY3xRmEj4btD/HTWQj9DPPxVml8s8CfRPFwEeX1gsCQ
         9awTNmvsrCod+0BMxJv0Xksl64rqz1QtGmewB3IEN+r6H7ykPOPlEnJ3tO/YDmZeo0Uu
         lrj+tCfoY1G0TfTIb0+F834SEQ3YDEj47aSuH/sfnpwVYIGg6wHg5a6uTvQ6IOMcFVTA
         FJtujdvQ+qvVMV7ods1jUInWIttCI41DV9WiG7kkGClKJs4WXi0oRyv7jKBp4hJuZP9Q
         ZTxw==
X-Gm-Message-State: AAQBX9f006OKxXlXeSyz3YCctfWaz7a3C5+rd1nAG3rv9Z2CapHUPlR7
        2rnKJS5+xdQ1VZX8UfWqv5kz+Xb4l+IEtG44plzkVcGW
X-Google-Smtp-Source: AKy350al7Uks4faLgUgg9M4ovphTxOGKyYKaAHLnzDUCsDVHzQ6VrDM3QN25S3l3837o8VN4FnQ+9Q==
X-Received: by 2002:ac2:44cd:0:b0:4ec:ae17:81d9 with SMTP id d13-20020ac244cd000000b004ecae1781d9mr3643245lfm.32.1682358244848;
        Mon, 24 Apr 2023 10:44:04 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id n15-20020a056512388f00b004e96afb1e9asm1745673lft.253.2023.04.24.10.44.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 10:44:04 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4ec816d64afso20439327e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:44:04 -0700 (PDT)
X-Received: by 2002:a05:6402:d1:b0:506:c238:4067 with SMTP id
 i17-20020a05640200d100b00506c2384067mr13659251edu.8.1682357791917; Mon, 24
 Apr 2023 10:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221016182349.49308-1-masahiroy@kernel.org> <20230424162110.11082-1-lrh2000@pku.edu.cn>
 <CANiq72=Kb6ckhU8Ss9=Dg4Zn11Us+DLbKnNWAVaTb-nv7Y=ARA@mail.gmail.com>
In-Reply-To: <CANiq72=Kb6ckhU8Ss9=Dg4Zn11Us+DLbKnNWAVaTb-nv7Y=ARA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 10:36:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDAYoWVEPSn2cD5YMjPN+nNYbHw3t8_=UiRi5V7WKgaA@mail.gmail.com>
Message-ID: <CAHk-=whDAYoWVEPSn2cD5YMjPN+nNYbHw3t8_=UiRi5V7WKgaA@mail.gmail.com>
Subject: Re: [PATCH] scripts: Remove ICC-related dead code
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Ruihan Li <lrh2000@pku.edu.cn>, masahiroy@kernel.org,
        arnd@arndb.de, bp@alien8.de, dave.hansen@linux.intel.com,
        devel@acpica.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, mingo@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, rafael@kernel.org,
        robert.moore@intel.com, terrelln@fb.com, tglx@linutronix.de,
        trix@redhat.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 10:27=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

I took that patch before this email came in, so that reviewed-by will
be missing in the tree, I'm afraid.

                     Linus
