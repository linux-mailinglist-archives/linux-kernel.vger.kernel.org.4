Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB141736335
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjFTFgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFTFgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:36:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0406D10D5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:36:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30fcde6a73cso3642142f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687239410; x=1689831410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QEJS5FDAzqAe3hnBpeiuUW3f6dfzzQgkQXzYDyGWP6k=;
        b=vKl4SAwdH844fLlarALw0CD55H61Q37HVekcCTMIdtWag1xnb57pDchz0T1QscLot2
         gRkZQbLHj7ZLiJ7TvF/SZxdGZ/R/5rZr0iAsgmi65cc98FVVxr4F0VLIGXvA2DWzXqWH
         hWKXfK+t1cFxnAGy8BHnxv8kMb8By2aUKV2i+nnT1hhjCHK/n5JV1FDm0iuB3i+8kl0d
         Eo+w5dwlUFbAazOql/zJk8xu1eE5ujI/JKBp/1/8mpuXE4//zcrFtoDLndGTnbEiRpiW
         al2fJNSDDRyEawJx71vYqSBxBnvw/bbl1j+sqnZT0GkPwjKSn0tEQtkaJWxKVfU4LnGH
         lq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687239410; x=1689831410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEJS5FDAzqAe3hnBpeiuUW3f6dfzzQgkQXzYDyGWP6k=;
        b=FeXcZg+Se9DuJXn27SV2TqfI2k9kGyTAkbRV+HW0kAbOyXDOIqxJ8qDVQMvBny8aAC
         HjBRfpYRnMn3m2RX0oUK9VuiR3B+8J5DvDOqHpp4DiYknZfTCM+E1I/O34O/msQ2S5E+
         y2QesivCcxr5360WZ+yoDhtVJL8YchxpI7nkJbETaGYYi3X03KA60PnjCZRfe/XQyHu7
         E1+u3kQNGvaQksloQQaXDVb+BGjmKVRICOsbhr9aqS/BkahwaiqXhxENScorCUzvyJUm
         7vGqoqUpJwa079jXthJXAk0Za3TQdgL7n6I62VqIh99PnVV0445ceLI1FO75GclcQg+M
         obxA==
X-Gm-Message-State: AC+VfDzlHGXspD1xYjx8rCYvEmM65wzV4D366nvqIrhm6BzFx8p2MuQC
        68yip0qnp7D/qaMt/l7Mwk2JvQ==
X-Google-Smtp-Source: ACHHUZ6X5zSuSbEf0b7XgWiyaWPgrAOwv271mDvGsWifmc8ZvlnQX7WqwDN3BBHuX7ds5yT7bl17nw==
X-Received: by 2002:a5d:4a0e:0:b0:30a:e6d2:3ce3 with SMTP id m14-20020a5d4a0e000000b0030ae6d23ce3mr7096325wrq.16.1687239410522;
        Mon, 19 Jun 2023 22:36:50 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x6-20020adff0c6000000b00307972e46fasm1070682wro.107.2023.06.19.22.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 22:36:49 -0700 (PDT)
Date:   Tue, 20 Jun 2023 08:36:46 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        t4rmin@zohomail.com, colin.i.king@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/rtl8192e Fix camelcased function name
Message-ID: <e4986b37-0b22-43ff-a07c-4f15f8c71add@kadam.mountain>
References: <ZJDnetEcwdG1ffrK@tacos.darkphysics>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJDnetEcwdG1ffrK@tacos.darkphysics>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can't send a patch as an attachment.  The subject isn't right.
Do `git log --oneline drivers/staging/rtl8192e/` to see what to use.

Read my blog about how to send a second version of a patch.
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter


