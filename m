Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F96D6A8BE2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCBWdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCBWdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:33:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5622A4ED2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677796374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wEn2MpA7p6zktO3lvlB6/EyreWsKvVgm3mI9NlrG6Hs=;
        b=SzGpRJb6sXpCwAiPsePaAjuZx8sLe9E7k31QgjJkE43WHW/XQBsKdPXLszDBcs4E/7/e/l
        hlkN/ordhJ6kt45KIABzbdomrnov2oz72/KvXtoBaV6FBkXjC0DeTJ27QgEXbJ590g7QvH
        ecb6tAe/iQMO34pacyLFm4u/tszPPzw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-aarqT5JOPay3s9J_Sula-A-1; Thu, 02 Mar 2023 17:32:51 -0500
X-MC-Unique: aarqT5JOPay3s9J_Sula-A-1
Received: by mail-qk1-f200.google.com with SMTP id e14-20020a05620a208e00b0074270b9960dso269495qka.22
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 14:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677796370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEn2MpA7p6zktO3lvlB6/EyreWsKvVgm3mI9NlrG6Hs=;
        b=b1W/shlg+6wTlyJneEwawGKnUi/Cs3PylQZaLEvlC0L7jEh+uUKwqMMQxKDkMtyQ4T
         2tK4bMc9kAdjhvBj+tqVEP6JIo51THpSV8lxWgsWJXBYCR809krdMZYO/KXV4J9S1u4L
         z7Ipbl7xXJx9RrnSdB3+vK2OJ4y43TklK92V/hl6lLaIy0H6Uu6zSklgf+yjrTD7aKs/
         vJMoUVh0e3QJfQreDRw2CwO4QfImt3R4bttqsxJpkL5sxbGmtBWTurgg1EoCmok8J1dO
         8PHJ04kVIpYS+cYtRU35FQcnlBrqwGweFK2R0xkC1KIANd0lV1Zt1ksw4ZC4YzkyNlaH
         tX+Q==
X-Gm-Message-State: AO0yUKV5gw+XJXNjhMkrSGbpj0iR9Ce0ZeOcOQaVybEWpsksI9C3wwaA
        O59Vrapv0wWBaN99y9wJI4EcNQLLflcTJuwPQgd6vB9GDRA78Z4Ey6asm3DXeZpdauw3qjdNovE
        VQ+7CyQueNWecbyrKxz/HDC8L
X-Received: by 2002:a05:622a:34d:b0:3bf:d71e:5b08 with SMTP id r13-20020a05622a034d00b003bfd71e5b08mr22871080qtw.3.1677796370800;
        Thu, 02 Mar 2023 14:32:50 -0800 (PST)
X-Google-Smtp-Source: AK7set+TPwvYbDcJf1DhJuI5EDnyoIv2/ltKJZAapCZu0h7yWl5Ber6Ev+UUzrhTJaqq0QNzi05a5Q==
X-Received: by 2002:a05:622a:34d:b0:3bf:d71e:5b08 with SMTP id r13-20020a05622a034d00b003bfd71e5b08mr22871057qtw.3.1677796370558;
        Thu, 02 Mar 2023 14:32:50 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id 29-20020a05620a049d00b00741a984943fsm538443qkr.40.2023.03.02.14.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:32:50 -0800 (PST)
Date:   Thu, 2 Mar 2023 17:32:48 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anish Moorthy <amoorthy@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: teach mincore_hugetlb about pte markers
Message-ID: <ZAEkEDcoIZRrAIwX@x1n>
References: <20230302222404.175303-1-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230302222404.175303-1-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 10:24:04PM +0000, James Houghton wrote:
> By checking huge_pte_none(), we incorrectly classify PTE markers as
> "present". Instead, check huge_pte_none_mostly(), classifying PTE
> markers the same as if the PTE were completely blank.
> 
> PTE markers, unlike other kinds of swap entries, don't reference any
> physical page and don't indicate that a physical page was mapped
> previously. As such, treat them as non-present for the sake of
> mincore().
> 
> Fixes: 5c041f5d1f23 ("mm: teach core mm about pte markers")
> Signed-off-by: James Houghton <jthoughton@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

Thanks, James.

-- 
Peter Xu

