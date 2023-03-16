Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87506BCFD9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCPMtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCPMtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:49:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710FE36FEA;
        Thu, 16 Mar 2023 05:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E37D362000;
        Thu, 16 Mar 2023 12:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF12BC433EF;
        Thu, 16 Mar 2023 12:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678970962;
        bh=2hIIa27J4OufttFD58aRpuD3JQNUHcSmgwP80p7hQDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZdGIneuWnom/b6edum2ICmxf9259ZsE/zcc1wnP4XX4bt94xlSUpUokRxEBTgpnYZ
         dvlD06MCX34+PpBfnp7xcrc86g7kv3zVy09Gut1+RdEnEYmURFLNAdBU3QNFWN9zYi
         PaWIinxcjc6N6f2VVRl7oCs5TGb54Om9vhaHJ7rE=
Date:   Thu, 16 Mar 2023 13:49:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/7] drivers: misc: Add support for the Lantiq PEF2256
 framer
Message-ID: <ZBMQTxFsrKQesd4v@kroah.com>
References: <20230316122741.577663-1-herve.codina@bootlin.com>
 <20230316122741.577663-3-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316122741.577663-3-herve.codina@bootlin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 01:27:36PM +0100, Herve Codina wrote:
> +EXPORT_SYMBOL(pef2256_get_byphandle);

You have a mixture of EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL() in the
same file here.  As this one:

> +
> +void pef2256_put(struct pef2256 *pef2256)
> +{
> +	put_device(pef2256->dev);
> +}
> +EXPORT_SYMBOL(pef2256_put);

Is just a wrapper around a EXPORT_SYMBOL_GPL() function, please revisit
and perhaps make them all EXPORT_SYMBOL_GPL() calls?

thanks,

greg k-h
