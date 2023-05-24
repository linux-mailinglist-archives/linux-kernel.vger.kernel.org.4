Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1BB70F4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjEXK75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjEXK7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68873A3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684925945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RyOOthwCwKmK2k/rvH+STfuwWCIZAOvW3IUp8VzMxe8=;
        b=ZCKo7KzXnxM2Afq/SRCN6pk3FXzlmBjNDbptyJvbBj/YkLAf6HG7DVATFVCYUVZ0t/IA1e
        IP3MF7GOqlciYbslExhBdA5MSYQWvb8KmMjBsfjlKl5FsOg31i5jK/kxHL2rlAe8hzs7H8
        XOMN2wKiswwc2XQmRHFFjsboqE6HXF8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-JeqWbzBDMV6n-FsfwaWokw-1; Wed, 24 May 2023 06:59:04 -0400
X-MC-Unique: JeqWbzBDMV6n-FsfwaWokw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30932d15a30so438864f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684925943; x=1687517943;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RyOOthwCwKmK2k/rvH+STfuwWCIZAOvW3IUp8VzMxe8=;
        b=kj4G7xcl1EViRuP/mbmVj0g94HqXsZ5rGpJjLoSs177EwJiaj2UuDGiwsV+qjCabri
         AzEwgEc5V3VkIkrmZjYNKD6VFRfnyoallJMMlmfbhDhLqJxniKw530or4TDQYj6OO8HD
         iI5UuYK6DVPPuk8xDWFRf/JTu9s7LjKIPyzcYYVwwCxIn7abhsMi0UYWaEHq+geqin7N
         TassFpbkqyaM50zz5Q7mz1eoaysLP/G0cBwrj7cUmvSnQ+foqTmLFQglGHyUrsINzV+z
         eaNU+b5xEw0vgVSP8Mve3LwYUBVXtYEJCoiFTW/QZ9lYHk5Pd5eGTNJDZZr/F39ezcgJ
         LC+Q==
X-Gm-Message-State: AC+VfDwN8pOdxzxKe04zSh2W+o6HI3aJiuugKL7X/dOFWLpT/E2S2kVH
        eCVM7oVnujhvzZOl5zC1Nvhf+TxRkwVFON5lu90ZA4xEWJY6eEHTJW/1puqb93JCMRX9tpiP+GS
        Ch9rvlaG1MyJ5IqTJ7jfJrN1x
X-Received: by 2002:adf:fa8f:0:b0:309:3698:8011 with SMTP id h15-20020adffa8f000000b0030936988011mr12471434wrr.57.1684925942847;
        Wed, 24 May 2023 03:59:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5UaFWIVzBtnybp/B6RPa+rXR+XvsRSCgDzFFSi7zOXyojX3oHmwbpJBkn+4vaJyJI2ouLlKA==
X-Received: by 2002:adf:fa8f:0:b0:309:3698:8011 with SMTP id h15-20020adffa8f000000b0030936988011mr12471419wrr.57.1684925942608;
        Wed, 24 May 2023 03:59:02 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d484b000000b00307c0afc030sm14324322wrs.4.2023.05.24.03.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 03:59:02 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        linmiaohe@huawei.com
Subject: Re: [PATCH] sched/deadline: simplify dl_bw_cpus() using
 cpumask_weight_and()
In-Reply-To: <20230522115605.1238227-1-linmiaohe@huawei.com>
References: <20230522115605.1238227-1-linmiaohe@huawei.com>
Date:   Wed, 24 May 2023 11:59:00 +0100
Message-ID: <xhsmhv8giov0r.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/23 19:56, Miaohe Lin wrote:
> cpumask_weight_and() can be used to count of bits both in rd->span and
> cpu_active_mask. No functional change intended.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

