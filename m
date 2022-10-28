Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE14A61125D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiJ1NIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJ1NI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:08:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589D76C74B;
        Fri, 28 Oct 2022 06:08:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEEFF62856;
        Fri, 28 Oct 2022 13:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF53C433D6;
        Fri, 28 Oct 2022 13:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666962506;
        bh=ECi5ZL9/CovQrvlXRqJIBv8wWvMwdtva2tmSf8ayGz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHCV8/xrqJ4VydITOXS6s0km2idgLo5DtBEjthmVLki9+Blqo7INGNTqczdDJm2sT
         mK767JbQIE7BlOVsk0Z5DZ8H/HLzqQMMVT9rO+aynsEWPr5PmN6r7WDQtFPPKbpq0x
         lTlTZbQoS9DQ3OSYADBVZ8xT2iyWjj2esS1qSG9KqC0sEUrXlJ5/xyyYZHoLlO+vkg
         jfqPyEPZO6BBpZAqrOXB4zmKiSar/7WatDoceZJVlQ6UWFAQ35vZhijJQyeLjy82Fl
         S8T0WP/bRw9VxtHA/k+Dshomv9ornM7Dbz6ThoDAJwMuTVNNwbU3yaS+DKybALYX0w
         xOYxbceKs4/iw==
Date:   Fri, 28 Oct 2022 18:38:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan@kernel.org>
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
Message-ID: <Y1vURr4xPZD5/bh0@matsya>
References: <20221021110947.28103-1-johan+linaro@kernel.org>
 <20221021110947.28103-9-johan+linaro@kernel.org>
 <932765e0-ecbc-8c9b-69c5-ce0bb0c8de68@linaro.org>
 <Y1KDXD9n0cCqjTGy@hovoldconsulting.com>
 <Y1vRDv+hrMmnqwPj@matsya>
 <Y1vT94blD9PJHKDp@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1vT94blD9PJHKDp@hovoldconsulting.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-10-22, 15:07, Johan Hovold wrote:
> On Fri, Oct 28, 2022 at 06:24:38PM +0530, Vinod Koul wrote:
> > On 21-10-22, 13:32, Johan Hovold wrote:
> 
> > > [...] This is not about keeping the
> > > diff small, this is about readability of the new helper function as I
> > > already told you.
> > > 
> > > And this is a *local* identifier, not some state member that needs a
> > > super descriptive name. And the rest of the driver used "tbl"
> > > consistently until your EP/RC mode patches for that matter.
> > 
> > I would disagree here... You can change tbls/tables but then it does not
> > help _this_ patch
> > 
> > Right thing would be to change tbls to tables first and then add init
> > helper... For a reviewer seeing an undocumented change and unnecessary
> > diff is not right..
> 
> I still think that it belongs in the patch adding the new helper
> because it is essentially only in that new function that the improved
> readability due to the shorter identifier matters (the earlier helpers
> where per table type).
>  
> > Pls split if you would still like the rename
> 
> But if you prefer I'll split it out in a preparatory patch.

That would be good thanks

-- 
~Vinod
