Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AED716995
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjE3Qc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjE3QcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50E119B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685464262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOIVzrI3vKBP/A6R0sJIuBO8sqm5648YHnsZrR5hri0=;
        b=HhirIuKDXFnHxelk6asrHF21SZO9HAvz6shGYkbKSqTOt4eFbB3sLRomIPTYkhbIfevuHb
        hnYp+YbsKqG/qDtdHSEUOEZuuK0efnha4ZGvlz4kH8JBknCITSpp++c8tdAkGoxt5QOlRx
        osvaoOD6CLz7VDOgcE5odRyAkfixmqM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321--lubBf-DOFSbbkPSEco7Yw-1; Tue, 30 May 2023 12:27:17 -0400
X-MC-Unique: -lubBf-DOFSbbkPSEco7Yw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75cb96abcb5so289203385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685464036; x=1688056036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOIVzrI3vKBP/A6R0sJIuBO8sqm5648YHnsZrR5hri0=;
        b=E9OkU8fqnq8UNM3gjImxECN8wGnQdpVELlVwtcak6eIeOSOxGCyjaiIFR8DEvdcw1z
         x/w5m4Br9xY8edu9WJnq74LPI+wozDHfKdboG0Xxm1lcbxg9W3dA7l4tqBcWv8q6aP7N
         24SZe8aU1IcjjGlkjcnZLB9jAMUcXmFFSwgU6GCB+ued8qOTk801rHIgULC4GypPdLiB
         j8QjwiNNSjiAVRQ8G+E3H4a6UAOsCyKdcDzeg6jf3xTPyla2K2kcNBitYKT8t9dPiUek
         chrh0I+xEMSOgIpjQ0GvC0Kqr6lKir/6CQXLhpN2XO1JlV171Z2vpj4M2MmaihPdaCG7
         WVJA==
X-Gm-Message-State: AC+VfDzgzCIRc1YceIrpz/KC5qkl+HVUWYRnZZFjkgbuXH+lp5Bb/cmW
        hdgTmSQINSzifOKa0N5PZjujAWffN6xe58S8zWBu5RjaNZH74Kqd7Lzvfc3rq5QDnkASWZQtKP/
        DDYdYUgqPMFjtZtsp9XbQmGCE
X-Received: by 2002:a05:620a:2617:b0:75b:23a0:e7e7 with SMTP id z23-20020a05620a261700b0075b23a0e7e7mr2242378qko.72.1685464036593;
        Tue, 30 May 2023 09:27:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7oC9aEVSBKMtLklQXrBPZMeMm21vFrPEYngDHux4hIbwN0xr0b2MneGdGNx1VH/PM57TmiVg==
X-Received: by 2002:a05:620a:2617:b0:75b:23a0:e7e7 with SMTP id z23-20020a05620a261700b0075b23a0e7e7mr2242356qko.72.1685464036338;
        Tue, 30 May 2023 09:27:16 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id a4-20020a05620a124400b0075b1c6f9628sm4202904qkl.71.2023.05.30.09.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:27:15 -0700 (PDT)
Date:   Tue, 30 May 2023 09:27:14 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Michael =?utf-8?Q?Niew=C3=B6hner?= <linux@mniewoehner.de>
Cc:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jarkko Sakkinen <jarkko@kernel.org>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        peterz@infradead.org
Subject: Re: [linus:master] [tpm, tpm_tis] e644b2f498: RIP:acpi_safe_halt
Message-ID: <kjcmnmspnpzp7j64msdeygfv76fah5whslldczlfzlk57cxp7b@myllnwmy43vo>
References: <202305041325.ae8b0c43-yujie.liu@intel.com>
 <d80b180a569a9f068d3a2614f062cfa3a78af5a6.camel@kernel.org>
 <42ea93a1-3186-b8ff-c317-d51f3e13856e@kunbus.com>
 <20230511141607.GA32208@wunner.de>
 <1a8ecf90-80a4-9aac-95e1-9ce0c4e09ba5@kunbus.com>
 <6nf5n6fdnkhx6taa2mecnsmyw7sdgaz6fbvkqy7jqkyd7jq2u7@ogsi6ije32in>
 <fcdc5a27817b17d91df84bb06ad5d382829d5467.camel@mniewoehner.de>
 <6hbzssr2byskuiznx6vvatcuvjkrbhscvorzm4qcheh3n6n4zj@2nrfawn6rbst>
 <0e837a2e859b4c633b068368f3c28ba30fc1af70.camel@mniewoehner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e837a2e859b4c633b068368f3c28ba30fc1af70.camel@mniewoehner.de>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:40:26PM +0200, Michael Niewöhner wrote:
