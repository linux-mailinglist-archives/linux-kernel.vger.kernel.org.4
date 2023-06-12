Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B925272D36B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbjFLVgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjFLVgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:36:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC3790
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686605750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NkQV10oF5ZntpZuW0m7Oa1esdGwRfz9LHsmhKjiKPeQ=;
        b=INXhRbSzs5T/AHBkAwHqLyVppT/dfkCo6u1SOW5ONuQObQhUXe4+6SNjJy/nCZSdnWhURb
        ApzWg03lj3rfQsUDcPKCs3W8Wpnk5J9t7EValJQNOVzG58zLhLoqlyeiR7f2Rkr4oKoSPY
        wNEKoKXOuZbqZOIQvKoMMyIduBFddQs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-VdxBLHlvNsqu4D4i2b8STQ-1; Mon, 12 Jun 2023 17:35:49 -0400
X-MC-Unique: VdxBLHlvNsqu4D4i2b8STQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62dd79f63e0so2256356d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686605748; x=1689197748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkQV10oF5ZntpZuW0m7Oa1esdGwRfz9LHsmhKjiKPeQ=;
        b=ZJTIGW0TnoXXshyq4ELgXTNUgkEh80IduVO7vMYw5QwgezUYLuxGp78PNXf6h4j1Oj
         FLeIqUBxBifXKL91As3XEryNqeBEZDH1HZpU4p6Kssdmk807156I4rkKWhR7d6cnnzER
         2gbDb+2m0tgMrHi7dl1f9xIbV/OVpS+coR3f2S0FXEx7+AtimL08qn3jzYMj9TC+/Si/
         RAnsCqWmm54zzuRb3yQTSt0I9zK/37RxMZVGUD382rZMKKn8gRSUWNtdrB0kOpt0yORA
         N5OmKk8OSMNuJS8HurlV4wC5WdAR98OZIOZmvebyRkk3a9xzbZ8e+ZXmfOTjgI/S53oI
         Sw5A==
X-Gm-Message-State: AC+VfDxXV00t/awtIYYinCgaOjJ1GjoCrA/OEMHqa+TEIJfd3uudlju5
        p2i0czjTBCXLx24HLMkQWLHfPB/3V40jBLCIX20a9S7SU+YRy+kRswaN0TniEhl8Wx1sdgzfZwy
        0EF8T41TtfbiMD9pEBm1ev/6/Lc44tUJm
X-Received: by 2002:ad4:5aea:0:b0:62b:5410:322d with SMTP id c10-20020ad45aea000000b0062b5410322dmr13260516qvh.6.1686605748591;
        Mon, 12 Jun 2023 14:35:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4hVxn8A37sq0YOY66NVF97sTSXxB2Qm4jGFSmtl+98Zfmt7cWhpbXFa6YFA2pqBxvxrtSgaA==
X-Received: by 2002:ad4:5aea:0:b0:62b:5410:322d with SMTP id c10-20020ad45aea000000b0062b5410322dmr13260505qvh.6.1686605748392;
        Mon, 12 Jun 2023 14:35:48 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id x4-20020a0cda04000000b0062df4144a4bsm246507qvj.56.2023.06.12.14.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:35:47 -0700 (PDT)
Date:   Mon, 12 Jun 2023 17:35:46 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH] mm/hugetlb: Fix pgtable lock on pmd sharing
Message-ID: <ZIePspc+wgNeR0/H@x1n>
References: <20230612160420.809818-1-peterx@redhat.com>
 <20230612204418.GD3704@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230612204418.GD3704@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mike!

On Mon, Jun 12, 2023 at 01:44:18PM -0700, Mike Kravetz wrote:
> Agree with this change.  But, it does make one wonder if the pud_clear()
> in huge_pmd_unshare is safe.  Like here, we really should be holding the
> higher level lock but are holding the PMD lock.

The vma write lock?  My memory tells me that you worked on the vma lock and
one major reason was for that, but maybe I missed something?

I did check again and all call sites should have that lock held, which
looks fine here.  One thing worth mention is pmd unshare should also always
be gup-fast-safe because it never really releases the pgtable, unlike thp
collapse.

-- 
Peter Xu

