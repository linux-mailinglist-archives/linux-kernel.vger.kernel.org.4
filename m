Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5174470DF18
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbjEWOUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbjEWOUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:20:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBBADD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:19:58 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso4530404b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1684851597; x=1687443597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qSaB8S6iMPltKJC6OceZ8AkCVMkwLB7jQ5nONfJjJWs=;
        b=lfNilZeefBWNt84JHJ0el8W+89Vs/JZYfiyTiA6G/aqGvgGwou0+z1E3Os/uHNNnkJ
         xo6SrNpz6weAKD2G5KaT+YIkQW5aDjDwhC+7sVswOhT8tZh2oybbAwy8QAPlzwOgKNjv
         6MYnhHXoXKFz3+l+vgrHZXoTfkYyiQpQYeXgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684851597; x=1687443597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSaB8S6iMPltKJC6OceZ8AkCVMkwLB7jQ5nONfJjJWs=;
        b=M8v9dc4WBTPWJ+8PgHAmNSKSkYjaLU/XagQ2693JLDQ2nHSPRNHyzsxkOrWMqWguZD
         OIiCzQw4Qlq+k+Xse2ggBbh55HuhnItY+bk9mMaUGfmB0hLJj/AxLugFq0hHe8agyfrp
         mJCIdnXvQZBbhb3ZFuAxPKtEI+45Qnn4Uzw1dud+cVBwamHPgcNJSGRxqqOYMhBDVbtj
         I8qB66VaAMQ0C4f7cnStwaewFamu6p4OHpH5N2QPqiAi89kn6oo+OkpjG+IK0ZLa6Cmx
         bjF0KoGru2LDvhTA7SCMnIEZxmacoCjbKQyKJYyBzjE6DpLbHV8PxupURQK05hHGW+fd
         AQ/w==
X-Gm-Message-State: AC+VfDxZA0qXdwhNbCjQu+VOCHK2makjLeyBzDUYNRdiAH2BvcgDLxyL
        WHZ3kXEggK9NO4ta3kSWaXBaRJI8u61wg56a/gn2Dg==
X-Google-Smtp-Source: ACHHUZ4KadxoD0Jt037h9tJ9dq8BsTt5jC/AWMCvzI/nuoobmcRmENwU0+79sZ6MvkqPkFPZFv7JbQ==
X-Received: by 2002:a05:6a20:3953:b0:10c:5745:3f4e with SMTP id r19-20020a056a20395300b0010c57453f4emr3506961pzg.56.1684851597339;
        Tue, 23 May 2023 07:19:57 -0700 (PDT)
Received: from d2762026c99c ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id b12-20020a17090ae38c00b0025063e893c9sm7577936pjz.55.2023.05.23.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:19:56 -0700 (PDT)
Date:   Tue, 23 May 2023 14:19:49 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/364] 6.3.4-rc1 review
Message-ID: <20230523141949.GA175285@d2762026c99c>
References: <20230522190412.801391872@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 08:05:05PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.4 release.
> There are 364 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.

Hi Greg,

I had the same build errors as Chris and Sudip.

6.3.4-rc1 tested with the following patch reverted
 "xhci: Avoid PCI MSI/MSIX interrupt reinitialization at resume"
  78887e3e5f00fca305670d8f3ba3c0f42b343047

Run tested on:
- Allwinner H6 (Tanix TX6)
- Intel Alder Lake x86_64 (nuc12 i7-1260P)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- NXP iMX6
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
