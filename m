Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7463273768F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjFTVVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFTVVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:21:14 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7E6132
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:21:13 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-763bd31d223so26861485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1687296072; x=1689888072;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jcP/rm05RrInHETkeFjW0Eo/JiIhtFou4XrWSAd+wQ=;
        b=xVQxFtvINCiFD58bFiHYe1aaNqyDHDsRvXUtLyBCZQ4OLf5LG+wj4dz9IJT7bARDm8
         bndpbFIdIVhYMIXyn2vhnHPSX95zDd62o17nMugqLgSeM2YOobMUCCAS1Ip1HLcN+ESg
         nhyfiD/0m3FoPIOECqAJa4v472BYsAo6epunk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687296072; x=1689888072;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jcP/rm05RrInHETkeFjW0Eo/JiIhtFou4XrWSAd+wQ=;
        b=l9W2Ur5ANeK7UA9/L9zmqPRluXGkkdabV3RPUgnb4+zuXIVNMoCxP0RKc11W9VsnSK
         +X7XALFJoFPGMMp39qAQqS0EpIQZTY9WYDgY98BVXzrxdYJgwSYG5MVz72aL+JO8t0oO
         lDvpQMy+XeRrHu8ZAXDqxcGnhfrrAwkvNcUx4quDrg3PTazjWTOj5HR9/tuSX2HMjcpS
         ASGWHobqwCp0A1j5Zn/guUyy7uVpd2pO8jAiAiDjwS3EVc79yXjhkhK95SVQS6WKTJfh
         Jsxgd2YjPGtEaUbSbpBsVPMgpihO/Uj+ud/hQI9TyCVBNSJnaTOQjPcZWwQT+Pv3Pc4m
         FNbw==
X-Gm-Message-State: AC+VfDzrzLiJ9c3iOrflD3JkPqkecuAvljSH3MiWm7Fr64OW5wMIRzBF
        z9gAeWh3NEd3in1AwMeG6K4XQEHImy5vq+vGx9M=
X-Google-Smtp-Source: ACHHUZ4JrLF0b4oOsT9kMCPcCqgqzM5+OfFosKmIub96E+yaPuRpcx9m5LtP3kwYacB3vbBCwaTVGQ==
X-Received: by 2002:a05:620a:660a:b0:762:3a20:7719 with SMTP id qf10-20020a05620a660a00b007623a207719mr12345317qkn.18.1687296072551;
        Tue, 20 Jun 2023 14:21:12 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id l2-20020a37f502000000b0076087149a19sm1512897qkk.83.2023.06.20.14.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 14:21:11 -0700 (PDT)
Message-ID: <867bd9d6-1d00-0d9d-368a-8224cb40a505@joelfernandes.org>
Date:   Tue, 20 Jun 2023 17:21:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/7] mm/mremap: Optimize the start addresses in
 move_page_tables()
Content-Language: en-US
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
References: <20230531220807.2048037-1-joel@joelfernandes.org>
 <20230531220807.2048037-2-joel@joelfernandes.org>
 <f2f751ca-217e-4177-bb7f-1c9cd71e103e@lucifer.local>
 <b87df265-7e58-5907-e215-953630a87155@joelfernandes.org>
 <f28eadbc-f40e-4286-bf7e-af0ac360617e@lucifer.local>
 <e81b4534-54ce-466f-0d07-dc530cf137c2@joelfernandes.org>
In-Reply-To: <e81b4534-54ce-466f-0d07-dc530cf137c2@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/23 17:16, Joel Fernandes wrote:
> 
> Considering our discussion above that hugetlb mremap addresses should always 
> starts at a PMD boundary, maybe I can just add a warning to the if() like so to 
> detect any potential?
> 
>      if (is_vm_hugetlb_page(vma)) {
>          WARN_ON_ONCE(old_addr - old_end != len);

Oops, I meant WARN_ON_ONCE(old_end - old_addr != len);

to make sure we did not mess up hugetlb mremaps.

thanks,

  - Joel

