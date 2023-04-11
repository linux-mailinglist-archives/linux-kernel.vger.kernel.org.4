Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448BD6DD30C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDKGlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjDKGlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:41:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BA3358E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:40:55 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a64b65b2a0so2938215ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681195255; x=1683787255;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P9E3QUvAQUl3o+y94u92fiPsX7FeUqAvp4hYEOQvbNI=;
        b=bwSwwNrwlSHWxctuiILVq87IWdaCXi4nEQhZKXaFKHGDV/tZDxpAQPzI+p6nuAZ9oG
         n1bGcDq6OmaIFf4BQ0LvKfD3Sci1+HNPwXeZR0+OBAbB4KcqUumNf/FomVxTcM5mTv+X
         U+gGK4q/s7oHdLvaIguwGGZNi6Vu4uBzRO/7q8ZxfUuf4FlS/D26aoriZzdzM0kLOMLq
         hIpZgKcLXDwwgf9rqcRDE5C68WH45Nzr5xchIIECs8/4QL8284IRb9FR0zfEF+yGY473
         DhZNzPwfq6EM5wGOPi/L7GvR6Q36+NW1KHS4uhqNAkD6KpzaPr5t354cEGzZzKLmCtns
         JxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681195255; x=1683787255;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9E3QUvAQUl3o+y94u92fiPsX7FeUqAvp4hYEOQvbNI=;
        b=ibxcXgHAZ5vs7wIrVJENbfc3n35tZN5wGQWbp9TCVGkAy++UXVR94Gf/TRn85DczBA
         mUbWQ/zzgvm4TQ55ZSnaUSMIEynDt3Rv+ZYYCKEKY1426vs2J9UiB/tNgzOm3n3CPUx7
         qdjT+4wpUb9BhS3aiijD6LE7ox4xKiEmQx+hTTOUipst/2l3PRbvjIfN+aKaQ6WNpVmC
         6sxcT0vT0/dP4xY7JmCfy2uncImZywbqLqOaHDUYynK05aP/r17LCJR6lMpA2mE5lwjz
         WxFfdO1w8JQnut5Cjxi1dMV6k9PLZegflQOjt7xcAEeSzb10Jtz14BlNH+iYXcusIxrq
         gHrg==
X-Gm-Message-State: AAQBX9f+Z0reCOnvphSLNgbrMUw4RbPLOiKDFszfrNnMZKFDTofTjYFp
        Uqy1dt+tFGFAg/B83Sm/fCSJucFeCBb1xJSWGMw=
X-Google-Smtp-Source: AKy350bAlb+cDbia8QKfCMxPUZQ30JZAbWebYQ1BSofjHaVQ6jNlpGiW52J3dB+BLo3Ik/HcvQl1ug==
X-Received: by 2002:a62:3802:0:b0:633:5c46:5a68 with SMTP id f2-20020a623802000000b006335c465a68mr9465898pfa.10.1681195254722;
        Mon, 10 Apr 2023 23:40:54 -0700 (PDT)
Received: from localhost ([122.172.85.8])
        by smtp.gmail.com with ESMTPSA id d21-20020aa78155000000b0062e0010c6c1sm8836856pfn.164.2023.04.10.23.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 23:40:53 -0700 (PDT)
Date:   Tue, 11 Apr 2023 12:10:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v2] cpufreq: sparc: Fix exception handling in two functions
Message-ID: <20230411064051.qyioheeoectj2lv3@vireshk-i7>
References: <b3cce5b3-2e68-180c-c293-74d4d9d4032c@web.de>
 <2d125f3e-4de6-cfb4-2d21-6e1ec04bc412@web.de>
 <20230403033529.x6n3ihhkypwizq3b@vireshk-i7>
 <39342542-9353-6a7b-0aa9-f9c294b158cb@web.de>
 <20230403230432.xeubpa3cc2gt4mw3@vireshk-i7>
 <68b1988b-987f-fa2b-111e-b1b42f9767ab@web.de>
 <20230409235511.7xxqdxsqtflrhifk@vireshk-i7>
 <f9f40c8a-a392-27e3-b19c-c8985a163159@web.de>
 <20230411033048.zwsijlyiksjcmgcc@vireshk-i7>
 <e53bfa4f-c4b0-ee80-a64c-be8e9af76230@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e53bfa4f-c4b0-ee80-a64c-be8e9af76230@web.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-04-23, 08:15, Markus Elfring wrote:
> >> The setting of the variables “cpufreq_us…_driver” influences the need
> >> to reset them to null pointers for the desired exception handling,
> >> doesn't it?
> >
> > This is what all should be done for these drivers I guess. There is no
> > points doing the dance of {de}allocating resources unnecessarily.
> 
> Are you going to integrate your source code adjustment according to
> reduced dynamic memory allocation?

You can prepare and send a patch for this if you want, else I will do
it.

-- 
viresh
