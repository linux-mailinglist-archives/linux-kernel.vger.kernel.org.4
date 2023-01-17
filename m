Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B2966DC13
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbjAQLQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbjAQLQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:16:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D43725E3A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673954074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZ99tWIQfiVtOBhXs6iRfqQWLkG99GmDtKwZHwV3+6A=;
        b=GccErK2y+dbFIT6pPhSx7a7ERElTmsvpl/Q2RKXBEBpIBHlMbqXlRbxufZXmFDgoIRPlCN
        NeoXmpGyoM4zh7s6i5ZfGPU5D3rrhIMMDc/cEBlvgdZTyPXkQMOgXq62yI71/F/VXP89CL
        7e6k4ehLVKuoFyVpmrMn/O6YpV4OUmk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-370-k7to8NMyO1KGtKCIbMVMVA-1; Tue, 17 Jan 2023 06:14:33 -0500
X-MC-Unique: k7to8NMyO1KGtKCIbMVMVA-1
Received: by mail-wm1-f72.google.com with SMTP id fm17-20020a05600c0c1100b003d96f0a7f2eso19888111wmb.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZ99tWIQfiVtOBhXs6iRfqQWLkG99GmDtKwZHwV3+6A=;
        b=ndW0avni4Fl2g6GqhNwp+ok5jK3iF7hzAuY4lBCjAA3Y20K3VrAmvB2on6O0CTwRAi
         VUb2t1TbTSkez3T9SB+5Pc+dWTJ3imOF5EKIgGfOZRBVIJQ4cZwEs7XNqXn5ZHsVveXC
         QfTjfo4BSwGEIKhWnijapUQQE821RMW95ssIUNXGx8xXS0vTV60eRnOcNIbd8Z9zlWQ+
         98ToQ/9wQSndTCnjO5V1imXhcoBw/Zdekt2o+CdPrIou/zJVGuaIrW6i5zuTWmaN0VQ8
         8UUhMze41rewIr5zcpkQDQLnIoqaS/dazOoNciTNfjBPngyr+DRl2rD9bdwxeAclv8ag
         Buxg==
X-Gm-Message-State: AFqh2kp+8mDs8MqNP/J1iGGJ+NpkBEw192x36V0Rz6oDbxxkZDMpIvE4
        10/R6XSrRue5U2uQMpvsV4e1EOgRxFpESAC8nKS5VIzNAp5vRVbxweST7TyyRksAyfaFGE9laTX
        /f9LbDFdww0s0XMFtC+STBm0Q
X-Received: by 2002:a05:600c:1604:b0:3c6:e61e:ae74 with SMTP id m4-20020a05600c160400b003c6e61eae74mr2727338wmn.4.1673954072039;
        Tue, 17 Jan 2023 03:14:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXujcYUwdW4dfyBijkjHTTqNZxJZzlbVppyFUeXexBHyixLVwkcHsQAv5xOwBAruMCrX37Bpdg==
X-Received: by 2002:a05:600c:1604:b0:3c6:e61e:ae74 with SMTP id m4-20020a05600c160400b003c6e61eae74mr2727314wmn.4.1673954071761;
        Tue, 17 Jan 2023 03:14:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:f00:323e:5956:8da1:9237? (p200300cbc7080f00323e59568da19237.dip0.t-ipconnect.de. [2003:cb:c708:f00:323e:5956:8da1:9237])
        by smtp.gmail.com with ESMTPSA id s7-20020a1cf207000000b003d98438a43asm34758449wmc.34.2023.01.17.03.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 03:14:31 -0800 (PST)
Message-ID: <4ac11b6a-284c-c763-f3c6-45a53c272f47@redhat.com>
Date:   Tue, 17 Jan 2023 12:14:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V1 1/1] sched/numa: Enhance vma scanning logic
Content-Language: en-US
To:     Raghavendra K T <raghavendra.kt@amd.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Peter Xu <peterx@redhat.com>, xu xin <cgel.zte@gmail.com>,
        Yu Zhao <yuzhao@google.com>, Colin Cross <ccross@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Hugh Dickins <hughd@google.com>,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
References: <cover.1673610485.git.raghavendra.kt@amd.com>
 <67bf778d592c39d02444825c416c2ed11d2ef4b2.1673610485.git.raghavendra.kt@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <67bf778d592c39d02444825c416c2ed11d2ef4b2.1673610485.git.raghavendra.kt@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.01.23 03:25, Raghavendra K T wrote:
>   During the Numa scanning make sure only relevant vmas of the
> tasks are scanned.
> 
> Logic:
> 1) For the first two time allow unconditional scanning of vmas
> 2) Store recent 4 unique tasks (last 8bits of PIDs) accessed the vma.
>    False negetives in case of collison should be fine here.
> 3) If more than 4 pids exist assume task indeed accessed vma to
>   to avoid false negetives
> 
> Co-developed-by: Bharata B Rao <bharata@amd.com>
> (initial patch to store pid information)
> 
> Suggested-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Bharata B Rao <bharata@amd.com>
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
>   include/linux/mm_types.h |  2 ++
>   kernel/sched/fair.c      | 32 ++++++++++++++++++++++++++++++++
>   mm/memory.c              | 21 +++++++++++++++++++++
>   3 files changed, 55 insertions(+)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 500e536796ca..07feae37b8e6 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -506,6 +506,8 @@ struct vm_area_struct {
>   	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
>   #endif
>   	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> +	unsigned int accessing_pids;
> +	int next_pid_slot;
>   } __randomize_layout;

What immediately jumps at me is the unconditional grow of a VMA by 8 
bytes. A process with 64k mappings consumes 512 KiB more of memory, 
possibly completely unnecessarily.

This at least needs to be fenced by CONFIG_NUMA_BALANCING.

-- 
Thanks,

David / dhildenb

