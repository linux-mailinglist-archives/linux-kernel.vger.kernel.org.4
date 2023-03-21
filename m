Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C036C3610
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjCUPn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjCUPni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:43:38 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE4A2BEDF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:43:34 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id cu36so5065127vsb.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679413413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y00xZTMnW/WazbGdbgQrBycDfNcdSIYV3Mj2B7uLQTc=;
        b=sPFXiF51FOiH1Az8z8W3OFjCkyrxHA+rMnCni2Cfh0p1HCJTcba1loA9m5PGDrcBXG
         9m+0Pa72K/zYMdNxB8WA+Ea5uLprRi5MKyVdqgvc9IcEHQVbziqDVOwZSF2SEwWHvJFp
         wdlm2p8YJ0yvelTRL6Yg5tRI+T08JHaput8IFf1Lo5momgM1EGsA4BansylobRI3ESf+
         /nOllXRmzQzan52DN49tMCrAZ7utbT7p3Xz3sYSK5e5GOJ4iD+p7oRFZMxF4WGxF/DYD
         DzfJwrC9q726iq7rpNhtVrAnraybW2odx9sG8zE/vhT/Oi4qHerQ+cP2j28uOWuNSft4
         AUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679413413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y00xZTMnW/WazbGdbgQrBycDfNcdSIYV3Mj2B7uLQTc=;
        b=YtQvA47IfIYsYpnlH66FRbZ6U6gGNRJ0TVRrBHDHmOJbPo5bdecjcY/pUvojlfWg9/
         eRQCIIfQy7u1/noUOX1EcbMk8y2feqskw1JQau1pWTHTDvFRuea6Wd2MzTceFDeQC4Br
         nFBFrSiCeVSjtlT9ySMDUaAWrxr04e9rwsXzcSqos+ogVhxx0QV7enzxaLEncWcd0qMD
         M32mTPC0NnJKHQqVxDgCQ6qpI5i0BaDUiqRw9NhsDy+hJUOxSyopXCAQZccC5Gif5zvs
         FgpoMouImfX2nixgh7aP84CYAfQ/jXdVzTOW7gdD1PwFZfO38yibERQA+TL8M5qnGm/1
         W+Uw==
X-Gm-Message-State: AAQBX9cwFez7bNEjs/fg+OmdYlFTYzjFQqDtqNiQSVrk2hOtPBv3d3En
        M+wnF0metOLzCr3fug4RNoyUyfq9HK80Bctf0a/VWg==
X-Google-Smtp-Source: AK7set+uE31fRevBboLUAiIpZN5iCBwZ5X84oVwutDcKQH0rj2bO1OlFmwPCvwxrPKza1UPYQ2We10CceECf7Oyd3pc=
X-Received: by 2002:a67:d891:0:b0:425:b38b:650 with SMTP id
 f17-20020a67d891000000b00425b38b0650mr1896281vsj.7.1679413412722; Tue, 21 Mar
 2023 08:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iLy+-rQDSKCg6g=xkNLL5SmgkB7gyMSgxCEPp13-+eLbw@mail.gmail.com>
 <26269528616bb41dcb2b5a3314f87fb36d45acac.camel@redhat.com>
In-Reply-To: <26269528616bb41dcb2b5a3314f87fb36d45acac.camel@redhat.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 21 Mar 2023 08:43:20 -0700
Message-ID: <CANn89i+vKjBZAC-Htt9K6+WxFHaSH190Mm9WMiy2ZUkuQJZ0Gg@mail.gmail.com>
Subject: Re: syzbot + epoll
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Xiumei Mu <xmu@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 8:20=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:

> (adding Hillf, as was looking to this issue, too)
>
> The fix LGTM and syzkaller says it addresses the issue:
>
> https://groups.google.com/g/syzkaller-bugs/c/oiBUmGsqz_Q/m/1IQ4vbROAgAJ
>
> I see Andrew removed the patch from the -mm tree. I guess at this point
> a new version of "epoll: use refcount to reduce ep_mutex contention",
> including the above is needed?
>
> If the above is correct, would a co-devel tag fit you Eric?

Squashing patches make sense for sure, thanks.
