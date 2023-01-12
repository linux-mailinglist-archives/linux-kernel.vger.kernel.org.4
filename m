Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839E2667DCC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbjALSTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbjALSST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:18:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02855D80
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:49:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87666620E3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 17:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90C4C433EF;
        Thu, 12 Jan 2023 17:49:36 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Optimise SME exit on syscall entry
Date:   Thu, 12 Jan 2023 17:49:34 +0000
Message-Id: <167354575614.3644139.13835865624687417471.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110-arm64-sme-syscall-smstop-v1-1-ac94235fd810@kernel.org>
References: <20230110-arm64-sme-syscall-smstop-v1-1-ac94235fd810@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 19:34:36 +0000, Mark Brown wrote:
> Our ABI says that we exit streaming mode on syscall entry. Currently we
> check if we are in streaming mode before doing this but since we have a
> SMSTOP SM instruction which will clear SVCR.SM in a single atomic operation
> we can save ourselves the read of the system register and check of the flag
> and just unconditionally do the SMSTOP SM. If we are not in streaming mode
> it results in a noop change to SVCR, if we are in streaming mode we will
> exit as desired.
> 
> [...]

Applied to arm64 (for-next/sme), thanks!

[1/1] arm64/sme: Optimise SME exit on syscall entry
      https://git.kernel.org/arm64/c/b2482807fbd4

-- 
Catalin

