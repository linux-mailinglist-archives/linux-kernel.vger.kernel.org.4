Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6908274893C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjGEQ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjGEQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:29:00 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2697A1703;
        Wed,  5 Jul 2023 09:28:59 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5774098f16eso73305847b3.0;
        Wed, 05 Jul 2023 09:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688574538; x=1691166538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsQgEMFM3mtzvgVBpT1aFEHWLRc49D7jcPk8h5Nd1ks=;
        b=q4z/7X9RTw5LAF+sLjQOLpziYsPj5A4zdgh7LlO6BCKh5FMnxFXZm0Z/XLO3zbi6Cg
         D4AsrYwtLuumwBclhsDZOOCfLl8qQsLi4YrsaKe8eZt6wfbb/Q6XOZ2fPtizUvPmkEtP
         OX9/PPe4122FrBRAryThc5YJ5cUQcYL/WY5VxaI/sGILdi8H0ygtPbGkToPOie3wc2nI
         WWKaJ61ISqjNKhv0gmuF5u0bpxdxlFYjoUewplLQsw4hyvRYBgp2r1Znb0jcsh6K4cwD
         a14sDSbrJkn7VNuHiji8WV/7/sUGixEVO2h1ToRhBHGhzDxlDKkzs4rNr5DReaGFbXUU
         fGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688574538; x=1691166538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsQgEMFM3mtzvgVBpT1aFEHWLRc49D7jcPk8h5Nd1ks=;
        b=bAL3rY/dGoO9DwtC5EiE4sltT2jkaNHfEwfUtw/zI/3qR4fsXYHBN2ctzakf3U2888
         LXfQLQgjoQ9dBycUL4+tqHwEdD9fZejeM+R2IoaXdAX8Ymkm5dtB2pujUMMz8y4Sby6X
         MlJVLnQ7JSzaw+7SP55bSIsj/Tqo6CH5SlW4cNnPoU22X/cNf+KRY1JUQjgTMkBVFm+i
         FqZmZKxTZVQpdb9tuX+RWiqIvkfZDeXs7q7tkUAOM3zjMK+Y4KUlGfgLRqgAoU+syGEp
         IBTE5e6yQgc3I4bveVQe1h12+mBU1NlzxDwTIPQMgpDNjezQTpJzsuIHsroEYw2Z1QV+
         ntuQ==
X-Gm-Message-State: ABy/qLbTkKwr34bD7vUA4PH+auI+p46Iz2O3aHtYUYPdIIjKrDYmDAe8
        cxYzsREE6mROdNyV8OvFxNQ=
X-Google-Smtp-Source: APBJJlFN0bjonq+219uKnrBI6oQSBKOMbONnXy9iOf2go4BwsSTLIwR+GlUvclNzSkqBAgQ98KQ3dg==
X-Received: by 2002:a0d:ca55:0:b0:56f:fba4:9b85 with SMTP id m82-20020a0dca55000000b0056ffba49b85mr15875344ywd.7.1688574538329;
        Wed, 05 Jul 2023 09:28:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h189-20020a0ddec6000000b00576e67820f3sm4913840ywe.66.2023.07.05.09.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 09:28:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 5 Jul 2023 09:28:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.3 00/14] 6.3.12-rc2 review
Message-ID: <8e8c0513-6227-49b3-a9e4-1d00fa163c1f@roeck-us.net>
References: <20230704084611.028211988@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704084611.028211988@linuxfoundation.org>
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

On Tue, Jul 04, 2023 at 09:48:39AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.12 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
