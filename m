Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF52728D10
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbjFIB03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237202AbjFIB01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:26:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B3118D;
        Thu,  8 Jun 2023 18:26:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4274652A1;
        Fri,  9 Jun 2023 01:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7C9C433D2;
        Fri,  9 Jun 2023 01:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686273985;
        bh=E7gyExAS/cvAO86R38JnW3fPXw6PrElO9fuzvoxsGrI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b1TGJDBKjjaKzVb5VkI/RqFFp5unE0RwXjKSIh/y5Dd7VVYOeB3g2Pzm9keHpfxw2
         8LVXpDYF3f9ytf8sDrfQYGP0W2N8FY1WaesZodif0X8O7gpHQt+Qq2V5ceZy5evL1r
         ZaBQVlLM14rcpc05xs/HAYeU4aNoA2QWJJbJTGImNannxVgptl78Wg200rh4tU9sUn
         vdcyLKR5AZPS7a9JxvqQ/+rqKhSTE82HjwtlUDNBZglPaeX99AQmLiejJEuqWlX0zq
         ifjehDh8A1FSlA+OQpc3ny93wsAU99EgboOmoIn3YCSaGdiaCC9X0xqrbg8M527wle
         JgWx40zAW/rOw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b1a7e31dcaso12650231fa.2;
        Thu, 08 Jun 2023 18:26:24 -0700 (PDT)
X-Gm-Message-State: AC+VfDzVpDViSVWEFuksAYY2KlBxIWVZQC7U+95QnOKmH6oPzrBcqWHu
        AUgZ1TWFm8DQLXrslTqZnQpossb9Mhc4CjQ6pQ==
X-Google-Smtp-Source: ACHHUZ4mbK7KCcvAS0lPnKAml65uyt9/S78fuLQ0/7LsylehrisF58SyKHzaBYI1C/QCxQzlV8h4rdqIkKPefp8EpJk=
X-Received: by 2002:a2e:988b:0:b0:2a8:c858:fb9 with SMTP id
 b11-20020a2e988b000000b002a8c8580fb9mr133316ljj.29.1686273982942; Thu, 08 Jun
 2023 18:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230607061121.6732-1-shawn.sung@mediatek.com> <20230607061121.6732-5-shawn.sung@mediatek.com>
In-Reply-To: <20230607061121.6732-5-shawn.sung@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 9 Jun 2023 09:26:11 +0800
X-Gmail-Original-Message-ID: <CAAOTY__5QhR7o3N-+vXjrC0bX=F6ABSGPyB-zowbHw5SJiZLfg@mail.gmail.com>
Message-ID: <CAAOTY__5QhR7o3N-+vXjrC0bX=F6ABSGPyB-zowbHw5SJiZLfg@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] drm/mediatek: mt8188: Modify display driver for VDOSYS1
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Fei Shao <fshao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsiao-chien:

Hsiao Chien Sung <shawn.sung@mediatek.com> =E6=96=BC 2023=E5=B9=B46=E6=9C=
=887=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=882:11=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> - Modify MUTEX and component preparation logic for better compatibility
> - Adjust display module probe sequence to avoid probe deferral
>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_merge.c     |   3 +-
>  .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 100 ++++++++++--------
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  28 ++++-
>  drivers/gpu/drm/mediatek/mtk_ethdr.c          |   1 +
>  drivers/gpu/drm/mediatek/mtk_mdp_rdma.c       |   1 +
>  5 files changed, 84 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_merge.c b/drivers/gpu/drm/=
mediatek/mtk_disp_merge.c
> index 6428b6203ffe..2a30e41c246f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_merge.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
> @@ -104,7 +104,7 @@ void mtk_merge_stop_cmdq(struct device *dev, struct c=
mdq_pkt *cmdq_pkt)
>         mtk_ddp_write(cmdq_pkt, 0, &priv->cmdq_reg, priv->regs,
>                       DISP_REG_MERGE_CTRL);
>
> -       if (priv->async_clk)
> +       if (!cmdq_pkt && priv->async_clk)

This is related to neither preparation logic nor probe sequence,
separate this to another patch.

