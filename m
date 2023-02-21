Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA08069DA60
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 06:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjBUF2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 00:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjBUF2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 00:28:13 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F03A26D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 21:28:10 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ck15so13690367edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 21:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lSksC8fsXMKoURwVyXHoZg6ZiRAH8wXHUe/MOqa9l0=;
        b=KgzsXP/uLCotz14QrXSx9HGgAAwq+EX1iCA0khBMMYYZ4bpp19cmcKb+PvLCubWlUR
         L0PyVKke1NoF93sTmBRx1gZq1sxFHIYNyFNUDys7r8hw+F8kvjs3+zQ6IdvWkgP4rKaF
         OKRg/wlB+Ns2Q1SuVRevuPq3Vlsk8ARftOOfNgSRagXT77pd5Q5PZo5ZOvAm8XQaB08o
         qzlSJE2K3oP0G+twaGkjWT2+1aU8RWOHzTbbwUv8rYEOXPkp+vOkkSY7yVnkDGpII3gY
         SSaWBzjmIqFZejF2r0vJWgUddc1mFcaDQpM8cxSfhBJucd4o4rT4Noo8xY2bPCUzoPcy
         NN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lSksC8fsXMKoURwVyXHoZg6ZiRAH8wXHUe/MOqa9l0=;
        b=XlBknBVyvq3oTMOkXHNYs2UlM1QYP3ksS4LkekWC8LFVKfSgZOYQp0afAkVcOD2Snm
         yVAMmTBafp9qUtFEvaDyscP12xhqFUWXsJzqE1UazT64goJgnaH7kNuEOLiisV+ndFhG
         ekZ9GOXRoD+DJ+dCQ2qjw5FirBTSLzyYj8r42yEjQ0y595k8fIM20lrLnMn1Oqqu1WzR
         AuSClr4Qnkc1GILtlIx8+D0TNqL9qnaEycnHu4s8HDzHZUhZGImRLC3PsonGglj07AIN
         MwTrczDKkXTOL9MhL4rp8HRSTimJTo82T/i0fBt1iex9FR8eK3LYoIrhMVkVwAZPMBmG
         nL9w==
X-Gm-Message-State: AO0yUKWvU+yRyiB3gIISC5wPK7h0d7oyr5Y5a3CuGJnzMxsToIFKxC0F
        aFrNL+fyXIYwIj1eAgaOpCJS64YDy8xgg0aaboVikg==
X-Google-Smtp-Source: AK7set+j3EAMYoASgPes70zdAtHz5d7vB7lxtsyL/bL08jysUR8+oBSACyTLLBr3ntjp4P4/wn/ov/ari59sXlr14bk=
X-Received: by 2002:a17:906:e217:b0:8b1:38d6:9853 with SMTP id
 gf23-20020a170906e21700b008b138d69853mr5118964ejb.2.1676957289130; Mon, 20
 Feb 2023 21:28:09 -0800 (PST)
MIME-Version: 1.0
References: <20230216092236.26720-1-quic_tjiang@quicinc.com>
 <20230218041545.3801-1-steev@kali.org> <DM5PR02MB36863752A525F50AC05662B0EDA49@DM5PR02MB3686.namprd02.prod.outlook.com>
In-Reply-To: <DM5PR02MB36863752A525F50AC05662B0EDA49@DM5PR02MB3686.namprd02.prod.outlook.com>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Mon, 20 Feb 2023 23:27:57 -0600
Message-ID: <CAKXuJqigh=5LMei4ym5s4vKCxkMR5vfM++k7Jk7C4Ge-GRVK6A@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth
 SoC QCA2066
To:     "Tim Jiang (QUIC)" <quic_tjiang@quicinc.com>
Cc:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "mka@chromium.org" <mka@chromium.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Mon, Feb 20, 2023 at 1:04 AM Tim Jiang (QUIC)
<quic_tjiang@quicinc.com> wrote:
>
> Steve, sorry I does not know why I can not send out the email as have som=
e warning  , so I removed the code part, you can refer to my inline comment=
s.
>

No worries, I understand!

> Regards.
> Tim
>
> >This patch adds support for QCA2066 firmware patch and nvm downloading.
>
> Is this actually correct?  I ask because here I have the WCN6855 in the L=
enovo Thinkpad X13s, and when attempting to use this driver, I end up with =
a board id of 08c, and according to the firmware, we should have a board id=
 of b8c.
>
> [Tim] correct, I does not know where you get the WCN6855 firmware, for ou=
r side, we will use different name rule for android and linux , for android=
 , we will add "b" in the front of board id, for linux we will not add this=
 bit.

So, the Thinkpad X13s is... well, it's a Thinkpad, and it comes with
Windows.  So the firmware that we have, comes from.... them? qualcomm?
I honestly don't know the provenance of it, just that I grabbed the
files from the Windows partition:

