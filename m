Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533FB6EEFEB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbjDZII5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbjDZIIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:08:47 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E52198C;
        Wed, 26 Apr 2023 01:08:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4edc63c82d1so6919049e87.0;
        Wed, 26 Apr 2023 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682496522; x=1685088522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vz2sYZ9NBvU4b/r64w0BAiIz0FeVVMljiKndLFmNPzM=;
        b=nS2NZxDvjIkU7CaXFub7mR+yCqpcF7NqNoWorRX2kerR9UWaikZdyhBovFX7hwE0DY
         CHtJDqKu1PcFiY+n3623hlkKs/dp55Pz5+pmT49qjg+aqXDvLilUhO2iLxJm3UO8gmZW
         NOq1XKWWrz2acbSJO1yRwBeFzkt5pWAbpug5doPLRc29x0MSVq44iPgcMLhDgkAg+cLt
         xlXhTBqoIkqQf/if4N2W1PZXxgFXeOIJv2nalrr3pZSYLIWarKYSDyxT3Uj6vByQBOp6
         0uEYved47plFFXa0Dy98pKjDYqh3yGYg1O/ZMrGz9YmWrx+alibBXFbcweranh1Dw6N6
         4xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682496522; x=1685088522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vz2sYZ9NBvU4b/r64w0BAiIz0FeVVMljiKndLFmNPzM=;
        b=ByUChrWj0JKVYnJPpUuxfC7Y/8U3c/V09miucHm+4extzQVdT9O8KfYQovmSPcWyXk
         dfhx77pcS0NJbb/qsUzhosR2RJ6RNzFYZQfxHUiO3rK9ixKNvkRuwNOt4KWUB0hsFITk
         QEsML3lfpaofI8loNLd6D9bWxupAG9Ocoik5tY4ucmQ8KEyeJ6ofT4wApo09THXra9Wo
         xwAGMajimnPhEGk0IC06EDJxDqeJhjefz1HDso+10TAceEyXyZt/dGsV7bf3q1UdxvY4
         XiLmoVPpAqca8WIsG3vxghNA0zKFrycdH+4+W0WpLAD04FJjYILaO1mbjfetQOaHHRUH
         /nYw==
X-Gm-Message-State: AAQBX9dMoF+XFJLUWFfd7wwr8emiro9my5tAjcuYYNOs4J+/137U+Mjk
        leTFsVPcL4TojtmB7iOqtgyXg4ZN8otZEgQ4tg==
X-Google-Smtp-Source: AKy350a2duOZydJOeUCzAXkYKrF3qHsW1o0YbQZaEfCidJADMQ3GvGD53p0OQ9cnBAH4Me6jhLvBm2L0C46lFlNL9Us=
X-Received: by 2002:ac2:4a87:0:b0:4e8:502e:b32b with SMTP id
 l7-20020ac24a87000000b004e8502eb32bmr5292588lfp.68.1682496521478; Wed, 26 Apr
 2023 01:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230426052153epcms2p27d64a865f15bfd452d564f77d63605db@epcms2p2>
 <20230426052153epcms2p27d64a865f15bfd452d564f77d63605db@epcms2p2>
In-Reply-To: <20230426052153epcms2p27d64a865f15bfd452d564f77d63605db@epcms2p2>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Wed, 26 Apr 2023 16:08:29 +0800
Message-ID: <CAGaU9a-Rm8nsFxo2Qt9vRGqqnOis6PLXNkD4PL9WZrfLCL_fqA@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: core: Simplify param_set_mcq_mode()
To:     keosung.park@samsung.com
Cc:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Keoseong Park <keosung.park@samsung.com> =E6=96=BC 2023=E5=B9=B44=E6=9C=882=
6=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=881:26=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> This function does not require the "ret" variable because it returns
> only the result of param_set_bool().
>
> Remove unnecessary "ret" variable and simplify the code.
>
> Signed-off-by: Keoseong Park <keosung.park@samsung.com>
> ---
>  drivers/ufs/core/ufshcd.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
