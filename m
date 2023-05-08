Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B934E6FBBB7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 01:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjEHX7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 19:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbjEHX7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 19:59:12 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B39A83EA
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 16:59:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a5197f00e9so36499875ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 16:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683590350; x=1686182350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=TPN5cpDiUj++UaBuLClkHYKSZJQANDd2z/20VxIZVWHMxUq8xHaiESgezp9rxD7Gua
         kwQsYUXcUlV+z/TE10zkBILwoSSFW9HIsSnlJiytJoJy7FpjLcJSkMTQ5FwrG0ZhPqpv
         mNklxZ3suiwvDBCj7EVZBtRDY5IACqgNnR8WuwKVGfhpG2I7i1f+Mkf7pj595ha9os6j
         TJJUiDx5lGMYJli6SFP6m5BzTEv5qxMT9T42KuwnS05NEL9gk7D+TTxRe4Ne2ObBXqzJ
         tDju3HLcbYeZK1v2hcxZ5e6OH+eh3geSlD4uCw+dEJXNmHBvdg/GJYTwaPZT50EygaGc
         RMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590350; x=1686182350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=ah4MO8QOLTF/4zAMBwKQh6sxjFTBllNp0kEftlYIym1W2Yfa64BZHsJ+XBHTODRqqy
         cz1fP0Oq07gRWwVgMmrP6WXWjHJBWyMOsaQz4eCqEJT6FYzT0zesu/rAigAXFSbqTEFu
         mxCsZ/FFh8uoIXbHOK2oWwzKohe9OdYOw1oQCg8Hb90oTHK3BK4CjkRM0Eab9rXh/5bN
         5gNjKiQNNy4AarZ12o7WqFEubHhQx58tyXwLpdXF8dJ2HjAhl6PTNQ5TUZ/QIdSd79np
         vjApyNA99oh/ZjMZK6/cx+VMNcttiGfXKzgVNtinZy7AKZlm9lTRS6I39Fn6PuR3yxCq
         7KAA==
X-Gm-Message-State: AC+VfDyHznS6j30gDOPl479KmRLamhL1ahjJrQvlpNFYjxBmCbZdfhRK
        MOFkwVPqkb+CP1KTpW6G6CA=
X-Google-Smtp-Source: ACHHUZ7b+WkCZIE72n5uctblOVhF8S4nx7C/p93x2y2+UjUpxZ3gKtCgsPeB10q3QmlKSF1IQOuFjA==
X-Received: by 2002:a17:902:a583:b0:1aa:f818:7a23 with SMTP id az3-20020a170902a58300b001aaf8187a23mr12371985plb.27.1683590349547;
        Mon, 08 May 2023 16:59:09 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t24-20020a170902b21800b001a505f04a06sm45882plr.190.2023.05.08.16.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 16:59:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 8 May 2023 13:59:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 15/22] xen/pvcalls: Use alloc_ordered_workqueue() to
 create ordered workqueues
Message-ID: <ZFmMy_QxaOzIoy0P@slm.duckdns.org>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-16-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421025046.4008499-16-tj@kernel.org>
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
