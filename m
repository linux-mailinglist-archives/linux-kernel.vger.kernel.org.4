Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220F366D753
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbjAQHz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbjAQHzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:55:22 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0BF24480;
        Mon, 16 Jan 2023 23:55:18 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hw16so61516467ejc.10;
        Mon, 16 Jan 2023 23:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Doys/SC0QOZ3upK94vMab3sn1eoA5ffBssidJQpR6WE=;
        b=T7vjsLXATy6+GqiZT3hsLButMHNBLRladrcF5/He5OPGnFCjvUiXtlLVxdY+dP7iWW
         hdkiuhaAaYo0QJZFRu1k6OoyFL6wLHV8LGBM2mGhlr9Iljzq792ZX2Rtxr0LeYNE2z+S
         7wEMFCxC5mNwH5rI+dVxhl3mJJEyTNHkUydVBnrCMPeS7GLQ1tYPnKnBZzj3ASUom26S
         aQwcHsr7MuzGbWyiCUhq9RYdpK1a+M5sM+WsZSIJQcVy5X1stM/STILqMb37S8hW2ngU
         O/3sOPeR1n+CsDp7jjqrRUKfbu5WQsTwa3DlB4VV1CP7r+rEH1lhs3m67s8kiiZBTmOQ
         TtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Doys/SC0QOZ3upK94vMab3sn1eoA5ffBssidJQpR6WE=;
        b=MOSiVSI3hRPexEkEWV9xT5muetD4T3NUmyJQjH1NB3h9XUqysKj6AgoMx+Veu3Mp4B
         1gI7q0wcM6I/0Q4VBpuYkkcJ20qCbdXM5+rNpi/ppU/4GaIBgK3FJlCH8BL7nuisZp1J
         12yFWmRspV/hzhkp8HB5iYHgHQRBV+F5CrE+/Vq+vWq2fgjgVdoWQUtMF88jsBFQwqNj
         VHXBBf9c7JnocklqTh0Uw9SGnv7+kKJXTfO4HRHwfsC/BrCZaVJGhi6uc6okHEqKQFbn
         SMnUMp/LnAcNsK6e0Dhj9JRQiPCLnZ9XITgrvNP7c0g91Fu1X3NbPRvRd7Gv0cgwv+bj
         0fkA==
X-Gm-Message-State: AFqh2kqhzO97heZcunE7uWYQTKvDxK3aGxUX3oYXWH5hcn+4u3it89e4
        L05ItuThH5cs+ulmb6ZLp4sl/0BYxPv1+zzixx4=
X-Google-Smtp-Source: AMrXdXtUspQBMKsdRawiO8iv21L66kOBo9o4QJxwo4y9amKrjl4eUvOXWL7oAQ8jT7OtiXFbPEJk/ALc+HxbDdpaNBA=
X-Received: by 2002:a17:906:ce36:b0:7c1:6f86:ec4 with SMTP id
 sd22-20020a170906ce3600b007c16f860ec4mr200821ejb.621.1673942116562; Mon, 16
 Jan 2023 23:55:16 -0800 (PST)
MIME-Version: 1.0
References: <2b4bc0b22fac32ab3a7262240019486804c1691f.1673806409.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <2b4bc0b22fac32ab3a7262240019486804c1691f.1673806409.git.christophe.jaillet@wanadoo.fr>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 17 Jan 2023 09:55:04 +0200
Message-ID: <CAEnQRZC=JNGixTRVDnEK0p5rZWuQbOmQvApTUM5=0iJN9pzVRw@mail.gmail.com>
Subject: Re: [PATCH] firmware: imx-dsp: Fix an error handling path in imx_dsp_setup_channels()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Paul Olaru <paul.olaru@nxp.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Sun, Jan 15, 2023 at 8:35 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If mbox_request_channel_byname() fails, the memory allocated a few lines
> above still need to be freed before going to the error handling path.
>
> Fixes: 046326989a18 ("firmware: imx: Save channel name for further use")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Good catch.

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
