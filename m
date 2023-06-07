Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41007252D0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 06:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjFGE0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 00:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjFGEZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 00:25:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BB81BFA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 21:22:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-65131e85be4so6946081b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 21:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686111753; x=1688703753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuclnzYeNveopGINoAYYFBKbv8upkWfI9n54Jz9FA3Q=;
        b=MT5UmRoJBF3lq0pWUJihfyi9mcRfA7Y3hLZgsLBPL+haXWFIt4sRngCYFjmHHww4cl
         eF0eIcxgI1qx5msJlenrk6AZZ+qDiApbD5ZJkjB5hP8T7wFTXP3jPbqONVQ19hodaR9p
         ObAKQEReARCyBv2wrwk/sX7VDeHssFUPIi8og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686111753; x=1688703753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HuclnzYeNveopGINoAYYFBKbv8upkWfI9n54Jz9FA3Q=;
        b=H9md11RFc9QygD0dx0NofgF0NqednqyQfWmvy40dJIbQnDTosLYAzW0w07Fk7uO50f
         2T8IRutdmASWgZrlTdcYw48lczF6/tcNAR2RkscC7pX/KfrLCkiU6RYdGGN33g8BIZ0A
         OFyRt2XPTNEXCEutvXXiM2r1UARZ6RC4yE5m20dJgY1OKT/57gxkvPoXJBMvY8ck/E51
         a6QuDZ2+V6tPTRlOtdVG72RjHDcIhwHxptH6d2gVG9UNTJFNhMjdD/CCDIClYMyDsBc4
         TTEsTt3urIWxAeV6li9rIbJqaf0GQSatk99+rxqWUvx/ufYqte8XaIhvmVS2lNKpEEzg
         51fg==
X-Gm-Message-State: AC+VfDxoJ9/jRjvPikvmM7RqQaYTmW7l8vUX23Am4M3/GnPdlewRFKBw
        VRdwvxjNuSZu2DJO1Z567qmyy5qX4EvkZUCswxWi6g==
X-Google-Smtp-Source: ACHHUZ4cnQdEjmOHnSTk6muDwbqSFSEL7omJhdbt0TnPfxs6VB7FY8d4muiwcgdJLfqKoxjimMXfBg==
X-Received: by 2002:a05:6a00:1794:b0:64d:632a:d0ac with SMTP id s20-20020a056a00179400b0064d632ad0acmr5640665pfg.25.1686111752893;
        Tue, 06 Jun 2023 21:22:32 -0700 (PDT)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com. [209.85.210.175])
        by smtp.gmail.com with ESMTPSA id e16-20020aa78c50000000b0064d5b82f987sm7679244pfd.140.2023.06.06.21.22.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 21:22:32 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-65131e85be4so6946074b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 21:22:32 -0700 (PDT)
X-Received: by 2002:a1f:6d81:0:b0:457:134a:50ef with SMTP id
 i123-20020a1f6d81000000b00457134a50efmr1490189vkc.0.1686111413362; Tue, 06
 Jun 2023 21:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230525014009.23345-1-yunfei.dong@mediatek.com>
 <20230525014009.23345-2-yunfei.dong@mediatek.com> <b32b82f5-8555-39cf-9311-017a42b24e66@collabora.com>
In-Reply-To: <b32b82f5-8555-39cf-9311-017a42b24e66@collabora.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Wed, 7 Jun 2023 12:16:17 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhM26=2FTtVjVvo6d0aWqo+KVa1s9=8xHL1VgYSqkuDvQ@mail.gmail.com>
Message-ID: <CAC=S1nhM26=2FTtVjVvo6d0aWqo+KVa1s9=8xHL1VgYSqkuDvQ@mail.gmail.com>
Subject: Re: [PATCH v4,1/4] media: mediatek: vcodec: Avoid unneeded error logging
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 4:11=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 25/05/23 03:40, Yunfei Dong ha scritto:
> > Since the LAT decoder works faster than its CORE, getting the trans
> > buffer may be done only after CORE finishes processing: avoid printing
> > an error if the decode function returns -EAGAIN, as this means that
> > the buffer from CORE is not yet available, but will be at a later time.
> >
> > Also change the log level for calls to vdec_msg_queue_dqbuf() in H264
> > and VP9 LAT decoder drivers to avoid excessive logging.
> >
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>
