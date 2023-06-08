Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87AE72822D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbjFHOFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbjFHOF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:05:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8302722
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 07:05:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2568befcf1dso504256a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 07:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686233126; x=1688825126;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pn+QJTHajWfG7d1v3e1LYOVtDbu7eUfKqZSk1uMhiJI=;
        b=qdcSAqjzQG9AgkHSgdnk0Q0Z+MkVX++FcEHQVf8BVaTmnCKgBIpAn90dZxbpBQwvx/
         w0RNl118wFkBM/N7KtDulHlMQvXUFeGrxPgbq5w9gh/et7LMN6EGej1blWrtEz2BKj7P
         DTjloCnC4fobsR2GdM10J9CZtzrhQtjmo+z3xMEk9avk35i0e0lxthbCuui4Nv2HZQX8
         1oy8hF4VG35B6a3K5+pYdkH3rTlAL33GYxkGZJQqkmKepZWsKGqv4NK4XDJQhUpRxaDc
         0Du19kaXGTQ9NrufuOvcs0BXYLWGTp+6yMogN58/deNR9BOhndXpKcgbTF9OzTmBomnX
         T6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686233126; x=1688825126;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pn+QJTHajWfG7d1v3e1LYOVtDbu7eUfKqZSk1uMhiJI=;
        b=cetNkCniWq0NN2HxEaQyXJPj+5MMWZ2wOM0o3eXNjzonNRD+KrU5UfcOli6BpLmuJ8
         JSkjQwX2XlA2pKx1t9eohsLt+Gm/Mx46Sl10DR6RE453vxF+bkYdMn10buW05jFKlsiU
         Wdoh/XasaZp4+M3J7T1QY6nw0hLj/Bwi+1OHzleqFnLfZoWD+eYuBVlLQeAiil1EzZRG
         7eZ78a2ph6j/MU/vrOd7YVIUhA8LHlcOutVQOMbJrxI/pnTdgXpMzF1di6yDnIRt4ppE
         VrKkH24nozrTLDrNMfj04GZ8+Ug31z/78mVnr8PrQVjvta2KqaiKUn+80/ujQPy1cH/R
         n5Jg==
X-Gm-Message-State: AC+VfDz0paOsol7U7aviSMX4mCb//Y0DPgpFdO5eHMHyq6li66QTq6Cy
        SIcvjfNEJKsghFUeylwMUw9auA==
X-Google-Smtp-Source: ACHHUZ5qj7JpWv3n5h049mcDRbvrnPWU2pxzum1X6mufnufFFDh/MhtDwjz8FcgngHxSziImKBqMBA==
X-Received: by 2002:a17:90a:190d:b0:259:43e1:c81e with SMTP id 13-20020a17090a190d00b0025943e1c81emr2668601pjg.12.1686233126458;
        Thu, 08 Jun 2023 07:05:26 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0024de39e8746sm3109142pjt.11.2023.06.08.07.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 07:05:24 -0700 (PDT)
In-Reply-To: <20230607125851.63370-1-alexghiti@rivosinc.com>
References: <20230607125851.63370-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH -fixes] riscv: Check the virtual alignment before
 choosing a map size
Message-Id: <168623309504.19530.15946291448306028872.b4-ty@rivosinc.com>
Date:   Thu, 08 Jun 2023 07:04:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     Song Shuai <songshuaishuai@tinylab.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Rob Herring <robh@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Jun 2023 14:58:51 +0200, Alexandre Ghiti wrote:
> We used to only check the alignment of the physical address to decide
> which mapping would fit for a certain region of the linear mapping, but
> it is not enough since the virtual address must also be aligned, so check
> that too.
> 
> 

Applied, thanks!

[1/1] riscv: Check the virtual alignment before choosing a map size
      https://git.kernel.org/palmer/c/49a0a3731596

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

