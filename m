Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA88696AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjBNRMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjBNRLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:11:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA482DE74
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676394621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0DJXN9Zb39FhiQZf73JvN0gT+bxqzwusS/lWbuaFLXw=;
        b=hqAb9FuqwvN4sfxwa3Ipt+0x05PFq8SfV2bd8KoEs2shJNl1eTJfE54NXvyvFnbW6GBPGS
        QFue/TOaGCMOk4wEIndKdGc2Lm1Jj+U+Q4JhYpAkZ+lKFgt4Mr6EW609wixUdVkhn0FJAi
        O+yy2mV/QF0xyciA+XYXj6+SVRHJOeo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-PTC-JrJyN365Bb13z_d90w-1; Tue, 14 Feb 2023 12:09:38 -0500
X-MC-Unique: PTC-JrJyN365Bb13z_d90w-1
Received: by mail-qk1-f198.google.com with SMTP id 130-20020a370588000000b0072fcbe20069so9913342qkf.22
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DJXN9Zb39FhiQZf73JvN0gT+bxqzwusS/lWbuaFLXw=;
        b=1OIZS/b8487pzJdX7FMQyB1RJEaWRV+hiL/Ag/2YYsgQx6khJ4vM8LxY6kHlG2BBG8
         hzzilnb2Ecli5iCEgZNqLrRj/gx2TrO1r+/1RKmC1yfq/l1onurmA+94xK9JUZUAhGxy
         B4HoAXLvbM42Q2noPFoUVK/qNh+2tLPmdSrHETVULQX57lSbNI0iIUjYWSY4EQjKCUVk
         DYdfym3072pgpXX+bTGqecINPFdJR1CcKNstcjnvsSyCdy6QYIvPu8I167iOAei+H4iU
         Pp5EkijdXwRbPBvU6d0HXmkuTVL/CSHeaT0MZeZE7tf+8OQn2k86ys8+uIdLsagN+2J3
         8CfA==
X-Gm-Message-State: AO0yUKXEffp2a0rEfYpA424tRVypIXc0j1vAjAWYYolRITwCz8AskAOI
        u92EP0kVovs1IzPMgGVyO3ius0+yx9kQL2nmDDz4BUhBpqMMDXtBjusor01rmz/mHTXC890CipN
        oZuqBOhTXkEsJF7/YpItOGwU2
X-Received: by 2002:a05:622a:13ce:b0:3b9:b9b4:cb8d with SMTP id p14-20020a05622a13ce00b003b9b9b4cb8dmr5606819qtk.11.1676394577591;
        Tue, 14 Feb 2023 09:09:37 -0800 (PST)
X-Google-Smtp-Source: AK7set9nrBuxI7vKhnbD9jG+rn0Zx5mXmYMbBddcbNffn3VsQz+QYI3PTcTYhZP5fvn0d8bv3bzoJg==
X-Received: by 2002:a05:622a:13ce:b0:3b9:b9b4:cb8d with SMTP id p14-20020a05622a13ce00b003b9b9b4cb8dmr5606794qtk.11.1676394577365;
        Tue, 14 Feb 2023 09:09:37 -0800 (PST)
Received: from debian (2a01cb058918ce00ffc7d132b72de2cb.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:ffc7:d132:b72d:e2cb])
        by smtp.gmail.com with ESMTPSA id m126-20020a378a84000000b0073b587194d0sm2059470qkd.104.2023.02.14.09.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 09:09:36 -0800 (PST)
Date:   Tue, 14 Feb 2023 18:09:33 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     jchapman@katalix.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] l2tp: Avoid possible recursive deadlock in
 l2tp_tunnel_register()
Message-ID: <Y+vATfTKLogXw+Ki@debian>
References: <20230212162623.2301597-1-syoshida@redhat.com>
 <Y+pPXOqfrYkXPg1K@debian>
 <Y+u7hGIAxhvyDG/2@kernel-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+u7hGIAxhvyDG/2@kernel-devel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 01:49:08AM +0900, Shigeru Yoshida wrote:
> Just one more thing.  I created this patch based on the mainline linux
> tree, but networking subsystem has own tree, net.  Is it preferable to
> create a patch based on net tree for networking patches?

Yes. Networking fixes should be based on the "net" tree:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git

For more details about posting patches to netdev, you can check
Documentation/process/maintainer-netdev.rst

Or the online version:
https://kernel.org/doc/html/latest/process/maintainer-netdev.html

> Thanks,
> Shigeru
> 
> > 
> 

