Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADA6705D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjEQCra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjEQCrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:47:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD5326AA;
        Tue, 16 May 2023 19:47:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-643b60855c8so199570b3a.2;
        Tue, 16 May 2023 19:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684291641; x=1686883641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZmEY7joOP2smV3ufIV5wtQ50nKOyO5RSPs1EXTLpO6s=;
        b=adluOgkf6M2EH1GV3xF+lre/wQvGXa9mA/zI++X2iWDGxt0tPWL0iDzY9iZavzjZfr
         Ag5HuJRT6J0EpCMK/oGfm3sAZkDOa6jE2DOXO2LwRIzP643D4leJZSY0SC1FJRf1kElq
         Oag23Ed11aAgtobU2h97I6mJsToOSYDVgPLw/oZNATJg97J62jSVue10PDGEctMJrBC5
         l85/AK8KVpVpsuyxBV6jOOG4vdHEHIXevslOTsUuQC5YEwuiHBco9ebVxh6gV0tyes/R
         8u3cesOdZhyE3kmKNwJgsn5y4OEcCXNAWE5CYrJ5H+J9AVbzxMym7lKKq1UzYHIpIN/Q
         dy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684291641; x=1686883641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmEY7joOP2smV3ufIV5wtQ50nKOyO5RSPs1EXTLpO6s=;
        b=hU3wnKF409/OGE5asXr1JzUPP82tjCU9LP+tVfv9z8VlhIxViD2E8HbOyV0khI7dK9
         6XKe7PnT3ZPeNl4NV3CCLmIkObyLFIWH3c7VWiP9moCqvgQyIThb6y0oSCpbFVU+agaz
         clfniXlX52cqaDBo9eQFd1ZluydK+3C7JvOVBFuv3IM6ibjlqRPxxRvvSGn4uIW/rZB4
         Yx5NYj8qTHJEWiTLSBPyf3xe8Sl/0fRZseTtbty+28UuaCO+79WiyS9yzohVNBXEL8sa
         DUqC17HLCto0kctA9HVSVy9cTJz+AgIGfJ+B2YgeGCxij9qjk0Xmp/FsAq0Cri6aX9FN
         q/nQ==
X-Gm-Message-State: AC+VfDyvSWCEfs+2dUhHq8j2ftNCXFuIgtD8ss39h+sF1eCw2ebTIHmg
        7mLreHFzFCl7W82jacS5Srk=
X-Google-Smtp-Source: ACHHUZ4fiWV0hVLkM5e6EkSfxjeQuFA03yXTwqQx+0RYACKxW3JX1g/49w5DoQaBPAZRE+Ch9VpVIg==
X-Received: by 2002:a05:6a20:54a2:b0:100:85e2:26c9 with SMTP id i34-20020a056a2054a200b0010085e226c9mr43226201pzk.13.1684291641433;
        Tue, 16 May 2023 19:47:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 63-20020a630242000000b0052c737ea9bbsm14352099pgc.39.2023.05.16.19.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 19:47:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 16 May 2023 19:47:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 4.19 000/191] 4.19.283-rc1 review
Message-ID: <f2c6e976-f430-487a-b073-5dc3790ed04d@roeck-us.net>
References: <20230515161707.203549282@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
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

On Mon, May 15, 2023 at 06:23:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.283 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 431 pass: 431 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
