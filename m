Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB4269F4FD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjBVM6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjBVM6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:58:46 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43573B3C8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:58:39 -0800 (PST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EC0B43F20F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677070713;
        bh=iMk87gysA4eaHAIflp61kjRjI9XPCsP7SLQze3YejXk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=biexyhqzstWEh9dvaTaUVZ5xAMyScoWx1huTqiytRRgpvvIyjahosH+u0rQY+nJ5j
         hBJh+KHLTkIWY1Da89ZfnLtNYRs75oKMHAvQN10YJZJFS7r7SXKQ2wgrY3w3oEH9+4
         ni46+RnOdIdiebwO3A8OL1eEG5FI6CkJdJhzLZ8xQxsD0tq02HkbYrXl1h3PlLOxDg
         9b8JxEGzjUUqZXJhHyWC2eghRAIfwSIrzWUjXzXNysfnz/Gfxj6WuEltAxEwOJ0KS5
         cCCAFImIoWUU4/sXghgET9RUMGgIVB1ov5vKXYY8DwfB2ed2dkd0FJuiwSqTQmlRKu
         63TrnaYGxORyw==
Received: by mail-pj1-f69.google.com with SMTP id cl18-20020a17090af69200b0023470d96ae6so791303pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:58:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMk87gysA4eaHAIflp61kjRjI9XPCsP7SLQze3YejXk=;
        b=WcgPQ2P29PG/H6aL0ag2A2zY/c1GYQ327hMLVjpgakFpG3O/dF//Umzz+3Tmug/GW1
         rrDUn9pYQEpRj++kEmH+4VtcvRgO91ZsCW3Z2jddsE6qlBRWRQu/rOBHxCfPh6Dh4aqe
         yJ5rZ79LC4JWtlJ7UWc/m8Qv7aY61OMCd6ELZsy9TsdboL4h1ZraiYA8aRkcynNuXuFM
         w9KqXWAQaWCWbMzOyPUfkltPrwGEPsD9bKTKWWyXjp++xR5uWrJ+2Rmxa/Y7TByFOjv/
         Aq/xi0ZBT0QjCCtk0s5etTjUwSnY64AL8ejN8I+4VWndtGtmGgxgWEuan/ZC1D4+MScO
         kPRQ==
X-Gm-Message-State: AO0yUKXk4l4KR1KTCeUR6XPWyMD5k0nZGOAlR0ArOL5aSNPUK7cnG3Ob
        kppN9ifDmdcabjw6U7NeSme03ArzXM7OyatevF6o2vBbovvXff/FqQFeOJhl+wFjpsPnMG9sAdU
        05M5zOQuslzdKBb/7JuySf4qEbMYCr7hfB9+wvkHKta45DN9N6vdvpkZ5PQ==
X-Received: by 2002:a17:90b:1f87:b0:237:1892:2548 with SMTP id so7-20020a17090b1f8700b0023718922548mr1308269pjb.44.1677070712475;
        Wed, 22 Feb 2023 04:58:32 -0800 (PST)
X-Google-Smtp-Source: AK7set8t7GH+/5kt3d+6jt2bifRD+Qrs2oMsHfDIkP9dJPLZIOBlT5vzRFzw/4YigtGXfjFuxQ9kqWRbXfqAHuTtwBU=
X-Received: by 2002:a17:90b:1f87:b0:237:1892:2548 with SMTP id
 so7-20020a17090b1f8700b0023718922548mr1308255pjb.44.1677070712173; Wed, 22
 Feb 2023 04:58:32 -0800 (PST)
MIME-Version: 1.0
References: <20230221023849.1906728-1-kai.heng.feng@canonical.com> <c21a3f74-871c-8726-f078-b4c2c3414ebd@gmail.com>
In-Reply-To: <c21a3f74-871c-8726-f078-b4c2c3414ebd@gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 22 Feb 2023 20:58:20 +0800
Message-ID: <CAAd53p5k5BrdHz6oAuviymdYNRJ_NGxDs_TAe2M=0W6xj2o5KA@mail.gmail.com>
Subject: Re: [PATCH v8 RESEND 0/6] r8169: Enable ASPM for recent 1.0/2.5Gbps
 Realtek NICs
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     nic_swsd@realtek.com, bhelgaas@google.com, koba.ko@canonical.com,
        acelan.kao@canonical.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, vidyas@nvidia.com,
        rafael.j.wysocki@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 7:09 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 21.02.2023 03:38, Kai-Heng Feng wrote:
> > The series is to enable ASPM on more r8169 supported devices, if
> > available.
> >
> > The latest Realtek vendor driver and its Windows driver implements a
> > feature called "dynamic ASPM" which can improve performance on it's
> > ethernet NICs.
> >
> > We have "dynamic ASPM" mechanism in Ubuntu 22.04 LTS kernel for quite a
> > while, and AFAIK it hasn't introduced any regression so far.
> >
> > A very similar issue was observed on Realtek wireless NIC, and it was
> > resolved by disabling ASPM during NAPI poll. So in v8, we use the same
> > approach, which is more straightforward, instead of toggling ASPM based
> > on packet count.
> >
> > v7:
> > https://lore.kernel.org/netdev/20211016075442.650311-1-kai.heng.feng@canonical.com/
> >
> > v6:
> > https://lore.kernel.org/netdev/20211007161552.272771-1-kai.heng.feng@canonical.com/
> >
> > v5:
> > https://lore.kernel.org/netdev/20210916154417.664323-1-kai.heng.feng@canonical.com/
> >
> > v4:
> > https://lore.kernel.org/netdev/20210827171452.217123-1-kai.heng.feng@canonical.com/
> >
> > v3:
> > https://lore.kernel.org/netdev/20210819054542.608745-1-kai.heng.feng@canonical.com/
> >
> > v2:
> > https://lore.kernel.org/netdev/20210812155341.817031-1-kai.heng.feng@canonical.com/
> >
> > v1:
> > https://lore.kernel.org/netdev/20210803152823.515849-1-kai.heng.feng@canonical.com/
> >
> > Kai-Heng Feng (6):
> >   r8169: Disable ASPM L1.1 on 8168h
> >   Revert "PCI/ASPM: Unexport pcie_aspm_support_enabled()"
> >   PCI/ASPM: Add pcie_aspm_capable() helper
> >   r8169: Consider chip-specific ASPM can be enabled on more cases
> >   r8169: Use mutex to guard config register locking
> >   r8169: Disable ASPM while doing NAPI poll
> >
> >  drivers/net/ethernet/realtek/r8169_main.c | 48 ++++++++++++++++++-----
> >  drivers/pci/pcie/aspm.c                   | 12 ++++++
> >  include/linux/pci.h                       |  2 +
> >  3 files changed, 53 insertions(+), 9 deletions(-)
> >
>
> Note that net-next is closed during merge window.
> Formal aspect: Your patches miss the net/net-next annotation.

Will do in next revision.

> The title of the series may be an old one. Actually most ASPM
> states are enabled, you add to disable ASPM temporarily.

Right.
Most hardwares I have access to don't grant OS ASPM control, so
tp->aspm_manageable is not enabled.
Will make it more clearer.

Kai-Heng
