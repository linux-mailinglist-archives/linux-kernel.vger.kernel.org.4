Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDCE6E1CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDNHH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNHHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F992358A;
        Fri, 14 Apr 2023 00:07:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A95C96442F;
        Fri, 14 Apr 2023 07:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D9CC433D2;
        Fri, 14 Apr 2023 07:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681456073;
        bh=leq9UGYYDxJ5qeejBWsEvNY2y+gGUIqDDe6MNk/qmsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ith2rptmH3lkLgjnSQxC6xEV6u5X6eWkyQwRr/mRe9Qf6AsoFcPTQTI54iOkLm1GR
         Rf7MoCirXwGp8nZfm2UBJbFVi9wAoq79eIOnbNobW87YmDGxbFxmLfC8jXCf0/I/sQ
         EHuUEpg+iEuMk/iOmSwxCt+z42GGcr0mm9Is06F+jr5+zsCPPDngvQ/1kaDp27PbKQ
         gvhFk4tt8DRKtTmtJ1nxa+s9yfN4WY3HjQbU7KVr2hS4ZWl8nVvIfeKnmm2ZZK6NlN
         ax8osBbssd4fOPUrlxs0dJn7FD5HFXeZqxfdZzadL1wnAJhAiV1a8oXfVSOA14IEhG
         uxDpIbWJSMgJQ==
Date:   Fri, 14 Apr 2023 08:07:48 +0100
From:   Lee Jones <lee@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Pavel Machek <pavel@ucw.cz>, sean.wang@mediatek.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 7/7] leds: leds-mt6323: Add support for WLEDs and
 MT6332
Message-ID: <20230414070748.GB1036697@google.com>
References: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
 <20230412153310.241046-8-angelogioacchino.delregno@collabora.com>
 <ZDfiNSAs3Bc7xe1l@duo.ucw.cz>
 <76c89ad1-a189-c907-590c-35ae6b7edd9e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76c89ad1-a189-c907-590c-35ae6b7edd9e@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023, AngeloGioacchino Del Regno wrote:

> Il 13/04/23 13:06, Pavel Machek ha scritto:
> > Hi!
> >
> > > Add basic code to turn on and off WLEDs and wire up MT6332 support
> > > to take advantage of it.
> > > This is a simple approach due to to the aforementioned PMIC supporting
> > > only on/off status so, at the time of writing, it is impossible for me
> > > to validate more advanced functionality due to lack of hardware.
> >
> >
> > > @@ -467,14 +590,24 @@ static int mt6323_led_probe(struct platform_device *pdev)
> > >   			goto put_child_node;
> > >   		}
> > > +		is_wled = of_property_read_bool(child, "mediatek,is-wled");
> > > +
> >
> > This needs documenting in the binding, no?
>
> Yes, and I forgot to. Would it be okay if I send a supplementary patch out
> of this series to document that since the bindings are already acked?

You can add the support as part of a new patch.

Please resend this series with it attached.

--
Lee Jones [李琼斯]
