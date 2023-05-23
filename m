Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0681770E35B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjEWROA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238020AbjEWRN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:13:57 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451FBDA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:13:56 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-339fca7da2aso760655ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684862035; x=1687454035;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWrKaN938503ei9lTkEyE57nCrbnfRgFai+3tZIgHbE=;
        b=K5dfnzgm+tNmGD65hLQqZn/mXCAvIPNiBR1SGDkmXR2ybCabAilLHV+EJGU8h53JWm
         nxVDq7Nk8JQgt0OD5Ekmm3ExrKZDhoFNsNZvnafrAx2/4O7W1L3a9ablJfu2ERuInQgx
         7pVcg7NiErWDQTykxwOLJugxBsOQ3CPHiPqz8hD9QtOFwzl9vE3lW3xQkL28xKtb2TSX
         25KyAltSZRseTLx18xWrZX+n0fic6fGOfUvUHF0iNrCsy4IzPpdvwCYCSyk2PeWklZGr
         kkfbnu6zt3v8xvtCRIuV56VaG6eIWH8svdxnIfMZdi3cCCtqZkr3x3//fi2rbrztjbx9
         EKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862035; x=1687454035;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWrKaN938503ei9lTkEyE57nCrbnfRgFai+3tZIgHbE=;
        b=PuDPTPAAYrJXu+T0iBKJRvaLj1KMGoeY2RT2CR5J3L0whnJb1iwVnWxSrhnc38YAn7
         JdcZnZg1rCwPKAJN8IvNA8vt8NB1CUTes0ZWNJlJmcX4uArRmxrQJMg+382PhG7dMHbC
         acywJueZd1tf8x8ufJexxHfuu9GFaHoBIiq9zqB43RvIKT+Ys+SOfKnkb6UKpoPqnEsj
         jQbHncVQH/6txPFv8NO9QQ5a8y45aEcWzmfgdVWxIWpi1vAHtxdiJAPLPGtqTPwzJyVg
         pa9UCw6rZ2/bz9GNoVQoI4ECBwEYuApfLDFte7BluKOtcYK9PinhdKMT4CsWc0LgKRwq
         wycA==
X-Gm-Message-State: AC+VfDwsVGOKAco3ABZ00pKEV4/kAjXmldKQjRGMULQJC1bZt2OExbFf
        20ildWI2ju0KmCWPqSER0n0pGw==
X-Google-Smtp-Source: ACHHUZ4CCcOcqZdnQ5/73VvbEeniX7BQ65QjdNhltU7Lfcv0/jo/hCNK8dKsj1N0H/pa27m2h+ylTw==
X-Received: by 2002:a05:6e02:482:b0:32a:eacb:c5d4 with SMTP id b2-20020a056e02048200b0032aeacbc5d4mr7205497ils.0.1684862035596;
        Tue, 23 May 2023 10:13:55 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u7-20020a02aa87000000b00411a1373aa5sm2524580jai.155.2023.05.23.10.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:13:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linan666@huaweicloud.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230522085355.1740772-1-linan666@huaweicloud.com>
References: <20230522085355.1740772-1-linan666@huaweicloud.com>
Subject: Re: [PATCH] block: remove redundant req_op in
 blk_rq_is_passthrough
Message-Id: <168486203451.398377.3948384027405149003.b4-ty@kernel.dk>
Date:   Tue, 23 May 2023 11:13:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 May 2023 16:53:55 +0800, linan666@huaweicloud.com wrote:
> op &= REQ_OP_MASK in blk_op_is_passthrough() is exactly what req_op() do.
> Therefore, it is redundant to call req_op() for blk_op_is_passthrough().
> 
> 

Applied, thanks!

[1/1] block: remove redundant req_op in blk_rq_is_passthrough
      commit: 712fd23a90eed6a73ea5135a500e59d30356d4f1

Best regards,
-- 
Jens Axboe



