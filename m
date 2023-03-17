Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAAF6BF494
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCQVuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjCQVum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:50:42 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBD03E1E6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:49:59 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id ja10so6717118plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679089783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17vrAHPcpt7USxungNYJ/wvRhGxMRagStdViFJpnIxw=;
        b=X683k1CZjfuoHw4S0vH3N+223YNtZr1Gy+GVCBMKPztJdT+t1sC76ZWk1A3tbLpkd1
         7g6u/czKLuPkBj9PIlIrBDuZXqwK2MzSStiUEQwXMA/7tM+eBpgLu7CbIwdAeSkuj1Xz
         6B/IRZ55cDFWv5ggBTJSVwgaIYA3aoEt4CaqEzYeyjh8Us6pa7kxk+MImpYDwzhzd8aD
         dXijvZGJGKgFlnwMKvQJbFhW4sSV0tD4tNcyKQsjiNXvj+qMlxC7S/16k6ILVX2ri7V+
         79BW2PhuBNvlvfni0Jf5nkc6TCGCBYzA+Fe3NakD/rDxNdWhGniMKMDHl27JIpIohaUs
         ARDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679089783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17vrAHPcpt7USxungNYJ/wvRhGxMRagStdViFJpnIxw=;
        b=kvUa12F6Ui0sgC70m8IUhXsriLl2iuVEOjb40uYZVj9UAv8sRP5gkUm6Pk//Qf88tt
         3aUYhnbvW+9+my/5p9L2MuddorI3ONa8MKTNJmSCiLxcl6O5ZJkTqQ4FKD7u3odb5GDm
         JCSXsJJlXm7QAwqXsZ+3kEdTTT2+ErHmPp7lRBEgGRASqVYN25grinGQQGy5UVB+by8G
         +x6Kw9IwABzHAGQxW+kzK04ZUDfpkXb6GU2mQfiUDB60m3wA9D+wZHBmJK+rpWnsHL/D
         g2kU/LBDN2q7UbBNxxavN8D6egJ6roZJBiXzcMEfLW06sZxYBUnvsZXHYY01wO74RaNj
         YNtw==
X-Gm-Message-State: AO0yUKViGSSY0upzh5lOmkyKeKmcFRBHqfhHPIinfp6HFifgmvIZQtvH
        H0B7Z2/U98KrujMS99OQutQ=
X-Google-Smtp-Source: AK7set+iXI2Lb9xULVAkDOCN8RmCZiri3oqGPASnA+qbG/dqSvOmKU/9RHGIMor5EtKBRL27kBGf1g==
X-Received: by 2002:a17:902:fb43:b0:1a0:4046:23f2 with SMTP id lf3-20020a170902fb4300b001a0404623f2mr7075874plb.56.1679089782783;
        Fri, 17 Mar 2023 14:49:42 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902968600b001a194df5a58sm1976910plp.167.2023.03.17.14.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:49:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 17 Mar 2023 11:49:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [PATCH v1 0/2] Two small patches for workqueue
Message-ID: <ZBTgdWov93mp2ifa@slm.duckdns.org>
References: <20230226165321.24825-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226165321.24825-1-ammarfaizi2@gnuweeb.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 11:53:19PM +0700, Ammar Faizi wrote:
> Two small boring patches for workqueue.
> 
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Applied 1-2 to wq/for-6.4.

Thanks.

-- 
tejun
