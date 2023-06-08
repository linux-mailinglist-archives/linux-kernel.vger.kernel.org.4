Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D647281D1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbjFHNv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjFHNvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:51:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B2E19BB;
        Thu,  8 Jun 2023 06:51:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b0424c5137so4496025ad.1;
        Thu, 08 Jun 2023 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686232313; x=1688824313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVU4ia+uWzC6rzcUeHtrRHPc2aAMft5u4K82EZ822aU=;
        b=iUv6fBe+iMwYTDbtfK4oJ+14pjttNADPFI9CMs8nRoemKdhdVvd5Si8U1ApXnJT9rK
         HCKKsbGjIzSeXuqXXn1g9xHVNDgfFt5oPcwUPUiOVltV+8f9rAMCgBoQNztaosegUWMU
         xESrMCn/zwn/VnNSRG2Op78apdZSSobhWVRh/NxfiVbp6cfjEgQ82aBHwKVPBqCLjUXM
         NC/Dul1QJVT2ht4CN6L2ODcxlewdjt+71PLIqXR/nDB/IXFUqskXGNQNARGMXFj8noJc
         022zx+HI1LYYKrUzRl8pQBMUlIWtQlsHX6OkEwO8XuFfTIx5dZFZ/iIbKNMSgp5zrNeK
         3alQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686232313; x=1688824313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVU4ia+uWzC6rzcUeHtrRHPc2aAMft5u4K82EZ822aU=;
        b=XiQSllcoHnSnpjyOVgV5TpBMZd+aIfakPH4u7nlB32VsajPQrUALmb1TRx0m84A8Il
         D7B5z4TauuAfmx0dm9THkDx3Yye5cZhvXPyx1PeO4PZQDL+zqvGFY/boT1uK043G7Azw
         IkeYQPDXY11GT48MmZ6P7+CKI6hPyoO8OE6CeWmxXTa3Jtr1sBH6AVsi4wlrgougoU2Q
         /Chx1WcfzipUwuUKZzPCHCOfgUnCG28xW4Wx6AnPg1k3DRRwt9C9v+VXl/7ZMqNFsTjo
         jyzkvBfcjCxpFk+a/ksvNBoDh7vGattM2oD3KNzPluJj75uL50na6oWGSeULNGL/41su
         5o6Q==
X-Gm-Message-State: AC+VfDzPDQfzh2S/SBFO97HZeWAGYZKDhWgXav03M68BDGNG9+QLh3LS
        cmh+o8+qyaHhdKLlC6G8SMrpDd3JE08=
X-Google-Smtp-Source: ACHHUZ5lcvPCM6FvWKAV3fSk5CMpDyR9cqmN7PCdoE2GKBun6tKc2B+W/2EkGU4kza0bZ0Aei7es/w==
X-Received: by 2002:a17:903:22c3:b0:1b0:3df1:c293 with SMTP id y3-20020a17090322c300b001b03df1c293mr9254927plg.45.1686232312873;
        Thu, 08 Jun 2023 06:51:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d6-20020a170903230600b001ae57277a87sm1446635plh.255.2023.06.08.06.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 06:51:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 8 Jun 2023 06:51:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Baskaran Kannan <Baski.Kannan@amd.com>
Cc:     babu.moger@amd.com, clemens@ladisch.de, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (k10temp) Report negative temperatures
Message-ID: <64e6164a-c874-403e-b899-45f741db2130@roeck-us.net>
References: <20230523204932.2679-1-Baski.Kannan@amd.com>
 <68c53a76-efd5-42da-af98-442bd80c7300@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c53a76-efd5-42da-af98-442bd80c7300@roeck-us.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 02:46:46PM -0700, Guenter Roeck wrote:
> On Tue, May 23, 2023 at 03:49:32PM -0500, Baskaran Kannan wrote:
> > Currently, the tctl and die temperatures are rounded off to zero
> > if they are less than 0. There are industrial processors which work
> > below zero.
> 
> This was introduced with commit aef17ca12719 ("hwmon: (k10temp) Only apply
> temperature offset if result is positive"). This patch would effecively
> revert that change. Given the reason for introducing it I am not convinced
> that it is a good idea to unconditionally revert it.
> 

Any comments ? I am not inclined to accept this patch as-is. What are
the industrial processors ? Is there a means to detect them ?

Guenter

> Guenter
> 
> > 
> > To display the correct temperature remove the rounding off.
> > 
> > Signed-off-by: Baskaran Kannan <Baski.Kannan@amd.com>
> > ---
> >  drivers/hwmon/k10temp.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> > index 7b177b9fbb09..489ad0b1bc74 100644
> > --- a/drivers/hwmon/k10temp.c
> > +++ b/drivers/hwmon/k10temp.c
> > @@ -204,13 +204,9 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
> >  		switch (channel) {
> >  		case 0:		/* Tctl */
> >  			*val = get_raw_temp(data);
> > -			if (*val < 0)
> > -				*val = 0;
> >  			break;
> >  		case 1:		/* Tdie */
> >  			*val = get_raw_temp(data) - data->temp_offset;
> > -			if (*val < 0)
> > -				*val = 0;
> >  			break;
> >  		case 2 ... 13:		/* Tccd{1-12} */
> >  			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
> > -- 
> > 2.25.1
> > 
