Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC8674F73D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjGKR2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGKR23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:28:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6132A1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:28:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so73807305e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689096506; x=1691688506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAbWd4eVejrEzVS+228fp0WdS6VB4PRr8i82+ghCjls=;
        b=tRiK8qbG1SzAXug+sVyY836Om/o50+MrsYCxB9zSIK1ZlhRVpBkrfSmdkSzitrivDZ
         31NZ/cnzFneyiSKGgTVNUqx1DLvVS4SX9U1XwBI5VC/yWLuij+X4qcUgULL0OCwwKkAi
         A+MT8hBxHsFbrgqWaVsFsQhZpkLvKMlpDROq1wM74+pWcKe9xIJUgTB3ePaXNwXKcyes
         phzWGb9OzvKacBvz2K3hDzW2Wp/10JRCQRJijjdWc7Gz/WarMMn8rR04TXQyCnr1DUhy
         zXnKW9aQL5AI+2IWTERgUDHnnKKxjj29/J5xS8M87svKya+Xz5vzdDYHUib1PlYWswr2
         HAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689096506; x=1691688506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAbWd4eVejrEzVS+228fp0WdS6VB4PRr8i82+ghCjls=;
        b=UK46S5Vi6TlM7vkfUKhAew23BPNFF9qQWFWJpwVv1MVd+bLlaVznr56qGzasZNxYmX
         qEcMYpnm5Cg/sJl36NP1KFyri+OPAsU/v+CZ6nTvUlR9JHHkBVJ9SZ+3em5z15Bl3xDQ
         w/wjl58v8SMZpfZQsMwQJUlUnEuOlrI71S0Rfru2UY0b7HYs/28fKEpZCom/PSTKXPpN
         hGYvl049kd3DAs3P8sv87es2id6IzNmMhsrqQWOngQk0njKpNl+iwIuq/0HaA0ePT+Kf
         SJWYlFPpqzsGax8C5ZT5RyNVGNgCEm8vCXYxSHvWqxg/mvDaj60yuaMa+ztmdrTfRjuG
         sEnw==
X-Gm-Message-State: ABy/qLbAogbLdyreIxkwqkHAvj9zYsV48mXUSu7h9OptrbKHRhDlMvOx
        /qPHprG1r7pjPaxVXzkkcFyv6A==
X-Google-Smtp-Source: APBJJlG/12CTlRB68oSs36vSi4vauByL6WVCnuQ6QECH7YERJbx8As3CNX5CubZMqGqZTZyXdP4bLg==
X-Received: by 2002:a05:600c:2299:b0:3fb:b005:99d6 with SMTP id 25-20020a05600c229900b003fbb00599d6mr19528603wmf.2.1689096506356;
        Tue, 11 Jul 2023 10:28:26 -0700 (PDT)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id f10-20020adff98a000000b003159d2dabbasm2762802wrr.94.2023.07.11.10.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 10:28:25 -0700 (PDT)
Date:   Tue, 11 Jul 2023 19:28:23 +0200
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Guo Ren <guoren@kernel.org>, Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Evan Green <evan@rivosinc.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: riscv: Document the 1.0 scalar
 cryptography extensions
Message-ID: <ZK2RN7EKqmW87tyQ@vermeer>
References: <20230709115549.2666557-1-sameo@rivosinc.com>
 <20230709115549.2666557-3-sameo@rivosinc.com>
 <20230710151624.GA1987602-robh@kernel.org>
 <20230710-education-evolution-f12520405842@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710-education-evolution-f12520405842@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 04:42:42PM +0100, Conor Dooley wrote:
> On Mon, Jul 10, 2023 at 09:16:24AM -0600, Rob Herring wrote:
> > On Sun, Jul 09, 2023 at 01:55:44PM +0200, Samuel Ortiz wrote:
> > > The RISC-V cryptography extensions define a set of instructions, CSR
> > > definitions, architectural interfaces and also extension shorthands for
> > > running scalar and vector based cryptography operations on RISC-V
> > > systems.
> > > 
> > > This documents all the dt-bindings for the scalar cryptography
> > > extensions, including the Zk, Zkn and Zks shorthands.
> > > 
> > > Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> > > ---
> > >  .../devicetree/bindings/riscv/extensions.yaml | 82 +++++++++++++++++++
> > >  1 file changed, 82 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > index cc1f546fdbdc..361756978da1 100644
> > > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > > @@ -190,6 +190,24 @@ properties:
> > >              instructions as ratified at commit 6d33919 ("Merge pull request #158
> > >              from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
> > >  
> > > +        - const: zbkb
> > > +          description: |
> > 
> > Don't need '|' if no formatting to preserve.
> 
> The existing binding only adds the `|` where the commit message contains
> a #, please drop the `|`s if you end up re-submitting. Otherwise,

I think the `|` is needed because the messages contains a `:`? This is
the case as the messages in this patch have a "Zvk:..." string.
Removing the `|` makes dt_binding_check fail because of that.

Cheers,
Samuel.


