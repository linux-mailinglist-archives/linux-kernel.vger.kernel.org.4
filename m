Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D45071891D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjEaSNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEaSNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:13:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C44B126
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:13:12 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso306665e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685556790; x=1688148790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gbuh9jdiV+SPVWIJmpiEUgjoMR54fGjNPi8rWBf5EoY=;
        b=dId7HG7QFPc3OpUbsFzimDWDHcW2Q4Q+Gb33kAMtXSGDHzJzC45ACiZWgkR9aS5rhf
         bKd1RbmB3Hf79uysmWi1uHvpfZZ2L9YBl/PuUmBJFcyo4kMk17UGUF7x2Ed+JhYV81B4
         6w3WEBgI/EuHrMCMf/2l76z9T7z314uHEC6JuZcy9KTTpra0364OYdOAxBVDj46yE3bc
         JVRQio3u9Hymr71Qa7RnCOXN6Qw9gIGDteZUKv/dPvHl+69pmkLArhypoRL2lGp0SsQb
         r1EBZWJzaCwkYaNw+1amjK3aigY82xSl53ivn4aNiC/ObcS+bHRH2Pl50INxNxrLU0MK
         RosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685556790; x=1688148790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbuh9jdiV+SPVWIJmpiEUgjoMR54fGjNPi8rWBf5EoY=;
        b=Xb3DzdkwEG9yh+RstHLPRZGtd50Tz5t1031bNmnj84uStOfKEAFbA6D2qjjdVXbmwt
         6DJ/QW6EXBpeLpLBHTyoZXv1U7/4tVNGBFlFAry00jj7DSixMCZrCula3BlDEUvDgASM
         P9ufQM77fnDogiTYiOjsuEU01HvKzK2BztYoYawzDlOvRKZSlWq++ygV9h8bo99tWpjz
         S+72qZAGtOUwKCSKU+NAqwMO9aavLniv0nLk85MAS0E7YnCM4HXgq/D4UdvrO90FmLO5
         CBIl3DOUjIF06QoTHotgl6xz0hwZaOeYgZfCRuPsup2FYvR6w5OzlDlDYEef0PT+QHiu
         e8UA==
X-Gm-Message-State: AC+VfDwGEkd1QXC1P0S6W4PMuKeWsTxQEkMXT/+hPThqbWlGAYOME7EA
        ltl/1qiK27qXrhdCySG2z/Fm8A==
X-Google-Smtp-Source: ACHHUZ6GsLlBE9uPQs84Ft2bnZom9VhLmhaLnSp+7xhLdvFbXoTBFf8tQjBp6N6V3V78LsLe+KSnFw==
X-Received: by 2002:a7b:c846:0:b0:3f5:fa76:8dd0 with SMTP id c6-20020a7bc846000000b003f5fa768dd0mr108435wml.0.1685556790677;
        Wed, 31 May 2023 11:13:10 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm5268621wmb.2.2023.05.31.11.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 11:13:08 -0700 (PDT)
Date:   Wed, 31 May 2023 21:13:04 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH RFC net-next v3 6/8] virtio/vsock: support dgrams
Message-ID: <d2e9c45f-bcbd-4e6a-98c1-c98283450626@kadam.mountain>
References: <20230413-b4-vsock-dgram-v3-0-c2414413ef6a@bytedance.com>
 <20230413-b4-vsock-dgram-v3-6-c2414413ef6a@bytedance.com>
 <ZHdxJxjXDkkO03L4@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHdxJxjXDkkO03L4@corigine.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 06:09:11PM +0200, Simon Horman wrote:
> > @@ -102,6 +144,7 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> 
> Smatch that err may not be initialised in the out label below.
> 
> Just above this context the following appears:
> 
> 	if (info->vsk && !skb_set_owner_sk_safe(skb, sk_vsock(info->vsk))) {
> 		WARN_ONCE(1, "failed to allocate skb on vsock socket with sk_refcnt == 0\n");
> 		goto out;
> 	}
> 
> So I wonder if in that case err may not be initialised.
> 

Yep, exactly right.  I commented out the goto and it silenced the
warning.  I also initialized err to zero at the start hoping that it
would trigger a different warning but it didn't.  :(

regards,
dan carpenter


> >  	return skb;
> >  
> >  out:
> > +	*errp = err;
> >  	kfree_skb(skb);
> >  	return NULL;
> >  }