> On Mon, 2023-05-29 at 13:58 -0700, Jerry Snitselaar wrote:
> > On Mon, May 29, 2023 at 05:07:54PM +0200, Michael Niewöhner wrote:
> > > Hi Jerry,
> > > 
> > > On Thu, 2023-05-11 at 07:59 -0700, Jerry Snitselaar wrote:
> > > > 
> > > > IIRC trying to catch the irq storm didn't work in the L490 case for
> > > > some reason, so we might still need the dmi entry for that one.
> > > > 
> > > > The info that the T490s had a pin wired up wrong came from Lenovo, but
> > > > this one even looks to be a different vendor so I wonder how often
> > > > this happens or if there is something else going on. Is it possible to
> > > > get info about the tpm used in the Inspur system? The datasheet online
> > > > doesn't mention it.
> > > 
> > > Are you sure about T490s? To me the wiring looks right on both s and non-s:
> > > Pin
> > > 18 / PIRQ# goes to PIRQA# of the PCH/SoC.
> > > 
> > > However on L490 Pin 18 / PIRQ# is wired wrongly to SERIRQ, which probably is
> > > the
> > > reason that catching the interrupt storm didn't work: I guess this
> > > completely
> > > messes up LPC communication and causes way more problems. In this case only
> > > a
> > > DMI quirk can help.
> > > 
> > > BR
> > > Michael
> > > 
> > 
> > I'm searching to see if I can find the old bug/email where that info
> > from Lenovo originated.  It could be that the info was wrong, and
> > it was some firmware issue instead. IIRC the the T490s issue could be
> > solved with the code looking for the irq storm, but the L490 needed
> > the dmi check even with the irq storm checking code.
> 
> Tbh I wonder why the T490s suffers from that interrupt storm at all, but that
> might be a FW bug (it's not handling the interrupt). L490 definitely needs that
> DMI check, right.
> 
> > 
> > 
> > I haven't found the info yet, but I did find some other reports from back
> > then.
> > 
> > Spurious irq reported with 5.5.7, so after the irq reverts in v5.5:
> > 
> > tpm_tis IFX0785:00: 2.0 TPM
> > Hardware name: Entroware Proteus/Proteus, BIOS 1.07.07TE0 11/15/2019
> 
> That's actually a Clevo N151CU. According to schematics it's wired correctly to
> PIRQA#, so probably a FW bug as well.
> 
> > 
> > Thinkpad P53
> > tpm_tis STM7308:00: 2.0 TPM
> > Hardware name: LENOVO 20QNCTO1WW/20QNCTO1WW, BIOS N2NET34W (1.19 ) 11/28/2019
> > 
> > 
> > 
> > Reports from before the 5.5 reverts:
> > 
> > tpm_tis MSFT0101:00: 2.0 TPM
> > Hyperbook NH5/Clevo NH55RCQ
> 
> PIRQ# wired to GPP_B0 - needs correct setup in firmware -> probably a firmware
> bug.
> 
> > 
> > tpm_tis IFX0785:00: 2.0 TPM 
> > Clevo N151CU-derived notebook
> 
> Same device as Entroware Proteus.
> 

Hi Michael,

Out of curiousity, where are you grabbing the schematics from?

Regards,
Jerry


> > 
> > 
> > Regards,
> > Jerry
> > 
> > > > 
> > > > Regards,
> > > > Jerry
> > > > 
> > > > > > Thanks,
> > > > > > 
> > > > > > Lukas
> > > > 
> > > 
> > 
> 

