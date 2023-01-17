Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CD166D5A7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 06:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjAQFgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 00:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbjAQFgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 00:36:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1473F17CD4;
        Mon, 16 Jan 2023 21:36:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0A97B80E76;
        Tue, 17 Jan 2023 05:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A99BC433F0;
        Tue, 17 Jan 2023 05:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673933777;
        bh=asJm1FEO3RCTI9yXgHpd6dK9DTZntJ1KAbCE9ko3y+Y=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=IcYiayCbWMGTTFIh0EEe0exejTDmWE9l0RjFiqBj98UmqkCalRXE3C4omasKau9Bn
         jByxdAKp/url4C9UtT8N3buxBDAVUl8pIhA0cyyfCncNXwsME08M3yDSzL6wbMSs2l
         8Z+CLVvKCSlRGs2954djFxzzG43Tk16nTxCB1S/yrGKJ/Ie8X6pmznF8r+XMw9iXzO
         Vx6yd0zWBVruK3dFlS1Q0+nXYxeK7C/8IJlgmKyM14LrsXfzEdViJwcMpolYOCKzG8
         0Cf5w5VIXYfPR7JGSYS01vSKylK5D5BxdQpZ4s8Dy7Ja5leb0RXU17tcz1dXIjH8kp
         i2jJpYQEnpdZQ==
Date:   Tue, 17 Jan 2023 11:06:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "phy: qualcomm: usb28nm: Add MDM9607 init
 sequence"
Message-ID: <Y8YzzCEqGi3m9fWM@matsya>
References: <20221214223733.648167-1-marijn.suijten@somainline.org>
 <Y8GY51Cfkj7o1MJs@matsya>
 <20230116203549.5jzd2olxua662n6w@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116203549.5jzd2olxua662n6w@SoMainline.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-01-23, 21:35, Marijn Suijten wrote:
> On 2023-01-13 23:16:15, Vinod Koul wrote:
> > On 14-12-22, 23:37, Marijn Suijten wrote:
> > > This reverts commit 557a28811c7e0286d3816842032db5eb7bb5f156.
> > > 
> > > This commit introduced an init sequence from downstream DT [1] in the
> > > driver.  As mentioned by the comment above the HSPHY_INIT_CFG macro for
> > > this sequence:
> > > 
> > >     /*
> > >      * The macro is used to define an initialization sequence.  Each tuple
> > >      * is meant to program 'value' into phy register at 'offset' with 'delay'
> > >      * in us followed.
> > >      */
> > > 
> > > Instead of corresponding to offsets into the phy register, the sequence
> > > read by the downstream driver [2] is passed into ulpi_write [3] which
> > > crafts the address-value pair into a new value and writes it into the
> > > same register at USB_ULPI_VIEWPORT [4].  In other words, this init
> > > sequence is programmed into the hardware in a totally different way than
> > > downstream and is unlikely to achieve the desired result, if the hsphy
> > > is working at all.
> > > 
> > > An alternative method needs to be found to write these init values at
> > > the desired location.  Fortunately mdm9607 did not land upstream yet [5]
> > > and should have its compatible revised to use the generic one, instead
> > > of a compatible that writes wrong data to the wrong registers.
> > 
> > Applied after adding missing subsystem tag, thanks
> 
> Thanks, it wasn't clear to me whether to suffix the title when already
> included in the Revert: "phy: qualcomm: ..." title :)

A revert patch is a patch as well so the patch rules apply there as well,
so should say "subsystem tag: other tags: Revert foo..."

Thanks
-- 
~Vinod
