Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167BA6FE435
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjEJSub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjEJSuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:50:25 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB692114
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 11:50:24 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-643a1656b79so5188679b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 11:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1683744624; x=1686336624;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F76UK+CxAhg4hqyTNocO7OCTW+IWsVT57luco8VSSm8=;
        b=3EYfHC/B/4fOE5EWwcqj9yAlBmPc1JO7qTwY9urGNzT+EbObCV/IHCD+Ta1EAeOdTy
         FgCx55rYjxcmo/xLfofTSK/D9D16MeqSF5NghXCpvhggVu6TX0wYMT19wycl54laJ+HO
         QUEtz7559EQmUyeY0WtLvvLwvtRjxaFkIj9wdT3j+MVEF1lqE8/Q3pU7i1tyIYeKnVbT
         0A0RxC+/gjLE4r/uRtzjS+KmLAhSzQjj86UZZnmOjSim4PqMAyQGKYQ8LYl3i/t1LixR
         1K79zcvG8L/tvdhcfXTBuNFHrgoyZaFLATCEVQBmK4KepL89vILcAptuuVnrAhKfjTaT
         4ZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683744624; x=1686336624;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F76UK+CxAhg4hqyTNocO7OCTW+IWsVT57luco8VSSm8=;
        b=LwM8dMZ9Pi8K+yX2k1GVNdNJWI6E05U7L7wQLW92ZsOlPlDaQnZAeWNL7NWuoYLk9I
         SEQhYxpE9yRiVtUJS2aPK66XXJ0ybGkwETd/f2mTw7X5fNfSzz8bkIE6rCrbPML4wx9h
         mkb6W6WdYo7HarBg2yKSKuT+tkEH4LSlc3usIBc/te/6mfjhG8qFL52eUkEQWg6YguLc
         BrEsHQIKArYgpT+tqyJs9e6IqbDeues0Wx2Ein4jlJE8V4oV1bKX2ZL2fAhk++Om2ewb
         Ira55z2uXxpy3qJnXo9hfaerkj4PgErtZ4SvCZezpTphSS1hSleerE5rjyLmK5gKsYZz
         5AZA==
X-Gm-Message-State: AC+VfDxGYMsJqK1/DWryac9DvM5B2+KSAAOpPXoGbR+tA5FDAsw89Bi0
        D5J3ta0AY90fQyU915mJjXnSoYa/kPPrMjbngaI=
X-Google-Smtp-Source: ACHHUZ4ArfIWAEgW34cKol+jrrXEu44mmiUN+5Nlg6BKulKz67xIwfTUPl7C6F3SfhSI3TlXQQtGTw==
X-Received: by 2002:a05:6a20:160e:b0:101:1008:6b84 with SMTP id l14-20020a056a20160e00b0010110086b84mr11772796pzj.8.1683744624180;
        Wed, 10 May 2023 11:50:24 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id mh16-20020a17090b4ad000b00250c753b889sm2290138pjb.23.2023.05.10.11.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 11:50:23 -0700 (PDT)
In-Reply-To: <20230504120759.18730-1-alexghiti@rivosinc.com>
References: <20230504120759.18730-1-alexghiti@rivosinc.com>
Subject: Re: [PATCH -fixes] riscv: Fix orphan section warnings caused by
 kernel/pi
Message-Id: <168374440137.14554.1070324077162510128.b4-ty@rivosinc.com>
Date:   Wed, 10 May 2023 11:46:41 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     kernel test robot <lkp@intel.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
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


On Thu, 04 May 2023 14:07:59 +0200, Alexandre Ghiti wrote:
> kernel/pi gives rise to a lot of new sections that end up orphans: the
> first attempt to fix that tried to enumerate them all in the linker
> script, but kernel test robot with a random config keeps finding more of
> them.
> 
> So prefix all those sections with .init.pi instead of only .init in
> order to be able to easily catch them all in the linker script.
> 
> [...]

Applied, thanks!

[1/1] riscv: Fix orphan section warnings caused by kernel/pi
      https://git.kernel.org/palmer/c/3b90b09af5be

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

