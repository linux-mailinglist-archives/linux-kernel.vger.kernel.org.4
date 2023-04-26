Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84966EF0F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjDZJUo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Apr 2023 05:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240249AbjDZJTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:19:41 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF463C03;
        Wed, 26 Apr 2023 02:19:08 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-b9246a5f3feso12231382276.1;
        Wed, 26 Apr 2023 02:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682500702; x=1685092702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nea43AGTHWHWBjILaENIfdEesjmp3NJp5Ib9Fbp61ic=;
        b=SByM82THatNkntNrzsAnwcGHyR03DjnVbSsGClf+vRSDh2CisJloEB6VesjtCE9pCK
         7COUSdiQUijfP/KVTrVSNtIzQwyeZhVAinIbWxASOd9eWUVK4yE7l2SOfezDNcy/7KYL
         hRnhgfa9FWRJk4gtz7NSWldox3z/4K4Kh4wLjS4nihq9IFOleB2JRcMBYejVrpV3j5Ui
         HZ7fU80f7OddA9FkI6WK+XMsRqS38H5aBVHOrCKM5+A3CCxoWbr1/wor9yzGAWQGpS2m
         RnYa9pLhDzg3Ceq2cJojdbzNBfhosF0dpBP0/kPS7LiLcLmHp9VAEOe9XAQ1DgXIt9Ct
         DBTA==
X-Gm-Message-State: AC+VfDyxYzUtS264tpHo+D4UHA++gIQ3cSZnJE2vCtwbjL2iqQHFBPB7
        ixvG6My+Vf1V4TMQZP8zyYb6EqipiiSWpw==
X-Google-Smtp-Source: ACHHUZ46BdIb5iKIODz22Gu2INxw8w+7w4zeHklIu49Rq7WsBDELZH0eDbSf9TgEBk4Iyg/HYTEIiQ==
X-Received: by 2002:a25:a10a:0:b0:b99:e0ff:5f16 with SMTP id z10-20020a25a10a000000b00b99e0ff5f16mr4560707ybh.18.1682500701873;
        Wed, 26 Apr 2023 02:18:21 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id e131-20020a253789000000b00b7767ca7473sm3951047yba.16.2023.04.26.02.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 02:18:21 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-b8f549d36e8so12204172276.3;
        Wed, 26 Apr 2023 02:18:21 -0700 (PDT)
X-Received: by 2002:a25:1683:0:b0:b8f:54a4:9a55 with SMTP id
 125-20020a251683000000b00b8f54a49a55mr12415557ybw.65.1682500701204; Wed, 26
 Apr 2023 02:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
 <20230328160756.30520-3-quic_kriskura@quicinc.com> <dde01219-57f7-3cc2-c4fb-5b6a38bd7a9c@quicinc.com>
In-Reply-To: <dde01219-57f7-3cc2-c4fb-5b6a38bd7a9c@quicinc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Apr 2023 11:18:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXdP6fPPQxvAdQCz2P_SPnCLjEpqiTHerF05e7tJmWHFg@mail.gmail.com>
Message-ID: <CAMuHMdXdP6fPPQxvAdQCz2P_SPnCLjEpqiTHerF05e7tJmWHFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: gadget: udc: Handle gadget_connect failure
 during bind operation
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_ugoswami@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

On Wed, Apr 26, 2023 at 3:17 AM Krishna Kurapati PSSNV
<quic_kriskura@quicinc.com> wrote:
> Hi Alan, Geert,
>
>   Can you help review and provide comments/approval on the following patch.

I don't know why you are addressing me, as I never touched the affected
file, am not listed as its maintainer, and don't know much about USB UDC.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
