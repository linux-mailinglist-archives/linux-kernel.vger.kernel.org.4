Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1746E53D4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjDQV06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjDQV05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:26:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE5E3A82
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681766768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+iUdFnPPW5Cjo+Wv9uVErEgS8kkVkrl+5T7LT3zMOPQ=;
        b=BPKEmPTA6imjDbkb/AoPdNUrU+XLbfq7Lt/WM4E5HBo+3RR1GX5iCWN6ADAGKk2MCf368D
        HodOdxH1pTQgsXqYGYZ6wJkMdHXBW0WyiTh3G/UIxKPJBL2b1Y6OZrFL6tMrZNJ9dCAak0
        fMYyOlW/Gf7pMaRPC3AmZO6hdgpptkk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-qY6-dE2KOb6SvQDBRKbJsA-1; Mon, 17 Apr 2023 17:26:07 -0400
X-MC-Unique: qY6-dE2KOb6SvQDBRKbJsA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-5ef5fbe2cfaso6172336d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 14:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681766767; x=1684358767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iUdFnPPW5Cjo+Wv9uVErEgS8kkVkrl+5T7LT3zMOPQ=;
        b=G6+cf8yDJkCxHzCmu4vharKGABs1Ebkstb+RRVugzEg9VyyhO3d5HEv2ckOrgNavEX
         Qu+qqztHrXoSJIUXesSKcH12l67+8VAMRQ4zcArZBGhONjwwuiyn6m3xvOfDtTOkmjUz
         iZhPCQWGXHCyCZVeKJv0Omgmi8d0WAb0uRxsbWkXS7n8AXGopHj8OjsCAJQEG+nEJ4ty
         ILfYK3YifEE5jNz6kS+KJLm8ig1dhoP5dMWpBJl8wXi4HeX1My9q2Mw/c82bkbHcsRuF
         b9fJ6pTY1YC0WBcFIncF9hrr24rafc8o/cTllfODNQce9MVW0slqYRoW2bc+m5QvGmrh
         JNUg==
X-Gm-Message-State: AAQBX9dURrUjD+Gf//b/eKxCmOhWWAvYBEFNZr/FS78eDgVxmQeODvxG
        ZUH0xmCwyFEv9ysX+sHGIjH1lT7pcvm5+qtTBK26ja6POjrGfysPokLv5JIUyUYNiAUMEMCOE6U
        1smtI0fxPV07E/7yQdqYZtHV3
X-Received: by 2002:a05:6214:4114:b0:5a9:ab44:5fdf with SMTP id kc20-20020a056214411400b005a9ab445fdfmr17548928qvb.0.1681766767257;
        Mon, 17 Apr 2023 14:26:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350bvmfyActz0XucL8uBTGsMXoULXM+Q4SGkObq+luJMUHRHs+pm3taS35Ybk4Jlndg31eEXu4A==
X-Received: by 2002:a05:6214:4114:b0:5a9:ab44:5fdf with SMTP id kc20-20020a056214411400b005a9ab445fdfmr17548909qvb.0.1681766767032;
        Mon, 17 Apr 2023 14:26:07 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id dw17-20020a0562140a1100b005dd8b9345cesm3274332qvb.102.2023.04.17.14.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 14:26:06 -0700 (PDT)
Date:   Mon, 17 Apr 2023 17:26:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page
 fault handler retries
Message-ID: <ZD25bBPbZYSb7grA@x1n>
References: <20230415000818.1955007-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230415000818.1955007-1-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 05:08:18PM -0700, Suren Baghdasaryan wrote:
> @@ -5223,8 +5230,8 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  		if (task_in_memcg_oom(current) && !(ret & VM_FAULT_OOM))
>  			mem_cgroup_oom_synchronize(false);
>  	}
> -
> -	mm_account_fault(regs, address, flags, ret);
> +out:
> +	mm_account_fault(mm, regs, address, flags, ret);

Ah, one more question.. can this cached mm race with a destroying mm (just
like the vma race we wanted to avoid)?  Still a question only applies to
COMPLETE case when mmap read lock can be released.  Thanks,

>  
>  	return ret;
>  }

-- 
Peter Xu

