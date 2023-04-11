Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7F26DCFEF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDKDDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjDKDDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:03:16 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AD630F0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:03:07 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5491fa028adso458185397b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681182186; x=1683774186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/ZlRoiu1wIxay9eSAG+82IQcuZBJKitlsbCIfhB1ls=;
        b=p23peQSBESFfKBX5qzUaFFuQlNCoNnYCcRzo4X01hLqp5yyb/EXyJ5tARG/xr3o47a
         lsw0uM1NYxVK8XD6kyiKMF2RZlz7LESjvR01hLARpXLbsNuumYzza0kNrcjRoqaFadt7
         Dlu7zl5WXscb2tsuZ3fYxy9yyNkoV4HVWEO85924Cg2p9fCjRx8D0MMpx8uL6hZKsCts
         LHP+LWP5N5cFtRMFNzij1IKncHGBrOvocZnOiixo87iJwkQYGFqIgpndRoTPzZ/SrxvM
         J8a9GINg+YQf4YnNYojwcF2xXyphK+m5MBSHRscMbmYBUDPQSXMvM8tk0TIZWHwhRYHL
         vO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681182186; x=1683774186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/ZlRoiu1wIxay9eSAG+82IQcuZBJKitlsbCIfhB1ls=;
        b=z1KabmcmvbhWAhagEePTCRKk+/04KtEEuflUM4fy0hpOWOSSuMLmLRjqjgGPNeW22v
         X6jou+3EdXktLyb0/lQ3TznEGE+bcifKlPnHArdl8r7yjyV+FibBt+7i8g0k8Vg+hKro
         4DqOVLK9mX3+UIkWy7PBYcU2pNJXKLCXpMQtD7QMwILOY51WasoiOJ+EpVdTMvSjMGvb
         oFzA2X6ZC/RpBGzfv3Jyalkidfj3LAqp8iDWQS/km/aTB7rt4jb4567JUT1GXRxNRZAQ
         fRG+YDTDF7ci1sqQFJgcWXy3ZObZTMqpf6tI5uTQdF48sPRhPNXEDn/FEbgn9atsiXdQ
         hSgg==
X-Gm-Message-State: AAQBX9elA0sCRmKVXretY5HvVBjCaAqgg2JhQQjDrU+M2uRAo+9d9EzW
        U/eLrXR+HT+uixVuEl2di4uT4j+BvIUJrkASbJMvZg==
X-Google-Smtp-Source: AKy350bGTe9O8VOwunq6lfwiyzTvnTDU4MVjsdYYrKAlp1XxALqKFbfbn4DnPg7sET9+7AXo84pBp+w0Qgzjnf7nl58=
X-Received: by 2002:a81:c509:0:b0:54c:2409:c306 with SMTP id
 k9-20020a81c509000000b0054c2409c306mr6819141ywi.6.1681182185494; Mon, 10 Apr
 2023 20:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230411003431.4048700-1-shraash@google.com>
In-Reply-To: <20230411003431.4048700-1-shraash@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 10 Apr 2023 20:02:54 -0700
Message-ID: <CABXOdTcDfy3oDVy6+FAg+jkqnCJABOq=VokWQ1q4QByKbo5UJQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: common: Fix refcount leak in parse_dai_link_info
To:     Aashish Sharma <shraash@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Guenter Roeck <groeck@chromium.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 5:34=E2=80=AFPM Aashish Sharma <shraash@google.com>=
 wrote:
>
> Add missing of_node_put()s before the returns to balance
> of_node_get()s and of_node_put()s, which may get unbalanced
> in case the for loop 'for_each_available_child_of_node' returns
> early.
>
> Fixes: 4302187d955f ("ASoC: mediatek: common: add soundcard driver common=
 code")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Link: https://lore.kernel.org/r/202304090504.2K8L6soj-lkp@intel.com/
> Signed-off-by: Aashish Sharma <shraash@google.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  sound/soc/mediatek/common/mtk-soundcard-driver.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.c b/sound/soc=
/mediatek/common/mtk-soundcard-driver.c
> index 7c55c2cb1f21..738093451ccb 100644
> --- a/sound/soc/mediatek/common/mtk-soundcard-driver.c
> +++ b/sound/soc/mediatek/common/mtk-soundcard-driver.c
> @@ -47,20 +47,26 @@ int parse_dai_link_info(struct snd_soc_card *card)
>         /* Loop over all the dai link sub nodes */
>         for_each_available_child_of_node(dev->of_node, sub_node) {
>                 if (of_property_read_string(sub_node, "link-name",
> -                                           &dai_link_name))
> +                                           &dai_link_name)) {
> +                       of_node_put(sub_node);
>                         return -EINVAL;
> +               }
>
>                 for_each_card_prelinks(card, i, dai_link) {
>                         if (!strcmp(dai_link_name, dai_link->name))
>                                 break;
>                 }
>
> -               if (i >=3D card->num_links)
> +               if (i >=3D card->num_links) {
> +                       of_node_put(sub_node);
>                         return -EINVAL;
> +               }
>
>                 ret =3D set_card_codec_info(card, sub_node, dai_link);
> -               if (ret < 0)
> +               if (ret < 0) {
> +                       of_node_put(sub_node);
>                         return ret;
> +               }
>         }
>
>         return 0;
> --
> 2.40.0.577.gac1e443424-goog
>
