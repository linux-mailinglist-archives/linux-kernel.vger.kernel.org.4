Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E1E6C45A2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjCVJGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCVJG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:06:28 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90AE5DCA6;
        Wed, 22 Mar 2023 02:06:22 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id g18so18146549ljl.3;
        Wed, 22 Mar 2023 02:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679475981;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B37GRcVLF1b1+pD+dUSBHo5HFxRZdJXBgKi6iaJTmuM=;
        b=UltHazn2sTziDGYHazVsxjJCYKirhJWuQ+bFybY/p3DyPON4HkSOiLQQTMeDuWDg6N
         zmaGQieryWnTc1FjetDjcs75C7nVxK8hkIHySF3pUIsp6FavsKnkmsi+B0H9HgCVvcIU
         8r2rBIT56mLC1icGbOT/vXfNsF96s973c/LAvsbjbXYPD7NLu0hVomDfSBVj3aVSnmuR
         SkdqaPKEp37BXvQGc7E7Csk39kDAe/xvQdfxHjKUk8+CCigk0H6z33ISxBbWEjuSgW9l
         pPdWfMg3mj74Lz5Jhx/thdi+22/B+BDJRunbxgEwr6BOCwYDZpPth3YOyxIduH2/l3NK
         XBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679475981;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B37GRcVLF1b1+pD+dUSBHo5HFxRZdJXBgKi6iaJTmuM=;
        b=Yv4o15Z0kEkM2ozZzL+OrBkhE/BJmxiRrW31QK469g4ArBUpqQZ2PnlS9jb0VYdA+C
         US54O4huYrvIq4e0czqCNlbIzgzDsQwalUVR/agr/dVUwaLEFchHgPC/wLVM9p6YFk6C
         /UQ4Ql2u6RhGVUCA86/Sr9AR5hGhmCPP2GoS+xT9BtNP5icsNkukPijpRN1CbZ+sRMr3
         oE/JU9IU4AIMU2/04tRoh/COHCIXIeJymzEp2sWYFae6y6KDQAdhTZYFtxMtIx/TXgnR
         R/Br7p3c1OvEKEy9JkTG0WLoclGn0ki+ko0NmNNymdYyg7PFVsI+IrDXyDU/KBc9YUkO
         BEvg==
X-Gm-Message-State: AO0yUKUkql48arlIOdjpiwTii9NfbwUrnsbbT5Ty8HCkyth9V4qvLYfI
        n1z1d9V9vEZsx/m686wUoUa1RaV5UhI=
X-Google-Smtp-Source: AK7set9zcMWn75el33gW5LDV9jaBRE1xysy0o4ZjMvJzfpOpDh45J/wSQZt7CpxTgr9mYQa81v+AUg==
X-Received: by 2002:a2e:9b4d:0:b0:29e:e9f6:3b99 with SMTP id o13-20020a2e9b4d000000b0029ee9f63b99mr1909106ljj.46.1679475981032;
        Wed, 22 Mar 2023 02:06:21 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.72.74])
        by smtp.gmail.com with ESMTPSA id i21-20020a2e8095000000b0029c92214148sm1324709ljg.73.2023.03.22.02.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 02:06:20 -0700 (PDT)
Subject: Re: [PATCH v2 08/14] mm: call {ptlock,pgtable}_cache_init() directly
 from mm_core_init()
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230321170513.2401534-1-rppt@kernel.org>
 <20230321170513.2401534-9-rppt@kernel.org>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <ff403707-a61b-8b87-4d8d-5aecaa574be3@gmail.com>
Date:   Wed, 22 Mar 2023 12:06:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230321170513.2401534-9-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 8:05 PM, Mike Rapoport wrote:

> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> and drop pgtable_init() as it has no real value and it's name is

   Its name.

> misleading.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
[...]

MBR, Sergey
