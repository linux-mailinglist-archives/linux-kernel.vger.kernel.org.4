Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42146F3E6E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjEBHfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjEBHfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:35:40 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DF7A7;
        Tue,  2 May 2023 00:35:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ec8133c59eso4080309e87.0;
        Tue, 02 May 2023 00:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683012938; x=1685604938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wvv/hBwHmGpvqxO3rQDcjva4ryRFVTLpzb5zW5Sqmx8=;
        b=FGYEylr802NA6MTpdomm9Hftyvl+iDvM04PAu5BCQ59yI97GUTmORAQmdcMDeCDxTS
         o6eURyXC9cHCn+zwsP2nBJjGuhFiJGDN8knAiOPN+luqD25+z+8DEimQCE0PwzpZ2Oup
         7130IR5wx+Evw9fABnCWM+tIiPshztoqCHBn544aoYVsOD6k7F1/TE4UUjdIj/IGk/N2
         EyYwHliO/jkqQRw3w9Ov+LqUDPhI894BvHxK1aKeySBdigVtA0m48r5+swd5rBWsxGbR
         en61vC7TxKgBGNcLYKehjNKqlduG5UsygK1WyCA8JmFnnKgQ4CStiEgHb9NbMZIZObTc
         S3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683012938; x=1685604938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wvv/hBwHmGpvqxO3rQDcjva4ryRFVTLpzb5zW5Sqmx8=;
        b=T5NMeS81OqvKqperuXEx/gi1iYtoNHHY/KFpO75yH4fy7jzcRcw1fPvjfBhwXMBjKS
         BZ7MaPiUDIBQ8vQ2EUiGok50pQyBsmwTQ4+X9k0gSPBMhINHuTeHZRE691o+KVE/Q1LF
         QQsez9WAzPGdFeIQzi070i57zwCcq9XyzL8NNdmX7vS0Q31DTgInANAwzkvIK35V3XlG
         UmbOT/evFOMMGOJiqGGDadthKx+5RAIBlm7YBEdT3LreWzyAtgqnvStN3BEimvtjRcCV
         m+uJCODaSoV2j78AT5c9OrRAUxfd+f7KfZ/NmF7BKS8vD2iiQUsm/+1cuoxbsJCr4Omf
         gJCg==
X-Gm-Message-State: AC+VfDxp70qg440ywAau0yhjkns7gpwQ2xLUS5f8UUgeN+3MupHh7WIc
        7OeKHtjwK1qTFNvwvgZ9rRvcF7l4iJNb8N0otw==
X-Google-Smtp-Source: ACHHUZ754sEATk1u8vUKBryFLLWAYu4arHBctSmd0C0Y352aDzqYtnJ0KlDtB2OPQuyahMtxy6awD4KLzSZtG6KW6eo=
X-Received: by 2002:ac2:52aa:0:b0:4ef:f088:f0e6 with SMTP id
 r10-20020ac252aa000000b004eff088f0e6mr4850445lfm.57.1683012937578; Tue, 02
 May 2023 00:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230424140839.22358-1-powen.kao@mediatek.com> <20230424140839.22358-2-powen.kao@mediatek.com>
In-Reply-To: <20230424140839.22358-2-powen.kao@mediatek.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 2 May 2023 15:35:25 +0800
Message-ID: <CAGaU9a8mSx1Da5rnXDm9pc-yc8BQOrjc5KMXjotcaDdKDTXwuQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] scsi: ufs: core: Fix mcq tag calcualtion
To:     Po-Wen Kao <powen.kao@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        mason.zhang@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Po-Wen,

Po-Wen Kao <powen.kao@mediatek.com> =E6=96=BC 2023=E5=B9=B44=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8810:13=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Transfer command descriptor is allocated in ufshcd_memory_alloc()
> and referenced by transfer request descriptor with stride size
> sizeof_utp_transfer_cmd_desc()
> instead of
> sizeof(struct utp_transfer_cmd_desc).
>
> Consequently, computing tag by address offset should also refer to the
> same stride.
>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
> Reviewed-by: Ziqi Chen <quic_ziqichen@quicinc.com>
> ---
>  drivers/ufs/core/ufs-mcq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 31df052fbc41..3a27fa4b0024 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -265,7 +265,7 @@ static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
>         addr =3D (le64_to_cpu(cqe->command_desc_base_addr) & CQE_UCD_BA) =
-
>                 hba->ucdl_dma_addr;
>
> -       return div_u64(addr, sizeof(struct utp_transfer_cmd_desc));
> +       return div_u64(addr, sizeof_utp_transfer_cmd_desc(hba));

Would you also need to consider the ufshcd_release_sdb_queue() case?

Thanks.
Stanley Chu
