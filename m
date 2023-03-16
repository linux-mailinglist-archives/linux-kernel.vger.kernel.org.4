Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41216BCC76
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjCPKUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCPKUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:20:38 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638DFBBB2B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:20:29 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5416698e889so21902427b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678962028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SAog4H/SRFvoaEO1OZaRPW+vcyrqLcy+mvMuM/gRdEU=;
        b=c+ZumM3X9admVFx8dYxUtMxlNIuB1aK9CvI3x1Bhk8FAE8iZwfnpyrfVzAVWQKPIfg
         Jy3AgQ2Wdq6r+PGFBOOR6Ap7ANNwzjk6ANKoPK0arbRr+2b9tlhpm/PLkn4SztdbA/Ag
         zqTcQcSvnJvPfyJFBkJzA+GqMxcV/Tx9JKmDWASuCW6fQ7Io7PnlTZGUpqttYj2Y1B+S
         WfNH9NAblKoCa5asYybuJDSgs0y3gu1pThe2rdgI7cUsKxBKJCSNidxQkLdqRDC4IBGW
         TffJHOKI1ZA13UMP/2eS3wRa7Hr7Ml3VXi7SHlD91iHBRIqkf4XG1sy6fsNtdEi+p7s/
         cB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678962028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAog4H/SRFvoaEO1OZaRPW+vcyrqLcy+mvMuM/gRdEU=;
        b=0zfpNawRt9cIIOwhUW2rvNHesXNIrlsGhsg9Uk6Ckh534tB3t2QWUxP4Cio2VChW9M
         +vc+VqAGTFSBRhRc/1wCb9RG+YYlKQsGT3Gkhm665QA8XUaWp6HddV7SEvX7qtzXw6wU
         2TkGXbd4qNEmH7Mq7eL9iHPeTbGzIdBTtvlQe4YoHTcVdBAb658MnaFrpbAgJAyns5X5
         b6+9onOxN4YnLvfUhqJOf7zSWixfpFzkd1b9N/L02RP+slzoJ1XJiQ527u2mnChCyIDl
         Iu0viq+bnTM7768sjbJ2tp1jUtGYGGv66XgqIgfEOU8jVU9o1ESqYUAe1NxhPdcJYNyp
         4iLw==
X-Gm-Message-State: AO0yUKWTQkG1WgxJIUWebZGPZg9ggMxxv8XrbLIqbwNx7j0YvsMXYii3
        F9pOS4OrFX7p0koQEkWlHx9DScR1plqwsMloLDJyHw==
X-Google-Smtp-Source: AK7set9sa4/oy4Jqwr7KB88J+xmPYRgd44Viltr+Y+ihpUmjD1EzCd/GuXR6lmOjOsG+2r84dXTULPtF66OZHVXeTtw=
X-Received: by 2002:a81:b3ca:0:b0:541:8a9a:5445 with SMTP id
 r193-20020a81b3ca000000b005418a9a5445mr1860892ywh.5.1678962028513; Thu, 16
 Mar 2023 03:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230202064712.5804-2-quic_vboma@quicinc.com> <20230316081509.12201-1-quic_vboma@quicinc.com>
 <20230316081509.12201-2-quic_vboma@quicinc.com>
In-Reply-To: <20230316081509.12201-2-quic_vboma@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Mar 2023 12:20:17 +0200
Message-ID: <CAA8EJpozq1nCgG5npK5JUXc-Y-7LiPe3Y_VP8++Rq70AreCenA@mail.gmail.com>
Subject: Re: [PATCH] venus: Enable sufficient sequence change support for
 sc7180 and fix for Decoder STOP command issue.
To:     quic_vboma@quicinc.com
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 at 10:17, <quic_vboma@quicinc.com> wrote:
>
> From: Viswanath Boma <quic_vboma@quicinc.com>
>
> For VP9 bitstreams, there could be a change in resolution at interframe,
> for driver to get notified of such resolution change,
> enable the property in video firmware.
> Also, EOS handling is now made same in video firmware across all V6 SOCs,
> hence above a certain firmware version, the driver handling is
> made generic for all V6s
>
> Signed-off-by: Vikash Garodia <vgarodia@qti.qualcomm.com>
> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
> Tested-by: Nathan Hebert <nhebert@chromium.org>
> ---

Which version of the patch is this? Were there any changes compared to
the previous version? Please include a changelog below the dashed line
to let other people know what has changed

>  drivers/media/platform/qcom/venus/core.h       | 18 ++++++++++++++++++
>  drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
>  drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
>  drivers/media/platform/qcom/venus/hfi_msgs.c   | 11 +++++++++--
>  drivers/media/platform/qcom/venus/vdec.c       | 12 +++++++++++-
>  5 files changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 32551c2602a9..ee8b70a34656 100644
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
> @@ -500,4 +505,17 @@ venus_caps_by_codec(struct venus_core *core, u32 codec, u32 domain)
>         return NULL;
>  }
>
> +static inline int
> +is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
> +{
> +       return ((core)->venus_ver.major == vmajor && (core)->venus_ver.minor ==
> +                       vminor && (core)->venus_ver.rev >= vrev);
> +}
> +
> +static inline int
> +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
> +{
> +       return ((core)->venus_ver.major == vmajor && (core)->venus_ver.minor ==
> +                       vminor && (core)->venus_ver.rev <= vrev);
> +}
>  #endif
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
> index df96db3761a7..07ac0fcd2852 100644
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
> +                      &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
> +       else if (IS_V6(core))
> +               sscanf(img_ver, "14:VIDEO.VPU.%u.%u-%u-PROD",
> +                      &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
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
> index 4ceaba37e2e5..36c88858ea9d 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -545,7 +545,7 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
>
>                 fdata.buffer_type = HFI_BUFFER_INPUT;
>                 fdata.flags |= HFI_BUFFERFLAG_EOS;
> -               if (IS_V6(inst->core))
> +               if (IS_V6(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))
>                         fdata.device_addr = 0;
>                 else
>                         fdata.device_addr = 0xdeadb000;
> @@ -671,6 +671,16 @@ static int vdec_set_properties(struct venus_inst *inst)
>                         return ret;
>         }
>
> +       /* Enabling sufficient sequence change support for VP9 */
> +       if (of_device_is_compatible(inst->core->dev->of_node, "qcom,sc7180-venus")) {

Is it really specific just to sc7180 or will it be applicable to any
other platform using venus-5.4 firmware?

> +               if (is_fw_rev_or_newer(inst->core, 5, 4, 51)) {
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


-- 
With best wishes
Dmitry
