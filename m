Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD795F3C30
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 06:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJDEnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 00:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJDEnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 00:43:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8FD39B93;
        Mon,  3 Oct 2022 21:43:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5697B818F6;
        Tue,  4 Oct 2022 04:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECE7C433C1;
        Tue,  4 Oct 2022 04:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664858583;
        bh=eYy7EY3wMGZQPeArL+2hroT5fu2zAsiPf6zlIP9+Gm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LwErs2ts4afxfSLyft8B10Lg3CRv3yfwGdn0RW2OozMWrmg6HpA9ebRxLny+aKKNl
         ojMXD2JpInZesbJ5C5dH6v8X5akzAA/PjKH29ojszQdp4omrh4g9jD8HIkv6lVIx6o
         htDoicY1k3fY3qPJ8ieSkRUnT0gitArCGM71VhiHUHHTn1cJB9DQ30yxOM9LhMPvXu
         uAOTAWNlYUfxhGG3pg+o94/mxZBf2EBaVpfPMmIb9k6XY0egzYdYhqZPDxd0S8YLEs
         fdlv5dGGUhf24B0/I15ZuweoCf4kZifJzlhds7tyC65N6caF0T1wCIcK82HzKarQbK
         fIEzbrfEwVgOw==
Date:   Tue, 4 Oct 2022 10:12:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 0/5] drm: Fix math issues in MSM DSC implementation
Message-ID: <Yzu50ly1AxZwmyvi@matsya>
References: <20221001190807.358691-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001190807.358691-1-marijn.suijten@somainline.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-10-22, 21:08, Marijn Suijten wrote:
> Various removals of complex yet unnecessary math, fixing all uses of
> drm_dsc_config::bits_per_pixel to deal with the fact that this field
> includes four fractional bits, and finally an approach for dealing with
> dsi_host setting negative values in range_bpg_offset, resulting in
> overflow inside drm_dsc_pps_payload_pack().
> 
> Note that updating the static bpg_offset array to limit the size of
> these negative values to 6 bits changes what would be written to the DPU
> hardware at register(s) DSC_RANGE_BPG_OFFSET, hence the choice has been
> made to cover up for this while packing the value into a smaller field
> instead.

Thanks for fixing these. I dont have my pixel3 availble but changes lgtm

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> Altogether this series is responsible for solving _all_ Display Stream
> Compression issues and artifacts on the Sony Tama (sdm845) Akatsuki
> smartphone (2880x1440p).

Does it need two dsi lanes?

-- 
~Vinod
