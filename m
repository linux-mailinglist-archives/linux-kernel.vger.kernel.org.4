Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF2D65C587
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbjACR6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbjACR5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:57:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D0D11A07
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:57:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0007B8107B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C139C433D2;
        Tue,  3 Jan 2023 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672768658;
        bh=hUZ2XDvLrwJ9FannznPjhaf3MRrc6OlAN+J+YQi66mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VWe/pJ0Rk3yxk2m19wCaALmQUCxhnbQi+NVxW6/7FRhaZSCBvm1Lzy0Wa8KPVvU0E
         4k/5NRa4jazSSKLEAl7WZl9WcA817NLvXoL8Qg6P/lV+JZhTAHwPxBRSBrdZVkm5h0
         lrLE/k2emox8Kdejgrli77+/I+4QeUbxD06407yQIh36wEl2YZofrqKmuzEOVXeM1K
         2vDqXCPDJEHPBhWDnBTwrXCsLKDID6l3lpS073aUw5VchrKqEAUpFfC1T9yjgdo1B1
         7HpgObpOkDxbMW166fbPambmCw9PhWFighD1qCqobaJhhwvY/aeiJj81Dd0zfW8wzr
         bHzVaa0m5tAOA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pClXb-00Ga8q-9m;
        Tue, 03 Jan 2023 17:57:36 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     James Clark <james.clark@arm.com>, kvmarm@lists.linux.dev
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] KVM: arm64: PMU: Fix PMCR_EL0 reset value
Date:   Tue,  3 Jan 2023 17:57:32 +0000
Message-Id: <167276864513.3239355.2653412840294598299.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209164446.1972014-1-james.clark@arm.com>
References: <20221209164446.1972014-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: james.clark@arm.com, kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org
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

On Fri, 9 Dec 2022 16:44:45 +0000, James Clark wrote:
> We noticed qemu failing to run because of an assert on our CI. I don't see the issue anymore with
> this fix.
> 
> Applies to kvmarm/next (753d734f3f34)
> 
> Thanks
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: PMU: Fix PMCR_EL0 reset value
      commit: edb4929ea9ba48cd91e3867041f49e4c34d729ed

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


