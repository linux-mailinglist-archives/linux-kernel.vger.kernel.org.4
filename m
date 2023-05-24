Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA8870EA55
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbjEXAgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbjEXAgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:36:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA16189;
        Tue, 23 May 2023 17:36:41 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d2b42a8f9so129017b3a.3;
        Tue, 23 May 2023 17:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684888601; x=1687480601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lM8mwZf1wzxcL+2sWIBCczl6sqGrKSXPMj4ZkVBKhOo=;
        b=qNAbacy/jdZ5QIIrU4HSoJTCBeTPSZD4068sdrvfUVmOZFMp+6SeCedv/AeJ+E15mF
         0+UkwUFzlzAf/6hFDe21z+91zH7wZvOa3OpkEFLnZJiQZgUlmvcAdQ55e9LsJwWtlGmV
         TIa10HGUcfM4rjMU5E3wOh3zPLYayMMfD1t+afK4/uZGtIKjRVt9k1tQzW+C8TFzCq6l
         21V7EI+LBo9g05MBp7+h4bIskjcn62mJZ89R5wAjAPUDvaSqXUpv1lHekUUY5RNhS7po
         IKNJRMH9enNn/gDyxM2nKUC1kalvwOETiZPCMG0GnTpdEsY2gULXv8oftvO50yZVuQ5d
         mc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684888601; x=1687480601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lM8mwZf1wzxcL+2sWIBCczl6sqGrKSXPMj4ZkVBKhOo=;
        b=Jc42RL27Y2LJBojhLQY14YsuL9YdBmNjRhflgSDGwUGhd8M5AbWXgUbbG1UvwhbzMb
         gg3SbSex0SnIGUyQ/0lW4v6Ek5nQ7MPVGJxroPYidA8i4igt3ipGfpHwnvEnajikhlQM
         AjoUDhp8zTfT2MM511AIqUE9P1W9hmdJdjMJx7bRkLhUEgFVs4zocaiHYz4rwRcWehIf
         8ItgcY9/rApOij7Oq8OEUdpdZjq/VdU3R3tju4+Mo4nHpHXOHd+0UB78U82UCnzcpEAF
         0eMLt+tZ8etgkJ5gkfybn1huXlJR1ngTb3o8IKmq/xD4cHZop5bId1ODnCE9J2K9hX33
         D1jw==
X-Gm-Message-State: AC+VfDzrBtJubTCDNzAssX4HKRYwoPgRJpExevMM2iiO2oDYr9b5ISdH
        zoraHLcmlMOknuCqJBx5se8=
X-Google-Smtp-Source: ACHHUZ5HSIVPXwLR65r7ykB4jTSX75Gv5mKrFciBfJIMqHnqDHnFeyAEFkNGiBYPcgVvzWXe92/Wng==
X-Received: by 2002:a05:6a00:2488:b0:64d:3227:b806 with SMTP id c8-20020a056a00248800b0064d3227b806mr1078723pfv.33.1684888600567;
        Tue, 23 May 2023 17:36:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i14-20020aa787ce000000b00640dbbd7830sm6552369pfo.18.2023.05.23.17.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:36:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 23 May 2023 17:36:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 000/203] 5.15.113-rc1 review
Message-ID: <c9e32599-339c-459d-ad9f-f9e29eae2112@roeck-us.net>
References: <20230522190354.935300867@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
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

On Mon, May 22, 2023 at 08:07:04PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.113 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 499 pass: 499 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
