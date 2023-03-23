Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768FF6C6AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjCWO0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCWOZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:25:58 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E751F166E8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:25:57 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so1222789wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679581556;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:references:cc:to:subject:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sIiBgnyQ0JgWES8oi760MqEjDmVQwV5KyEI3pPlcmjE=;
        b=lobijrxwfeTd/sblvUsE2L1Xa2drxlFnjVZEe7Rs0GjXc1TudwtfHXtQc63+bKRGpQ
         V/O2yeHvvpm3/D6ANvQ2Yf4wPnNzwuto6wJ/mCaaGayaeHuvKES4vCz+08z7blQ1EsIm
         78hgX91wOuccS5a2vNTTBZZVDV+x2dsJS/qvGvuCVylYxkMYcd4KsatUH5a01aevohxC
         oDiv/BQkB9ujIyliAVBWSrZ6b4FtCQsUQ6mxwvP4pAecWAfwafD3Rtu8E4w1dDVHGqxX
         /eV0SU/mfL+gzOeMp6gTd/MlfxlJ9am2ppSXY5rXr0q2jGccTdPV2yDb/+OjvvDK4SbH
         P4kA==
X-Gm-Message-State: AO0yUKXTQs3HiEpcvK2cPqwJ3E8LCl1r8WcIhB4AKtxbohx7iMn6ptii
        glXkr1YE1T4jEPAPttApqJk=
X-Google-Smtp-Source: AK7set98nON+a4xvqXnrY2t3snByonMW4zhDley7/e60yaTL8DdfxO5968XOMnuIEEQow63HwAXBkA==
X-Received: by 2002:a7b:c3d9:0:b0:3ee:42fd:7768 with SMTP id t25-20020a7bc3d9000000b003ee42fd7768mr2786409wmj.1.1679581556275;
        Thu, 23 Mar 2023 07:25:56 -0700 (PDT)
Received: from Johanness-MBP.fritz.box ([2001:a62:1493:d101:d423:498b:c14e:a659])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b003ee5cc90fa3sm2110748wms.8.2023.03.23.07.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 07:25:55 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH 1/1] mcb: Remove requesting memory region to avoid memory
 overlapping
To:     =?UTF-8?Q?Rodr=c3=adguez_Barbarin=2c_Jos=c3=a9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "jth@kernel.org" <jth@kernel.org>,
        =?UTF-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?= 
        <Jorge.SanjuanGarcia@duagon.com>, Michael Moese <mmoese@suse.de>
References: <20230323124900.898035-1-josejavier.rodriguez@duagon.com>
 <20230323124900.898035-2-josejavier.rodriguez@duagon.com>
Message-ID: <c08407ec-8553-87ca-85d5-1988b8f9172b@kernel.org>
Date:   Thu, 23 Mar 2023 15:25:54 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230323124900.898035-2-josejavier.rodriguez@duagon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.23 13:49, Rodríguez Barbarin, José Javier wrote:
> mcb-pci requests a fixed-size memory region to parse the chameleon
> table, however, if the chameleon table is smaller that the allocated
> region, it could overlaps with the IP Cores' memory regions.
>
> There is no need to request the memory region for only parsing the
> chameleon table as it is read-only. It is sufficient to only remaps
> it when parsing.
>
> Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
> Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
> Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
> ---
>  drivers/mcb/mcb-pci.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
> index dc88232d9af8..e98f626020a7 100644
> --- a/drivers/mcb/mcb-pci.c
> +++ b/drivers/mcb/mcb-pci.c
> @@ -29,7 +29,6 @@ static int mcb_pci_get_irq(struct mcb_device *mdev)
>  
>  static int mcb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> -	struct resource *res;
>  	struct priv *priv;
>  	int ret;
>  	unsigned long flags;
> @@ -52,15 +51,6 @@ static int mcb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		goto out_disable;
>  	}
>  
> -	res = devm_request_mem_region(&pdev->dev, priv->mapbase,
> -				      CHAM_HEADER_SIZE,
> -				      KBUILD_MODNAME);
> -	if (!res) {
> -		dev_err(&pdev->dev, "Failed to request PCI memory\n");
> -		ret = -EBUSY;
> -		goto out_disable;
> -	}
> -
>  	priv->base = devm_ioremap(&pdev->dev, priv->mapbase, CHAM_HEADER_SIZE);
>  	if (!priv->base) {
>  		dev_err(&pdev->dev, "Cannot ioremap\n");

TBH I'm not sure I like this approach.

One thing that could be done (and probably the easiest and most correct)
is resizing
the resource used for the header. Aka checking the header size and
dropping/reallocating
it once we have the correct size. It's not a fastpath anyways so we
don't really care about
reallocations here.

Another way would be flagging these ressources as IORESOURCE_MUXED but
that would need
quite some plumbing, especially for the 16z125 as it uses 8250_port for
requesting memory.

If these are specific FPGA versions/revisions, maybe they could be
quirked as well so we only
allocate as much space as we need.

I'm not too deep into resource manage any more, but
Documentation/PCI/pci.rst explicitly
states, that a driver must request the region to verify no other device
is alreay using the
resource.

So until you (or someone else) are proofing me wrong on these I'd say
NACK to this.

Byte,
    Johannes
