Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B98731E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbjFOQtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbjFOQtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:49:04 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3883295E;
        Thu, 15 Jun 2023 09:48:26 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-77acb944bdfso438110439f.0;
        Thu, 15 Jun 2023 09:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686847706; x=1689439706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFEsL0GLVi4RtgCxkqPyG2MNt0gsxqeP3X7GxfYbipY=;
        b=aLYciXUGRWgVNNr4iu6vLi2e5fmDknWIi1WjZqVKJWSp55Z9GLHwSeSQATA6QPAiqe
         Ftb8ygeNQoIk0+FAs8y6EEvuACwH91cUwq6B1IsGqAOtvJR4TtbEbIf4E7dLop4FeA5d
         Uou72qGylt+jhp37fiVRZ3Y3pvNTMymMfm2MT/FeGfaf2Y5Hwbi9iTuzFoASEh52zIRG
         n6XMBxOGOANIYqGfiwi1kZPOO/4YgTVPMdbAPdzS9Rry1r1+RrytqmCY1erYZWTYRaZs
         YexH46Paf7upRZqY0X5aoeUqvrKjj+5xGyGuoAwbfxhK5cNFngtRG34XU2JHV+DXUbjZ
         PfsQ==
X-Gm-Message-State: AC+VfDwZAbvsrC+e3x3b8MrCGcjY7kINEjEQbf09knIEh6CwjfoDtoBs
        soksQtSA/Yz3Oy7N/nEVGX4Bo63ZmQ==
X-Google-Smtp-Source: ACHHUZ7bj1TVUIo7zoNAxxsfF8oCMe4jDqlwq7B3hEb2xidbQ0+mRqXB8w9fmR00nVMNWaZRdFbcfg==
X-Received: by 2002:a6b:fd17:0:b0:76c:62ab:5d96 with SMTP id c23-20020a6bfd17000000b0076c62ab5d96mr20199987ioi.19.1686847706093;
        Thu, 15 Jun 2023 09:48:26 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z3-20020a5ec903000000b0077ac811b20dsm6123778iol.38.2023.06.15.09.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:48:25 -0700 (PDT)
Received: (nullmailer pid 1177025 invoked by uid 1000);
        Thu, 15 Jun 2023 16:48:22 -0000
Date:   Thu, 15 Jun 2023 10:48:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/1] of/platform: Propagate firmware node by calling
 device_set_node()
Message-ID: <168684770004.1176923.6901939518921030402.robh@kernel.org>
References: <20230615145243.37095-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615145243.37095-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Jun 2023 17:52:43 +0300, Andy Shevchenko wrote:
> Insulate of_device_alloc() and of_amba_device_create() from possible
> changes to fwnode_handle implementation by using device_set_node()
> instead of open-coding dev->dev.fwnode assignments.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/of/platform.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 

Applied, thanks!

