Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A95716F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjE3VRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjE3VRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:17:05 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60E8E8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:17:03 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77700d5a176so345053739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685481423; x=1688073423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P8AWK6vW9g0L9wKhlsKR98Xhgzj+ZXqnUK/AQ7fXJZc=;
        b=MOsoJ6/qQUZ/QT/3MGmK4wChP3Sna3iH3M+Et0lQ8mCnYYkQsijBsSdtlfRoIyQLWC
         ri7/g6cADkwlUccTDRew97+m4P85QOQ7NVJWZGqBB8KnWiz3H/DhS1dKAB8Yk18v2GcP
         WDepOB5+MFL2jjPDwAk3jF7nt7pEBk0pNdiNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685481423; x=1688073423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8AWK6vW9g0L9wKhlsKR98Xhgzj+ZXqnUK/AQ7fXJZc=;
        b=AIw4Q8uwLmQ1pWYukFbSKz5oa5itFD7qgpncC4jo/G+aDq9oCDPQjwnMS/A99HmkKy
         0L3P3Vu9novZzVX0Kr2M104j1GSR8XN9mr7ZAlhOJRt7jd2UrkGMHI6rYVqaOWLd53O3
         6ezcGkm4BY/mAgTNbjJoOYoMTfJ9AkJsoq+XmvitbWhktsaXOJ29ABuSGuhJoxAp6pEg
         U9z0CUkv2IT3owSKDyJSpi+rrURxJ8oj02ADYMRh2UzPQsxnPSIcmFNjoVc3dgnk6IKQ
         6Yn2qJbf5YbbOoBBo9eP3UZ0obWMFfoQifd7pi9sTHW+SnZcEo5XSZkxUQn90cB5L4nx
         kS7A==
X-Gm-Message-State: AC+VfDy91EYr0IICreKyEm3JymFDf0TYeJW/YUZjMJbKuk/L3/ZBWNOJ
        zHUHO1l57K0W91h2l0d1tRIj/w==
X-Google-Smtp-Source: ACHHUZ5/Ilt2O7jEL8iLyLVlFNOWDAsFDyM1uRUTYJQ8+z4fK22hjW1uA7wA/E9+ayMRzB4dYka1Ug==
X-Received: by 2002:a05:6e02:68d:b0:338:1370:a7e with SMTP id o13-20020a056e02068d00b0033813700a7emr496712ils.25.1685481423174;
        Tue, 30 May 2023 14:17:03 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id q13-20020a92d40d000000b0032ca1426ddesm2743528ilm.55.2023.05.30.14.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 14:17:02 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
X-Google-Original-From: Matthias Kaehlcke <mka@google.com>
Date:   Tue, 30 May 2023 21:17:02 +0000
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Owen Yang <ecs.taipeikernel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@google.com>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, Harvey <hunge@google.com>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] drivers: pci: quirks: Add suspend fixup for SSD on
 sc7280
Message-ID: <ZHZnzqeFbwkGFUud@google.com>
References: <20230525163448.v1.1.Id388e4e2aa48fc56f9cd2d413aabd461ff81d615@changeid>
 <20230529164856.GE5633@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230529164856.GE5633@thinkpad>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 10:18:56PM +0530, Manivannan Sadhasivam wrote:
> On Thu, May 25, 2023 at 04:35:12PM +0800, Owen Yang wrote:
> > Implement this workaround until Qualcomm fixed the
> >  correct NVMe suspend process.
> > 
> > Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
> > ---
> > 
> >  drivers/pci/quirks.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index f4e2a88729fd..b57876dc2624 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5945,6 +5945,16 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
> >  }
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
> >  
> > +/* In Qualcomm 7c gen 3 sc7280 platform. Some of the SSD won't enter
> > + * the correct ASPM state properly. Therefore. Implement this workaround
> > + * until Qualcomm fixed the correct NVMe suspend process*/
> 
> What is there to fix during suspend? Currently, Qcom PCIe driver just votes for
> low interconnect bandwidth and keeps the resources (clocks, regulators) ON
> during suspend. So there is no way the device would move to D3Cold.
> 
> Earlier Qcom reported that during suspend, link down event happens when the
> resources are turned OFF without waiting for the link to enter L1ss. But as I
> said above, we are _not_ turning OFF any resources.

Right, it makes little sense that the NVMe would move to D3Cold. And why does
the issue only reproduces sometimes (with certain NVMes) and not consistently?

> I believe this patch is addressing an issue that is caused by an out-of-tree
> patch.

I think ECS observed this with Chrome OS v5.15 kernel. On the PCI side this
kernel only has backported changes from upstream  (mostly clean picks), no
downstream patches, so it seems unlikely that the issue is caused by a
downstream patch.
