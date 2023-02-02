Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE416879D8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjBBKLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjBBKK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:10:56 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1B488F30
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:10:54 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 74so1262465ybl.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 02:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fIr6opegPYfpGWKNlATi3aulrpwL9ZZFwjdVeIsGg20=;
        b=NIhoncgdsLnAr7fLeP22RntrW5UuVkPsVZUIag071PSTqztaYTAYp1IOOQJaYJ1m9s
         SfTv3VPsrOOlwypaPvpob3JYUWfzCESKKMtXxapPEYGr1QYbSNs3lV5BrH/Vq+BTaUQg
         CjHi2kIkioQSpUc2bD5JWP1ersrxhxuH5lyyTwogjKdv5oaKDB3NAt/KnkUksXZw48nL
         KpfGESNoQHQwBi8SLAaIhNQgdA4XrPB1fUDe2C8R55SALsZ/0CAmo2hZMeQyP4Cry2T7
         HEICtNTPJCtJvi8JSrjRp+hyjF5wREoEXsDy9FIzJL7rSYAmstamzuGnKzu1zIbFmCK4
         2xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIr6opegPYfpGWKNlATi3aulrpwL9ZZFwjdVeIsGg20=;
        b=zjJVd7eSD9Durc7bapr/3dbAaiEq5TXdlQ9cEu8Majy4b2xdWBZgpqiR91DqEvIDnm
         2C2td6ODGAUphNzdmPYfi0DU9uzCXRo6fD8Qe2hkTgiO9MXCTLyqv8MqKaWJIAylP2ry
         0Kt8FCJ375MUImAHPzWpKt4FL6kt9OM4lgqT5p3EnY6ZtgbIZ0tTCNksKqKmyiz83UOf
         31BiAP2KaAYMi4EJxwVxF7Q+Kt1H7o4bODF7IA+rGlv2M+Pg9Zv1Zs11fvDHvrnKR4Aq
         L03NFFMzdYNPVtUWOH9cwCjWEu1oy761GyrJpY69PQarahNlQwfKSteCN3igV58ntRlN
         EVcQ==
X-Gm-Message-State: AO0yUKX0A0ZqobHbgLLiIKeoQi6cLXxLnMGR7QAuxyHoPK0V4EXibmfx
        NwwTUHms8ybsXPafjKgbf5raXBixe7Mr27OZBcR3Lg==
X-Google-Smtp-Source: AK7set8OAHlZDQN+AkaE+B1uLRGDzAJWAAoIau5RgOokIKEP9uytufptVUjIEheTX4tybvgMJGNNdQFwLK7ApmxAr4Q=
X-Received: by 2002:a25:bf90:0:b0:6e0:c7d3:f026 with SMTP id
 l16-20020a25bf90000000b006e0c7d3f026mr692420ybk.275.1675332653827; Thu, 02
 Feb 2023 02:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20221115121237.28361-2-quic_vboma@quicinc.com>
 <20230202064712.5804-1-quic_vboma@quicinc.com> <20230202064712.5804-2-quic_vboma@quicinc.com>
In-Reply-To: <20230202064712.5804-2-quic_vboma@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 2 Feb 2023 12:10:42 +0200
Message-ID: <CAA8EJpqp7D3kBwPNNtdWHPdp=N+VZ_7dZEB7+O7nMxT44ZJ-5w@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] venus: Enable sufficient sequence change support
 for sc7180 and fix for Decoder STOP command issue.
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

On Thu, 2 Feb 2023 at 08:47, <quic_vboma@quicinc.com> wrote:
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
>  drivers/media/platform/qcom/venus/core.h       | 18 ++++++++++++++++++
>  drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
>  drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
>  drivers/media/platform/qcom/venus/hfi_msgs.c   | 11 +++++++++--
>  drivers/media/platform/qcom/venus/vdec.c       | 12 +++++++++++-
>  5 files changed, 41 insertions(+), 3 deletions(-)

Several generic comments:
- Please move your work on top of the recent kernels. 5.15 was
released half of the year ago. I'm not going to mention 5.4 age.
- Please split your patch into smaller logical patches.

>
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 32551c2602a9..8f94d795cc2b 100644
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
> +               vminor && (core)->venus_ver.rev >= vrev);

Please make the indentation logical here (and below).
Also is 5.6.1 (e.g.) newer than 5.4.51? Or 5.4.1 newer than 4.2.0?

> +}
> +
> +static inline int
> +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
> +{
> +       return ((core)->venus_ver.major == vmajor && (core)->venus_ver.minor ==
> +               vminor && (core)->venus_ver.rev <= vrev);
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

What about older (V1/V3) cores?

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

Do newer chips support this property? Do you intend to list all of them here?

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



-- 
With best wishes
Dmitry
