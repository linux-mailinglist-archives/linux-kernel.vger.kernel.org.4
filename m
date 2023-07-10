Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E61474CCDE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjGJG0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjGJG0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:26:01 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA1310CA
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:25:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3142970df44so3840462f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 23:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688970353; x=1691562353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RTGPRaTPsW1oLolTdR1W2eMZbk+GEZzuxjroyHe18Es=;
        b=flOhQFeZ/g7IAS0o/33S3qkJ2Pu3MgxVosOMBDHErB6MylnolQt+eSCQqNfaiTNL51
         y5ouTWnFs6r4BWVtVOjrW7di8BqRRLkZLXX+ghMbnuqE83Bk+8+Fh1UauD+VFFgwBGYD
         cb1iq3pGmW6f5AGRjAqMI5NmHn/ruKENY6qorrmHSb2Zf+bkdRckYKVf58/DGRduaTGe
         C2Hhhz+0GimNMQ9I1g493hapvlmW/olUyKv8ilA3MOumkLzJL8mnSLkLtP+Hz2Ksr5Pw
         C8OQXCsDLOplFYvOgRu8M/64gk4DAbnkrK8DWTLkSa66HmapEABdp0Zd1UH9gqu278R6
         XNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688970353; x=1691562353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTGPRaTPsW1oLolTdR1W2eMZbk+GEZzuxjroyHe18Es=;
        b=exwvIZra8u9g/LYOOg3/Mx7ganApYIsxDg3y1c9hmq8vWU2ksg5eBMDeMO9N5a/+lP
         w08rCRUQSkuXLukB+qr2g0ahJn7NpNAxKjwvemnXvRBYFWSASKpWb7Tv5NH3Unn80bxV
         TvdOGNXOItUGOygzo9FK13kegqCHWxFGy6rHDRsT22iXiqoMhA6vBVJeszo8WzaUNjK9
         rpNW/u46MosLyKak0lvg7FnCgFSELNKKgfh90n5l0GcHHD5eEvN7C8krPh5soYZDkk1M
         fGnsmJ/FU8cETb2wl+ERmE43fLlV7UEf6IFIQKSPpnZfWIeuHF4ETu+eu1kIjpg0KC9m
         iQLw==
X-Gm-Message-State: ABy/qLaaDephbW8F278AT0qHj87S9Jvka7Twjkhtih/N70+x/7If/4/N
        xxcs5+mybL2ZRaEgH9K9M+8nIA==
X-Google-Smtp-Source: APBJJlHe/ztQIOxhO5hduzvHISVsuPEATfvAy0wCgXbWJfUZ/z31/ad58Nmvho+qW0BLywAisppqAA==
X-Received: by 2002:a5d:6205:0:b0:313:f676:8343 with SMTP id y5-20020a5d6205000000b00313f6768343mr10235179wru.60.1688970352878;
        Sun, 09 Jul 2023 23:25:52 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i18-20020adfefd2000000b0031272fced4dsm10767459wrp.52.2023.07.09.23.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 23:25:50 -0700 (PDT)
Date:   Mon, 10 Jul 2023 09:25:47 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EDAC/i10nm: shift exponent is negative
Message-ID: <dbfac4bd-a9e4-403d-86de-c70668f6e676@kadam.mountain>
References: <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
 <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+UB+eYoYOOVH2bqnnVEJcLrxaj5A7-zyfgBM7hOf4y8zw@mail.gmail.com>
 <SJ1PR11MB608383A5841E4AE8D3A64B79FC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+VFYyTiQ7yhX=Z8-Q4QW-GMsGXMuEWxLjuoZ1aDB98qXg@mail.gmail.com>
 <SJ1PR11MB60832C7FFEF98EE33F255B9DFC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CY8PR11MB713495A12DE47EDC3B7C5E20892CA@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CAJB-X+X_KW=T4WOe2AS3SFFQKjt7VcQRFUCGYFcjipi5-aXdrw@mail.gmail.com>
 <CY8PR11MB71346D8945AAC57D3614CBE2892DA@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CAJB-X+Xe9H0O=-2o3hL+pz=aGdSRYX+hD0bAxUS11CZDRVZLKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJB-X+Xe9H0O=-2o3hL+pz=aGdSRYX+hD0bAxUS11CZDRVZLKg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 11:42:22PM +0800, Koba Ko wrote:
> tested-by: koba.ko@canonical.com

It's better if you put the tag in the correct format.  There are a bunch
of tools which automatically add tags, but they only work if the tag is
in the correct format.

regards,
dan carpenter

