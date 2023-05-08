Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ECE6FBBB6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 01:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjEHX7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 19:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjEHX6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 19:58:55 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3283E10FE
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 16:58:54 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aae46e62e9so37122145ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 16:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683590333; x=1686182333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=cbvSR/3dKgyfh87LL+Na4E2z+nS904gEAihiVyEbc3Z4Z/4DonWXup6MnVeDT7WiCA
         a75cdwbobOjWlPrtRi85/GPnHVkvYdPQUVFF19BjCtQKfI7osqWaPaRysMDJtLYX6eBl
         ACkVCfsdCMJKHCL9WAyAHnnzwNqR9abpPKCMB8JaOGDeDM7f1Zj17GslUJMFgSa+HoCh
         tfBl8Q1ZiD+e3CsenQ6jZljN1K2klZ2x9Wa1YQTtwrWXjx8kDGCuBnq99wgVRn+O9Wfs
         dY1EaDqg+lMYF0wCkKNV0vf/Pi3n64RL6ebdSg4PtyuUL7CK3FCiBTXkwQPSHQsWuQ2u
         g/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590333; x=1686182333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=ASae05L1JLz0l+6oOu/t0TFX/TEiiMAQcanZUBVi0qTlBQrhsGfeP+i7/P/pj+9P87
         G31aMutyqm3Oda7kzloxTOgJoLtKlxtfOSTGtcgGhHNMa6+MMU2HLVqVmqnOxINsBv/e
         o6dt6uh19SeB9XL12rbuXH0aephMCZJiwJ1wj4JzmqYlkqYJd04JGdzF5VRTZJUUFe88
         3rfGz1wcOEc1AJM+0mq/kIeCDiZ0wXibQVs22ILaPNDNy5CdkQXFJD207RLmSOKv5ir5
         fcG512YMe4B0m0ufrrTktxYfymnswJY8BGzTe/VOJdLvly912lG3dGDXdZTBrc6XE42Z
         9r3g==
X-Gm-Message-State: AC+VfDxcp1AfnRn2RQdLYhQYeYMYPyp4wKFv9obaG4U6oJmqQxHP/c7T
        iBDC0Q8KwBaQDoXetAsLsjs=
X-Google-Smtp-Source: ACHHUZ4c/IntNWoeby0me0W97t0ogZrkrb1zI04R3KKZ2MwCuP/Ull7H19+AQ5Jq6IWpCCqBmSf6BA==
X-Received: by 2002:a17:902:d4c6:b0:1ac:8ad0:1707 with SMTP id o6-20020a170902d4c600b001ac8ad01707mr3278242plg.1.1683590333511;
        Mon, 08 May 2023 16:58:53 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709029a9100b001a653a32173sm67623plp.29.2023.05.08.16.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 16:58:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 8 May 2023 13:58:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Fei Li <fei1.li@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 13/22] virt: acrn: Use alloc_ordered_workqueue() to
 create ordered workqueues
Message-ID: <ZFmMunSrvOw9LOC8@slm.duckdns.org>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-14-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421025046.4008499-14-tj@kernel.org>
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
