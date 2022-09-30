Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA06A5F02ED
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 04:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiI3Cpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 22:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiI3Cpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 22:45:38 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2A7E10B7;
        Thu, 29 Sep 2022 19:45:37 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s125so3504378oie.4;
        Thu, 29 Sep 2022 19:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ormkvRBKI2AfF5opKCYXp3Bxv1cAvtNNbHyCcEt9dLg=;
        b=m0SKXBGYpikQoqjj2V1cNuUbXIEAWsR41hrVDjBcCxdieWAlacta57yxeaJfW8tl9r
         j/wZm7GXAH0BRr5p7Yao87XoveOzpwlvnuboHNL2bWy4s4C1jHIdIB5wdHN1J/oiuSbP
         LzhPY4wyjjRVcoQiEO7UYSp99+6szxN7YB2vDMj0D6jjTeQDkSkSladsIooIOOI/3u65
         Z9doxpnNbFH975mVQ/Rvf36jpLuDhlJJfAYCCNKh/BMH96BdAD9Q3yv3LN43Mt/BQ47h
         KaGy5HaKKyP2AteNp4nVg1m/4+YgA6HN+wLf5mv6XX+qmUqUYkVDVB4vnkTAD6SebeDT
         v9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ormkvRBKI2AfF5opKCYXp3Bxv1cAvtNNbHyCcEt9dLg=;
        b=aEsQeschcbxJqoR+ygI5D7UJCrMVF2FVmc2ipa7xiM18cjON+KPuxzCdnB3hRWmij8
         19bOkwU8dWb5j6fCWuFmdraKj1FGrDzTdO22ddC7u1blPYOBMWnEkS1mkom9PoV/pyr3
         aMN1t06FJc7UXl637sFFLPQ2/Ce58tJX8FESJrcKLd/kqLDdMBf0BrHFoxqPftpR2VpF
         hQuDIkhgc2m4MJSjfhkju3Fdo0YkwDrQ7zzShfZDbXWjzWSLvN/3NgfO1G5lAMnLC/nQ
         zir0gtyoRlOMw+7VeyH+Y36zWZ3APcL9z/BzBf6D9on4JDs+ErG6cU4G6Cd0uE/FOcwo
         lLWg==
X-Gm-Message-State: ACrzQf1san8+N50QvqzH/wJUDK/o0JtqdAzL++64TgQ/fTJZzPe3Ms57
        qOI7vtvIbMC6dC7K9/ZGpgdvAQCs2A9zPAzsFFfScOUNgHs=
X-Google-Smtp-Source: AMsMyM7zD6isDJ6UJOQ3QtX+tKpPq685v5+DmwyFUvISrYY5uzUt5EN7FqpxwKlyHaHmngpf2ytPTx+Tcli5lrVpQc8=
X-Received: by 2002:a05:6808:1b1f:b0:350:9443:d8f5 with SMTP id
 bx31-20020a0568081b1f00b003509443d8f5mr2922195oib.288.1664505936959; Thu, 29
 Sep 2022 19:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220712020058.90374-1-gch981213@gmail.com> <0450c7c0-4787-2aa2-de3e-c71522e467ce@kernel.org>
 <498a9097-8ecf-0a47-abbb-8b64fb7ee2de@kernel.org>
In-Reply-To: <498a9097-8ecf-0a47-abbb-8b64fb7ee2de@kernel.org>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Fri, 30 Sep 2022 10:45:25 +0800
Message-ID: <CAJsYDVKXxzOr_UqN-rU06JxbAqs07dzF=8QP_dmebNBDUDfTqg@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: skip IRQ override on AMD Zen platforms
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        Tighe Donnelly <tighe.donnelly@protonmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Sep 28, 2022 at 4:31 PM Jiri Slaby <jirislaby@kernel.org> wrote:
> > This breaks pads on IdeaPad 5 Flex:
> > https://bugzilla.suse.com/show_bug.cgi?id=1203794
> >
> >  > [    1.058135] hid-generic 0020:1022:0001.0001: hidraw0: SENSOR HUB
> > HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
> >  > [    2.038937] i2c_designware AMDI0010:00: controller timed out
> >  > [    2.146627] i2c_designware AMDI0010:03: controller timed out
> >  > [    6.166859] i2c_hid_acpi i2c-MSFT0001:00: failed to reset device: -61
> >  > [    8.279604] i2c_designware AMDI0010:03: controller timed out
> >  > [   12.310897] i2c_hid_acpi i2c-MSFT0001:00: failed to reset device: -61
> >  > [   14.429372] i2c_designware AMDI0010:03: controller timed out
> >  > [   18.462629] i2c_hid_acpi i2c-MSFT0001:00: failed to reset device: -61
> >  > [   20.579183] i2c_designware AMDI0010:03: controller timed out
> >  > [   24.598703] i2c_hid_acpi i2c-MSFT0001:00: failed to reset device: -61
> >  > [   25.629071] i2c_hid_acpi i2c-MSFT0001:00: can't add hid device: -61
> >  > [   25.629430] i2c_hid_acpi: probe of i2c-MSFT0001:00 failed with
> > error -61
> >
> > The diff of good and bad dmesgs:
> > -ACPI: IRQ 10 override to edge, high
> > -ACPI: IRQ 6 override to edge, high
> >
> > The diff of /proc/interrupts:
> >       6: ...  IR-IO-APIC    [-6-fasteoi-]    {+6-edge+}      AMDI0010:03
> >      10: ...  IR-IO-APIC   [-10-fasteoi-]   {+10-edge+}      AMDI0010:00
> >
> > And:
> >    i2c_designware: /devices/platform/AMDI0010:00
> >    i2c_designware: /devices/platform/AMDI0010:03

Oops...

> > So the if needs to be fine-tuned, apparently. Maybe introduce some list
> > as suggested in the commit log. Based on the below?
>
> Something like the attached. It's:
> 1) untested yet
> 2) contains more debug messaging
> 3) contains both cases for ACPI_ACTIVE_* as I don't know the original
> polarity

The patch in your attachment looks good to me. But I think
"lenovo_laptop" is a bit too generic. Maybe name it
lenovo_82ra instead?

>
> I don't know how widely this is spread -- maybe it would be worth a
> commandline parameter so that people can work around this until this is
> fixed by a DMI entry permanently?

That's a good idea :)

--
Regards,
Chuanhong Guo
