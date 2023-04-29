Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CE86F22D4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 06:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347134AbjD2EKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 00:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346852AbjD2EKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 00:10:42 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263372D58;
        Fri, 28 Apr 2023 21:10:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b87d23729so557195b3a.0;
        Fri, 28 Apr 2023 21:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682741441; x=1685333441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvLvl+AjFmVyPv5uNYvodAxuZdcuS3mddIow0JZhXiI=;
        b=Z98WTyuoWTs5riplU1Q2eedbGpoQZ0jLyRa7D/jHuQYh/2crYqcZytjIXd7Kn6x23E
         V/StNDqRpSqUwZBF1p+121rg7xH5+614MpKZrrRx8mboov7TmweUU9vXjk9PwQngaiZY
         exOjEPD8Io8lQ0yO9M5DwKmWttEFau7WKaequrRdrJyhbStgKV+9OFQfl2+krHH0tgpZ
         5aSxwyoFf91JVPJhACRAmL7giLzQ/jOHamAun0KQYe5OE3php+pzdBleedI8plYhIVPJ
         820oqwPIMLd+KwmGm/6j0U6AoEEGgktor54dIjxg39tXojl/vUNIyUIoScqeYCrRzon2
         tyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682741441; x=1685333441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvLvl+AjFmVyPv5uNYvodAxuZdcuS3mddIow0JZhXiI=;
        b=bkU7iPtjFRHpXZVPc2kPW7VjBFWD9S5Lnj/JABep4J1da+vmBvDN+KPpdcsjzjmRsN
         ksUBqiu/wSCmgDuM+6oCRUPAsX6YCDdO1F73lnOH8s//MNKM8oyejdG2V7OqkRUrv+g9
         e+4+sQj9L9vVXIv6zT7n0K9r2fupbJezfsAVg9TJw06HYylMXurzIh5JJkR6M1kIdK5V
         PZ4zC4gJh6HRxyuctLa/BqoJTTDeWjNGG1dIbbkLZkFAx//D7MipnTKLfofIvGkilWLU
         TTegIYqYc7iCRyzQXzZvYUSqkeTTfxZT5Kq0QVFGTcj+NreZ1+I5lJ94QRQCPBkKHkIe
         SaKw==
X-Gm-Message-State: AC+VfDwClMmBYNAnJecjDTC6SUtBmsr4MTWXxXiM/Sz2neyq6rhZalC+
        8nc+v72TLlUW8oIo4AeBNto=
X-Google-Smtp-Source: ACHHUZ7f+lsdIuVBv9wr4OXv5fqOh7cH/hegiEQrfvJLj4bGXfwk26WXy2QJ2sZma9PqcQ4tNc892g==
X-Received: by 2002:a05:6a00:2d89:b0:63b:89ba:fca1 with SMTP id fb9-20020a056a002d8900b0063b89bafca1mr11227026pfb.10.1682741441520;
        Fri, 28 Apr 2023 21:10:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z21-20020a62d115000000b0063d24fcc2b7sm15876787pfg.1.2023.04.28.21.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 21:10:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 28 Apr 2023 21:10:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 00/11] 6.3.1-rc1 review
Message-ID: <5fe2beaa-4ec4-4f2e-825a-2cfc974a2106@roeck-us.net>
References: <20230428112039.886496777@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428112039.886496777@linuxfoundation.org>
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

On Fri, Apr 28, 2023 at 01:27:35PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.1 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
