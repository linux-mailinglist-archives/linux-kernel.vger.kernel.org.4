Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34C65F35B9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJCSjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJCSjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:39:14 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D763ED6A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 11:39:12 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e129so10369916pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 11:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=G7bUMV+FEZy7kwIPvofvWVHEzM2JjGpJ/T9cn7FANKI=;
        b=DbL7LAsMn1ZPP3tNqgEAs3OQijAthjiTsME8iEq9bYxYCoSv0lX69AAmGW/K9A6j/q
         TMxBNDTbCnI8kpn+gp3mX8N+xIP0/vXpRvy2NYb976KpDaLB/bkmYwScsJ09vfjp9jgi
         P5XvS/Lge/4CLPDX9IZNvy8a9fJitWxxwmk0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=G7bUMV+FEZy7kwIPvofvWVHEzM2JjGpJ/T9cn7FANKI=;
        b=mK9HuK0JSle8Ouyp/iAsGcRmOIeST+l/OdyJNBO/7OAHns86uI6Z3U4OqYDVwsnMqy
         X/ZlWFOhiNJca7KSfvpI2ydbLliT5pWpGyzs1cmdvknEHE39ery/6OLg/FrOW2O3kjPj
         E6pt9+EvZQlhGtor+F3OaWTG6IiDni7Y0Ao4xPC3dt6Z8VP4hDA5fFJcWzkmui5PA4nc
         iERzQ4xju63hfW18yKPIR8pJONZsMvYc9vcSOHnbb+Fg8PG8VazqkfT//I0p8ZZ90snx
         7I774LhDVYoNe5NhmxX7x903fHkp75Hmeb19b7st74b417s/q4X9/90h4z6Ygf5u3UB1
         PbMw==
X-Gm-Message-State: ACrzQf3NXn10wrhixJXifywiqCgBByi6XYFDorvUS8uxmZ7tXc2/HqxH
        eA/MA0ermWTw3qcM8+Q6SxsEiw==
X-Google-Smtp-Source: AMsMyM7dhnU1K9hukcn95YVuWGVu5LA5Bt+XPOoY3OKL7aWIGI8OTGW3VT2EJsGjF80hrfyoCag0wQ==
X-Received: by 2002:a62:1482:0:b0:55f:eb9a:38b2 with SMTP id 124-20020a621482000000b0055feb9a38b2mr11535532pfu.29.1664822351896;
        Mon, 03 Oct 2022 11:39:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v62-20020a626141000000b0054097cb2da6sm7726006pfb.38.2022.10.03.11.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:39:11 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:39:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Subject: Re: [PATCH v2 22/39] mm: Don't allow write GUPs to shadow stack
 memory
Message-ID: <202210031134.B0B6B37@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-23-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-23-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:19PM -0700, Rick Edgecombe wrote:
> [...]
> Still allow FOLL_FORCE to write through shadow stack protections, as it
> does for read-only protections.

As I asked in the cover letter: why do we need to add this for shstk? It
was a mistake for general memory. :P

> [...]
> diff --git a/mm/gup.c b/mm/gup.c
> index 5abdaf487460..56da98f3335c 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1043,7 +1043,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>  		return -EFAULT;
>  
>  	if (write) {
> -		if (!(vm_flags & VM_WRITE)) {
> +		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
>  			if (!(gup_flags & FOLL_FORCE))
>  				return -EFAULT;
>  			/*

How about this instead:

  		return -EFAULT;
  
 	if (write) {
+		if (vm_flags & VM_SHADOW_STACK)
+			return -EFAULT;
 		if (!(vm_flags & VM_WRITE)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;


-- 
Kees Cook
