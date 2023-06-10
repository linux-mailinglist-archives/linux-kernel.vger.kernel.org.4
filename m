Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C068E72A89A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 05:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjFJDAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 23:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjFJDAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 23:00:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438263C02;
        Fri,  9 Jun 2023 20:00:30 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f122ff663eso2954557e87.2;
        Fri, 09 Jun 2023 20:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686366028; x=1688958028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJq+2/RSaJ7fmkOcjKO3amG929XbfkZnl7QhpyxGlBk=;
        b=Ym/6M4HGGdBtaElDK1B31w3o/7Z73YmWSrAu2i6jzVFCMwSarWiGTIrJH225I6J8s4
         wgC2xYOZbIA2TOk0TPpxjhNGV4EWSsm4rjlRhZX6/Sjx2U3Ypr/ZssfhFUHNpHlheUgF
         M7GS1oR/uEkdOXQkbb/tLBY6CnqQ5EzSx6LuxS2nOg5d4N2q9Oc7oYN/vZwKRxGcXCEX
         HLLyGw4pms03SBZ9AquXz4xDgtRAZrEaHKKgmV9ws99mDct/2ZDMUaREgKLrqm00mk/6
         VwXucoD3QNTvDweiRuCUw36WzkxnhbF07DVaeOyk+VBz0VmSfCcXbiBF79siBKdX0aWX
         4QuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686366028; x=1688958028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJq+2/RSaJ7fmkOcjKO3amG929XbfkZnl7QhpyxGlBk=;
        b=Xuw1TiCLpFuxafSZgrvTeWqs/rlaRDYMC6xtiLP+Gn1FB8/fCivxKG7FmGSu1vyHeo
         pD1lSVEbY2xVzembDmq9PsWlsY8k+XXVJejPeGdoTBNYraLv3fYRllplewqKRFfZwz5n
         3MrqL0n3YR0F5EBm+PPvnb3dWf+4Woyhht992vEEvS0PfuuIdy6faUKJu31FTG70fJox
         pus2LgOTAd28SnmAqq8IjJpM7kH4JZTmPebbDPYwi6l8V7pfVhbwk76rp6g8WBry/nUK
         Ooy1EiGRLGweoN0UpUbwStel4GXbLlaGUjDiFjzs+CXVqj+SNhMdI0xcFPWLxgO7VZAs
         pOug==
X-Gm-Message-State: AC+VfDxbxTJcwItuiOJS+sruz3PtR7AFSmwTPwR0jUnB9d4EAtZ6FRdS
        B5dP4CNrA/F2lC+OmjqMTqqaOTQc6tJRT/BEfg==
X-Google-Smtp-Source: ACHHUZ5Vvb14RxL9ukTvB26Pk6G2V/s1h6McJEpnMG+Lb4tEsfZjaoVEBV1zBwT8Tj+qS/9hiAGrvpEIa+Pm0DftQM8=
X-Received: by 2002:a19:505b:0:b0:4f6:14d1:596d with SMTP id
 z27-20020a19505b000000b004f614d1596dmr1647182lfj.61.1686366027294; Fri, 09
 Jun 2023 20:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230610021553.1213-1-powen.kao@mediatek.com> <20230610021553.1213-3-powen.kao@mediatek.com>
In-Reply-To: <20230610021553.1213-3-powen.kao@mediatek.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Sat, 10 Jun 2023 11:00:16 +0800
Message-ID: <CAGaU9a8-2zzBshfoN4zaZbfBu_EKMEH7S4o32DDUk7GJ2nkh5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] scsi: ufs: core: Remove dedicated hwq for dev command
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

On Sat, Jun 10, 2023 at 10:17=E2=80=AFAM Po-Wen Kao <powen.kao@mediatek.com=
> wrote:
>
> This patch depends on patch
> "scsi: ufs: mcq: Fix the incorrect OCS value for the device command"
> which take care of OCS value of dev commands under mcq mode.
>
> We are safe to share first hwq for dev commnad and IO request here.
>
> Tested-by: Po-Wen Kao <powen.kao@mediatek.com>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
