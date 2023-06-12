Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B239572CA0E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbjFLP2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbjFLP2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:28:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D881728;
        Mon, 12 Jun 2023 08:27:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so5315391e87.3;
        Mon, 12 Jun 2023 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686583668; x=1689175668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eqdmpioM7cvB8OMxS9TRRMy4xTHyUhazWL7ppG2Wes=;
        b=OAcMjzwJCHqYjJqn3ucnb+gsPFqhKKRm4+H3g66MCcjXAbL5eOtZEK6vZVUjtu7/hl
         Lfyr/hQ3gwHJtSQuso1QYT9/6cs9mmMkv8vi882a3IV2A5Hjkdq/HdXPaWictX5jJlXk
         AgmvOD1Oq08CfWjS5n4SMbUIHGaTnoC5K++S99qOvOcfr6AzMb5WxtrfG0cSQP7NDGnh
         OMcPOAXjdON/GpeRodJi3ejlrTiWMQYATfoJtdBc9hKMKsPdJLFqeG1oDzfnCcg6e4ip
         HJgEAcsAxyGYlV+FVIDIMmeFq4su/YXDow2rawAx+pU+MdpvuuanzhRh3yNlXd4flig/
         689Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686583668; x=1689175668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eqdmpioM7cvB8OMxS9TRRMy4xTHyUhazWL7ppG2Wes=;
        b=bvAM9BjjBrnOVUjshrHK2wPtGU8dz1Mttldhp6Bmin0m6euEGDh7eEyr31eIvvXudv
         S6MiUL7aRbPopf4trlspYB6yM3y43W0DQkYXjK07OF1dZg2NDEZVCrngov+S5aW7sW2z
         dQ9I1RuiVkrk8Q9XOECqgLVEjvegY8XIn0cznYDj4adl5NGtnfiSuL7rtWPyxWubiW0P
         Px97qQ92Hbe22StqSeQd5EzGAg/D1SQnobGUQVXuuBnNz2C+7Ss1Dmd5mVChuDPo1hkD
         w47GnRG2Nwxj+1uY7Gl1fUqq8qdOM/BNO1AvWgK3qKlKPcMle8+7KcHv5S0fxgW2uYoB
         ht0Q==
X-Gm-Message-State: AC+VfDzHW6+oZktQcXMkcG6zIwGDmbLbPu+3y1ln3J+VRG58vvJ6W8aL
        5kReWLVn/tQ2eRoZkJPs7NkVkYsLrQ+jmIe10A==
X-Google-Smtp-Source: ACHHUZ5wFjKGPSAP6FqL1tEy9K8sbH3eFvEp3aEmBQXMgMe0Z9ECe+DRGR5GMeeGDzFOcDKdAztD0yKBXRn+90JYSvg=
X-Received: by 2002:a2e:87d9:0:b0:2b2:5d2:ce5f with SMTP id
 v25-20020a2e87d9000000b002b205d2ce5fmr2909582ljj.50.1686583667984; Mon, 12
 Jun 2023 08:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230612085817.12275-1-powen.kao@mediatek.com>
In-Reply-To: <20230612085817.12275-1-powen.kao@mediatek.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Mon, 12 Jun 2023 23:27:36 +0800
Message-ID: <CAGaU9a8HKSuxZ2Qhw6HkJ1WMWVsr6JZFX_Xrk8Eq_8Qqg6Q5qw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] ufs: Introduce MCQ Quirks for MediaTek host
To:     Po-Wen Kao <powen.kao@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com
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

On Mon, Jun 12, 2023 at 5:11=E2=80=AFPM Po-Wen Kao <powen.kao@mediatek.com>=
 wrote:
>
> v1
> Introduce quirks for non-standard part of UFSHCI and address Bart's comme=
nt
> from last patch
> https://lore.kernel.org/all/20230328103801.11198-1-powen.kao@mediatek.com=
/
>
>
> Po-Wen Kao (4):
>   scsi: ufs: core: Add host quirk UFSHCD_QUIRK_MCQ_BROKEN_INTR
>   scsi: ufs: core: Add host quirk UFSHCD_QUIRK_MCQ_BROKEN_RTC
>   scsi: ufs: ufs-mediatek: Set UFSHCD_QUIRK_MCQ_BROKEN_INTR quirk
>   scsi: ufs: ufs-mediatek: Set UFSHCD_QUIRK_MCQ_BROKEN_RTC quirk
>
>  drivers/ufs/core/ufs-mcq.c      | 12 ++++++++++++
>  drivers/ufs/core/ufshcd.c       |  6 +++++-
>  drivers/ufs/host/ufs-mediatek.c |  2 ++
>  include/ufs/ufshcd.h            | 13 +++++++++++++
>  4 files changed, 32 insertions(+), 1 deletion(-)
>
> --
> 2.18.0
>

The entire series looks good to me.

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
