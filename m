Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAEF74893A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjGEQ2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjGEQ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:28:33 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F0F1713;
        Wed,  5 Jul 2023 09:28:32 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-57023c9be80so79446527b3.3;
        Wed, 05 Jul 2023 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688574512; x=1691166512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8pDRtkd3JT3S574w5/FXocHz4F6TT7I/bGyhLdaQUw=;
        b=R3AFoG50WHNT0g9ebP9pViGu3d3OjscDZ4YrnLRaAqUtpXk42R/hs1J6NLuOt67l+T
         fclQ8jTxb9lrAa9U10eImZbZYZy4wu/8KacId+37+gjY99hghC4T7eJYKZnyZHCFtxVZ
         fk1Pwjf+pO4PFXwbESK0rhhMXz5TCJBcMRRZo5oCwKju9GYBAxgeZeDKKIDTxtgGevyR
         N0Fz9Jayl9ceSX/XPS6fKnwAh7iJyuqYIC2Y0JM5LA0StnJZcoUvEdfOhHhwpows12Kp
         73d364d+Xx6rxr+E0b2Kqj9AV8DL9kCzCZm9Wm9PUVCZNb84lDzo4IBElZ6u3au1iQsj
         ZqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688574512; x=1691166512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8pDRtkd3JT3S574w5/FXocHz4F6TT7I/bGyhLdaQUw=;
        b=T/TIHput+LvkrZb6HHO6un+7i6hKOrW0RzyPFm4YaiYoZaJSz9XSO/X+NRJ1+CqIAM
         GO8WPTfyBb+bNc7yak7oZf1cs7jfzSOPQdVE5RBTzjJrngOGt63RwSA3mSiu/FyPedUU
         GPBvx35Mc0zT4evBdrC8sLeOll9v3HciRJxdvptVI9ZoJ2c/Ex2IWVJZl12K1T3dM+sY
         IV2mQLY6xdS9n9EI9QtG+Ot/KZW7Emw7TR3MVOpfOHqUh+j2kHGV0b5fQshQIW+8BDtC
         eMvbl9R+t8rnP8Gm0cJHi9XndcosnxIKPlZkOWUQ+aAY2lvZCsQjRTEmwA3hb0N5KL9m
         FURw==
X-Gm-Message-State: ABy/qLZMxNfQsCtuxAO7poCyfbgeeGOc0tiSF4lJJ1GrzIvHQ9PKtVdS
        XfwaWNFHLmkbRC+bqn5OZxs=
X-Google-Smtp-Source: APBJJlH7aD7KQvhlGlrFzCnWuSOlcqeoprHc8559PyVECNaejWnhz6y1MqUAj7XSxt7o+5u+uXEqgw==
X-Received: by 2002:a81:838f:0:b0:579:dfac:f507 with SMTP id t137-20020a81838f000000b00579dfacf507mr11634636ywf.34.1688574511825;
        Wed, 05 Jul 2023 09:28:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v78-20020a814851000000b005771d1c7756sm3904604ywa.51.2023.07.05.09.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 09:28:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 5 Jul 2023 09:28:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/13] 6.1.38-rc2 review
Message-ID: <519b0b43-895b-4735-aba2-1ff660ff6c11@roeck-us.net>
References: <20230704084611.071971014@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704084611.071971014@linuxfoundation.org>
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

On Tue, Jul 04, 2023 at 09:48:32AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.38 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 519 pass: 519 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
