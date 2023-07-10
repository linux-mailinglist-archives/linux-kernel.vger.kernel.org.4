Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C656274D4E0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjGJMBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjGJMBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCA8F9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:01:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9A0060FD8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18618C433C8;
        Mon, 10 Jul 2023 12:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688990471;
        bh=hi2KjYVNB1fgMeU4P1IicTBxc+ULEU0k8ide4WBCPI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eUf+bOsBAEEtyVa+Tu1NcCxNEphDSnC05lrP4V2VIQBaufImErwI42F5EzPJ0MezX
         SKXml0eAJvfoOhNufaG/FFftOj5O85WkSU+EoDWLvENzmFx3yMOfr58/Cf1Z0cKQvc
         43NWvDGjxTh58W/y+ucwfNf12IomMSRZh9iZUPtDAl5l8bAoI9bLjUJsyy6Qp9O1kt
         VpP37cZyPeIkUkFQe9ycH3/S/plF5OkiXOA8SZ92QcKQshxDOzXiWgPQIWhgciIf05
         JfSeULY9SLcRUHCMIBMkqQxmfAjcqdKcFA/++E4awkkOmZtLjY1Rea/dBIhZx/KQSh
         baWFwlbKT/rGg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qIpaD-0003Lu-15;
        Mon, 10 Jul 2023 14:01:37 +0200
Date:   Mon, 10 Jul 2023 14:01:37 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Alex Elder <elder@linaro.org>
Subject: Re: [PATCH 7/8] ASoC: topology: suppress probe deferral errors
Message-ID: <ZKvzITFLCQzmw72w@hovoldconsulting.com>
References: <20230705123018.30903-1-johan+linaro@kernel.org>
 <20230705123018.30903-8-johan+linaro@kernel.org>
 <ac232872-734f-d192-d46c-555ebe3625c5@linux.intel.com>
 <ZKZbzctgLpV-67hJ@hovoldconsulting.com>
 <f464d5b1-c708-4b3f-f1d1-031c5def5b38@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f464d5b1-c708-4b3f-f1d1-031c5def5b38@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 09:25:26AM +0200, Amadeusz Sławiński wrote:
> On 7/6/2023 8:14 AM, Johan Hovold wrote:

> > In short, it is not correct to use dev_err_probe() here as this is not a
> > probe function.
> > 
> > dev_err_probe() is tied to driver core and will specifically allocate
> > and associate an error message with the struct device on probe
> > deferrals, which is later freed when the struct device is bound to a
> > driver (or released).

> I guess you mean call to: device_set_deferred_probe_reason(dev, &vaf);
> perhaps functionality could be extended to allow to skip this call and 
> just do prints? Or just add separate dev_err_defer function without this 
> step, although it would be best if they could share parts of code.

Feel free to suggest adding such a function if you think it's
worthwhile. It doesn't exist today it should not be a prerequisite for
suppressing these error messages.

Johan
