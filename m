Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B19698114
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBOQk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBOQkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:40:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9FF2137
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676479174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IOpW2pToLbb19g+Edc0IdmB1Z2NNyNsORJ71Ae1vdjY=;
        b=DYkZ8lIxrfbYccoFp0GX4V1Mc5Upwa5/+z/gi27/Zsjku4oQWkaPZv4hoA2hQskp1Wf/r3
        WzSG33HmErZ2BVXDp5oTfP3JaGQlyif5rG0c1iSMlxxOiJkKG3ylOnnw0DJHNPOpmAqIMg
        HMROjKTZ4VUK6R23RTtaYxOiF4waNdk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-133-9TjpZY9dNvSjGPexbb2JZw-1; Wed, 15 Feb 2023 11:39:32 -0500
X-MC-Unique: 9TjpZY9dNvSjGPexbb2JZw-1
Received: by mail-pg1-f198.google.com with SMTP id r126-20020a632b84000000b004393806c06eso7379059pgr.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 08:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOpW2pToLbb19g+Edc0IdmB1Z2NNyNsORJ71Ae1vdjY=;
        b=j1UbEtSgnzotIY0C/KfAnTGE4DlPWVxWAvgYntUjD2O6tPLoFSoyxr7aAACPVmVyUQ
         kDnVjVw3Rmazc0Evk1gUEqe0dBuSi2IFuT9SGXBZh+2wHxhN2xprLM0y2Rx8+G9f6Qsz
         c9Hd1ITt7NfeDzwJs9EY++gWpMctgqOMsaMO8T/iJw9wghVhV3n0Oet/9CI2A+QGhVI5
         KyvUO+bczGyft8BPbe5sC6vucofbIqlsi2p5GYdcccPq2YtZTfv7qaKueaSrBcbO30HT
         HmpjBqUG8nTvadTR1kAzhK8o0Kckj4vWeJ+T2bd01dCXyrkCS7FrlGB6Oud/oR1Q0dWB
         rcJg==
X-Gm-Message-State: AO0yUKVRBOymntK420WaVdqeq17rg7+74jzve9zE2tnMhVEOCdplvPPC
        m1EUxVXbFtQxMavTXzlsAnFlCq0Kf/2oyq/Sf0I+oQnHBR4UJAFYmXMXXwCzWo/twAzEtj9cKmg
        4616imcaMQzZ4RqQhUU8a52Wx
X-Received: by 2002:a05:6a20:1ea3:b0:bc:9f82:93a6 with SMTP id dl35-20020a056a201ea300b000bc9f8293a6mr2083051pzb.7.1676479171505;
        Wed, 15 Feb 2023 08:39:31 -0800 (PST)
X-Google-Smtp-Source: AK7set87s3/OopGxbp+dxPJ30N0ZplbtCCAZgPj4qhzlnsoRAO6gzntErNlz9dx5Af/9I/IecVNhkQ==
X-Received: by 2002:a05:6a20:1ea3:b0:bc:9f82:93a6 with SMTP id dl35-20020a056a201ea300b000bc9f8293a6mr2083031pzb.7.1676479171146;
        Wed, 15 Feb 2023 08:39:31 -0800 (PST)
Received: from kernel-devel ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id n15-20020aa78a4f000000b005a8a5be96b2sm6325557pfa.104.2023.02.15.08.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 08:39:30 -0800 (PST)
Date:   Thu, 16 Feb 2023 01:39:26 +0900
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     Guillaume Nault <gnault@redhat.com>
Cc:     jchapman@katalix.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] l2tp: Avoid possible recursive deadlock in
 l2tp_tunnel_register()
Message-ID: <Y+0Kvspkx4n2tWJQ@kernel-devel>
References: <20230212162623.2301597-1-syoshida@redhat.com>
 <Y+pPXOqfrYkXPg1K@debian>
 <Y+u7hGIAxhvyDG/2@kernel-devel>
 <Y+vATfTKLogXw+Ki@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+vATfTKLogXw+Ki@debian>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

On Tue, Feb 14, 2023 at 06:09:33PM +0100, Guillaume Nault wrote:
> On Wed, Feb 15, 2023 at 01:49:08AM +0900, Shigeru Yoshida wrote:
> > Just one more thing.  I created this patch based on the mainline linux
> > tree, but networking subsystem has own tree, net.  Is it preferable to
> > create a patch based on net tree for networking patches?
> 
> Yes. Networking fixes should be based on the "net" tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git

Thanks.  I'll use the "net" tree for v3 patch.

> For more details about posting patches to netdev, you can check
> Documentation/process/maintainer-netdev.rst
> 
> Or the online version:
> https://kernel.org/doc/html/latest/process/maintainer-netdev.html

Got it.  I'll check that.

Anyway, I'll make v3 patch based on your feedback.

Thanks,
Shigeru

> 
> > Thanks,
> > Shigeru
> > 
> > > 
> > 
> 

