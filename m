Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB7A61061F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbiJ0XHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbiJ0XH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:07:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9838F97E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:07:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id e4so3267638pfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGIOOj3+qzuziQHt4I3vJ0yhwP9i2B2Blb/XTHKGMxA=;
        b=DQ12Roa/JCXk48lRfZQvcdCR5DKamBLnfsA/y+WP0VhsBcphWICeeOvOJAHZFSBoUn
         gl0Tsxd+qmgZ90G5FiKpBF4SELi4PtDFKah+kk9F201OOfc3lFcfGZmV63Gvr+q6s6+m
         AbIHcTHOuBjGXnUCqQzepYO8FPcpxVB1PNMgbybic+rmtKj4iTN1N0z2t2p9u1JbLb2E
         WJpGxg1w1wg9Ih0R1E0wlkSdOJM2JZ+6tENLD8t+jhFBqKJNq/vvTzZErfS9S+becMJW
         ob4mFbQrFaNrbt8NugT98wmIV5d/LCfe7Wi//gcNJBm2/Ye8qT9eQholmoulgMFnGk4s
         rZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGIOOj3+qzuziQHt4I3vJ0yhwP9i2B2Blb/XTHKGMxA=;
        b=Z+LcqbmqviYGErSQQ6Evkf6NtJl2HEIxGQXT2xlJpjkhVkq6pJlVU7O4Mi1e96Fk3C
         3/Z2Vi8hkgneq44EDHy+QjhIvrevfU/Grd2ZNlPt5bVCYTWq+9T2+cBHZZywCfO2Z3DJ
         mrsLKwa4sy0e7KrS9sBpfVN48DO1lNyuRe6RMWq32UiHBLz4cm3S+7GVORPpt1fZXAWY
         nxgCQO7hBNOx4AgATzJiQ3eWNSXdBx43/sDrlsuv88Z2MLQo++eZtF29wP+eeO6n5Me+
         Ju2jyLAYIl9ujAryPkb1jpt1ZCyD6ccVHrWRATsTEVGge+FTI9Jb600mJKPqHQGNAZWm
         KobQ==
X-Gm-Message-State: ACrzQf00Edf/WvYRQg0ImXbz2PHANl4WHYEv35WkQX+9HvtWzEuL1b2s
        q4nfjWmkuWVxDyZ0KHSVvfa01A==
X-Google-Smtp-Source: AMsMyM4pGfab/Lu9otcgknoFf3QkCWBb4tRNWzqL/utHiVbszNKEX0k0wNujQ0wmYp9Ebm9yoeQFDQ==
X-Received: by 2002:aa7:88d4:0:b0:56c:ae9d:6fdf with SMTP id k20-20020aa788d4000000b0056cae9d6fdfmr3713215pff.41.1666912048006;
        Thu, 27 Oct 2022 16:07:28 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id w3-20020a63d743000000b0046f03254c9csm1542392pgi.23.2022.10.27.16.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 16:07:27 -0700 (PDT)
In-Reply-To: <20221018141200.1040-1-jszhang@kernel.org>
References: <20221018141200.1040-1-jszhang@kernel.org>
Subject: Re: [PATCH] riscv: remove special treatment for the link order of head.o
Message-Id: <166691074225.22464.6806069295219492474.b4-ty@rivosinc.com>
Date:   Thu, 27 Oct 2022 15:45:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-36ce3
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nicolas Schier <nicolas@fjasle.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 22:12:00 +0800, Jisheng Zhang wrote:
> arch/riscv/kernel/head.o does not need any special treatment - the only
> requirement is the ".head.text" section must be placed before the
> normal ".text" section.
> 
> The linker script does the right thing to do. The build system does
> not need to manipulate the link order of head.o.
> 
> [...]

Applied, thanks!

[1/1] riscv: remove special treatment for the link order of head.o
      https://git.kernel.org/palmer/c/2348e6bf4421

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
