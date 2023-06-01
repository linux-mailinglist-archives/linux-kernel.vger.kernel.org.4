Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAA77197D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjFAJz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjFAJya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0EDE5B;
        Thu,  1 Jun 2023 02:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D45A76092A;
        Thu,  1 Jun 2023 09:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B5CC433EF;
        Thu,  1 Jun 2023 09:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685613227;
        bh=fm7sw9sNJNxay74Yt8jfMtjyjVMmd/+OYcZxUbraMcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irmlnJdfZQqDpJHR+4hazW/0EFkoY7IbZnEvNqggTskj/EsMDRu54dYy/j77NVYso
         nlz0GS4Z3EQBpgLv1uXFxwFqv/9slQiO0f8oDSZWcoxfkufh+yyJRF31Xp3jd9pSFe
         pcPccoQrYfDSDmgY4Mn26q87m60AsIG618tpvtAgcPrQzStQawG879bjNgcYSc8YjT
         mJDEswbxaVNwAnZfniJaovR7UkIr40m5FABshB3WmZ6MPY3tDG0uhs7CTGik5zypq2
         cPx+W9+RSOM2XyYB7kK31CI/0mGqxqRmjanRVDQDgvOSISIYtg4ZcraJdbgHaQiDeE
         QTYGTzeGm/WyA==
Date:   Thu, 1 Jun 2023 05:53:46 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        felipe.clark@amd.com, Aric.Cyr@amd.com, wenjing.liu@amd.com,
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
Subject: Re: [PATCH AUTOSEL 6.1 4/9] drm/amd/display: Do not set drr on pipe
 commit
Message-ID: <ZHhqqkF8FCSqMi81@sashalap>
References: <20230511193945.623476-1-sashal@kernel.org>
 <20230511193945.623476-4-sashal@kernel.org>
 <bc4d10f2-6ded-bed3-1d81-7e09292adf6f@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc4d10f2-6ded-bed3-1d81-7e09292adf6f@mailbox.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 03:04:43PM +0200, Michel Dänzer wrote:
>On 5/11/23 21:39, Sasha Levin wrote:
>> From: Wesley Chalmers <Wesley.Chalmers@amd.com>
>>
>> [ Upstream commit 474f01015ffdb74e01c2eb3584a2822c64e7b2be ]
>>
>> [WHY]
>> Writing to DRR registers such as OTG_V_TOTAL_MIN on the same frame as a
>> pipe commit can cause underflow.
>>
>> [HOW]
>> Move DMUB p-state delegate into optimze_bandwidth; enabling FAMS sets
>> optimized_required.
>>
>> This change expects that Freesync requests are blocked when
>> optimized_required is true.
>
>This change caused a regression, see https://patchwork.freedesktop.org/patch/532240/?series=116487&rev=1#comment_972234 / 9deeb132-a317-7419-e9da-cbc0a379c0eb@daenzer.net .

Dropped, thanks!

-- 
Thanks,
Sasha
