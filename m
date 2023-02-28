Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341B16A53C7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjB1Hhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjB1Hhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:37:34 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170EC10401
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:37:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c18so5727607wmr.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ7vpVmH2svpxStx0c+Rdq7n5k/ARjaIr92QsU/5uUc=;
        b=QWTHNrausIxVp8/ehT15syafvequ22Wpd53r6wRKrNBwnAmRI+wi8q4PcugZlhPHMt
         c8CAWebyQyNARnZ4/geUTZsv5TVF3OrIYbBw7URoVlb+sDelBOx3kYRJ2+t0q+cCxNoZ
         x0N8aEpTLm5RBjBY4lCEzTntj9pB+yf66gWttI6sQDZPFTRxB/J7IfcNme3oYQ5NMzv+
         htPloJSZUyFYMVZOAvGmKJxlu/Xel8FLnzdwuGm1LKOJy3dLVNw1lPfUdnVMo4v7WZ5L
         sfBQpBolR3Kg2NjMRn3qGgGEux1PcVfd7sjP4sAwpmbQefqJSXcpIe53bNy8daqW4h3B
         7VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ7vpVmH2svpxStx0c+Rdq7n5k/ARjaIr92QsU/5uUc=;
        b=PDCrVvjxLNNf0X53T98kv7XoG1QF6RZKHWr9Rs8VeEJCsPUp9t9Jy9ai9o0iA5E3Ec
         3ib1Ecd3QF49e9m1xDTe6/5h1fxlJn/cvknqyx6vcs6wEcjwYY9jllxUi/nbrxiHPVfK
         j8ZAoJJri/A+XxRf+a7h1Kj2BytbNOJXSy9/KCvnrGiFrgL2rjReoWAAQ/6pDFj3cw4T
         Bq8WcQGbizj/zl5NcZxujhCUwaIeLR13Yif1IHlqsv4YLE44lbD9drF3Q/tfS4pyWojn
         Ot3uUtM4s6R8a2W6/r0Eg2KNyrliC3JlU6wfbdoOJiFHUrmjTi3tvxaKzTX0QrCFkXqu
         J3ug==
X-Gm-Message-State: AO0yUKW+SMKC13vEK3IMui2ObSKY1hW2lZFN1NcjCqMbBsGFkvDqEwA5
        inB9racJ43PuOvdXk3Z6QSMyJA==
X-Google-Smtp-Source: AK7set+e33yEECDct6qvnW53UUqgcWZBrgj0LPbQ1yvkRyEvAYETNKX+NYpCBqGtSavtmE4nMrYb9g==
X-Received: by 2002:a05:600c:4da4:b0:3eb:3843:9f31 with SMTP id v36-20020a05600c4da400b003eb38439f31mr1343843wmp.10.1677569851530;
        Mon, 27 Feb 2023 23:37:31 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id s10-20020a1cf20a000000b003dfe5190376sm11315809wmc.35.2023.02.27.23.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 23:37:31 -0800 (PST)
Date:   Tue, 28 Feb 2023 08:37:25 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Message-ID: <20230228073725.m5t6rkcbgbi3g26z@orel>
References: <20230224120715.wgqnqmkadsbqusus@orel>
 <180fda36f9974809b436c52e4b3eda58@EXMBX066.cuchost.com>
 <20230227075942.rgl4hqnwttwvoroe@orel>
 <178ca008701147828d2e62402ff4f78a@EXMBX066.cuchost.com>
 <20230227114435.eow57ax5zhysz3kv@orel>
 <a6c319dd867f4f1d97e9d950b9e7c636@EXMBX066.cuchost.com>
 <20230228050457.zfbflfawctaccepv@orel>
 <803ac603023c4eeda4a0b8e414cce6f1@EXMBX066.cuchost.com>
 <20230228071845.k6s6bcnesdsnw3jl@orel>
 <abd16b950ca744b081fc9f545977b8fa@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abd16b950ca744b081fc9f545977b8fa@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 07:29:40AM +0000, JeeHeng Sia wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Jones <ajones@ventanamicro.com>
