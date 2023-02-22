Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E1B69F50F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjBVNDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjBVNDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:03:20 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2326D367CE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:03:18 -0800 (PST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8D81F3F57F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677070996;
        bh=vDl8+hjfMfY7KUo2hxAOUC4kT84OFjznnoyN+yHSR7c=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=EMlsesxQc8Kw3BGiVwKwGamGXmPvP9sBuyk+5MXKC4k9j1Kqmxr6ZEr828nqKf8E9
         naR8UQlSw3rxzPwbul1lJThDTAxwtfy+prFNBj8yFlp/BhlDP/99AQKBhogHJL1nC6
         grGTVRjc35PW2HK/pt3hfpi32eHU4TmMRkQefEMkux+C113H/vOZtSr/V53pcuf8XP
         gAyyOtzASVn7e1Dr2YieCtU5/VdPfg0uLG284PgsGQTAj1u9kfLEvuREwMBEjB9qBW
         KJ/pIlqtCdWQR1e3HYpmySjH80Wp+M7xDWC9GSI+oA6smoSd0sWeofT16wsl6gKQKA
         699R8+tx1ju+w==
Received: by mail-pl1-f200.google.com with SMTP id e4-20020a170902cf4400b00199148d00f2so3755864plg.17
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:03:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDl8+hjfMfY7KUo2hxAOUC4kT84OFjznnoyN+yHSR7c=;
        b=iDnbL2cZ3j5+pLK1ssvcQ2Vo1JNsfPDY0y17XFxe03PjBXjxcA9Os1+iV/LTvCJZKK
         mqZvjq/sqQC/ZzQwPkDDAtWNlneaYusonebrGSIpP7GfxwJA7V5qlnzGO+UfSvhRYObH
         KTo472Rbgzto80JfQva3VGl1zQJEVR7mgO1m93TqdmQ50mwRjRPEs3reupdmSsl3dyRu
         LigCDbMgKv4Cr8pReS7YHhLmWx697vpWPAK73ssRrAQCoCDQk8MfByvh45oTO/vPn0tQ
         O0v62wEXJzX4gdWNezUBQwH7vQutKxbi1lgomCS1/MB4gv9qFsOvHZcioHsigMju/2hu
         tblQ==
X-Gm-Message-State: AO0yUKVrHc03bJe5i9BGHGVEMB1ScZVfGq9vYmJfy0w6KdeR93bJaXZz
        1/FNe8/I1vrXPfOmFq/nEFECr/xE3SeNKZJ8raVvrX6n1aewT4bhroFc6xSFXcKuHqyUsNZzR6j
        cjolQhLFgins0aCNoaFnYmiOUYYdeVNslCEki+6d2JbJaizCy1ZvGIi4jyQ==
X-Received: by 2002:a17:90b:1f87:b0:237:1892:2548 with SMTP id so7-20020a17090b1f8700b0023718922548mr1311105pjb.44.1677070993466;
        Wed, 22 Feb 2023 05:03:13 -0800 (PST)
X-Google-Smtp-Source: AK7set8YbQqmzpzq5/1//FaF6k+HETVuHWe7YKJkndlhhZiyXSUpczFRV7U8PwaK551Xg7ch6DjXBMeH4OCU3YJo3B8=
X-Received: by 2002:a17:90b:1f87:b0:237:1892:2548 with SMTP id
 so7-20020a17090b1f8700b0023718922548mr1311091pjb.44.1677070993144; Wed, 22
 Feb 2023 05:03:13 -0800 (PST)
MIME-Version: 1.0
References: <20230221023849.1906728-1-kai.heng.feng@canonical.com>
 <20230221023849.1906728-7-kai.heng.feng@canonical.com> <b2bae4bb-0dbe-be80-3849-f46395c05cd2@gmail.com>
In-Reply-To: <b2bae4bb-0dbe-be80-3849-f46395c05cd2@gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 22 Feb 2023 21:03:01 +0800
Message-ID: <CAAd53p79Of-ZPBFGtBZCSnST+oTT5AwGkRo_Z57Gm9XDOBmi_A@mail.gmail.com>
Subject: Re: [PATCH v8 RESEND 6/6] r8169: Disable ASPM while doing NAPI poll
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 7:09 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 21.02.2023 03:38, Kai-Heng Feng wrote:
> > NAPI poll of Realtek NICs don't seem to perform well ASPM is enabled.
> > The vendor driver uses a mechanism called "dynamic ASPM" to toggle ASPM
> > based on the packet number in given time period.
> >
> > Instead of implementing "dynamic ASPM", use a more straightforward way
> > by disabling ASPM during NAPI poll, as a similar approach was
> > implemented to solve slow performance on Realtek wireless NIC, see
> > commit 24f5e38a13b5 ("rtw88: Disable PCIe ASPM while doing NAPI poll on
> > 8821CE").
> >
> > Since NAPI poll should be handled as fast as possible, also remove the
> > delay in rtl_hw_aspm_clkreq_enable() which was added by commit
> > 94235460f9ea ("r8169: Align ASPM/CLKREQ setting function with vendor
> > driver").
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v8:
> >  - New patch.
> >
> >  drivers/net/ethernet/realtek/r8169_main.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> > index 897f90b48bba6..4d4a802346ae3 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -2711,8 +2711,6 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
> >               RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~ClkReqEn);
> >               RTL_W8(tp, Config5, RTL_R8(tp, Config5) & ~ASPM_en);
> >       }
> > -
> > -     udelay(10);
> >  }
> >
> >  static void rtl_set_fifo_size(struct rtl8169_private *tp, u16 rx_stat,
> > @@ -4577,6 +4575,12 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
> >       struct net_device *dev = tp->dev;
> >       int work_done;
> >
> > +     if (tp->aspm_manageable) {
> > +             rtl_unlock_config_regs(tp);
>
> NAPI poll runs in softirq context (except for threaded NAPI).
> Therefore you should use a spinlock instead of a mutex.

You are right. Will change it in next revision.

>
> > +             rtl_hw_aspm_clkreq_enable(tp, false);
> > +             rtl_lock_config_regs(tp);
> > +     }
> > +
> >       rtl_tx(dev, tp, budget);
> >
> >       work_done = rtl_rx(dev, tp, budget);
> > @@ -4584,6 +4588,12 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
> >       if (work_done < budget && napi_complete_done(napi, work_done))
> >               rtl_irq_enable(tp);
> >
> > +     if (tp->aspm_manageable) {
> > +             rtl_unlock_config_regs(tp);
> > +             rtl_hw_aspm_clkreq_enable(tp, true);
> > +             rtl_lock_config_regs(tp);
>
> Why not moving lock/unlock into rtl_hw_aspm_clkreq_enable()?

Because where it gets called at other places don't need the lock.
But yes this will make it easier to read, will do in next revision.

Kai-Heng

>
> > +     }
> > +
> >       return work_done;
> >  }
> >
>
