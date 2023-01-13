Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B45366A13A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjAMRzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjAMRyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:54:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E32A25C0;
        Fri, 13 Jan 2023 09:47:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17E96B8163F;
        Fri, 13 Jan 2023 17:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9445DC433F0;
        Fri, 13 Jan 2023 17:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673632012;
        bh=pFf9JzNDw/gaL2e3i3Xnx474o61Ef0Q3FesKXT12MKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rXG37IuzqXeblx0Q4yCL2l6kUzV0wWRZNSp0Dzt+svPoJUb1FbU28nY6kt/sG8Kql
         Z4cR+JAjJxGM/fKWAXuRn2SDQWR9ZdZGQMCxM1lpXJTXvsFAqSObzojq2dSPM3yp1G
         +A0D/CsyjQqGpPB7V/vN+VlILDJR6dScdYSd37HZ8rlhayVWgX4/AnrWjy/io0hxFu
         5Cb32uzgJw0555wayt4RkW76EuRS4MjxE7Yc+OqwRjP0SjHZGdjBH22OI+/rqmyHbK
         jh5jRCaiURL1LOWAOQbMtTzvR66Lm1sL9PWprcSmLCabDs5jq1JrJbTiYURfYSMH8G
         n6kwJ6skDpcxg==
Date:   Fri, 13 Jan 2023 23:16:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
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
Message-ID: <Y8GY51Cfkj7o1MJs@matsya>
References: <20221214223733.648167-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214223733.648167-1-marijn.suijten@somainline.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-12-22, 23:37, Marijn Suijten wrote:
> This reverts commit 557a28811c7e0286d3816842032db5eb7bb5f156.
> 
> This commit introduced an init sequence from downstream DT [1] in the
> driver.  As mentioned by the comment above the HSPHY_INIT_CFG macro for
> this sequence:
> 
>     /*
>      * The macro is used to define an initialization sequence.  Each tuple
>      * is meant to program 'value' into phy register at 'offset' with 'delay'
>      * in us followed.
>      */
> 
> Instead of corresponding to offsets into the phy register, the sequence
> read by the downstream driver [2] is passed into ulpi_write [3] which
> crafts the address-value pair into a new value and writes it into the
> same register at USB_ULPI_VIEWPORT [4].  In other words, this init
> sequence is programmed into the hardware in a totally different way than
> downstream and is unlikely to achieve the desired result, if the hsphy
> is working at all.
> 
> An alternative method needs to be found to write these init values at
> the desired location.  Fortunately mdm9607 did not land upstream yet [5]
> and should have its compatible revised to use the generic one, instead
> of a compatible that writes wrong data to the wrong registers.

Applied after adding missing subsystem tag, thanks

-- 
~Vinod
