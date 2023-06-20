Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B070737518
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjFTTa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjFTTay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:30:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573BF1704
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:30:53 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b55643507dso25129475ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687289453; x=1689881453;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSlhmSL2kU9Xbi63wct+B70WsJdLHYOGLNkscGggduE=;
        b=flNLHVIr+QyF5Nx1TtqrBWSHkg9WFJWdlhg0ySaMqu1C8VEP09aNmL/u3czZfQJjPF
         YQfAhACPaswaYkR2llW4D0KiaDZPZfD1d6zybjKZPkybBIEvBku3+M6FfxJeqw2P6GaD
         FM9pdZdmkSfSyBJ0bclyVG4yh4R+4ev6VORg8zjrGTrr9+KPZOcFhigYnb0t+xwUWlZT
         LIgYvj/J7Af9yHevImDGlg/WBUPTaJ/G83zve8hzr4XzOPzugGvIlg1qpMDkv7ZSGHK7
         IrpzjGBqD68/DUOgWPzLK+Ek5N8EdBvIQry6W8QZJStsObyuTq9k+QRC0v5zMGXewp1s
         AlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687289453; x=1689881453;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSlhmSL2kU9Xbi63wct+B70WsJdLHYOGLNkscGggduE=;
        b=SJ9KOxATiznYfBB2BkHRrDEYPNHH5CqSemZpOuLwyImnlvIyvY2tH2RgjxHGBNJA5q
         fGDkLUassvh3Zc/1i3xZ3ayMHhG6UIkr0Rncv5021w7dZJ+R+QPg5Cu0df2IoVjwBXWU
         jRxzamQWdNjYIfFSRzVX15DgJih/pFIae9ENf+rWS3f2hnbSQZlkCMfi3L4Uc0Sm3/cA
         ttr1Zv65WRdQToqYPr8KpCsekpx2i/uvPVdDGfWhgFVuhnGaaMY2blf4LojI1xTRtbA7
         bz1F4Uj7xTlPICORz/iNwZEX6Xvx/x4GXq6q74cG+DZ3Mak1NnLpoa7wuvPniU/YrAZS
         E+jA==
X-Gm-Message-State: AC+VfDzv0Qu+1exXQiy5h8wwBfXRvq57Yv5BNEoNytlG/3mEqzpa6rGu
        eFzHrNW0c0CzgDY1pRfyUrDeWw==
X-Google-Smtp-Source: ACHHUZ6xHwg6uQ16euXDtpmFrxepvcbcTpjPEhdF6d8QU10aa+wOO+jkalRWbMhkjV6A1/gDwKjOtQ==
X-Received: by 2002:a17:903:2284:b0:1b6:66f1:35b3 with SMTP id b4-20020a170903228400b001b666f135b3mr6878161plh.50.1687289452723;
        Tue, 20 Jun 2023 12:30:52 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id im16-20020a170902bb1000b001ae59169f05sm1989478plb.182.2023.06.20.12.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:30:52 -0700 (PDT)
In-Reply-To: <1682214146-3756-1-git-send-email-yangtiezhu@loongson.cn>
References: <1682214146-3756-1-git-send-email-yangtiezhu@loongson.cn>
Subject: Re: [PATCH] riscv: uprobes: Restore thread.bad_cause
Message-Id: <168728927546.19726.7304186466225291370.b4-ty@rivosinc.com>
Date:   Tue, 20 Jun 2023 12:27:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Apr 2023 09:42:26 +0800, Tiezhu Yang wrote:
> thread.bad_cause is saved in arch_uprobe_pre_xol(), it should be restored
> in arch_uprobe_{post,abort}_xol() accordingly, otherwise the save operation
> is meaningless, this change is similar with x86 and powerpc.
> 
> 

Applied, thanks!

[1/1] riscv: uprobes: Restore thread.bad_cause
      https://git.kernel.org/palmer/c/58b1294dd1d6

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

