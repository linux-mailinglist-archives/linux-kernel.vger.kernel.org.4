Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB777127EC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243665AbjEZOCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjEZOCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:02:34 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E580187
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:02:32 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2af225e5b4bso7646541fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20221208.gappssmtp.com; s=20221208; t=1685109750; x=1687701750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I24xOJUPwotirG7z+TXrhtcscl8kClafHqUY8HoH3jQ=;
        b=U+37g5QCWau8FMMqFyw7/ahikzVlf58I9L65O/nwVQziYDrjPcZMznL3rckunSpQHc
         kJNnr3PR8YRLcbN+E64/qviorAojRf7lrZ4es3pYuzv4RTaFFIcu0CbuopJ3Iq1R/Yjx
         BLtTtxR34MZEG3RO9GNxPiwD6yps/wmpiwmoPerA71MfLWpHG1X1XmeUgwvNvHCDgx/5
         E8gnoO8y7AtFcQr3fbnK7pCXJUPeKVBbPoZXTQIe54/+l+i4HKzSqHwcTdvD2iOWWg9x
         mBhebsRjbe5PkzJKUYtsqFy/ZgEcgcUCFdKWzwACYyWxl6JI+MVmiOu9Z2frtVdFtpYM
         6T0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685109750; x=1687701750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I24xOJUPwotirG7z+TXrhtcscl8kClafHqUY8HoH3jQ=;
        b=fWmDOFa+tVoH1dFU0NJ0zoku0IMir0038s762FMmJt0q8zfuvNkiOLVK29TzzPxqcV
         WvTMd/DCsaA0XWHqHppXPllMCXDPFXe+iwFvSKj4HNjrX6s3ik+bby9vk+GFRfYAaArA
         0wXz0nkpHplbd9FdNHfLZd/eDQuHJ05JE1jrSHc1434TB4A4nILphDlvkj3IY4kzcFiZ
         j5U2bRrIXaNBb+oi50URdtt0c3W9viPVpi4IoSCb+GfXGqSlk9jLSU4kb/vt3pJyMgft
         kn1u5PdkVc4wMxOCR5/RQW3GIYzHm/wu7Z0CyQgMRhbVCyC3dda4vNMeGAzCOFpVzCXj
         mVNQ==
X-Gm-Message-State: AC+VfDwwoSIrM03G59J44B5oDFUbkI6xkC6k5NYPEb2q8NaY6syVvsCM
        Z4wboRR3mLOZuVd69e360GXySQ==
X-Google-Smtp-Source: ACHHUZ6KsmwbD0WumVIxZybsAhOs0AkayBUKKYqlJF9vW/kh8LukQC/2MUJTJQo05NkI1GcIAc0zpw==
X-Received: by 2002:a2e:8843:0:b0:2a7:6e85:e287 with SMTP id z3-20020a2e8843000000b002a76e85e287mr817003ljj.45.1685109750513;
        Fri, 26 May 2023 07:02:30 -0700 (PDT)
Received: from builder (c188-149-203-37.bredband.tele2.se. [188.149.203.37])
        by smtp.gmail.com with ESMTPSA id o20-20020a2e90d4000000b002aecfa8c58bsm741809ljg.40.2023.05.26.07.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 07:02:29 -0700 (PDT)
Date:   Fri, 26 May 2023 16:02:27 +0200
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Parthiban.Veerasooran@microchip.com
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Horatiu.Vultur@microchip.com,
        Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v3 2/6] net: phy: microchip_t1s: replace
 read-modify-write code with phy_modify_mmd
Message-ID: <ZHC78yzOp/xIXKYL@builder>
References: <20230524144539.62618-1-Parthiban.Veerasooran@microchip.com>
 <20230524144539.62618-3-Parthiban.Veerasooran@microchip.com>
 <ZG9599nfDnkcw8er@debian>
 <f81c80cb-fbe8-0c7e-f0f9-14509f47c653@microchip.com>
 <ZHBbVNWeKK2di73h@debian>
 <6eb6893f-7731-dcc5-9221-048383bcbce4@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eb6893f-7731-dcc5-9221-048383bcbce4@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> /* Reference to AN1699
> >>    *
> >> https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/SupportingCollateral/AN-LAN8670-1-2-config-60001699.pdf
> >>    * AN1699 says Read, Modify, Write, but the Write is not required if
> >> the  register already has the required value. So it is safe to use
> >> phy_modify_mmd here.
> >>    */
> >>
> >> So in future, if someone wants to know about this configuration they can
> >> simply refer the AN1699.
> >>
> >> What do you think?
> >>
> > 
> > I'm not sure about the link, resources have a tendency to move.
> Yes, I agree with you but somehow there is no way for giving the 
> reference to this document. May be we will keep this link for the 
> reference, later if someone is not able to access the link then they can 
> request Microchip to get the document.
> 
> What do you think about this proposal? If you agree then I will proceed 
> for preparing the next version with your comments.

Thumbs up from me
R

> > Otherwise LGTM
> > 
> >> Best Regards,
> >> Parthiban V
> 
