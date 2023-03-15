Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575ED6BBB41
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjCORrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjCORrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:47:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ACE49DE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2F2261E14
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C5AC433EF;
        Wed, 15 Mar 2023 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678902398;
        bh=8hA6UGitqz8/PjMOldZ4ee3+Tb6IiyQ9hvwclhtFjQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iw1aiWUseK7W4mzBcPjsGjJ5GygqJ5VWsvlAF6EBBNFg0xrjLyaMmeEnlOjVk1/Ju
         8ZRKr0TpuDyL1GsRbhrThQ2NoQ+SrdTGnCEZFHpwyzmsY6eB5i3qH+Jb+pxHIOyWPS
         fxK5nt+DmmDRMxlHj0Pqf1ROyM1XIx/0AfkHrljr7ltCf134A2zpOoaxhtHjoxXu7l
         NEIoNFB4NbN0qORN8ZmL7QSU0C3iaXYf18q0jR6zYEP2KGsBwvprFqRDlEWD9sPezH
         +lgQtiYvXhc9y4WaJ1PvcpTWFS4Oo0bXGG6Acf+j+WSfOPsDIarvQfauiJ/pPtBhpl
         TPZG1lSdGQTEg==
Date:   Wed, 15 Mar 2023 17:46:34 +0000
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
Message-ID: <20230315174634.GH9667@google.com>
References: <20230307121246.127425-1-Naresh.Solanki@9elements.com>
 <20230307121246.127425-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230307121246.127425-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2023, Naresh Solanki wrote:

> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>
> Implement a regulator driver with IRQ support for fault management.
> Written against documentation [1] and [2] and tested on real hardware.
>
> Every channel has it's own regulator supply nammed 'vss1-supply' and
> 'vss2-supply'. The regulator supply is used to determine the output
> voltage, as the smart switch provides no output regulation.
> The driver requires the 'shunt-resistor-micro-ohms' to be present in
> the devicetree to properly calculate current related values.
>
> You must specify compatible devictree layout:
>
> regulator@3a {
>         reg = <0x3a>;
>         vss1-supply = <&p3v3>;
>         compatible = "maxim,max5978";
>
>         ...
>
>         regulators {
>                 sw0_ref: SW0 {
>                         regulator-compatible = "SW0";
>                         shunt-resistor-micro-ohms = <12000>;
>                         ...
>                 }
>         }
> }
>
> 1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
> 2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ...
> Changes in V12:
> - Use simple_mfd_i2c driver and remove previous implementation.
> - Remove newline
> - Use _MFD_MAX597X_H in header file
> - Successfull build need following patch from regulator:
> https://lore.kernel.org/r/20230216075302.68935-1-Naresh.Solanki@9elements.com
> https://lore.kernel.org/r/20230210163225.1208035-1-Naresh.Solanki@9elements.com
> ---
>  drivers/mfd/Kconfig          | 10 ++++
>  drivers/mfd/simple-mfd-i2c.c | 13 +++++
>  include/linux/mfd/max597x.h  | 96 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+)
>  create mode 100644 include/linux/mfd/max597x.h

Applied, thanks

--
Lee Jones [李琼斯]
