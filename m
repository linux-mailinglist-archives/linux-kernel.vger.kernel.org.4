Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCF463FD5D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiLBAyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiLBAyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:54:18 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD990BE4EB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:54:16 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s8so5108400lfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 16:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7GP4pufhPVvfnoAh3ChG2xLHp0hP06BCc4j2QAJn5bg=;
        b=XH4vTBSn6vlWn5uLdcdBTvFIb4KLggNORtsYxSlUhcb9KJeST8Ojnl3Z0nfM9uyW45
         F3osR4K53DJzpU4X1LGZiZcXI8d0yJcDBg9oblineBQATUIVJ5O7gWQJAxKKNpDqpIZb
         ourzpz1ILyX2Dr6/fPNchtjvawXkImeXpl+4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GP4pufhPVvfnoAh3ChG2xLHp0hP06BCc4j2QAJn5bg=;
        b=vNcs3C/gZbTrU5JZNFAkRrHODbP8D2qYZpd80Z/NeHZJRxaRoM6HmsvmMlXtPftFr/
         yHxpgdV+w1iidNTjxgKZefeiOu2THbZIA4gEkDS1SdUitJU9j79ASOrkm9Pj9r8HEZnC
         GLjnfBnN2rkrQm0eiWB3okYUFyWpdpL9S62OkFVj0kTvOMJeJRzD9nRcSqvVniS8qlFr
         5AdndtBojUdMeeZg+VDXz8Hgc/4VwnaIlPHjO3TjnKc9SxM+cLWxJMmx0Z4WQqCAjdr6
         hKFe+h0FMAcCQ6ExX38CKiyXF8TAYLiYYTbqY/PeY2RgJ4oYJ5zyjvSiE6wP441B07A0
         RWuQ==
X-Gm-Message-State: ANoB5pmLxoKOiDUfeXXA0Af1ZAghIwmPawMZHg+tY/2yaAzRGADgfiEY
        EQGAjGkp5qn0Zd+KaSubJLlCVWyKdhtTqT64/tmJSQ==
X-Google-Smtp-Source: AA0mqf5ijdSCxsTWwbKy9oyOU/ZX9gdAczwmorr4f+2fLgEZSUzmFZX1JV0IowsOu4Q8JApXZfXkBoshlOd4sT0WqcQ=
X-Received: by 2002:ac2:4149:0:b0:4a2:217:18bf with SMTP id
 c9-20020ac24149000000b004a2021718bfmr17611548lfi.146.1669942454970; Thu, 01
 Dec 2022 16:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20221115121237.28361-1-quic_vboma@quicinc.com> <20221115121237.28361-2-quic_vboma@quicinc.com>
In-Reply-To: <20221115121237.28361-2-quic_vboma@quicinc.com>
From:   Nathan Hebert <nhebert@chromium.org>
Date:   Thu, 1 Dec 2022 16:54:03 -0800
Message-ID: <CANHAJhEdE+ZavgDHbAwM3rmw-HJVPyoWG938zMoOp+WdteXuXQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] venus: Enable sufficient sequence change support for
 sc7180 and Fix for Decoder STOP command issue.
To:     quic_vboma@quicinc.com
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 4:12 AM <quic_vboma@quicinc.com> wrote:
>
> From: Viswanath Boma <quic_vboma@quicinc.com>
>
> For VP9 bitstreams, there could be a change in resolution at interframe,
> for driver to get notified of such resolution change, enable the property in video firmware.
> Also, EOS handling is now made same in video firmware across all V6 SOCs,
> hence above a certain firmware version, the driver handling is made generic for all V6s
>
With this patch and the latest Venus SC7180 firmware, VP9 interframe
resolution changes are handled and decoded correctly.

Tested-by: Nathan Hebert <nhebert@chromium.org>

