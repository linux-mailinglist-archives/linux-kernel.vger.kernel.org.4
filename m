Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0132D7238A2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjFFHPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbjFFHO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:14:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1AC10DB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:14:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30c4c1fd511so4631259f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 00:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686035680; x=1688627680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=It+nkfYvKCq4aeFGAGdC7BWM3PqrSBMd9y38bbAgRPM=;
        b=UXiJghZq+3ETeJdMHDXrwoYuGJi3h39BiZp+jrdychvCCP27ggpydzm+7bS4jYMR+J
         c5ZspsefFpXcWVPDSFNa0xf54ZxpLbdq4u2v665TalDvvsFLOzQdWzhI8cWE8HFspwqr
         k7CupyeARn2fvSA8adCiwLntZbNdozURLFFHUEj5ivqYA44uCmsbhWn1G/jQvMyaXKp6
         ZVBrmirdZ50lSIdvER9i/cJcjYtTCzF2w/HxNa+qw5eTj0tiOr+yQ6It/33MhSfnJ+J5
         EX4Al1EBOB+R5YBl38ZnB1c1EEd7BhMhEz4ft8iiOHvDyRRyX6g7TEbN7k83q5qxUE4G
         qvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686035680; x=1688627680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=It+nkfYvKCq4aeFGAGdC7BWM3PqrSBMd9y38bbAgRPM=;
        b=D0tSWiTgnCiO6iyU5lAi0C5AUBM/8PD0pmismR+WgAYEzLdisnWg0YOxDEVr7Hzkxw
         c2ogmlJ2Inr1RuclodTM1VFy7TnFxW1gRXbsvklLq6UrJHiBXn6goSES3VBGpkCDIgvb
         UPeEIjWftNJ+WbS7OFYu/ZhSzuUQLAY0q1pgmYqE5epCKb8vmQnO81sZijjWZtV6ToOj
         WFJe5/y6xD4kbVMnLtxjlUS5TCGiZJKfWJMGh8skB27NYAIVchrM3ZrC2qNkU4gbwkRs
         9+5ADU+/3ugb1L+zYCUjk7h+gPq/idHMXtjZ7wGAYEjlfuOssw5M65kDQ4Ls+8nP64SL
         a5pw==
X-Gm-Message-State: AC+VfDzYFq3u4ZQws0QC+fUKukdFc1wQVE0ODBKkeCMI+Ok4wxx9IJMr
        tswLDofsM+PYqWKW31OrxoE0QA==
X-Google-Smtp-Source: ACHHUZ4GwxU1iacrwvkPQqK92ptyT6EtS1B/aVnKTXF+PVgC+M6N/TJYJQqgpBkqhe/jGhrGEdlArQ==
X-Received: by 2002:adf:e6d2:0:b0:30d:8ad0:3bf1 with SMTP id y18-20020adfe6d2000000b0030d8ad03bf1mr1397418wrm.34.1686035680213;
        Tue, 06 Jun 2023 00:14:40 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z24-20020a1c4c18000000b003f734ee1670sm9153001wmf.31.2023.06.06.00.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 00:14:38 -0700 (PDT)
Date:   Tue, 6 Jun 2023 10:14:35 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>,
        "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>,
        Scott Branden <sbranden@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 1/1] test_firmware: return ENOMEM instead of ENOSPC on
 failed memory allocation
Message-ID: <ba21003b-1440-464c-b251-0e3c2759d07e@kadam.mountain>
References: <20230606070808.9300-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606070808.9300-1-mirsad.todorovac@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:08:10AM +0200, Mirsad Goran Todorovac wrote:
> In a couple of situations like
> 
> 	name = kstrndup(buf, count, GFP_KERNEL);
> 	if (!name)
> 		return -ENOSPC;
> 
> the error is not actually "No space left on device", but "Out of memory".
> 
> It is semantically correct to return -ENOMEM in all failed kstrndup()
> and kzalloc() cases in this driver, as it is not a problem with disk
> space, but with kernel memory allocator failing allocation.
> 
> The semantically correct should be:
> 
>         name = kstrndup(buf, count, GFP_KERNEL);
>         if (!name)
>                 return -ENOMEM;
> 
> Cc: Dan Carpenter <error27@gmail.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Brian Norris <briannorris@chromium.org>
> Fixes: c92316bf8e948 ("test_firmware: add batched firmware tests")
> Fixes: 0a8adf584759c ("test: add firmware_class loader test")
> Fixes: 548193cba2a7d ("test_firmware: add support for firmware_request_platform")
> Fixes: eb910947c82f9 ("test: firmware_class: add asynchronous request trigger")
> Fixes: 061132d2b9c95 ("test_firmware: add test custom fallback trigger")
> Fixes: 7feebfa487b92 ("test_firmware: add support for request_firmware_into_buf")
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

