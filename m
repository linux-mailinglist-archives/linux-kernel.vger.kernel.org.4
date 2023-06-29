Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B95E742019
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjF2Fv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjF2FvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:51:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AC42D4C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 22:51:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-313e742a787so191167f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 22:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688017862; x=1690609862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=peZonunRaJ95r6T1skx2hyGoFsSu6wDgzOW9qrfM4Kc=;
        b=tgfy8qGSD65HWBeWSIUrq2wWBy9Vd26n+4f51LYynMfXR3xx01skrGd0sgmMs9OpTA
         cDfcerpQwY09qL8vel86+NmxTEhQm3d7DtER7CT5WcpLGRGcWN4tn6MU+ZAPaOy5EGMt
         9ONOUxTd0gHb4ERi6CPsC0jpfU6kqDRFQ/VbLOZJpmY/DHvICxEkLpC5RzneK7k7+bAs
         +5P3tk4Bk0OmQUYahxXdYCKj+cg1pSHaWjtPI7661o5+BEAMmXdiPABIbXPe8IcwZ37r
         nsFbf99Gk5ZwMYha6mtBhmDaM4auoL9kE8but4ai5jRteblHx2prqqfj8oZ6nV1zQtTz
         APoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688017862; x=1690609862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peZonunRaJ95r6T1skx2hyGoFsSu6wDgzOW9qrfM4Kc=;
        b=ZMAYoOun+DzgHaeL4XK37zojjp7EkIkqM9d4zUftZDLpcrEZQJ7bU66LIR0NjWB4CE
         k5RlvgM5PPHUIB0zD7r3Y4B7blok7UZ+BFxHV++etGsx7eDDN9LR4Wv6NZQGcKN+8tCI
         4Gb817isLh7DMGlf6fxoQTxXzMChQa7zYLhGINW4fIb7L7dD9p626Jffzquu417JoOcl
         O7ZiAUhAVU5lDa0ZLrF6poc5wp4y/XuZGMVtjOha8Tjknigb0YNZbzKPR3wDUez1P8on
         I76VsJFhZbq+T9pdBYLDcadZGkLaRmlI69NuuUxo87TqrwRELci3+CHK3dNyM0hbWily
         MGmg==
X-Gm-Message-State: AC+VfDybQHze8bla6pauPJ0N2WQGIMadYHtXyFEsc50vVKBs9DbMvMmX
        USIeohsnZeQ/RlFOynaO8etJ+Q==
X-Google-Smtp-Source: ACHHUZ46bnTv4fp7Jqwr00dopnJCmcDpYeZN2PzIZLASW0OP/E6OKDKyB66Uq90f9l+06/VSKbnd8w==
X-Received: by 2002:adf:fd51:0:b0:313:eeb0:224c with SMTP id h17-20020adffd51000000b00313eeb0224cmr3055104wrs.28.1688017861739;
        Wed, 28 Jun 2023 22:51:01 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z16-20020a5d4d10000000b00313eeca9f4asm11425249wrt.14.2023.06.28.22.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 22:50:59 -0700 (PDT)
Date:   Thu, 29 Jun 2023 08:50:57 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     yunchuan <yunchuan@nfschina.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
        quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next 08/10] net: mdio: Remove unnecessary (void*)
 conversions
Message-ID: <3fda1d81-e350-42e9-8fec-6f107ae75932@kadam.mountain>
References: <ZJwCcWgi0d6kEepI@shell.armlinux.org.uk>
 <325f00e3-1dfd-f77b-9795-6f89e44c0417@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <325f00e3-1dfd-f77b-9795-6f89e44c0417@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 09:59:56AM +0800, yunchuan wrote:
> On 2023/6/28 17:50, Russell King (Oracle) wrote:
> > On Wed, Jun 28, 2023 at 10:45:17AM +0800, wuych wrote:
> > > @@ -211,7 +211,7 @@ static void xgene_enet_wr_mdio_csr(void __iomem *base_addr,
> > >   static int xgene_xfi_mdio_write(struct mii_bus *bus, int phy_id,
> > >   				int reg, u16 data)
> > >   {
> > > -	void __iomem *addr = (void __iomem *)bus->priv;
> > > +	void __iomem *addr = bus->priv;
> > >   	int timeout = 100;
> > >   	u32 status, val;
> > > @@ -234,7 +234,7 @@ static int xgene_xfi_mdio_write(struct mii_bus *bus, int phy_id,
> > >   static int xgene_xfi_mdio_read(struct mii_bus *bus, int phy_id, int reg)
> > >   {
> > > -	void __iomem *addr = (void __iomem *)bus->priv;
> > > +	void __iomem *addr = bus->priv;
> > >   	u32 data, status, val;
> > >   	int timeout = 100;
> > These probably cause Sparse to warn whether or not the cast is there.
> 
> Hi, Russell King,
> 
> I didn't notice this Sparse warning.
> Should I remove this cast although it cause Sparse warning?

No.  Don't introduce new Sparse warnings.

regards,
dan carpenter

