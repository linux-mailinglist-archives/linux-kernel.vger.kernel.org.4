Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67950723565
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 04:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbjFFCll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 22:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjFFClj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 22:41:39 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA984122
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 19:41:34 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-565f1145dc8so60533197b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 19:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686019294; x=1688611294;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/OY+878V1FQUEQIL1kvZEgzbdoaux9eczVlkSaD+I/Q=;
        b=TJRJ5MwMTAsRDF6xptr1GnPQQGOWkOSr9nqwm+2T4bFB2fnQYtY0MAFfIXuzj/facS
         Bq/AblFVzb2VZBFBMj8m3Aun+sKDDxRnlWdi1tqEbP4V9Msk9UEhvNN8fBw01hPkZcqh
         aCefalnixHirL+Sbfzojc2ubXX/dqN6pry0icsNDpadK1LL0wBIg+wQhdtsURMQSVYB+
         TelDBkzPL0Afw+kOv2kW7OuzpJz9ocapwkhr955CRcQVRBE5V10YpVkKlu/GtSMgtxwY
         9FBEKhQ3iuBivA6Md2gtnn8rrCeaXIdHnTJ7irl+szonbwlw673TUrUDgluT9NC8wPbt
         WpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686019294; x=1688611294;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OY+878V1FQUEQIL1kvZEgzbdoaux9eczVlkSaD+I/Q=;
        b=MK1gkgPnOn+uxsi28oGYqNtd4OFszk9UbrpHVBueCXydpyf/QfATFD1luboouc2RYy
         v7y0CdmtcyK6r+wCYMGXBCFHpoHoO7q6Tgi/EBQ6eqkMXbNRUuKg/X/m0HPgJ0crZarH
         LSH/vAwtuzu73FgJ8y/AbLPWIT3MvMHysDNfZZiB9Yn2d6+VROHjQrn1x7uCTPcZDqlC
         HCB9nhG/SlfKEvPuKXrg90vCKNKfCoEgnQP+28ladd7ej/GUqRWrL9/txxYG65qdxHwy
         JdbSzOPP09v7TNkFv/pE/I61lkh7Gyhm+hznzjIdj5o6L3OPPAonCbYuIJyjbWUrJo5O
         00Sw==
X-Gm-Message-State: AC+VfDxuaOf4B39/Muls2AKGLN7erEZxkZbiAvsbV3CSqjsv6hWuF7J9
        Ms7hb/UKtqakxkjTl5LixAO7RQ==
X-Google-Smtp-Source: ACHHUZ4+H1RDAiuTWrigMwLJw3JR7kzzMdIFJ9hsdOOC0dyodzvNJbwlgT4q0yPmIIHx50HRHgPAOQ==
X-Received: by 2002:a0d:f943:0:b0:552:96e0:ccd0 with SMTP id j64-20020a0df943000000b0055296e0ccd0mr620675ywf.16.1686019293978;
        Mon, 05 Jun 2023 19:41:33 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g67-20020a816b46000000b00559ec10f245sm3706391ywc.103.2023.06.05.19.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 19:41:33 -0700 (PDT)
Date:   Mon, 5 Jun 2023 19:41:22 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Liu, Yujie" <yujie.liu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 00/14] Reduce preallocations for maple tree
In-Reply-To: <20230605140344.66pwpdg5zgb6rfa7@revolver>
Message-ID: <9f4c10bb-ee7c-cd41-f1b9-c1a7a1a562fd@google.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com> <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com> <fad3c833-1ab3-2d34-aa85-dcc7c40c3587@bytedance.com> <a9d2ab1b-23a5-8c06-9f7a-6872c726db03@intel.com> <b5f2d527-8887-eb0b-d3f2-4e7cd8f3c022@intel.com>
 <4fb5f66d-c8c2-f857-7461-b974154dbc2b@bytedance.com> <20230605140344.66pwpdg5zgb6rfa7@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2023, Liam R. Howlett wrote:
> 
> You mean "mm: update validate_mm() to use vma iterator" here I guess.  I
> have it as a different commit id in my branch.
> 
> I 'restored' some of the checking because I was able to work around not
> having the mt_dump() definition with the vma iterator.  I'm now
> wondering how wide spread CONFIG_DEBUG_VM is used and if I should not
> have added these extra checks.

Most CONFIG_DEBUG_VM checks are quite cheap, mostly VM_BUG_ONs for
easily checked conditions.  If validate_mm() is still the kind of thing
it used to be, checking through every vma on every mmap operation, please
don't bring that into CONFIG_DEBUG_VM - it distorts performance too much,
so always used to be under a separate CONFIG_DEBUG_VM_RB instead.

Hugh
