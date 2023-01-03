Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D4065C85E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbjACUqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238864AbjACUqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:46:39 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC972DC4;
        Tue,  3 Jan 2023 12:46:38 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-4a263c4ddbaso114669477b3.0;
        Tue, 03 Jan 2023 12:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AS/vWqRZ6x9OUsSMq7BdlYNFG1U/IWYpVcw5ZmkhUsQ=;
        b=enr8ncWUjnyLmoN+bT4ZgGAH/VwJR3u5xVztMX2EGj00gJSbCnkXRymBv7G64DkdSh
         iFl+M7cc7sVoiS0JdqJOGndWJV0wyEWUEmOLXqEPEsiiko08s7DiHKHVqUP3xTT5zI6X
         GK98Q4MIftklas54KqdyO/nlVVh9rE/B0aqvnUvoGGAdnnEO35uUfe77Uh6hchwEUHKp
         z+R4gD1N+DHJqut5yF9Xp5cbkxCHWsB1Pe7Z2Sz0/GwRhOr8gPC6jDLIq/FT1yYT3Nza
         jdUHR6YbyoI37ed57PM6z++c1z0LMYtJlt/sbWbm3Fr2zroI1METMHVZQY1fc+/O+pCY
         dmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AS/vWqRZ6x9OUsSMq7BdlYNFG1U/IWYpVcw5ZmkhUsQ=;
        b=OCKltbUU5DlbrXDSkZS8cky8zA+EKxcpfBXIlHtMPOdjvNYz5ocInotptTM4OB9T5z
         3cxILQt3Vc8/CBLNOIt+BrVxJccRlUDzEV9aNgvVGDVhDUDB13ZIR7dfDN6qAVcg2p8Z
         BF6YVgPAURaNkgnjVVzXD9kSasjtXvllPirgK6ymNIiBW+z/qZwlm2073Xi8W2badLbx
         7UYdWA8kjhU0/vOoM/mLztNZkvwvCMM9ZJd3qwhbOwlGMOnVH0db6EOFaSDsIPhe+0UJ
         lRlZks7exMdbAN0QWwevsTJN+IVY8HmJoUEr3cv2JiRf5k6GZURhcnrhaWfZ7oeAUKjz
         eCmA==
X-Gm-Message-State: AFqh2kqRC2sduU0L8TdF9igGZ+kBRdWmhs3JDZSARbKeZKuIhKuleuuP
        vjfkBcqO9jsQE5LjOFYCSZDpN9Ytacasr6P12WQ=
X-Google-Smtp-Source: AMrXdXvu9rgMUFYc2t+HPZIqr+bY3bfGne7DLfYo4HbWyfy4UVncyz+QbfP2ASxz7Kh1JM0l0OIp9YuwqJgVseR8o7w=
X-Received: by 2002:a81:7343:0:b0:484:a94f:210 with SMTP id
 o64-20020a817343000000b00484a94f0210mr3181124ywc.129.1672778797905; Tue, 03
 Jan 2023 12:46:37 -0800 (PST)
MIME-Version: 1.0
References: <20221231064203.1623793-1-masahiroy@kernel.org> <20221231064203.1623793-7-masahiroy@kernel.org>
In-Reply-To: <20221231064203.1623793-7-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 3 Jan 2023 21:46:26 +0100
Message-ID: <CANiq72k5xQV0T0Md43yJaVB-0ORURfK1r4qX2RSnrB8A5su0Eg@mail.gmail.com>
Subject: Re: [PATCH 6/6] fixdep: do not parse *.so, *.rmeta, *.rlib
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 7:42 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> rustc outputs *.so, *.rmeta, *rlib to dep-info. fixdep needs them in
> the dependency, but there is no point to parse such binary files.

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
