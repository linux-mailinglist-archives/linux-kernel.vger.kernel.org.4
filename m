Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D78A63ADE9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiK1Qig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiK1Qie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:38:34 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD6224F16
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:38:32 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id f6so5268089ilu.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yXIPAzmyDAZ8+Yt+mdIKfYzYf8GpnFdRWmFlTziLPXg=;
        b=AS242zFDSXrjnkDSDOd4HCh+DxQhjEj++DoANtzghOgH1Dhbr+D6SBJRVaUMJ2Hhr3
         DBOE55TmEQsNUe3h0QEqbLWHv66CNpRkhh3KVULoHFjXmZ4HtUirB4INY02b2kvvvUkl
         9turIca2kOmmbcLCY9s33Uphqh0Yn3tV488UgIWU9KjtFeyCW2gfwVgL++yWDcK0x//g
         6T8Il64zJQ+pQ4ICgjpd/puAZI3rfOsQapqeGkAtSxCR8pxNQbAq5LUbN+fy+jjnsNXG
         QWByrD8AHaYtay/CuVr6JaWtoA/KB2TNMd2bRXDwBjjWEDTbGAIZkAbmo+mq6ynQQiRx
         cUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXIPAzmyDAZ8+Yt+mdIKfYzYf8GpnFdRWmFlTziLPXg=;
        b=lx75645iV7CMPf/WHiYBV5kxXBupZx6GSNIyVzHeX8vM0+9jQpqDmGOY/8BKEqTvUx
         UUJis5Dh2dwvPEFTta4aPTGbVadBppuuJQbl+MgykVqtW4rqFQ+QzzNVOlEsgtDZGrrT
         +0u+caRw7OfNKQdZFlrOBcG9HE2VPoNLVGDqMz7zSIbUcxkj7dYcLTfPYmS1eJ6VHtr0
         fFUyI6URep0j8cLgDiEVX1rQan2UV+AIkX2npn4qQJIQ2uV7OjdjTlJ1d9GYujtVJl6h
         Pl0bXMh803YZ4qHpLSTP9BJCsxI2mxe6c61nY0qDti8UCypWC2DE/1N7xubcPIjtVzc2
         lRaw==
X-Gm-Message-State: ANoB5plLySVl1+cfOB3EYxy/oD90F8JbrYX1WNhba9J2jndTizCVwmEo
        I8c7SIwyzTNxU6IUuTTRFrPqRjQK0GXhWOkwwF9qEQ==
X-Google-Smtp-Source: AA0mqf5r5eWK1t05qxcUZ+jOLr71jb0rREp0k4Q9m03mLrkxwO85Ab05Wv/E06af1m1CqWAhynRdnEwTlpHGLp/2KRY=
X-Received: by 2002:a92:1948:0:b0:302:4d37:9e66 with SMTP id
 e8-20020a921948000000b003024d379e66mr15861054ilm.277.1669653511879; Mon, 28
 Nov 2022 08:38:31 -0800 (PST)
MIME-Version: 1.0
References: <1669642093-20399-1-git-send-email-quic_sarannya@quicinc.com>
In-Reply-To: <1669642093-20399-1-git-send-email-quic_sarannya@quicinc.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 28 Nov 2022 09:38:20 -0700
Message-ID: <CANLsYkzwryAvo6rvT+4KyRX7deoB+QJ2gC0u2r0cN9HY1P3Daw@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] rpmsg: core: Add signal API support
To:     Sarannya S <quic_sarannya@quicinc.com>
Cc:     bjorn.andersson@linaro.org, arnaud.pouliquen@foss.st.com,
        swboyd@chromium.org, quic_clew@quicinc.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please send another revision with a proper cover letter that details
the changes made between the last version.

