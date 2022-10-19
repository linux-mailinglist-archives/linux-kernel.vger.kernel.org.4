Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDA46051FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiJSVcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJSVcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806D318E736
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666215135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iRo8z7I39TZ2xgzmOs0IkUPyEriKByUvdIr0+xvZt3Y=;
        b=TnzEz5O7TBF/cuQchHjTG+IkTf/ga3y20rJ0WhJ5oZthmYA6JiDwjruCKHsVO7/U32NVY9
        lPLkyQ+A923zsY0jdXSK+uyxMiV5pznmIaB98EoMiVih+pQszXZ9Ch/bovHuTuaTas5/eh
        IhQgsCtYVBnTRkmR6pLMQ5iWk4GOprs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648--kOwMoCqPhCLVNi-HUgJNg-1; Wed, 19 Oct 2022 17:32:14 -0400
X-MC-Unique: -kOwMoCqPhCLVNi-HUgJNg-1
Received: by mail-qv1-f69.google.com with SMTP id eu10-20020ad44f4a000000b004b18126c4bfso11429212qvb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRo8z7I39TZ2xgzmOs0IkUPyEriKByUvdIr0+xvZt3Y=;
        b=M/ndnqwFVHFIk7Q7OEAS/qj5mMoSyMpyBhX4OKXTQQLlfQxwKw5xGUg6iDnErhjx4+
         xyo84CLrBe7bvd4yJtCZVzI0o028xt77d3v7N8gvQM6sOvP9VAncfluCkqs/GSEP5K3P
         zO2QvWJ4nPGsm7h6S+ZjMJBmVY0+x0WPCtw9VRmrFR9JnyMJCXZ42pxbRCU93m57bZXG
         6qfIn5NN+zd15BCGm53v1o9FlApLCa4S5+wN8gvxXaKpZ2lvYs5QXuvW5VjhEXWJtDh2
         ipNuWGcFn0/6b5hXorT8g+4l8AxuXK9fSVheqym5C6DB3kzjz7uhSuzN3Dxjpfp8n4zf
         HLSA==
X-Gm-Message-State: ACrzQf3dbGi1ska+1NOQwA5O4t4BawTVbkiAEGtZwkZvHB6lVsJVbAqZ
        HevxSQp8k92THkXk4vxvAtQq2aXnm2UXY953r6BfqQ3tXNZOvZFiJrZzVGzUcU32zJvP/CXKUZc
        2BglPuueDiXqBLA1oYs/7gI/4
X-Received: by 2002:ac8:7e84:0:b0:35b:a902:57c3 with SMTP id w4-20020ac87e84000000b0035ba90257c3mr8244620qtj.37.1666215133691;
        Wed, 19 Oct 2022 14:32:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6n9BznDrKP2dQk6tJ1JIOGufLUsAqZJjny42w86LkBTeAVBcYMkps5A9DvXTIjQgO1LQYTSA==
X-Received: by 2002:ac8:7e84:0:b0:35b:a902:57c3 with SMTP id w4-20020ac87e84000000b0035ba90257c3mr8244601qtj.37.1666215133472;
        Wed, 19 Oct 2022 14:32:13 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c68:4300:fdba:af4a:bbcd:7e28? ([2600:4040:5c68:4300:fdba:af4a:bbcd:7e28])
        by smtp.gmail.com with ESMTPSA id d4-20020ac81184000000b00359961365f1sm4675476qtj.68.2022.10.19.14.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 14:32:12 -0700 (PDT)
Message-ID: <41ffe32931a21961a3f368b30bd4335faa5ac6a4.camel@redhat.com>
Subject: Re: [PATCH] drm/amdgpu/dm/mst: Fix incorrect usage of
 drm_dp_add_payload_part2()
From:   Lyude Paul <lyude@redhat.com>
To:     "Lin, Wayne" <Wayne.Lin@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc:     "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Chen, Ian" <Ian.Chen@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
        Claudio Suarez <cssk@net-c.es>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 19 Oct 2022 17:32:11 -0400
In-Reply-To: <CO6PR12MB548939841653ABD0EAA95DCAFC299@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20221004202429.124422-1-lyude@redhat.com>
         <d3b272e1-3b5d-c843-e8ac-57dc5e3a7ced@amd.com>
         <128762cfb6524d17e6ee7308aa7e859dd350fa63.camel@redhat.com>
         <CO6PR12MB548939841653ABD0EAA95DCAFC299@CO6PR12MB5489.namprd12.prod.outlook.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gotcha, I'll take another look at this tomorrow

