Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111D7615D69
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKBINl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKBINf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5D22704;
        Wed,  2 Nov 2022 01:13:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79A8961847;
        Wed,  2 Nov 2022 08:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4FBC433D6;
        Wed,  2 Nov 2022 08:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667376813;
        bh=lpAAsFlmTm/LavhinI8aX5Gdc5BT8bM0i9kKwT4V+1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIuPC2Z6WOE7ysPjJJVdG8KR0j/MNsk4CrhiMJRXT5ylfRXHUF2Y8fSsX+x8YbWp6
         VGE4quuJQRTkn8vYSu2r5xFoKYQ7LuMFnx+ZyPVKLHVBxvT4ptjl8Ytf8M9BX3HrRC
         gZ6dbe86s2xt7pVAsnbY5nkZ/iPnxgrVg3vgRLm4ZX8cc1XAqbY15QmajrPpcQv5q3
         LyGyQb/0vIx9E7v2hwa1vPJco2+9RSF0mhX6+F5MRXN7lkU36LZKzVAVDGc0Jw2mwn
         3ZTTlmkr/bkgBUZ+eSlZoz2ze+EpJVTroFda+N/tuCMxVNM11J4UWcGr1EbvBVBthe
         EXId+ts+RhnqQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oq8s9-0002XH-Ph; Wed, 02 Nov 2022 09:13:17 +0100
Date:   Wed, 2 Nov 2022 09:13:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, andersson@kernel.org,
        bmasney@redhat.com, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clk: qcom: gcc-sc8280xp: add cxo as parent for
 gcc_ufs_ref_clkref_clk
Message-ID: <Y2Imnf1+v5j5CH9r@hovoldconsulting.com>
References: <20221030142333.31019-1-quic_shazhuss@quicinc.com>
 <20221101182402.32CE5C433C1@smtp.kernel.org>
 <Y2IZaxukERXNcPGR@hovoldconsulting.com>
 <c96304da-f57e-4926-2f3f-665c2054fb00@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c96304da-f57e-4926-2f3f-665c2054fb00@quicinc.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 01:28:48PM +0530, Shazad Hussain wrote:
> On 11/2/2022 12:46 PM, Johan Hovold wrote:
> > On Tue, Nov 01, 2022 at 11:23:59AM -0700, Stephen Boyd wrote:
> >> Quoting Shazad Hussain (2022-10-30 07:23:33)
> >>> Since 'commit f3aa975e230e ("arm64: dts: qcom: sc8280xp: correct ref
> >>
> >> So we should have a Fixes tag for this commit? Or really back to the
> >> beginning of the driver?
> >>
> >>> clock for ufs_mem_phy")' we need to explicitly make cxo as parent to
> >>> gcc_ufs_ref_clkref_clk to have an independent vote from ufs_mem_phy.
> > 
> > The commit message is slightly misleading as this affects the other UFS
> > PHY as well.
> > 
> > If CX is indeed a parent of this clock then the issue has been there
> > since the clock driver was added. (And otherwise, the PHY binding may
> > need to be amended instead.)

> CX is not the actual parent of this clk. GCC_UFS_REF_CLKREF_CLK is an 
> external clk to the device, which needs to be voted. If we use the 
> GCC_UFS_REF_CLKREF_CLK as ref clk, we don't have explicit vote for CX 
> from ufs_mem_phy.
>
> If no client votes for CX,(very unlikely) then it's won't be ON for 
> ufs_mem_phy as well right ! So to maintain the voting to CX, we make 
> this as parent to ref clk.

Right, but if the PHYs really requires CX and it is not an ancestor of
the refclk then this should be described by the binding (and not be
hidden away in the clock driver).

Johan
