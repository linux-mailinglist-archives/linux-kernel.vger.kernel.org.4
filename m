Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB19565EF28
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjAEOrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjAEOra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:47:30 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3541093
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 06:47:29 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d15so39552278pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 06:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uW5/0Xy5zahrkQgqdMY2BKgM//oxkezjC3Vpdg59WdU=;
        b=hn+H7TefgeYaXEnhb2fgrjPcF4N/UL+fxwpDi5Zyg4qLS2ayKIchBIGdIgxNKAM6y4
         mssN/3tYOmPirqlwsFuTDyZoq2Ax2xSIQ6kcRkTY9TSf9+HgdbhhtsbiHwSNk0rZCUcJ
         Ikc/vzsTrC48vzr5TXWIW2pGheX3K9pSjbjT4wLqHA/W4ckBGs3NTNUruAIZwqBpaJC+
         LX5Ds7hrGu6OKKrZfDyOFW5DIZh4GjW+xQuoCii+YEfQGQUP2ZxdEs3A5KkDWfadTYJ0
         b8+aFTXYn6I2jxv432nP+czU3YrZNR2aznXTN1MpuCcRg6GrxGPP9zU3DeOZEXHw6YSk
         kJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uW5/0Xy5zahrkQgqdMY2BKgM//oxkezjC3Vpdg59WdU=;
        b=VPW/ZehmJBJiRGbXtb53cNFzCqCRUX6TugHJLmfUd0V3rbmW2b5RDvJ/I15HRlHwlV
         e+hxyKamtlg1Ck7GzwHkUm+C5WGwkcYqTy3KHg+3sslqJP1kysRJ0n2kZtGE0p7aSETE
         Zq8afvNmZuegQ8Ea6dyVEJC7rl3LgSqZi9m8JnUS47StNa2xkKLVaSPh7b1C0XXlWg2u
         YrMpNF4wHXsmUNFOcaaawursh/85HaF/9MG2h6ofR1vWtoOV3BZ5xHT+S0VqWiXMS5Fk
         weMNoTYGQmjdnhSGpEBHBK7aKRWU0KMPW+rK9tRObxoLpfIcbrMjXIVantXOWnG+cJhN
         KuyQ==
X-Gm-Message-State: AFqh2kpriKWVuwXr7MkgH8S2FDdY2pc/queiTXOw4ep9dZjp5fT1JADy
        /8d19qg5lIMFR+Ns2Jif1Nka+RLGxUOY+A==
X-Google-Smtp-Source: AMrXdXsSPNPB6c83FlYsfpPDbUIYRVOAEwabbDYDFz7NTMAp/QZN7zX8kJ/WC9Fzyo20J3ievNftyg==
X-Received: by 2002:a17:90a:d246:b0:226:1020:3460 with SMTP id o6-20020a17090ad24600b0022610203460mr32230548pjw.34.1672930049320;
        Thu, 05 Jan 2023 06:47:29 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id e22-20020a63f556000000b00499a90cce5bsm17145067pgk.50.2023.01.05.06.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 06:47:28 -0800 (PST)
Date:   Thu, 5 Jan 2023 23:47:22 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Message-ID: <Y7bi+mjxEJb/pkVZ@hyeyoo>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
 <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
 <Y7Qxucg5le7WOzr7@xsang-OptiPlex-9020>
 <Y7VBFLHY/PMbb4XS@hyeyoo>
 <Y7Yr3kEkDEd51xns@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7Yr3kEkDEd51xns@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 09:46:06AM +0800, Oliver Sang wrote:
> If you need more information, please let us know. Thanks

Can we get a vmcore dump using kdump functionality?

-- 
Thanks,
Hyeonggon
