Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD0763B964
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 06:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbiK2FTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 00:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiK2FTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 00:19:16 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673054FFA4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:19:15 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id h131-20020a1c2189000000b003d02dd48c45so7571992wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FpUmcQBjCTcWeBttLoCWVwQC7ryZAPTXKUDNedSR73o=;
        b=TU1BE4d+8d8hQDYIKSlLlx7RUly2TYm2sJ028YYnkb6ZIcTOB59CIttBGoWjSoTt06
         Fs1Ek4mCnldzkYyQZtqehRmAvCdpxZ47O8a/Wt+dXP4BgrBDP+uE4OIJMF1+2FfCIkYf
         2cX1Q49OZBk2H1+jD8M+dbyodSaezg0/RjedMXGV7EY3c57wDJHoFvq4YW/qJhkB5B7z
         xyZNECEsQruSVhhr+Agn6SMNaf+l2bSZcJDTDteEC296ctOyJYFqNk8Zv9SY/hDRqJCT
         NiZ4xFyzX4mQeqsZjmhipSDiurRx1p9XHM/4VVzuss1X1lcFgnh4XPmLhstNg+txakQk
         yzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpUmcQBjCTcWeBttLoCWVwQC7ryZAPTXKUDNedSR73o=;
        b=l3qUiPN+aR94/ov7i8ctaK6g0E0x25eeQK6wIgBldAgSAn0pmlglnAyArt70KSmAFh
         zpiITNsM397BJuqUONVGkY8/+UMbEfeFP/CZticz+S9IHA5KXxDeiqCV84IABknFaTNY
         47XPXQVcmhLZAWlpfGtJo1Pswbh9jpuEk8yRX0R2eScugUihBAIo2/Mh8ObyQBqvS6IO
         nGn7ban47+6FCOC7/CCz3p2YSZWr7czUHC7J2Slo7rDne/9EqaIC6ZHtgqBykZPbddg6
         kEa9o3YLwwti3KAuRH+EWjqUsJ+skOFh1Wz96yhpyj0fvKUfeZI3GOScuh6vZJZU0l97
         Rhhw==
X-Gm-Message-State: ANoB5pkcQuwXUOOvmQgWJ/mpJ3wCm9TmYj9jH8GY67rjmedui3rEh+B2
        5/6m/iz6x3fEL+rw7YlKuqRGrA==
X-Google-Smtp-Source: AA0mqf4Ty4v0djT/usoo7920TxGtt5C2ytOH086uEUEAyBmdTpf/mnfQxF8Pe63RRJSSjspBPpcgcA==
X-Received: by 2002:a05:600c:4f90:b0:3c1:aeb9:29b6 with SMTP id n16-20020a05600c4f9000b003c1aeb929b6mr26171384wmq.97.1669699153764;
        Mon, 28 Nov 2022 21:19:13 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003b4ff30e566sm967816wms.3.2022.11.28.21.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 21:19:13 -0800 (PST)
Date:   Tue, 29 Nov 2022 06:19:11 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor Dooley <conor@kernel.org>, heiko@sntech.de,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, guoren@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: Re: [PATCH 2/2] dt-bindings: riscv: fix single letter canonical order
Message-ID: <20221129051911.5xetsgfukxiljuhf@kamzik>
References: <Y4UJQYgCpnZJji9o@spud>
 <mhng-8141aa74-17c6-4692-a658-b5e4faad0c14@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-8141aa74-17c6-4692-a658-b5e4faad0c14@palmer-ri-x1c9a>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 03:41:19PM -0800, Palmer Dabbelt wrote:
