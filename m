Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6704A5F5AA9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 21:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiJEThj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 15:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiJEThg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 15:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E23C7F24C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664998653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=om/4sfRsXfwNwWQKPv9CFi8IwmnaiLcb7IYF4maF9ko=;
        b=DVj83FICHny6CqspJfvzdW3umJ+iiVolVU6kWJWh+1ugUgfGfbHd3kmMDOG3MWsbNqBmDa
        U+Jwukh542EWvqh6Y4FJYpxdbve086dhsvy9fcXEftJlfYN3DCDQVIwU95GdIf0zT7jsYm
        P4sLlJrvc5TVy4rs48esbLT1xYi7h98=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-232-N4l7hYfKMoKnjpFJIUkz0Q-1; Wed, 05 Oct 2022 15:37:30 -0400
X-MC-Unique: N4l7hYfKMoKnjpFJIUkz0Q-1
Received: by mail-il1-f199.google.com with SMTP id u2-20020a056e021a4200b002f9ecfa353cso6989323ilv.20
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 12:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=om/4sfRsXfwNwWQKPv9CFi8IwmnaiLcb7IYF4maF9ko=;
        b=1J+k4Wfk0MDPHz1eHtNfFVlIPDTIGg5H9+6wZnW7atVXG3lXBzV18+VVx+s9NogRpP
         odOmVC6IvpPQOgz5zzjjyh+DX1foiHx/1jchQKnBqlO2edOTqMRxvqnpmufV6TzahFUM
         48Th63IgH5KNwvQuQVdPdqUtm+HxMcNuIyhxees2zbg/3MB+2pk7sD8sBDvdP1COfizA
         +HNI2EuOssRMPpBeN/kNEtVufd100/J0njam9AwB+tiXehksTA0YEGN/Y6MDgm9Ertcy
         dSWMKrsqScL9PjMkisNcBrFoOAHLETdWkKh2TOSX9rCjDbnG4xIRNbYFsxXfskQ+Fj+h
         JfOw==
X-Gm-Message-State: ACrzQf1hsxzhhhsPDqLffYyMrGC1+Wyy0CM28qTKDU9Ln3u+pDYRWfH9
        kPghatNdVluKwldyUvNRMX0lRATV5NaNfe4f1V1XaI9aQ4SNDUqklMxuSJPEntcWaQQZS8AURbG
        m3H9NxjwqxNEYHaLCtIDz186P
X-Received: by 2002:a92:ca4c:0:b0:2f9:5143:faad with SMTP id q12-20020a92ca4c000000b002f95143faadmr601798ilo.3.1664998649677;
        Wed, 05 Oct 2022 12:37:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6XbJTCCAKAeqFGgRlGD4yz9P7kGpD2LZ94vAS1Q5FqKSmlWF3438/LCyxGKw4Wvc+9bqy0jQ==
X-Received: by 2002:a92:ca4c:0:b0:2f9:5143:faad with SMTP id q12-20020a92ca4c000000b002f95143faadmr601788ilo.3.1664998649468;
        Wed, 05 Oct 2022 12:37:29 -0700 (PDT)
Received: from [10.56.18.113] ([140.209.96.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a056e02068900b002f4ab5c3d7fsm6109000ils.62.2022.10.05.12.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 12:37:28 -0700 (PDT)
Message-ID: <128762cfb6524d17e6ee7308aa7e859dd350fa63.camel@redhat.com>
Subject: Re: [PATCH] drm/amdgpu/dm/mst: Fix incorrect usage of
 drm_dp_add_payload_part2()
From:   Lyude Paul <lyude@redhat.com>
To:     Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Ian Chen <ian.chen@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Claudio Suarez <cssk@net-c.es>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 05 Oct 2022 14:37:25 -0500
In-Reply-To: <d3b272e1-3b5d-c843-e8ac-57dc5e3a7ced@amd.com>
References: <20221004202429.124422-1-lyude@redhat.com>
         <d3b272e1-3b5d-c843-e8ac-57dc5e3a7ced@amd.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-04 at 16:46 -0400, Rodrigo Siqueira Jordao wrote:
> 
> On 2022-10-04 16:24, Lyude Paul wrote:
> > Yikes, it appears somehow I totally made a mistake here. We're currently
> > checking to see if drm_dp_add_payload_part2() returns a non-zero value to
> > indicate success. That's totally wrong though, as this function only
> > returns a zero value on success - not the other way around.
> > 
> > So, fix that.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Issue: https://gitlab.freedesktop.org/drm/amd/-/issues/2171
> > Fixes: 4d07b0bc4034 ("drm/display/dp_mst: Move all payload info into the atomic state")
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > index b8077fcd4651..00598def5b39 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > @@ -297,7 +297,7 @@ bool dm_helpers_dp_mst_send_payload_allocation(
> >   		clr_flag = MST_ALLOCATE_NEW_PAYLOAD;
> >   	}
> >   
> > -	if (enable && drm_dp_add_payload_part2(mst_mgr, mst_state->base.state, payload)) {
> > +	if (enable && drm_dp_add_payload_part2(mst_mgr, mst_state->base.state, payload) == 0) {
> >   		amdgpu_dm_set_mst_status(&aconnector->mst_status,
> >   			set_flag, false);
> >   	} else {
> 
> Hi Lyude,
> 
> Maybe I'm missing something, but I can't find the 
> drm_dp_add_payload_part2() function on amd-staging-drm-next. Which repo 
> are you using?

If it's not on amd-staging-drm-next then it likely hasn't gotten backported to
amd's branch yet and is in drm-misc-next

> 
> Thanks
> Siqueira
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

