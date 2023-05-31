Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F857176CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjEaGZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEaGZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:25:58 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0159F
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 23:25:56 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-39a505b901dso224045b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 23:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685514356; x=1688106356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6QEemah19M6O9zXMW59Hl4eoCOU3nOcUSmXPFvc40qY=;
        b=yfU72+a+V2j1RGJPAmrckG8hM7WDnXqiHNyDYmGNLaKUCMEP4XxwviwX+agCGFrcLP
         Yo8vfNa08n1FVaMu0X1PY/t9b1Ubsjk9QaMuY0vEHxiWyShKpqdddJ+KaVP3vc0epElt
         YfyhQnGsE3WgjqORPELcNGKiQF65PqC+1I3LqsMMk/YxvkCcp8UuGfrg4sDBCA+cYpeJ
         3+BMapGTMNFXdVhYOmuwDq/Aj85/RlK5TF+VnOqL1tDxpxpZbyPsTiw8dlC6Bam3Wye7
         xTR11c4SfSSwIbAZMFAPU3SjiNn3/3LC8RuWdPt9dxLt73JV1ewK8lUEFVVh6JqOhsiY
         thfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685514356; x=1688106356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QEemah19M6O9zXMW59Hl4eoCOU3nOcUSmXPFvc40qY=;
        b=kk9Bet41Q8zGnXOZRdx+ZnYmeT0UfSSkm2If77sR/679MpL9tQSSRg4ZiLHN4xY+af
         J4Iti5O4yW4oRm+We2628XmwrMBUwioTOBwMbNOVgMwVmmNaV8eYwwI+LN4Orm2OfLs7
         /5OIwM/zsT5l7acHy833GrJXD11TTexR1b38LDBcld0W/d9WZ3mgv0K/wnJXValn2y/s
         NLoGCtIfpg0TYNv82yGusWYGlmErCrK4dljQ0JEaBXcZG5EVp5FGIIm3YrOztbKyjKeF
         41sU0odcTcmWoU3bQMH9O1Wmpknge3G12/uRldnAfWFumweHoqxyf7f0Alz9T95iPKwO
         s41g==
X-Gm-Message-State: AC+VfDx12bJUL0OhxncQSiyH9yfi/2dC2y8/N1zJjNdeX+DiEgg13XcA
        dtG8pE+A9raJbUobRq+a6+T1d3NLg3suRNewxg==
X-Google-Smtp-Source: ACHHUZ7UhgIzbO0+5ARVJsxpkjyAwkwawoZkIijG0DTJ0OpOoUf3tpw7dMYdvCkbhrqK0+T6PV9O+Q==
X-Received: by 2002:a05:6808:8c2:b0:398:36a0:d42 with SMTP id k2-20020a05680808c200b0039836a00d42mr2894012oij.39.1685514356188;
        Tue, 30 May 2023 23:25:56 -0700 (PDT)
Received: from thinkpad ([117.217.186.173])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902e88c00b001aaf370b1c7sm404309plg.278.2023.05.30.23.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 23:25:55 -0700 (PDT)
Date:   Wed, 31 May 2023 11:55:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_krichai@quicinc.com
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Add support for IP_SW0
 channels
Message-ID: <20230531062550.GA7968@thinkpad>
References: <20230519135803.13850-1-manivannan.sadhasivam@linaro.org>
 <CAMZdPi_QRi_n7=Do_P6E3Xwk=zQ3nS3jpiFBNApCvWd4v=LSCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMZdPi_QRi_n7=Do_P6E3Xwk=zQ3nS3jpiFBNApCvWd4v=LSCw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 08:27:45PM +0200, Loic Poulain wrote:
> On Fri, 19 May 2023 at 15:58, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > IP_SW0 channels are used to transfer data over the networking interface
> > between MHI endpoint and the host. Define the channels in the MHI v1
> > channel config along with dedicated event rings.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Assuming we can extend the number of event rings (and dedicated irqs)
> without hitting any hardware limitation on the device side?
> 

Not all endpoints support IP_SW0 channels. Only a few devices that intend to
transfer non-IP data payload supports it and those should take care of the
requirements.

- Mani

> Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
> 
> 
> 
> > ---
> >  drivers/bus/mhi/host/pci_generic.c | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> > index db0a0b062d8e..70e37c490150 100644
> > --- a/drivers/bus/mhi/host/pci_generic.c
> > +++ b/drivers/bus/mhi/host/pci_generic.c
> > @@ -212,6 +212,19 @@ struct mhi_pci_dev_info {
> >                 .offload_channel = false,       \
> >         }
> >
> > +#define MHI_EVENT_CONFIG_SW_DATA(ev_ring, el_count) \
> > +       {                                       \
> > +               .num_elements = el_count,       \
> > +               .irq_moderation_ms = 0,         \
> > +               .irq = (ev_ring) + 1,           \
> > +               .priority = 1,                  \
> > +               .mode = MHI_DB_BRST_DISABLE,    \
> > +               .data_type = MHI_ER_DATA,       \
> > +               .hardware_event = false,        \
> > +               .client_managed = false,        \
> > +               .offload_channel = false,       \
> > +       }
> > +
> >  #define MHI_EVENT_CONFIG_HW_DATA(ev_ring, el_count, ch_num) \
> >         {                                       \
> >                 .num_elements = el_count,       \
> > @@ -237,8 +250,10 @@ static const struct mhi_channel_config modem_qcom_v1_mhi_channels[] = {
> >         MHI_CHANNEL_CONFIG_DL_AUTOQUEUE(21, "IPCR", 8, 0),
> >         MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
> >         MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
> > -       MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 128, 2),
> > -       MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 128, 3),
> > +       MHI_CHANNEL_CONFIG_UL(46, "IP_SW0", 64, 2),
> > +       MHI_CHANNEL_CONFIG_DL(47, "IP_SW0", 64, 3),
> > +       MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0", 128, 4),
> > +       MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0", 128, 5),
> >  };
> >
> >  static struct mhi_event_config modem_qcom_v1_mhi_events[] = {
> > @@ -246,9 +261,12 @@ static struct mhi_event_config modem_qcom_v1_mhi_events[] = {
> >         MHI_EVENT_CONFIG_CTRL(0, 64),
> >         /* DIAG dedicated event ring */
> >         MHI_EVENT_CONFIG_DATA(1, 128),
> > +       /* Software channels dedicated event ring */
> > +       MHI_EVENT_CONFIG_SW_DATA(2, 64),
> > +       MHI_EVENT_CONFIG_SW_DATA(3, 64),
> >         /* Hardware channels request dedicated hardware event rings */
> > -       MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
> > -       MHI_EVENT_CONFIG_HW_DATA(3, 2048, 101)
> > +       MHI_EVENT_CONFIG_HW_DATA(4, 1024, 100),
> > +       MHI_EVENT_CONFIG_HW_DATA(5, 2048, 101)
> >  };
> >
> >  static const struct mhi_controller_config modem_qcom_v1_mhiv_config = {
> > --
> > 2.25.1
> >

-- 
மணிவண்ணன் சதாசிவம்
