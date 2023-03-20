Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153F26C2554
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCTXCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCTXCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:02:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C582D2A998;
        Mon, 20 Mar 2023 16:02:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w4so6066768plg.9;
        Mon, 20 Mar 2023 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679353334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQTnX0bMfKbYGJwMixkUOT6RG4X+okEUFeKSoqg7iTo=;
        b=c9FZ2V3ReMf/oMa6/BuHFlFCRR4IRu2XhLE8LdXnMuS4CmtPf6MoQdJf2e+pPee72B
         p9yZTdfvqUO2Rx9OJEjQ6QCGdWrhueWbl1zEiZD43rYbMCnDB8VdffX+89rRtAxKx2nE
         z2vrZ9UVMMqVipvOvme5XzqfocLlq/hEXSNvOm2f4Gx1xY919xqJILpyGnxqomabPhmi
         6qXbNpEiwR/onTQ8rHezcIlHMdQ5Dj4IlserMqyc5/9Wjtg8pVCoyfluDqFm9P8pR4hP
         1flLyjyFxp8dgChxehMX77r0a8KPEGa6UR1wP8fRHFwMjjcx2jiZFZq+hrK9NH7t307M
         QxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679353334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQTnX0bMfKbYGJwMixkUOT6RG4X+okEUFeKSoqg7iTo=;
        b=dNI6vmF+R4ydgnSt3GJlH50pOZBdQFm3PnK4GCI4lDLY7cd1iDC8/HiWy9VJm1h+Os
         W2SLem199n4bSB37QEqt2FkijsQ8i9pyF298RRHlVDR0N7QhmtuW4OgIXpIpBGCNdpi/
         fPlzbelBlKDDqPgVYb0a4WVSvdP59eZ2cO0Fp+QTX4hhb3lfBhJudqoN7+p8OxUglGq7
         9LSimM1y5y1Wj6XNMH3xXyHIypxaILgEh+R+y1Z2wuC9kE8Z/PRRZx3LZpCyfc1/7c2g
         jtgIzHiUt8Q1jsHHwUG+5NBkHcx/fy2Gkn8qmtK+iUPyJgirMpqWcIKjOTw+uC48yplU
         SzyA==
X-Gm-Message-State: AO0yUKVlELvGbne10DlP6ufSFESpXMOtC5hxWJNNzLVmIHuhPYlU/OkO
        SQjSxhv5sBDH34YpPKO7FOqMYXgyslZUxspnPos=
X-Google-Smtp-Source: AK7set/2NdZhhmQO5d6e9xSkCffYHJdBbggPTveFkSs06tcd9zy4WRFcK2Gmk3YxchcdNwrKviVCcWEkAKuzyKT8e1g=
X-Received: by 2002:a17:90a:6082:b0:23b:36cc:f347 with SMTP id
 z2-20020a17090a608200b0023b36ccf347mr82605pji.9.1679353333727; Mon, 20 Mar
 2023 16:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230320221826.2728078-1-mathieu.poirier@linaro.org> <20230320221826.2728078-6-mathieu.poirier@linaro.org>
In-Reply-To: <20230320221826.2728078-6-mathieu.poirier@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 20 Mar 2023 20:02:04 -0300
Message-ID: <CAOMZO5Dh0mQEhjT2Wx_T9Kf9aTkNpJ7PbMfocQ24sh+yGtw+ww@mail.gmail.com>
Subject: Re: [PATCH 5/5] retmoteproc: imx_dsp_rproc: Call of_node_put() on
 iteration error
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     andersson@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com,
        patrice.chotard@foss.st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, arnaud.pouliquen@st.com,
        hongxing.zhu@nxp.com, peng.fan@nxp.com, shengjiu.wang@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Mon, Mar 20, 2023 at 7:18=E2=80=AFPM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Function of_phandle_iterator_next() calls of_node_put() on the last
> device_node it iterated over, but when the loop exits prematurely it has
> to be called explicitly.

Typo on the Subject: s/retmoteproc/remoteproc
