Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7A673CAF2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjFXMwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFXMwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:52:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8D919B7;
        Sat, 24 Jun 2023 05:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CC73602E8;
        Sat, 24 Jun 2023 12:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81532C433CA;
        Sat, 24 Jun 2023 12:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687611135;
        bh=kHhHNKRusWp3/ld33wwdh8PJRYf8lmxyG3Kov1neSkw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cSkt9/mSfAhhZeNr5/gKNkUak5ti6Rst+i1tl+EzqSiSmyUZvbAJreZJEktWa2Tqk
         +udr2HuDMaciDOvcYgnGPvQlm9ESWAT2rb/ZF4ogoooja0IVQJMsrBwi3+WCY8Ad2t
         svmK0RI9iTu+wnODHCvhiJoZvUHMG90vcux/3+S5RAqE1SboNR36ml8Pwrs18sxVUg
         uimZzQ3T8ajsXwX8qc55MzBTIDywfoOz+hfHgV9cw5/gPvuHlLbcitZ5I51IT18ktR
         P3B55o3BWLtwkNSz8HEKrgkozscL0Rr59o4QOKzSICQ4Rzp92RqK732vzhWI7oeGlV
         +17gYBwRzIK+w==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f866a3d8e4so2190932e87.0;
        Sat, 24 Jun 2023 05:52:15 -0700 (PDT)
X-Gm-Message-State: AC+VfDxacXop9NGBfvN+21Dt584SWs2nUMXvVN2mj+C5E/EGT5eY567p
        iHwZ20+CvESSST6lq7e4sHaWHgRdpnHrUPxvtTE=
X-Google-Smtp-Source: ACHHUZ4tEhdREzxLeBvoSgS+KPuPkEUNzVRNVIVPcEu9Rad/1bw73q/f2L/oYI20KRvPlEwpMelie4194emS+tIdPiE=
X-Received: by 2002:a05:6512:3d1e:b0:4f9:696f:6b0b with SMTP id
 d30-20020a0565123d1e00b004f9696f6b0bmr5877154lfv.60.1687611133543; Sat, 24
 Jun 2023 05:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
 <CAP6exY+tqAU0j1TVEMTzTb18M6_mPH5bWWiAS=94gyDGTY3hyQ@mail.gmail.com> <CAEEQ3w=wBdpZWnUd2WWVBC3BtFiUp-PQtNAtdXE4cO4n0XT-fg@mail.gmail.com>
In-Reply-To: <CAEEQ3w=wBdpZWnUd2WWVBC3BtFiUp-PQtNAtdXE4cO4n0XT-fg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 24 Jun 2023 14:52:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFGpXEPtYpy1+bs13F2P_LLZf9rTMfYMU=6jzgd3=SEcw@mail.gmail.com>
Message-ID: <CAMj1kXFGpXEPtYpy1+bs13F2P_LLZf9rTMfYMU=6jzgd3=SEcw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Cc:     ron minnich <rminnich@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 at 10:04, =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@byteda=
nce.com> wrote:
>
> Thanks for Ron's suggestions.
>
> Hi Ard,  Mark,
> >
> > Is there some feeling here that it would be ok to restrict this discuss=
ion to risc-v, and not bring in ARM considerations.  WDYT?
> >
>
> Hi Ard,  Mark,
>
> Now the coreboot we are using does not support EFI and only supports
> one interface DTB. It seems that we have to pass the firmware
> information through DTB.
>
> From another point of view, ACPI and SMBIOS are common modules of the
> kernel, not only EFI, but also other interfaces can also be connected
> to this module, such as 0xF0000 for SMBIOS,
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP for ACPI,  this patch is also.
>
> We just use the DTB channel to add a few nodes to complete the
> transfer of firmware information, which does not interfere with DTS
> itself.
>
> We think it is unnecessary to add an ACPI-supporting framework under
> the fdt framework we discussed before. We only need one set of ACPI
> framework, but one more set will cause unnecessary trouble.
>
> So, let's move on to this patch, shall we?
>

How do you intend to provide the ACPI core with the memory attribute
information that it needs to access SystemMemory OpRegions?