>                 reset_control_reset(priv->reset_ctl);
>  }
>
> @@ -303,6 +303,7 @@ static int mtk_disp_merge_remove(struct platform_devi=
ce *pdev)
>  }
>
>  static const struct of_device_id mtk_disp_merge_driver_dt_match[] =3D {
> +       { .compatible =3D "mediatek,mt8188-disp-merge", },

This is related to neither preparation logic nor probe sequence,
separate this to another patch.

>         { .compatible =3D "mediatek,mt8195-disp-merge", },
>         {},
>  };
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gp=
u/drm/mediatek/mtk_disp_ovl_adaptor.c
> index c0a38f5217ee..e1d8d4765af8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> @@ -51,6 +51,7 @@ enum mtk_ovl_adaptor_comp_id {
>
>  struct ovl_adaptor_comp_match {
>         enum mtk_ovl_adaptor_comp_type type;
> +       enum mtk_ddp_comp_id comp_id;
>         int alias_id;
>  };
>
> @@ -67,19 +68,19 @@ static const char * const private_comp_stem[OVL_ADAPT=
OR_TYPE_NUM] =3D {
>  };
>
>  static const struct ovl_adaptor_comp_match comp_matches[OVL_ADAPTOR_ID_M=
AX] =3D {
> -       [OVL_ADAPTOR_MDP_RDMA0] =3D { OVL_ADAPTOR_TYPE_RDMA, 0 },
> -       [OVL_ADAPTOR_MDP_RDMA1] =3D { OVL_ADAPTOR_TYPE_RDMA, 1 },
> -       [OVL_ADAPTOR_MDP_RDMA2] =3D { OVL_ADAPTOR_TYPE_RDMA, 2 },
> -       [OVL_ADAPTOR_MDP_RDMA3] =3D { OVL_ADAPTOR_TYPE_RDMA, 3 },
> -       [OVL_ADAPTOR_MDP_RDMA4] =3D { OVL_ADAPTOR_TYPE_RDMA, 4 },
> -       [OVL_ADAPTOR_MDP_RDMA5] =3D { OVL_ADAPTOR_TYPE_RDMA, 5 },
> -       [OVL_ADAPTOR_MDP_RDMA6] =3D { OVL_ADAPTOR_TYPE_RDMA, 6 },
> -       [OVL_ADAPTOR_MDP_RDMA7] =3D { OVL_ADAPTOR_TYPE_RDMA, 7 },
> -       [OVL_ADAPTOR_MERGE0]    =3D { OVL_ADAPTOR_TYPE_MERGE, 1 },
> -       [OVL_ADAPTOR_MERGE1]    =3D { OVL_ADAPTOR_TYPE_MERGE, 2 },
> -       [OVL_ADAPTOR_MERGE2]    =3D { OVL_ADAPTOR_TYPE_MERGE, 3 },
> -       [OVL_ADAPTOR_MERGE3]    =3D { OVL_ADAPTOR_TYPE_MERGE, 4 },
> -       [OVL_ADAPTOR_ETHDR0]    =3D { OVL_ADAPTOR_TYPE_ETHDR, 0 },
> +       [OVL_ADAPTOR_MDP_RDMA0] =3D { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONEN=
T_MDP_RDMA0, 0 },
> +       [OVL_ADAPTOR_MDP_RDMA1] =3D { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONEN=
T_MDP_RDMA1, 1 },
> +       [OVL_ADAPTOR_MDP_RDMA2] =3D { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONEN=
T_MDP_RDMA2, 2 },
> +       [OVL_ADAPTOR_MDP_RDMA3] =3D { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONEN=
T_MDP_RDMA3, 3 },
> +       [OVL_ADAPTOR_MDP_RDMA4] =3D { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONEN=
T_MDP_RDMA4, 4 },
> +       [OVL_ADAPTOR_MDP_RDMA5] =3D { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONEN=
T_MDP_RDMA5, 5 },
> +       [OVL_ADAPTOR_MDP_RDMA6] =3D { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONEN=
T_MDP_RDMA6, 6 },
> +       [OVL_ADAPTOR_MDP_RDMA7] =3D { OVL_ADAPTOR_TYPE_RDMA, DDP_COMPONEN=
T_MDP_RDMA7, 7 },
> +       [OVL_ADAPTOR_MERGE0] =3D { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_=
MERGE1, 1 },
> +       [OVL_ADAPTOR_MERGE1] =3D { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_=
MERGE2, 2 },
> +       [OVL_ADAPTOR_MERGE2] =3D { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_=
MERGE3, 3 },
> +       [OVL_ADAPTOR_MERGE3] =3D { OVL_ADAPTOR_TYPE_MERGE, DDP_COMPONENT_=
MERGE4, 4 },
> +       [OVL_ADAPTOR_ETHDR0] =3D { OVL_ADAPTOR_TYPE_ETHDR, DDP_COMPONENT_=
ETHDR_MIXER, 0 },
>  };
>
>  void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
> @@ -192,6 +193,8 @@ int mtk_ovl_adaptor_clk_enable(struct device *dev)
>
>         for (i =3D 0; i < OVL_ADAPTOR_MERGE0; i++) {
>                 comp =3D ovl_adaptor->ovl_adaptor_comp[i];
> +               if (!comp)
> +                       continue;
>                 ret =3D pm_runtime_get_sync(comp);
>                 if (ret < 0) {
>                         dev_err(dev, "Failed to enable power domain %d, e=
rr %d\n", i, ret);
> @@ -201,7 +204,8 @@ int mtk_ovl_adaptor_clk_enable(struct device *dev)
>
>         for (i =3D 0; i < OVL_ADAPTOR_ID_MAX; i++) {
>                 comp =3D ovl_adaptor->ovl_adaptor_comp[i];
> -
> +               if (!comp)
> +                       continue;
>                 if (i < OVL_ADAPTOR_MERGE0)
>                         ret =3D mtk_mdp_rdma_clk_enable(comp);
>                 else if (i < OVL_ADAPTOR_ETHDR0)
> @@ -219,6 +223,8 @@ int mtk_ovl_adaptor_clk_enable(struct device *dev)
>  clk_err:
>         while (--i >=3D 0) {
>                 comp =3D ovl_adaptor->ovl_adaptor_comp[i];
> +               if (!comp)
> +                       continue;
>                 if (i < OVL_ADAPTOR_MERGE0)
>                         mtk_mdp_rdma_clk_disable(comp);
>                 else if (i < OVL_ADAPTOR_ETHDR0)
> @@ -229,8 +235,12 @@ int mtk_ovl_adaptor_clk_enable(struct device *dev)
>         i =3D OVL_ADAPTOR_MERGE0;
>
>  pwr_err:
> -       while (--i >=3D 0)
> -               pm_runtime_put(ovl_adaptor->ovl_adaptor_comp[i]);
> +       while (--i >=3D 0) {
> +               comp =3D ovl_adaptor->ovl_adaptor_comp[i];
> +               if (!comp)
> +                       continue;
> +               pm_runtime_put(comp);
> +       }
>
>         return ret;
>  }
> @@ -243,7 +253,8 @@ void mtk_ovl_adaptor_clk_disable(struct device *dev)
>
>         for (i =3D 0; i < OVL_ADAPTOR_ID_MAX; i++) {
>                 comp =3D ovl_adaptor->ovl_adaptor_comp[i];
> -
> +               if (!comp)
> +                       continue;
>                 if (i < OVL_ADAPTOR_MERGE0) {
>                         mtk_mdp_rdma_clk_disable(comp);
>                         pm_runtime_put(comp);
> @@ -313,36 +324,26 @@ size_t mtk_ovl_adaptor_get_num_formats(struct devic=
e *dev)
>
>  void mtk_ovl_adaptor_add_comp(struct device *dev, struct mtk_mutex *mute=
x)
>  {
> -       mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA0);
> -       mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA1);
> -       mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA2);
> -       mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA3);
> -       mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA4);
> -       mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA5);
> -       mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA6);
> -       mtk_mutex_add_comp(mutex, DDP_COMPONENT_MDP_RDMA7);
> -       mtk_mutex_add_comp(mutex, DDP_COMPONENT_MERGE1);
> -       mtk_mutex_add_comp(mutex, DDP_COMPONENT_MERGE2);
> -       mtk_mutex_add_comp(mutex, DDP_COMPONENT_MERGE3);
> -       mtk_mutex_add_comp(mutex, DDP_COMPONENT_MERGE4);
> -       mtk_mutex_add_comp(mutex, DDP_COMPONENT_ETHDR_MIXER);
> +       struct mtk_disp_ovl_adaptor *ovl_adaptor =3D dev_get_drvdata(dev)=
;
> +       int i;
> +
> +       for (i =3D 0; i < OVL_ADAPTOR_ID_MAX; i++) {
> +               if (!ovl_adaptor->ovl_adaptor_comp[i])
> +                       continue;
> +               mtk_mutex_add_comp(mutex, comp_matches[i].comp_id);
> +       }
>  }
>
>  void mtk_ovl_adaptor_remove_comp(struct device *dev, struct mtk_mutex *m=
utex)
>  {
> -       mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA0);
> -       mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA1);
> -       mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA2);
> -       mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA3);
> -       mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA4);
> -       mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA5);
> -       mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA6);
> -       mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MDP_RDMA7);
> -       mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MERGE1);
> -       mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MERGE2);
> -       mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MERGE3);
> -       mtk_mutex_remove_comp(mutex, DDP_COMPONENT_MERGE4);
> -       mtk_mutex_remove_comp(mutex, DDP_COMPONENT_ETHDR_MIXER);
> +       struct mtk_disp_ovl_adaptor *ovl_adaptor =3D dev_get_drvdata(dev)=
;
> +       int i;
> +
> +       for (i =3D 0; i < OVL_ADAPTOR_ID_MAX; i++) {
> +               if (!ovl_adaptor->ovl_adaptor_comp[i])
> +                       continue;
> +               mtk_mutex_remove_comp(mutex, comp_matches[i].comp_id);
> +       }
>  }
>
>  void mtk_ovl_adaptor_connect(struct device *dev, struct device *mmsys_de=
v, unsigned int next)
> @@ -386,6 +387,15 @@ static int ovl_adaptor_comp_get_id(struct device *de=
v, struct device_node *node,
>
>  static const struct of_device_id mtk_ovl_adaptor_comp_dt_ids[] =3D {
>         {
> +               .compatible =3D "mediatek,mt8188-vdo1-rdma",
> +               .data =3D (void *)OVL_ADAPTOR_TYPE_RDMA,
> +       }, {
> +               .compatible =3D "mediatek,mt8188-disp-merge",
> +               .data =3D (void *)OVL_ADAPTOR_TYPE_MERGE,
> +       }, {
> +               .compatible =3D "mediatek,mt8188-disp-ethdr",
> +               .data =3D (void *)OVL_ADAPTOR_TYPE_ETHDR,
> +       }, {

This is related to neither preparation logic nor probe sequence,
separate this to another patch.

>                 .compatible =3D "mediatek,mt8195-vdo1-rdma",
>                 .data =3D (void *)OVL_ADAPTOR_TYPE_RDMA,
>         }, {
> @@ -466,6 +476,9 @@ static int mtk_disp_ovl_adaptor_comp_bind(struct devi=
ce *dev, struct device *mas
>  static void mtk_disp_ovl_adaptor_comp_unbind(struct device *dev, struct =
device *master,
>                                              void *data)
>  {
> +       struct mtk_disp_ovl_adaptor *priv =3D dev_get_drvdata(dev);
> +
> +       priv->children_bound =3D false;
>  }
>
>  static const struct component_ops mtk_disp_ovl_adaptor_comp_ops =3D {
> @@ -483,6 +496,7 @@ static int mtk_disp_ovl_adaptor_master_bind(struct de=
vice *dev)
>                 return dev_err_probe(dev, ret, "component_bind_all failed=
!\n");
>
>         priv->children_bound =3D true;
> +

This is related to neither preparation logic nor probe sequence,
separate this to another patch.

>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 6dcb4ba2466c..87dadd129c22 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -188,6 +188,12 @@ static const unsigned int mt8188_mtk_ddp_main[] =3D =
{
>         DDP_COMPONENT_DP_INTF0,
>  };
>
> +static const unsigned int mt8188_mtk_ddp_ext[] =3D {
> +       DDP_COMPONENT_DRM_OVL_ADAPTOR,
> +       DDP_COMPONENT_MERGE5,
> +       DDP_COMPONENT_DP_INTF1,
> +};
> +
>  static const unsigned int mt8192_mtk_ddp_main[] =3D {
>         DDP_COMPONENT_OVL0,
>         DDP_COMPONENT_OVL_2L0,
> @@ -287,6 +293,14 @@ static const struct mtk_mmsys_driver_data mt8186_mms=
ys_driver_data =3D {
>  static const struct mtk_mmsys_driver_data mt8188_vdosys0_driver_data =3D=
 {
>         .main_path =3D mt8188_mtk_ddp_main,
>         .main_len =3D ARRAY_SIZE(mt8188_mtk_ddp_main),
> +       .mmsys_dev_num =3D 2,
> +};
> +
> +static const struct mtk_mmsys_driver_data mt8188_vdosys1_driver_data =3D=
 {
> +       .ext_path =3D mt8188_mtk_ddp_ext,
> +       .ext_len =3D ARRAY_SIZE(mt8188_mtk_ddp_ext),
> +       .mmsys_id =3D 1,
> +       .mmsys_dev_num =3D 2,

This is related to neither preparation logic nor probe sequence,
separate this to another patch.

>  };
>
>  static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data =3D {
> @@ -327,6 +341,8 @@ static const struct of_device_id mtk_drm_of_ids[] =3D=
 {
>           .data =3D &mt8186_mmsys_driver_data},
>         { .compatible =3D "mediatek,mt8188-vdosys0",
>           .data =3D &mt8188_vdosys0_driver_data},
> +       { .compatible =3D "mediatek,mt8188-vdosys1",
> +         .data =3D &mt8188_vdosys1_driver_data},

This is related to neither preparation logic nor probe sequence,
separate this to another patch.

>         { .compatible =3D "mediatek,mt8192-mmsys",
>           .data =3D &mt8192_mmsys_driver_data},
>         { .compatible =3D "mediatek,mt8195-mmsys",
> @@ -682,6 +698,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[=
] =3D {
>           .data =3D (void *)MTK_DISP_GAMMA, },
>         { .compatible =3D "mediatek,mt8183-disp-gamma",
>           .data =3D (void *)MTK_DISP_GAMMA, },
> +       { .compatible =3D "mediatek,mt8188-disp-merge",
> +         .data =3D (void *)MTK_DISP_MERGE },

This is related to neither preparation logic nor probe sequence,
separate this to another patch.

>         { .compatible =3D "mediatek,mt8195-disp-merge",
>           .data =3D (void *)MTK_DISP_MERGE },
>         { .compatible =3D "mediatek,mt2701-disp-mutex",
> @@ -965,15 +983,15 @@ static struct platform_driver * const mtk_drm_drive=
rs[] =3D {
>         &mtk_disp_ccorr_driver,
>         &mtk_disp_color_driver,
>         &mtk_disp_gamma_driver,
> +       &mtk_disp_rdma_driver,
> +       &mtk_mdp_rdma_driver,
>         &mtk_disp_merge_driver,
> -       &mtk_disp_ovl_adaptor_driver,
> +       &mtk_ethdr_driver,
>         &mtk_disp_ovl_driver,
> -       &mtk_disp_rdma_driver,
> +       &mtk_disp_ovl_adaptor_driver,
> +       &mtk_dsi_driver,
>         &mtk_dpi_driver,
>         &mtk_drm_platform_driver,
> -       &mtk_dsi_driver,
> -       &mtk_ethdr_driver,
> -       &mtk_mdp_rdma_driver,

Why change the order?

>  };
>
>  static int __init mtk_drm_init(void)
> diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/media=
tek/mtk_ethdr.c
> index 73dc4da3ba3b..b5a6b67f2db9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
> +++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
> @@ -353,6 +353,7 @@ static int mtk_ethdr_remove(struct platform_device *p=
dev)
>  }
>
>  static const struct of_device_id mtk_ethdr_driver_dt_match[] =3D {
> +       { .compatible =3D "mediatek,mt8188-disp-ethdr"},

This is related to neither preparation logic nor probe sequence,
separate this to another patch.

>         { .compatible =3D "mediatek,mt8195-disp-ethdr"},
>         {},
>  };
> diff --git a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c b/drivers/gpu/drm/me=
diatek/mtk_mdp_rdma.c
> index e06db6e56b5f..06d5c9abb515 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
> @@ -323,6 +323,7 @@ static int mtk_mdp_rdma_remove(struct platform_device=
 *pdev)
>  }
>
>  static const struct of_device_id mtk_mdp_rdma_driver_dt_match[] =3D {
> +       { .compatible =3D "mediatek,mt8188-vdo1-rdma", },

This is related to neither preparation logic nor probe sequence,
separate this to another patch.

Regards,
Chun-Kuang.

>         { .compatible =3D "mediatek,mt8195-vdo1-rdma", },
>         {},
>  };
> --
> 2.18.0
>
