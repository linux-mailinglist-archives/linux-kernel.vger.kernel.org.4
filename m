Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408B171A253
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjFAPSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjFAPSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:18:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FE410D1;
        Thu,  1 Jun 2023 08:18:03 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af189d323fso29167541fa.1;
        Thu, 01 Jun 2023 08:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685632681; x=1688224681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTAumcalUcQiGx1tnlErkX6GyqVTNQRt5wh7k3odTZA=;
        b=fsYBW3VTm0kYhHCDQIE7yTK+842UysSDHQPY1amB9atiM9FMZanfftkgZOI+BjL9/v
         YcpI4lBcNB7tT+17Jcy3Q06ANmdx8MLn8QIV+7PvOUGVA5H6nuIQj15mQeOatCmmKvU1
         3oSDVGPT/7m5HuhsGcgWIYmqeW/qvoRO86KjlqRzMg7vuTozIJzvmOdbqwlb18SLai49
         qnWXC5vG3Z7/B0YLHmvXYd5lvuB/WFmfDv22lLzqky/12ukYbroXO8p8lGM88SyTtlka
         PoeGFbEiP1bFQFn4pnPRRH5KErwY2huXeKqr4lC+nSj7BAlYbQj8jAfIFLSKySugpiX3
         Khgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632681; x=1688224681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTAumcalUcQiGx1tnlErkX6GyqVTNQRt5wh7k3odTZA=;
        b=FSi2q5itC3vJcfGYCKKw7odgKNWAOI8nWiLyjlwHN8p73ouZxOqrbm9Uc4bUF7ox/v
         FAhKSKU/mnqwO4j2ObNePjcSgcDvqCkraaMczJQ/GHpi4+SJ5qcMOJSIeXpgIu7s4f3e
         gwNyyA7n2wmnPdpJP6GhJkUDrlqGkopcBYW/94dYL/BsEri9aYM7nm41eVDXKN3mvk94
         1FTdOMzhYlJ93SeqGbfE+pcu0di1b0djd8+V+LKo60z7ULOT0Nehx5eLVUZGqRJHlRTY
         kDGTQXamXqLNQtuZ0D9YP+WqHkBwob4FjYxoKCeensYR29bPdk5GzoAxGiJPzhaQWEy1
         xZrw==
X-Gm-Message-State: AC+VfDwQTb+yFJ97KMzUzAMv9coI8Rs8XT0IuANCskGDOQt5NogZXPM2
        jEXWi2dSe8UEeF2V6ic89yayrx5jU9t071mHcw==
X-Google-Smtp-Source: ACHHUZ7POzm7EFn/TiX6knB2rEnVKU47reEuIkrPfBqJPtaASLAcUeeMOuJ44BupaBw63F8lERn32AY7nkyeW/Rlob4=
X-Received: by 2002:a2e:a230:0:b0:2af:1460:4253 with SMTP id
 i16-20020a2ea230000000b002af14604253mr784298ljm.3.1685632680862; Thu, 01 Jun
 2023 08:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230601124613.1446-1-zhanghui31@xiaomi.com>
In-Reply-To: <20230601124613.1446-1-zhanghui31@xiaomi.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Thu, 1 Jun 2023 23:17:49 +0800
Message-ID: <CAGaU9a_75FToskToj4GDrFqoYSD3mn3GoUKrtiF-bMJgU98wPQ@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: ufs: core: Fix ufshcd_inc_sq_tail function bug
To:     Zhang Hui <masonzhang.xiaomi@gmail.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Can Guo <quic_cang@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        zhanghui <zhanghui31@xiaomi.com>, Bean Huo <beanhuo@micron.com>,
        peng.zhou@mediatek.com, yudongbin@xiaomi.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Jun 1, 2023 at 8:57=E2=80=AFPM Zhang Hui <masonzhang.xiaomi@gmail.c=
om> wrote:
>
> From: zhanghui <zhanghui31@xiaomi.com>
>
> When qdepth is not power of 2, not every bit of the mask is 1, so
> sq_tail_slot some bits will be cleared unexpected.
>
> Signed-off-by: zhanghui <zhanghui31@xiaomi.com>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