On Mon, 28 Nov 2022 at 06:28, Sarannya S <quic_sarannya@quicinc.com> wrote:
>
> Some transports like Glink support the state notifications between
> clients using flow control signals similar to serial protocol signals.
> Local glink client drivers can send and receive flow control status
> to glink clients running on remote processors.
>
> Add APIs to support sending and receiving of flow control status by
> rpmsg clients.
>
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> ---
>  arch/arm64/configs/defconfig   |  2 ++
>  drivers/rpmsg/rpmsg_core.c     | 20 ++++++++++++++++++++
>  drivers/rpmsg/rpmsg_internal.h |  2 ++
>  include/linux/rpmsg.h          | 15 +++++++++++++++
>  4 files changed, 39 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0b6af33..2df3778 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -26,6 +26,8 @@ CONFIG_CGROUP_CPUACCT=y
>  CONFIG_CGROUP_PERF=y
>  CONFIG_CGROUP_BPF=y
>  CONFIG_USER_NS=y
> +CONFIG_RPMSG=y
> +CONFIG_RPMSG_CHAR=y
>  CONFIG_SCHED_AUTOGROUP=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_KALLSYMS_ALL=y
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index d6dde00e..0c5bf67 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -331,6 +331,24 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>
>  /**
> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
> + * @ept:       the rpmsg endpoint
> + * @enable:    enable or disable serial flow control
> + *
> + * Return: 0 on success and an appropriate error value on failure.
> + */
> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
> +{
> +       if (WARN_ON(!ept))
> +               return -EINVAL;
> +       if (!ept->ops->set_flow_control)
> +               return -ENXIO;
> +
> +       return ept->ops->set_flow_control(ept, enable);
> +}
> +EXPORT_SYMBOL(rpmsg_set_flow_control);
> +
> +/**
>   * rpmsg_get_mtu() - get maximum transmission buffer size for sending message.
>   * @ept: the rpmsg endpoint
>   *
> @@ -539,6 +557,8 @@ static int rpmsg_dev_probe(struct device *dev)
>
>                 rpdev->ept = ept;
>                 rpdev->src = ept->addr;
> +
> +               ept->flow_cb = rpdrv->flowcontrol;
>         }
>
>         err = rpdrv->probe(rpdev);
> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> index 39b646d..4fea45a 100644
> --- a/drivers/rpmsg/rpmsg_internal.h
> +++ b/drivers/rpmsg/rpmsg_internal.h
> @@ -55,6 +55,7 @@ struct rpmsg_device_ops {
>   * @trysendto:         see @rpmsg_trysendto(), optional
>   * @trysend_offchannel:        see @rpmsg_trysend_offchannel(), optional
>   * @poll:              see @rpmsg_poll(), optional
> + * @set_flow_control:  see @rpmsg_set_flow_control(), optional
>   * @get_mtu:           see @rpmsg_get_mtu(), optional
>   *
>   * Indirection table for the operations that a rpmsg backend should implement.
> @@ -75,6 +76,7 @@ struct rpmsg_endpoint_ops {
>                              void *data, int len);
>         __poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
>                              poll_table *wait);
> +       int (*set_flow_control)(struct rpmsg_endpoint *ept, bool enable);
>         ssize_t (*get_mtu)(struct rpmsg_endpoint *ept);
>  };
>
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index 523c98b..cc7a917 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -64,12 +64,14 @@ struct rpmsg_device {
>  };
>
>  typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
> +typedef int (*rpmsg_flowcontrol_cb_t)(struct rpmsg_device *, void *, bool);
>
>  /**
>   * struct rpmsg_endpoint - binds a local rpmsg address to its user
>   * @rpdev: rpmsg channel device
>   * @refcount: when this drops to zero, the ept is deallocated
>   * @cb: rx callback handler
> + * @flow_cb: remote flow control callback handler
>   * @cb_lock: must be taken before accessing/changing @cb
>   * @addr: local rpmsg address
>   * @priv: private data for the driver's use
> @@ -92,6 +94,7 @@ struct rpmsg_endpoint {
>         struct rpmsg_device *rpdev;
>         struct kref refcount;
>         rpmsg_rx_cb_t cb;
> +       rpmsg_flowcontrol_cb_t flow_cb;
>         struct mutex cb_lock;
>         u32 addr;
>         void *priv;
> @@ -106,6 +109,7 @@ struct rpmsg_endpoint {
>   * @probe: invoked when a matching rpmsg channel (i.e. device) is found
>   * @remove: invoked when the rpmsg channel is removed
>   * @callback: invoked when an inbound message is received on the channel
> + * @flowcontrol: invoked when remote side flow control status is received
>   */
>  struct rpmsg_driver {
>         struct device_driver drv;
> @@ -113,6 +117,7 @@ struct rpmsg_driver {
>         int (*probe)(struct rpmsg_device *dev);
>         void (*remove)(struct rpmsg_device *dev);
>         int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
> +       int (*flowcontrol)(struct rpmsg_device *, void *, bool);
>  };
>
>  static inline u16 rpmsg16_to_cpu(struct rpmsg_device *rpdev, __rpmsg16 val)
> @@ -192,6 +197,8 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>
>  ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
>
> +int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable);
> +
>  #else
>
>  static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
> @@ -316,6 +323,14 @@ static inline ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>         return -ENXIO;
>  }
>
> +static inline int rpmsg_set_flow_control(struct rpmsg_endpoint *ept, bool enable)
> +{
> +       /* This shouldn't be possible */
> +       WARN_ON(1);
> +
> +       return -ENXIO;
> +}
> +
>  #endif /* IS_ENABLED(CONFIG_RPMSG) */
>
>  /* use a macro to avoid include chaining to get THIS_MODULE */
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
