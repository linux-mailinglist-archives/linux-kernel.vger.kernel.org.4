Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4705714A57
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjE2N3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2N3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:29:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA4890
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:29:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC699617C4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 13:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BE4C4339B
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 13:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685366956;
        bh=XLm3szY01Nq/axWC4cs6QVknk/VT720/yL79hUpr8b0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ga2ESkzeZKzpkTuZJ+seVAN2NKGi/tjHIbDQxgHlAurN8xkO+9/IEbg/CNMjgBfYE
         lOJXAVWnJ+rnxgv21ljjW5tFHhqVHlvCYWdkp2h6Ut/89nJUiMDaASWwAXzAW50VS+
         9LMVDmj2y2P+ZsJnI5zgT/MYJO9/8FRDlOnBlaev965tHnIYlRY6+W45azddHtYFCE
         HIPukyny9gdqoVW64OkVtmLgiMqwlvwRuRXmnSZslsBM0Wb90y9yy9C7dTGL2hWCb0
         KMYR5BEJ1IkfhVWRKakCDaTNzHufgQ5jlEQicoJEjKPfGfMbLBFk0mw33VAPKzwrgY
         kDJpCk2H3eiZw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2af31dc49f9so35535901fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:29:16 -0700 (PDT)
X-Gm-Message-State: AC+VfDyL/iT/zokZgOkTVmg6y6T5N4ztkWF21xcwVwY4zQZYF7GCXx8s
        o1zBkvrsDbm/k9vbawdS8J9g6tkS7B/jFXBmTKU=
X-Google-Smtp-Source: ACHHUZ5QX6MT0hXAcfXSzdfRq24FDKaVwugGILK0aaVJIy7S+mOQIBl6BuEKoRfcqkfhS3TaZxLEkp8kEWE57zcSSpA=
X-Received: by 2002:ac2:5a07:0:b0:4f1:444e:6c5a with SMTP id
 q7-20020ac25a07000000b004f1444e6c5amr3447772lfn.8.1685366954312; Mon, 29 May
 2023 06:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
 <CAMj1kXEN0naaKAzGKBsJaL7LKa_4b+iP=g9YLcBK8qxZxy1C-A@mail.gmail.com> <CAHUa44EcVtMRp-894vQdHkNpnowvsKEQMZbr=axOJPig9zFhqQ@mail.gmail.com>
In-Reply-To: <CAHUa44EcVtMRp-894vQdHkNpnowvsKEQMZbr=axOJPig9zFhqQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 29 May 2023 15:29:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGDRDCOgVXAYU2wM1SsT9A20-dxCRqiOu3-FbjGTvWehw@mail.gmail.com>
Message-ID: <CAMj1kXGDRDCOgVXAYU2wM1SsT9A20-dxCRqiOu3-FbjGTvWehw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] introduce tee-based EFI Runtime Variable Service
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 at 11:05, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Fri, May 26, 2023 at 3:10=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Fri, 26 May 2023 at 03:08, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> > >
> > > This series introduces the tee based EFI Runtime Variable Service.
> > >
> > > The eMMC device is typically owned by the non-secure world(linux in
> > > this case). There is an existing solution utilizing eMMC RPMB partiti=
on
> > > for EFI Variables, it is implemented by interacting with
> > > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > > and tee-supplicant. The last piece is the tee-based variable access
> > > driver to interact with OP-TEE and StandaloneMM.
> > >
> > > Changelog:
> > > v4 -> v5
> > > - rebase to efi-next based on v6.4-rc1
> > > - set generic_ops.query_variable_info, it works as expected as follow=
s.
> > > $ df -h /sys/firmware/efi/efivars/
> > > Filesystem      Size  Used Avail Use% Mounted on
> > > efivarfs         16K  1.3K   15K   8% /sys/firmware/efi/efivars
> >
> > Excellent, thanks a lot for double checking that.
> >
> > Jens, did you have any feedback on this? If not, I intend to queue it
> > up for v6.5
>
> Looks good to me.
>
> Thanks,
> Jens
>

Thanks

I've queued this up now.
