Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F9C638905
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiKYLpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKYLo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:44:59 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4DF19001
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:44:58 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v8so6056686edi.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ganGoGk0dGLWUVZJZmO5N8MpSnIzwLlxlJWd5xpG83Q=;
        b=RclqeXPCsvXV295FMJA2FxIFmH1hIIdtE83WJi1sS2G+TBtQqDyYZu42qNcLM3L6v1
         60gjZ9vN9VAt/7rkJkryeuBmRONyL1OJLG4o3NnUlcXE++uqtjTZ+dkgwPVyxTE/YO2K
         RiqNzcS3hLhu/tJeZB7zHbhLzznr/3DQxfMLz4LThA1Bp3HTUe9NpL7v0yrgjfL/qiIe
         Kt1dqqWBm4rvfIVaUPVyjsWq4Ui/4Vmzh863hv163sDvJH3wjCtHaB99VL0dj/PHkLDl
         O9Quf7aao/efSpjhi/xnajZL6cbZQdkZI5EqlIUHkORpad55O/fpRIZGQojRIEoDvYwj
         5xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ganGoGk0dGLWUVZJZmO5N8MpSnIzwLlxlJWd5xpG83Q=;
        b=am9LrX8Wk/wsyWpOatShq8zMK0Ts/1WKMauL9wtaRwzTgwlwR/fMgTtfO/DliwVw7u
         rxWuXL/ln1KyOaKBB14OZRzOayuqRU+/6bomQUJ4PT8Ee6otLT4zoIf0YmXLq4EiMDfh
         qGaY7qODXZhu8JWAUKpGIv0Y78r26wwkyXP2K7KCS1YSyZlvt0uy4yUYJvAU2oGfWq9z
         3BDAgZffGbqKLfEwt9KmXCdzSadc+5qgLh750sLYUUaLKbz42jQNFmkFPIjW0OeQv9dC
         jzDq2tNIVhxgHTWLEaZQsosA0HbDe2pINnKTz5ijz7tT8DcfMKaPpW1LqWCvXiLXQRmQ
         xY4A==
X-Gm-Message-State: ANoB5pktjVH2pxoNhdWZ0NcR0JN5H2/o9tN4ifcS02tREQc59/hqmWP2
        3JM9+Lj2WEfh7PZZbj1b/tHo3A==
X-Google-Smtp-Source: AA0mqf7SeBJN7wr1Q4tACLDGo74k4BsLhAglgzt2jja6Yg+ow1nUgTWXD1+XxUrNqU9Yf/KfD80AVw==
X-Received: by 2002:a05:6402:2318:b0:469:10b2:df98 with SMTP id l24-20020a056402231800b0046910b2df98mr30800385eda.115.1669376696729;
        Fri, 25 Nov 2022 03:44:56 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id kz1-20020a17090777c100b0078de26f66b9sm1467428ejc.114.2022.11.25.03.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:44:56 -0800 (PST)
Date:   Fri, 25 Nov 2022 12:44:54 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 1/7] riscv: asm: alternative-macros: Introduce
 ALTERNATIVE_3() macro
Message-ID: <20221125114454.yfh2mtctbi3nkud7@kamzik>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y3/LgZkR1hkblJ8D@spud>
 <4801607.MHq7AAxBmi@diego>
 <Y3/OlKI1jyi0eoCJ@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3/OlKI1jyi0eoCJ@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 08:05:40PM +0000, Conor Dooley wrote:
> On Thu, Nov 24, 2022 at 08:58:41PM +0100, Heiko Stübner wrote:
> > Am Donnerstag, 24. November 2022, 20:52:33 CET schrieb Conor Dooley:
> > > On Thu, Nov 24, 2022 at 05:22:01PM +0000, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > 
> > > > Introduce ALTERNATIVE_3() macro.
> > > 
> > > Bit perfunctory I think! There's a lovely comment down below that would
> > > make for a better commit message if you were to yoink it.
> > > Content looks about what I'd expect to see though.
> > 
> > Also both the comment on the original ALTERNATIVE_2 and the new ALTERNATIVE_3
> > should probably be merged into a single comment explaining this once for all
> > ALTERNATIVE_x variants.
> > 
> > Especially with the dma stuff, I'm pretty sure we'll get at least an ALTERNATIVE_4
> > if not even more ;-) . So we defnitly don't want to repeat this multiple times.
> 
> Oh I can promise you that there'll be a #4 ;)

I took a stab[*] at cleaning up alternative-macros.h a bit in order to
prepare for _3, _4, ..., _42. The idea was to try and find a way to
reduce as much duplication as possible, both in the current code and
in the new macros.

[*] https://lore.kernel.org/all/20221125113959.35328-1-ajones@ventanamicro.com/

Thanks,
drew
