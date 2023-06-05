Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5449772280B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjFEOAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjFEOAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:00:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34966F7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD8CF6146B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00396C4339B;
        Mon,  5 Jun 2023 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685973644;
        bh=On3rGOqFSbByR/DIILhT4dFBEtswVbOki/UYt/0OBzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rDZ3G2R0okYT4e7d/zC2zK19Wd02wV9A2gKqkCzP14aWvhJGxNnYJ3S09tGWSbD7A
         XDGlJa/xOLMfEz7HFWBDzzZt+3JMoECKqPUt4m6skv89KoS0ST3c+IpshtoJNyBrZ6
         AtAauNcoWoTvAikg+6jCPlu/qk0L6PPIOjaqBdZKczVCd5Ghgkr5lJw8paKEoawnAe
         uCCdNhxQ4GVlh3y9UJcm7hDGbjN94ujnqteLNyqC48UOxefVP+L2kJJPWmzxwyuKeo
         r95yi7COgfXd4EFf+daSP5m30VuC/qcSxPXfXXNO13egmc2pC4uApv1H2q591fQFor
         I7tHUdx/WbWFA==
Date:   Mon, 5 Jun 2023 15:00:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] arm64: Disable EL2 traps for BRBE instructions
 executed in EL1
Message-ID: <20230605140038.GB21212@willie-the-truck>
References: <20230516083015.569248-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516083015.569248-1-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 02:00:15PM +0530, Anshuman Khandual wrote:
> This disables EL2 traps for BRBE instructions executed in EL1. This would
> enable BRBE to be configured and used successfully in the guest kernel.
> While here, this updates Documentation/arm64/booting.rst as well.

Is it safe to give the guest access to BRBE if the hypervisor doesn't
switch the state? I'm assuming the architecture defaults to "trap" for a
reason and disabling the trap alone isn't sufficient.

If it _is_ safe, please can you explain that in the commit message? If not,
then this should be at the end of the series adding hypervisor support.

Will
