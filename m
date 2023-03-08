Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD6A6AFB0D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCHAZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCHAZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:25:55 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C58F7EC0;
        Tue,  7 Mar 2023 16:25:55 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-17683b570b8so14350220fac.13;
        Tue, 07 Mar 2023 16:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8qA3wiTpOTQTEufu+lX89OfEdwE/rERluNPvTrI/bQ=;
        b=G5/yxlJj4YKEBGgnurIrN1BzoGxXMuNV5+PpxoA95lvKGyy7dZajvghsHC/nPJiecq
         DLHr7g7Xe3H1K+OxDkGY0Px7PqCe8TurLkb8hs0hcIoGMJE99d2lx4U3Jf9FwovmVUe7
         Ayi6KS1eohUIarqH8DpuqT94V3ShJQyJgMad2WHJncNcRxNUFKgHnP+lMVO6I/xefrc8
         ugDEIF9eE89/Hpb+7GeM8FIXIDuM0Hge5GKbi8YPZlJmSuITnfAlYQHoZ5CHYsElPcK7
         WSQUTSr22FID8zA58BFNAHmGpjxVT5WWT3pcKtyD09y7HKP3shfuv4UvGT7+lOyqPLMv
         7H7g==
X-Gm-Message-State: AO0yUKUA517CE/GqUZa+oMPv/Po3Tp7vjpJs4ZPebuBBeYVwHAwFOs69
        RuxsMo9ZUXIVFE0qyzIZSg==
X-Google-Smtp-Source: AK7set/M1uyyiMd4GsLYEysZH4fwJuh2mfvxIsAMal5b5M/kBD5KwQ0X+O0EfOmunaj5X7wBHFF6zw==
X-Received: by 2002:a05:6870:414e:b0:16d:ccf9:bb4d with SMTP id r14-20020a056870414e00b0016dccf9bb4dmr9410387oad.39.1678235154336;
        Tue, 07 Mar 2023 16:25:54 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d44-20020a056870d2ac00b00172473f9fe0sm5727074oae.13.2023.03.07.16.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 16:25:54 -0800 (PST)
Received: (nullmailer pid 531600 invoked by uid 1000);
        Wed, 08 Mar 2023 00:25:53 -0000
Date:   Tue, 7 Mar 2023 18:25:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 06/21] usb: ulpi: Use of_request_module()
Message-ID: <20230308002553.GD513330-robh@kernel.org>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
 <20230307165359.225361-7-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307165359.225361-7-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 05:53:44PM +0100, Miquel Raynal wrote:
> There is a new helper supposed to replace of_device_request_module(),
> called of_request_module(). They are both strictly equivalent, besides
> the fact the latter receives a "struct device_node" directly. Use it.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/usb/common/ulpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
