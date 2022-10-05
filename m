Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5A95F56A3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJEOoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJEOoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861234DF38
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 07:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664981039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0NQQ894rf2uw+GLiaTPriKMLBx+dfQpucYnsDWrJcYY=;
        b=UniUVd180YKQL2pAIuKUOunEMlBx54rpTteWouSf6SasCyFwpweHkmTmUvCvS3jblkwmow
        FhwloAfo/3Y8lfiF3QuKh0Hc4Dh88Jyy/WbVxI9pzSTkBTKFY+t7lpsaO1Hwj8e6O3gdlt
        GAP4dDH6mL9uLsNuEtsksnfbAzi5iMA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-99-EcBJAY3YP8O-kz3vkvaD3w-1; Wed, 05 Oct 2022 10:43:58 -0400
X-MC-Unique: EcBJAY3YP8O-kz3vkvaD3w-1
Received: by mail-qk1-f200.google.com with SMTP id w10-20020a05620a444a00b006ce9917ea1fso14403678qkp.16
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 07:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0NQQ894rf2uw+GLiaTPriKMLBx+dfQpucYnsDWrJcYY=;
        b=qWPL8WiIYJFCtPSo7dCxPOrMtQ4rwMf6Uaz66A69YvdwsHiJqt23+uzLozNIO6THzI
         nNq1vaE7/8Q/aSA9Jlt6YLyGJwFmaron20gWQZs0fEEFAoXueFbKb7m/hxXTnCG9Il4C
         3RbJ0Pec53AfyNCdO87y0anhMsauBCkQK6Z1OxRlmpwGR4ladJPzSdE/2b+bfslr+25b
         sOuSb/eDZ2cVElJxMvac/h2G7u6Q4NnB7Kpy1VZShiOj9qWdKLBsZxiMpcGBYcl3S9rx
         cqB9A1g058wduECQ4eX3bNyVaLsM4UvpL93bc4VA9O4wczwaz+99pzqj4YZDaZmDeiFQ
         uwOA==
X-Gm-Message-State: ACrzQf0AzMlIEjat93UbJh+lbunVcDk8zBVTKKjgZLMN7ZnTzPKp2wbj
        tU5YMJUQcmKU4rCnjhkpYpvVR+5iTMAUL1zd66vQp9Fb2JI6nzM/SZlRpH2NZgsRNxDf1QiNMZd
        VjKnWNf072ExhS53VKX7Pv6dL
X-Received: by 2002:ac8:5b50:0:b0:35c:eb1f:67d9 with SMTP id n16-20020ac85b50000000b0035ceb1f67d9mr24186292qtw.235.1664981037711;
        Wed, 05 Oct 2022 07:43:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5gBvGqnQ+9ASkMwEbWktnRvo+U9lRBOhofGT3FAWSNEjItybeyyumt+96Ti1ByplluThVc8A==
X-Received: by 2002:ac8:5b50:0:b0:35c:eb1f:67d9 with SMTP id n16-20020ac85b50000000b0035ceb1f67d9mr24186276qtw.235.1664981037503;
        Wed, 05 Oct 2022 07:43:57 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id f7-20020a05620a280700b006be8713f742sm17319447qkp.38.2022.10.05.07.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:43:56 -0700 (PDT)
Date:   Wed, 5 Oct 2022 10:43:55 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 1/4] selftests/vm: Use memfd for hugetlb tests
Message-ID: <Yz2YK83Vejc+QIez@x1n>
References: <20221004214125.120993-1-peterx@redhat.com>
 <20221004214125.120993-2-peterx@redhat.com>
 <CAJHvVchRHhQDug1Zf6ygdnz96Dn4tBkPpB5fO3g2EDpxFcwP+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVchRHhQDug1Zf6ygdnz96Dn4tBkPpB5fO3g2EDpxFcwP+A@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 03:04:23PM -0700, Axel Rasmussen wrote:
> We should also update the examples / help text near the top of the
> file, since we're changing what arguments this accepts.

Definitely, I missed that.

> 
> It might also be better to squash the changes to test arguments in
> run_vmtests.sh into each patch, so if we're bisecting we'll have a
> matching / working test + run_vmtests.sh combo at each commit.

I can do that, but may not be required - note that I did the first three
patches just to make sure they're still compatible with the old cmdlines,
by ignoring the extra params.

[...]

> This is a nice simplification! Thanks for doing it. Besides the
> comments above, the rest of the code here looks correct to me. Feel
> free to take:
> 
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

Thanks!

-- 
Peter Xu

