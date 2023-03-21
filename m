Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E55C6C2631
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCUAFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCUAFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:05:15 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFBC13D6C;
        Mon, 20 Mar 2023 17:05:12 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id n13so1279044qkh.5;
        Mon, 20 Mar 2023 17:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679357110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zwGxwuyXT/NVvMzhj8NdGRibrMvY35o27jTmcImb/o=;
        b=M87mIS3xjD3LbG+ibAMNXTKr5138vmVRHU7bLjNFFqg2esxmLtsuup0C/VhccJYamh
         4koBFZK6aSnb8OgxOoV1mbp03nkUotXwNzHYvS/dB5mQrLARdltZTYlvkZ4xgdVEFk+y
         fEE/ah0ADDD2pkKj9QBlA8FdVi2C9Er1pT3cY5/NrQyZNZ4EorHEJbgn6ZO/LFyeYEqz
         s09eSL8NyzIugTn3N6XSe/7kpesvNm/JVeMPNhg8ycevYSQhJSFZc2xr9YoQcura1prr
         TXlHWXEG2UxUSqngylm15VXJ8o1ryq7WzcpY1Dkf3mWGLmCA9hVUCpqj4TX8ECJpJlnt
         AVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679357110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zwGxwuyXT/NVvMzhj8NdGRibrMvY35o27jTmcImb/o=;
        b=JFEBStYct8VoIGYMikjlVQmigHjrMVUZkl0hsE2tFXrBCyX+B9TVPZFc6Ln2BhC9Sm
         UJmeCwf2xKppsbQFlHOSD3j68VOqCryIBQ4SQIkt3j/tjErMu0gues9Y1aSLeeJRU9FZ
         gGKy1if469TMM9xQC6MGp4B3WFYk1zB/JRadDw1SMxRj9nUrFcLPNW5Tx4ziLCxVhd5P
         DzNZJ/VOfAH4CAUca4o4C6NmvpS0PoQicyb/jSR6AMXGLuVWq5s0j1QgPrgiuHZNcYG3
         Ultc5FpblnJk2amQexZywFJtQjKeuiaQbvYQsSmIkfpSbggqR2lias3HhPMehTA0Giew
         V/3A==
X-Gm-Message-State: AO0yUKXHgCZycvDuJByY90RmwhA6GksQmXuA1hQV361UXgAsLjKG0N9u
        E+GDCP0WdxjEfsKnX6MsdoHL9NFg85RO/8MCNC5WpodW/aARE5cn3x1eeg==
X-Google-Smtp-Source: AK7set8Ktr3fw2E+9mOT7egDTk+dzT1LGMr4CC3xgUMx14JeapNTniRyBCsmYLDYA4HpVC3dRZHypWJfW1pCY5XKRCk=
X-Received: by 2002:a37:e110:0:b0:744:ae74:6fd2 with SMTP id
 c16-20020a37e110000000b00744ae746fd2mr163138qkm.10.1679357110557; Mon, 20 Mar
 2023 17:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsMOZ7LQgem+vpjytU5MybGrOmRH_hnkckQCx8_wCknecA@mail.gmail.com>
 <121d75eb-da8e-e120-3754-391a0c064001@candelatech.com>
In-Reply-To: <121d75eb-da8e-e120-3754-391a0c064001@candelatech.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 21 Mar 2023 05:04:59 +0500
Message-ID: <CABXGCsMP6XUt4QKPc2P4fHo8DD_tam62NBHGrSWc0BHvch3hXw@mail.gmail.com>
Subject: Re: BUG: KASAN: vmalloc-out-of-bounds in mt7921_check_offload_capability+0x3fa/0x430
 [mt7921_common]
To:     Ben Greear <greearb@candelatech.com>
Cc:     Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        Felix Fietkau <nbd@nbd.name>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 7:00=E2=80=AFPM Ben Greear <greearb@candelatech.com=
> wrote:
>
> On 3/20/23 03:32, Mikhail Gavrilov wrote:
> > Hi,
> > After enabling KASAN sanitizer the message "BUG: KASAN:
> > vmalloc-out-of-bounds in mt7921_check_offload_capability+0x3fa/0x430
> > [mt7921_common]" chase me at every boot.
>
> This is use-after-free bug, and I already posted a patch to fix it.
> "wireless: mt76: mt7921: Fix use-after-free in fw features query."

Hi,
This is the last version?
https://patchwork.kernel.org/project/linux-wireless/patch/20230308175832.23=
94061-1-greearb@candelatech.com/

Unfortunately it is not applicable to 6.3-rc3.

=E2=9D=AF git apply v2-wireless-mt76-mt7921-Fix-use-after-free-in-fw-featur=
es-query..patch
-v
Checking patch drivers/net/wireless/mediatek/mt76/mt7921/init.c...
Hunk #1 succeeded at 171 (offset 6 lines).
Hunk #2 succeeded at 203 (offset 6 lines).
error: while searching for:

release_firmware(fw);

return features ? features->data : 0;
}
EXPORT_SYMBOL_GPL(mt7921_check_offload_capability);


error: patch failed: drivers/net/wireless/mediatek/mt76/mt7921/init.c:211
error: drivers/net/wireless/mediatek/mt76/mt7921/init.c: patch does not app=
ly

--=20
Best Regards,
Mike Gavrilov.
