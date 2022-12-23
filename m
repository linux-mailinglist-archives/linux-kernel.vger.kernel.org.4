Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913E96552E9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiLWQnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiLWQnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:43:53 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401FD13DFD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:43:52 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g13so7698862lfv.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eTitOekDuo3LDxAbgs9DMgMITmyXa1apsqpqb9tpvA4=;
        b=YDZ+QC3ajRi287uTWq7UtytjZqIAAxgr0ZFbMut2vYqCMeL/PiRcAM7BoRDPOK4UCz
         7wt5kGmny/krnwgRBlae3Qe342cpzgi9SRzaoMwzDgcgk/pPr2D/bvm4XIZTD3lHNY2m
         xcGW8W1N5eUFSvdyCtakM/OJzAfJxEDkpntnrchRG2X/6mzhoMA7u1KW8rRm0NkxZHxR
         ogLSukr3YjJA2JeiUi9D3jjOuLaseqEuqzOpJT/vHDE31A6xXC0jVq0IPmyDhU0el1Nn
         wlwtw3TsfLJbhjVaGotk4XUsuLd2xauS8JncQ7A/+uru4vS87YKvkZCsdMkKycLi9TkG
         HpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTitOekDuo3LDxAbgs9DMgMITmyXa1apsqpqb9tpvA4=;
        b=40ovr2y+Oi7r7mFP+zNSATjzU0awGZfJjJEpC7t7pJKI+P6+4VAp26Di27UX5IjanX
         VPEQecujZjTriJMsymKGahbZFM2/hDQ0VYe0ay9Qe2O9oFo0Wa0I7BF59cAB3G69RHQF
         w0I8YIc9cGnfVccjcqChbCDGFSyMOjN4ALnKl4eNDYJS2YVlYj2QJvDSXCbiBov7Gx3M
         urXch/Ow4iJ1DKR9H53HM3LEYwIb+PxosKGq1DSAXmWYuuM2+0v7Tk8gjqxaFgc6ISHt
         Fnk2zcRgmX24Ud/qjqrni1cxnon88zHX4ojPs+ZIZigvfv99KDwWUyV3I7lko9YJCZiW
         hiYQ==
X-Gm-Message-State: AFqh2krS6KgHg5MUei/LALhNTyJqopXR0Ur765WbWyWhfmQIYAz70Mwg
        CoDKx7x7mbDKwYABTKLF8WA=
X-Google-Smtp-Source: AMrXdXsbCmOcL5tModruIP+ddl5ZOymjj797oP0QUjzCh4udJGnP0p8WNmXeyxpDkbDlWJ+fsTRpmw==
X-Received: by 2002:a05:6512:2828:b0:4b9:f5e5:8fbc with SMTP id cf40-20020a056512282800b004b9f5e58fbcmr3666477lfb.30.1671813830674;
        Fri, 23 Dec 2022 08:43:50 -0800 (PST)
Received: from pc636 (host-90-233-218-120.mobileonline.telia.com. [90.233.218.120])
        by smtp.gmail.com with ESMTPSA id r9-20020a056512102900b004a05767bc07sm584203lfr.28.2022.12.23.08.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 08:43:50 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 23 Dec 2022 17:43:47 +0100
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v3 1/3] mm: vmalloc: Avoid calling __find_vmap_area()
 twice in __vunmap()
Message-ID: <Y6XawyzTqaUBb2xJ@pc636>
References: <20221222190022.134380-1-urezki@gmail.com>
 <Y6Vkjr7DNEEv4MW5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6Vkjr7DNEEv4MW5@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 12:19:26AM -0800, Christoph Hellwig wrote:
> On Thu, Dec 22, 2022 at 08:00:20PM +0100, Uladzislau Rezki (Sony) wrote:
> > @@ -1825,9 +1825,8 @@ static void free_vmap_area_noflush(struct vmap_area *va)
> >  	unsigned long va_start = va->va_start;
> >  	unsigned long nr_lazy;
> >  
> > -	spin_lock(&vmap_area_lock);
> > -	unlink_va(va, &vmap_area_root);
> > -	spin_unlock(&vmap_area_lock);
> > +	if (WARN_ON_ONCE(!list_empty(&va->list)))
> > +		return;
> 
> I'd just drop this check as the function is not exported.
> 
>
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
Thanks!


--
Uladzislau Rezki
