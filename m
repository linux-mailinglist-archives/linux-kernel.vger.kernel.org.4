Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5490C628BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbiKNVz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbiKNVzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:55:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6B2F5A0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668462901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qpc2eQF4OVRCR9vIz7961ylczQfdMl7P3OUcWUSapU0=;
        b=HuCaI4wDVF939S4gDPijaNf1dXE8+wHY75I7jYLzALrWMmX0qOcnGzfDRhy9CVBvIymaTn
        j/e8w198V3dxjSzYiKR6oir/R1m1yYm7ql128ypBPh+gNI0B9WLeIu5A89fc6cy6GNUmHd
        Q4uAJDZ74tCSbAxkj3xwXJOMihWyPs0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-97-Dz53I3UePSyrzSqKsOG5bw-1; Mon, 14 Nov 2022 16:54:59 -0500
X-MC-Unique: Dz53I3UePSyrzSqKsOG5bw-1
Received: by mail-qt1-f199.google.com with SMTP id w27-20020a05622a191b00b003a56c0e1cd0so8892880qtc.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qpc2eQF4OVRCR9vIz7961ylczQfdMl7P3OUcWUSapU0=;
        b=iESNpJuBSzVUBfDlYyX3Ztnqhw+6yCCgWjh0kvlaAsymJppEZI72p8MS/ZUbf5I6Ue
         RJ3QBNI3Lz/PrlPwkSIFhm/86M/lYA6jaDblwTaiU1mhm75zR9AoSzuzXQ7bG8pCRVYp
         4siFEbXug0i3yqQnlJydyv+iQHBv/Rab62dwEECHGCi9wOYceriQisXH/Ep3HMUqLgH6
         F77grdnaXuji6kG7BwLDu1f9m+MxlGb8jIHO8E66pOU6d3dv6pke26bEJF9qpw7qDP8F
         D0zY//UpD8IOH/EDyO5FvuznfEzmHc6dPZPiqIPAv2kTWhHzVF4oDqWqcX2lchjMlPPk
         aX4Q==
X-Gm-Message-State: ANoB5plfYgeZMbm9KCXfYxQ5hirysvkJ1omauF1SRr065V86ocNQFrqn
        vdM49iif1BbdIVjmICQ70jlSqyxT84dY960pBH3eBQMDwS1MNfX8g2/gXj44F8O0eNiDIr5mSc7
        Dnz1M4TcS68fZOGGZvZIh1Hj6
X-Received: by 2002:a05:6214:1902:b0:4a4:474a:1394 with SMTP id er2-20020a056214190200b004a4474a1394mr14177468qvb.36.1668462898904;
        Mon, 14 Nov 2022 13:54:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4JgH34ZSNeRxluqCoega8kEsCXijBbz2npC1p8GEG2x4oKXtEevNQk4JgOUn038jyPFgODag==
X-Received: by 2002:a05:6214:1902:b0:4a4:474a:1394 with SMTP id er2-20020a056214190200b004a4474a1394mr14177451qvb.36.1668462898651;
        Mon, 14 Nov 2022 13:54:58 -0800 (PST)
Received: from ?IPv6:2600:4040:5c6c:9200::feb? ([2600:4040:5c6c:9200::feb])
        by smtp.gmail.com with ESMTPSA id i19-20020a05620a249300b006fb38ff190bsm7023557qkn.34.2022.11.14.13.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 13:54:57 -0800 (PST)
Message-ID: <4482e7de979cc6673162b7aac0fcbfddb5d2d906.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/mst: Stop ignoring error codes and
 deadlocking
From:   Lyude Paul <lyude@redhat.com>
To:     "Lin, Wayne" <Wayne.Lin@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc:     "Wentland, Harry" <Harry.Wentland@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
        "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
        "Li, Roman" <Roman.Li@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>,
        "Wu, Hersen" <hersenxs.wu@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
        "Hung, Alex" <Alex.Hung@amd.com>,
        "Francis, David" <David.Francis@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        "Liu, Wenjing" <Wenjing.Liu@amd.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 14 Nov 2022 16:54:55 -0500
In-Reply-To: <CO6PR12MB5489E3850FE3C9FBDA7BAC29FC3E9@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20221104235926.302883-1-lyude@redhat.com>
         <20221104235926.302883-2-lyude@redhat.com>
         <CO6PR12MB5489E3850FE3C9FBDA7BAC29FC3E9@CO6PR12MB5489.namprd12.prod.outlook.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-09 at 09:48 +0000, Lin, Wayne wrote:
> >   	}
> > -	if (!drm_dp_mst_atomic_check(state) && !debugfs_overwrite) {
> > +	ret = drm_dp_mst_atomic_check(state);
> > +	if (ret == 0 && !debugfs_overwrite) {
> >   		set_dsc_configs_from_fairness_vars(params, vars, count,
> > k);
> > -		return true;
> > +		return 0;
> > +	} else if (ret == -EDEADLK) {
> > +		return ret;
> 
> I think we should return here whenever there is an error. Not just for
> EDEADLK case. 

Are we sure about this one? I think we may actually want to make this so it
returns on ret != -ENOSPC, since we want the function to continue if there's
no space in the atomic state available so it can try recomputing things with
compression enabled. On ret == 0 it should return early without doing
compression, and on ret == -ENOSPC it should just continue the function from
there

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

