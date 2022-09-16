Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BAF5BAF87
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiIPOnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiIPOm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:42:58 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6698358500
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:42:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so1833564pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=CczDj0L6fyErXarjYUw/nJButDiDyt2jg/VsMlHD9x0=;
        b=OulnIc0PtMHK6HBr/Ps6pXumK5u3z46zD9qTpwgCt3YZ9WlxymyQYofzW2uXiYqD68
         l+1dCUz9ozdNUjkvCBpAKBX7kXamXafBqAitnxJWe/mgSPrKxR+LqZz1ASr2cVF+MT0i
         FqQW0UwdPP0m9XW+ODPsEEuMnSXwGDAiQYCCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CczDj0L6fyErXarjYUw/nJButDiDyt2jg/VsMlHD9x0=;
        b=6hQq7wbBr5tn7c4Vvuo8Pu3TlLFAlRXBdrmGy2FHDotMfsy+ZBFfiFYs9l+IWy9KKz
         aaeDTrMvdlqrfv0pL1GPGciCZtdsdY8KbmqLPAi/BiLadFHn7xwHbQqQZp1koNyRiJYy
         +cn5ZmIaJiOs8yAoBLrQp08KLdyntygLkdapvMUEAs+Kvo4c2A4MXyKN79/IKmCTACnH
         EjZM1rZE/BniwG4RBrETxSVXSDZ8NmV+EVFthbpkruXcZuc8GPDlgU+iRRqi8FNsfSwJ
         lvBMAc8X9Fbe4Qiz6shH7LfEiaha5aWVlzPgQSZLY/kp2sF0wjwdg2MgUAYIYxhYZF1O
         kbNg==
X-Gm-Message-State: ACrzQf1/R4bNixFFOplqKVVys+ioBrI/l+0dWVYyPpSwe/dfZNraNxf6
        BhWskbixlsBQK37PKfPFnhD8KKP7yXbiSD3/
X-Google-Smtp-Source: AMsMyM6fN+pgEnc/ncnyOHdVfzsAk03A4QioD6WtmLqIzn6JzDwi9BxnF+gf8QmMz6pDubaM926hUw==
X-Received: by 2002:a17:902:b693:b0:178:5fa6:4b3 with SMTP id c19-20020a170902b69300b001785fa604b3mr170800pls.63.1663339376925;
        Fri, 16 Sep 2022 07:42:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m17-20020a637d51000000b0042ff6b0cf4dsm13491251pgn.58.2022.09.16.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 07:42:56 -0700 (PDT)
Date:   Fri, 16 Sep 2022 07:42:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] powerpc/xmon: Fix -Wswitch-unreachable warning in
 bpt_cmds
Message-ID: <202209160742.81BE54E@keescook>
References: <YySE6FHiOcbWWR+9@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YySE6FHiOcbWWR+9@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 03:15:04PM +0100, Gustavo A. R. Silva wrote:
> When building with automatic stack variable initialization, GCC 12
> complains about variables defined outside of switch case statements.
> Move the variable into the case that uses it, which silences the warning:
> 
> arch/powerpc/xmon/xmon.c: In function ‘bpt_cmds’:
> arch/powerpc/xmon/xmon.c:1529:13: warning: statement will never be executed [-Wswitch-unreachable]
>  1529 |         int mode;
>       |             ^~~~
> 
> Fixes: 09b6c1129f89 ("powerpc/xmon: Fix compile error with PPC_8xx=y")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
