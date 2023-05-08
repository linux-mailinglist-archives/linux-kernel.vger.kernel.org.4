Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569D36FBA61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbjEHV6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjEHV6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:58:16 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854A210D;
        Mon,  8 May 2023 14:58:15 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-38dec65ab50so2881834b6e.2;
        Mon, 08 May 2023 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683583095; x=1686175095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYD9qUfsMKsdWwBMnXikPPjoTvUwobnwMoNDEvNnnaY=;
        b=WaV2njf6ub3jNTiOp6qhZn195Si8U/jN3lbuU76eU9d0hw69Evi5GbXccKITtMejAZ
         YiHJSvy6P1z9SK2NOcjr52AKJ3o3z+3fBkQW+3VtFeXIN4N7SvX9v4oKVGwqEhL2HSSb
         X4C3p6pV0Yv+0anuFQZPlywpoHBByLkGG+ViMfc769ogZouhSogpw8o0I13lYl0mmlcD
         qkR0rsJo+JQhP5swHmZW6WwfQCPnkBwIwEW1l84CuQrCElHStWxl808pbPkGIrQmEZLp
         X5Y17avdEQEmyYMmaMgaK4LBTmSJAme6dMTZqEm8bHXzGLNHn1iR+Ubkeop21ufL2CKX
         9ysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583095; x=1686175095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYD9qUfsMKsdWwBMnXikPPjoTvUwobnwMoNDEvNnnaY=;
        b=QKtCS1Vpuhyx73l18U2XZACE4Gk7f/m6lY3E6firTRaxvHzI4Us819KueLnXPqZ9lW
         b1tXlbm3MEoyGdOQ07C5+HTWd+vQSYB1tpa1+g79r+fZrN9me/TjQEfOA1wCzfiW7uNG
         1jpC6g1FiJmZTlkZB62BWjBxfkdru6OEomCdR9oftCR2soorCCqq61ewmfJVrmEVaJqd
         aa4r/r0LCV+rv6E+8Br3sgrmVXRNmLEEwmWjChl5FvO9wIFfcoSCF3kycLgavHk83mbS
         Dm+uF2xxCvMnNMzNDbs/U3xHTCNwjXH6eSujowy4hHpLgZGYedR2CQHqnKnOimSISAS8
         DzPg==
X-Gm-Message-State: AC+VfDwDfm1zmckvlw+VOq6SeNvKvZVN2vJRqS2okv7XF1xUep0JtQ7m
        0DrCoCHwZ81ark7pw8XKwrT2xVRnzg==
X-Google-Smtp-Source: ACHHUZ78OsFdJ+lCqJLTphN/mSCRDehxvPfjFqsgtyIjGGbcUUXpxLW8hvxzjhxB9ZM0Lc2sfy4rvQ==
X-Received: by 2002:a05:6808:2805:b0:38b:a6be:7a55 with SMTP id et5-20020a056808280500b0038ba6be7a55mr211448oib.37.1683583094687;
        Mon, 08 May 2023 14:58:14 -0700 (PDT)
Received: from C02FL77VMD6R ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056808180b00b0038934c5b400sm470195oib.25.2023.05.08.14.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 14:58:14 -0700 (PDT)
Date:   Mon, 8 May 2023 14:58:09 -0700
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vlad Buslov <vladbu@mellanox.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net 6/6] net/sched: qdisc_destroy() old ingress and
 clsact Qdiscs before grafting
Message-ID: <ZFlwcYY0nkCEEXFY@C02FL77VMD6R>
References: <cover.1683326865.git.peilin.ye@bytedance.com>
 <e6c4681dd9205d702ae2e6124e20c6210520e76e.1683326865.git.peilin.ye@bytedance.com>
 <CAM0EoMmFwgmip7pYSLavfXzduWCwS4AyuAON9oXKYAn5G2Yiog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoMmFwgmip7pYSLavfXzduWCwS4AyuAON9oXKYAn5G2Yiog@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 07:32:01AM -0400, Jamal Hadi Salim wrote:
> Thanks for the excellent analysis Peilin and for chasing this to the
> end. I have no doubt it was a lot of fun! ;->

Of course ;-)

> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

Thanks for reviewing this!

Peilin Ye

