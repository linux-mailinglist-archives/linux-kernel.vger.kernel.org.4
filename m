Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32336264BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbiKKWrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiKKWqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:46:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE4040922
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668206756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HfoD+yTsgDgyy3DKNtedBkMBeaq/mYuNaScJkhXJDcQ=;
        b=WfRGDPb65rye87R4KPsiuquAZw87lT2UwqlsNKWG8cZR8V8AsiMga7oXAnApxa+aX+BWag
        7SzMLiGrgqI+TCrpRpaIe5u7gPmMFLJzKWp/KAOVjJaEhUvCXzud5R2tI+MLxr1+oDV0vX
        jvd2675/R8uxVrEmEJmaXlvQYyWcdQ4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-386-dWxfMPmwPGCzJtplhgF7bg-1; Fri, 11 Nov 2022 17:45:55 -0500
X-MC-Unique: dWxfMPmwPGCzJtplhgF7bg-1
Received: by mail-qk1-f197.google.com with SMTP id v7-20020a05620a0f0700b006faffce43b2so5773488qkl.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HfoD+yTsgDgyy3DKNtedBkMBeaq/mYuNaScJkhXJDcQ=;
        b=UWC7cgn21rLchV4RfIw494nurlJQNpsLXmz7rMNFOZexRCVLwPc6JgypGi3NkaM6+X
         0Ne8HMyZNXYQlBtnPk3SEteiKrpxK5iw9qZrIFf/DdMCXsT/TIpY4xbdtkh3Yk7MYgJ0
         USFqgvQQfMdTt8lbXbAzlnnrXG8yJSTVIL9xJnFu22/JuTmqcLzrbuWJ7ZMbORc1CQeD
         EHGKNrGevZlM2onqMDTDtZP3yYlySHAdhhbEQterx+f/0RiOvk/DIRCLmZADMljPCtFo
         EDhqku9rhIha7+9hsTtATHoHPt2mF2EvI3fCsqTKZGLKPLMXA3s1ciJCopozxv2lqEs/
         qReA==
X-Gm-Message-State: ANoB5plwEnDktgQdSCSaFyQyef0qWmUPcqqp5LlPpMIi2F9X1NQyrUa5
        RTb1Z/AM7lWpNN7u/OxWa8IUUASToN/KqAQz3mT46YCZjrWcOZf4WVuhdaL+2wXsqb9ecmdIgSO
        O9m/AKSwxJYMJZg3Q81khksD4
X-Received: by 2002:a37:6887:0:b0:6cd:fd44:d83e with SMTP id d129-20020a376887000000b006cdfd44d83emr2973922qkc.594.1668206755001;
        Fri, 11 Nov 2022 14:45:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6SZGZhkL4AowLZ87AFimr5T3hQE6XB4d5J7ZosU46Koto1vL4Amhb0XNjGBjAqUUHeUBXwrQ==
X-Received: by 2002:a37:6887:0:b0:6cd:fd44:d83e with SMTP id d129-20020a376887000000b006cdfd44d83emr2973910qkc.594.1668206754748;
        Fri, 11 Nov 2022 14:45:54 -0800 (PST)
Received: from ?IPv6:2600:4040:5c6c:9200::feb? ([2600:4040:5c6c:9200::feb])
        by smtp.gmail.com with ESMTPSA id f2-20020ac87f02000000b003a4c3c4d2d4sm1948861qtk.49.2022.11.11.14.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:45:53 -0800 (PST)
Message-ID: <023708836f1af8302c813e8308c7d406e6fd2310.camel@redhat.com>
Subject: Re: [PATCH 1/5] drm/nouveau/nvfw/acr: make
 wpr_generic_header_dump() static
From:   Lyude Paul <lyude@redhat.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, bskeggs@redhat.com
Cc:     kherbst@redhat.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Date:   Fri, 11 Nov 2022 17:45:52 -0500
In-Reply-To: <20221111091130.57178-1-jiapeng.chong@linux.alibaba.com>
References: <20221111091130.57178-1-jiapeng.chong@linux.alibaba.com>
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

Actually hm, I think ben will need to consider pulling these into his branch
since these don't seem to apply to drm-misc-next - so presumably they're
related to some of the work that's been getting pushed recently for GSP prep

On Fri, 2022-11-11 at 17:11 +0800, Jiapeng Chong wrote:
> This symbol is not used outside of acr.c, so marks it static.
> 
> drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c:49:1: warning: no previous prototype for ‘wpr_generic_header_dump’.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3023
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c b/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c
> index 83a9c48bc58c..7ac90c495737 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c
> @@ -45,7 +45,7 @@ wpr_header_v1_dump(struct nvkm_subdev *subdev, const struct wpr_header_v1 *hdr)
>  	nvkm_debug(subdev, "\tstatus        : %d\n", hdr->status);
>  }
>  
> -void
> +static void
>  wpr_generic_header_dump(struct nvkm_subdev *subdev, const struct wpr_generic_header *hdr)
>  {
>  	nvkm_debug(subdev, "wprGenericHeader\n");

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

