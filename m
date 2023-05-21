Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8C370AC0D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 04:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjEUCl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 22:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjEUCka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 22:40:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BEF12A
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 19:40:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-25275edf6caso1606628a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 19:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684636829; x=1687228829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=deLq55sdG3oQrFxh5ujiNytSgNWF6i/5khM+kQO4GHk=;
        b=NJhqvwaGC8hzhZdB63U4j6xnXUyvJCBqqtVKbG1P2yQE53FFYaJRd4lbL8x5Qi1hp1
         9YlfEYULeWIP3wcIwqRYidUMwxoPKonYDcNQq3mcGMCWmltTfVSfBJcj0CeiTq8ZagG4
         mn5ZUkSLSvecJVTE8P7QyS/rmXWZBqMWf6jR13lIHwZIQaJVXVsZOGZ8D1bduKmAbMtv
         s7j0EkcMJScb4vNIqEfdso3bNlq7wLSmuLKc7CDtpzCUAvyf5WTPz0kjX/0Nr7zygmRu
         iLUpETSUu9fuJwrJJExN7YbO15NVVGridVlrK1ZI94SluGmn0CG4/SS1wKR7hIcOdmVm
         Ksag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684636829; x=1687228829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deLq55sdG3oQrFxh5ujiNytSgNWF6i/5khM+kQO4GHk=;
        b=BL6B0xNCurYQbAzepXVJp3ftfFQnUJOd1JlWGh0UD6LBGOkRbAwUZvKlDRqgt9m4+Q
         u3BGlWQoSo5Rg43maDRiCFfS4Sap8bZDvUoLDFTcsjCIQmCNI4t0A9zYYOGMU7eI3PBT
         qlKz/QQEjPm5LBhl+ICWMdJ8oAsbyeXdlGIRHd5kVTy2YjpLPTsaOGgEXgs7QPf1yFgJ
         1hDPxQYPPyBB0yu0iow2er0XLJaljEvKG8HIN1Vsg7bS9OsbNkEEkws4UOczAHw5WvBs
         mBcoYuxc8y+rCzOK2UQZPEImJ/uK6KUjaBrUl8dl44YVK6eIqN55SBOhi9ibwGUKnKgj
         fAqA==
X-Gm-Message-State: AC+VfDzvDcNv0Avf2RkaxffZAmm/avpITVwpYz3tZ+P1PCfPqyGlWEZh
        XC/nVGBpaEI5oux+5sdPgSc=
X-Google-Smtp-Source: ACHHUZ48bp7f0TdHYTqKZCMC8+BByLa8LBckdw6CIgSN/IFGxnDUUl9lV/u9sXjZwU7ld4KmEqsFzg==
X-Received: by 2002:a17:90a:984:b0:253:9548:91e1 with SMTP id 4-20020a17090a098400b00253954891e1mr5386812pjo.17.1684636828523;
        Sat, 20 May 2023 19:40:28 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id bb18-20020a17090b009200b0024b6a90741esm3532980pjb.49.2023.05.20.19.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 19:40:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 20 May 2023 16:40:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Richard Clark <richard.xnu.clark@gmail.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix enum type for gcc-13
Message-ID: <ZGmEmkcrfh7QdkIz@slm.duckdns.org>
References: <20230117164041.1207412-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117164041.1207412-1-arnd@kernel.org>
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

Applied to wq/for-6.5.

Thanks.

-- 
tejun
