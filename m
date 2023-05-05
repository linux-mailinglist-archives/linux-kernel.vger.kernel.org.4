Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAF96F7E02
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjEEHg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjEEHgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6804118153
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 00:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683272163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1CDos4xXpfX0yUzIH2R6tkwubXHkIXYBoy2gEXH5JA=;
        b=Ulu1OIJv+F5PRIiVh/+oSWmT47A8tnohcll3b6MIOvPvGoXJ4oTI/pvuYX0hOoc6eyP/qV
        BoVNt4/dLOGV62nGPxxh/ilaxgUFqzdD5KUovqWrCiJZfK+Ps9hgk86kpDaAB2ySQ69Gr8
        uMDP8vjVXwzRUrwJvwWe2jPii4PfuP4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-uM2D1bRJPYmiaR17oxBnYA-1; Fri, 05 May 2023 03:36:02 -0400
X-MC-Unique: uM2D1bRJPYmiaR17oxBnYA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f173bd0d1bso9394385e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 00:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683272161; x=1685864161;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1CDos4xXpfX0yUzIH2R6tkwubXHkIXYBoy2gEXH5JA=;
        b=PpBfKcJsWYK8lAtHwYYioom7ZtRnyeM2nvC5F/9nLD19qV3Wm1133rL4jmlXP1/jjD
         oLVsjnSGScg2QqiB+fM46UQ0p50HJzd8wUXSz87YF8Hw1EkISbV0UHvK7RrW+OtxWegN
         AgBYXMn9k+Gkdw4jXufrGYh/CoEDPzqHqdI/WCyCWcrChqC6TyB0iuvouTkkGgidj7KV
         snh/cPoqdP1bpqD+qVYhyjo5tJEDzfSKPairqjzlrMH7Xp6w2tFBCQ8Nzq+iMmQAEw19
         ooeaFUGRdTJpDRUyD0vjo4H2W869jTneCTqedJ6pgRi9oTM6qLiVk0dyEBCDlQMrrTWi
         LuNQ==
X-Gm-Message-State: AC+VfDzHSqoNpnrj7rtetT0yd9pxa3r5mEY6CQIx+Ngm5dAAgNzFoIcr
        G/Oi5XNgrLwSfgiJBKb63nZRzHc8PBUZBSqsDrk9wgr36yrg2Nn1ylym4YMKcaic8j1oRiBlOAx
        oj3Ko+aVTkcXpSDueOE2xE9/Y
X-Received: by 2002:a1c:f60a:0:b0:3f2:5920:e198 with SMTP id w10-20020a1cf60a000000b003f25920e198mr327460wmc.34.1683272161232;
        Fri, 05 May 2023 00:36:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5XUDdNnSt2o2Ebxjr2vrScxpisR6Dhq9Ysweo7VXotuNFB3rkH+IP2VGzq0fyN3ub0us6E+w==
X-Received: by 2002:a1c:f60a:0:b0:3f2:5920:e198 with SMTP id w10-20020a1cf60a000000b003f25920e198mr327446wmc.34.1683272160847;
        Fri, 05 May 2023 00:36:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71f:6900:2b25:fc69:599e:3986? (p200300cbc71f69002b25fc69599e3986.dip0.t-ipconnect.de. [2003:cb:c71f:6900:2b25:fc69:599e:3986])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c021000b003f1940fe278sm7185780wmi.7.2023.05.05.00.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 00:36:00 -0700 (PDT)
Message-ID: <fbf37518-328d-c08c-7140-5d09d7a2674f@redhat.com>
Date:   Fri, 5 May 2023 09:35:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] sysctl: add config to make randomize_va_space RO
To:     Michael McCracken <michael.mccracken@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-hardening@lists.openwall.com, serge@hallyn.com,
        tycho@tycho.pizza, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20230504213002.56803-1-michael.mccracken@gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230504213002.56803-1-michael.mccracken@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.23 23:30, Michael McCracken wrote:
> Add config RO_RANDMAP_SYSCTL to set the mode of the randomize_va_space
> sysctl to 0444 to disallow all runtime changes. This will prevent
> accidental changing of this value by a root service.
> 
> The config is disabled by default to avoid surprises.

Can you elaborate why we care about "accidental changing of this value 
by a root service"?

We cannot really stop root from doing a lot of stupid things (e.g., 
erase the root fs), so why do we particularly care here?

-- 
Thanks,

David / dhildenb

