Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11502714DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjE2QGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjE2QGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:06:19 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFB2A3;
        Mon, 29 May 2023 09:06:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64f47448aeaso2516144b3a.0;
        Mon, 29 May 2023 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685376378; x=1687968378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q53lJcgOFRIoT/sqLBJuSrkzsCLUtjgdJNovsTwxUYI=;
        b=TSoVcNEC5KHzdSTV/COFmCiLlQoVey50m5D0ci5njG8P3y9SReGDBJFqZoPqyRr+Fd
         8Y77KcJ4EsYW8xZIRboZKdP1U/70rE0D/ygONF6JnEjTkrmAzZX+/R5uRcEEIqzrlI4g
         EYaSDLXlrep2lelBbTAU7DkrMenDx7YMXdfejPkyqmFnURpGjja0oAoHvCkou75/MwhG
         pl3AkjF4pIH0fhcOnq/WQHMrf7NC6ngLTmwk+jp2/usyWVKAwNqPnjPNEg5m1OhbZGp6
         vkecWyAcVGin3KNoXKBg98INVmoLWkXYSlJxQ5Za1SPWD5Xldiao/WVSg+QcLR8KEAiC
         +1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685376378; x=1687968378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q53lJcgOFRIoT/sqLBJuSrkzsCLUtjgdJNovsTwxUYI=;
        b=Nw5aViZlrlBitxkV9gMIUzpzAtIEdNuEuP/Q/tD6fZMm6xNc3gsR6wAO21R2fwGscO
         qatbdlaRZBhrCR7ZN742msL/Ugov2xa33wO9pkg8//676RBL4eSxP4JYtMzWOEWT07Wk
         qTRx6NtZCQt+XJQ4RQIUzQNnfTd/2DzwgCY5vScStlNBG9TFnqh/eKOdAtxnl+WJdUW4
         5A1LY9wTfOEMzQJ/6BZe+YW3e5V24z/J2p5q+ZvkN/JR1LDHynh/dcRrbkpIjn9s0yiL
         RNciA8C5BOZiyEH45bJzlsFvh4eX3hllkVvfyfY9Ebju2ITs3Yb8cjen9MI0j1M2mIgD
         xHxQ==
X-Gm-Message-State: AC+VfDyveh6thCUdzuLQQXiR5+tlILtJD0LqiZiydcC8tCg6hEFGZu9d
        FO/RH1MvKUBEGCMo+Dc6Dbw=
X-Google-Smtp-Source: ACHHUZ5zizGAthoUYgL1a63BdbwJZL2N8oio5nyEd5uwzN77OfObH0tATyO+zrhYChALeT/5a+AiqQ==
X-Received: by 2002:a17:902:7b83:b0:1ae:50cc:455 with SMTP id w3-20020a1709027b8300b001ae50cc0455mr9931389pll.39.1685376378133;
        Mon, 29 May 2023 09:06:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iz9-20020a170902ef8900b001aaf536b1e3sm1981439plb.123.2023.05.29.09.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 09:06:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 May 2023 09:06:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.10 000/211] 5.10.181-rc1 review
Message-ID: <ead0f6db-6400-4b5f-b3a0-9d9238524dc0@roeck-us.net>
References: <20230528190843.514829708@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
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

On Sun, May 28, 2023 at 08:08:41PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.181 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 162 pass: 162 fail: 0
Qemu test results:
	total: 485 pass: 485 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
