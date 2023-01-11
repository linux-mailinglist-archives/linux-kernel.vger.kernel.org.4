Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1343666653
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjAKWkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjAKWkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:40:49 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E3842E19
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 14:40:48 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vm8so40535199ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 14:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I6F8lGqMyWQPxHybRXHy/JOYHSNqp8lMgB32SloPQJ0=;
        b=ER+oAfDCq1qBzlUIl/NJrT20HKbTLkrLlj+owS9YulHqJ9D/Hboegp6u8ahlgpykGb
         xH4+ddvc0WR8vvkJbWsWDSDVqjSXKY95R3YLU5AtKC5SpyIThA6rfMP3nKf8vcAQ8Yp8
         nfsY444LvIEylRMyRVAbn+tnVyglGSdsLKeno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6F8lGqMyWQPxHybRXHy/JOYHSNqp8lMgB32SloPQJ0=;
        b=wc7I+N0K9pBq2SSBk1ru9+JOkygVjZMsp77tJ7g3O5RCxPAyV/87nIu53j2r10LDqA
         6NGbbiERlboSQtlkQ4MXD88yxlh9vX7FdMUc3SFpNVp0vP4AtDzEZ2lQo9e2vHpcQEWE
         b3ci6lhdCrwNojd4xbxtJwWzci+xo+G6jqUs4yLAN0cEDtmtwnfcXvFDe+BRkXtuPQJx
         tc2ZLkrIBdTF2pc0ynvewWdHE1z0Kb9wLQic74bXtgLyaOwoc+bW2ZtVCKqUQdrh5maI
         9tO+hLW+9W5tuSk1zZOpSQcSUXNEDygF34PobxMi6wqcLf5mT6ugLeJtpFbA0H/+Xm13
         MYYg==
X-Gm-Message-State: AFqh2krSnx05yjaRc7idavaSpBhGafftsT7WiD6hxNMlQ5zL8CsfhYOg
        mqgT5FyYNLDWvfGIn1UBXfcHNFYlmku1E4lB
X-Google-Smtp-Source: AMrXdXv/CiLkKgvceOfzI/Ye6UVdDBrEIwRgyJJs8pPtFNKjKh9THairwpjxkiAiC/VATHFq7siiBQ==
X-Received: by 2002:a17:906:7f99:b0:84d:2f2a:b158 with SMTP id f25-20020a1709067f9900b0084d2f2ab158mr15893098ejr.11.1673476846592;
        Wed, 11 Jan 2023 14:40:46 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id qu25-20020a170907111900b0084c7574630csm6786372ejb.97.2023.01.11.14.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 14:40:45 -0800 (PST)
Date:   Wed, 11 Jan 2023 23:40:43 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Melissa Wen <mwen@igalia.com>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/debugfs: add descriptions to struct parameters
Message-ID: <Y7866924YruF9OrY@phenom.ffwll.local>
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
 <Y7iCOD1mylBX/VuB@phenom.ffwll.local>
 <c7cbcb01-d0ce-47bd-1d9d-e687ef9e5315@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7cbcb01-d0ce-47bd-1d9d-e687ef9e5315@igalia.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 08:28:20AM -0300, Maíra Canal wrote:
> On 1/6/23 17:19, Daniel Vetter wrote:
> > On Thu, Jan 05, 2023 at 04:30:39PM -0300, Maíra Canal wrote:
> > > The structs drm_debugfs_info and drm_debugfs_entry don't have
> > > descriptions for their parameters, which is causing the following warnings:
> > > 
> > > include/drm/drm_debugfs.h:93: warning: Function parameter or member
> > > 'name' not described in 'drm_debugfs_info'
> > > include/drm/drm_debugfs.h:93: warning: Function parameter or member
> > > 'show' not described in 'drm_debugfs_info'
> > > include/drm/drm_debugfs.h:93: warning: Function parameter or member
> > > 'driver_features' not described in 'drm_debugfs_info'
> > > include/drm/drm_debugfs.h:93: warning: Function parameter or member
> > > 'data' not described in 'drm_debugfs_info'
> > > include/drm/drm_debugfs.h:105: warning: Function parameter or member
> > > 'dev' not described in 'drm_debugfs_entry'
> > > include/drm/drm_debugfs.h:105: warning: Function parameter or member
> > > 'file' not described in 'drm_debugfs_entry'
> > > include/drm/drm_debugfs.h:105: warning: Function parameter or member
> > > 'list' not described in 'drm_debugfs_entry'
> > > 
> > > Therefore, fix the warnings by adding descriptions to all struct
> > > parameters.
> > > 
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Signed-off-by: Maíra Canal <mcanal@igalia.com>
> > > ---
> > >   include/drm/drm_debugfs.h | 18 ++++++++++++++++++
> > >   1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
> > > index 53b7297260a5..7616f457ce70 100644
> > > --- a/include/drm/drm_debugfs.h
> > > +++ b/include/drm/drm_debugfs.h
> > > @@ -86,9 +86,22 @@ struct drm_info_node {
> > >    * core.
> > >    */
> > >   struct drm_debugfs_info {
> > > +	/** @name: File name */
> > >   	const char *name;
> > > +
> > > +	/**
> > > +	 * @show:
> > > +	 *
> > > +	 * Show callback. &seq_file->private will be set to the &struct
> > > +	 * drm_debugfs_entry corresponding to the instance of this info
> > > +	 * on a given &struct drm_device.
> > 
> > So this is a bit late, but why don't we pass that drm_debugfs_entry as an
> > explicit parameter? Or maybe just the struct drm_device, because that and
> > the void *data is really all there is to pass along. Would give us more
> > type-safety, which really is the main reason for having drm-specific
> > debugfs functions.
> 
> It seems like a better idea to pass the drm_debugfs_entry as an explicit
> parameter. I can work on it, but I guess it is a better idea to finish
> the conversion of all drm_debugfs_create_files() to drm_debugfs_add_files()
> and then perform the change in the show() signature.

So drm_debugfs_entry still feels like a bit too high level, do callers
really need that? They get the void * and I guess need the struct
drm_device *

This really starts to matter more when we also roll this out for
connector/crtc, then you can give them directly a pointer to that. And the
drm_debugfs_entry thing becomes an implementation detail entirely.

Or do I miss something?

Also yes we can do that later on, it shouldn't be too annyoing to roll
out.
-Daniel
> 
> Best Regards,
> - Maíra Canal
> 
> > 
> > Either way, on the series: Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > 
> > > +	 */
> > >   	int (*show)(struct seq_file*, void*);
> > > +
> > > +	/** @driver_features: Required driver features for this entry. */
> > >   	u32 driver_features;
> > > +
> > > +	/** @data: Driver-private data, should not be device-specific. */
> > >   	void *data;
> > >   };
> > > @@ -99,8 +112,13 @@ struct drm_debugfs_info {
> > >    * drm_debugfs_info on a &struct drm_device.
> > >    */
> > >   struct drm_debugfs_entry {
> > > +	/** @dev: &struct drm_device for this node. */
> > >   	struct drm_device *dev;
> > > +
> > > +	/** @file: Template for this node. */
> > >   	struct drm_debugfs_info file;
> > > +
> > > +	/** @list: Linked list of all device nodes. */
> > >   	struct list_head list;
> > >   };
> > > -- 
> > > 2.39.0
> > > 
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