> On Mon, 28 Nov 2022 11:17:21 PST (-0800), Conor Dooley wrote:
> > On Mon, Nov 28, 2022 at 10:12:17AM -0800, Palmer Dabbelt wrote:
> > > On Mon, 28 Nov 2022 10:08:05 PST (-0800), Conor Dooley wrote:
> > > > On Mon, Nov 28, 2022 at 09:41:03AM -0800, Palmer Dabbelt wrote:
> > > > > On Thu, 24 Nov 2022 05:42:20 PST (-0800), heiko@sntech.de wrote:
> > > > > > Am Donnerstag, 24. November 2022, 14:04:41 CET schrieb Conor Dooley:
> > > > > > > I used the wikipedia table for ordering extensions when updating the
> > > > > > > pattern here in foo.
> > > > > >
> > > > > > 	    ^ foo? :-)
> > > > > >
> > > > > > > Unfortunately that table did not match canonical order, as defined by
> > > > > > > the RISC-V ISA Manual, which defines extension ordering in (what is
> > > > > > > currently) Table 41, "Standard ISA extension names". Fix things up by
> > > > > > > re-sorting v (vector) and adding p (packed-simd) & j (dynamic
> > > > > > > languages). The e (reduced integer) and g (general) extensions are still
> > > > > > > intentionally left out.
> > > > > > >
> > > > > > > Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-unpriv-pdf-from-asciidoc-15112022 # Chapter 29.5
> > > > > > > Fixes: 299824e68bd0 ("dt-bindings: riscv: add new riscv,isa strings for emulators")
> > > > > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > >
> > > > > > So I have compared the new pattern to the isa manual,
> > > > > > and it looks like the order checks out, so
> > > > >
> > > > > Which ISA manual?
> > > >
> > > > For me, isa manual is the above github repo.
> > > 
> > > Which commit, though?
> > 
> > mutt won't let me paste a clown face emoticon.
> > 
> > > > > There have been many mutually incompatible ISA string
> > > > > encoding rules, at least one of them was a change to the extension ordering.
> > > > > It's not entirely clear what the right answer is here, as we can't really
> > > > > parse ISA strings without also knowing the version of the ISA manual we're
> > > > > meant to parse them against.  Maybe we just accept everything?
> > > >
> > > > I don't think accepting everything is the right thing to do. A minimal
> > > > amount of validation is still needed here, but I think we can deprecate
> > > > the DT property entirely & make it optional if a new-and-improved way of
> > > > encoding the in DT is used.
> > > 
> > > Sorry, by "everything" I meant "everything that's even been allowed by the
> > > ISA manual".  Just accetping anything would be bad ;)
> > > 
> > > > > IMO it's time to just stop using the ISA string.  It's not a stable
> > > > > interface, trying to treat it as such just leads to headaches.  We should
> > > > > just come up with some DT-specific way of encoding whatever HW features are
> > > > > in question.  Sure it'll be a bit of work to write that all down in the DT
> > > > > bindings, but it's going to be way less work than trying to keep around all
> > > > > this ISA string parsing code.
> > > >
> > > > I'm a glutton for punishment, I'll try and come up with some sort of
> > > > other way to encode this information in DT that requires less parsing
> > > > and validation. As I said on IRC, something that more resembles:
> > > > if (of_property_wahtever("riscv,isa-foo")) { do_enable_foo() }
> > > 
> > > That seems way simpler to me, thanks!  We'll still need to support whatever
> > > was here as a legacy format, but at least we won't need to add a bunch of
> > > new stuff to it -- that's where the parsing starts to get really
> > > complicated.

While it's easy for Linux to add new DT nodes when new extension support is
added, it's not so easy to add new ACPI objects. The current plan for ACPI
is to use the ISA string[1]. With that in mind, I think Linux should
continue to parse the string for DT as well.

[1] https://docs.google.com/document/d/1LlCefO_0GQ_7Tf3lzfMPETEfMlGo2FfLRJ09IMqJKEk/edit

> > 
> > Yah, and "deprecated" in dt-schema doesn't actually do anything at the
> > moment other than let humans know not to use something. Just gonna have
> > to do some sort of "feature-wise AND" between the existing things we
> > parse from the isa string & whatever riscv,isa-foo stuff later on.
> 
> I suppose this is more of a Rob question, but could we just make the DT
> bindings match the current ISA manual's rules and then have the kernel's
> "riscv,isa" string parser accept more orderings to remain compatible?
> 
> Sort of a API vs ABI stability question, but for DTB and bindngs.
> 
> > > FWIW, there's a similar dicussion going on in GCC land right now.
> > > 
> > > > > I know I've said the opposite before, but there's just been way too many
> > > > > breakages here to assume they're going to stop.
> > > >
> > > > :upside_down_face:
> > > >
> > > > Either way, I think these two patches are worth taking in the mean time.
> > > 
> > > Yep, just as long as it doesn't break any of the strings that were valid
> > > according to previous versions of the ISA manual I'm fine with it.
> > 
> > I don't think so. I had been looking around for a supposed order for
> > where to actually put H, which had been dropped - and the only place I
> > recall seeing that was Wikipedia - which now seems like an awful
> > decision since the order there looks kinda off anything I see in dozen
> > or so spec PDFs I have downloaded. But that's where I got the K & V
> > ordering from that I now think is wrong (and doesn't match any PDF I
> > have). The other changes relax rules and add letters so they should be
> > okay too.
> 
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> as it sounds like there aren't even any fixed rules, so I guess none of this
> even matters?

IMHO, we should try to get the spec changed to say that the only order
which matters is that single letter extensions come first (in any order)
and then multi-letter extensions come after (in any order). Parsing
becomes simple and we can publish the string in proc in any order too,
maybe preferring alphabetical order for neatness.

Thanks,
drew

> 
> > 
> > > > > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > > > > >
> > > > > > > ---
> > > > > > >  Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > > > > index e80c967a4fa4..b7462ea2dbe4 100644
> > > > > > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > > > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > > > > > @@ -80,7 +80,7 @@ properties:
> > > > > > >        insensitive, letters in the riscv,isa string must be all
> > > > > > >        lowercase to simplify parsing.
> > > > > > >      $ref: "/schemas/types.yaml#/definitions/string"
> > > > > > > -    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:z(?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
> > > > > > > +    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:z(?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
> > > > > > >
> > > > > > >    # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
> > > > > > >    timebase-frequency: false
> > > > > > >
