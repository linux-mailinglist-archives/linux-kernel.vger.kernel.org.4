Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2C366A3D9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjAMUEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjAMUEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:04:38 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA2685C85
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:04:37 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id x37so23561710ljq.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pn/bUQqTAlACXsw2QFf1F1nB2X4q2bNMOyvZ55+9yP4=;
        b=Tr6VgupPvHBPkf9jtufKm+A27vFwaSYnsjcszGJP6IBI2qUNT2ZjMKC3evDBThaPTt
         NDh+pJGetVKcZxgpqrN4Egt5C9/fbftrgp2NmGzf/XYJr+GEh2BJBZfb8Au84H7RN/iq
         rNHLuEQVEZ/gODcLlT7B/nPWwOR/8Rw6AW/+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pn/bUQqTAlACXsw2QFf1F1nB2X4q2bNMOyvZ55+9yP4=;
        b=xw0HTISIKwD/bOX1+3bh/9A2hrtSWhpAHWTU1B5DzcXdvRRfSgfofRJmYlNMMUERJm
         ooOEKsb62zTOWN395hMfIYmpiT1ohu7d4QFZYbZqjvSy5ecrcxSQyZLRsEbQpYVU7Uhw
         CjSmabv2ddqsMGjMPHJZvUbXuM8PDncII+ohrqY9FdugUv6NKRJo7Xf79euDlYZ0wEDD
         EiGW0ko8Y+BI8R4XaNYBZK9yZ3kmwesbh0/O0/RpPm9auqoythKioz0yOu7NIYmbPVJy
         In218nDbKcuyQ6+r4fwgPSNvVyELWrrUfKUO7ANB3U3v8BTYTrThU8jEn9Q6PxgMWP8E
         PYbw==
X-Gm-Message-State: AFqh2kro8um1IiVF2Tpqzwpu1vQh/Z+0BowCjFGe9rpfearS3RcXg+ZE
        1/JGUaJ74zVlbgOBv3I73iLIMR1eRAVkOL+YXb2xWA==
X-Google-Smtp-Source: AMrXdXuxNP3qxjyfKL7UUHKMWbAhG7+AZ5pGsKgsViDpwuAAelWCvLAprFzP+G20mze9LfyTHRB9PaqUYqRLWMQPSzo=
X-Received: by 2002:a05:651c:332:b0:28b:62f7:5b6d with SMTP id
 b18-20020a05651c033200b0028b62f75b6dmr406063ljp.39.1673640275607; Fri, 13 Jan
 2023 12:04:35 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Jan 2023 14:04:35 -0600
MIME-Version: 1.0
In-Reply-To: <Y8ERv0712EfPJWtF@hovoldconsulting.com>
References: <20230113005405.3992011-1-swboyd@chromium.org> <20230113005405.3992011-5-swboyd@chromium.org>
 <Y8ERv0712EfPJWtF@hovoldconsulting.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 13 Jan 2023 14:04:35 -0600
Message-ID: <CAE-0n50bbUJGfdXLhD2FP6-dwZEn_AqyB-fCTxgnZ=YBUQdUAw@mail.gmail.com>
Subject: Re: [PATCH 5.15.y 4/4] phy: qcom-qmp-combo: fix runtime suspend
To:     Johan Hovold <johan@kernel.org>
Cc:     stable@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
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

Quoting Johan Hovold (2023-01-13 00:09:35)
> On Thu, Jan 12, 2023 at 04:54:05PM -0800, Stephen Boyd wrote:
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > index 9fda6d283f20..d928afe2ebba 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > @@ -4985,15 +4985,11 @@ static void qcom_qmp_phy_disable_autonomous_mode(struct qmp_phy *qphy)
> >  static int __maybe_unused qcom_qmp_phy_runtime_suspend(struct device *dev)
> >  {
> >       struct qcom_qmp *qmp = dev_get_drvdata(dev);
> > -     struct qmp_phy *qphy = qmp->phys[0];
> > +     struct qmp_phy *qphy = qmp->usb_phy;
> >       const struct qmp_phy_cfg *cfg = qphy->cfg;
> >
> >       dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qphy->mode);
>
> So this doesn't work currently either as the usb_phy pointer is not set
> for PCIe and UFS PHYs.

Cool, setting usb_phy for pcie and ufs fixes this.
