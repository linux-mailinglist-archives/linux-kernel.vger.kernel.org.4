Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28816708D02
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjESAlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjESAlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:41:16 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EBF137;
        Thu, 18 May 2023 17:41:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d2ca9ef0cso451057b3a.1;
        Thu, 18 May 2023 17:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684456874; x=1687048874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=gPyTu7Ftro36DNbp+lkqcM/uD9AZNx5HrIUkeYjWtOsDesNs073VVmKX4OA1iDWGmj
         IzPUjHYderK9FHrwkfLPVzFJ4k1uiQ6NVykF/MVLc0MN9Vjy/eOiZz3b+V2Gvmty8ljD
         ZdLk8uPFZ1H7Uj8uRu8bF94mYyQzcsLxg7L0hOi86nBrwLkcb+pmkZ65H7lBAel0MAnh
         uePHkr/6fHRtHAvWT1/TkcN6/YlNzfypbGpuuQggqRcnHhieiK8ohtlCof/FIdUarpvx
         80owNV31vyWprVxxApRxjryIaKIPdKnn6L5EXyY5Z19cLRVV/uNkUf7W8zqBHHtiMTgp
         83Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684456874; x=1687048874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=XYOOsdG6SdUGVPgYyjHqhT2jWU+00EWO0HpHNC9yUUqyn4fhoKhNtUgjIiyjIVEJqE
         DdfT80dlrMVsPBmCNqy7YnlH7TSTAUO7yfPfBqDpjSzC7S5ZN5rDmOc7h/IoTlsDZciR
         XHdpedXYf7O6IPuM/h4bunq+E5qNuZ2Ipr1JagSNYsu4Rg1NrBkUrbq5sUbuart/LUKj
         25SIa2ELbW9IVcVqiAdbINjnlj4vdqUtzNSQtsvxyYRhWPH3okRD7DWbTBGaGKG/NCgg
         2ei5zIwTBOUCOGLcAOOG2kr0p5hhzeN/BHpIi+PeBUCXAsrrSbLpgJg8urOhXP3jvSSL
         uyxQ==
X-Gm-Message-State: AC+VfDxx7BWg85CWrLgmyiiy3XH5cgL4l92+vwK5eq8YJvtuoQPZVH1C
        O37LfWP1i549V0Xn9erM8+0=
X-Google-Smtp-Source: ACHHUZ5FTXkHQ/buCBgpFS1XdJiWwBLPshYyJNbxkY/nKsr3BpBS9vFVOL2VkgoHrkIB89J4sGkcFg==
X-Received: by 2002:a05:6a20:1448:b0:101:241d:55fe with SMTP id a8-20020a056a20144800b00101241d55femr239063pzi.45.1684456873560;
        Thu, 18 May 2023 17:41:13 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id fe16-20020a056a002f1000b0063d6666ee4csm1903212pfb.34.2023.05.18.17.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:41:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 18 May 2023 14:41:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 05/13] wifi: ath10/11/12k: Use alloc_ordered_workqueue()
 to create ordered workqueues
Message-ID: <ZGbFpxqk37-VhfUS@slm.duckdns.org>
References: <20230509015032.3768622-1-tj@kernel.org>
 <20230509015032.3768622-6-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509015032.3768622-6-tj@kernel.org>
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
