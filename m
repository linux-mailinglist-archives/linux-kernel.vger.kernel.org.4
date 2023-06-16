Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D935732FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345335AbjFPLSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbjFPLSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:18:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93FC213F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:18:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f8d2bfed53so4909565e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686914291; x=1689506291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzzz9+MQDy1v7mf6h8LKh2I0EdtZCpgt3033bmxFLt4=;
        b=xO9S4qPH++KwL3bqmpqNIouOhxbgRJ6SxHNQK/ye2vn8zyZyyVWE0A8Fp12TPe5UEm
         auhGwcNjhXlWmq7Z/IdqpdZbQkKk8Dml+ZcRR44APMB4R0kI3zvQIXbdbpPDxieV8yy3
         YUN8nNjIG63V6OC1046j6gB2kYhjfS3Yi4uV54gq2eRTC7+ihj6Ja8OPu3PIWiKMjPjH
         G5wW5UmtxjC9eoDQvYkHUMmCLvuG6T8Ls2v1sidokHKLWLLYphoIclz567/lbDY8nQgm
         MC1xP36ucCdyTuIXwAZbqlb6aX3l8SyGtYlvJdvuYY239/r5sjTXPcmnRUVtUw6qLzH9
         u1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686914291; x=1689506291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzzz9+MQDy1v7mf6h8LKh2I0EdtZCpgt3033bmxFLt4=;
        b=VJGoBn2JAn9oPEH5yajA/JrMrPe9eP+2DhuxmCoUCBqonKPTcLdRH6bMUVu69opJZR
         h3oPH2tPsuMyMPmdfphGOr59vYNMP12MNMggGiwlby/hKgjS6zd6t8qmgrUvD2sJOp46
         n4lHrBwald2Q7xHLlMOpY5blLdMBCsgWYsfxN/m3ha5zazDH2kExcv8nEUj5fqRSaVi6
         8EZSzJMNbMw4nHIzmn6fZXl6mC+Nx3gbGO7zPXLr5P+4Q923+iCpHX/YCnpBC23kFMG3
         Ipt+bkjBp6bsaeny4pyun05xQLDPU0Oa/EW7MvzA9ScpY5YhOILEwQo3nwTt1TtP/alf
         TqvQ==
X-Gm-Message-State: AC+VfDycjcrDbkl+BeqARFaF3/oPaCtjdN3ETw2Gl0QOCw+r8xtnuKZP
        LScv1Z3JcfatXtVgvHNzJH8WMkzlIDxIPnv3L58=
X-Google-Smtp-Source: ACHHUZ4dQlbHeAuRZeLC4Y8OzZsImTHLTf2rFlPkoywMcf0wXUYdWyJ5nI7ueJAs67y7U7OWDEJTlg==
X-Received: by 2002:a05:600c:329d:b0:3f6:eae:7417 with SMTP id t29-20020a05600c329d00b003f60eae7417mr6554134wmp.1.1686914291372;
        Fri, 16 Jun 2023 04:18:11 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n16-20020a7bc5d0000000b003f739a8bcc8sm1917075wmk.19.2023.06.16.04.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 04:18:09 -0700 (PDT)
Date:   Fri, 16 Jun 2023 14:18:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>, tools@linux.kernel.org,
        kernel-janitors@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, smatch@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from
 dma_request_chan()
Message-ID: <7466cb8d-85d9-4583-af2c-3616209e97e3@moroto.mountain>
References: <20230615-topic-sm8550-upstream-fix-spi-geni-qcom-probe-v1-1-6da9bf2db4a4@linaro.org>
 <b82b8041-7bc5-433c-98bc-4ac6fcf5ae9d@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b82b8041-7bc5-433c-98bc-4ac6fcf5ae9d@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 06:12:03PM +0300, Dan Carpenter wrote:
> Here is the command to search for all the KTODO items added
> in the last six months.
> 
> lei q https://lore.kernel.org/all/ -o ~/Mail/KTODO --dedupe=mid 'KTODO AND rt:6.month.ago..'
> 

I guess you need the -I option here.  I'm not sure what -I does.  I had
thought it might mean case insensitive search but that's not it.

lei q -I https://lore.kernel.org/all/ -o ~/Mail/KTODO --dedupe=mid 'KTODO AND rt:6.month.ago..'

Then grep ^KTODO ~/Mail/KTODO -R and cat the filename you want.

regards,
dan carpenter

