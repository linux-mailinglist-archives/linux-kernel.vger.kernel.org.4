Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF43744889
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 12:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjGAKuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 06:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGAKt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 06:49:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1613ABD
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 03:49:56 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51dd0205b2cso4792761a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688208594; x=1690800594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yy74r11zEdWsHFYiWRbF/mcSfP7vY0N5EyD0HnLO+xY=;
        b=ZW8+GT+RDP8ZXRsCLgL4Bp0/4JHSxiDaWKQCEGiBcvpUjtP5E2ZbS1cAcN2h5xhn2x
         saaWLU89bq7tnk7qeR/FpIDEb4ASsHLIX2dy/uNGDTKWsxiYx71V+l3y2rfx8vZFBYzY
         0Yzo2SmgseAVhVbiwYsuhsshMSf7oI3MjbVHtYCEQOGsEeJzf0m2dA6fZYEUYLW7tTQK
         MhGvle0Y3r9Sh+C7lXXNuR/O83qreoxvMe7poRjc7hx/zgIfqGairNwnmCs21ri8mfcz
         FzFqWngc6gbWwY46AkNsLRDNm1Haugwp47QLl5Tu5k23tOKJQk4TwzfI7uTY1NK8cDzG
         v3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688208594; x=1690800594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy74r11zEdWsHFYiWRbF/mcSfP7vY0N5EyD0HnLO+xY=;
        b=SFGoWzTjNtWRNaLYvVf7WFDvWTlEQDH/nV2O/lqwjrI8k93Gx5tHkRGUqZZdZTMSg+
         +5DzGl7SBt8+XpyKXNPiuhhOboqrr9oZVlllu3wwwvENAz/ZB5brrTT+48eZm5CESwst
         nU6Pfm868W8r7xm7HDHwVdRPRAdbE5tRNFLEIJ0V/Yk3AAO3XGOtXBiBpd63G0vo6MB5
         LVVP22TI7SUz8kQ6U3JkHOCf3/1bV9txqw6A6UCGMnDcCKjC3XOa0z5FDNTal9N65Nis
         UNvRsmTGSxvKx44cnBQRwYfnu2wEFMUbvBOKMPaDwg2MvInBLamZShSAIyYPV5WHrteD
         nqTw==
X-Gm-Message-State: AC+VfDxdiM+2FjpMg6k8Ga3J36u4MarkOXAz6Gdz+40uRd0i1gyXKFbD
        3zTs3yc+fOjSZ06Fz9YCNzKJl5Sfh0aZwAO0XV0=
X-Google-Smtp-Source: ACHHUZ63HJaiSjtPUrA2MKbj0y3+pjdKkuCMv+y2Yz6Ok03XFHlhsmYzKA9rCUssSRl/SCT4Te/xCQ==
X-Received: by 2002:a17:907:8689:b0:982:7434:ea84 with SMTP id qa9-20020a170907868900b009827434ea84mr6741959ejc.10.1688208594650;
        Sat, 01 Jul 2023 03:49:54 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id gt12-20020a170906f20c00b00992b2c5598csm2828739ejb.128.2023.07.01.03.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 03:49:54 -0700 (PDT)
Date:   Sat, 1 Jul 2023 12:49:53 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, heiko.stuebner@vrull.eu,
        Evan Green <evan@rivosinc.com>, sunilvl@ventanamicro.com,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] RISC-V: provide a Kconfig option to disable
 parsing "riscv,isa"
Message-ID: <20230701-623f719c181e08b43930de11@orel>
References: <20230629-landed-popsicle-ab46ab3b46d9@spud>
 <mhng-f060b5c8-aa99-4952-b1e1-ee85a92e6b07@palmer-ri-x1c9a>
 <20230629-angled-gallantly-8fe7451a25fa@spud>
 <20230630-7d0f6fe66c9415315d491f15@orel>
 <20230630-urgency-emission-882cd52a7a27@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630-urgency-emission-882cd52a7a27@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 02:19:46PM +0100, Conor Dooley wrote:
> On Fri, Jun 30, 2023 at 09:46:48AM +0200, Andrew Jones wrote:
> > On Thu, Jun 29, 2023 at 10:44:18PM +0100, Conor Dooley wrote:
> > > On Thu, Jun 29, 2023 at 02:16:49PM -0700, Palmer Dabbelt wrote:
> > > > On Thu, 29 Jun 2023 13:20:55 PDT (-0700), Conor Dooley wrote:
> > ...
> > > > > +bool __initdata riscv_isa_fallback_cmdline = false;
> > > > > +static int __init riscv_isa_fallback_setup(char *__unused)
> > > > 
> > > > Maybe it's better to support =true and =false here?  Not sure it matters,
> > > > we're already down a rabbit hole ;)
> > > 
> > > Dunno, not implemented a cmdline param before. Seemed "cleaner" to check
> > > for presence, don't really care so I'll adapt to w/e.
> > >
> > 
> > I don't have a strong preference here, but to throw in more food for
> > thought, I see this DT-v1 vs. DT-v2 choice to be a bit analogous to the
> > DT vs. ACPI choice. The 'acpi' command line parameter, for RISC-V, can
> > be 'off', 'on', and 'force', where
> > 
> >   off -- disable ACPI if default was on
> >   on -- enable ACPI but allow fallback to DT
> >   force -- enable ACPI if default was off
> > 
> > So, if the default of the isa fallback command line option will depend on
> > Kconfig, then we may also want a 'force'.
> 
> I'm not sure that I understand what "force" would give us.
> There's 4 cases:
> - CONFIG_RISCV_ISA_FALLBACK is enabled, cmdline option is present:
>   cmdline option is ignored, fallback is taken if needed.
>   crash if neither are present.
> 
> - CONFIG_RISCV_ISA_FALLBACK is enabled, cmdline option is not present:
>   cmdline option is ignored, fallback is taken if needed.
>   crash if neither are present.
> 
> - CONFIG_RISCV_ISA_FALLBACK is disabled, cmdline option is present:
>   cmdline option takes priority, fallback is taken if needed.
>   crash if neither are present.
> 
> - CONFIG_RISCV_ISA_FALLBACK is disabled, cmdline option is not present:
>   fallback is never taken
>   crash if new properties aren't present.
> 
> I don't really see the value in having an equivalent to acpi=off,
> because the order of precedence is, to use your naming, "DT-v2" falling
> back to "DT-v1" & the default value concerns the use of the fallback.
> For ACPI, it is the other way around & the option controls the use of
> "DT-v2"'s analogue. Trying to slot in that logic:
> 
> - CONFIG_RISCV_ISA_FALLBACK is enabled, cmdline option "=on":
>   cmdline option is ignored, fallback is taken if needed.
>   crash if neither are present.
> 
> - CONFIG_RISCV_ISA_FALLBACK is enabled, cmdline option "=off":
>   cmdline option is prioritised, fallback is taken if needed.
>   crash if new properties aren't present.
> 
> - CONFIG_RISCV_ISA_FALLBACK is disabled, cmdline option "=on":
>   cmdline option is prioritised, fallback is taken if needed.
>   crash if neither are present.
> 
> - CONFIG_RISCV_ISA_FALLBACK is disabled, cmdline option "=off":
>   fallback is never taken
>   crash if new properties aren't present.
> 
> I think I prefer the behaviour of what I currently have & I don't really
> get where the "force" option is supposed to fit in either?
>

WFM

Thanks,
drew