> > Sent: Tuesday, 28 February, 2023 3:19 PM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> > Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> > 
> > On Tue, Feb 28, 2023 at 05:33:32AM +0000, JeeHeng Sia wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Andrew Jones <ajones@ventanamicro.com>
> > > > Sent: Tuesday, 28 February, 2023 1:05 PM
> > > > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > > > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> > > > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> > > > Subject: Re: [PATCH v4 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> > > >
> > > > On Tue, Feb 28, 2023 at 01:32:53AM +0000, JeeHeng Sia wrote:
> > > > > > > > > 	load image;
> > > > > > > > > loop:	Create pbe chain, return error if failed;
> > > > > > > >
> > > > > > > > This loop pseudocode is incomplete. It's
> > > > > > > >
> > > > > > > > loop:
> > > > > > > >         if (swsusp_page_is_forbidden(page) && swsusp_page_is_free(page))
> > > > > > > > 	   return page_address(page);
> > > > > > > > 	Create pbe chain, return error if failed;
> > > > > > > > 	...
> > > > > > > >
> > > > > > > > which I pointed out explicitly in my last reply. Also, as I asked in my
> > > > > > > > last reply (and have been asking four times now, albeit less explicitly
> > > > > > > > the first two times), how do we know at least one PBE will be linked?
> > > > > > > 1 PBE correspond to 1 page, you shouldn't expect only 1 page is saved.
> > > > > >
> > > > > > I know PBEs correspond to pages. *Why* should I not expect only one page
> > > > > > is saved? Or, more importantly, why should I expect more than zero pages
> > > > > > are saved?
> > > > > >
> > > > > > Convincing answers might be because we *always* put the restore code in
> > > > > > pages which get added to the PBE list or that the original page tables
> > > > > > *always* get put in pages which get added to the PBE list. It's not very
> > > > > > convincing to simply *assume* that at least one random page will always
> > > > > > meet the PBE list criteria.
> > > > > >
> > > > > > > Hibernation core will do the calculation. If the PBEs (restore_pblist) linked successfully, the hibernated image will be restore
> > else
> > > > > > normal boot will take place.
> > > > > > > > Or, even more specifically this time, where is the proof that for each
> > > > > > > > hibernation resume, there exists some page such that
> > > > > > > > !swsusp_page_is_forbidden(page) or !swsusp_page_is_free(page) is true?
> > > > > > > forbidden_pages and free_pages are not contributed to the restore_pblist (as you already aware from the code). Infact, the
> > > > > > forbidden_pages and free_pages are not save into the disk.
> > > > > >
> > > > > > Exactly, so those pages are *not* going to contribute to the greater than
> > > > > > zero pages. What I've been asking for, from the beginning, is to know
> > > > > > which page(s) are known to *always* contribute to the list. Or, IOW, how
> > > > > > do you know the PBE list isn't empty, a.k.a restore_pblist isn't NULL?
> > > > > Well, this is keep going around in a circle, thought the answer is in the hibernation code. restore_pblist get the pointer from the
> > PBE,
> > > > and the PBE already checked for validity.
> > > >
> > > > It keeps going around in circles because you keep avoiding my question by
> > > > pointing out trivial linked list code. I'm not worried about the linked
> > > > list code being correct. My concern is that you're using a linked list
> > > > with an assumption that it is not empty. My question has been all along,
> > > > how do you know it's not empty?
> > > >
> > > > I'll change the way I ask this time. Please take a look at your PBE list
> > > > and let me know if there are PBEs on it that must be there on each
> > > > hibernation resume, e.g. the resume code page is there or whatever.
> > > >
> > > > > Can I suggest you to submit a patch to the hibernation core?
> > > >
> > > > Why? What's wrong with it?
> > > Kindly let me draw 2 scenarios for you. Option 1 is to add the restore_pblist checking to the hibernation core and option 2 is to add
> > restore_pblist checking to the arch solution
> > > Although I really don't think it is needed. But if you really wanted to add the checking, I would suggest to go with option 1. again, I
> > really think that it is not needed!
> > 
> > This entire email thread is because you've first coded, and now stated,
> > that you don't think the PBE list will ever be empty. And now, below, I
> > see you're proposing to return an error when the PBE list is empty, why?
> > If there's nothing in the PBE list, then there's nothing to do for it.
> > Why is that an error condition?
> > 
> > Please explain to me why you think the PBE list *must* not be empty
> > (which is what I've been asking for over and over). OIOW, are there
> > any pages you have in mind which the resume kernel always uses and
> > are also always going to end up in the suspend image? I don't know,
> > but I assume clean, file-backed pages do not get added to the suspend
> > image, which would rule out most kernel code pages. Also, many pages
> > written during boot (which is where the resume kernel is at resume time)
> > were no longer resident at hibernate time, so they won't be in the
> > suspend image either. While it's quite likely I'm missing something
> > obvious, I'd rather be told what that is than to assume the PBE list
> > will never be empty. Which is why I keep asking about it...
> The answer already in the Linux kernel hibernation core, do you need me to write a white paper to explain in detail or you need a conference call? 

I'm not sure why you don't just write a paragraph or two here in this
email thread explaining what "the answer" is. Anyway, feel free to
invite me to a call if you think it'd be easier to hash out that way.

Thanks,
drew

> > 
> > Thanks,
> > drew
> > 
> > >
> > > 	//Option 1
> > > 	//Pseudocode to illustrate the image loading
> > > 	initialize restore_pblist to null;
> > > 	initialize safe_pages_list to null;
> > > 	Allocate safe page list, return error if failed;
> > > 	load image;
> > > loop:	Create pbe chain, return error if failed;
> > > 	assign orig_addr and safe_page to pbe;
> > > 	link pbe to restore_pblist;
> > > 	/* Add checking here */
> > > 	return error if restore_pblist equal to null;
> > > 	return pbe to handle->buffer;
> > > 	check handle->buffer;
> > > 	goto loop if no error else return with error;
> > >
> > > 	//option 2
> > > 	//Pseudocode to illustrate the image loading
> > > 	initialize restore_pblist to null;
> > > 	initialize safe_pages_list to null;
> > > 	Allocate safe page list, return error if failed;
> > > 	load image;
> > > loop:	Create pbe chain, return error if failed;
> > > 	assign orig_addr and safe_page to pbe;
> > > 	link pbe to restore_pblist;
> > > 	return pbe to handle->buffer;
> > > 	check handle->buffer;
> > > 	goto loop if no error else return with error;
> > > 	everything works correctly, continue the rest of the operation
> > > 	invoke swsusp_arch_resume
> > >
> > > 	//@swsusp_arch_resume()
> > > loop2: return error if restore_pblist is null
> > > 	increment restore_pblist and goto loop2
> > > 	create temp_pg_table
> > > 	continue the rest of the resume operation
> > > >
> > > > Thanks,
> > > > drew
