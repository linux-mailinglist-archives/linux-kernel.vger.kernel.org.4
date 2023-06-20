Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCE3736A10
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjFTK5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjFTK52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:57:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD74F101;
        Tue, 20 Jun 2023 03:57:27 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3094910b150so4544366f8f.0;
        Tue, 20 Jun 2023 03:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687258646; x=1689850646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=12MHpXVfV5/4NMPgWQ0+SabaxFmiyGuGrPFVvOL1TDA=;
        b=N4W7GsufFgmP6oHtlt9Q1p8seFK+wS3lXJ9dyNPgdJUGjAzzp6AaPtChargp3nIhXE
         hkSoxyLoT8DK0oUX+iwKIJNQetG8CK9gx+0WuVcEkEkLVYQlidvOP82tcSYyFRi/as/B
         HBp/pLZLysaJBJm/b3zbRgK1cFBmJ1qhqEuxmKN1a0dbwQzEt2d9SKdx8MfZSqiKcrfb
         L6RBYAiv/RI+2L1mdZJKoaEDHh8SIwTYEOvwWket7x4IfzoyjdSC6IrTCJR3VNhhZC4p
         iW2pwd6qykK+IZVmtDE04umldg+eWbkDNTdlxVgbifwQEyJHhe9INA/WwXyj6YWWfbk2
         xqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687258646; x=1689850646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12MHpXVfV5/4NMPgWQ0+SabaxFmiyGuGrPFVvOL1TDA=;
        b=Sz+qTuDgd+edRE7LK2S95OQLuZYP3MEeXPZW4ljWOO62l7KZXPtXaToO9SYdgiioBR
         24Sq5EPmyHvuTAsx9eqRWzfrmxmG6ivzH3F8sDtfnQSKHKuWDUbj1eKGW3iCg5x7s0eR
         M6fsewFzXfePHNyXtcbhsxbdSYVe4h706/iVO9g7pQIQAeSq2O53fOHC4lz+hTLGS7de
         Nl9keBCdRWemUsvTZyvQLh/w6nx5s47b61aEYAP2aasfs4mmborNu9vyAAuDOYYeaKjg
         AZhcGiqmGxXWxDE9vWspaHpKGBdxIUTX1eq6TERN2S2QsOHEuV+pf4Y5SQaa3iQOtxW6
         /9cw==
X-Gm-Message-State: AC+VfDx0S+25riMYT7gxdNdU9uj1XNpGL7AaZ/Fk1WUIuZ3nJoJt4Z3l
        VNiMrCd5vh/f5DNKKroFGK4=
X-Google-Smtp-Source: ACHHUZ49J3mc1NBJrhjMDak0Nllb38q8xGqs3Yq3y4XRXRcxCJ3z7KE1nqBdaw1gUYYEI1AgxaYxAA==
X-Received: by 2002:a5d:453b:0:b0:311:1b8d:e565 with SMTP id j27-20020a5d453b000000b003111b8de565mr9229426wra.34.1687258646031;
        Tue, 20 Jun 2023 03:57:26 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id x5-20020adff645000000b0031276f8be22sm1701779wrp.97.2023.06.20.03.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 03:57:25 -0700 (PDT)
Date:   Tue, 20 Jun 2023 11:57:24 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 5.4 00/64] 5.4.248-rc1 review
Message-ID: <ZJGGFPe1KWMyC891@debian>
References: <20230619102132.808972458@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Jun 19, 2023 at 12:29:56PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.248 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 11.3.1 20230511):
mips: 65 configs -> 3 failures
arm: 106 configs -> no failure
arm64: 2 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Note:
mips db1xxx_defconfig, gpr_defconfig and mtx1_defconfig failed to build with:

arch/mips/alchemy/common/dbdma.c:33:10: fatal error: linux/dma-map-ops.h: No such file or directory
   33 | #include <linux/dma-map-ops.h> /* for dma_default_coherent */
      |          ^~~~~~~~~~~~~~~~~~~~~


Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]

[1]. https://openqa.qa.codethink.co.uk/tests/4066


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
