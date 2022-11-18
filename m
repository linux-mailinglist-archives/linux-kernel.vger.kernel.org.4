Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F5462F9BB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiKRPww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242437AbiKRPux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:50:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CB88B131
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668786594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f0l961mOiSvfsHXNC9b/4yL94fMPoEXmeS8Dl+sxaT8=;
        b=cDS+gEqgTxQyXDDO4CZ+fmuJpaM/7WR1lANsy0H2+N58OlaJmwZBBQGRzvoc8hUIKvwe/1
        EeapbLrIp5tp6sv09en8vdC3TcwEOVOm1E1G4X/Y4BwSjdkXMIe6Jq5zMrXtohRWwn8wfN
        M3sY02iXQVnBOVvOcjxbC01CQ70dn2Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-102-trLBXlhbN5-D4oMcLJIDlw-1; Fri, 18 Nov 2022 10:49:52 -0500
X-MC-Unique: trLBXlhbN5-D4oMcLJIDlw-1
Received: by mail-wm1-f70.google.com with SMTP id o5-20020a05600c510500b003cfca1a327fso2425901wms.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0l961mOiSvfsHXNC9b/4yL94fMPoEXmeS8Dl+sxaT8=;
        b=xo3aU5BM7qY2v5DftPOmg2M8qJbU+hdBAp2EzGtMc4dzBuxrUtHzLgAhewBGABbtKR
         3yvDM6hxKxLxzvH9f0/I3b8s+ZIVefkvmciQiQJfxN25Bo50OAY+WZWRj+NO2dzYIEES
         v+O5AJ/NDrFldswMbi1QOzEwQQtY0pyqLZam4aVh7J2L+op725EJroIw5fNTQkFtif2q
         q7pq0o2KXNZZjVkbHKLXsys8JAaaGNufeFtwSoG+Jf9MsXYmaUzLHNm3IgqjLsVQ7Iak
         agVyvZ1h8dnjo9og2TxI7d66X8QTCFmkvB36WK6iewxQpxUrdbYflwoxm3X84JoiSMcR
         B3Lw==
X-Gm-Message-State: ANoB5pmUkx1Va3TK5HDaPe9cEmQAn9trJ1VEMLsMbPXKX3DFBgWtQ982
        TJHkSm8UyLMw9i2rzhIvP5cK7iFc5rGpEEwRbcb91OjQTeMIwO6NHaArBzq0Ey7SPw+VLe20NOX
        ASri+nGhfERIOYAy9Tu+8oVkm
X-Received: by 2002:a5d:6746:0:b0:22e:39c9:a4a6 with SMTP id l6-20020a5d6746000000b0022e39c9a4a6mr4764198wrw.170.1668786591680;
        Fri, 18 Nov 2022 07:49:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5jlCG7seEl6CRYzUhjn7XrAab5Jm0ioGMACGL05tz5BA2MIRJoWKGbzbVbGzrZRpznzsvaHg==
X-Received: by 2002:a5d:6746:0:b0:22e:39c9:a4a6 with SMTP id l6-20020a5d6746000000b0022e39c9a4a6mr4764178wrw.170.1668786591405;
        Fri, 18 Nov 2022 07:49:51 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id f16-20020a5d50d0000000b00235da296623sm3807096wrt.31.2022.11.18.07.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 07:49:50 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, xingxin.hx@openanolis.org,
        baolin.wang@linux.alibaba.com, peternewman@google.com
Subject: Re: [PATCH 07/18] x86/resctrl: Move CLOSID/RMID matching and
 setting to use helpers
In-Reply-To: <20221021131204.5581-8-james.morse@arm.com>
References: <20221021131204.5581-1-james.morse@arm.com>
 <20221021131204.5581-8-james.morse@arm.com>
Date:   Fri, 18 Nov 2022 15:49:47 +0000
Message-ID: <xhsmh8rk8xnxg.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/22 13:11, James Morse wrote:
> When switching tasks, the CLOSID and RMID that the new task should
> use are stored in struct task_struct. For x86 the CLOSID known by resctrl,
> the value in task_struct, and the value written to the CPU register are
> all the same thing.
>
> MPAM's CPU interface has two different PARTID's one for data accesses
> the other for instruction fetch. Storing resctrl's CLOSID value in
> struct task_struct implies the arch code knows whether resctrl is using
> CDP.
>
> Move the matching and setting of the struct task_struct properties
> to use helpers. This allows arm64 to store the hardware format of
> the register, instead of having to convert it each time.
>
> __rdtgroup_move_task()s use of READ_ONCE()/WRITE_ONCE() ensures torn
> values aren't seen as another CPU may schedule the task being moved
> while the value is being changed. MPAM has an additional corner-case
> here as the PMG bits extend the PARTID space. If the scheduler sees a
> new-CLOSID but old-RMID, the task will dirty an RMID that the limbo code
> is not watching causing an inaccurate count. x86's RMID are independent
> values, so the limbo code will still be watching the old-RMID in this
> circumstance.
> To avoid this, arm64 needs both the CLOSID/RMID WRITE_ONCE()d together.
> Both values must be provided together.
>

I think I remember something about this... Is that about having them
union'd and read/written as one? (just for my own curiosity)

> Because MPAM's RMID values are not unique, the CLOSID must be provided
> when matching the RMID.
>
> CC: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

