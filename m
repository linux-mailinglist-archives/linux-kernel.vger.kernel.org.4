Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AC672A161
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjFIRie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFIRic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:38:32 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956BC30FF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:38:30 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3357fc32a31so1684935ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686332310; x=1688924310;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFN/ngh2qAWxLPocmGCw4f8nI83RTxDlGX+psBDU7zQ=;
        b=lo1hFMspJ97T89nkTAuLWMwzicIlsVU5g7F/jYoBPOG0wuFpu7Om+RcLiasKXsYrJE
         Jzf4cFv+1aZNMkkv4ch17mATGJKip5jnIhLRDqLNINyvg+Uq+JLeKfMhMA+y5JY1FQnA
         Z0E3oWegJs/tinE7UkKkrhVfXezDabsbwBhhHj2ubupC32sqOhKB0Ko5clbW6sz5BopT
         8zO5yZZn4u2l5NxFWUEp/dwzP1Y22txr2d3k0upAjgeOF3CHZ2GVhi+koIgcqtYLsxLW
         8LyrTCp4IWH1z2tbNW46Jl4OJ8ha8IrVkOswyUdntSPQAFNWGapKJi6+3EKIr1b+RevO
         kUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686332310; x=1688924310;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFN/ngh2qAWxLPocmGCw4f8nI83RTxDlGX+psBDU7zQ=;
        b=aAnVteEaoRH7NCDApDXqJREOqJiFf5xDuM8occQXe/tMYcYkN6RL//80iOwbofT6ib
         3bad7zPO3qWIAJ8T782pi2uW/p61trzoFP+WtwQvVWCPXPxI+HRriyJEGLA46lE36U77
         NafVuchRxC6LmBekv+XLlOZP8hY2o7lf8CLtQ8YAhHoMCCvOi7UY0XlkMG17l+OcpT+3
         sWyNNcakFpB+NLigwmbIBWE9lUTIAl5LakHlpzM/JD/vPkVu8Q9gKz4/Ji2xLIHWSBlI
         K21r20A88YCMntqIlJkExJd8zHXCdZtHsEtXK5Se6s60sqIsrxtd1qWBRqbfLAat2iOK
         gwEQ==
X-Gm-Message-State: AC+VfDweRGsNI+uvbNi/PS9uh2ZnIxlTWutGzIy+t2Mj2ZoO/W5lJpH8
        VKKiSBcThzopqO2xAj1IAb+xvQ==
X-Google-Smtp-Source: ACHHUZ4RCwmr6wL6gfG+lLDv7adQwFwZ7ioFiwvs51g/vMiNFw4mtWyi4oQktGDmR5neLScZyQlQzg==
X-Received: by 2002:a5d:9d8f:0:b0:77a:c93b:f9d8 with SMTP id ay15-20020a5d9d8f000000b0077ac93bf9d8mr2240500iob.2.1686332309979;
        Fri, 09 Jun 2023 10:38:29 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y14-20020a02a38e000000b004090c67f155sm1077815jak.91.2023.06.09.10.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 10:38:29 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     festevam@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230609051737.328930-1-hch@lst.de>
References: <20230609051737.328930-1-hch@lst.de>
Subject: Re: [PATCH] block: fix rootwait= again
Message-Id: <168633230873.625852.2100341448421337244.b4-ty@kernel.dk>
Date:   Fri, 09 Jun 2023 11:38:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 09 Jun 2023 07:17:37 +0200, Christoph Hellwig wrote:
> The previous rootwait fix added an -EINVAL return to a completely
> bogus superflous branch, fix this.
> 
> 

Applied, thanks!

[1/1] block: fix rootwait= again
      commit: bb91a7d96a5c9662f41a08024f405bf9ad333e86

Best regards,
-- 
Jens Axboe



