Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499B6728C5F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 02:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbjFIA0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 20:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjFIA0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:26:10 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2402D72;
        Thu,  8 Jun 2023 17:26:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-652328c18d5so937427b3a.1;
        Thu, 08 Jun 2023 17:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686270369; x=1688862369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsLHpUV3U4RHcYmttv82/JvsSyFIcyIPeIQmZazPerg=;
        b=JVxMAS5Rql8+6bB8cFnlTJE1Y+0PDTB5UwnRSgYerzJLulSMpalR6I9yuAcrJp2oZG
         pyktcLw+3fZ6jEQx9/pTy5xKcYdSTO4jgULDn0kS3QgFQ68O9oouVPSDfGhPGqyBtK/t
         s1x53uaxxiVHwYGaLoSPg4ZRrcAxJdnrKLkRIiNMgAaDOr3ekZ6GOX2JWE8n721BeJc0
         bKnKNdgd2P7ouW95NZPekHQaIYaoeLoJnIwoHhg6hi8gYOluOWmJ3vMGPgnWJMnyppgw
         mOZpLLgzrdV1Yn213xCgdn6CtR/7I1GiyinI6EWoR/GgCQSLtIWI9wSG++l6V6XaYFDf
         fF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686270369; x=1688862369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsLHpUV3U4RHcYmttv82/JvsSyFIcyIPeIQmZazPerg=;
        b=cOdvQkH4rbHr7hd7lWWnUgrOoQycWYLrPeawwpr9DFrHMWtY++BGOa0ta2wFIqb4DM
         SzT5LmNPaJ1VIyQE8tiu+DqFw9NIkZRDrdyYG4mQ+dVqIcBog4jNIleDARgAPBho7zvr
         SUpgaEn54jo4Vuuo51FwGpiDapuraPw+J1FI/aVkdSVYUo4G+X4TqmPBFW2kgINKcpwL
         j1C+RbGwcOeBXV4JlOUF7DkWzMjr8KvwJ/0GF62NSeLMO6kLl7HAO4B2aefic2wL+ZyR
         ybJklqLdhq0Udq94gh4k+dj7n9pbdtPL4LgAm1VDNAJYPdulKxqS/o9BYgtVOI3NVslQ
         EndQ==
X-Gm-Message-State: AC+VfDyhW+ZLiLqMsSGnm1gMqGeo1tdzMnJk38NGlZ8oNLH0KvABtRBh
        06LYILpCyJYO6v2JUK8GfKM=
X-Google-Smtp-Source: ACHHUZ5RHs5idAHmUIW80YZUdFMTvAyPG7GtZS73qmDLkqkEZVWKhZn3UsojLdEcAAL5NpXAKUMBew==
X-Received: by 2002:a05:6a21:6d91:b0:10d:3ff2:452b with SMTP id wl17-20020a056a216d9100b0010d3ff2452bmr5743417pzb.18.1686270369049;
        Thu, 08 Jun 2023 17:26:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s64-20020a635e43000000b0053efc8ac7e9sm1771643pgb.29.2023.06.08.17.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 17:26:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 8 Jun 2023 17:26:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 4.14 00/61] 4.14.317-rc1 review
Message-ID: <2ec644ea-e58e-44da-9bc8-25cf9a942714@roeck-us.net>
References: <20230607200835.310274198@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607200835.310274198@linuxfoundation.org>
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

On Wed, Jun 07, 2023 at 10:15:14PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.317 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 168 pass: 167 fail: 1
Failed builds:
	x86_64:tools/perf
Qemu test results:
	total: 430 pass: 430 fail: 0

I don't know what causes the perf build failure; there has been no change.
I suspect it is because I recently switched from Ubuntu 20.04 to 22.04.
I don't think it is worth bothering; I'll just stop build testing perf on
that branch.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
