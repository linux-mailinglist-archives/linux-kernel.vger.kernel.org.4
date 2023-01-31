Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2C668312D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjAaPSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjAaPSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:18:01 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9445A59B4F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:16:14 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id e9so8536225vsj.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hqSkLxxkS4WxXckkEqwqJ2FoqZVZdDRCF2SZ/0LGP88=;
        b=JtZQ/lBmt1byjRUtXNuodezmFLI68Y4U1n9cV4QC89Jrp7zRN+opOXcshCLau26tiK
         Nd7XZH0XhmPh/ylPrymz6yitRCTAk77brQH6Y7T9Rwe3+PBn1kmbTPPEa5n39WSpbPC/
         3UVWX2vsjw2pYxx03h0V6D3FqfEWNxMiI4V+1HfBhQ7IPqlBbu3/6JtPVaSx9TOUQRxf
         2mhIwkexBZz2BsG43yqbCb10cc/be7/cOMguEs3i6vHqPgytYuZugK70wSwuExWwjz2Y
         zsQhqw+EG63ShEJ2r0cpRtXL/S2Fd3ulNRqK5Gi2R4vnSEqOzBBhRqgx2w0+r7or3E81
         nYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqSkLxxkS4WxXckkEqwqJ2FoqZVZdDRCF2SZ/0LGP88=;
        b=V9dQrKFCw4Z3dD3D0Sfa0SsVGe8FOtOPxqkwYlmr9/HyaOk7d2/201Exq8457HEWsB
         tllNUz6xw88V7QS77vnMVgKSYBOYcxujxtHqSM72DU+9+rA8121Z/FKzNAMev2XOkFdQ
         Luubr04/20QDRyMsEbqsjt3PCiCCoVH7n86oWjo+3P3uOEuaNhJBV9Gh89RoNrI1uGLW
         KfYEMwHg5EU3RIP9I+LhnYFZqrEt3c+SyssK00+XyUnrVk48EHTiJh9ANA/jEKB9AMaR
         R7eZ1KMTDoBdEHDSWPbIt1CguhqVMgZeUlHTO8OY1CQkHDhTYSqxwi3HBYRzkKTJIhm/
         ZcPA==
X-Gm-Message-State: AO0yUKWBUl0c7N8vsgMRBNQDEsn4cW5YCYtf+nnSGTlZxhj5ptQ6Fyf2
        /tXKIag0ceHZT9/CU4UiA8qUMt1RrzpOVKXj6eadbw==
X-Google-Smtp-Source: AK7set9TuI801MQUIobSqj1yTStH7qsNvDVpmcS4/LrfPrPNvx2T47lNeSF2Vu2NdDktr05dS0mA/2X+cH7Q7NH14kc=
X-Received: by 2002:a67:c31e:0:b0:3ed:1e92:a87f with SMTP id
 r30-20020a67c31e000000b003ed1e92a87fmr2427528vsj.1.1675178173210; Tue, 31 Jan
 2023 07:16:13 -0800 (PST)
MIME-Version: 1.0
References: <167467815773.463042.7022545814443036382.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167467815773.463042.7022545814443036382.stgit@dwillia2-xfh.jf.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 Jan 2023 16:15:36 +0100
Message-ID: <CAG_fn=U37EVEYYBTRWvOzVq7n0sSqaS5UN-9pjfZQnczAv3B4w@mail.gmail.com>
Subject: Re: [PATCH v2] nvdimm: Support sizeof(struct page) > MAX_STRUCT_PAGE_SIZE
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     nvdimm@lists.linux.dev, stable@vger.kernel.org,
        Marco Elver <elver@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 9:23 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Commit 6e9f05dc66f9 ("libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE")
>
> ...updated MAX_STRUCT_PAGE_SIZE to account for sizeof(struct page)
> potentially doubling in the case of CONFIG_KMSAN=y. Unfortunately this
> doubles the amount of capacity stolen from user addressable capacity for
> everyone, regardless of whether they are using the debug option. Revert
> that change, mandate that MAX_STRUCT_PAGE_SIZE never exceed 64, but
> allow for debug scenarios to proceed with creating debug sized page maps
> with a compile option to support debug scenarios.
>
> Note that this only applies to cases where the page map is permanent,
> i.e. stored in a reservation of the pmem itself ("--map=dev" in "ndctl
> create-namespace" terms). For the "--map=mem" case, since the allocation
> is ephemeral for the lifespan of the namespace, there are no explicit
> restriction. However, the implicit restriction, of having enough
> available "System RAM" to store the page map for the typically large
> pmem, still applies.
>
> Fixes: 6e9f05dc66f9 ("libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE")
> Cc: <stable@vger.kernel.org>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Reported-by: Jeff Moyer <jmoyer@redhat.com>
Acked-by: Alexander Potapenko <glider@google.com>
