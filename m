Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7076E25DE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjDNOgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDNOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:35:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D799AB471;
        Fri, 14 Apr 2023 07:35:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cm18-20020a17090afa1200b0024713adf69dso6301606pjb.3;
        Fri, 14 Apr 2023 07:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482952; x=1684074952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTHFZ7l3wE9U86eEphSFZ2rSKZCeThr+DNv8MnufPa0=;
        b=m6SgR51+8v/PMGG6QvtlNupBC9rNMUdoImHK5PLV19+bnrp6KQBNyHGKevIxItLZWU
         uRbrCR3n1dTdDKUu/L38sPKmnSiEWElJHZurlKdg6dpDVIj3kMUSuNhrjjbF97hx8kGI
         vlA9XQcDfEvp/XmrMoTPvMnnCgJxcGUJ81HC7ZintXC8AsN7tR44sjS5378640+NBi3g
         0Wt/aMgnRMJYtm9kvk6+/iWEUCgwXBsPBB8Fn2Zp4boIRu/Zdu3Eh2vodhz4sXWNaSQO
         yC2uhA3SLzOn77ZcfJ7bhuI0vqL3scMiWrvbkxYBOhs5j6quLBs62JXX71Ei8w6AyB2m
         bAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482952; x=1684074952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTHFZ7l3wE9U86eEphSFZ2rSKZCeThr+DNv8MnufPa0=;
        b=grbiA4GoLZla6QSy/VEIUPnF+JOuJYajJBxUPbEmLd5wFiio3uOgUmg8/iS2xxn4iV
         7cEF24MgUca0ILJT9DKT7nDx11xAAUtKdt+Lufarf2rCOmOT/80nUlY1GW6m2NOqSPS6
         ACNiE11dVL3esqkWT/kRHBlqLWOxiFtdaCnHQh3Bay7UjBy3e/RvgraORQuo5fOiF1W8
         PZNuc0BZg61BU+iDVdXZFSbmPcu5ttdED6JrlQ8zPZgMdIt3YSSG4S6RCf1j9hVhinQT
         otNCHCOEV/EgXp+hN0e403dxjLg9jGsUX8R87FH6wQ0bzM7kDmCRjiJnaPRoOdGtt7DA
         G0fw==
X-Gm-Message-State: AAQBX9eKdz6lgqhNA5ZSP7vDuAOsb5gHRwukmNMlAFfM1W8cFD+kK6Rm
        RP4+reI3B9v7+k72fEihBTM=
X-Google-Smtp-Source: AKy350bg4uHNIfn4f4T2pZkww85DA9c4Zb9RQaPzV3tdfT5FfZHGh9fhZCMdi7FqyJ7VEvhlqFsc7A==
X-Received: by 2002:a17:902:e5d2:b0:1a5:22f3:220d with SMTP id u18-20020a170902e5d200b001a522f3220dmr3850972plf.49.1681482952255;
        Fri, 14 Apr 2023 07:35:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902ed0200b001a6370bb33csm3162509pld.41.2023.04.14.07.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:35:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 14 Apr 2023 07:35:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH 1/2] dt-bindings: watchdog: marvell octeonTX2
 GTI system atchdog driver
Message-ID: <cf85d90f-ebfb-435a-925a-f0a3b4e970d6@roeck-us.net>
References: <20230414102342.23696-1-bbhushan2@marvell.com>
 <a5aa1be1-f98d-af04-9879-b924a5bcb14c@linaro.org>
 <DM5PR1801MB1883C0B40D8D7C84BA0435FDE3999@DM5PR1801MB1883.namprd18.prod.outlook.com>
 <875aaaa6-ac8a-fbf6-edd3-fde5444220b8@linaro.org>
 <DM5PR1801MB188392419EA5CD976986B085E3999@DM5PR1801MB1883.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR1801MB188392419EA5CD976986B085E3999@DM5PR1801MB1883.namprd18.prod.outlook.com>
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

On Fri, Apr 14, 2023 at 11:34:36AM +0000, Bharat Bhushan wrote:
> Please see inline 
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Sent: Friday, April 14, 2023 5:02 PM
> > To: Bharat Bhushan <bbhushan2@marvell.com>; wim@linux-watchdog.org;
> > linux@roeck-us.net; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > linux-watchdog@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [EXT] Re: [PATCH 1/2] dt-bindings: watchdog: marvell octeonTX2 GTI
> > system atchdog driver
> > 
> > On 14/04/2023 13:29, Bharat Bhushan wrote:
> > 
> > >
> > >>
> > >>> +
> > >>> +examples:
> > >>> +  - |
> > >>> +    soc {
> > >>> +        #address-cells = <2>;
> > >>> +        #size-cells = <2>;
> > >>> +
> > >>> +        watchdog@802000040000 {
> > >>> +          compatible = "marvell-octeontx2-wdt";
> > >>> +          reg = <0x8020 0x40000 0x0 0x20000>;
> > >>
> > >> Are you sure that this is correct DTS? 32-bit numbers are usually
> > >> 8-digit long. Plus size of 0x20000 is crazy huge. And the unit
> > >> address is a bit unusual. Are you sure dtc W=1 does not say about any errors in
> > your DTS?
> > >
> > > Each cell is 32bit, so if we specify less than upper values becomes zeros (0s).
> > 
> > ... and what is the convention/coding style of your subarch? Is to have short or 0-
> > padded reg addresses?
> > 
> > Anyway, I have doubts this was tested, so please confirm that dtbs W=1 and
> > dtbs_check produce no errors on your DTS. BTW, where is the DTS?
> 
> Our device tree are part of firmware and not in Linux.

Odd argument. That is true for pretty much every devicetree file.

Guenter
