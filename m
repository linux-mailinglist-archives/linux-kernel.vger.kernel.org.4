Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E436E24CA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjDNNw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjDNNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C2AB440
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681480297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwFOnM3nMI93el8j5Fm/36C16c2wvk4iAVnNGABHAIk=;
        b=Ea6hOwhCcjOC6HIdiwMeVz0bhGhmvNp6Yr8maP7VHPI9cc+gVl52pDbC+5i96yl1Y80WmA
        tWJ7FFrW3R0tJSxTpZfSdgMQCxiuSHjphpUgoRHshiyrw4ToM6uSSsuAbcBjLc7DyL8k3R
        r1Wzm6itKPb8SBxXz1YbH9gQkp92IdY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-_ewnsBbJPLymurl5keXJNQ-1; Fri, 14 Apr 2023 09:51:34 -0400
X-MC-Unique: _ewnsBbJPLymurl5keXJNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84BEF3C10C70;
        Fri, 14 Apr 2023 13:51:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96D5140C6E70;
        Fri, 14 Apr 2023 13:51:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230329140155.53272-3-zhujia.zj@bytedance.com>
References: <20230329140155.53272-3-zhujia.zj@bytedance.com> <20230329140155.53272-1-zhujia.zj@bytedance.com>
To:     Jia Zhu <zhujia.zj@bytedance.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jefflexu@linux.alibaba.com, hsiangkao@linux.alibaba.com,
        yinxin.x@bytedance.com
Subject: Re: [PATCH V5 2/5] cachefiles: extract ondemand info field from cachefiles_object
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1250338.1681480291.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 14 Apr 2023 14:51:31 +0100
Message-ID: <1250339.1681480291@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jia Zhu <zhujia.zj@bytedance.com> wrote:

>  #define CACHEFILES_OBJECT_STATE_FUNCS(_state, _STATE)	\
>  static inline bool								\
>  cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *=
object) \
>  {												\
> -	return object->state =3D=3D CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
> +	return object->ondemand->state =3D=3D CACHEFILES_ONDEMAND_OBJSTATE_##_=
STATE; \
>  }												\
>  												\
>  static inline void								\
>  cachefiles_ondemand_set_object_##_state(struct cachefiles_object *objec=
t) \
>  {												\
> -	object->state =3D CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
> +	object->ondemand->state =3D CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
>  }

I wonder if those need barriers - smp_load_acquire() and smp_store_release=
().

David

