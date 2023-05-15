Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9977040B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244742AbjEOWI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242789AbjEOWI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFD18A7B
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684188363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mJEVFLdRPcjN80hZWVkTiTXZUJ1+07IKEu73jeobqWc=;
        b=CiiSwhTflptjEBcLEbSNcxRj7RGU90dDNSGjeEyX/TYvAM4kbqE3jaB/r3JKxuRlCW/KO2
        WAhPrebDUhCZJdNnJuzX3HFPeXHmM03vAyzu/5l1Kwx77FgOP4rH/gy0MDO4KKlfQtkgaS
        M5ph4nlD4Gj+cSNvFAKFYwgMpls6kPw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-xSVJpvM3NsOi_V0dzNT-mg-1; Mon, 15 May 2023 18:06:01 -0400
X-MC-Unique: xSVJpvM3NsOi_V0dzNT-mg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-5ea572ef499so20939896d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684188361; x=1686780361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJEVFLdRPcjN80hZWVkTiTXZUJ1+07IKEu73jeobqWc=;
        b=kLzeLtUQAUYnGNfXvxC2bwOVxErcYSzdUhL8jLJbTcYZdIf2DlYMW0pOoD5xLEpMCj
         8Z/8zDFf1dP5Q9c7CLzP+j2fkTPjbq94H25MGw98PvgmgYYQGorccI75Vtd68NIWCmIB
         2JGR4cCfA0AyKNsH0rFnFenHdgl5GhEDTvCvnZEcRCaUYQzL5J0qgHZNYeqWrOeGqdbs
         E4V5hHxyqjb9lL83OQN2L/WRccX/UYK1ZINBUK1fZgsk7IkTPJ5ycHlC9dwDZhhC2zB+
         KV/uzH+6V3WwVsrJ3XWshhDvBNWpe2CBlhxiuyeAZn+8bDDk1PdkV9A/KyNX9YxdTKxE
         nD7A==
X-Gm-Message-State: AC+VfDymZxILf4uV2s+pweyJSjASN6knUTfkeEZz5ukGyOk0zNGWuZah
        LdpdPVscHszyBCq1fgnhtGHr/wu8wgpq1CJhFPoAtF45dorZ90DuGNWYqaLWn3L518RkJ4hVXGs
        PwSr/yxO9U5fRGpEwVjQ+criD
X-Received: by 2002:a05:6214:519a:b0:61b:76dd:b643 with SMTP id kl26-20020a056214519a00b0061b76ddb643mr16092578qvb.4.1684188361049;
        Mon, 15 May 2023 15:06:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76teqgNwGIs5CbjCMoSR//D+TAlaJxOvBjU3cu/IszWhxC8gqE0TLwrF6d15B3gUYbHtIY/A==
X-Received: by 2002:a05:6214:519a:b0:61b:76dd:b643 with SMTP id kl26-20020a056214519a00b0061b76ddb643mr16092547qvb.4.1684188360785;
        Mon, 15 May 2023 15:06:00 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id i7-20020a056214030700b006215f334a18sm3542109qvu.28.2023.05.15.15.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 15:06:00 -0700 (PDT)
Date:   Mon, 15 May 2023 18:05:58 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Zach O'Keefe <zokeefe@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: pagemap: restrict pagewalk to the requested range
Message-ID: <ZGKsxlVpcTRUFT6N@x1n>
References: <20230515172608.3558391-1-yuanchu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230515172608.3558391-1-yuanchu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 01:26:08AM +0800, Yuanchu Xie wrote:
> The pagewalk in pagemap_read reads one PTE past the end of the requested
> range, and stops when the buffer runs out of space. While it produces
> the right result, the extra read is unnecessary and less performant.
> 
> I timed the following command before and after this patch:
> 	dd count=100000 if=/proc/self/pagemap of=/dev/null
> The results are consistently within 0.001s across 5 runs.
> 
> Before:
> 100000+0 records in
> 100000+0 records out
> 51200000 bytes (51 MB) copied, 0.0763159 s, 671 MB/s
> 
> real    0m0.078s
> user    0m0.012s
> sys     0m0.065s
> 
> After:
> 100000+0 records in
> 100000+0 records out
> 51200000 bytes (51 MB) copied, 0.0487928 s, 1.0 GB/s
> 
> real    0m0.050s
> user    0m0.011s
> sys     0m0.039s
> 
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

