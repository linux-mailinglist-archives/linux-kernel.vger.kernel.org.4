Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5895FAAB2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJKCoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJKCn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:43:59 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB196F560
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:43:58 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id t25so686745qkm.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6i9xvvSsQD2yTk04TmeVes3fjoEAF2ePWkZcQJA7uzk=;
        b=dIrbNcBbr0Ci+kGmNJtzhtRw+Q7XzS0paYgTElSH1b2OKEJFR7JVoYfGS/qff0OxAd
         MtJS8mnVUAi7cJX38b3VgKU7zP3nyQJQcRNdIrElAscjzb+h27xLS6EjvyT7buc7wo/C
         XCeI6FkWGef0pC/QfSlVC8kz/zni1yF0O9wFcu6w7O5S7y1nXELL6uoon0fUcoEUfO17
         RWhaojYvoSE5mDpNRGIcLhAxQBjQQPLfk1eol5GDzjLWXGFIEnHO8Jci4g5+gvybXaXD
         i0Zg0AjzdfJ6O/Fs1f4wyX5wkO6CbRxnLkZzIPl6EM2SX2334q9+j3BZJFzydS9CSh3u
         Xqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6i9xvvSsQD2yTk04TmeVes3fjoEAF2ePWkZcQJA7uzk=;
        b=nl3E5ry7AIGaVDefYAUmzVZD8EvhXXguNBNu8zgGcC9RBoaskBMZphF6zt1QWBrxgl
         4+4/Vl4GJnGwaMNZXa23Exo35559XDMh4SCgeJZBkLD82SlRH7/NPMtMqFb/bJzpIDdi
         zOB09f9YhaWGR+LY2XSFRPzAcv8A1NQdcvvga+sqRIBHLnz2raApE61demb9pRsk5VHA
         18g84sDNoFIg/yWR8/u+SW7PQNosvPNmgon9Qin1TryNnwV+MyTGV6CGQ52rjT1Ku38E
         rMw+linA0P8HMgcANQo6DxZNPeOVnTGIINJkS8z6Le5yj5GVkvzcqpaLliLWX2rWHP+f
         F8oQ==
X-Gm-Message-State: ACrzQf3v23shMcU4vnxz6JVs4mTAvPVc27RQDRZSlJQvq8pqPelAAQqr
        H83bW9UYckoiqat/3WKvopWecxjxhu3Ng68Wkb3hAQ==
X-Google-Smtp-Source: AMsMyM4XbgUeYhAK9x9eOFGVHGizsE2BCVNROCrpdXY5W/HQgkJoScfEge9JbEMWPhJ7Q/RyyLnDqw==
X-Received: by 2002:a05:620a:4108:b0:6cf:8490:fa77 with SMTP id j8-20020a05620a410800b006cf8490fa77mr15437302qko.734.1665456237350;
        Mon, 10 Oct 2022 19:43:57 -0700 (PDT)
Received: from sladewatkins.net (pool-108-4-135-94.albyny.fios.verizon.net. [108.4.135.94])
        by smtp.gmail.com with ESMTPSA id bp9-20020a05622a1b8900b00399d5d564b7sm4339810qtb.56.2022.10.10.19.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 19:43:56 -0700 (PDT)
Date:   Mon, 10 Oct 2022 22:43:54 -0400
From:   Slade Watkins <srw@sladewatkins.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com
Subject: Re: [PATCH 6.0 00/17] 6.0.1-rc1 review
Message-ID: <Y0TYagQVWLuGl0yz@sladewatkins.net>
References: <20221010070330.159911806@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010070330.159911806@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 09:04:23AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.1 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Oct 2022 07:03:19 +0000.
> Anything received after that time might be too late.

6.0.1-rc1 compiled and booted on my x86_64 test system. No errors or regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

Thanks,
-srw
