Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DD974DC79
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjGJR31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjGJR3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:29:19 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890ED1A7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:29:14 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-635e5b06aaeso26744236d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689010153; x=1691602153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NijMvu4hDPVcn1xdPqxC+coZ9Y8AUqtC5nBuqj5T3eI=;
        b=HmtbopGCZEIoAGeA5xKlxgRxdSMmaMPuZJWEYjL6F+XIVF0kfNo4CmzxEH1m/e0WND
         BhKOOFPKkYxasJc4m2T36ZUAZi00BY25GduLfqKHLtYS++CuX7+7XyZlzEDYkQxBU7qV
         BA0b+CXNhHQX4UMb92RWjyFn8xejGejJwbsgmreeYsPVULuHm0DiHfIpJuT5k3QV418f
         9lbpUjDIYxRtqzlku2I6LGbzKWcejoFilD2TU3jeRYLdSMEmoZcy1RIxQgozCmcZ19dD
         XWYnpDcg53JFw1PCji7ANmzN+g3fAH4fgSBMY55TwdlC9UKKAMBWJJqztH3bum6ArnOw
         9bSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689010153; x=1691602153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NijMvu4hDPVcn1xdPqxC+coZ9Y8AUqtC5nBuqj5T3eI=;
        b=S2Q/QI0DXpG89I5moWgFjBZRYOcTavt5S5RCPzD2EHY9UGGuq/advobkpC+792AXPW
         1mbujkGt14A/EX5E6sb5SPNjTqll2uDBpyyTyAD5+GqSlxnNDxYMwfPY3qN+ikhc28ZR
         azGGmXiIkKcCBZOmnbkE6UtVzUcRUxzPzTwLIxE3P5Apwiv+xeGol6WfSmq35Px0w3nJ
         HQAKfKfLB0y/v6CwSvqiasEnUN8soD+PFBYyvj5guGglM1cJkKlHi5CZoQezJy/S8uqp
         iwm4JVRJ5MUiKjrSlfvsKQMD170MzfbGmopWwS3oQoF2ktao401Ha+n6vnxOrQsTZ518
         oBGg==
X-Gm-Message-State: ABy/qLYWyl+gZ5MW8YBZhyRfl3lBJliojievExey8ZpRh2cQONX0oG4q
        m2yi6FC6dnB+cmumYYUUHnR4VA==
X-Google-Smtp-Source: APBJJlEt/sUmDLXrLxo45lionjYNQmEHJgq3ERqjFIlGob/IwNHCoqaKp2l5acb5H1OG3gitrRV6Fg==
X-Received: by 2002:a0c:cb8f:0:b0:62d:feee:2520 with SMTP id p15-20020a0ccb8f000000b0062dfeee2520mr6258429qvk.51.1689010153723;
        Mon, 10 Jul 2023 10:29:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id h16-20020a0cf210000000b00636bde318bcsm47891qvk.61.2023.07.10.10.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 10:29:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qIuhE-0004Gy-QG;
        Mon, 10 Jul 2023 14:29:12 -0300
Date:   Mon, 10 Jul 2023 14:29:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] mm: Deprecate pasid field
Message-ID: <ZKw/6O4QmJMIRRP9@ziepe.ca>
References: <20230707013441.365583-1-tina.zhang@intel.com>
 <20230707013441.365583-7-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707013441.365583-7-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 09:34:41AM +0800, Tina Zhang wrote:
> Drop the pasid field, as all the information needed for sva domain
> management has been moved to the newly added iommu_mm field.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  mm/init-mm.c | 1 -
>  1 file changed, 1 deletion(-)

Shouldn't this remove the field from the mmu_struct as well??

Jason
