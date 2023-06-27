Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D4373F654
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjF0ICr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjF0ICj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:02:39 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697FD269E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:02:32 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b4f9583404so35723515ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687852952; x=1690444952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwSOaaqXQuvrI4/1ZVdn4pZtlCvLtoOyfkYIM95Gkyg=;
        b=n61emth7MMMXsUyQZTn2mvezxo+aS/47NEiAR+fmv6JvaSIm1xaV9iIiQKlKFMYleg
         BACfQCvCCzvlz8m8pVn1T9s+9Xu52SSldssZvwFIOq+jOtUDEP3qWT8tSCLDsQUZhEJq
         lOBRo5s2ocWihk9SIQqEYtqeoSXTZkC4p7BBaSdojtvy+rnqnmy/ffBo5XhDjzM4RhGx
         pHx/gEbuUEibvf2NfoCq1WL512mVKT1bVCkfIHNIMAFTsTl7XUaBb4ZSP7vWOUcc4r54
         Y6GzvgMPO7rcsYBLdeeKYsui+8erpFQ8Kbx4MiwOvKUKMLBFCQaB9lGyPHSsZZTAejeH
         qYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687852952; x=1690444952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwSOaaqXQuvrI4/1ZVdn4pZtlCvLtoOyfkYIM95Gkyg=;
        b=Y40ji6SREtZLf2i+1shKh2Vjl+pCVDSpRsbgFzqEkc+joI4Biq1XnWTZeylAUNjubd
         XFKtHMF3JTfcbyPD0W21peVtn8Jn9oCvmAXiQYlKWP7mq7i1sztEI48pGbL1LRAOAll0
         /gFJ3eUXPaZa3IIZJZvy+EJC0PzL5Z0NNZp9yP5ARFCDC4BOZ3RwZerRIAHwn6CnatmH
         kn2RsZtNmH4O28GdWGH8FqHnDq2P+AZKFyNe92b7cG0QGiZCFT6tE7cA/lK7qajAQToj
         5ykF74xzDuQW25lKUStu/9ReW8ywwe1q2quIVRjuvly4OEVuEKz5NGux+hmbQVPyk5nm
         ceLA==
X-Gm-Message-State: AC+VfDzVh4/rsy4QgXkm/7VP40PKyrCKf67VTVHpSrWRFwl3+9KQIZtc
        ALWwNJDbkLDzra1RWNFNgMIVSw==
X-Google-Smtp-Source: ACHHUZ6UZNXZmsJzaB9zcJo7pIb8wVgihAnTAOaXihsbTnFUpv6o9tz42ExvLlFerm1GhPq/VvjP2w==
X-Received: by 2002:a17:902:be11:b0:1af:b92d:b5fe with SMTP id r17-20020a170902be1100b001afb92db5femr10036126pls.0.1687852951788;
        Tue, 27 Jun 2023 01:02:31 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.72])
        by smtp.gmail.com with ESMTPSA id y22-20020a1709029b9600b001ac40488620sm5380340plp.92.2023.06.27.01.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:02:31 -0700 (PDT)
Date:   Tue, 27 Jun 2023 13:32:23 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/9] RISC-V: don't parse dt/acpi isa string to get
 rv32/rv64
Message-ID: <ZJqXj7UdegnRP4mI@sunil-laptop>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
 <20230626-silk-colonize-824390303994@wendy>
 <20230626-e3ea7beb39c584bfbf7ee836@orel>
 <20230626-dragonish-romp-9acf4846ae01@spud>
 <20230626-4fb963235f3ab08383a6d9ab@orel>
 <20230626-ragweed-whenever-5b22e180dcd1@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626-ragweed-whenever-5b22e180dcd1@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 05:16:09PM +0100, Conor Dooley wrote:
> On Mon, Jun 26, 2023 at 06:05:40PM +0200, Andrew Jones wrote:
> > On Mon, Jun 26, 2023 at 04:51:29PM +0100, Conor Dooley wrote:
> > > On Mon, Jun 26, 2023 at 05:14:15PM +0200, Andrew Jones wrote:
> > > > On Mon, Jun 26, 2023 at 12:19:39PM +0100, Conor Dooley wrote:
> > > > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > > > > @@ -333,8 +335,6 @@ static int c_show(struct seq_file *m, void *v)
> > > > >  
> > > > >  		of_node_put(node);
> > > > >  	} else {
> > > > > -		if (!acpi_get_riscv_isa(NULL, cpu_id, &isa))
> > > > > -			print_isa(m, isa);
> > > > >  
> > > > 
> > > > Extra blank line here to remove. Actually the whole 'else' can be removed
> > > > because the print_mmu() call can be brought up above the
> > > > 'if (acpi_disabled)'
> > > 
> > > Can it be? I intentionally did not make that change - wasn't sure
> > > whether re-ordering the fields in there was permissible.
> > 
> > I agree we shouldn't change the order, but moving print_mmu() up won't,
> > afaict.
> 
> D'oh, I'm an eejit. Sure, I'll do that for v2. Thanks!
> 
> > > One of the few things I know does parsing of /proc/cpuinfo is:
> > > https://github.com/google/cpu_features/blob/main/src/impl_riscv_linux.c
> > > and that doesn't seem to care about the mmu, but does rely on
> > > vendor/uarch ordering.
> > > 
> > > Makes me wonder, does ACPI break things by leaving out uarch/vendor
> > > fields, if there is something that expects them to exist? We should
> > > not intentionally break stuff in /proc/cpuinfo, but can't say I feel any
> > > sympathy for naively parsing it.
> > 
> > Yes, it would be nice for ACPI to be consistent. I'm not sure what can be
> > done about that.
> 
> Print "unknown", until there's a way of passing the info?
> Speaking of being an eejit, adding new fields to the file would probably
> break some really naive parsers & quite frankly that sort of thing can
> keep the pieces IMO. Ditto if adding more extensions breaks someone that
> expects _zicbom_zicboz that breaks when _zicbop is slid into the middle.

Hi Conor,

Instead of unknown, could you print "risc-v" or "riscv"? There is nothing
equivalent to compatible property in ACPI. Using mvendorid,
marchid and mimpid, people can determine the exact processor
<manufacturer>,<model>.

Thanks!
Sunil

