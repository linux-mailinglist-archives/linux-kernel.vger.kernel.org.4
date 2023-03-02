Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5666A8ADE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCBUzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCBUzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:55:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC7C497EF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 12:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677790503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JFNwRi5/Kf0+dhWCteiH7bI3G3kdg4tmsNAULgUWudU=;
        b=KEKt0SadqCNhB1gxmcsVYEbvC6Jnw/WqEFCmSXsOmiCcXWhJOw4nr7yU7a1K9+OwyAMGj8
        VCfwPyF18LKhh2noL1UwNZdZzRoDzImChkQngfyyU7UICQnKH+xXz4Vll9B6eFTgZ7S7wN
        m5Zzn10fRY6SvIk1cOJwhUH9tfTaaXM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-G2gzVU9QMmCjMUFpDLZ3vw-1; Thu, 02 Mar 2023 15:55:01 -0500
X-MC-Unique: G2gzVU9QMmCjMUFpDLZ3vw-1
Received: by mail-qk1-f198.google.com with SMTP id 19-20020a370c13000000b007428253bb55so130272qkm.23
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 12:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677790501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFNwRi5/Kf0+dhWCteiH7bI3G3kdg4tmsNAULgUWudU=;
        b=lbZIIb5D7KQ2o3gIak27Q6ybsNMN2Xog1d+OJA7hJUNx9f3PtjsgzeEL1b0X0Yg+DG
         gM4y1RRCFYa6BFKxNYCrcGZO1G2bobPX3kqU7pfax8uhU8/vRQeacpG8u47kE4BkKbeS
         Y7gd1a7wnbWNs7TKSFWvZNmfliUo8Xxz+4rOcjlee9hfpj/gvxaKWVGDYdiJqPI6Nq56
         w1jQhKp2b2C1rtX93nPJHbVyoT57pLvAumUJWxCpKH4bQRQ5jHYKewgLukywxCJi1knX
         iPjfk9963lPahPOj1WkeQpXCNKFS1IDEUn7XCMoiRUiFFM21NpSV5kVWq1Pr+CJYdJPa
         W+xA==
X-Gm-Message-State: AO0yUKU+QWO+afWo12hO5y37MOZ6HcN7vgtO6u7wcIB6U0W5sTlejaaD
        vOpUfryfs8NRXfS/0E/X3amoAV6XkXDgqIDYrLg2Nb0BcHHWd3xF0Bh2bBfMi7NTU4f9oDbDUen
        s/2aZv01KE+cS0/MPgeznTJD5
X-Received: by 2002:ac8:580f:0:b0:3bf:daa8:cacc with SMTP id g15-20020ac8580f000000b003bfdaa8caccmr22508103qtg.3.1677790501162;
        Thu, 02 Mar 2023 12:55:01 -0800 (PST)
X-Google-Smtp-Source: AK7set/ubbtWdRYZkqIy9VA/XhPef6Jat19o3BO5H4dq+GIJeNCcLCDeIo3yS8UHjDDuwM0qJdYPkA==
X-Received: by 2002:ac8:580f:0:b0:3bf:daa8:cacc with SMTP id g15-20020ac8580f000000b003bfdaa8caccmr22508087qtg.3.1677790500922;
        Thu, 02 Mar 2023 12:55:00 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id z24-20020ac87cb8000000b003bfa8e1b7d1sm402654qtv.32.2023.03.02.12.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 12:55:00 -0800 (PST)
Date:   Thu, 2 Mar 2023 15:54:59 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/11] convert this_cpu_cmpxchg users to
 this_cpu_cmpxchg_local
Message-ID: <ZAENI/VwUm2Lwdc6@x1n>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.818774692@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230209153204.818774692@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 12:01:57PM -0300, Marcelo Tosatti wrote:
> this_cpu_cmpxchg was modified to atomic version, which 
> can be more costly than non-atomic version.
> 
> Switch users of this_cpu_cmpxchg to this_cpu_cmpxchg_local
> (which preserves pre-non-atomic this_cpu_cmpxchg behaviour).
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Yes afaict these are the only pieces that uses the helper besides vmstat
udpates.

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

