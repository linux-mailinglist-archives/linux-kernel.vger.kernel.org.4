Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C230671388
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjARGB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjARF5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 00:57:41 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2989EC8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 21:56:38 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 7-20020a17090a098700b002298931e366so1132198pjo.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 21:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LhlR+hPYyUurHWkbpxrUfFZm8eX14qkXhreB4Z6yMig=;
        b=XfLbG1xZL4EZLFZTy58zuiNH52eGCvzSqxO5KJyOobEc3Y4LxqeDHa6hg31tr1ytNh
         cLy6bd1lsUBVW5ANwI4kxY64vl8YzAjabRK1psgv4aC6Ma/eeu2At9PaJjMQ7iNHvPaL
         CnMFz0t5RTIdfH5/LH4DRp515KAXYQrtl7YdCbPF+sTTb+x//M2FGQJYZ2JYwNscJcyu
         HlY5F6TriT/KmA2+x+9rlPMlI+WDbNOEGxCWVWgn5Tc6JSNvBIRhc5a66Dud/XoByqFt
         YTrq3vSDhb8YJzQ5CagJEuEdcqbPGRgXcZcKOhOfwHOcwutVKQeYmvIjus46w6Gg7sWo
         c9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhlR+hPYyUurHWkbpxrUfFZm8eX14qkXhreB4Z6yMig=;
        b=eAnLpu1J5Zd5Ef9fYKuR432nCr80bKJgdDKVREG3yZ7U/tHw5eWHgdy9KSg8N0SIDz
         Ni62qr3/Oc8eQUpTwpAQ8HOvRMcmQ0/AyRPPa28RLmcnR+9haH4gsaDTHWwU9/yVpXEO
         WBQA4DnKeJ8IOmt/C3Oa4ZEL8Okd2BOBHO3Nw0+BgsPtb5SeeuYVrbmrEClIW5ur5u5j
         bZTIfxUB7a/DLeWMFoTRTNQU1PdDStTReH6fU/87xwPnfXmQmuTOeJgxMvCWUZp84dl8
         3dc3uOs/pRpqrYCu5IavOrKqyg2gOz9Eso9pHxT8VE4Iyy+Fom9z5x9RQV+kmkSpqSmj
         Zvog==
X-Gm-Message-State: AFqh2koQDfMkza+LgvCmaP41XUcVdmNcRxkvFZvAcw9S+Nx8GNaArHEZ
        FKtJxoGSvqYpAzhdmjXbHYWmyPvOkUOlnbv9
X-Google-Smtp-Source: AMrXdXtRkj4b/2S6i/McOAhb95+DUW52aqowC5BjwP72VASQbD7fAynY0yZIEEJvmkz4D90uKUNzLA==
X-Received: by 2002:a05:6a20:c183:b0:b8:ca86:f3ab with SMTP id bg3-20020a056a20c18300b000b8ca86f3abmr515953pzb.2.1674021398256;
        Tue, 17 Jan 2023 21:56:38 -0800 (PST)
Received: from [2620:15c:29:203:8fea:734b:d1f:d2d7] ([2620:15c:29:203:8fea:734b:d1f:d2d7])
        by smtp.gmail.com with ESMTPSA id e9-20020aa79809000000b0058d9058fe8asm6075611pfl.103.2023.01.17.21.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 21:56:37 -0800 (PST)
Date:   Tue, 17 Jan 2023 21:56:36 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
cc:     rppt@kernel.org, akpm@linux-foundation.org, mhocko@suse.com,
        vbabka@suse.cz, david@redhat.com, quic_charante@quicinc.com,
        lizhe.67@bytedance.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] mm/page_ext: Do not allocate space for page_ext->flags
 if not needed
In-Reply-To: <20230117202103.1412449-1-pasha.tatashin@soleen.com>
Message-ID: <59557eaf-7301-d142-4549-c3e196d011d5@google.com>
References: <20230117202103.1412449-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023, Pasha Tatashin wrote:

> There is 8 byte page_ext->flags field allocated per page whenever
> CONFIG_PAGE_EXTENSION is enabled. However, not every user of page_ext
> uses flags. Therefore, check whether flags is needed at least by one
> user and if so allocate space for it.
> 
> For example when page_table_check is enabled, on a machine with 128G
> of memory before the fix:
> 
> [    2.244288] allocated 536870912 bytes of page_ext
> after the fix:
> [    2.160154] allocated 268435456 bytes of page_ext
> 
> Also, add a kernel-doc comment before page_ext_operations that describes
> the fields, and remove check if need() is set, as that is now a required
> field.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: David Rientjes <rientjes@google.com>
