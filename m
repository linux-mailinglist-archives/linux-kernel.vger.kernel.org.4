Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872E26FCED3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjEITyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjEITyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:54:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE5D3AB2;
        Tue,  9 May 2023 12:54:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24e1d272b09so4701949a91.1;
        Tue, 09 May 2023 12:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683662086; x=1686254086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrVMLpxtsXEq0miSACw7WBy3JB6wSxJy7i4yWvfaf+o=;
        b=YCjelijlPfBaocwl8sr5OwbLT6+0dbl3jr/REZLPgEURMt7uR1z01cLuviDaxM7oP8
         dxndzecac6G1+bm9L9X2GbpNSM+jf909zWeXjFrtTi0owClfg9I3K0GsUwtZjWSMSRNn
         vNtIolpmhqw6Yak1qSxGUa2ggnMLTm/ijPRxNKEhdrqAFyjL94jwE4PFRnRhPXX6ODDq
         9tF65EgVK3beOm9/CyqrYMKGGx9aaQWdewdlFV2p6fiOT5VeOTKKfBd/o05tcs0qcWvh
         9ioAurEa11i+f6V70eJNrWBlul8PVJXFipJZkFgR3SN0NCtpAhqmxs9uDsSfY5tSAdjq
         3/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683662086; x=1686254086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrVMLpxtsXEq0miSACw7WBy3JB6wSxJy7i4yWvfaf+o=;
        b=eFyoztY4obfJKWE8L7iQZnMEv2rSzlCdLbWZIbsHmOzAYYpTSTNaa4M1MjHD+ra8HR
         YqO+PNFAeR1e4stt5zQAK0O99vOTejlurZq4RKA/iwXpD6Uh38PScE9ZnN4/vX/pLY+y
         9ri+8ewh3pPLSHnKaF/8lxisQRf6HVhX7afwbvEtkwS84EwAyh6dLpxhkvYMiI9rlhjw
         WlIXYUUBU9FhbMH7jwMxSTSQP7DeUuIRr6V28unlwZtDL2n8UYHUBS4PFIPJfdqUhkmx
         B1tqeg4Wdn4J4Y7eaD8trT1Y99MkY/0ibZaxpGidFbWXrUYq4QHjhaqy0DH0GHUUIaRF
         579A==
X-Gm-Message-State: AC+VfDwXuqVKmISbxKyLEAxCyOIIfc3AyIOhzTfMSlpkwa4IxUgh4NQR
        0mXbWYT1hOnPg6erPJ8otyPdOpgXzDs=
X-Google-Smtp-Source: ACHHUZ7NL5MWUC33nq/O/Q7kW03yeQu4uK/BMBxCBDGTehcQwaqbcJxLZw1lglgy/SOOFczujWJnEA==
X-Received: by 2002:a17:90a:384b:b0:24d:dc79:5901 with SMTP id l11-20020a17090a384b00b0024ddc795901mr15716506pjf.26.1683662086512;
        Tue, 09 May 2023 12:54:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g30-20020a63201e000000b0052858b41008sm1718442pgg.87.2023.05.09.12.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:54:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 9 May 2023 12:54:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 000/370] 5.15.111-rc2 review
Message-ID: <a6e27b30-b9b7-44a2-8b11-4d732e11cb56@roeck-us.net>
References: <20230509030611.521807993@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509030611.521807993@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 05:26:15AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.111 release.  There
> are 370 patches in this series, all will be posted as a response to this one.
> If anyone has any issues with these being applied, please let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.  Anything
> received after that time might be too late.
> 

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 499 pass: 499 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
