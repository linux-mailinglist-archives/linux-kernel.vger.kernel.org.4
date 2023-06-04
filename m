Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B803721757
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 15:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjFDNSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 09:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjFDNSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 09:18:12 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F80FD;
        Sun,  4 Jun 2023 06:18:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-653f9c7b3e4so928501b3a.2;
        Sun, 04 Jun 2023 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685884688; x=1688476688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2antYKxvIwNmqy5CZTA/jD5hacvCwsyZLTjfiBAziik=;
        b=apiWE5SRBAi8uhX66jCjeKU/pAGIqPIf3sx18YKQoluVhZ1rMYOCMkyA44lGq0wu5M
         GAYpS89unkdusP6Qoy9ECNqoYMYNkiDLIQ2Omg5ZkGQ/UPGVKV9okfmQJ3ha7X204avg
         8gx807hiZF+r/V9wth0N3OXFnXr06vJcVfY28/jD98FdPfzCNcyB1O9sMN5CoBQP6Ugp
         aSuPZNfZyI2crv6+4mhh29PLrPef5a30qZQfT5/FKF5gvT+uBjn4ssurD1xMDjyujrK4
         VGD9wuLck5YZB7Ef2gFi4nUOKJmxNt2gKaeJHRG36oRCJKnfsfWTBlEwHKSJdRF2Nqlo
         VRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685884688; x=1688476688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2antYKxvIwNmqy5CZTA/jD5hacvCwsyZLTjfiBAziik=;
        b=XE28hSDpICZEcj45sNHEkhvO5ccTKPDvg8sN2WrfLQFNq0Itbl8dJzmXthp7xzfAQ0
         o9L+sZUrWJlSGxYR52YIqIm68CDI+wwjSFT3ClrXALlo7VMqHtmJdiTM7ikfyoKo7542
         oEhvG9XQrg5K1CadknK0ol8P5fBYVgT73K0DtKuX1mf52kaR7Bx2TJTt9zDhWWJ08Rfc
         mNBkEzi0caDyesmhdUZFwkjsWRmGcWKVY1MEXDoK/urBHW9f28BvJNObliwfzOY6vMyc
         zSoVgp5tnmdFsc3PS2UUPyep8jTfVrHXitU1O9TjMWQenHLP/XMlgVZwbVq5lKer40FI
         sw8A==
X-Gm-Message-State: AC+VfDxytX1ylewDcx2tLtt5Rzt0nsYjpNlOvO989B3oa4xAfsN8gRTw
        ZDT3tYOp6i9VWYzLBHz8+H8=
X-Google-Smtp-Source: ACHHUZ5tZkKgVKSpfQF4V5GjOlVhutEKUzrn1geCssyoRpjtBxkGmkQwJVBs4pJUDHofdpjPNuRqUQ==
X-Received: by 2002:a05:6a00:15cf:b0:653:a56:db9 with SMTP id o15-20020a056a0015cf00b006530a560db9mr5688123pfu.7.1685884688369;
        Sun, 04 Jun 2023 06:18:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w12-20020a63474c000000b005134fc049d7sm4152597pgk.31.2023.06.04.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 06:18:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 4 Jun 2023 06:18:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 00/35] 5.15.115-rc3 review
Message-ID: <a298cb13-d3a8-4c2c-a17f-6570698d4e02@roeck-us.net>
References: <20230603143543.855276091@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603143543.855276091@linuxfoundation.org>
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

On Sat, Jun 03, 2023 at 04:37:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.115 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 05 Jun 2023 14:35:25 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 499 pass: 499 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
