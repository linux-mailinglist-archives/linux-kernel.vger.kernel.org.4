Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FA3611258
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiJ1NID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiJ1NHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:07:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68655B538;
        Fri, 28 Oct 2022 06:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F5CFB8298A;
        Fri, 28 Oct 2022 13:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0EDC433C1;
        Fri, 28 Oct 2022 13:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666962438;
        bh=KqluL/CAr3SUlElvnxxgfbjkXmXWuUwxysD/RzhVQrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nw9CI4BJyOG4IJC99m0pn/JoWR9b4Sc131ghvJcg+B90SgRN55urC9NeH2HJ4HU1Y
         X8NK/XskA3hD7N75D7+KwtTcqO3ZMDqDT7IOsL7PP76gRSKFnpEWPJBsug/tkOOycI
         oCBSF15yAn750jpt2I/8NovAFOXgLTrwLvedbzT/VC/GhXRPrkPp+lIGugBQA6RHXg
         DPBhkqmlzakZqneysbvNQE0xh6yT9v3gCiW/k/pPVkjFv8UkhUuU3+HaI6Y+soeRXA
         75eRSv3XtNvYRMsKj/JvU8eZ1TCl/lMqhgROyG0DZRGPRatac+3NVzrsO3kDCYo8MC
         l15qN+CMDFL3g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ooP4h-0001JE-9Z; Fri, 28 Oct 2022 15:07:04 +0200
Date:   Fri, 28 Oct 2022 15:07:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/15] phy: qcom-qmp-pcie: add register init helper
Message-ID: <Y1vT94blD9PJHKDp@hovoldconsulting.com>
References: <20221021110947.28103-1-johan+linaro@kernel.org>
 <20221021110947.28103-9-johan+linaro@kernel.org>
 <932765e0-ecbc-8c9b-69c5-ce0bb0c8de68@linaro.org>
 <Y1KDXD9n0cCqjTGy@hovoldconsulting.com>
 <Y1vRDv+hrMmnqwPj@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1vRDv+hrMmnqwPj@matsya>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 06:24:38PM +0530, Vinod Koul wrote:
> On 21-10-22, 13:32, Johan Hovold wrote:

> > [...] This is not about keeping the
> > diff small, this is about readability of the new helper function as I
> > already told you.
> > 
> > And this is a *local* identifier, not some state member that needs a
> > super descriptive name. And the rest of the driver used "tbl"
> > consistently until your EP/RC mode patches for that matter.
> 
> I would disagree here... You can change tbls/tables but then it does not
> help _this_ patch
> 
> Right thing would be to change tbls to tables first and then add init
> helper... For a reviewer seeing an undocumented change and unnecessary
> diff is not right..

I still think that it belongs in the patch adding the new helper
because it is essentially only in that new function that the improved
readability due to the shorter identifier matters (the earlier helpers
where per table type).
 
> Pls split if you would still like the rename

But if you prefer I'll split it out in a preparatory patch.

Johan
