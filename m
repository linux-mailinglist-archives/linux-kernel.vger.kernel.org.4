Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077E4711095
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjEYQMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjEYQMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:12:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E06210B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:11:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66AC364754
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5D3C433D2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685031087;
        bh=68dx/rY90NC8wOI8hV0HFjV/zhhCrF1GhBmt0/6FRNA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t6zWjU+rpy64Noy0yJkZh49d1OFrOb/tDGUyWXn3E25ibTA0yHHUxaWuJfSDpFjNd
         SsxRlYpmL0yHtr6NoJ9NRUCSb6Ck7gByHkZBV40sXtsYrnz75WOLEw2oHV87gDIAac
         qVTsAkprOwLJgVh6glafUQiuPdkB3GI3XAzKFIuqX3XveX2nfIpQeQVuHXlhf71nGG
         Qd51Q3eRzYeZ5lD0xlLKVUDSQfUGjgp5kUP+1cBBeHq9tcex1I72PqaEx4m8yMZ6iv
         CaOnp0O57WTDEHbtBwSB735s/EYUJMijzeFqtsL1cIVkAlIRvc8Q0iDZ4edfKteRmF
         9MNz9XXEEsTNg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4f37b860173so2776165e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:11:27 -0700 (PDT)
X-Gm-Message-State: AC+VfDyEL39hzpRjI3+GukHO/3oSqWI4mFcxv5uRUez2X5aerm8RWirl
        8aPsJMjhzpTchD5VlLOlhbUeuRRUIKdPoJfReao=
X-Google-Smtp-Source: ACHHUZ4xfxHLlDiC+LCfpc50LYV1fkStQqHKY14mLTAW2mplnwHQ0mSlsbPW37mLUnTaLnYkfFGZZQNaIuaZAyoOue4=
X-Received: by 2002:ac2:51ad:0:b0:4f3:a3e0:8502 with SMTP id
 f13-20020ac251ad000000b004f3a3e08502mr6374558lfk.33.1685031085799; Thu, 25
 May 2023 09:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230523090607.1433-1-masahisa.kojima@linaro.org>
 <CAFA6WYOOEwd=jWk1LEaj9K2GkjfV+kfPYOfwPkJVoWXJKGoQXA@mail.gmail.com> <CAC_iWjKxXrEgpqgnpt8g0ummdb1mFbwgMVTSVqfRTNbXOwhz2w@mail.gmail.com>
In-Reply-To: <CAC_iWjKxXrEgpqgnpt8g0ummdb1mFbwgMVTSVqfRTNbXOwhz2w@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 25 May 2023 18:11:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGxTcsWxwKayf8YDy_iocPJu2reWgMBtRfs8ZNin4fPpg@mail.gmail.com>
Message-ID: <CAMj1kXGxTcsWxwKayf8YDy_iocPJu2reWgMBtRfs8ZNin4fPpg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] introduce tee-based EFI Runtime Variable Service
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 at 10:01, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sumit,
>
> On Wed, 24 May 2023 at 10:56, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Tue, 23 May 2023 at 14:36, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> > >
> > > This series introduces the tee based EFI Runtime Variable Service.
> > >
> > > The eMMC device is typically owned by the non-secure world(linux in
> > > this case). There is an existing solution utilizing eMMC RPMB partition
> > > for EFI Variables, it is implemented by interacting with
> > > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > > and tee-supplicant. The last piece is the tee-based variable access
> > > driver to interact with OP-TEE and StandaloneMM.
> > >
> > > Changelog:
> > > v3 -> v4:
> > > - replace the reference from EDK2 to PI Specification
> > > - remove EDK2 source code reference comments
> > > - prepare nonblocking variant of set_variable, it just returns
> > >   EFI_UNSUPPORTED
> > > - remove redundant buffer size check
> > > - argument name change in mm_communicate
> > > - function interface changes in setup_mm_hdr to remove (void **) cast
> >
> > I don't have detailed insights into how EFI spec mandates StandaloneMM
> > should be implemented. But utilizing OP-TEE as the underlying
> > transport here looks fine to me. FWIW,
> >
> > For the series:
> > Acked-by: Sumit Garg <sumit.garg@linaro.org>
>
> Thanks!
>
>  FWIW the PI spec describes some of the functionality and how that
> should be accessed.
> There's a EFI_MM_COMMUNICATION_PROTOCOL which is not used here.
> Instead the entry point is via an SMC to op-tee and the payload
> adheres to what the PI spec describes in its EFI_MM_COMMUNICATE_HEADER
>

Thanks for the resend

Could you please double check whether this needs any changes in
relation to this patch?

https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?id=d86ff3333cb1d5f4
