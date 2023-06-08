Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6389728784
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjFHSyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFHSyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:54:02 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0443270F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 11:54:00 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-650c89c7e4fso939482b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686250440; x=1688842440;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fJEHFi97DlbjmCUi9KJ74Rwm7pWeUSTdC5PB7cfCM4=;
        b=EoG2H7AxXXooNLAjrSxKqHnNGdrPa6YAxcOyK9Mn0Xm4mKDG8T+aHYaB0PZrmUkQGC
         t3Z5SbYWDYLEVkfJnPmL6qGXXgU2TNc2S6DitaYcaOn5zc1DuWGhvV5cmBj2I90aVPPE
         K27vKR1T2dJ/FR3aiiS4zF3FzxcpW7s2yig8vdN44eseE70dCfL8h6pd7Na5rUTp1EbC
         5v6aP8SOb2N27R166/EO0ntvoSVHINTwoFprmmXubwUen0+juEa36jhngnANtjSkf7YX
         RUXq7ZhO/yRTpRctQUIYHovnHXbBah7t7KKuO//zOlfCrVZZeiVtsl9vz8tlmtgpbfyl
         EUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686250440; x=1688842440;
        h=to:from:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fJEHFi97DlbjmCUi9KJ74Rwm7pWeUSTdC5PB7cfCM4=;
        b=h9XVlKGnQFccVrEpDBZjrQ6pb5CdsLh+7FrF/kPtWD4+YSgJb6ak2caeGiQtAJPPau
         W56j9R52tO5BGusuS68K0C59F5Vn5xwPEGxVKhihaX37KnRtlE1FV6COnweSrhPoATcr
         mipQHB23IFjltTzmvQqFTD7Q8GIK16iJNdb5fJ98Vb+5LsC8B98yq4vYPeJ7mwD7zV3t
         SGcQQLL/b4wuDa6z3E9MfA6086j4S9zXtH/QtOQWHGPeDek5SLYM+VRYcMXKW4m6BdEy
         AXKah3KkO97JmamD67WjMkZ9qs2uD2ZFGt+WaaFz2QApRR9KTaXEapbyEneueQft8p22
         yvAQ==
X-Gm-Message-State: AC+VfDyo6+aNNPE6Tvh9EbjwvVY4XJMYlpvD4G109JUA1XIM+wo3mO8j
        Ce+LEYTwAg/OVAGToToAoxKGYw==
X-Google-Smtp-Source: ACHHUZ6qOJ2APMDbRsU8BHeHOmULCkvsbeS3GA8+hyX5g4Fxgp48D1t8zMsAuTJKR14dbFoJ3Jgz7Q==
X-Received: by 2002:a05:6a20:4429:b0:111:97f:6d9d with SMTP id ce41-20020a056a20442900b00111097f6d9dmr9156712pzb.62.1686250440273;
        Thu, 08 Jun 2023 11:54:00 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id c14-20020aa7880e000000b0063d46ec5777sm1394121pfo.158.2023.06.08.11.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 11:53:59 -0700 (PDT)
In-Reply-To: <20230504072910.3742842-1-ruanjinjie@huawei.com>
References: <20230504072910.3742842-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH v3] riscv: fix kprobe __user string arg print fault
 issue
Message-Id: <168625043497.19063.14436590324361967786.b4-ty@rivosinc.com>
Date:   Thu, 08 Jun 2023 11:53:54 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ruan Jinjie <ruanjinjie@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 04 May 2023 15:29:10 +0800, Ruan Jinjie wrote:
> On riscv qemu platform, when add kprobe event on do_sys_open() to show
> filename string arg, it just print fault as follow:
> 
> echo 'p:myprobe do_sys_open dfd=$arg1 filename=+0($arg2):string flags=$arg3
> mode=$arg4' > kprobe_events
> 
> bash-166     [000] ...1.   360.195367: myprobe: (do_sys_open+0x0/0x84)
> dfd=0xffffffffffffff9c filename=(fault) flags=0x8241 mode=0x1b6
> 
> [...]

Applied, thanks!

[1/1] riscv: fix kprobe __user string arg print fault issue
      https://git.kernel.org/palmer/c/99a670b2069c

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

