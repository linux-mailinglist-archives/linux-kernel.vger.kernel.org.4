Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A726076F3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJUMeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJUMeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:34:09 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5A82610B1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:34:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id u71so2452617pgd.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyCXDbLpOB42sFwGLjHzpnkGP3ksmJXvJE6oi9Zx5GM=;
        b=uUrsYd9XAH1vztZJPKMaodu6CSrh8REB1BXqn7Y728tygZ9uXBYUOfql5/poP5XLKe
         91K7mLRjGFZZWt7pxL9d56Gb6tNIeRzyjHO1XBA8uO8PYjxtgI3t+0Od/tnaAySlyVo1
         Z8blIIPx+jhElCi1pIm+qZ8Qnt/dMWjODQUSS2rnTl5hquxwi5Bg7oSiyZwyPkKjpBKL
         MyVMgymwgN4IkbGGBHN19CVSdtj+soqVxIkptMBDYwiY1mnPM4akOJZbmw6D0m6fXeQZ
         PERVi5CIHDsKRtH3r23dUOaTf7Uax1cZdrxHO9H229JCc1FT+iq814joq0C1xI3or9oI
         vnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyCXDbLpOB42sFwGLjHzpnkGP3ksmJXvJE6oi9Zx5GM=;
        b=PZ0T5Y74rTwJRS7hc9cpJwAIcZJNX4ONdf0Oe5jnigCYUSOSwfiD6cUdmA758/f9U3
         wykktxdfTKikvWaBxsIAvxvnVhlopuJ9KBDD/dlUfKMwej2CJP3GZAVCSjzMXd6H2EYy
         Jn7wFHhXHD5hTirJvoZxhGxdcEjgQ6gyqDkzzbh/nX6B//IVyZEjPJMK8b8Hmapf67wC
         iW9XO6PuAnpsNziE/rxYlZ0kV9L32aD8GOjUcEFxx2ZAsv3jRa0jwDvA0MWCrwdXTEzw
         OrqpRdU30zbIAMgzGYTxF6/YztpzZnPynsR/i0OV0nzT7XvI1HX0yKUvuE5f1SGALlJB
         e8Cw==
X-Gm-Message-State: ACrzQf1hHrWxBkkPPtBwjivSHiRPmUC52W7ZN8vAhZsH3HNIJYBgtZub
        FhUNyyT2PJ0k12Hm2iojeGRbh9wXsNP02D0k7oQ4iQ==
X-Google-Smtp-Source: AMsMyM4sW4hgbnbXnOdPBCZmzImZYpM5zcFzTNd+ZfeOEYrhZqNH2MfjpA24pDa7AurEdTLSgv5fP9ow6WF+2WQBXvs=
X-Received: by 2002:a05:6a00:1587:b0:563:39f5:3fba with SMTP id
 u7-20020a056a00158700b0056339f53fbamr19484913pfk.64.1666355647886; Fri, 21
 Oct 2022 05:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAFJ_xbq0cxcH-cgpXLU4Mjk30+muWyWm1aUZGK7iG53yaLBaQg@mail.gmail.com>
 <20221021111935.GB28729@wunner.de>
In-Reply-To: <20221021111935.GB28729@wunner.de>
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Fri, 21 Oct 2022 14:33:56 +0200
Message-ID: <CAFJ_xboDuFiACjECO0UmYz5y9TCz4rTRPmrxeVMup7r9816dTg@mail.gmail.com>
Subject: Re: [BUG] Intel Apollolake: PCIe bridge "loses" capabilities after
 entering D3Cold state
To:     Lukas Wunner <lukas@wunner.de>
Cc:     bhelgaas@google.com, Rajat Jain <rajatja@google.com>,
        Vidya Sagar <vidyas@nvidia.com>, upstream@semihalf.com,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 21 pa=C5=BA 2022 o 13:19 Lukas Wunner <lukas@wunner.de> napisa=C5=82(a=
):
>
> On Fri, Oct 21, 2022 at 12:17:35PM +0200, Lukasz Majczak wrote:
> > While working with Vidya???s patch I have noticed that after
> > suspend/resume cycle on my Chromebook (Apollolake) PCIe bridge loses
> > its capabilities - the missing part is:
> >
> > Capabilities: [200 v1] L1 PM Substates
> > L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substat=
es+
> >   PortCommonModeRestoreTime=3D40us PortTPowerOnTime=3D10us
> > L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> >    T_CommonMode=3D40us LTR1.2_Threshold=3D98304ns
> > L1SubCtl2: T_PwrOn=3D60us
> >
> > Digging more I???ve found out that entering D3Cold state causes this
>
> You mean the capability is gone from lspci after D3cold?
>
> My understanding is that BIOS is responsible for populating config space.
> So this sounds like a BIOS bug.  What's the BIOS vendor and version?
> (dmesg | grep DMI)
>
> Thanks,
>
> Lukas

Hi Lukasz

here is the DMI

localhost ~ # dmesg | grep DMI
[    0.000000] DMI: Google Coral/Coral, BIOS Google_Coral.10068.81.0 11/27/=
2018
[    0.155420] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.447820] [drm] DMI info: DMI_BIOS_VENDOR coreboot
[    0.447828] [drm] DMI info: DMI_BIOS_VERSION Google_Coral.10068.81.0
[    0.447832] [drm] DMI info: DMI_BIOS_DATE 11/27/2018
[    0.447835] [drm] DMI info: DMI_BIOS_RELEASE 4.0
[    0.447838] [drm] DMI info: DMI_SYS_VENDOR Google
[    0.447841] [drm] DMI info: DMI_PRODUCT_NAME Coral
[    0.447844] [drm] DMI info: DMI_PRODUCT_VERSION rev3
[    0.447848] [drm] DMI info: DMI_PRODUCT_FAMILY Google_Coral

Yes, you are right and in our internal discussion the vendor (Intel)
has proposed a firmware patch, although I couldn't verified that the
issue is limited only to the given firmware/bios, so decided to send
this email.

Best regards,
Lukasz
