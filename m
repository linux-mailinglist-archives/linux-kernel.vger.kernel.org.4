Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420AD6B08B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjCHN2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjCHN2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:28:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBB720561;
        Wed,  8 Mar 2023 05:27:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DC973CE1FB1;
        Wed,  8 Mar 2023 13:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F74C433D2;
        Wed,  8 Mar 2023 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678282032;
        bh=zPgPnfEx7TTfrpkIeqTBW0I7Azvx8nMPmWHtRyKCwJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PFA7LXhTxi7fZ0XL539AtLSO14qzEVc3qRSHZy8NzpDARtmQqjMxzVgOIO/i9razz
         9SqttdgquWwv3rVzJ83PZ9Ply3rP+zSq5Wo9Od0WkyYzSRgsIJTya8mmsfggl/ITnb
         HrIc39qcOOnH3pFuQAn7ju2jrrVGxwqNUWj8gKyaFrb9QmYvb51CIyEhvCbHAT7X23
         byaEILnWonIBblDNm5t4/oVA5/NoRc68LykNHJvOIrIPkO6KHM5jh2RT+1MJH+570D
         6u5b7X1/sKTIRApWNN534etwOZWnFezOiNFNfnHgjivzezXlnwHHd3ZRbsyAZwE8ad
         K+Ey++rv4dnyA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pZtpm-0006Xi-Px; Wed, 08 Mar 2023 14:27:58 +0100
Date:   Wed, 8 Mar 2023 14:27:58 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Lux Aliaga <they@mint.lgbt>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org
Subject: Re: [PATCH v7 3/6] phy: qcom-qmp: Add SM6125 UFS PHY support
Message-ID: <ZAiNXmbep8nR6nkj@hovoldconsulting.com>
References: <20230306170817.3806-1-they@mint.lgbt>
 <20230306170817.3806-4-they@mint.lgbt>
 <25c17af5-8f6b-a2c3-dab3-f9bc69711db7@linaro.org>
 <ZAhrT1ICTQjfdeGq@hovoldconsulting.com>
 <64ab4061-6a8b-662e-1c7a-99b0da26751c@linaro.org>
 <ZAhwTcMZoCQVULQe@hovoldconsulting.com>
 <DE127158-6956-42E9-B7AE-9687B4ABD6DA@mint.lgbt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DE127158-6956-42E9-B7AE-9687B4ABD6DA@mint.lgbt>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 08:37:48AM -0300, Lux Aliaga wrote:
> On 8 March 2023 08:23:57 GMT-03:00, Johan Hovold <johan@kernel.org> wrote:

> >It seems a previous version of this patch was merged almost two months
> >ago.
> >
> >	9b9e29af984c ("phy: qcom-qmp: Add SM6125 UFS PHY support")
> >
> >Not sure what failed here.

> Yes, but it received some comments regarding using v5 offsets instead
> of v3-660. I could spin off this change into a new patch if necessary.

Once a patch has been applied, you generally need to do any further
changes incrementally on top.

It seems Dmitry renamed the struct himself after the patch was applied
in this case.

Johan
