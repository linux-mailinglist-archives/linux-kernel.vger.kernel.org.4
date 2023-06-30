Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BA074354E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjF3GtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjF3GtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:49:09 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EA430C4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:49:08 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6994a8ce3so23209221fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688107746; x=1690699746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DSXNPQ9cSE+8ldFCpxe5231qRGX3JF8PWsLfdfAuz3g=;
        b=hICM+omDFks6kQ89EBT0xpUSj+YToF61eJndpVtCtihFxeQwaevRkEJWr0asmdsAbO
         D+BIvvRzIVyhUN67pLHauRQ3QKPddnwsKgYxjrV8QnzH4ecTeqCdVSTBwu/TrOeuQvzy
         Pi5a/l9hXeTbdlcC6O5Dm2gXTbcYdNl1AlLZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688107746; x=1690699746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSXNPQ9cSE+8ldFCpxe5231qRGX3JF8PWsLfdfAuz3g=;
        b=Xc2GZuBlHZi5mK2Z+T1YfFdrwOp678DDBvAdV6tO0xMrZOrAKPNMI6dllDzLQ9AdFy
         KDrDVatCEVMJMtvBUZEvbNJlK67t7Jb/NQ4rJqNy8m8fPD9lQoB7P5c0UQb05CjuOgeK
         riM+fTRu9QSdHslQJDPHp7KXfsjq7lByPm/Au87IZr80FNtHlS/Tj6nMLrIGsKQx1ryv
         wt+2hJvL98C/B+dW1m2CpTBUFAF7J1HE/CiPROvhMom2dv6zhjnQttMiInK+BzXafn+w
         rWxwA2x5PgKqNOrEfaTcfrpHklgehio8E0ipgpn/DcS2EiSZS4cEPcbH/HqALv8yYk5/
         I18A==
X-Gm-Message-State: ABy/qLYmp8yzgm2FpWgvn7yVtw5Xm6djFHGnZJk9xEFpW5UE/INzbob7
        nn4cbb5Cxj+QDzfsqPIlT0CM1gH/YAJiwY6rPcDNnr+D
X-Google-Smtp-Source: APBJJlGPgM1hGaxqfGdkRECqpV38dg97aG71jvAWh23zNH1p4TGPXapwF46YEjooZ69jcP2vm2zlUQ==
X-Received: by 2002:a2e:730d:0:b0:2b6:caf2:c628 with SMTP id o13-20020a2e730d000000b002b6caf2c628mr1429412ljc.20.1688107746507;
        Thu, 29 Jun 2023 23:49:06 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id ck18-20020a170906c45200b0098e38d2e584sm6510571ejb.43.2023.06.29.23.49.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 23:49:06 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51d9123a8abso1627015a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:49:06 -0700 (PDT)
X-Received: by 2002:a05:6402:12ca:b0:514:96f9:4f20 with SMTP id
 k10-20020a05640212ca00b0051496f94f20mr795315edx.41.1688107745787; Thu, 29 Jun
 2023 23:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230630055626.202608973@linuxfoundation.org> <CAHk-=when9OgPprG57O+DtVFM7X9_wb6x2h4Veq4Gu6TUvxyiQ@mail.gmail.com>
 <2023063030-overgrown-unfunded-7523@gregkh>
In-Reply-To: <2023063030-overgrown-unfunded-7523@gregkh>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 23:48:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjm79krU=PJ372s5PzrbZ=kUDA16WMm==J4Moery3Uu0A@mail.gmail.com>
Message-ID: <CAHk-=wjm79krU=PJ372s5PzrbZ=kUDA16WMm==J4Moery3Uu0A@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/29] 6.4.1-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 23:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> I think the "crazy users" reports might be triggered sooner with stable
> updates than from your tree as well, so this might be a early-warning
> type system.

Yeah, I agree, it might help find any potential odd cases more quickly.

So just as long as you are aware of the false positives by syzbot and friends..

               Linus