On Mon, 2022-10-17 at 03:09 +0000, Lin, Wayne wrote:
> [Public]
> 
> 
> 
> > -----Original Message-----
> > From: Lyude Paul <lyude@redhat.com>
> > Sent: Thursday, October 6, 2022 3:37 AM
> > To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; dri-
> > devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org
> > Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> > <Sunpeng.Li@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> > Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; Zuo, Jerry
> > <Jerry.Zuo@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chen, Ian
> > <Ian.Chen@amd.com>; Mikita Lipski <mikita.lipski@amd.com>; Mahfooz,
> > Hamza <Hamza.Mahfooz@amd.com>; Claudio Suarez <cssk@net-c.es>; Colin
> > Ian King <colin.i.king@gmail.com>; Jani Nikula <jani.nikula@intel.com>; open
> > list <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH] drm/amdgpu/dm/mst: Fix incorrect usage of
> > drm_dp_add_payload_part2()
> > 
> > On Tue, 2022-10-04 at 16:46 -0400, Rodrigo Siqueira Jordao wrote:
> > > 
> > > On 2022-10-04 16:24, Lyude Paul wrote:
> > > > Yikes, it appears somehow I totally made a mistake here. We're
> > > > currently checking to see if drm_dp_add_payload_part2() returns a
> > > > non-zero value to indicate success. That's totally wrong though, as
> > > > this function only returns a zero value on success - not the other way
> > around.
> > > > 
> > > > So, fix that.
> > > > 
> > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > Issue:
> > > > 
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgi
> > > > tlab.freedesktop.org%2Fdrm%2Famd%2F-
> > %2Fissues%2F2171&amp;data=05%7C0
> > > > 
> > 1%7Cwayne.lin%40amd.com%7Ccd5a63120e064f4bb6aa08daa7090baf%7C3d
> > d8961
> > > > 
> > fe4884e608e11a82d994e183d%7C0%7C0%7C638005954559719396%7CUnkno
> > wn%7CT
> > > > 
> > WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> > JXV
> > > > 
> > CI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=nMIGnUKS6EDrdKJ0rR%2BAh
> > FRa4ST0%2
> > > > BYr9bILmXv40yv0%3D&amp;reserved=0
> > > > Fixes: 4d07b0bc4034 ("drm/display/dp_mst: Move all payload info into
> > > > the atomic state")
> > > > ---
> > > >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2
> > +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git
> > > > a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > > > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > > > index b8077fcd4651..00598def5b39 100644
> > > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > > > +++
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > > > @@ -297,7 +297,7 @@ bool
> > dm_helpers_dp_mst_send_payload_allocation(
> > > >   		clr_flag = MST_ALLOCATE_NEW_PAYLOAD;
> > > >   	}
> > > > 
> > > > -	if (enable && drm_dp_add_payload_part2(mst_mgr, mst_state-
> > > base.state, payload)) {
> > > > +	if (enable && drm_dp_add_payload_part2(mst_mgr,
> > > > +mst_state->base.state, payload) == 0) {
> 
> Hi Lyude,
> 
> This line changes the original logic a bit. The 'if' case was trying to catch failure 
> while sending ALLOCATE_PAYLOAD. If the msg fails, set the set_flag to false.
> If succeed, set the set_flag to true and clear the clr_flag. 
> 
> Sorry if the code wording misleading. Thanks!
> 
> > > >   		amdgpu_dm_set_mst_status(&aconnector->mst_status,
> > > >   			set_flag, false);
> > > >   	} else {
> > > 
> > > Hi Lyude,
> > > 
> > > Maybe I'm missing something, but I can't find the
> > > drm_dp_add_payload_part2() function on amd-staging-drm-next. Which
> > > repo are you using?
> > 
> > If it's not on amd-staging-drm-next then it likely hasn't gotten backported to
> > amd's branch yet and is in drm-misc-next
> > 
> > > 
> > > Thanks
> > > Siqueira
> > > 
> > 
> > --
> > Cheers,
> >  Lyude Paul (she/her)
> >  Software Engineer at Red Hat
> --
> Regards,
> Wayne Lin
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

