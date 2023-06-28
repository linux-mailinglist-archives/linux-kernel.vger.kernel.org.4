Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162677410E6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjF1Maf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjF1Mac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:30:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231EE2102
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:30:29 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so6233972e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 05:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687955427; x=1690547427;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8uELbaTBQBP7IMLX/PL59rLHYxkicVqZoxRVAK7TQmc=;
        b=VfNGdMyM7OeLVTTVyHyaXx9ZRvDc4b5asU+TytqUDH0ZZUXLREHvdAjjfWWfdor8+1
         Kryt9jxd/nT49bthEJz4d0P2z/23qTcPQ9lY73LIM5Kw3x1PSeun1wJSd1qVFjDzPqc5
         peVoDDhx8hDjTUetLhPzlRsH0g6qVrrTvAW/tVv5lbIeUsAg/ChJIinCvzsqAE+NNVFq
         tt+KyBvEwPMdSKrHQ2nO1phLqElLBDMJGLWRtkGZyqxHHGPn2M7S6IqUm0eGm6EYpMIo
         JioHaCc2v8kBMA6rBtP+PxbOwkGNP4W5mZ7NJjyuCGR36dQugRW9fTUzTGDvska2lE5i
         TgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687955427; x=1690547427;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uELbaTBQBP7IMLX/PL59rLHYxkicVqZoxRVAK7TQmc=;
        b=LS6RxZ6zNqr5lZIfj2zGQ0T+d9PknHg3+tAcDhwWHlZlJG2U37+TjsZLKhd7BJmbmS
         Qj0cRRDGNYD5xNof7RY/ql7bHb59ygdEwDA2XQKcbFhe+fGNtLQnMhl6m4AsVKHIY9Vp
         MSjGUva1xTMpUlK7IlqaF9y1GkOptyRW/T8hT6kseoCvsKIVAjMCm0CDVFAAe+HJca+h
         eHOGeKZ5QMbVSPcx2jH+xaHITk0SVfD1XuiHLM/UejykGnAd0BMjaXPys77dYSdGXH6F
         WT0Cea//uLfqGaLtTmDZgFbGnG00FUDpx+QRE+YF1ukGBgAiIhzBOa++ttSgsURmg1NE
         9BdA==
X-Gm-Message-State: AC+VfDwas4vmO/6tLZ6wxUGyTTsC0wYmb7vm7CoJis5mATHJ6rmDF4OX
        VO1dRifrmR+mrl6Z5YAPhqfc5g==
X-Google-Smtp-Source: ACHHUZ7J+EyKCOqib+T5i+o3hRIRjIvVeJQPeKuhzBfsHMiztjXy8t0h8uOeQBlu2M+7kF9i1t3xtg==
X-Received: by 2002:a05:6512:39c4:b0:4f9:5a0c:85b8 with SMTP id k4-20020a05651239c400b004f95a0c85b8mr13796411lfu.36.1687955427192;
        Wed, 28 Jun 2023 05:30:27 -0700 (PDT)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id c21-20020a7bc855000000b003f8fac0ad4bsm13566299wml.17.2023.06.28.05.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 05:30:26 -0700 (PDT)
Date:   Wed, 28 Jun 2023 14:30:24 +0200
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, Evan Green <evan@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>, linux@rivosinc.com,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Jiatai He <jiatai2021@iscas.ac.cn>
Subject: Re: [PATCH 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <ZJwn4HZ9KaB/q3Vt@vermeer>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
 <20230627143747.1599218-2-sameo@rivosinc.com>
 <CALs-HssMkVikspnEi-Ek2t=ABvFvgptAhsBjk1+aLuVjiP7P7w@mail.gmail.com>
 <20230627-debating-twelve-da2c1ed60948@spud>
 <ZJwE5wRVkoND3Z6P@vermeer>
 <20230628-unfeeling-tavern-edd4f58396fa@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628-unfeeling-tavern-edd4f58396fa@wendy>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 12:10:11PM +0100, Conor Dooley wrote:
> On Wed, Jun 28, 2023 at 12:01:11PM +0200, Samuel Ortiz wrote:
> > On Tue, Jun 27, 2023 at 07:48:15PM +0100, Conor Dooley wrote:
> > > On Tue, Jun 27, 2023 at 11:14:30AM -0700, Evan Green wrote:
> > > > On Tue, Jun 27, 2023 at 7:38 AM Samuel Ortiz <sameo@rivosinc.com> wrote:
> 
> > > > It would be nice to consolidate the ones together that search for a
> > > > single string and set multiple bits, though I don't have any super
> > > > elegant ideas for how off the top of my head.
> > > 
> > > I've got a refactor of this code in progress, dropping all of these
> > > copy-paste in place of a loop. It certainly looks more elegant than
> > > this, but it will fall over a bit for these "one string matches many
> > > extensions" cases. See here:
> > > https://patchwork.kernel.org/project/linux-riscv/patch/20230626-thieving-jockstrap-d35d20b535c5@wendy/
> > > My immediate thought is to add another element to riscv_isa_ext_data,
> > > that contains "parent" extensions to check for. Should be fairly doable,
> > > I'll whip something up on top of that...
> > 
> > Nice, and thanks for the review.
> 
> > Should I wait for your refactor to be merged before pushing this one?
> 
> I don't know. I think that you should continue on with your series here,
> and whichever goes in second gets rebased on top of the other.

Sounds good to me, thanks.

Cheers,
Samuel.


