Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52476737094
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjFTPfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjFTPfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:35:04 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2FA198;
        Tue, 20 Jun 2023 08:35:03 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-77e2f4498d3so189520639f.1;
        Tue, 20 Jun 2023 08:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687275302; x=1689867302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34IeiC/L9E1MwwlaWrlBd7sxpmimp9Mx9aQL9KsP4Zw=;
        b=EfzINjG0NQhi+YXQNvQgkOKXRbCEzOK/L3rbIJ7+jbQcDZzwOEyvPNh5cyRIaUwFN/
         gs63bdC8y3eoSLMw4zYa0PEl8fz2qwwlFLKH8PDmP36qwohB8Z3gYhTCzzj1u26vlpGt
         cO5gedyvA5lmRSuXD3O57A5KpvzO+gAnsYZHCPMUOn6nG9smqkQobwm1q28RDu6Jdn3M
         sUWL1ru3+G+dyF8kf5RKyW+4kJrjdTrKCtcorBfjJ6Lqsc5sFdQsVCiR2T7mMXUGDFX1
         do7fF3Os9yqcx0G/+umV4wkaQCdAf8a6UsMJjQyC9S5lR8C0peLY8uPeLj5fAG1ZpgwP
         cXqw==
X-Gm-Message-State: AC+VfDzC/vhqbAaaSfxWmPwEFFx3yKOz+srXMPx+21G6F3OUCI7bq51b
        D6Ww8YXu2XKW/0N6AP4GPtxSaar0UA==
X-Google-Smtp-Source: ACHHUZ60Z3HFmKQ6GL2eorW9CFFtnVT6Cdb02pPVLIj9UOrKv766YYxg/CjFot0TmKrDrOg4lRlkGQ==
X-Received: by 2002:a92:cb50:0:b0:342:6f0:d1e9 with SMTP id f16-20020a92cb50000000b0034206f0d1e9mr13080565ilq.26.1687275302532;
        Tue, 20 Jun 2023 08:35:02 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l2-20020a92d8c2000000b003424b3d6d37sm684153ilo.24.2023.06.20.08.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 08:35:01 -0700 (PDT)
Received: (nullmailer pid 3637405 invoked by uid 1000);
        Tue, 20 Jun 2023 15:35:00 -0000
Date:   Tue, 20 Jun 2023 09:35:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        devicetree-spec@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2 2/2] of: reserved_mem: Use stable allocation order
Message-ID: <168727529919.3637328.11452341509705803196.robh@kernel.org>
References: <20230510-dt-resv-bottom-up-v2-0-aeb2afc8ac25@gerhold.net>
 <20230510-dt-resv-bottom-up-v2-2-aeb2afc8ac25@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510-dt-resv-bottom-up-v2-2-aeb2afc8ac25@gerhold.net>
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


On Wed, 14 Jun 2023 21:20:43 +0200, Stephan Gerhold wrote:
> sort() in Linux is based on heapsort which is not a stable sort
> algorithm - equal elements are being reordered. For reserved memory in
> the device tree this happens mainly for dynamic allocations: They do not
> have an address to sort with, so they are reordered somewhat randomly
> when adding/removing other unrelated reserved memory nodes.
> 
> Functionally this is not a big problem, but it's confusing during
> development when all the addresses change after adding unrelated
> reserved memory nodes.
> 
> Make the order stable by sorting dynamic allocations according to
> the node order in the device tree. Static allocations are not affected
> by this because they are still sorted by their (fixed) address.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  drivers/of/of_reserved_mem.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Applied, thanks!

