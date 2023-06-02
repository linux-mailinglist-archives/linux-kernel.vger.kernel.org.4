Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853907207FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbjFBQ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbjFBQ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:56:53 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8A418D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:56:50 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6af6db17a27so1313013a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1685725009; x=1688317009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpFkoBOgIhm6mVYnAm3/uE52vs/uGNgQbLUnzZ8e50A=;
        b=OYTGcuM33CecRMp0bGXgKRvNrSjIqKgpvkYDOSRdh6fe8CHOCEdAr1Frby7/3YtOWq
         seQc9WxsFfEXsBsVEPABs2F5x4iUvW4Fju58l4vzqWHstTxWJun+rg22pagiK7Z6HpEA
         W/72rYdED9jIxY/+FA+YrIo2TEfPcD2bQNRT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685725009; x=1688317009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpFkoBOgIhm6mVYnAm3/uE52vs/uGNgQbLUnzZ8e50A=;
        b=C8uO11PqLtIV2maEmJNfAlCvSDhM6Z5cM7gzO07fCpI0mSqJItqrXS6ax3RlkYEyXY
         MSjwFHwJQRh6NfnOR5E+4Dnds971sicKUOPuNSSt4zHaMPPuT+RG0661Rh1As5uBZIm/
         9WuU4E9pqmfoEGH7QEHUVtHPLTHGdAZviaEPIBxIjG49nGv7W0TN2tXYcNOAtfgaeIy+
         2CQGk5eZSAZ+XwwlpZ0uZD9QWLuaCPXT/O6hfXIE8Rl6wk3pcsCkdC062LQXmbJ5HVWg
         /0JuhpYUGTtiuDqATcrdm9NPO/6G2KaoVUwx/EXWbrnO9n9VGJydmDem7PQMgb6KsNPL
         0EVQ==
X-Gm-Message-State: AC+VfDxd5vNMtpfaxjTZ8BWC3FcpOklWeu6zUZqlVvjj2ySmMqoeK0vg
        1oJ7ORbESdqHXV6aDgqvwbUIiQ==
X-Google-Smtp-Source: ACHHUZ7/PTjo9k0bGsi3dIeEZREUXDAf8wSbxwJM45eAIKUPenOyP0DS66nNoBJMRzqoRnm6VX+zDg==
X-Received: by 2002:a05:6830:1042:b0:6af:7493:79be with SMTP id b2-20020a056830104200b006af749379bemr1930925otp.10.1685725009629;
        Fri, 02 Jun 2023 09:56:49 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id l2-20020a0568301d6200b006ab305429e7sm807579oti.0.2023.06.02.09.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 09:56:49 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Fri, 2 Jun 2023 11:56:47 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 00/45] 6.3.6-rc1 review
Message-ID: <ZHofTwvKfnZmRhww@fedora64.linuxtx.org>
References: <20230601131938.702671708@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 02:20:56PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.6 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
