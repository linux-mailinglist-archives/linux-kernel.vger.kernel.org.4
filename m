Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE046420EF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 01:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiLEA6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 19:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiLEA6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 19:58:22 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4773460FE;
        Sun,  4 Dec 2022 16:58:21 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g7so16234844lfv.5;
        Sun, 04 Dec 2022 16:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HkRGHqHdg9Bnf3e/6jaMzI+Z1mIolSUlCDDkLMFE30o=;
        b=CsJ433aWcWqX4swu8BdNVZTdaNezeLS0DcTcv1TN9+CT2c+95XXz2KhAESSQNxbBuQ
         dC8GG6osZuJv0TeYn8QlMNwcnSEHJHFKXKfeqiFoQy6xwWWhpREVfId5aelbbt/k2L3D
         L+SbVOwIELp31NrdyF++V1htL3Xe1+SgXLP9XLfJf3WicwaBZdiJXESKauiFSJrsgjbg
         /uqNJmGJmLa8J4P71e3JBGaujydVPJXSFc6ulvfCdyXENxHO32236cP9g3/nByIKZZAQ
         WNYj0F0pTzmkW6ySlygtIuxu9F6CJNncm0rSFKLykGuGKS6OKYXq/elTNrrUg9M+YfdA
         sqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkRGHqHdg9Bnf3e/6jaMzI+Z1mIolSUlCDDkLMFE30o=;
        b=Jo8lT0O9y0ra/1wdtOCA5ZYlL/lQGIIqna7Qy0pHWiSrY2C/Ge7+zNqc/0CPvsVSbn
         uTbR5J9dzfPpqjeuIJ1G/ngq1oKIXQy7IkxBc8Gxv50LBgQXrWL/NmEhd5oXe5Q5+hQJ
         JrV36IdNGwk+4UsNBSq0KivXzhPSzhD3wPidgvjT3OQZMU7GYkuVVzKdCau78VcpIRSP
         ol7kzpRgSXtoAfC8EfWMwaSYeCg4PY1B7npdJYL6TYVMPCLtwT/nf5ppBX6zMKI9L/4A
         mRxRAh8WLPVMmkSDSAJpia6sCz+X22QZbjgCTFnLwLILTTLu8Fq3enb/1bHKyDntNZxo
         Jo5g==
X-Gm-Message-State: ANoB5pmEcUxjQ2HDRkK71bib8KeVdr6R2g0/7zjxqmR5aCIB+uhU0Eua
        uawG2evIbh/oTJEW3CgBtXCccvLrVrweD3F9Tg==
X-Google-Smtp-Source: AA0mqf6dWmnOgmhIrnqCSzWieFJU/k6CdROuk/AQbLgw/JkAj8kPO0czJ7BA0QbM61jvkXN+fL6ObJbMyLq2cYlhQ+Q=
X-Received: by 2002:a19:6a18:0:b0:48b:1973:e3bf with SMTP id
 u24-20020a196a18000000b0048b1973e3bfmr24921974lfu.328.1670201899359; Sun, 04
 Dec 2022 16:58:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1669850856.git.quic_asutoshd@quicinc.com> <796a65f6f1a6e2d276b05fd76df27ad77c3c38cc.1669850856.git.quic_asutoshd@quicinc.com>
In-Reply-To: <796a65f6f1a6e2d276b05fd76df27ad77c3c38cc.1669850856.git.quic_asutoshd@quicinc.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Mon, 5 Dec 2022 08:58:07 +0800
Message-ID: <CAGaU9a9nbfr1f+ot=DqUSUunqKJNFsrv-FedSUUgjMFs-F+UaQ@mail.gmail.com>
Subject: Re: [PATCH v9 03/16] ufs: core: Introduce Multi-circular queue capability
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        eddie.huang@mediatek.com, daejun7.park@samsung.com,
        bvanassche@acm.org, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 8:05 AM Asutosh Das <quic_asutoshd@quicinc.com> wrote:
>
> Add support to check for MCQ capability in the UFSHC.
> Add a module parameter to disable MCQ if needed.
>
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
