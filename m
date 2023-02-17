Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B1B69B02A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjBQQE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjBQQEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:04:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67816D271
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676649837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TLvN6DDQkswzF52JGa6ZTsut+NWI5tIiJO0waJH0how=;
        b=L0nZyYC1MVgAdtpudZdfFwJvCLC2cR9AgBtH0fuPGrdZAR251sffcDz5ECAVLP74xB2Swc
        RxE7DgudHKd/DiSywu/lkAnfpvPy2qQLmB+3qGf3D90yELl1SWbGKK3PkCQLeCm/uOPpKj
        owwLLa1aHEOMFcjC7+oQ5hgZEDsrCnE=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-Y6Cabm8TPbWG1HC3YeLmUA-1; Fri, 17 Feb 2023 11:03:55 -0500
X-MC-Unique: Y6Cabm8TPbWG1HC3YeLmUA-1
Received: by mail-io1-f71.google.com with SMTP id b4-20020a05660214c400b007297c4996c7so830367iow.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676649834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLvN6DDQkswzF52JGa6ZTsut+NWI5tIiJO0waJH0how=;
        b=2p72qgSgzQ/7d8+8mXLFZ+pgSC+sdQrMHhIkiRaYdSPHAxAQYrc8ecf1vDdVFQIRLj
         WcaaNnNuc/x267QQYI8N3s1Oz8rx/H4mAzMhsfekK8oD3OBTWS4ZFVZMx+G5TXjHRKmD
         LpuygQgb8t13R8994FBWyaWPYY3MYJNsi6c2KD0u60BX1L9v/qyW5FwnatQRjmp8Yuio
         IbErb32LvHowdAu3Bu+aEQxMDOPA6BKUj9lLseI+IHBHqShtNPeLNnPqpwc/nj4eXTJN
         JLnZQJLzZCsVvSeakAmo7H2vIBJRsGFrHZYBR1iwfebOKu2Ruc+TgLMxY97lzWBFTkvz
         L+rA==
X-Gm-Message-State: AO0yUKWYQqKNNPkzu6GFTOmq6I/sQ6qXXza5i5X7KxiGgjMc+AidnPgT
        eHjchWOZNAww1UMHKnSTZBGgi9S3avs0Nxog0+FvhFckC+DtOuS+xRtPJguVN/CfY8IstZI8gUg
        WUNQV6EKgMsjcguxuDfqh7CtLUMvtmg==
X-Received: by 2002:a05:6602:2e13:b0:73a:397b:e311 with SMTP id o19-20020a0566022e1300b0073a397be311mr1657435iow.0.1676649834653;
        Fri, 17 Feb 2023 08:03:54 -0800 (PST)
X-Google-Smtp-Source: AK7set9CnTXktT42br7BRBjPf109RfUQofqeloj7BAciwWnaQO2cG/npH6H4c5CAsKMgJMefcN68UA==
X-Received: by 2002:a05:6602:2e13:b0:73a:397b:e311 with SMTP id o19-20020a0566022e1300b0073a397be311mr1657426iow.0.1676649834361;
        Fri, 17 Feb 2023 08:03:54 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id t23-20020a02ccb7000000b003c51aab9d88sm574690jap.159.2023.02.17.08.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 08:03:53 -0800 (PST)
Date:   Fri, 17 Feb 2023 11:03:52 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Paul Gofman <pgofman@codeweavers.com>, david@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/userfaultfd: Support WP on multiple VMAs
Message-ID: <Y++laOl3OLw7zMPL@x1n>
References: <Y+prUgFQqmytC/5M@x1n>
 <9f0278d7-54f1-960e-ffdf-eeb2572ff6d1@collabora.com>
 <Y+qnb/Ix8P5J3Kl4@x1n>
 <0549bd0e-85c4-1547-3eaa-16c8a8883837@collabora.com>
 <Y+wCDUpuDcSDSQAK@x1n>
 <c9d3a306-0c5e-ad58-cffc-3c4c6b8b7433@collabora.com>
 <Y+1SdZqwS7LbcfaQ@x1n>
 <e35c7af0-d115-9808-61b5-cf8ab4356a35@collabora.com>
 <Y+5cu9QMCy32ONBo@x1n>
 <5f234d04-684e-9338-44b6-df23f7166578@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f234d04-684e-9338-44b6-df23f7166578@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 03:59:25PM +0500, Muhammad Usama Anjum wrote:
> > But what if the user wants to do that during when you're tracing it using
> > userfaultfd?  Can it happen?
> Sorry, I've not tested tracing.

No worry.  It's not a request to test tracing; it's more or less to make
sure it works for you if it cannot trace a program that uses uffd.  If it's
not a problem to you, then it's not a problem to me either. And it's not
anything special to async but in general to uffd.  Thanks,

-- 
Peter Xu

