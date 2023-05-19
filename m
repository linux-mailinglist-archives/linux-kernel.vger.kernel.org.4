Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13026708D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjESAun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjESAul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:50:41 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DDFBC;
        Thu, 18 May 2023 17:50:40 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5304913530fso2461977a12.0;
        Thu, 18 May 2023 17:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684457440; x=1687049440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=o9KS7YJOvUFKFJwPmR6sxid//+dzBMJMdAKwIV2GWa3HE08bImysrgjQUFZXaisQPg
         5KnN6MlhqgV+sBm0JgUU3OpzXsZSKihu69r5hxYN+9iwEPOTmC9qR383e4VvFwrk0ImM
         bx4z2c5KUEtGqCFHm1E5ax+XkPZqGPmnx8Jaz/0wcBBan9i0OP5KgeSVr+fLq5HFFfe0
         AqhR4Sc66mlI9IHt4LycdAZOeb5rf+gHwp2Y7shK4ktdntMF2L7675JcF5LTOwu0x0cg
         2BpZYBYNNhEzx7M8zn9iuvSlKPAnar7C+557g6WIOnGtRSXAI86xZDGTSiakJqrYc7vl
         3xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684457440; x=1687049440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=RlSP3rkwfU8GYRHL/6k1wsc9Lxx9fJVZReisMUUrPBtb9sA5KnqBpx8/tlKx5mxptk
         ebfuDnNlQ+ntC3jQ+C3dkVeJ/mcFm2zN232JXUDAN9IRq/clhx0DXrRcwCek6yI2p0wZ
         bOLYq6GDWM2SFexbWN3Gvrwo/JFm//0lQyYVWpL6s2QThIilEZKyi0CbJRUFoQ1CI2gp
         AeKlNdVQeYnmJd63bFGhXNfQylWVtTSUWaDRNklN9FtY/fSr+vPNLVOwK4NFK3I3C+On
         PVfxqDjkwj+t1WPI/lrnomuMZo6axKLJfdk6i5z4lubhZLkfVNFN3KISjehdPNWEz5Vh
         b4wQ==
X-Gm-Message-State: AC+VfDzfThlGpaK9zUmEcVis/HKmXYdmQFuvrehAW39Bz7JNdMmtmoBD
        XcZ+u2oHt34ViwOjb1B7wf0=
X-Google-Smtp-Source: ACHHUZ6CLi0rFkSdrmEapeDYyWv0hBxoiC6OCcv3dRQi7Xqx+W2RlMl6XDn2tS6AQBjEt5F+F20FZQ==
X-Received: by 2002:a17:902:a515:b0:1ae:6efb:7a60 with SMTP id s21-20020a170902a51500b001ae6efb7a60mr830413plq.39.1684457439573;
        Thu, 18 May 2023 17:50:39 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id l11-20020a170903244b00b001ac937171e4sm2039176pls.254.2023.05.18.17.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:50:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 18 May 2023 14:50:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 12/13] media: coda: Use alloc_ordered_workqueue() to
 create ordered workqueues
Message-ID: <ZGbH3YYeNHD_Uh6T@slm.duckdns.org>
References: <20230509015032.3768622-1-tj@kernel.org>
 <20230509015032.3768622-13-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509015032.3768622-13-tj@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to wq/for-6.5-cleanup-ordered.

Thanks.

-- 
tejun
