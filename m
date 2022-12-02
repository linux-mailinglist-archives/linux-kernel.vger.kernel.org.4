Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2A2640C0F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbiLBRWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiLBRWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:22:13 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A845FEC80D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:22:03 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id k79so5485783pfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nAc9Ui5FDUiek1r3Ck1fS7WTbV+aLgSqwss523muYTk=;
        b=Hesf4Q5brm36uJX3MEKcbGHrBL3g6VJA4t6P1O4r21kyQ+SXDRhZoqBvQAszLuC4az
         1AyHP6c6OrwskWd44Vpqp8dBDzowKxdJHuoV4a6EviwOXax84doqhj+TH6WQjMSNjDfJ
         4E0wk3E2LEXYUvYjnhKN9yHVCPd9TT3Bv6OkbES3PPIHEPhHD2GAR2Ituic7qtcNCPBv
         wAMaRX33IGTJSxTTc9sDJv/frwj7Y91TR1GyRMjhbFONoRofpSJDgnn/hIcmXntNOrx0
         w/N1FJlZ5tm9vbPmXYVg/u8o6iNfmatY+lN0LgpprUnqJpuQJkhUOtXICTGDU9dL1R7M
         Mc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAc9Ui5FDUiek1r3Ck1fS7WTbV+aLgSqwss523muYTk=;
        b=h+R9CtLPVawZzwYTTm3pajaL2ujRyXZHo1jyc5YyjNyymNHh2tl2a+sIlcyGUAj8+W
         8XzuVCMefxWEbj8rF2TLB+pV/fWVIGKErspx7ZYR7e38XKPW6n+yBUD11k6LWXaACObw
         q6sOZ6Z0JRNdSg3hlxUdK6vqEMC8Fo6OcVlxcLtWiE8VRbMwDAdSH4f1/gjtuUJSASHl
         +9xuk9NOarUjs1uTgnIvE+b5UUp2MPHrN/GrKRoXZmECD4tC0OYuj9qQEuFvzIJ1M4nA
         D0v8TTDzFrPZRi6z+9KA8ObMyZA4ik/YYp6rJzuDpe4yb0cLpZ/KuNgDt/S4xCIqF5d1
         XJeg==
X-Gm-Message-State: ANoB5pmxe056aVCBeY/oPA6mqIwjsCIB7DP/s+MhqXWo22SHlJ4LLK5N
        sfj0PDdlDcC6vEhGP+CDSQeiYQ==
X-Google-Smtp-Source: AA0mqf5m4zXkdiVg7X1oUF/in3uAi1adGUciP0lbBTNgQCH9BYJcAzGmMa6mLTtbviUw1JXWglFLJA==
X-Received: by 2002:a05:6a00:414e:b0:575:7968:f546 with SMTP id bv14-20020a056a00414e00b005757968f546mr18387843pfb.30.1670001723093;
        Fri, 02 Dec 2022 09:22:03 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l4-20020a17090a384400b00212c27abcaesm6898955pjf.17.2022.12.02.09.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:22:02 -0800 (PST)
Date:   Fri, 2 Dec 2022 17:21:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] KVM: selftests: Fix spelling mistake
 "probabalistic" -> "probabilistic"
Message-ID: <Y4o0Nq4SKGZgDOxi@google.com>
References: <20221201091354.1613652-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201091354.1613652-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022, Colin Ian King wrote:
> There is a spelling mistake in some help text. Fix it.

I assume you have a script/tool of some form to do spell checking?  If so, can
you point me at it?  I'd love to incorporate something like that into my workflow.

Thanks!

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
