Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363096D3D69
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 08:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjDCGfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 02:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCGfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:35:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3BD65BC;
        Sun,  2 Apr 2023 23:34:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0EE4614E2;
        Mon,  3 Apr 2023 06:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54299C433EF;
        Mon,  3 Apr 2023 06:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680503697;
        bh=wzluEvR07/Iehrheek73HbOQNPlcwZDSwVVMhYpLF/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+MzaLjuuylILtjgw54TNYfLhl5hpYOjQUiwdSE3anYeloxGna46S5TtmcRBpu12+
         qxlU3s/6y/Hx/TqGBrGHafn3P0J7fev2i7kHsxCfBoOKClAO8259xknPzkZnKW6vXC
         Jd4wIPzbtuL8bbRWuukNnsSLy73C8DcuL4vYDGCj1m2WEUOZaElpaPS3U2MWBbSqKj
         5k9xuOujB5jYyI73LHF/CC6GcTO6w0t3PFuuhmUywRY1gX+bccudEn09QYd9GkDaYm
         sOUY0L9G89XWvH9dbCt9R0mZjzyZN2d6rGz72fPCVWB6uDzJ85vlCQoDZovTddqwcI
         VOboOEm215leA==
Date:   Mon, 3 Apr 2023 12:04:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/3] phy: starfive: Add mipi dphy rx support
Message-ID: <ZCpzjIrcKt4t93gn@matsya>
References: <20230223015952.201841-1-changhuang.liang@starfivetech.com>
 <20230223015952.201841-3-changhuang.liang@starfivetech.com>
 <ZBhTmTEcrV59oaw3@matsya>
 <2aa1bdbd-e37e-941a-9422-0908545c14f7@starfivetech.com>
 <ZCbloBdeffocT3Os@matsya>
 <d48ab612-213a-8d20-4b36-3f64f3d24721@starfivetech.com>
 <0dd5e35b-512e-41ed-af33-f94b7e2868c1@spud>
 <b07842e4-54cc-873e-3140-4a933e054802@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b07842e4-54cc-873e-3140-4a933e054802@starfivetech.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-04-23, 14:31, Changhuang Liang wrote:
> 
> 
> On 2023/4/3 14:24, Conor Dooley wrote:
> > On Mon, Apr 03, 2023 at 09:39:00AM +0800, Changhuang Liang wrote:
> >> On 2023/3/31 21:52, Vinod Koul wrote:
> >>> On 21-03-23, 14:08, Changhuang Liang wrote:
> >>>> On 2023/3/20 20:37, Vinod Koul wrote:
> >>>>> On 22-02-23, 17:59, Changhuang Liang wrote:

> >>>>>> +static int stf_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
> >>>>>> +{
> >>>>>> +	struct stf_dphy *dphy = phy_get_drvdata(phy);
> >>>>>> +	int map[6] = {4, 0, 1, 2, 3, 5};
> >>>>>
> >>>>> what does this mean?
> >>>>
> >>>> This is the physical lane and logical lane mapping table, should I add a note for it?
> >>>
> >>> Yes please. Also will the mapping be always static or ever change?
> >>>  
> >>
> >> The mapping is always static on the visionfive2 single board computer.
> >> Thanks for your comments.
> > 
> > What about other boards featuring a JH7110?
> 
> maybe add this mapping in the device tree, we just need to parse the device tree is better.

If the mapping is hw description then yes it makes sense

-- 
~Vinod
