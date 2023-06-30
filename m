Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76A374362A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjF3HsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjF3Hrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:47:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7543C12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:46:51 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so1881772a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688111210; x=1690703210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gkEVUn+BSGCw26Br9R1zJay0XQU2Hj1OrR3nyO4XYMs=;
        b=pXW7rqo2IPCCQNelaVb4brBvc66A3ZsWjaSvhuweZhbnHl52z8pQnkZvsPvTuVFnjl
         O8sSSJB0DWG46EaLZsvx1SOe+L/d37a9A0x6Pevillxw2A/kVu0f3BQT78pI7QFeCwZp
         G2RZH9s5TafP0LSUNkJZ3Ovd/EcLBs6haxbhhkqWvvDTwNZql5nbOBbMc5AJLWw96j01
         bO7wHfy0r8BbfI23SDIZN5JRXVO6/sOLrrKypk3TSwwoR7EpX8rRtDLO05FoUywhlI/N
         xI1lmHzC5sKJ2bN+jiDxyTOWr1cTFW4pxG+g1r0ycbnhuIqVpMPXwBTgLmCn5DF5EVoZ
         TaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688111210; x=1690703210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkEVUn+BSGCw26Br9R1zJay0XQU2Hj1OrR3nyO4XYMs=;
        b=lAtNjiaBuj9W574nZzblY9KuCQ5I3rr0ZHH0WJtKH9QisGrjDueeYYjoth2FT9ncW2
         /K3CdwYiF0knO/uQ74YgYZ4bKoM8BQaev9iQ/sgum+F7mO2p1KLRQ4BZzVIKGYwb3d3n
         VJ3cTIlpXTgOahasEdqR/NGm5Q3ticOgVeNnpsc7oqv0uUkbSPOHAeItRHp4iYb3A3yp
         k0j2gTUugnH3jJ1ZhHUU1iCObeo5J+24FIaFc+VaEpfCeB3MTXdH1LirLRK2g3BUSQyg
         gt+91zdzN9gotEbLYCUpHeS7Fnl0gJF08HT3sn21HUz5Ntnw4q/o8OXuu1JHhDslx51x
         Nw9Q==
X-Gm-Message-State: ABy/qLam3pZRoti9b76lPJI3PC2Jg36GJL2KMn1Nd5eh72RLWLqTKwdc
        qSrFXU6Sax078/Yg0aK0bjhRqg==
X-Google-Smtp-Source: APBJJlFgqHa9gDbozF0P92T72GWSMIP3fuYpYu4HFpS6dAtkIvNTi5BLg3397B7OHXeTVHiRxxPH/Q==
X-Received: by 2002:aa7:d98f:0:b0:51d:e59c:6190 with SMTP id u15-20020aa7d98f000000b0051de59c6190mr1208294eds.2.1688111209947;
        Fri, 30 Jun 2023 00:46:49 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id i12-20020aa7dd0c000000b0051830f22825sm6503023edv.90.2023.06.30.00.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 00:46:49 -0700 (PDT)
Date:   Fri, 30 Jun 2023 09:46:48 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, heiko.stuebner@vrull.eu,
        Evan Green <evan@rivosinc.com>, sunilvl@ventanamicro.com,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] RISC-V: provide a Kconfig option to disable
 parsing "riscv,isa"
Message-ID: <20230630-7d0f6fe66c9415315d491f15@orel>
References: <20230629-landed-popsicle-ab46ab3b46d9@spud>
 <mhng-f060b5c8-aa99-4952-b1e1-ee85a92e6b07@palmer-ri-x1c9a>
 <20230629-angled-gallantly-8fe7451a25fa@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629-angled-gallantly-8fe7451a25fa@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 10:44:18PM +0100, Conor Dooley wrote:
> On Thu, Jun 29, 2023 at 02:16:49PM -0700, Palmer Dabbelt wrote:
> > On Thu, 29 Jun 2023 13:20:55 PDT (-0700), Conor Dooley wrote:
...
> > > +bool __initdata riscv_isa_fallback_cmdline = false;
> > > +static int __init riscv_isa_fallback_setup(char *__unused)
> > 
> > Maybe it's better to support =true and =false here?  Not sure it matters,
> > we're already down a rabbit hole ;)
> 
> Dunno, not implemented a cmdline param before. Seemed "cleaner" to check
> for presence, don't really care so I'll adapt to w/e.
>

I don't have a strong preference here, but to throw in more food for
thought, I see this DT-v1 vs. DT-v2 choice to be a bit analogous to the
DT vs. ACPI choice. The 'acpi' command line parameter, for RISC-V, can
be 'off', 'on', and 'force', where

  off -- disable ACPI if default was on
  on -- enable ACPI but allow fallback to DT
  force -- enable ACPI if default was off

So, if the default of the isa fallback command line option will depend on
Kconfig, then we may also want a 'force'.

Thanks,
drew
