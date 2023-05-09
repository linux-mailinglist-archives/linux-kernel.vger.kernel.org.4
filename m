Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2E86FCC5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjEIRIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbjEIRHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:07:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4B859FE
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:05:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bcb4a81ceso11136353a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 10:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683651920; x=1686243920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KbLmm2hGnypwCCIbVWxOS6zbqY1vqAPFYGOOnhtGEc=;
        b=bbqxKfE6Z8EGbjdYkk6sFhSd05uiH5tJeImHDdCystpjFaUROCtvWIh79WfuTmrytB
         0Ctl2dkqGb8FVScb5RZHvTSpPdu8Uyknt7ihFYN6OP1rX7YV/fPX90P5avuRh73kF2mS
         MD9YtNOSS4MgyCsFe6Ujzvdx+MjUtN9C1yYXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651920; x=1686243920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KbLmm2hGnypwCCIbVWxOS6zbqY1vqAPFYGOOnhtGEc=;
        b=Sqr8HKi0377CAtntIgVVREwTMDxznUADLhUw80ENs17mev6HI1Ah5sNSCz/AkAzhdf
         Hr8gPtzy0ez9BPoRhtv+TEXV7qH7Bj98X4dkIyFOZ0jO9P7+yaVd8p7S84rB73doNx7V
         lFpvmptEUXVVb38pw5sejfkU+1yH8l23N3jiGTotmRJeO4CEKJ3gJsNA/AizrMBX4n48
         8LCdcDBVi6BYgp2y5ARVhjjP3nRrUoQ/zjhVcwOXmprqw1oNjp7HcsxEoYKj+jXysvU8
         VA3c/rlNz/lXbTxiRYvunMJmk/XBoikzdbQsrFXqqsd+nG6BmnUmrtrNFirtrEgbMshD
         yPCw==
X-Gm-Message-State: AC+VfDxZIZramMi+7UA5Kvb7Ws4IA5DIEjUhxKpHrGztf0MaIgE1FTDb
        FRwO+GJrBhXZn9v7XO4o7msE26BhL7s1TgNliXLfKQ==
X-Google-Smtp-Source: ACHHUZ62NVCIqWM+eeVYiHw1YopN/84NI4MP5NJrIrH+hG0nN4MPOxuObG1Nj3pSQtAjsy7NsUaiZQ==
X-Received: by 2002:a17:907:9308:b0:965:b2c3:9575 with SMTP id bu8-20020a170907930800b00965b2c39575mr11934635ejc.57.1683651920443;
        Tue, 09 May 2023 10:05:20 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id md1-20020a170906ae8100b0094b5ce9d43dsm1538083ejb.85.2023.05.09.10.05.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 10:05:19 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-965ac4dd11bso1216571166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 10:05:19 -0700 (PDT)
X-Received: by 2002:a17:907:169f:b0:953:93ab:50cf with SMTP id
 hc31-20020a170907169f00b0095393ab50cfmr14975532ejc.70.1683651918864; Tue, 09
 May 2023 10:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <202305041446.71d46724-yujie.liu@intel.com> <CAHk-=wgYqsXvK0zA0o061NSkc=dXX4LoP_4m41TyskN9RHrojQ@mail.gmail.com>
 <CAHk-=wjMz_=WyfQMx1ebofeq+w6Cr_kRcJ1Xc=D6iKc4My16bQ@mail.gmail.com> <ZFo7j/M1suY/Ey5M@feng-clx>
In-Reply-To: <ZFo7j/M1suY/Ey5M@feng-clx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 May 2023 10:05:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLZUauRc3skOQGqm3WW4Hr711jHU90dO23ySPFDOFpRA@mail.gmail.com>
Message-ID: <CAHk-=whLZUauRc3skOQGqm3WW4Hr711jHU90dO23ySPFDOFpRA@mail.gmail.com>
Subject: Re: [linus:master] [x86] adfcf4231b: blogbench.read_score -10.9% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     kernel test robot <yujie.liu@intel.com>,
        Frank Denis <j@pureftpd.org>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org, ying.huang@intel.com,
        fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 5:30=E2=80=AFAM Feng Tang <feng.tang@intel.com> wrot=
e:
>
> > At a *minimum* that benchmark should have different threads using
> > different read() buffers.
>
> We tried a debug patch which allocates a dedicated buffer for
> each reader thread, run it on the same Cacade Lake platform, and
> the regression is _gone_, after the noise of cache false sharing is
> reduced.

Thanks for verifying.

I was pretty sure that was the issue, but it's always good to
double-check that there wasn't something else going on,

                 Linus
