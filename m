Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E6872EFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbjFMXI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFMXI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:08:58 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B74E6F;
        Tue, 13 Jun 2023 16:08:57 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-39caf0082f3so3174431b6e.3;
        Tue, 13 Jun 2023 16:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686697737; x=1689289737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9M/ss+rdoBanhZ72S4Y+ozQ77svOJMSyhGeoYM/6yQ=;
        b=R5A5l6QwgwIPYZcsFFFFNVy24AXx7/WY2c5KrZ7vW042rFwhFGIFO1vzW7sC4oGEBW
         PFjRLh1GV4BjzJjjoaPr1M+NSbz8lYuZHHb+xilq6sF1oYhQohD5B7SZOs22DqPsjFF8
         lMf6JwqhBAIi3aT5aIqgObSmWiVIsgniFTggRkz/or1IdGtv1UgboxhnmQ+OgDXIbq9J
         4mL9iehwAV+vK/BnrxctbSfFF238NOoqZw0fFzlNVcK476hVaifExiTw/IS7rpEX+fiu
         gNDgkuRUuMW4cGRIVGcchp8/PssRbONveNEQBCLdnC0YEProGV3tTQ0jdADC4B6ESjfv
         U/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686697737; x=1689289737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9M/ss+rdoBanhZ72S4Y+ozQ77svOJMSyhGeoYM/6yQ=;
        b=UIWM8amNBZKxnWnxe7D8v04iFmpDt8SpW0DQnnFe2QeVY16AnZG05phWOerNd+or9f
         3Rix0w6fQavKmK5lqZgyjB2a/+Xk8IvhW3zlQWUfpW/S46hGNf5UXkz1jZWbg/UWGFMI
         jGfma+5posoz2YK75SvPwoaiYLveb8pB9OwgemGMnsfXvikJXN7XkEfNMDAeP+RyXtkD
         taNa9szVCkxuUcE7e6gm9TL7zE47ytMdD1BxSXf3Cvnde3H15SfPaATkSGejqSgh0ASJ
         yzFNdoX82NmCZc+ORTtH6r2md2djKLqEDIQMLfMKCCTShv0gJA37bGnFDsEYE+VaUmMi
         cAgg==
X-Gm-Message-State: AC+VfDzNNt/8ZItowcTv5gtiVf+Wc0iQ+ZWyky3aW7QruRAh17ecC7tQ
        scDbpyPrKlz/UjzvEmnCYC4=
X-Google-Smtp-Source: ACHHUZ4yLU8QuJO0JPZqzDcwd6u0OOvYXRoadqagnOkHPpdqXHYSLIcFh01J5GDJu3By7WpG4Olk4g==
X-Received: by 2002:a05:6808:3089:b0:398:5df8:5d63 with SMTP id bl9-20020a056808308900b003985df85d63mr9237538oib.16.1686697736771;
        Tue, 13 Jun 2023 16:08:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s19-20020a17090a881300b002532ddc3a00sm11468575pjn.15.2023.06.13.16.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 16:08:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 13 Jun 2023 16:08:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 4.19 00/23] 4.19.286-rc1 review
Message-ID: <3879bcf5-e472-4a0a-9de7-49c767b23ee9@roeck-us.net>
References: <20230612101651.138592130@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612101651.138592130@linuxfoundation.org>
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

On Mon, Jun 12, 2023 at 12:26:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.286 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 431 pass: 431 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
