Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A26362C746
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiKPSJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiKPSJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:09:54 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD2B1A81D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:09:53 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so3049065pjs.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uha19DGn1cipYAwBOyrw3AdHNrtOnbopGJxC7rXrQ/k=;
        b=ZDqc3cq8Ax6Pt6u3GCJwqCQZVVe1CuQQnKni3FkP4DUVLls/bdpD3QXrmfOOLJ/OU+
         Jfv4C5/TqWM2DDHgO720x5Xcq/Vqfv1/a4KOb90OGfQ6qrkPrsaGi1fUvHiX1KF9glmC
         8V3yRUNVIGVUj/LQvT73c5YIIXHdiXQoBUdeFQJKy7n2L+ovNz88ysop7e8LvEn3+Ec+
         +tg1la6B4pqMhnJR9x0Enmk075wDgOrbqks9VPnVj0POpmGvJTxRzOJCu4SjKweioIIE
         8iBf5mr2Vlg8QBQllPtwzgMOAOEmnyoevookW7dt2aNmmznrCk+id7Mq9hj3iZ6GWgTQ
         5UHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uha19DGn1cipYAwBOyrw3AdHNrtOnbopGJxC7rXrQ/k=;
        b=ILQir+uHVHZpKY1k9FsLRnNLL0qlEJvm4oaMQvYOl45Pl+0qdxU87rZSJeASerCxiW
         ECYWS0KTkihJ0BnVJ1tO7QvZKL/8VY/zuM/8kKNK+eOMf+Dna+3ZPdFjwwilRu8jcut1
         fp5Bw6vEKKkW15RiE5qzYncX0y1q2R71N3oNDK96qtIolRNTKGgqQpt65nBgl/YREkzU
         LxfY9024bRyqkG+YJF54LuakAZr4g8v6oVO6fAC3s6tjFh8FNlt1uEInM60zKPFe9Ugr
         M/TxAeOdcSQrHGUa0PlBr+soKpPqVUjaNdZr/3r+aihChRagpbWHijPG+8yMJZZatrZg
         5OXg==
X-Gm-Message-State: ANoB5pmVWYXZY/xcNTptUDRpCcp5u19UymedF00H1VRLo3YmySS2xPyk
        6XsOVHZNenyjRFytlq1vWz4pdg==
X-Google-Smtp-Source: AA0mqf4faQyRgiiosbyugC6bNzLWoQKMwQYCzT7xgnogs350R64d9WVcRuMgRBcxR8HLMnc+FSrCWw==
X-Received: by 2002:a17:90a:6049:b0:218:4d16:cecf with SMTP id h9-20020a17090a604900b002184d16cecfmr4799475pjm.96.1668622192609;
        Wed, 16 Nov 2022 10:09:52 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a19d000b0020ad53b5883sm1917200pjj.14.2022.11.16.10.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:09:51 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:09:49 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     MD Danish Anwar <danishanwar@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, nm@ti.com, vigneshr@ti.com,
        srk@ti.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 1/6] dt-bindings: remoteproc: Add PRU consumer bindings
Message-ID: <20221116180949.GC61935@p14s>
References: <20221116121634.2901265-1-danishanwar@ti.com>
 <20221116121634.2901265-2-danishanwar@ti.com>
 <20221116160948.GA169555-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116160948.GA169555-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:09:48AM -0600, Rob Herring wrote:
> On Wed, Nov 16, 2022 at 05:46:29PM +0530, MD Danish Anwar wrote:
> > From: Suman Anna <s-anna@ti.com>
> > 
> > Add DT schema binding for PRU consumers. The binding includes
> > all the common properties that can be used by different PRU consumer
> > or application nodes and supported by the PRU remoteproc driver.
> > These are used to configure the PRU hardware for specific user
> > applications.
> > 
> > The application nodes themselves should define their own bindings.
> > 
> > Co-developed-by: Tero Kristo <t-kristo@ti.com>
> > Co-developed-by: Suman Anna <s-anna@ti.com>
> > Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> > Co-developed-by: Puranjay Mohan <p-mohan@ti.com>
> > Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> 
> Run checkpatch.pl and fix the warnings with the tags.

My bad - I asked Danish to remove the SoBs to lighten the changelog
presentation.  Danish, do you absolutely need to list everyone that touched that
patchset?  If so I suppose just listing the SoBs would be a compromise.

> 
> You didn't add review/ack tags either.

Those are important.  

Please send another patchset that clears checkpatch with review/acks and I'll
look at it.

Thanks,
Mathieu

> 
> > ---
> >  .../bindings/remoteproc/ti,pru-consumer.yaml  | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