> Signed-off-by: Vikash Garodia <vgarodia@qti.qualcomm.com>
> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/core.h       | 10 ++++++++++
>  drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
>  drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
>  drivers/media/platform/qcom/venus/hfi_msgs.c   | 11 +++++++++--
>  drivers/media/platform/qcom/venus/vdec.c       | 12 +++++++++++-
>  5 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 32551c2602a9..538d7cd41edd 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -202,6 +202,11 @@ struct venus_core {
>         unsigned int core0_usage_count;
>         unsigned int core1_usage_count;
>         struct dentry *root;
> +       struct venus_img_version {
> +               u32 major;
> +               u32 minor;
> +               u32 rev;
> +       } venus_ver;
>  };
>
>  struct vdec_controls {
> @@ -472,6 +477,11 @@ struct venus_inst {
>  #define IS_V3(core)    ((core)->res->hfi_version == HFI_VERSION_3XX)
>  #define IS_V4(core)    ((core)->res->hfi_version == HFI_VERSION_4XX)
>  #define IS_V6(core)    ((core)->res->hfi_version == HFI_VERSION_6XX)
> +#define IS_FW_REV_OR_NEWER(core, vmajor, vminor, vrev)  ((core)->venus_ver.major == vmajor && \
> +                       (core)->venus_ver.minor == vminor && (core)->venus_ver.rev >= vrev)
> +#define IS_FW_REV_OR_OLDER(core, vmajor, vminor, vrev)  ((core)->venus_ver.major == vmajor && \
> +                       (core)->venus_ver.minor == vminor && (core)->venus_ver.rev <= vrev)
> +
>
>  #define ctrl_to_inst(ctrl)     \
>         container_of((ctrl)->handler, struct venus_inst, ctrl_handler)
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> index 930b743f225e..e2539b58340f 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> @@ -521,6 +521,7 @@ static int pkt_session_set_property_1x(struct hfi_session_set_property_pkt *pkt,
>                 pkt->shdr.hdr.size += sizeof(u32) + sizeof(*en);
>                 break;
>         }
> +       case HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT:
>         case HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER: {
>                 struct hfi_enable *in = pdata;
>                 struct hfi_enable *en = prop_data;
> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
> index d2d6719a2ba4..20516b4361d3 100644
> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
> @@ -469,6 +469,8 @@
>  #define HFI_PROPERTY_PARAM_VDEC_PIXEL_BITDEPTH                 0x1003007
>  #define HFI_PROPERTY_PARAM_VDEC_PIC_STRUCT                     0x1003009
>  #define HFI_PROPERTY_PARAM_VDEC_COLOUR_SPACE                   0x100300a
> +#define HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT \
> +                                                               0x0100300b
>
>  /*
>   * HFI_PROPERTY_CONFIG_VDEC_COMMON_START
> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
> index df96db3761a7..4a398f77fe9c 100644
> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
> @@ -248,9 +248,10 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
>  }
>
>  static void
> -sys_get_prop_image_version(struct device *dev,
> +sys_get_prop_image_version(struct venus_core *core,
>                            struct hfi_msg_sys_property_info_pkt *pkt)
>  {
> +       struct device *dev = core->dev;
>         u8 *smem_tbl_ptr;
>         u8 *img_ver;
>         int req_bytes;
> @@ -263,6 +264,12 @@ sys_get_prop_image_version(struct device *dev,
>                 return;
>
>         img_ver = pkt->data;
> +       if (IS_V4(core))
> +               sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u-PROD",
> +                       &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
> +       else if (IS_V6(core))
> +               sscanf(img_ver, "14:VIDEO.VPU.%u.%u-%u-PROD",
> +                       &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
>
>         dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
>
> @@ -286,7 +293,7 @@ static void hfi_sys_property_info(struct venus_core *core,
>
>         switch (pkt->property) {
>         case HFI_PROPERTY_SYS_IMAGE_VERSION:
> -               sys_get_prop_image_version(dev, pkt);
> +               sys_get_prop_image_version(core, pkt);
>                 break;
>         default:
>                 dev_dbg(dev, VDBGL "unknown property data\n");
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 4ceaba37e2e5..cc19eb62b723 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -545,7 +545,7 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
>
>                 fdata.buffer_type = HFI_BUFFER_INPUT;
>                 fdata.flags |= HFI_BUFFERFLAG_EOS;
> -               if (IS_V6(inst->core))
> +               if (IS_V6(inst->core) && IS_FW_REV_OR_OLDER(inst->core, 1, 0, 87))
>                         fdata.device_addr = 0;
>                 else
>                         fdata.device_addr = 0xdeadb000;
> @@ -671,6 +671,16 @@ static int vdec_set_properties(struct venus_inst *inst)
>                         return ret;
>         }
>
> +       /* Enabling sufficient sequence change support for VP9 */
> +       if (of_device_is_compatible(inst->core->dev->of_node, "qcom,sc7180-venus")) {
> +               if (IS_FW_REV_OR_NEWER(inst->core, 5, 4, 51)) {
> +                       ptype = HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT;
> +                       ret = hfi_session_set_property(inst, ptype, &en);
> +                       if (ret)
> +                               return ret;
> +               }
> +       }
> +
>         ptype = HFI_PROPERTY_PARAM_VDEC_CONCEAL_COLOR;
>         conceal = ctr->conceal_color & 0xffff;
>         conceal |= ((ctr->conceal_color >> 16) & 0xffff) << 10;
> --
> 2.17.1
>
