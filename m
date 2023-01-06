Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3171166082D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbjAFUU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbjAFUTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:19:11 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBB669B2B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 12:19:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso1877848wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 12:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HIAM0suU1+vto0GHCwsmDjqm/WjWit3Redd5TQMQDhw=;
        b=C/ZaMvDpAUoVg8tJA4m7T8tRcV/yfg+m1Jbs73a3nblep+fFepL1aUZ+croiJENWAk
         X0ldr8dkvjdArkV5aSwkK74saT7DyFA8842tfGzDi2armdgh+QHdj5BAebZxql0/eXI/
         7Vh5c60HarHMJ3S2NG3ZX9qmvele2XWlUlIM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIAM0suU1+vto0GHCwsmDjqm/WjWit3Redd5TQMQDhw=;
        b=NmgURQakvpptqjBX9k35iuLPeR6hEc1QWSHqTNHMiIuiS5cFflkaq7so/9jBkdNYG3
         fvOcMG0/Iga3MT+C1bJB7CuH98u4Q/S2BY8C02gRIZxMJQGxYjfsrclE68OpFgJrvnaH
         GifgDzzTsSY6Psz7h7l97QY1jUaOIJk5nmcte7q0HpOhHPOJA52nQkpfv64Mhf9NwrIK
         iMn3b4IHbn4f7jzX4YAFpkKYkhI8yKAstGuF7FVBGiC8rj1ZsvNx4fnjclnF8uRsXasB
         pU1BSbZMufjeaEDp9tkl8Q6X6z/gw7fRb6uN+g4UrdP6vJoWXAlSuQA7qjQPccp1KoZY
         a45g==
X-Gm-Message-State: AFqh2krH6TBcFFhzYnsIZqchNAzmSSkA7g/yPO6knM5B/h30kuapigjv
        F1uabaS0hj2SawRdRHoPjPmyHQ==
X-Google-Smtp-Source: AMrXdXttFvNQSvhSh/wyqzgV6fjfB2h+/lik9CCASkQZcxzJzoE2G7j1I1mV0/4AJXiZqV/5pGaAiQ==
X-Received: by 2002:a05:600c:1503:b0:3d0:8722:a145 with SMTP id b3-20020a05600c150300b003d08722a145mr39134766wmg.40.1673036347651;
        Fri, 06 Jan 2023 12:19:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c0a0600b003d96efd09b7sm8950446wmp.19.2023.01.06.12.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:19:06 -0800 (PST)
Date:   Fri, 6 Jan 2023 21:19:04 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Melissa Wen <mwen@igalia.com>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/debugfs: add descriptions to struct parameters
Message-ID: <Y7iCOD1mylBX/VuB@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Melissa Wen <mwen@igalia.com>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230105193039.287677-1-mcanal@igalia.com>
 <20230105193039.287677-2-mcanal@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105193039.287677-2-mcanal@igalia.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 04:30:39PM -0300, Maíra Canal wrote:
> The structs drm_debugfs_info and drm_debugfs_entry don't have
> descriptions for their parameters, which is causing the following warnings:
> 
> include/drm/drm_debugfs.h:93: warning: Function parameter or member
> 'name' not described in 'drm_debugfs_info'
> include/drm/drm_debugfs.h:93: warning: Function parameter or member
> 'show' not described in 'drm_debugfs_info'
> include/drm/drm_debugfs.h:93: warning: Function parameter or member
> 'driver_features' not described in 'drm_debugfs_info'
> include/drm/drm_debugfs.h:93: warning: Function parameter or member
> 'data' not described in 'drm_debugfs_info'
> include/drm/drm_debugfs.h:105: warning: Function parameter or member
> 'dev' not described in 'drm_debugfs_entry'
> include/drm/drm_debugfs.h:105: warning: Function parameter or member
> 'file' not described in 'drm_debugfs_entry'
> include/drm/drm_debugfs.h:105: warning: Function parameter or member
> 'list' not described in 'drm_debugfs_entry'
> 
> Therefore, fix the warnings by adding descriptions to all struct
> parameters.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>  include/drm/drm_debugfs.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
> index 53b7297260a5..7616f457ce70 100644
> --- a/include/drm/drm_debugfs.h
> +++ b/include/drm/drm_debugfs.h
> @@ -86,9 +86,22 @@ struct drm_info_node {
>   * core.
>   */
>  struct drm_debugfs_info {
> +	/** @name: File name */
>  	const char *name;
> +
> +	/**
> +	 * @show:
> +	 *
> +	 * Show callback. &seq_file->private will be set to the &struct
> +	 * drm_debugfs_entry corresponding to the instance of this info
> +	 * on a given &struct drm_device.

So this is a bit late, but why don't we pass that drm_debugfs_entry as an
explicit parameter? Or maybe just the struct drm_device, because that and
the void *data is really all there is to pass along. Would give us more
type-safety, which really is the main reason for having drm-specific
debugfs functions.

Either way, on the series: Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +	 */
>  	int (*show)(struct seq_file*, void*);
> +
> +	/** @driver_features: Required driver features for this entry. */
>  	u32 driver_features;
> +
> +	/** @data: Driver-private data, should not be device-specific. */
>  	void *data;
>  };
>  
> @@ -99,8 +112,13 @@ struct drm_debugfs_info {
>   * drm_debugfs_info on a &struct drm_device.
>   */
>  struct drm_debugfs_entry {
> +	/** @dev: &struct drm_device for this node. */
>  	struct drm_device *dev;
> +
> +	/** @file: Template for this node. */
>  	struct drm_debugfs_info file;
> +
> +	/** @list: Linked list of all device nodes. */
>  	struct list_head list;
>  };
>  
> -- 
> 2.39.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
