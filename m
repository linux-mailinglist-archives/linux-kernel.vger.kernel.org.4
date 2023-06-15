Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E187F731D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjFOQLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjFOQLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:11:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92A095
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:11:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b3be39e666so7676505ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686845477; x=1689437477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SHFSwygxeSP/wb+9cpN9Yh89Hq/EoNysOuT6jZLAZPA=;
        b=a5jrDgJ473r5kUIlYrgUMKKspLnXEM1iePB/RAqvLVO8KXD8ipIU0S+BvsIY8KzL+o
         e8GvYpDS/83Hz6b0ZR42lyNdIMzhOWiEQZhU8AZO/H6FSOzz4Ui5zYW4zWlBl8afGgDh
         7U0ls7TCNFrf9BAyDY3nqDgQ3e3ZbAJo/qVmHnAzTWgcNcQdsJdmPOXOxHKqmHwNaomN
         ZbRLK3jOeBoCHKUOejfkcTXGfQSkuB/BRx9K2QBPUooCYgrKb9s4hyzOztelOOxEhFCA
         ICSEPIJXtYiFtR7viy2efTNdfT3eA6C1+EAr2vK31EprWEcTkN3cvPFM5pUjJn7seq1+
         kjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686845477; x=1689437477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHFSwygxeSP/wb+9cpN9Yh89Hq/EoNysOuT6jZLAZPA=;
        b=FJINH0t380s6XTvwr0a5HBKlMUahlnFVW0LgFF62X2VrO2nFKBCaCqw0puLH8l/mi+
         115FA4ot5DiwvZ834Bw8GUAnC9RSny/UJoSSqod/BVaP7Y6XGIjRPl3JRh9B9QnUlfFP
         9noTACVB1rZJ8jFaLiimn0bz2IiSZbFwXNFhZev3opfwI3bPzApJAdlsICa02Mlur6pI
         fTWhOSspmtF9A5V38eHrYJzOWuN+Wa5ZXoDymrxo5YBgkjAjxCJmKwyLn7zzouFG/uiU
         7PsynsXRl6j1aGm0du+FHn/caeSrfxmCNCZx3kGAw3w1K6sI+6WdsFyN9FEpT08g4lBR
         ujKw==
X-Gm-Message-State: AC+VfDwDyFNz/WJ9WCfw8IKd8sQjQnLAfjRCHeIS4TW1sKPUyIrNX6Hz
        SVOWIpH1/vuSiEOuNSqrGfOwyDzPjow=
X-Google-Smtp-Source: ACHHUZ6cwPkh6elQv6ZZn8eTE+1VBrzp0IAE9+SSpS4WlT6sTPwAuiG+jAMOY0L6uDaHtW0Y4Nr/yQ==
X-Received: by 2002:a17:902:dac4:b0:1a9:6a10:70e9 with SMTP id q4-20020a170902dac400b001a96a1070e9mr7036413plx.33.1686845477059;
        Thu, 15 Jun 2023 09:11:17 -0700 (PDT)
Received: from yogi-Zephyrus ([103.251.210.211])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902ee9100b001b5115b16a1sm2125682pld.94.2023.06.15.09.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:11:16 -0700 (PDT)
Date:   Thu, 15 Jun 2023 21:41:12 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: Re: [PATCH v2 0/5] Trivial code cleanup patches
Message-ID: <20230615161112.GA42873@yogi-Zephyrus>
References: <cover.1686149467.git.yogi.kernel@gmail.com>
 <2023061532-fall-earthy-c429@gregkh>
 <20230615140908.GB37552@yogi-Zephyrus>
 <2023061520-gear-unwind-fbcc@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023061520-gear-unwind-fbcc@gregkh>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 04:34:36PM +0200, Greg Kroah-Hartman wrote:
> I don't know, sorry, that's up to you.  If a symbol is used in one
> module, then of course you can't remove it :)
> 
> don't mess with the modules split for now, just get the existing code
> cleaner, that's probably much easier, right?
Yes, clean up is easier. I will resend the v1 patchset. It only cleans up the 
variable names leaving the rest untouched.  

Thank you all for reviewing the patches. 

Thanks and Regards 
Yogesh 
