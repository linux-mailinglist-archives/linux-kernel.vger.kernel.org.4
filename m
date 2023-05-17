Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A23705D71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjEQCtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjEQCtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:49:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F547B3;
        Tue, 16 May 2023 19:49:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so10051140b3a.0;
        Tue, 16 May 2023 19:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684291789; x=1686883789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5Hu/pfh6heq83uqkqoHwx78gypqIXAEufcYmbKjLXk=;
        b=DqUCKOkTV5NTLs9/3LrcKWL0q4sjkAZSk1eCnfxnr9yZG7ZUQp4D4q8wC9N5qG9gGk
         xwhIYWlu93bS+7jvaocupczzqsNp62qS/1UCLcMxHtixd16yQvutnplJzdAV9P6n4jVt
         3FmY80JW2FnGt6stjHlIj2+UqU7Oz+lVJ7obnlIfzDPISXB3UdePOZJkx0F00VAnTTLS
         Rv2UYLFZ1xTBFjk2TG9mza0092KEiH1pn/NT7jyddLGAgXMF+ZztIULbzysRNvMJDKGL
         BhPtbSR3zuXuxQDSzvvRbG3H5UVIL2Zs+27HIZs28rXU9rTpCGFqHH5kZduwUkcxBOSZ
         P7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684291789; x=1686883789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5Hu/pfh6heq83uqkqoHwx78gypqIXAEufcYmbKjLXk=;
        b=Ylr/pG5norAKN+sS3TV9bmGHFSHFp+1ImscR7nwP3YcE2y/CokjrvttNTcxc0cXNs5
         B0Oe8XAyJVgAdo2CxMZpXIjy+XqPYQkdG3Mh1A8sbG4y7WO0jFROMS+tILsVPRA3kd68
         eo9w7ajlAO8Q1kcfUlfiEQu2HZFGY6EaCQsKqriGdcnIZd5AiGDbHnBBhdSo+jvJH6sV
         a7t46I46PvtLfd6lvRUrZ8Ekk7F1fQiXAomhOOrGvt2x8SneCqczWGv0EpJjte9RjBGR
         tHiZMPZydNGIFQPMWO9rGDFquHQkzRAF0nLkW1Sz8OUF2syvayrnEQrZCMSVVZtjMnir
         5lFw==
X-Gm-Message-State: AC+VfDy9k19wxzzOlGO2B3c9dq+k0KV7O7Y7hD5RaoQqeKKYCNqvSJn0
        K5hpGdn4XQDkrmiGEZ1etlw=
X-Google-Smtp-Source: ACHHUZ6wrbUWipYAF7ePukEX17pMnZjyX/PPIDzXkmrRP0Avx8utruS8ChESKc4/EcfW+bKDkMYdrA==
X-Received: by 2002:a17:902:f612:b0:1a2:749:5f1a with SMTP id n18-20020a170902f61200b001a207495f1amr926119plg.26.1684291789466;
        Tue, 16 May 2023 19:49:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7819a000000b0063799398eaesm13991553pfi.51.2023.05.16.19.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 19:49:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 16 May 2023 19:49:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.10 000/381] 5.10.180-rc1 review
Message-ID: <b2f06ad9-f298-4b97-9a5a-b40243910f7c@roeck-us.net>
References: <20230515161736.775969473@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
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

On Mon, May 15, 2023 at 06:24:11PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.180 release.
> There are 381 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 162 pass: 162 fail: 0
Qemu test results:
	total: 485 pass: 485 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
