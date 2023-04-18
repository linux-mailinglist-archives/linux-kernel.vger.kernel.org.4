Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151576E5BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjDRIPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjDRIPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635E959DF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681805646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EGmsPhYqXkM4h3lS3j2J6rFOa5Kg9NoDZ6FuRnesr/A=;
        b=W90lRjQxYEpiDrx5JATs8+kR23fUdb3FhlWFcTC4RT/GC3YfKdI+ecn6RgBTpI97QwrXm/
        ZTjZGXp2EaPDmqf2wIz4IWS2iW6EvH7HwsX5v7rvoOK3juchKWV2HMfvwjQ052EuDZTxV3
        rBGiIh2jNAZqeHZyoE/v8M8alnDq/BA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-XVVcjkegNzuXuf6bgCfLkQ-1; Tue, 18 Apr 2023 04:14:05 -0400
X-MC-Unique: XVVcjkegNzuXuf6bgCfLkQ-1
Received: by mail-wr1-f70.google.com with SMTP id d21-20020adfa415000000b002f68de99106so1925618wra.19
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681805644; x=1684397644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGmsPhYqXkM4h3lS3j2J6rFOa5Kg9NoDZ6FuRnesr/A=;
        b=ZXoKlCGbsF5q6PLHFIRtjHj9F/35hJROEy1sRxGGsL2T4W/Eebet4vWj9RlWdSax3c
         utbcBj+ayRKEwIodJT0Yaq9pzEBmgQKozlPeLQfUfjBFJ/LQmBOC0s2h4LS0mf6xKUJV
         t16bPtIHm2oPm7GDqN8Iom7k5Tqj62z+2/Xpu93ofodpg3NQkQCQW+BpYguoLk4EGxDj
         hP4Q+qztVs42hOktN4A4iGUKvBIn9jou/6PhVLkOqB2UQVB2tI2SJoTj+JmKdBXKuK35
         /5THSZv3TWWu4XWlfOT3uDmV4hO3GmixsMCJaM/J1e2cnBeAU2kUdo93o4rUGwo9UrD0
         y3FQ==
X-Gm-Message-State: AAQBX9cF9xvQ3QNKTchRRmdKGNGEL/SQqBYYR5/CQzcmmlCtaOi6J0Ux
        AuxY28Hedn+iFYzc+x+FQutfFoXlsxEl2gBL+BpLbwhB2HT1MV5NG/Ni95hLW+Fq9Rvcs5YwQLj
        X3fpEBE90u+MgpyslS2y8tzPd
X-Received: by 2002:a7b:cc94:0:b0:3f0:5beb:6f0 with SMTP id p20-20020a7bcc94000000b003f05beb06f0mr12966600wma.18.1681805644137;
        Tue, 18 Apr 2023 01:14:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350aA7v1tMPmHJ6euPAD3upj/mGQ0RZG5O7DSucBbGroxI9JcIp3kDKJehA+p1y5A4FmxtBeLPQ==
X-Received: by 2002:a7b:cc94:0:b0:3f0:5beb:6f0 with SMTP id p20-20020a7bcc94000000b003f05beb06f0mr12966578wma.18.1681805643836;
        Tue, 18 Apr 2023 01:14:03 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id q25-20020a05600c331900b003f17b91c3adsm90863wmp.28.2023.04.18.01.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 01:14:03 -0700 (PDT)
Date:   Tue, 18 Apr 2023 10:14:00 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        James Chapman <jchapman@katalix.com>, tparkin@katalix.com,
        edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPPoL2TP: Add more code snippets
Message-ID: <ZD5RSOrpUusamkQv@debian>
References: <20230416220704.xqk4q6uwjbujnqpv@begin>
 <ZDx2IUYTmLSdzU6D@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDx2IUYTmLSdzU6D@codewreck.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 07:26:41AM +0900, Dominique Martinet wrote:
> Samuel Thibault wrote on Mon, Apr 17, 2023 at 12:07:04AM +0200:
> (That somewhat makes it sounds like the "new" netlink interface cannot
> be used (e.g. ip command); although I guess sommeone implementing this
> would be more likely to use the ioctls than not so having the names can
> be a timesaver?)

I don't understand what you mean by 'the "new" netlink interface'. You
can create a PPP interface either with the PPPIOCNEWUNIT ioctl or with
netlink. But no matter how you create it, you need a /dev/ppp file
descriptor associated to the PPP network device. Other than that, and
no matter how you create them, PPP network devices can be used and
configured like any other network interface. You absolutely can use
"ip link" to manage you ppp interfaces.

