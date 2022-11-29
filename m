Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B402663C6BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbiK2RtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiK2RtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:49:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3424269AAC;
        Tue, 29 Nov 2022 09:48:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF64561866;
        Tue, 29 Nov 2022 17:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA94FC433D6;
        Tue, 29 Nov 2022 17:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669744136;
        bh=yrbXN5X5h7Pny/XhUR9FOsWs1xs8Rvdy9a2TeeCgzxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KyUCIBxFxCUw+Ri9kQ0SuNXRTPyfbjq4JJVPm1zYOgcoUkAHwmionlVrQviYJO34n
         hKPbXp84YX4u9hORCegfJ6WNCY98+BGzirQSB60xtxEDESASs8PIRZjSTZeskHx1+p
         TYk7RNlWS/HVqvQJm7Ll8K6Scy+qlk0O0Pc+pGAQ6DxQnS8RYHjjqpQuHSehfSGcp6
         wVi7Q0HkSJyFDI6HRZNVkJ0OBHWXj28Lv2jpX1UmNVYLreK4+Rsh0xKEPqCtD2UsB1
         DmNtdYvr09dbAp8CmTcv9roQ6lvl/Hpo7XCsAIGUDJssOKftdNi35t/z2NpKt7vRNe
         GLaQVJzV8Qriw==
Date:   Tue, 29 Nov 2022 17:48:51 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        devicetree@vger.kernel.org, guoren@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Subject: Re: [RFC 1/2] RISC-V: clarify ISA string ordering rules in cpu.c
Message-ID: <Y4ZGA0KyiN+11vjX@spud>
References: <Y4XvnHIPw8ZuBZEk@wendy>
 <20221129144742.2935581-2-conor.dooley@microchip.com>
 <20221129161223.gelsvctfnqg7pdwb@kamzik>
 <Y4Y5O83NCNr1TOAy@spud>
 <20221129171951.6kvvleeny5e2x2nk@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129171951.6kvvleeny5e2x2nk@kamzik>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 06:19:51PM +0100, Andrew Jones wrote:
> On Tue, Nov 29, 2022 at 04:54:19PM +0000, Conor Dooley wrote:
> > On Tue, Nov 29, 2022 at 05:12:23PM +0100, Andrew Jones wrote:
> > > On Tue, Nov 29, 2022 at 02:47:42PM +0000, Conor Dooley wrote:
> > > > While the list of rules may have been accurate when created, it now
> > > > lacks some clarity in the face of isa-manual updates. Specifically:
> > > > 
> > > > - there is no mention here of a distinction between regular 'Z'
> > > >   extensions which are "Additional Standard Extensions" and "Zxm"
> > > >   extensions which are "Standard Machine-Level Extensions"
> > > > 
> > > > - there is also no explicit mention of where either should be sorted in
> > > >   the list
> > > > 
> > > > - underscores are only required between two *multi-letter* extensions but
> > > >   the list of rules implies that this is required between a multi-letter
> > > >   extension and any other extension. IOW "rv64imafdzicsr_zifencei" is a
> > > >   valid string
> > > > 
> > > > Attempt to clean up the list of rules, by adding information on the
> > > > above & sprinkling in some white space for readability.
> > > > 
> > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > >  arch/riscv/kernel/cpu.c | 22 +++++++++++++++++-----
> > > >  1 file changed, 17 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > > > index 852ecccd8920..5e42c92a8456 100644
> > > > --- a/arch/riscv/kernel/cpu.c
> > > > +++ b/arch/riscv/kernel/cpu.c
> > > > @@ -120,20 +120,32 @@ device_initcall(riscv_cpuinfo_init);
> > > >  		.uprop = #UPROP,				\
> > > >  		.isa_ext_id = EXTID,				\
> > > >  	}
> > > > +
> > > >  /*
> > > >   * Here are the ordering rules of extension naming defined by RISC-V
> > > >   * specification :
> > > > - * 1. All extensions should be separated from other multi-letter extensions
> > > > - *    by an underscore.
> > > > + *
> > > > + * 1. All multi-letter extensions should be separated from other multi-letter
> > > > + *    extensions by an underscore.
> > > > + *
> > > >   * 2. The first letter following the 'Z' conventionally indicates the most
> > > >   *    closely related alphabetical extension category, IMAFDQLCBKJTPVH.
> > > > - *    If multiple 'Z' extensions are named, they should be ordered first
> > > > - *    by category, then alphabetically within a category.
> > > > + *    'Z' extensions should be sorted after single-letter extensions and before
> > > > + *    any higher-privileged extensions.
> > > > + *    If multiple 'Z' extensions are named, they should be ordered first by
> > > > + *    category, then alphabetically within a category.
> > > > + *
> > > >   * 3. Standard supervisor-level extensions (starts with 'S') should be
> > > >   *    listed after standard unprivileged extensions.  If multiple
> > > >   *    supervisor-level extensions are listed, they should be ordered
> > > >   *    alphabetically.
> > > > - * 4. Non-standard extensions (starts with 'X') must be listed after all
> > > > + *
> > > > + * 4  Standard machine-level extensions (starts with 'Zxm') should be
> > > > + *    listed after any lower-privileged, standard extensions.  If multiple
> > > > + *    machine-level extensions are listed, they should be ordered
> > > > + *    alphabetically.
> > > > + *
> > > > + * 5. Non-standard extensions (starts with 'X') must be listed after all
> > > >   *    standard extensions. They must be separated from other multi-letter
> > > >   *    extensions by an underscore.
> > > >   */
> > > > -- 
> > > > 2.38.1
> > > >
> > > 
> > > Alternatively, we could change the comment to just point out the spec
> > > chapter and provide an example, e.g.
> > 
> > IDK, maybe add the reference & the example but keep the summary?
> 
> It risks needing to synchronize the comment with the spec.

Heh, see I almost see this as an *advantage* of this approach!

> Also, the
> comment doesn't need to reproduce the flexible specifications, since
> Linux has a single implementation (it always puts an underscore between
> single-letter extensions and the first multi-letter extension, for
> example). So, rather than paraphrase too much of the spec, we could just
> point out Linux's specific implementation (with the help of an example).

You're right here though. I've had my head stuck in the incoming-string
side of things rather than outgoing. I'll wait for the all clear from
Above, but ideally I'll reword this explaining where this info shows up
(and therefore why it needs to be ordered), what elements of the rules
matter here (entirely ordering) and then include your bits from below?

> I don't feel that strongly about it though, so we can keep the text
> the spec paraphrasing too.

> > > /*
> > >  * The canonical order of ISA extension names in the ISA string is defined in
> > >  * chapter 27 of the unprivileged spec. An example string following the
> > >  * order is
> > >  *
> > >  *   rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
> > >  *
> > >  * Notice how Z-extensions are first sorted by category using the canonical
> > >  * order of the first letter following the Z. Extension groups are in the
> > >  * order specified in chapter 27. Extensions within each group are sorted
> > >  * alphabetically.
> > >  */

