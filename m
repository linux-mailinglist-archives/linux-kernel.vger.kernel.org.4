Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2F56CBC61
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjC1KRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjC1KRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:17:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD42619A3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679998605; x=1711534605;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=YNcmTAzIivIIG1nw9WZggF/K2IYvfLlzFc8+1akrKgM=;
  b=Pundf8vfZkjIf755tBEPpvBd2JCiacgGhLKPduQ4PFre2K6k/Z6EkRR/
   zfJEXNnPMl867TFjEKb8wkfd5r2hx/NxRNVgBvLMO8O97SeOwDQuZJJbE
   ovgPxUbLVTfucVCk1kcPfCKRYusv+tJIWWHsNYB5LNI2ITgXXyowPIPty
   2IC/rxT3oZKyQx0ngh1X/LM4nfdlEYjYfXWEOhcsO8NnqU7woihQeLC/h
   0m1tY9ZahPSFI6o1Ry1ro0PEEqm/SoscHrz3IncKyWsgOOdJv5WIN+ehp
   KmxkxaA0bJ/9kdgNB3HyS1YXurqB9Oks2RocCxiP0xvnVDg8jvtSmpui8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="339252097"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="339252097"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:16:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="929817003"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="929817003"
Received: from gprivite-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 03:16:31 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Caio Novais <caionovais@usp.br>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Felipe Clark <felipe.clark@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        =?utf-8?Q?Ma=C3=ADra?= Canal <mairacanal@riseup.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Charlene Liu <Charlene.Liu@amd.com>,
        Gabe Teeger <gabe.teeger@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Taimur Hassan <Syed.Hassan@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>,
        George Shen <George.Shen@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Chaitanya Dhere <chaitanya.dhere@amd.com>,
        Alan Liu <HaoPing.Liu@amd.com>,
        Mukul Joshi <mukul.joshi@amd.com>,
        =?utf-8?Q?A?= =?utf-8?Q?ndr=C3=A9?= Almeida 
        <andrealmeid@igalia.com>, Jingwen Zhu <Jingwen.Zhu@amd.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Leo Li <sunpeng.li@amd.com>, Melissa Wen <mwen@igalia.com>,
        Le Ma <le.ma@amd.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Caio Novais <caionovais@usp.br>,
        Martin Leung <Martin.Leung@amd.com>,
        Ryan Lin <tsung-hua.lin@amd.com>,
        Brian Chang <Brian.Chang@amd.com>,
        Sung Joon Kim <sungjoon.kim@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Dillon Varone <Dillon.Varone@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Zhan Liu <zhan.liu@amd.com>,
        Roman Li <Roman.Li@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Wayne Lin <wayne.lin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Joshua Ashton <joshua@froggi.es>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 00/12] drm/amd: Remove unused variables
In-Reply-To: <20230327233353.64081-1-caionovais@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230327233353.64081-1-caionovais@usp.br>
Date:   Tue, 28 Mar 2023 13:16:28 +0300
Message-ID: <878rfh5gg3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023, Caio Novais <caionovais@usp.br> wrote:
> This patchset cleans the code removing unused variables and one unused
> function.
>
> Caio Novais (12):
>   Remove unused variable 'r'
>   Remove unused variable 'value0'
>   Remove unused variable 'pixel_width'
>   Remove unused variable 'hubp'
>   Remove unused variable 'speakers'
>   Remove unused variable 'mc_vm_apt_default'
>   Remove unused variable 'optc'
>   Remove two unused variables 'speakers' and 'channels' and remove
>     unused function 'speakers_to_channels'
>   Remove two unused variables 'is_pipe_split_expected' and 'state'
>   Remove unused variable 'cursor_bpp'
>   Remove unused variable 'scl_enable'
>   Remove two unused variables 'result_write_min_hblank' and
>     'hblank_size'

Curious, how did you create this? It does not match the patches.

BR,
Jani.

>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  8 ----
>  .../amd/display/dc/dcn10/dcn10_link_encoder.c |  3 --
>  .../drm/amd/display/dc/dcn201/dcn201_dpp.c    |  6 ---
>  .../drm/amd/display/dc/dcn201/dcn201_hwseq.c  |  2 -
>  .../gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c |  2 -
>  .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |  4 --
>  .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  3 --
>  .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.c  | 39 -------------------
>  .../drm/amd/display/dc/dcn32/dcn32_resource.c |  4 --
>  .../display/dc/dcn32/dcn32_resource_helpers.c |  4 --
>  .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |  2 -
>  .../dc/link/protocols/link_dp_capability.c    |  7 ----
>  12 files changed, 84 deletions(-)

-- 
Jani Nikula, Intel Open Source Graphics Center
