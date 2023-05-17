Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AB9705D79
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjEQCwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjEQCwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:52:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0664E40F7;
        Tue, 16 May 2023 19:52:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24e5d5782edso389195a91.0;
        Tue, 16 May 2023 19:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684291940; x=1686883940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaTHqXWE1EpiMliJCprZs9xZj+DcX2XA9gKFLsIwevY=;
        b=isznSnUI6Jag61h3gdlTcxd2az5dkaJhf69SNArQCjOJj5Q1bzkNBjvajBXNT3L75r
         APh4j45eTRpIGpizESnBUqjfLnlORKFOvKPfOp9UEMuNJwDCYemaQebC5aHxVP0Fnjom
         qceCWmdcY1bzO+CCuDoUbDFUUenMj+k7K4a1swHAlGPy4V7xmLm1XVvo78mWIm8LZORo
         +bnLehJwOo5eGnSpnZk44sWPTNAQwilhowoRFpuGCmrkm/2sLE7gduwUpMgUUNh6HV19
         Dv8oiv6GvBwVrnQzJO8E+EjJFGldkdoEICc2wF62y7nE1SxLDl6hn8aNalalbKg6mJSK
         rZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684291940; x=1686883940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaTHqXWE1EpiMliJCprZs9xZj+DcX2XA9gKFLsIwevY=;
        b=IWo1Ka+kwkPpL9fzXV+birgQRRYgHuejAoHmN0tCM0SOryTx2PzfL+Fzq5b89NJoKt
         q5C7x5QXW15qsZuFg1UNxkKOpo4IOsCT3zcCR0lHqQvIyavghKXtIQHi5eAZrI/mtuE7
         85a6/oDH1klYJumZ/NC8mp00/HQ2nTp+OPnUHGJmdk6oVunRF05WRFo0EJPxjThaD5y9
         0XsjfmIuFM/DJFntGnC+oyAmNqCjnyyrOoyfbCeSya1QTB4BqlU4ziBm0zewl0iiHnX4
         cydZYVf655gi7slr6kGc2AgqQ5ElYvVq+BOGr5pEwiuDQ6zwfjYa4fAs/U0hET0o7g80
         5cOg==
X-Gm-Message-State: AC+VfDxsUBBsxxsK0OkA+3dyLsitqr3jehS69mSqcfTPnNNMholrBY/S
        uojw2mkuMEv/T6xktuasDw8=
X-Google-Smtp-Source: ACHHUZ4hGMFfasa4TY9gMKoC/mYVhcOMyxS9iCz1t2Hp5jnHlU/kepIw570D74PJDd0ghL5smGZ+vw==
X-Received: by 2002:a17:903:2281:b0:1a3:cd4c:8d08 with SMTP id b1-20020a170903228100b001a3cd4c8d08mr47903074plh.38.1684291940517;
        Tue, 16 May 2023 19:52:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g7-20020a170902868700b001aad4be4503sm16268713plo.2.2023.05.16.19.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 19:52:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 16 May 2023 19:52:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/239] 6.1.29-rc1 review
Message-ID: <1d30a01e-7e51-4152-b6cf-f3afe3fbe9b2@roeck-us.net>
References: <20230515161721.545370111@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
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

On Mon, May 15, 2023 at 06:24:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.29 release.
> There are 239 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 519 pass: 519 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
