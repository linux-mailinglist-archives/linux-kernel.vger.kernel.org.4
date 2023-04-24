Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E8D6E443E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjDQJqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjDQJqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:46:07 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6D25587
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 02:45:24 -0700 (PDT)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 84A253F233
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681724285;
        bh=VD8+uXNUhbdgH2Qo+D1vtL7yokGwsrp5wVF5XeioMkI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=l36aIpIZUTPT+6KoIKvDfhv0Bz62QVttjFBusgtE6ht9AP8YrYMA8qBOIZ7tMYS86
         YKQGnOT0VVRR5y9UdsMLNIP/DiCP5/6Wp6dU5+XHPj+scrazgjbqsB8ioJ8UyXmRUX
         B+fos48DwudPUfzSNO56va9JcakZxbndYZWnl+ahXMJXoFPUQqEgrGGCDiuwY0bJX4
         TsZdpVhnGuuNqlSMDoxb84SnOC3jqWEDSVnwH+lYpI/WiZ7/YEAJKwVs1abhseQ2Gw
         ulG5k+zi9yaHsa3fp8dk9z8a4GL4LOnE+GLfWOen5MVm1Na7+dzRZ7uGnHB4g0ShAC
         T31gKBZU8xJWg==
Received: by mail-pl1-f198.google.com with SMTP id kc13-20020a17090333cd00b001a6751016d4so6712258plb.23
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 02:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681724284; x=1684316284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VD8+uXNUhbdgH2Qo+D1vtL7yokGwsrp5wVF5XeioMkI=;
        b=JzIWLCyzmqtvagAMDrCHS3DTWuTpMFTE6L2OjP9RZB+fOAwucy37K2TY7VI5eZ/k/X
         7XXCfUB0Rung1EBlq5SatBND6vVUqORkTtABJyNYDYUF1kHnCM4uWWjwRAPRPD3GzyuT
         Nt0ZqbfzAqJqgh6w+Wk+FJN+0jRM7jxdsWrHWRF0dOYXHl0IIszTPx6/QWAwUcNxuiQb
         vY6wmtSj5HfsC3dBCDD/KlvwpXU5AOo8EaSZEF+EaTeuTX9MNILLNMonPkjf9VNrtQ6X
         2NIWeCb06JXou2mppXjNNDrYxPpwkf+pvJ7K+U5XjgTXV0+G59KQ6XwX3gWSDkxe9lAl
         BwNA==
X-Gm-Message-State: AAQBX9dg/Pyl4BjEpSjuKKU560sFinkxDxq8a8l3C5wJLHOSUm6mTgdt
        7iRFnNSgHAt//P4Jpq2ooRibqHgNbqqv8Gg1dPi5q65CaW30MLQCZj4hg/PxqWs/LFrOTmh5LXq
        xJvMj4tfGeboJvW/YdJtEtU6QbgSXS37oiz1bND3HiXEIR15i/vlPB3PUbw==
X-Received: by 2002:a17:90a:bf0d:b0:247:a22d:2a41 with SMTP id c13-20020a17090abf0d00b00247a22d2a41mr1529116pjs.13.1681724283984;
        Mon, 17 Apr 2023 02:38:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350YGMLu1dBlve2tadaE8Y0Mizyq9mkFQCjO6kFnWrQzYxrysiyBGGvNDoKPtNGjcY6rgTi1V7lgsW6qVoyK8p3E=
X-Received: by 2002:a17:90a:bf0d:b0:247:a22d:2a41 with SMTP id
 c13-20020a17090abf0d00b00247a22d2a41mr1529104pjs.13.1681724283623; Mon, 17
 Apr 2023 02:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220727013255.269815-1-kai.heng.feng@canonical.com> <20220928213209.GA1839792@bhelgaas>
In-Reply-To: <20220928213209.GA1839792@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 17 Apr 2023 17:37:52 +0800
Message-ID: <CAAd53p7qTEmPQSn=njkA5G5j-6sg1Tkt91rSn5fTkRUWfsjzQQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI/portdrv: Flag services when IRQ is shared with PME
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Lukas Wunner <lukas@wunner.de>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 5:32=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Wed, Jul 27, 2022 at 09:32:50AM +0800, Kai-Heng Feng wrote:
> > After commit cb1f65c1e142 ("PM: s2idle: ACPI: Fix wakeup interrupts
> > handling"), there's a system that always gets woken up by spurious PME
> > event when one of the root port is put to D3cold.
> >
> > '/sys/power/pm_wakeup_irq' shows 122, which is an IRQ shared between
> > PME, AER and DPC:
> > pcieport 0000:00:01.0: PME: Signaling with IRQ 122
> > pcieport 0000:00:01.0: AER: enabled with IRQ 122
> > pcieport 0000:00:01.0: DPC: enabled with IRQ 122
> >
> > Disabling services one by one and the issue goes away when
> > PCIE_PORT_SERVICE_AER is not enabled. Following the lead, more info can
> > be found on resume when pci_aer_clear_status() is removed from
> > pci_restore_state() to print out what happened:
> > pcieport 0000:00:01.0: AER: Corrected error received: 0000:00:01.0
> > pcieport 0000:00:01.0: PCIe Bus Error: severity=3DCorrected, type=3DPhy=
sical Layer, (Receiver ID)
> > pcieport 0000:00:01.0:   device [8086:4c01] error status/mask=3D0000000=
1/00002000
> > pcieport 0000:00:01.0:    [ 0] RxErr
> >
> > Since the corrected AER error happens at physical layer when the root
> > port is transitioning to D3cold, making system be able to suspend is
> > more important than reporting issues like this.
> >
> > So introduce a new flag to indicate when IRQ is shared with PME,
> > therefore AER and DPC can be suspended to prevent any spurious wakeup.
> > HP already has its own suspend routine so it doesn't need to use this
> > flag.
>
> I think it probably does make sense to disable AER and DPC interrupts
> during suspend.  I'm not sure it makes sense to do that conditionally
> based on whether the interrupt is shared.  I think I'd rather disable
> them always, whether the interrupt is shared or not, because then we
> would do the same thing on all machines.  What do you think?

Sorry for the belated response.

I think that sounds reasonable.
I'll send a new version that unconditionally disable AER and DPC IRQ on sus=
pend.

Kai-Heng

>
> Bjorn
