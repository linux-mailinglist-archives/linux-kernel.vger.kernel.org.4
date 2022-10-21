Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414EE607989
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiJUO0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJUO0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:26:07 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B926126EDB6;
        Fri, 21 Oct 2022 07:25:59 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id y72so3387674oia.3;
        Fri, 21 Oct 2022 07:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MWmxzeBv04SeJOw6jKYpRv1e5SEanghL8yyC/XAz/0=;
        b=gMiAgI7wgWxz8toHeh4CwxCG9mChL1j2wpiIsmPfVC4Ijld+JOrM90VAx3bw8gsmgx
         BLHa1YTVrFXPYn/kULtAl81IqAGGj9sxmKT3K2rrXUiOVutZFOKOrIs5eOu7hhUG/zHx
         I3Z0AbwxG5arVbY0kgfHYqDSUITSvoTKs2nLhIKaTivAJWJXY1s/cK/1NPejsGWTGRbU
         x7xvDxrxWbNQUXanGATw2KBGXi2oGF+Bhe/QoSfXfiHHa5A0ZUtvqjq6URHj3e7KHxhJ
         SXG/n5gjsh9hSJH+q8+gm6Q7Xh5zlNiJjgQhbs3/o+dTHHdv0QYsbp9a+kZcA97ryJad
         3sjg==
X-Gm-Message-State: ACrzQf0N1r2251TR8bNqV/tuItVZW5rTiG4pdjcsRXwFo1RXKgjL98Uz
        IU8EzIP7b147l7zOGlU2vA==
X-Google-Smtp-Source: AMsMyM5waqqF2ZrhT4UdNdl/SeZivLSgo9IEVXbX8TNVdatsQdb89iPevIW908f0tKmIF3Fv496Zew==
X-Received: by 2002:aca:a84c:0:b0:355:4262:28ef with SMTP id r73-20020acaa84c000000b00355426228efmr11136678oie.14.1666362357884;
        Fri, 21 Oct 2022 07:25:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l10-20020aca190a000000b003549db40f38sm1118351oii.46.2022.10.21.07.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 07:25:57 -0700 (PDT)
Received: (nullmailer pid 3658172 invoked by uid 1000);
        Fri, 21 Oct 2022 14:25:58 -0000
Date:   Fri, 21 Oct 2022 09:25:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, robh+dt@kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] scripts: dtc: only show unique unit address warning for
 enabled nodes
Message-ID: <166636173496.3593878.13529338596528679973.robh@kernel.org>
References: <20221021084447.5550-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021084447.5550-1-alexandre.torgue@foss.st.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 10:44:47 +0200, Alexandre Torgue wrote:
> In some cases an hardware peripheral can be used for two exclusive usages.
> For example, on STM32MP15 we have the same peripheral for I2S and SPI. We
> have dedicated driver for each usage and so a dedicated device node in
> devicetree.
> To avoid to get useless warnings running "make W=1 dtbs", this patch adds
> the "-Wunique_unit_address_if_enabled" flag for a make with W=1. In this
> case we will detect a duplicate address only if both devices are
> enabled in the devicetree, which is a real error case.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 

Applied, thanks!

I refactored the options and kept 'unique_unit_address' for W=2.

Rob
