Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42A66D69AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbjDDQ6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjDDQ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:58:53 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6262B3ABC;
        Tue,  4 Apr 2023 09:58:48 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-17997ccf711so35354917fac.0;
        Tue, 04 Apr 2023 09:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680627527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiNu1ACRu56K9bloHouaXrNZa/JCLgtThvUYRqbnw58=;
        b=lBHrmI4hrpjrBIiwUvV4fdcb0NK+SWBAm8vKjpdq1GzZ8tu73w0QQt501Ewa9gSRDM
         T4KCeGLojE4znvigwgn7TOjTODpJ/vAFeYkOe2muYymoCaKJAJzaMmUszCc20mKyqLMv
         vJ26nzOTsEfZoWJPVuqevMQOsbCzqHVBnDItRGJNwEGIn9lm/KwvZG1zFXi7SF4/xq2f
         NMh4GOgEv3pGFCa6wffFoajlua1NK0/AUUN07B1tsREpiG+eCMLCy2i/InliCxeVfTyS
         t1XVui8jggLUksoCs1/XgE++IpzhaG7lrWjcWEJGfD4nHILkbCdR3XIObSIIF053hxK3
         QrbA==
X-Gm-Message-State: AAQBX9fmaJXq2/u/EG4YXZ7PEaZu6H+bRtObFD2pvK/C75OBUSTBRczD
        u3wZrg+JzfEcvagJo0anJQ==
X-Google-Smtp-Source: AKy350ZCXusNb0GY54vqNjcB+19rcJ0QVPtVsjXBfRiKkGVSG03QFymysoMWHm6BrxE9RNOeVe2vOA==
X-Received: by 2002:a05:6870:638a:b0:17d:1f3:3016 with SMTP id t10-20020a056870638a00b0017d01f33016mr52065oap.5.1680627527584;
        Tue, 04 Apr 2023 09:58:47 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id vc12-20020a0568708f4c00b00172426ebe58sm4883176oab.27.2023.04.04.09.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:58:47 -0700 (PDT)
Received: (nullmailer pid 56057 invoked by uid 1000);
        Tue, 04 Apr 2023 16:58:46 -0000
Date:   Tue, 4 Apr 2023 11:58:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] firmware: Use of_property_present() for testing DT
 property presence
Message-ID: <20230404165846.GA49361-robh@kernel.org>
References: <20230310144704.1542045-1-robh@kernel.org>
 <20230323120030.7mk62xk7tco32zw2@bogus>
 <ZCwmWoZhMOlHnnzf@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCwmWoZhMOlHnnzf@orome>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 03:30:02PM +0200, Thierry Reding wrote:
> On Thu, Mar 23, 2023 at 12:00:30PM +0000, Sudeep Holla wrote:
> > On Fri, Mar 10, 2023 at 08:47:04AM -0600, Rob Herring wrote:
> > > It is preferred to use typed property access functions (i.e.
> > > of_property_read_<type> functions) rather than low-level
> > > of_get_property/of_find_property functions for reading properties. As
> > > part of this, convert of_get_property/of_find_property calls to the
> > > recently added of_property_present() helper when we just want to test
> > > for presence of a property and nothing more.
> > > 
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  drivers/firmware/arm_scmi/optee.c | 2 +-
> > 
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>(for the SCMI part)
> > 
> > I am assuming you will route this as it has other changes as well in the
> > patch.
> 
> I can also pick this up along with the Tegra changes if Rob doesn't
> want to take it. But also feel free to take this through whatever tree
> works best, for the Tegra parts:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>

You can take it. Thanks.

Rob
