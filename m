Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388AF707702
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjERAjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjERAjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA67B30C8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684370339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YL4VRHTTTP5ymMEYgQSrzIpXej5X99LgoW1v1ye3Zo=;
        b=Wqbnx7kAus3cyNZY2qtkbydf2GDi0c9pUMCaGiAO/XFO1ZOrtmx/q12gkDpLeQIlfpTtfj
        0AidY7BNKRz7Dqcu8pTuDfYVnNQOGTFXwiUXf6pQdZHVNgSe5fbqKDz8gK2vQMs60gNF26
        1EO9jEizTXvB10zSqZlSxhk1kUlfh3g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-Etr3ADirMnmvkUeJGEwywQ-1; Wed, 17 May 2023 20:38:58 -0400
X-MC-Unique: Etr3ADirMnmvkUeJGEwywQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f398a25be2so563851cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684370338; x=1686962338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YL4VRHTTTP5ymMEYgQSrzIpXej5X99LgoW1v1ye3Zo=;
        b=LJaCbAgOiMuUpMjFrNhKHD5U7CR6wQgcOjL7dJQHHTls7jFHMNw9Mb9XvvWphd/Bwv
         UMwaVAh/sLJM8v/+V0WkCq1ChkrxBajZwK6zGE6Nao9yPYqLCacG6+rhe9E2VLeeHCv5
         1J/3cXtyHA+fVlCouKKi+gDAilDHiakm2qQ2Whd/+jaYGy1tkBOweAFCqjo9hMpOY3nP
         9E+3EvDLCgD9IvgAF/n0XgH5Nx4pKX8tloDSZc+1FwchrlTJoMFPbLH7eAgucMz8ECq4
         D/869C+Lc2+AzH7fzLORR0MXg5/5qUT+yUtm0Ijq+8rOEapEsddByfJOAgOJT/VxUUrX
         oFJw==
X-Gm-Message-State: AC+VfDxu5wpuOSApEFOl3J/evt2EQfQROnvzht4concFWjhb3564eG0i
        SeuSCZbrXHqpEwae+fvb2IXUcqSga+Sn/9ZqZ33Feh+PO8rZj5ath/+n+fY9//dbCHvq68S7pCk
        awDYoo4Jnr9lRfILY/p/PVtjg
X-Received: by 2002:a05:622a:8f:b0:3f2:38d:5c84 with SMTP id o15-20020a05622a008f00b003f2038d5c84mr8822018qtw.4.1684370338063;
        Wed, 17 May 2023 17:38:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xEBvgfLNxrHvwCcc4+e+3bU8VzdS24qg4PYgcL2vQQ97RhLwMyNNEDb++wV/iW7UOoIUE2Q==
X-Received: by 2002:a05:622a:8f:b0:3f2:38d:5c84 with SMTP id o15-20020a05622a008f00b003f2038d5c84mr8821999qtw.4.1684370337824;
        Wed, 17 May 2023 17:38:57 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id j17-20020a05620a147100b0075934be7618sm40063qkl.71.2023.05.17.17.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 17:38:57 -0700 (PDT)
Date:   Wed, 17 May 2023 20:38:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] mm: userfaultfd: avoid passing an invalid range to
 vma_merge()
Message-ID: <ZGVzoMBTq85xg1Hx@x1n>
References: <20230515193232.67552-1-lstoakes@gmail.com>
 <ZGKjvceDfpKMxtfb@x1n>
 <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
 <20abea10-5307-498b-b9df-8f0b2fed1701@lucifer.local>
 <ZGOcAOFOjx3XPGqO@x1n>
 <20230516164907.5bf2qe7nn5bo7iaa@revolver>
 <ZGPjlVOV5R7x4CV7@x1n>
 <20230516225251.xwmz2oyebo7k56ys@revolver>
 <ZGTbp9LLNYG4ILXk@x1n>
 <20230517225142.xbchqdmp6ma5wzkg@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517225142.xbchqdmp6ma5wzkg@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 06:51:42PM -0400, Liam R. Howlett wrote:
> > Yes, IIUC that's what we want because vma_merge() just handles everything
> > there (including split, or say, vma range adjustments) if any !NULL
> > returned.
> 
> I don't get your use of split here. __vma_adjust() used to be used by
> split, but it never split a VMA.  vma_merge() is not used by split at
> all.

I guess maybe I just made it confusing somehow when using "split" here..

I meant the vma range adjustments when vma_merge(), so indeed it's not
really a split, but it's still a logical split to me.

To be explicit, taking example of the uffd unregister case that was
essentially case 4, where part of PPPP will be "split" out and merged with
NNNN:

        ****
        PPPPPPNNNNNN
        might become
        PPNNNNNNNNNN
        case 4 below

        if (prev && addr < prev->vm_end) {	/* case 4 */
                vma_end = addr;
                adjust = next;
                adj_start = -(prev->vm_end - addr);
                err = dup_anon_vma(next, prev);
                ...
        } 

PPPP is adjusted here (where I was trying to refer as a "split", because
vma_end is less than before so part of PPPP is cut out):

	vma->vm_start = vma_start;
	vma->vm_end = vma_end;
	vma->vm_pgoff = vma_pgoff;

NNNN adjusted here (where the "split" part merged into NNNN):

	if (adj_start) {
		adjust->vm_start += adj_start;
		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
                ...
	}

I'll remember to stop using the word "split" in these cases in the future
to avoid confusion.

Thanks,

-- 
Peter Xu

