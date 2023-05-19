Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75018708D05
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjESAmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjESAmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:42:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204EABC;
        Thu, 18 May 2023 17:42:47 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae4c5e12edso21359645ad.3;
        Thu, 18 May 2023 17:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684456966; x=1687048966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=FhVbqUWSfKoK65eksBcMm+T/anGwzJ7feZxDU9sQLJuv5vpIWmfyiQXDcuurFsNM/Z
         tXNZIdpE0ugAni5joL8Y7T7mQ1R1AsMH/ro19c3opgXo/WWdLFunhUgeC0VVh7ZgxeTH
         vbVwkoIvoVDjE1G+OV7XcxQ9lGNbB8Kovpny75gaQMi0vQqwpV+rfLP76tRJwDWTVJZQ
         oJZwadsywzFEpRnAENSS5y955l7Vve6MI6Igo85hFz3ZjRIFgbPP++oy125CiMpBVqdr
         f3QQkqRgwuzHoJKYxSKUTSZfpaKqD7OgDNRJQK4m+tdu9RPRF9KYVIWlRwgzTuFyC+bJ
         CrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684456966; x=1687048966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=GkP5Q9owsj7p5wmEQ8Fpr0j8HjQOaXsSo3cU7IOZ6yr7nS/QXJIeKMvi/n1sLFrx5v
         /2mOqsqknVd1+EXyRasc4SeODTcI/7i6W1r0eq37MczpTrifEV1IK4bSSDei3QSUxd1Q
         4JV3RR7W3Czjn9MQwqiwU1no84i9I+3+7+iUFlVKIQS+1ZiwIYaNpfVPhu0CGT4n7ph+
         ozRD9IfYqSTZwaj1qxVcjjotZvuzT1w+t6ZTjMw1efvpYwJ8T/+DOogzCwk2JJXJImj3
         Cwi5w5HNuk1CfU9e58HFQ6hfWyWGOsEC/MroHAPh0w92oP8m11g9mOKkVDith2R0V7xN
         bvVw==
X-Gm-Message-State: AC+VfDzzoSQ92NGQTdn/eXmnk8ySUz9aV2zoDYg2vhemBqzmubVjznJ6
        YSNrnV63uI/n9OasrlV8cuc=
X-Google-Smtp-Source: ACHHUZ7uGgeA0JSUHZOioCuEkISbTecVbqi5XMFhJ+uP4uwWKkKBFlNJvWeibygfrTk2BCH5gq2FcA==
X-Received: by 2002:a17:902:ced0:b0:1a9:a478:66c5 with SMTP id d16-20020a170902ced000b001a9a47866c5mr880974plg.63.1684456966374;
        Thu, 18 May 2023 17:42:46 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903110400b0019ef86c2574sm2033106plh.270.2023.05.18.17.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:42:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 18 May 2023 14:42:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Shijith Thotton <sthotton@marvell.com>,
        Vladis Dronov <vdronov@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH 11/13] crypto: octeontx2: Use alloc_ordered_workqueue()
 to create ordered workqueues
Message-ID: <ZGbGBCA6NGCcSNgC@slm.duckdns.org>
References: <20230509015032.3768622-1-tj@kernel.org>
 <20230509015032.3768622-12-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509015032.3768622-12-tj@kernel.org>
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
