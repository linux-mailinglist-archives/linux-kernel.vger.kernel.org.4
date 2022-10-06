Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AC35F69E4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJFOoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiJFOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:44:04 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3A2AE20F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:44:02 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id 13so5110561ejn.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OyDpyBgQV47YB+266Ki7DI96CjddGq1pfZPclx12xOw=;
        b=aKf7WhdU+FEtwlX5DJmHKTimmxWRzabCaDnXalwl281hYJgcc09YH0IzOwSHp2/Zs7
         RtdxuTRudXaZueoK2fYmS5Hv/CqTw73NioV/pU1PDRdLJqB5SMtbElLp/lQAR56AIm/+
         6lrslo+hGCzqeNqlHU3cTyU5tZ+E0mGS3BhAVXReKEt8dVJJZ6Us6VO8byQesuChs8/q
         6Oa29HAjUG/75Ok/Xrqj8bOB2ejTpRq5og7ye/gu23X7XCV5FtMtcl2gmESt0Tdj3LVV
         0Xz8X+c+p90d/bZQnz/DyvJmvfBIWuDfDD7EQ9JpYDJYa03K8CdpukywAtArm6oo2rt8
         5kLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyDpyBgQV47YB+266Ki7DI96CjddGq1pfZPclx12xOw=;
        b=TFnkDvM22HlmVnqIElwXwBcVi/TwIxZ1/Fmn3LAvuLFrGMm3sYcke71gx0nS5R6F1R
         Yn9zi1quqT9lRl42MY/OsQsmRCAg2Z4agD9caiAywcwkDk+VETbvYyiiVB3NvwLzLHM3
         iwKEK6KJsjcN19aqMxhLTFtP9W3VKa/g5SO5qbKiDjQPTWhiKZS1LhxJB/cbvDu89YdV
         GX6syUVRfGCNDsFqnJKa6ttV20TV/3gts+/JLX6tbjpxnKiK4ko0H8cpyo+ejAFwt0mg
         VjNZbX4Fd54TjBnFDIOukJ61HvMFYU7RJxC68c+2wAp4a4+7RizqvdvbzEzbcLdHSOrh
         YNIg==
X-Gm-Message-State: ACrzQf2MODxsGR3F8K09f0UiPXzjdFrsMIrfs7IJ/8V61nwXI24ahqYi
        mQwE8QZoWDbk67HV0wyZfFsY3ipFDI0M07PUvMA004eK
X-Google-Smtp-Source: AMsMyM5Y7NcUG/exewc3InWkGudL7EukyL+tDPK9wIGRuqO+9a91trYlsZUK2u+iC5VwGaD2DkjO20ddrC30cYOTWbI=
X-Received: by 2002:a17:906:6a13:b0:78c:71c0:e615 with SMTP id
 qw19-20020a1709066a1300b0078c71c0e615mr127498ejc.363.1665067441137; Thu, 06
 Oct 2022 07:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220919030136.1055409-1-peng.fan@oss.nxp.com> <DU0PR04MB9417E587ED9439309510B34A885C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417E587ED9439309510B34A885C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 6 Oct 2022 09:43:49 -0500
Message-ID: <CABb+yY2umT5J_saASjXEnE9y56=XDHhfGARCwboiKK35pNZbfg@mail.gmail.com>
Subject: Re: [PATCH V2] mailbox: imx: fix RST channel support
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ying Liu <victor.liu@nxp.com>
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

On Thu, Oct 6, 2022 at 5:44 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Jassi,
>
> > Subject: [PATCH V2] mailbox: imx: fix RST channel support
>
> Would you pick this patch?
>
Already queued yesterday.

cheers.
