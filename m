Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB856AFB0F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCHA0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCHA0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:26:51 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC6EA102B;
        Tue,  7 Mar 2023 16:26:50 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id c11so11045043oiw.2;
        Tue, 07 Mar 2023 16:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Hkby2vlQx0f1o01FlGJdqmioVTYUXHKkOhCJhmTdGw=;
        b=lU3/ui7ugzmJX91DigSgyQGBDbGhocmtHGT+5BcmusG3yYctARVwri4gN5OoJ8K5GB
         FSZs8zJ0LNICuzgZWd/a7g7GE/bW70WkssOtyAkm7nXmQBet0d0VMReJFRmIy4C+6jAw
         a91B5AdZSu0n71k9Z9Y6c2l4eTlwFScvNX4NEbUNXQkYpIdyteiXEKAVmMc195OJgAyd
         xs+iecV4lG31is/gWn5iVGKui/J0SkEWBTjvXBpGXCq9GwLbcLUvEoI8VaU2S84UUjQd
         wSabjoSuOWCmZk3AIs9a45HwBYxJ6bJVAhDQoyvP0Gcp30MsOAlS1ymJXcOrU0nj0H65
         /PRA==
X-Gm-Message-State: AO0yUKVYAYiME3JXLtaUJ19vhRgeR2o05I5qLZZS0jy3TFiNYDdfAefL
        sT6U2GrkoBx+J8itj8rZhkwVZjHOcDhM
X-Google-Smtp-Source: AK7set98lOyt6Rzk2C+QJuBTx2FmZYIWP2K1cMounTBTvx1y0p0Ul2EbnET+gyz322U/l0LCBjLtnA==
X-Received: by 2002:aca:2809:0:b0:35e:4192:5da8 with SMTP id 9-20020aca2809000000b0035e41925da8mr7308376oix.52.1678235209857;
        Tue, 07 Mar 2023 16:26:49 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e129-20020acab587000000b003847ca255fasm5818742oif.30.2023.03.07.16.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 16:26:49 -0800 (PST)
Received: (nullmailer pid 532613 invoked by uid 1000);
        Wed, 08 Mar 2023 00:26:48 -0000
Date:   Tue, 7 Mar 2023 18:26:48 -0600
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
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/21] of: device: Kill of_device_request_module()
Message-ID: <20230308002648.GA532107-robh@kernel.org>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
 <20230307165359.225361-8-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307165359.225361-8-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 05:53:45PM +0100, Miquel Raynal wrote:
> A new helper has been introduced, of_request_module(). Users have been
> converted, this helper can now be deleted.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/of/device.c       | 9 ---------
>  include/linux/of_device.h | 6 ------
>  2 files changed, 15 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
