Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE856C3903
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjCUSQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjCUSQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:16:40 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A061F18B3F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:16:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id s8so19985475lfr.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679422590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KDFZrNSGbx6kXfBTWbHiu3B1ojrpm5J95xJKok9hpdg=;
        b=oeAEXQx8p16Bf8q8S+69VRYyQAd/gXz+2xFAAtBBZ7kEI62axDYCyPj5jjIbQwZ0ju
         4Q8w9jQcT93gT2IWzlOfedSNMs7fRVWNLlqa4tPEuF2Q+NHurcTWAqeKBMgM26Z2wrFV
         VMIwhiDD9cFKyXYm8BCe4WrDoV+4CABlqGkGLQK2c2AXLBaBvoaRFSp7mFwYmk+VyTbY
         G+qZqXYR0wmPeTxVFoNDSkGHjcTUeQx/feuLv3dFJKVGkf83w8wJtuaJgeTZGalmOQvn
         KcpUhfRG2nN4KWODqklQrig7f459GE7AW44PUZBXxFRCZ/6ei1hjiGhLlufUunCx2vNn
         jq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679422590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDFZrNSGbx6kXfBTWbHiu3B1ojrpm5J95xJKok9hpdg=;
        b=PZsLI4+5l4CpA4QE4ASeCSW94nkNLv8vhmOHVnO5YZHeN7jIBZ2eb43YmwFzxudKyX
         HtkABkCox9qV3S5h7nzxudo/3fzoIFnuNuwSwYzh3FVomLTf8CBI8FHYnTDwv5THDKoZ
         ogDJQsquHlD5HHTQeQ6zntDdi9jL1CTn11O/WtwKpqiqz+bTmJmDHLAetZWtLl/mmL0n
         fUk7m8UDCIf+jrCpIMYL6z1pp44cPBksc0os/ELFmJsWQPKAhmVfifjFGwMp4ssivRiR
         5hqPxwFUVlY3SeIy93vccy1g00hKD3UogdPt2oOO3NtuknyC0q4GbQOBMozQYNzgKRlL
         M3yg==
X-Gm-Message-State: AO0yUKXfTh2NJUc95U7gyQoBh6Qa7BqGfRpQwC3+mOzaSgLhkcNPuOpU
        Q37iRhLGSnFLpXYH5vOLrrQ=
X-Google-Smtp-Source: AK7set81Z5rRpqlVAcKNnMlWpVH8OObsxQcRAXiPFZ/IH38XbWI3XLTu5QiQD/i8BHk4h5bTsJp6BA==
X-Received: by 2002:ac2:510c:0:b0:4cc:73ff:579a with SMTP id q12-20020ac2510c000000b004cc73ff579amr1063295lfb.38.1679422589928;
        Tue, 21 Mar 2023 11:16:29 -0700 (PDT)
Received: from pc636 (host-90-233-209-15.mobileonline.telia.com. [90.233.209.15])
        by smtp.gmail.com with ESMTPSA id l9-20020ac24309000000b004dbebb3a6fasm2259384lfh.175.2023.03.21.11.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:16:29 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 21 Mar 2023 19:16:27 +0100
To:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] MAINTAINERS: add myself as vmalloc reviewer
Message-ID: <ZBn0exbF9PRlv67E@pc636>
References: <55f663af6100c84a71a0065ac0ed22463aa340de.1679421959.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55f663af6100c84a71a0065ac0ed22463aa340de.1679421959.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I have recently been involved in both reviewing and submitting patches to
> the vmalloc code in mm and would be willing and happy to help out with
> review going forward if it would be helpful!
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b79463ea1049..69d19130af2f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13419,6 +13419,7 @@ VMALLOC
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  R:	Uladzislau Rezki <urezki@gmail.com>
>  R:	Christoph Hellwig <hch@infradead.org>
> +R:	Lorenzo Stoakes <lstoakes@gmail.com>
>  L:	linux-mm@kvack.org
>  S:	Maintained
>  W:	http://www.linux-mm.org
> --
> 2.39.2
Makes sense to me!

Acked-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
