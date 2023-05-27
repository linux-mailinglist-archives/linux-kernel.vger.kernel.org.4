Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C848E7131E7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 04:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjE0CVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 22:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjE0CVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 22:21:42 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76745125
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 19:21:40 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d5f65a2f7so1201009b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 19:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685154100; x=1687746100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4u3wyjxu3pSFjQpLkXWyrv3jN5Nzs8AH5ozbdTcUIpY=;
        b=x4VxuDsmHMBks19r5vNJ6LF+p9t75igapR7CSfoaA95cfkWGPjc+IYM5i+JrnK/W49
         8c6lW8uTQAuyBk5/Ru873J0FRM+xjjEVziu1tWvXM4LmqEIR/OUHrASyN2WtbLsoHI0p
         r8ZJmF7iaXuMDjIzlV9NYChw8Y0vsB0BOOt9wOFcG2ABFWrwN+YHFMRkzB6jGA6QsX1c
         IokJDsq8rT9W0DNAL483fVt6Ih1W3l84012zF83sQ+8+P3djiphRGvbwSw/6Ppa4f+F/
         4xhheDOw2EzxuCcVApd3Tmiw5yrEaTLHm9ESZkdchHk7GkFtjsyeXPTyaXMfXcYVYL4u
         Q8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685154100; x=1687746100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4u3wyjxu3pSFjQpLkXWyrv3jN5Nzs8AH5ozbdTcUIpY=;
        b=NIbTVDzn7dBWs/MR8Np+c+jzEAWvePpdb7g5sDQMh8y55SoEhjmbbS3gXUVarljyn7
         8WRc4HiB7Rnh8XL/kOUtf+31l0FkVVPHQu0OP0NHoRmMSyLUgtgf5h09Ixpm8g4OsdJO
         O5E2RaRiGANsUNUL73PTvUnIZAEKf53tqCmuiM+G6E6arOKYMwe8aT9Q0rA0qbt5ItuW
         td9a9VYG6NmSkgNchHEqBd+Xy7FfJ/FGBl7j748jrgnwIXQW2xPxEQYZO8UOj4yEmsu5
         dvg9KYBc9ci5vymV2F3aj63eqlkmMYuYeb3R5W87rTZBbhlNv9EpBKsdcGFwg91EM6Vp
         Igxw==
X-Gm-Message-State: AC+VfDwxwNgvHyMT1Soe7b/8Q+kJCoxM8ciGi3U8xRfZHtUGfurSz2X4
        fjUbIIneyg5UsftbRsh7Fsve
X-Google-Smtp-Source: ACHHUZ7y3kt+pLHNlXo1UvK5zsCmkXEuLD0VzVolIcvDXiSRH2li5d7r0Wg8HfFDXbBIUXoiIAfWnw==
X-Received: by 2002:a05:6a00:c8a:b0:64c:ae1c:3385 with SMTP id a10-20020a056a000c8a00b0064cae1c3385mr6994587pfv.32.1685154099916;
        Fri, 26 May 2023 19:21:39 -0700 (PDT)
Received: from thinkpad ([117.216.120.68])
        by smtp.gmail.com with ESMTPSA id j7-20020aa78d07000000b0064d3a9def35sm3187034pfe.188.2023.05.26.19.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 19:21:39 -0700 (PDT)
Date:   Sat, 27 May 2023 07:51:32 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <frank.li@nxp.com>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: Re: [EXT] [PATCH v4 4/7] PCI: endpoint: Add BME notifier support
Message-ID: <20230527022132.GA2814@thinkpad>
References: <20230519144215.25167-1-manivannan.sadhasivam@linaro.org>
 <20230519144215.25167-5-manivannan.sadhasivam@linaro.org>
 <AM6PR04MB483845CDCBDF5962C3F9D8F2887C9@AM6PR04MB4838.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR04MB483845CDCBDF5962C3F9D8F2887C9@AM6PR04MB4838.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 06:19:44PM +0000, Frank Li wrote:
> 
> > @@ -72,11 +72,13 @@ struct pci_epf_ops {
> >   * @core_init: Callback for the EPC initialization complete event
> >   * @link_up: Callback for the EPC link up event
> >   * @link_down: Callback for the EPC link down event
> > + * @bme: Callback for the EPC BME (Bus Master Enable) event
> >   */
> >  struct pci_epc_event_ops {
> >         int (*core_init)(struct pci_epf *epf);
> >         int (*link_up)(struct pci_epf *epf);
> >         int (*link_down)(struct pci_epf *epf);
> > +       int (*bme)(struct pci_epf *epf);
> 
> I posted a doorbell from host to EP at
> https://lore.kernel.org/imx/20230426203436.1277307-2-Frank.Li@nxp.com/T/#u
> 
> Can we consider consolidate these notification to one function and distinguished by
> EVENT_ID in future?
> 

My preference is to keep a separate callback for each event as it makes the code
look better instead of clubbing everything in a single callback separated by a
switch case.

- Mani

> Best regards
> Frank Li
> 
> >  };
> > 
> >  /**
> > --
> > 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
