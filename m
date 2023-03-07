Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413EF6AEA6B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjCGRdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjCGRdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:33:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355763E62A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678210081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cfPqcA1cwRLTFxhmqSenRbKcOcueH6OIZGXv5ofSOBc=;
        b=c4x6i/1ShoGvdbrKw1MuLtUpu2DIGGEkuZIcJ3SBI4DxH/UUvAbglGzZ8I5DXDZwwE2vcu
        Wy7dmZg4zXzZcVcz+YQtK68hU8aBIdRbnu9vpnX/O/0BnZ60RsSm1JHDkCHllEzemgghqX
        BtgWJy4AQPICavxs9W4WiscZiqw/9Qc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-jUpUAx5ZN5CGMhrdRYap8Q-1; Tue, 07 Mar 2023 12:28:00 -0500
X-MC-Unique: jUpUAx5ZN5CGMhrdRYap8Q-1
Received: by mail-il1-f197.google.com with SMTP id i7-20020a056e021b0700b0031dc4cdc47cso4981259ilv.23
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 09:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678210079;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfPqcA1cwRLTFxhmqSenRbKcOcueH6OIZGXv5ofSOBc=;
        b=WSKrdcwyDdp6w2YZnsxSDDZpajtR+62nEatmd6+p8td7FcJY+lDPaAShxCe1lHs78a
         ouCapq2CgmnMdICEU8XgYT8Vi/qVPlSJeSEHprqatudWPQE5VTy4DXA7oaCeSfy1P97b
         Cnon7wN6zCkNxXuV4YflCvhnIJkuoY3THOCjyGXJJbrtOAa06VHZhSnp6tmk0JSKqBrk
         j/Q9GU/19GOsd8kNOtUqI5RhwIyQQq5Jur6Q51zqV1AXHPA3ZxLZeb8EpZT0R6F9NRgk
         CjQ6GJfvqek0MVssh+cK7cYUioCAhb2Vgpql+MQK9sfD6PQzH95TZ/1ljRdGHdLiwru2
         HBDQ==
X-Gm-Message-State: AO0yUKUSmFPLwyIf+NbJ7BdEQgF39bvRhACcowyRUkMwfR5fZmzagEXB
        DgcgkfZXLFGncQ+jfzC8lIXq4kHn2iGkbFrpYSTuyXdZZOSHEnjjXkyVXJqpqGftMyU2G2rDmbD
        ZbAw5hZFCvrU4elO2Rr2pKtVA
X-Received: by 2002:a05:6e02:12cf:b0:317:3f4:c06c with SMTP id i15-20020a056e0212cf00b0031703f4c06cmr13683751ilm.20.1678210079348;
        Tue, 07 Mar 2023 09:27:59 -0800 (PST)
X-Google-Smtp-Source: AK7set/0WWrRrCd3gc67coU2cSQKQm4QzNjqBsadANxnjkNms5bcQylIzmjtvguW4ZIsk3I4wn0cYQ==
X-Received: by 2002:a05:6e02:12cf:b0:317:3f4:c06c with SMTP id i15-20020a056e0212cf00b0031703f4c06cmr13683737ilm.20.1678210079049;
        Tue, 07 Mar 2023 09:27:59 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id g11-20020a02b70b000000b003a7c47efde0sm4344252jam.11.2023.03.07.09.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:27:58 -0800 (PST)
Date:   Tue, 7 Mar 2023 12:27:56 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 0/6] Add basic Minidump kernel driver support
Message-ID: <ZAd0HPHtSEs+XX7P@x1>
References: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
 <Y/deHzijzvuvCJ2M@x1>
 <47542dbb-8cf3-6eae-a38e-910d38bd960b@quicinc.com>
 <Y/kKn9tnvSQ2Pacn@x1>
 <14b11c3c-353c-50f9-f9a4-837fc5d06fa4@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14b11c3c-353c-50f9-f9a4-837fc5d06fa4@quicinc.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 03:45:31PM +0530, Mukesh Ojha wrote:
> 
> 
> On 2/25/2023 12:36 AM, Brian Masney wrote:
> > Hi Mukesh,
> > 
> > On Fri, Feb 24, 2023 at 04:10:42PM +0530, Mukesh Ojha wrote:
> > > On 2/23/2023 6:07 PM, Brian Masney wrote:
> > > > I'd like to test this series plus your series that sets the multiple
> > > > download modes.
> > > 
> > > Sure, you are welcome, but for that you need a device running with Qualcomm
> > > SoC and if it has a upstream support.
> > 
> > I will be testing this series on a sa8540p (QDrive3 Automotive
> > Development Board), which has the sc8280xp SoC with good upstream
> > support. This is also the same board that I have a reliable way to
> > make the board crash due to a known firmware bug.
> > 
> 
> 
> Can you try below patch to just select minidump download mode and make the
> device crash ?
> 
> --------------------------------------->8-------------------------------
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 0d02599..bd8e1a8 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -280,6 +280,7 @@
>         firmware {
>                 scm: scm {
>                         compatible = "qcom,scm-sc8280xp", "qcom,scm";
> +                       qcom,dload-mode = <&tcsr 0x13000>;
>                 };
>         };
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index cdbfe54..e1539a2 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -20,7 +20,7 @@
> 
>  #include "qcom_scm.h"
> 
> -static bool download_mode =
> IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
> +static bool download_mode = true;
>  module_param(download_mode, bool, 0);
> 
>  #define SCM_HAS_CORE_CLK       BIT(0)
> @@ -427,7 +427,7 @@ static void qcom_scm_set_download_mode(bool enable)
>                 ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>         } else if (__scm->dload_mode_addr) {
>                 ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> -                               enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> +                               enable ? 0x20 : 0);
>         } else {
>                 dev_err(__scm->dev,
>                         "No available mechanism for setting download
> mode\n");

Hi Mukesh,

I tried to test this series but I don't know how to actually use the
minidump feature that's in this series. Some more documentation is
needed.

I added this series, plus your other series that adds the download modes
to the SCM driver to my tree, along with your changes above. I
downgraded the firmware on my sa8540p and I have my reproducible crash.
Linux immediately loses control and the board firmware takes over.

I assumed that I'd need to do a warm reboot so that DDR contents are
still present so Linux can grab the memory contents on next reboot.
However, 'fastboot devices' shows no devices so I can't reboot that
way. I can do a cold boot but the DDR contents will be lost.

Also this series needs to be rebased against 6.3rc1.

Brian

