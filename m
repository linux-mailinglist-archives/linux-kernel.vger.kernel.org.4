Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B4F6F07F5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbjD0PLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243558AbjD0PLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:11:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD9C2726
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53B1763BED
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 15:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0364C433D2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 15:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682608268;
        bh=l6laNL5+185Lj5BlHWSsODPn1E0DbC9F8Y6d9W1UyDo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c7NNP4wfVjJFXqpVRwA0XeibAdJY77QyeZGs8xSxQzCBbSJHlzrR+NrSxlg4Ky9uX
         RvMD+KeIWgrALoNz9mkmozZMW5cRhiCa/Uja3HxUgPEUcIcoSIjk08zrv9hIm4CUn2
         eL+GD2PWs3zIin4Z/O4jEaSu8NuoNBYTdDGPMbDFEm0mx0CnmMOKWx/OrNbpMFTit1
         R3WdRWcaC6sVxRu5Noi3C+QtoG1PEOo2ak3kzHXxcR7ETm9OX7VIQziQ/ZxztxI5N2
         PD722DVNMAaiTZ/XfCQNRJ/pFrIaUNYWj/Epnvh2KfbmkU6S6ANH6BYCm+Cq810y5s
         jgYBSRmn6Ttkg==
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5208be24dcbso6469834a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:11:08 -0700 (PDT)
X-Gm-Message-State: AC+VfDylU6ErWgrqJNZVRUSsQyNC1A1U7jZjt92jKS0rzipgpnOWcMBQ
        Gy0SmAjSl6ivOa9AmhcfsVqSAMi3BQOhLcb+So8AVg==
X-Google-Smtp-Source: ACHHUZ5NxyJDUO4FTy/bs7agRCtWpiWaSIyWZoCCTaOxbDS+Kd/2JIfrEGWJsq3KErFabBaP4K4k3JalnBiKfr02Gio=
X-Received: by 2002:a17:90a:f481:b0:23d:bbcb:c97f with SMTP id
 bx1-20020a17090af48100b0023dbbcbc97fmr2267524pjb.1.1682608268270; Thu, 27 Apr
 2023 08:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de> <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <14636275-4d26-d639-5f6e-293fc6d1c4c6@web.de> <CAN6tsi7caOQZLLvbL7phMEtNvBLaWgJuHLkLo3YWdqQw7Vxnaw@mail.gmail.com>
 <6f758653-36c9-91a2-7bbc-278ae3f8ccee@web.de>
In-Reply-To: <6f758653-36c9-91a2-7bbc-278ae3f8ccee@web.de>
From:   Robert Foss <rfoss@kernel.org>
Date:   Thu, 27 Apr 2023 17:10:57 +0200
X-Gmail-Original-Message-ID: <CAN6tsi4WBDOyzvXJ8vV=xJYay1JbBGo+UzZ+vudTBm5Fk5nB=A@mail.gmail.com>
Message-ID: <CAN6tsi4WBDOyzvXJ8vV=xJYay1JbBGo+UzZ+vudTBm5Fk5nB=A@mail.gmail.com>
Subject: Re: drm/bridge: it6505: Move a variable assignment behind a null
 pointer check in receive_timing_debugfs_show()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Allen Chen <allen.chen@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        Hsin-yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 4:16=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > This patch seems to be a part of a series without being marked as such,
>
> The mentioned patch affects only a single function implementation.
>
>
> > this causes issues when importing this patch with maintainer tools
> > like b4 which automatically pull in the entire series and not
> > just the specific patch.
>
> It is a pity that there are special technical difficulties.
>
>
> > Either label the patch as being part of a series ( [PATCH 1/XX] ),
>
> Further software modules were similarly affected.
>
> See also:
> Reconsidering pointer dereferences before null pointer checks (with SmPL)
> https://lore.kernel.org/cocci/1a11455f-ab57-dce0-1677-6beb8492a257@web.de=
/
> https://sympa.inria.fr/sympa/arc/cocci/2023-04/msg00021.html
>
>
> > or submit it separately.
>
> I thought that I did that (in principle).

You can have a look at LKML for the email message-id to see the whole
thread of patches.
https://lore.kernel.org/all/14636275-4d26-d639-5f6e-293fc6d1c4c6@web.de/#r

Or https://lore.kernel.org/all/$MSG_ID

Fix the email Sign-off email !=3D Sender email issue, resubmit and I'll
be able to apply this.
