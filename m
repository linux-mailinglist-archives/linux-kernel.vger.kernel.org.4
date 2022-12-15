Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A7564DAED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiLOMNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLOMM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:12:58 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224502DAB0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:12:57 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so2478012pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbROf/TWMFjx+MhQppMSRO2ij4qLCaZ+Ou86oYjClhs=;
        b=xRlaGwhWLdkfj/Xfjxe0Bu53C3ZyhnOP60du9GLIDh5lpeg9AixIvblroSXtY/xpKb
         z8QYSyvoDAqkGdEczolF7dChtHNWOtFs/uFuLE67vgSVIClw0MWuVhb35TQYt0Eypj7L
         QT0iEswSfSGshl7iVZ+LIeq1CmMwm707euW0l8uTQIN9FmVtlGv93CXv6TFaEucub3Ch
         +qwYPEdXrnTWbevK5LyOejX01Vy7wq2u3WhJ++nzYWATwkZVWFD19/oT2xy+mcJaCdlt
         BirmGqphW1e/qTxcvj7OGXizc7cVjlsb/BUKU60XjFFykZaPUvCGLA8GvUxgc7xhP9bj
         H8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbROf/TWMFjx+MhQppMSRO2ij4qLCaZ+Ou86oYjClhs=;
        b=a5lf5As00NzDCxJAyoNJAPRt8gNYZuUP/cTty5B8Z2w5JO5D3Y2bQeIoG6z3B8kyW5
         +6sNFIPnuPVNTxL0hycMNGkOaD9p0PEvdVicyA2l+km9jHJom/eqmekSUmaVpSa/L45R
         aT2WiBhEJVv7iSA9IoH1X6peMJp27cc1NUnRvvPZ2/Y7hIot7ZHqxf89XxwND/qaSggg
         /mr7ES6I/ytzG8KuOnceDznEJWtqUUNgCkyo6Jim0cA3XPsQ8HhqoeRL2QTAeYyd+g/X
         NLYt1kBB1YP3cma0wFtPsFcMXFujiiVQJztqAhiy71Jv5uZLElD2YVWYKfpr88wZ8Ecz
         3jVA==
X-Gm-Message-State: ANoB5pmYj5/BwBoT7Jx1X2U6RrLlyiw9K8c7rxXMJpDFheobwEd095RH
        hn5Yb7He1Jk36Edyr6qhEGyiAg==
X-Google-Smtp-Source: AA0mqf4sD2H8/j5rrD7/yP/LldETGl5hooq/lVB9I1kQwnnTUp5/EAtE4m4QFhcWVGkJN1mVn8aARg==
X-Received: by 2002:a17:90b:1914:b0:219:3e05:64b7 with SMTP id mp20-20020a17090b191400b002193e0564b7mr6458040pjb.0.1671106376453;
        Thu, 15 Dec 2022 04:12:56 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id oa9-20020a17090b1bc900b0020a81cf4a9asm3037614pjb.14.2022.12.15.04.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 04:12:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     paolo.valente@linaro.org, Yuwei Guan <ssawgyw@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com, Yu Kuai <yukuai3@huawei.com>
In-Reply-To: <20221110112622.389332-1-Yuwei.Guan@zeekrlife.com>
References: <20221110112622.389332-1-Yuwei.Guan@zeekrlife.com>
Subject: Re: [PATCH v1] block, bfq: do the all counting of pending-request if
 CONFIG_BFQ_GROUP_IOSCHED is enabled
Message-Id: <167110637519.45663.2497428136113155086.b4-ty@kernel.dk>
Date:   Thu, 15 Dec 2022 05:12:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Nov 2022 19:26:22 +0800, Yuwei Guan wrote:
> The 'bfqd->num_groups_with_pending_reqs' is used when
> CONFIG_BFQ_GROUP_IOSCHED is enabled, so let the variables and processes
> take effect when ONFIG_BFQ_GROUP_IOSCHED is enabled.
> 
> 

Applied, thanks!

[1/1] block, bfq: do the all counting of pending-request if CONFIG_BFQ_GROUP_IOSCHED is enabled
      commit: 1eb206208b0f3f707c67134ef6ba394410effb67

Best regards,
-- 
Jens Axboe


