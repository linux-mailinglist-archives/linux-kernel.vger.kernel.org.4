Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60896D043A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjC3MBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjC3MBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C78A24E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680177619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y4kBL+83QToteVgKil7VO5tgjxZqNxgaDRNr3gcrywg=;
        b=hY2UW+ZIl5U3lhNtdK9iOvHbDb+AVpaj5uLGlFG0wYZut5ejmxOrIMNqhse7Zq6UVNFpuu
        v7UnN41eq3Cxnz2j/3vbhGA1U41/wl/gtHDkLNhL3lIzwKGXupDqW4sDxZbvpkiyGVFs2s
        XLRJz9hY7pQqdi4xBs+NYB/rdiKtR6M=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-af7xjqhGPV60p5ZZbmN1VA-1; Thu, 30 Mar 2023 08:00:15 -0400
X-MC-Unique: af7xjqhGPV60p5ZZbmN1VA-1
Received: by mail-qk1-f200.google.com with SMTP id s21-20020a05620a0bd500b0074234f33f24so8635842qki.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680177615; x=1682769615;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4kBL+83QToteVgKil7VO5tgjxZqNxgaDRNr3gcrywg=;
        b=BX6h++Tn3zWPq4VxWT4CLpiuHwm5NJYeFPmer5xdbmNYw0pXGnPmxMQDUPzAZIzm1O
         NddHhaQe3s7Lo6KlkyC/lS6Ul3sq59bTq1FTU4u5HhR2lmZ65NsFY/bLcDkc0pyihSay
         /e9JmAr7XTZkBL8+RpG8LPWywpe+RliFLVHgZR6oRK1YHEbzTqvQoln8yeHAmw91qMsj
         u7CB77mB71358Ym/T8sDE7/m18MvouOtr4Hf0lEncOaFvuCrTpQmK7BW7Pd832nQuKzI
         iPDUzom9ATXmNlXP5lhfaYvJwL7kag4l68i9VSHaH4gEgJ7tPXLDsja61bjzVbIFKw6J
         2klw==
X-Gm-Message-State: AAQBX9cWxxDd/vSOQDDlEJUHFcyf1ztZHFgI1hmW8JSjkRUxZ/l6IG4R
        VXuE/iNfnYPfaZ7NHNjDBUiQSMEbo4qcYj9nm7cxbZH4wDRD5YbzXoRJTdeN4lZ3+9zuClfz5OZ
        piiwUintTJxcFmDjYnIpKSPA3
X-Received: by 2002:a05:622a:1815:b0:3e6:30c4:656f with SMTP id t21-20020a05622a181500b003e630c4656fmr3382247qtc.3.1680177615245;
        Thu, 30 Mar 2023 05:00:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZsHaKjIuC84GXaAXjkM9JM90iIamxuSWXB5xzRL6fwcpPAZ7ZkIYl8hCrmXXt/5ZFlO14V9w==
X-Received: by 2002:a05:622a:1815:b0:3e6:30c4:656f with SMTP id t21-20020a05622a181500b003e630c4656fmr3382202qtc.3.1680177614894;
        Thu, 30 Mar 2023 05:00:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-125.dyn.eolo.it. [146.241.228.125])
        by smtp.gmail.com with ESMTPSA id 4-20020a05620a048400b007468bf8362esm13619101qkr.66.2023.03.30.05.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 05:00:14 -0700 (PDT)
Message-ID: <4c10487da3a217bcfa9f5d7c515ab4a300c84949.camel@redhat.com>
Subject: Re: [PATCH v3] xen/netback: use same error messages for same errors
From:   Paolo Abeni <pabeni@redhat.com>
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        xen-devel@lists.xenproject.org, Jan Beulich <jbeulich@suse.com>
Date:   Thu, 30 Mar 2023 14:00:11 +0200
In-Reply-To: <20230329080259.14823-1-jgross@suse.com>
References: <20230329080259.14823-1-jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 2023-03-29 at 10:02 +0200, Juergen Gross wrote:
> Issue the same error message in case an illegal page boundary crossing
> has been detected in both cases where this is tested.
>=20
> Suggested-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>

As this was intended to be part of:

xen/netback: fix issue introduced recently

I'm going to apply this one on net, unless someone screams very loudly,
very soon :)

thanks!

Paolo

