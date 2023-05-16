Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A3F705ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjEPWwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEPWwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5501730E6
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684277517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ocX88koyMSL3z5d7fsei+K4lRNspfTzWujaeY63o7N0=;
        b=hQm8KctNmCvuEJxq/sezFs4SbEqNDIQlNFuAIyfhqdpyhd+cW0QhcoJkpP9Pduk2V5v6ox
        rNep23/Gh6ZKBrC1vwUJT1/48Fq8fdB8kWmImWQGFbxCxEVUDyq1GvrWB32EMD9aa9d7LZ
        1qJZhkEzi8Jo68z5H3TrIe9Zwp2rNTA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-nn2C1JdNOTqVj8nhywhxJg-1; Tue, 16 May 2023 18:51:56 -0400
X-MC-Unique: nn2C1JdNOTqVj8nhywhxJg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-61a3c7657aeso207826d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684277516; x=1686869516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocX88koyMSL3z5d7fsei+K4lRNspfTzWujaeY63o7N0=;
        b=IMKL8E7Sl31+5TXxdYRV2eukC2NN7HxJZVGrpkU8K7V4OO//nH4UEa1bR9NvUXdc3+
         38/p66wA/wiXmjyarbVFM20AEkDVtTbvvV5dPWY5s2HnFjkKG+ZG9LJzQJ6xoUV6HptP
         9bM/hmE/QXrYZTSkquJep3kKtBQCJXeqcdlDRBXd9x9Rk4Uti2AeBD6swYblRT1/C1q3
         qO0ShOhofY72jVvdOLd93cbkanw9JFvVDq+sPvYXbkj70XEqiM6Gz4XRXzMCskRpZhkv
         Ui/8fNVASUJOpAeyYYPyVi5pCpoYAIKwNvOGDZPK1lu4bNmBpLXZSRGiml7WZHTeIZ+P
         r+XA==
X-Gm-Message-State: AC+VfDzNj3WAiEX3kYqnvbODPo9j/RYF5BDOS9/s60xZUndCLYq7L43Z
        1lpaqhaurhx6exZdYo8PWfIALj7UxU+wT6qwPWdAp23pYxRQ/w9S3xtbJf0OV4s/u1stfxT7S7V
        aEItJR3Mze/VRdNzqCItdVcQ+
X-Received: by 2002:ad4:5be3:0:b0:616:870c:96b8 with SMTP id k3-20020ad45be3000000b00616870c96b8mr1815070qvc.3.1684277515797;
        Tue, 16 May 2023 15:51:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4W+OsHHwadVHAQI27/YuV9okTcG5IrJCEEa6o+76pChN+xoosvW2qEb8jS9fDuX2W4piGx5Q==
X-Received: by 2002:ad4:5be3:0:b0:616:870c:96b8 with SMTP id k3-20020ad45be3000000b00616870c96b8mr1815052qvc.3.1684277515544;
        Tue, 16 May 2023 15:51:55 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id i7-20020a056214030700b006215f334a18sm4275406qvu.28.2023.05.16.15.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:51:54 -0700 (PDT)
Date:   Tue, 16 May 2023 18:51:53 -0400
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
Message-ID: <ZGQJCaZiPDjYS8w4@x1n>
References: <20230515193232.67552-1-lstoakes@gmail.com>
 <ZGKjvceDfpKMxtfb@x1n>
 <bcfb0376-ccf4-4467-9da5-8ae6f1c86876@lucifer.local>
 <20abea10-5307-498b-b9df-8f0b2fed1701@lucifer.local>
 <ZGOcAOFOjx3XPGqO@x1n>
 <9739133c-3ee7-4e94-a6a8-783045a50ac6@lucifer.local>
 <ZGPn00ZqqQqdmk2e@x1n>
 <e90c2b38-805b-4df1-abdd-8ee460b12b72@lucifer.local>
 <ZGP4KSw/yD5ItTYu@x1n>
 <20230516223830.64ege7magdtx3zsr@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230516223830.64ege7magdtx3zsr@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 06:38:30PM -0400, Liam R. Howlett wrote:
> > It seems to me what you're trying to explain is we shouldn't handle any
> > split in vma_merge() so we should move cases 4 & 5 out of vma_merge().  If
> > we split first then merge, cases 4 & 5 will become case 2 & 3 after split.
> 
> We don't split in case 4 or 5 - we adjust the existing VMA limits.  We
> don't actually handle any splits in vma_merge().  I think splitting
> first would change 4 & 5 to 7 & 8?  2 & 3 would require a split and
> munmap, right?

Right, I referenced to the wrong numbers..  2 & 3 are when CUR (CCCC) is
empty and newly mapped in, if split happened it means CUR (CCCC) exists
which is 7 & 8 correspondingly.

> 
> > My question would be: if it worked perfect in the past few years and it
> > looks all good enough, why bother..
> 
> I suspect, but it's not clear (like all of this), that the other
> arguments to vma_merge() is ruling out this potential hazard I thought
> existed.

Some more elaborations on this one would be appreciated.

Thanks,

-- 
Peter Xu

