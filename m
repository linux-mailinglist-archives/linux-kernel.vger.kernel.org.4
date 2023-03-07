Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F436ADB7E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCGKLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCGKLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:11:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC7C5504F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678183830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YnH613TPa+ha+v7p8FxCuhYnqAF6ByvqtyivAaHKTO4=;
        b=AIhznB0sEQ59Wy+/DZG5dHtd+9sRuSTfXGl3jIwO6GuLlwQ+HZ/3CPx5aLOEcqG+qVAvSj
        HVZYNYWGu912ysSzM2PVakl7Z8Qf3EW6i+lXhuczWpCZG/XrZwNT7aWN8JdNbYXReONOIq
        /qMAEgoRhFn7ZwEgdAe2+GRR5GCNKlg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-otaLYVs8MFigZgHJ0TNzBA-1; Tue, 07 Mar 2023 05:10:26 -0500
X-MC-Unique: otaLYVs8MFigZgHJ0TNzBA-1
Received: by mail-wm1-f70.google.com with SMTP id r7-20020a05600c35c700b003eb3f2c4fb4so4785403wmq.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 02:10:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678183825;
        h=content-transfer-encoding:in-reply-to:organization:from:cc
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YnH613TPa+ha+v7p8FxCuhYnqAF6ByvqtyivAaHKTO4=;
        b=Ajs1tncyo6y3nvsdNCRf+vrUCTeyjk2UfuOrKETz90rCW3PFJyOkjuORv+wQbhu8KK
         bg54tfw8JjPkqfllWujHx46pdxjXut0ceYESP93DtSPAbgOpx8+6mk1VmJFcmqEyfd9S
         DyczNC+RWagusuNrpA2Yq0Pb6bx3fYCJXDCPUwFjcI6B4X2mgUgQngI6ujIu2VsL54xM
         EgFG5p/O338uU6aDjGrb4DQlaQ7SgywR15GZCcGEOnHL8vehOktpGMVkTzNTqAmWbxDW
         EuCbrEAL3/Pq5zFkKcK2G9qXfWfQCog7sjdiOIci2frK9ED8AsJAStM7F2Q+PWZYaM33
         Ll0A==
X-Gm-Message-State: AO0yUKXa3XFgQyKTQNzZYJBUfGEC0K9OvKOe6RWW9uHT+9rsa8uGN+Ep
        4dR7nkQvWdcfsFpmxHqNrE9U6i4iileNM4R24Sgrhbd6oT5Qlx0Y3ap3PZuxTPeKBdLH8uNlyxi
        C2R2yuJVoT8dhVHDRz0S+l6/o
X-Received: by 2002:adf:f584:0:b0:2c9:b3a9:b080 with SMTP id f4-20020adff584000000b002c9b3a9b080mr9786978wro.16.1678183825500;
        Tue, 07 Mar 2023 02:10:25 -0800 (PST)
X-Google-Smtp-Source: AK7set8gaN0xfQX1mKqKS4oeq8DdWD7u+c+KKVNg83fzXXuWZmaIMjQB3ZvBePhINyRg2ZpgeFrZ5A==
X-Received: by 2002:adf:f584:0:b0:2c9:b3a9:b080 with SMTP id f4-20020adff584000000b002c9b3a9b080mr9786966wro.16.1678183825156;
        Tue, 07 Mar 2023 02:10:25 -0800 (PST)
Received: from [192.168.3.108] (p5b0c626a.dip0.t-ipconnect.de. [91.12.98.106])
        by smtp.gmail.com with ESMTPSA id n1-20020adffe01000000b002c4084d3472sm12381283wrr.58.2023.03.07.02.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 02:10:24 -0800 (PST)
Message-ID: <278ec047-4c5d-ab71-de36-094dbed4067c@redhat.com>
Date:   Tue, 7 Mar 2023 11:10:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: THP backed thread stacks
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230306235730.GA31451@monkey>
Cc:     Rik van Riel <riel@surriel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230306235730.GA31451@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.23 00:57, Mike Kravetz wrote:
> One of our product teams recently experienced 'memory bloat' in their
> environment.  The application in this environment is the JVM which
> creates hundreds of threads.  Threads are ultimately created via
> pthread_create which also creates the thread stacks.  pthread attributes
> are modified so that stacks are 2MB in size.  It just so happens that
> due to allocation patterns, all their stacks are at 2MB boundaries.

Is this also related to a recent change, where we try to always align at 
PMD boundaries now, such that this gets more likely?

commit f35b5d7d676e59e401690b678cd3cfec5e785c23
Author: Rik van Riel <riel@surriel.com>
Date:   Tue Aug 9 14:24:57 2022 -0400

     mm: align larger anonymous mappings on THP boundaries


As a side note, I even heard of complains about memory bloat when 
switching from 4k -> 64k page size with many threads ...

-- 
Thanks,

David / dhildenb

