Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F045702D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242197AbjEONFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242189AbjEONFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:05:20 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9370273E;
        Mon, 15 May 2023 06:04:54 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QKfjD11sHz9sZF;
        Mon, 15 May 2023 15:04:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1684155888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aReNDZORAsT9vC55Sza0lixh/dFu7bUAxE370evU9U0=;
        b=HSExI2TLDxPazFnZAhnKWQUKsI6/VM6N+LUj1nR7G4Y7GRJ6gfBbOk0RF06aColi9xPiBa
        /U/Z1KcwTbjQVNFIwxzbB7jsVd28JkDLRx/6kDpAsD0MmBQ76sasbnfF7UjVXE9++vChoi
        xtWF6odERRxAzWeNS71fwHdE7e2pCu9R+6ckEDKfYPcgP1qN5lm0mOe5CKjbgBrW1kTjSx
        FrkhdrEpzvkaQo/r5pecksfU6TV7Jg7Hz+P9IU2N2XVmg4qFw7cvDVuVZTmDRtOB+JQ9/Y
        oiaR4fLB7SbbHAtblk6utPSe3Kxcrc9ULpFftEnT4Az7zBQkXUn/ElwbCAmWdA==
Message-ID: <bc4d10f2-6ded-bed3-1d81-7e09292adf6f@mailbox.org>
Date:   Mon, 15 May 2023 15:04:43 +0200
MIME-Version: 1.0
Subject: Re: [PATCH AUTOSEL 6.1 4/9] drm/amd/display: Do not set drr on pipe
 commit
Content-Language: en-CA
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     felipe.clark@amd.com, Aric.Cyr@amd.com, wenjing.liu@amd.com,
        dri-devel@lists.freedesktop.org, Jun.Lei@amd.com,
        airlied@gmail.com, jiapeng.chong@linux.alibaba.com,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        amd-gfx@lists.freedesktop.org, aurabindo.pillai@amd.com,
        Alvin.Lee2@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
        mwen@igalia.com, Daniel Wheeler <daniel.wheeler@amd.com>,
        Dillon.Varone@amd.com, Wesley Chalmers <Wesley.Chalmers@amd.com>,
        qingqing.zhuo@amd.com, Xinhui.Pan@amd.com, daniel@ffwll.ch,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com
References: <20230511193945.623476-1-sashal@kernel.org>
 <20230511193945.623476-4-sashal@kernel.org>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20230511193945.623476-4-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yjitohq9diod3ii4o71ztepm4eueahaa
X-MBO-RS-ID: 14971900af013488b0a
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 21:39, Sasha Levin wrote:
> From: Wesley Chalmers <Wesley.Chalmers@amd.com>
> 
> [ Upstream commit 474f01015ffdb74e01c2eb3584a2822c64e7b2be ]
> 
> [WHY]
> Writing to DRR registers such as OTG_V_TOTAL_MIN on the same frame as a
> pipe commit can cause underflow.
> 
> [HOW]
> Move DMUB p-state delegate into optimze_bandwidth; enabling FAMS sets
> optimized_required.
> 
> This change expects that Freesync requests are blocked when
> optimized_required is true.

This change caused a regression, see https://patchwork.freedesktop.org/patch/532240/?series=116487&rev=1#comment_972234 / 9deeb132-a317-7419-e9da-cbc0a379c0eb@daenzer.net .


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

