Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2663A73785D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjFUAjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjFUAjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:39:51 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E4519B3;
        Tue, 20 Jun 2023 17:39:37 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-54fba092ef5so4305695a12.2;
        Tue, 20 Jun 2023 17:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687307977; x=1689899977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kH35UreoOLAI7AawrIwf/RQ6GEC527GKJ67uTzyFpEk=;
        b=Tuq+knsGDvhVVnmMBJYyWidndARcXkKhQWqhBhbR07ZRjAu1YT8M9+cFIE3zTmR9zA
         grrclbAQ+cM0y+smI9+13t/O/xsv1G7Q1aTHWjPJy2/30wq+T+M8y6YF6qgYRWyA9DBM
         XbXFJ6Cw8/bMbNnA/NZG+gh5SNvKFHKf6SXF/4BormdarJKjGrTfzf99I0HR66WOett0
         iKdFRGvILf6iUa6oO/aYciEvAB+nO0p5uyDqoNkeabfOqH2EN5fopystJk5Ae13qJbU/
         ZvtpHezv5PJqDsQhlOt7ojV0Ctk7aOHYo0nwItjkp1lQaCrQ0Wvmw9PDtDBA6RQ0q09V
         4hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687307977; x=1689899977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kH35UreoOLAI7AawrIwf/RQ6GEC527GKJ67uTzyFpEk=;
        b=SOWKaH6AdWNwGjJIkyS19kEy5txJYwaSXSnWm2reKPTpcRa7zahO7CNOwhv8RXpHx3
         EackLJNNlWdnxICl/yFjbQ2JS9DcKsbgLcWRHbdA5KsS+nqFQhiq0xFuaegWsKr33A39
         VKa45W/95oVKxEGF0XWZrnwWRTPd8NGh/0b5S1yu1PL3rxlrLyKaFaK2oikXJp6Kc7om
         5UBt2Uo8ZU0J9uVU1klqlxN5bt8V78qzeQ2yJThWu83RdmjwQED34DB7HRTGKjEsaBG/
         ycJFbKdb1kHpZOp6Ew5J5Gy8CPZvgHtqKPZuVYtal2IZ5PbaeKrXxdX4iy8luqBDc27I
         bujg==
X-Gm-Message-State: AC+VfDyhzBhtVB4CUSEHd3FvbwKDbUuGwSseYKnDinK4E/W3vLuvmwd2
        5FQtAq5Y1HHPrOyUavZwRSs=
X-Google-Smtp-Source: ACHHUZ5Z6dKRWRT7aq3orpUPjjYQhFpNGLFpgjH07jyu/7RmToyIpFvqL7y2AZmfFNW25yckE4PJRA==
X-Received: by 2002:a05:6a20:734f:b0:10c:3cf3:ef7e with SMTP id v15-20020a056a20734f00b0010c3cf3ef7emr18580445pzc.42.1687307976785;
        Tue, 20 Jun 2023 17:39:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g7-20020a635207000000b00528db73ed70sm1932060pgb.3.2023.06.20.17.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 17:39:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Jun 2023 17:39:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/166] 6.1.35-rc1 review
Message-ID: <01eae2e5-cd22-4c46-a021-3670302e8dbd@roeck-us.net>
References: <20230619102154.568541872@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
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

On Mon, Jun 19, 2023 at 12:27:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.35 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 519 pass: 519 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
