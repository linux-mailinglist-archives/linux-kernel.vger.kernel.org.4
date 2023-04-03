Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D056D5343
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjDCVQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjDCVQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:16:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FC4EE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680556603; x=1712092603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N3ra2AO4hWBwhw91KuhVXI56Yt6E3/AoYlap5ePN/dI=;
  b=basNGbAZraD4v9BEoQHlotEkvhWrnEi/ZzBNERqpGOPbd9cciCZf4LxV
   HAoPE0W/aPtcW94Bh5OcCBglZ2iwi2hiLe51CqU4AVaJgU7LgbNZZ2mxN
   vDIFnskxs13MlijOVgXmEte2vh9oKHrzkPXobID5gvXv48HI7OWZCLrH4
   fNr1c+Eu52yg8WNu0HKbP+wbz57+ACXkvcL/0hLFNMsRTaEx6kKDW5mUT
   C5jrvaR7v0s1PgdSYT4F+4N/suEfXG8FR/8NuNSr9IhZy6TTXinTD2o5s
   M5hr7CheTON8vIPk4/tnLoAr75WeBcdD07iem1H/wpvfQ5bnxXsnZZhUq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="330593315"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="330593315"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:16:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="797211667"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="797211667"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.70])
  by fmsmga002.fm.intel.com with SMTP; 03 Apr 2023 14:16:39 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 04 Apr 2023 00:16:39 +0300
Date:   Tue, 4 Apr 2023 00:16:39 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Erico Nunes <nunes.erico@gmail.com>
Cc:     Qiang Yu <yuq825@gmail.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/lima: add usage counting method to ctx_mgr
Message-ID: <ZCtCNx5JUKFcoCCp@intel.com>
References: <20230312233052.21095-1-nunes.erico@gmail.com>
 <20230312233052.21095-2-nunes.erico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230312233052.21095-2-nunes.erico@gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 12:30:50AM +0100, Erico Nunes wrote:
> lima maintains a context manager per drm_file, similar to amdgpu.
> In order to account for the complete usage per drm_file, all of the
> associated contexts need to be considered.
> Previously released contexts also need to be accounted for but their
> drm_sched_entity info is gone once they get released, so account for it
> in the ctx_mgr.
> 
> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
> ---
>  drivers/gpu/drm/lima/lima_ctx.c | 30 +++++++++++++++++++++++++++++-
>  drivers/gpu/drm/lima/lima_ctx.h |  3 +++
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/lima/lima_ctx.c b/drivers/gpu/drm/lima/lima_ctx.c
> index 891d5cd5019a..e008e586fad0 100644
> --- a/drivers/gpu/drm/lima/lima_ctx.c
> +++ b/drivers/gpu/drm/lima/lima_ctx.c
> @@ -15,6 +15,7 @@ int lima_ctx_create(struct lima_device *dev, struct lima_ctx_mgr *mgr, u32 *id)
>  	if (!ctx)
>  		return -ENOMEM;
>  	ctx->dev = dev;
> +	ctx->mgr = mgr;
>  	kref_init(&ctx->refcnt);
>  
>  	for (i = 0; i < lima_pipe_num; i++) {
> @@ -42,10 +43,17 @@ int lima_ctx_create(struct lima_device *dev, struct lima_ctx_mgr *mgr, u32 *id)
>  static void lima_ctx_do_release(struct kref *ref)
>  {
>  	struct lima_ctx *ctx = container_of(ref, struct lima_ctx, refcnt);
> +	struct lima_ctx_mgr *mgr = ctx->mgr;
>  	int i;
>  
> -	for (i = 0; i < lima_pipe_num; i++)
> +	for (i = 0; i < lima_pipe_num; i++) {
> +		struct lima_sched_context *context = &ctx->context[i];
> +		struct drm_sched_entity *entity = &context->base;
> +
> +		mgr->elapsed_ns[i] += entity->elapsed_ns;

drm-tip build is now broken because of this vs. 
commit baad10973fdb ("Revert "drm/scheduler: track GPU active time per entity"")

../drivers/gpu/drm/lima/lima_ctx.c: In function ‘lima_ctx_do_release’:
../drivers/gpu/drm/lima/lima_ctx.c:53:45: error: ‘struct
drm_sched_entity’ has no member named ‘elapsed_ns’
   53 |                 mgr->elapsed_ns[i] += entity->elapsed_ns;

-- 
Ville Syrjälä
Intel
