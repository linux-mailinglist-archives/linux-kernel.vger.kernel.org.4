Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CEA65259F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbiLTRdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiLTRd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:33:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0CD1AA33
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671557559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LpJLDJC3PZt1IAsqj5WBTZVH7ZAYMCqMmIX34DLaBOI=;
        b=ViJw5gmDUkzF2Qdz4y5NgZoScCyOjn//qB78L9zfbjwdXVJdI8eTcRkC2UwYrKF2cMbwaA
        DgW97KsRdU2KVh++XxzCmbd2HX0cknFiZMWVYjZ9bVW8J2xJXO8GS4t6+wB/f80JzSYkok
        BJUcKaBdoPlmMGzX0BWTRiwoVLbA/9o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-541-mOZQ56BBPRCn6XwBs6BtZA-1; Tue, 20 Dec 2022 12:32:37 -0500
X-MC-Unique: mOZQ56BBPRCn6XwBs6BtZA-1
Received: by mail-wr1-f71.google.com with SMTP id v14-20020adf8b4e000000b0024174021277so2400021wra.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpJLDJC3PZt1IAsqj5WBTZVH7ZAYMCqMmIX34DLaBOI=;
        b=xWHZ5vqepErWQ0GOlC20ZzRl2A2d02GsSdtoARaDZutJAM7mkUsYCSm/1/10GyZum4
         TVkTcXE8qAapzCLWkxxSh/PRLqI+JHwfDpT9kAv5n+Zq3Eqkq6Iq2RsWr+Ia0XMm4neX
         AixP0v1FB6Zw71zSRfHn8WRyD4SZAIoqMUoVp+eLR+2ydzenUSOk0QIO/nlvy4Ctnn4h
         JTKqW+wPEG0QlwQ9eVfoLsdKhXce8egjwCdJiwDiyqAbmTyXZ6crwCvCU4+RHeXeIHnc
         u9wdPtFGbLPhTOwTvFv5j7cMUVNGPwkRgJhGVHpFwuj1hBep8lTACuQmfQk5Buqd031Z
         cq9g==
X-Gm-Message-State: AFqh2kos6ralAtyhIQE0EQhtaauu3s93YC+YtWaJitCp9NaitiQTyhLe
        GFJS3MP/d5Yqh36vaDiKmtBgkVlRdXscIYRzcaWAtlovuloycyqneqkQCWrpAWW6BrBVlAJqKxY
        IfMSB79IDLEjYxewjhKpvsKQ=
X-Received: by 2002:adf:d22c:0:b0:242:33ed:af28 with SMTP id k12-20020adfd22c000000b0024233edaf28mr1682595wrh.41.1671557556442;
        Tue, 20 Dec 2022 09:32:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv1Bkqe93hZZTs0fZ8/ZvjEcMYSyy0RFqcGLMF01Eg0Pzr50O7dE/aovotBoQa9H2pGPEH3hw==
X-Received: by 2002:adf:d22c:0:b0:242:33ed:af28 with SMTP id k12-20020adfd22c000000b0024233edaf28mr1682581wrh.41.1671557556241;
        Tue, 20 Dec 2022 09:32:36 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600003cd00b0024cb961b6aesm13524883wrg.104.2022.12.20.09.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 09:32:35 -0800 (PST)
Date:   Tue, 20 Dec 2022 17:32:35 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Daniel Vacek <neelx@redhat.com>
Cc:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, atomlin@atomlin.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: no need to explicitly init a global
 static variable
Message-ID: <20221220173235.t7vq7mdbimwjijyx@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20221220151415.856093-1-neelx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221220151415.856093-1-neelx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-12-20 16:14 +0100, Daniel Vacek wrote:
> cpuset_rwsem is a static variable. It's initialized at build time and so
> there's no need for explicit runtime init leaking one percpu int.
> 
> Signed-off-by: Daniel Vacek <neelx@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a29c0b13706bb..87fe410361b3d 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3281,8 +3281,6 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
>  
>  int __init cpuset_init(void)
>  {
> -	BUG_ON(percpu_init_rwsem(&cpuset_rwsem));
> -
>  	BUG_ON(!alloc_cpumask_var(&top_cpuset.cpus_allowed, GFP_KERNEL));
>  	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_cpus, GFP_KERNEL));
>  	BUG_ON(!zalloc_cpumask_var(&top_cpuset.subparts_cpus, GFP_KERNEL));
> -- 
> 2.38.1

Good catch.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin

