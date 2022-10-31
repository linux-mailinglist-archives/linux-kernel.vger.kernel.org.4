Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59449612E70
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 01:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiJaAwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 20:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJaAw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 20:52:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1215120;
        Sun, 30 Oct 2022 17:52:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E94760F8C;
        Mon, 31 Oct 2022 00:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB31DC433C1;
        Mon, 31 Oct 2022 00:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667177546;
        bh=aAKSoQnRirrEhzznep5heaZ2XHhpE7FBrQKBRdvFiXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CDh4H/sP5FvkJiSy4245sfEHKCggo2e4/08dG0uRMB25oTJPxGr+TpCSx0v5cHSBW
         9Hi+6/0c14zYNVuH/uj39XIi/6l2jMkfXVvD44hFR2+OnYgUpC149V6aDqyuhx2HA/
         h5Ia352Syh+PfyNiCbztfyJqytms7vbZorY0lrdJK5qqQA/UkgFRGMRRdtzPinEHG3
         x1wkdT28FTl/G5odqlyS47FM20LyKXn/b6wCOxCtPTMRwomQ/T2urSasXdtCGWGWLG
         ExZ3N8856j/+h4/OWILedgb5bCrDnTuEfinpX+i/gRc8wb/01JXdSiR5+YR/KtdoIO
         Yba9vOzcZA4DA==
Date:   Mon, 31 Oct 2022 08:52:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alistair <alistair@alistair23.me>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the imx-mxs tree
Message-ID: <20221031005219.GA125525@dragon>
References: <20221031090904.7ce6ca3c@canb.auug.org.au>
 <87cab9ba-883b-4275-8170-12b525399751@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cab9ba-883b-4275-8170-12b525399751@app.fastmail.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 08:11:57AM +1000, Alistair wrote:
> On Mon, 31 Oct 2022, at 8:09 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the imx-mxs tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> > 
> > arch/arm/boot/dts/imx7d-remarkable2.dts:26.15-44.5: ERROR (phandle_references): /thermal-zones/epd-thermal: Reference to non-existent node or label "epd_pmic"
> > 
> > ERROR: Input tree has errors, aborting (use -f to force output)
> 
> Sorry, that's completely my fault. Apparently I had a local change
> that didn't get committed. I'll send a new version of this patch.

Alistair,

I have fixed it up with the change below.

Shawn

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 2314f68f3c86..8b2f11e85e05 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -24,7 +24,7 @@ memory@80000000 {
 
        thermal-zones {
                epd-thermal {
-                       thermal-sensors = <&epd_pmic>;
+                       thermal-sensors = <&sy7636a>;
                        polling-delay-passive = <30000>;
                        polling-delay = <30000>;
 

