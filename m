Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB686F965E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjEGA4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjEGA4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:56:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6FA100DC
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 17:55:06 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94a342f7c4cso567674966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 17:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683420881; x=1686012881;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpiOavQ+gXchfKmR1zFFxlUEn+ftnKF3TyEQDre8v2A=;
        b=BpnhwTtrQMIkHv+Q4TzR7PnHWBLP+3S7l1XhgPWOHidvZmqtu6SIqpPyX8VSTK/+mZ
         /I5VJoPB+aj4rXDPXSHiBjx5HdvozQgAEZP/PkDX9/nk3m8GCsn7S+3COnWUi0Py3nYP
         vpXZ5bYQX7ROzO0qoNwtaJXzMnlXeXJaSUsm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683420881; x=1686012881;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpiOavQ+gXchfKmR1zFFxlUEn+ftnKF3TyEQDre8v2A=;
        b=XVbRjIci5UFcDcOputip4JCvIkDObqNB3pXNcG75LVW3ESqG/nK5HzzwA1KQn5fN11
         NoHAOhUwaotCc+slDwA6Zdq+Ej87YSgEvlYXqVOEMT9jyUIGNHB3hcpf9LbnlPpRMpBS
         /9ibtZgLFKqjiJL/bBHvty/f24z7BFj/am5pKOiu/g3UGGKu75D4Nd2hUGuU+w7qXOa+
         hBFNSxz8bnm58r1/HKYDQnLIuB1roZ2TxNn2UDxgqW7zBd3APHd05kpykph2htZhOBkH
         +yGlNB7ChUxxbujVYCLAboWv9FdCkzTmHxfq6T1jNDRGnZZIlCt4Mn0R0iaeOiIgccG/
         /tAg==
X-Gm-Message-State: AC+VfDzD4QRgUy3eyRWcE/6IvZccSbMxGV2IarOMqRqs2glIW5gFgXOU
        d8sSsshtUq7hUVOAa6zr35ge4ZVXQ2PEFmuBXXtP1Q==
X-Google-Smtp-Source: ACHHUZ47v546ZliMi1stX0oietWtmiKPf1C0PbYTUdY3cYsCiJG2u7YbCsXuxIHgBkaU/4GMk23s2g==
X-Received: by 2002:a17:906:974b:b0:957:943e:7416 with SMTP id o11-20020a170906974b00b00957943e7416mr5885583ejy.15.1683420881300;
        Sat, 06 May 2023 17:54:41 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id nr1-20020a1709068b8100b0096621340285sm1228373ejc.198.2023.05.06.17.54.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 17:54:40 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9659f452148so566878766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 17:54:40 -0700 (PDT)
X-Received: by 2002:a17:907:944d:b0:94e:fa56:a74f with SMTP id
 dl13-20020a170907944d00b0094efa56a74fmr4763145ejc.14.1683420879818; Sat, 06
 May 2023 17:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <ZFbY7siXjm9hhpUB@debian>
In-Reply-To: <ZFbY7siXjm9hhpUB@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 May 2023 17:54:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiA=7uuzs-JEDDrPtPbFqULGDtEYiV=K+ZW9n_BftUrSw@mail.gmail.com>
Message-ID: <CAHk-=wiA=7uuzs-JEDDrPtPbFqULGDtEYiV=K+ZW9n_BftUrSw@mail.gmail.com>
Subject: Re: Debian package build from upstream source need git repo?? Failing...
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
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

On Sat, May 6, 2023 at 3:47=E2=80=AFPM Bhaskar Chowdhury <unixbhaskar@gmail=
.com> wrote:
>>
>   I can vividly remember that it was working fine few months back...in fa=
ct
>   building the 6.2.2 kernel. I am certainly missing the updated informati=
on of
>   change. The damn script just untar the tarball and build.

Yes, please just use git if you build packages.

We've been using git for almost 20 years now, it's become the most
widely used SCM in the world, it's time you just laid tar-balls to
rest as a way to distribute kernel sources.

                   Linus
