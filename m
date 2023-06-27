Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCED17405A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjF0VdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjF0VdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:33:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C95212A;
        Tue, 27 Jun 2023 14:33:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6687466137bso2785687b3a.0;
        Tue, 27 Jun 2023 14:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687901585; x=1690493585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgbDvvzUv8QtDJ40QzJnjKKZJrxnC6hVW/NOrwNS2pU=;
        b=TqkuFqpEAF0j6gP25gYyRdHaLlwMeoiRRSwcxhnP374icarclcMhqDNNbOUBGMBHDr
         mj7nhH27KJ8iWXR6Md2/vwfaMe2X6LnQlQV/8SRFuvtVyhdZ5unVkN2DrRKsR45sOBD3
         grl35H4Sd8xFopz6ZN4MFyshcTItPMDWzWwV/+JxB6N4SNfd2M1dKjyfIZlwWG8wtv2w
         Gb5FpJbI+Fu4K2evQ410eCdJiM1AUgbg3MAej7giGricDUMEfIG7e4G8+Dfu7qEn7i+Q
         PSrLxSUw45gF3IHDQjcJRzyMJN4/kAsPdE/Mm/UjR1sEi7hXlHBBHq9I/s14AjCQhqk2
         J6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687901585; x=1690493585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgbDvvzUv8QtDJ40QzJnjKKZJrxnC6hVW/NOrwNS2pU=;
        b=lFHv6+nW2pbI6PNrO7K3RSjFBYquHEPi2RtFMeq8YRxgSL1zQ3iscyuFZ4QD4ckctM
         z9SSWF+n5fv9flWwxT/xtdJ83mmygwLuWjE+f4zGg7O5olU0Oakr2eN75DgE498siJMG
         XQK8/qpoeSmn3zPIwd5TpCB6vLLdn4BGuZ1MK8A8soqcHd5cB3CHflXtjnYmamhu846w
         kHqKZBiLk9sOL/Pp22FMLT2nyVu5z587hc++D6/EQ2A0vpTyk+6dO1wljBmx3DW/6S4y
         kuCKezEnh+rIO6XPechXAP/AFzCMoBRyTbhpeNQgXvud4u8QX/H/xOsMXb2DqTmBYzcf
         WpRw==
X-Gm-Message-State: AC+VfDwQeWd9/eIxgAHfLOP3gc/68AnzezYKWV5WuLtJ8crUojf8ka0m
        6adEq4rnKStECAfJbbyuQ3A=
X-Google-Smtp-Source: ACHHUZ6e0+9xPrHdfZ2likvnrI0ojEz5hwqfheQVBPRJqYJAGeVWASjQhE0hLpAmsMsVkrcOro0NkQ==
X-Received: by 2002:a05:6a00:3909:b0:666:b254:1c9c with SMTP id fh9-20020a056a00390900b00666b2541c9cmr26761263pfb.27.1687901584729;
        Tue, 27 Jun 2023 14:33:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z19-20020aa785d3000000b00679efed4108sm3111394pfn.33.2023.06.27.14.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 14:33:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 27 Jun 2023 14:33:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.3 000/199] 6.3.10-rc1 review
Message-ID: <b772d50a-118c-41b6-99d9-e97d38d3c9b0@roeck-us.net>
References: <20230626180805.643662628@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
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

On Mon, Jun 26, 2023 at 08:08:26PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.10 release.
> There are 199 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
