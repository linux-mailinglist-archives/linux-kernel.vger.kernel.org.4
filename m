Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413C8741C58
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 01:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF1XRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 19:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjF1XRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:17:53 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDC81FFB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:17:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6a084a34cso1052381fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687994269; x=1690586269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oM8+DBVW7RHSb20wzupU3eI3vgm5LTctM5Hspz2fXBo=;
        b=FnFtb0i32O/g4RUqUATBebmwVUGbf02elpj5724B5r/e51+mwYnWj1sOrpuzl9mQHI
         mwGPb4NiUJ3YWgKW/emmuF3oAbxLxt9eui1/CNxqLl0fjATlexgsV0r7HCd49Yi/JPBt
         96jTBza6202gulr02P+GT2pTynHNLhf/EnKf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687994269; x=1690586269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oM8+DBVW7RHSb20wzupU3eI3vgm5LTctM5Hspz2fXBo=;
        b=RxilfSt5dovWc99ylncDdR6Ic16eRg+Yw9u6KwSN3YA6AqURWY47Az8nA/SSnO4xUw
         gcDG9UTXBH6LntkyXD6hAb5obfoqFPWEeAdJep+2iv6qCibouXxqSTj4rJxyC6zsnnB5
         qUkcK5n2RncTC++qXmIYnvj79krwhk8ACwE7vADHoON/EhXrhKsN2feiNB2hPgEBxIp7
         56FDTruNGWqhigKdcX9o/pPRnxhiCwpuZTeinli6Gpc9mYC2Au1ol3S8ht5GR0bt0hOu
         mK/yEXJEUSKAa6aVXETps7kFnglQy/tFUJN1GwnkP0Q5LUikv8qMLMKT8nlT+EnLeL0m
         MeBg==
X-Gm-Message-State: AC+VfDzX4dIdCGYvCYTwXOD2Fp0Ua95fGClKeDMbh8F7fki1oHTvjZ5t
        bFTXmwqu1loAKL1zkY9eNIfNeo7Xn2OQHbXt2R3iJKsp
X-Google-Smtp-Source: ACHHUZ5nSCsxCNd/k0tHX7Htl77RL8xzI67diEoZ0+uXWSxsZvjhbEDgk10BWjTHvBDSqmok6LPuPQ==
X-Received: by 2002:a2e:7c09:0:b0:2b5:80c9:1266 with SMTP id x9-20020a2e7c09000000b002b580c91266mr17942725ljc.43.1687994269576;
        Wed, 28 Jun 2023 16:17:49 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id d7-20020a1709067f0700b009925cbafeaasm1500523ejr.100.2023.06.28.16.17.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 16:17:49 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-98e1b1d1698so8284266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:17:48 -0700 (PDT)
X-Received: by 2002:a19:380f:0:b0:4f8:4177:e087 with SMTP id
 f15-20020a19380f000000b004f84177e087mr20100079lfa.47.1687994248313; Wed, 28
 Jun 2023 16:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <ZHTCK2_1pF61yWIr@hovoldconsulting.com> <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org> <499e30cc-d015-8353-1364-50d17da58f47@redhat.com>
 <ZHd8bLPY4OQCb/Z5@bombadil.infradead.org> <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
 <ZHoTFDkPIgglW0sU@bombadil.infradead.org> <fa3f1a1f-edc6-f13b-cc84-f3264b03b0b1@redhat.com>
 <ZH38lpTHZ/RISC1v@bombadil.infradead.org> <ZH3/KVCHhX4D4yh9@bombadil.infradead.org>
 <ZJyBhv6yrAfYvMh5@bombadil.infradead.org> <CAHk-=wiSRTEOgiDA5qUTPGcw=Fbk9Ou2i97kfSBcj3pey3X=fQ@mail.gmail.com>
 <CAHk-=wgPz4Fj9M_h7sRSHAK9QeJiTFaYMWX3fDyZ-Bj41HftmA@mail.gmail.com>
In-Reply-To: <CAHk-=wgPz4Fj9M_h7sRSHAK9QeJiTFaYMWX3fDyZ-Bj41HftmA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jun 2023 16:17:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh80e=+_6UrHLdXMbJJ58Jz2YtMidc95HBT8raNy325nQ@mail.gmail.com>
Message-ID: <CAHk-=wh80e=+_6UrHLdXMbJJ58Jz2YtMidc95HBT8raNy325nQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, song@kernel.org,
        Johan Hovold <johan@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 at 15:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, since I clearly didn't communicate clearly that I was throwing
> the patch over to you, let me go and find it and just apply it myself.

Ok, I spent some time writing a better commit message for that change,
tried to make sure I got everybody's comments and Tested-by's sorted
out etc, and committed the end result.

I also did the actual module pull and your sysctl pull.

Can you please check that it all looks like you expected?

              Linus
