Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C797650E14
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiLSOuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiLSOrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:47:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98622DE1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 06:47:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0B7BB80E4B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46683C433F0;
        Mon, 19 Dec 2022 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671461248;
        bh=MENjf6lY8GK2GTH2tECqFbt7ss1GMvxx+PbZHvnU7iw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V4A3elTQRGlZEYtd8MKwSTgMymarhRIwCKt7XgdZbGmedeaWmDNJFT/GQYN8coL1I
         0l0lSITSPwMxU8GqiD2Gss7nE6WY5J0Ft054QnUj/Rm//pwxZ16Ry6tfRtN9hFZHZU
         EPT/+yhrXcSLK1dT23iU2QkUnDxqt1BcK8712esWHHYi5/pEwpITKuZU2AGm4r60Kf
         Gq9s8qcIPnyuaH4ccRUTKTB57DXM3BsvOMn1XdRy+2HWGjcAGPvhiFFCL6yhvfec48
         FPRuqjMnUDbdl6pexjynquwVAEdXlDghZ7X3Kvgk9blfVSFTJI15Dvgjt+5xjEsNEP
         I37YDyepK0MgA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1p7HQL-00DgCo-Sg;
        Mon, 19 Dec 2022 14:47:25 +0000
MIME-Version: 1.0
Date:   Mon, 19 Dec 2022 14:47:25 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Akihiko Odaki <akihiko.odaki@daynix.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 1/3] arm64/sysreg: Add CCSIDR2_EL1
In-Reply-To: <Y6BjQiR5gUhIAyIS@sirena.org.uk>
References: <20221211051700.275761-1-akihiko.odaki@daynix.com>
 <20221211051700.275761-2-akihiko.odaki@daynix.com>
 <Y6BjQiR5gUhIAyIS@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <6363f9d0979be5aedfb04db4810b71a4@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: broonie@kernel.org, akihiko.odaki@daynix.com, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org, oliver.upton@linux.dev, suzuki.poulose@arm.com, alexandru.elisei@arm.com, james.morse@arm.com, will@kernel.org, catalin.marinas@arm.com, asahi@lists.linux.dev, alyssa@rosenzweig.io, sven@svenpeter.dev, marcan@marcan.st
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-19 13:12, Mark Brown wrote:
> On Sun, Dec 11, 2022 at 02:16:58PM +0900, Akihiko Odaki wrote:
>> CCSIDR2_EL1 was added with FEAT_CCIDX.
> 
> This corresponds to the definition in DDI0487I.a.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Since you're reviewing some of this, please have a look at v3[1],
which outlined a limitation of the sysreg generation tool as well
as a potential fix.

Thanks,

         M.

[1] 
https://lore.kernel.org/r/20221218051412.384657-2-akihiko.odaki@daynix.com
-- 
Jazz is not dead. It just smells funny...