steev@wintermute:~/firmware/new/qcbtfmuart_hsp8280.inf_arm64_69bd85311531b3=
4a$
ls
bsrc_bt.bin hpnv10.b03 hpnv20.b80 hpnv20.b8f hpnv21.ba2 hpnv21g.b9f
hpnv21g.bb8 hpbtfw10.tlv hpnv10.b04 hpnv20.b82 hpnv20.bin hpnv21.ba3
hpnv21g.ba0 hpnv21g.bin hpbtfw10.ver hpnv10.b06 hpnv20.b84 hpnv21.b8c
hpnv21.ba4 hpnv21g.ba1 qcbtfmuart_hsp8280.cat hpbtfw20.tlv hpnv10.b07
hpnv20.b85 hpnv21.b9f hpnv21.bb8 hpnv21g.ba2 qcbtfmuart_hsp8280.inf
hpbtfw20.ver hpnv10.b08 hpnv20.b8c hpnv21.ba0 hpnv21.bin hpnv21g.ba3
qcbtfmuart_hsp8280.PNF hpbtfw21.tlv hpnv10.bin hpnv20.b8e hpnv21.ba1
hpnv21g.b8c hpnv21g.ba4 qcbtfmuart_hsp8280.sys

So, all of the nvm patches that are provided by them with the windows
driver, all start with 'b'.

> I'm not sure how to phrase this, and just thinking out loud - if the qca2=
066 is the same as the wcn6855, just with an additional antenna, perhaps th=
ere should be some way to indicate it?  In my patchset, I had a print of th=
e name "Setting up wcn6855" and locally, I combined your patch with mine, a=
lthough dropping the above qca2066 hunks in favor of my already written wcn=
6855 hunks, and then combined the two in the print so it says "Setting up q=
ca2066/wcn6855" - is there any way to differentiate between what qti consid=
ers a qca2066 and what is considered the wcn6855?
> [Tim] steve ,as I mentioned previously, we have different board id  for q=
ca2066 and wcn6855 , and then which will use different nvm config files bas=
ed on board id.
>
I get that; I'm thinking of end users, who may know that they have a
wcn6855, but if the messages are qca2066, they may not understand that
it's the same chip.

> Below is dmesg output, and so if we go by the wifi device check, we end u=
p seeing that we get
>
> chip_id 0x2
> chip_family 0xb
> board_id 0x8c
> soc_id 0x400c0210
>
> [    9.724834] ath11k_pci 0006:01:00.0: chip_id 0x2 chip_family 0xb board=
_id 0x8c soc_id 0x400c0210
> [    9.724850] ath11k_pci 0006:01:00.0: fw_version 0x110b196e fw_build_ti=
mestamp 2022-12-22 12:54 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SI=
LICONZ_LITE-3.6510.23
> [    9.742346] ath11k_pci 0006:01:00.0: failed to fetch board data for bu=
s=3Dpci,vendor=3D17cb,device=3D1103,subsystem-vendor=3D17cb,subsystem-devic=
e=3D0108,qmi-chip-id=3D2,qmi-board-id=3D140 from ath11k/WCN6855/hw2.1/board=
-2.bin
> [    9.742358] ath11k_pci 0006:01:00.0: failed to fetch board.bin from WC=
N6855/hw2.1
> [    9.742361] ath11k_pci 0006:01:00.0: qmi failed to fetch board file: -=
2
> [    9.742363] ath11k_pci 0006:01:00.0: failed to load board data file: -=
2
>
> But with your driver (mine too for that matter, but then it's just doing =
the same bid bits)...
>
> [    9.081003] Bluetooth: hci0: Frame reassembly failed (-84)
> [    9.141992] Bluetooth: hci0: QCA Product ID   :0x00000013
> [    9.141999] Bluetooth: hci0: QCA SOC Version  :0x400c0210
> [    9.142003] Bluetooth: hci0: QCA ROM Version  :0x00000201
> [    9.142007] Bluetooth: hci0: QCA Patch Version:0x000038e6
> [    9.170612] Bluetooth: hci0: QCA controller version 0x02100201
> [    9.170620] Bluetooth: hci0: QCA Downloading qca/hpbtfw21.tlv
>
>
> [    9.760537] Bluetooth: hci0: QCA board ID len 2,id =3D 0 8c
> [    9.760547] Bluetooth: hci0: QCA Downloading qca/hpnv21.08c
> [    9.760638] bluetooth hci0: Direct firmware load for qca/hpnv21.08c fa=
iled with error -2
> [    9.760640] Bluetooth: hci0: QCA Failed to request file: qca/hpnv21.08=
c (-2)
> [    9.760643] Bluetooth: hci0: QCA Failed to download NVM (-2)
>
> Is there another way to check the board id or board family?  Because it's=
 not coming up with the correct one here.
> [Tim] as my comments above, the read board id way is correct, only we hav=
e different name rule for android and linux .

Right, I get that reading the board id is the right way - and if you
see in my Windows firmware above (the firmware submitted to
linux-firmware by you only seems to have nvm patches that start with
'3', and no others..)  I'm saying, should we also read the chip_family
somehow, since the WiFi firmware seems to properly notice that we are
chip_family 0xb, however, the bluetooth driver just returns '0'.  And
neither the submitted firmware, nor the firmware that Lenovo/Qualcomm
ship to Windows users, have nvm patches that start with 0.

An additional note, neither my driver, nor yours, seems to work with
BLE.  I cannot connect a pair of AirPods to my Thinkpad in Linux, but
I am able to do just fine in the Windows installation.  I'm not sure
if this is a known limitation already in linux or not.

>
> --steev
