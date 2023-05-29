Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A335714DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjE2QH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjE2QHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:07:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B60DD2;
        Mon, 29 May 2023 09:07:54 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-256931ec244so646250a91.3;
        Mon, 29 May 2023 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685376473; x=1687968473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urDTXxsjrGokKJEuNqWBCmuPnIpK8aci2gJZ6+Wwrwg=;
        b=CDbxiHusCRrK1WBUSPRq4/nPfMfdkLeA1pOc8mTjLfeloNGcpEgZrCiT6snSsWb51z
         E7Bc/SHwCYiix8HdHRljCm0fjW2+DQjuveNO40FQin9bd/Oca+1jUjk/rJ763JvhVvyI
         1XD8L3OEevHlsye2ATa5xV2SNTiKnpGfzysXgBdkAVdGoBJtfeXQpHJal93eEdFbtyOz
         Alw9iwgX2dgi1ZiZZi3BU+fEqPMXNQb4+BJxeI2YBbN0QsrIUutCVIrgJeX7+LbNS1vI
         RuAoF+ORZEtK3hczBN5gVdcCZkk6YQM6UWnr997+9QhrUvOm+zm+O1iVtcTsZtKQfTBY
         XdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685376473; x=1687968473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urDTXxsjrGokKJEuNqWBCmuPnIpK8aci2gJZ6+Wwrwg=;
        b=e2I8kyiFyz+3NzsGEg0Lf86Q0NIm+XcUaRzGrifSL08h6zbvLUMTKJkvNamR977pEk
         mV7OhmXoGPmL3r8OgAGO9uYXfWFpN3L+1B8BuOuQFzmSThrIT9GLqwq5O12I5IoSoNC1
         jrIdv0OTmdks71FRkiwbAt3d2r7nfXUjbeu512Ki7WiAWOPn7Ipq1QvT0Kh2rc8OhzuJ
         inQnVma8QNBGlwO4i4sFECKi4WMag1ZpC49i3LC69Pf9fE/cs9QM6ZfiVx0oikt6a1Ie
         j7ihHTmlgw56ep4sXo2bcmVNmbDY+z7zTP8oaI4dY7Bg0zbcv9FfgShF2hnHzDePayIV
         yC9w==
X-Gm-Message-State: AC+VfDyCnMp4WBsV5P3RnqaiSEv6Wl0KdLXZZGSmjbZ79A4Gnmx9+ZWn
        L9sCsIUH2W2wB2N27a6Xnqk=
X-Google-Smtp-Source: ACHHUZ6K5y6yBeaLBTeJEdyC88S46Gtr0nXUkQKk46+Oj7BqXmPbAJPfXHOABg+IPVlA5applL8rRA==
X-Received: by 2002:a17:903:280f:b0:1ac:a6b0:1c87 with SMTP id kp15-20020a170903280f00b001aca6b01c87mr10631105plb.48.1685376473490;
        Mon, 29 May 2023 09:07:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902e9d100b00199203a4fa3sm8466280plk.203.2023.05.29.09.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 09:07:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 May 2023 09:07:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/119] 6.1.31-rc1 review
Message-ID: <7969ae12-4c2a-486b-b41d-1cb18178087a@roeck-us.net>
References: <20230528190835.386670951@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
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

On Sun, May 28, 2023 at 08:10:00PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.31 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 519 pass: 519 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
